#!/bin/bash
# Uso: ./portScan.sh <ip_address>

if [ "$1" ]; then
    ip_address="$1"
    max_jobs=100

    for port in $(seq 1 65535); do
        # Lanza el escaneo en segundo plano
        timeout 1 bash -c "echo '' > /dev/tcp/$ip_address/$port" 2>/dev/null && echo "[ * ] Puerto $port - ABIERTO" &

        # Espera si hay demasiados procesos corriendo
        while (( $(jobs -r | wc -l) >= max_jobs )); do
            sleep 0.1
        done
    done
    wait
else
    echo -e "\n[ * ] Uso: ./portScan.sh <ip_address>\n"
fi

