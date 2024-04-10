#!/bin/bash

# 随机US节点
cities=("atl" "bos" "den" "dfw" "ewr" "iad" "mia" "ord")
index=$(($RANDOM % ${#cities[@]}))
selected_city=${cities[$index]}

# 输出toml部署文件
cat > fly.toml << EOF
# fly.toml app configuration file generated for hgjhghg-damp-pond-5796 on 2024-01-17T04:03:15-08:00
#
# See https://fly.io/docs/reference/configuration/ for information about how to use this file.
#

app = "${FLY_APP_NAME}"
primary_region = "ewr"

[build]
  image = "louislam/uptime-kuma:1"

[[mounts]]
  source = "kuma_data"
  destination = "/app/data"
  auto_extend_size_threshold = 0

[http_service]
  internal_port = 3001
  force_https = true
  auto_stop_machines = false
  auto_start_machines = true
  min_machines_running = 1
  processes = ["app"]

[[vm]]
  cpu_kind = "shared"
  cpus = 1
  memory_mb = 256
EOF
