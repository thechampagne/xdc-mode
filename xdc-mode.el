;;; xdc-mode.el --- Minor mode for Xilinx Design Constraint (XDC) files -*- lexical-binding -*-

;; This is free and unencumbered software released into the public domain.

;; Author: Jake Grossman <jakergrossman@gmail.com>
;; Version: 1.0.0
;; Created: 29 Apr 2023
;; Keywords: XDC, constraint, FPGA
;; Homepage: https://github.com/jakergrossman/xdc-mode

;;; Commentary:

;; Simple syntax highlighting for Xilnix Design Constraint (XDC) files.
;;
;; TCL commands and flags lifted from:
;; https://docs.xilinx.com/r/2021.1-English/ug835-vivado-tcl-commands/Tcl-Commands-Listed-Alphabetically
;; (Vivado version 2022.2, 2022-10-19)
;;
;; Key properties lifted from:
;; https://docs.xilinx.com/r/en-US/ug912-vivado-properties/Key-Property-Descriptions
;; (Vivado version 2022.2, 2022-11-02)

;;; Code:

(defvar xdc-tcl-commands
  '("add_bp" "add_cells_to_pblock" "add_condition" "add_drc_checks" "add_files"
    "add_force" "add_hw_hbm_pc" "add_hw_probe_enum" "add_peripheral_interface"
    "add_to_power_rail" "add_wave" "add_wave_divider" "add_wave_group"
    "add_wave_marker" "add_wave_virtual_bus" "all_clocks" "all_cpus" "all_dsps"
    "all_fanin" "all_fanout" "all_ffs" "all_hsios" "all_inputs" "all_latches"
    "all_outputs" "all_rams" "all_registers" "apply_bd_automation"
    "apply_board_connection" "apply_hw_ila_trigger" "archive_project"
    "assign_bd_address" "auto_detect_xpm" "boot_hw_device" "calc_config_time"
    "can_resolve_reference" "check_syntax" "check_timing" "checkpoint_vcd"
    "close_bd_design" "close_design" "close_hw_manager" "close_hw_target"
    "close_project" "close_saif" "close_sim" "close_vcd" "close_wave_config"
    "commit_hw_hbm" "commit_hw_mig" "commit_hw_sio" "commit_hw_sysmon"
    "commit_hw_vio" "compile_c" "compile_simlib" "config_compile_simlib"
    "config_design_analysis" "config_hw_sio_gts" "config_implementation"
    "config_ip_cache" "config_timing_analysis" "config_timing_corners"
    "connect_bd_intf_net" "connect_bd_net" "connect_debug_cores"
    "connect_debug_port" "connect_hw_server" "connect_net" "convert_ips"
    "convert_ngc" "copy_bd_objs" "copy_constraints" "copy_ip" "copy_run"
    "create_bd_addr_seg" "create_bd_cell" "create_bd_design" "create_bd_intf_net"
    "create_bd_intf_pin" "create_bd_intf_port" "create_bd_intf_tlm_port"
    "create_bd_net" "create_bd_pin" "create_bd_port" "create_bd_tlm_port"
    "create_cell" "create_clock" "create_cluster_configuration"
    "create_dashboard_gadget" "create_debug_core" "create_debug_port"
    "create_drc_check" "create_drc_ruledeck" "create_drc_violation"
    "create_fileset" "create_generated_clock" "create_gui_custom_command"
    "create_gui_custom_command_arg" "create_hw_axi_txn" "create_hw_bitstream"
    "create_hw_cfgmem" "create_hw_device" "create_hw_probe" "create_hw_sio_link"
    "create_hw_sio_linkgroup" "create_hw_sio_scan" "create_hw_sio_sweep"
    "create_hw_target" "create_interface" "create_ip" "create_ip_run"
    "create_macro" "create_net" "create_partition_def" "create_pblock"
    "create_peripheral" "create_pin" "create_port"
    "create_port_on_reconfigurable_module" "create_power_rail"
    "create_pr_configuration" "create_project" "create_property"
    "create_reconfig_module" "create_report_config" "create_rqs_runs" "create_run"
    "create_single_pass_run" "create_slack_histogram" "create_testbench"
    "create_waiver" "create_wave_config" "create_xps" "current_bd_design"
    "current_bd_instance" "current_board" "current_board_part" "current_design"
    "current_fileset" "current_frame" "current_hw_cfgmem" "current_hw_device"
    "current_hw_ila" "current_hw_ila_data" "current_hw_server" "current_hw_target"
    "current_instance" "current_pr_configuration" "cuprrent_project" "current_run"
    "current_scope" "current_sim" "current_time" "current_vcd"
    "current_vivado_preferences" "current_wave_config" "decrypt_bitstream"
    "delete_bd_objs" "delete_clock_networks_results" "delete_dashboard_gadgets"
    "delete_debug_core" "delete_debug_port" "delete_drc_check"
    "delete_drc_ruledeck" "delete_fileset" "delete_hw_axi_txn"
    "delete_hw_bitstream" "delete_hw_cfgmem" "delete_hw_probe" "delete_hw_target"
    "delete_interface" "delete_ip_run" "delete_macros" "delete_partition_defs"
    "delete_pblocks" "delete_power_rails" "delete_power_results"
    "delete_pr_configurations" "delete_qor_suggestions" "delete_reconfig_modules"
    "delete_report_configs" "delete_rpm" "delete_runs" "delete_timing_results"
    "delete_utilization_results" "delete_waivers" "describe" "detect_hw_sio_links"
    "disconnect_bd_intf_net" "disconnect_bd_net" "disconnect_debug_port"
    "disconnect_hw_server" "disconnect_net" "display_hw_ila_data"
    "display_hw_sio_scan" "encrypt" "endgroup" "exclude_bd_addr_seg"
    "execute_hw_svf" "export_as_example_design" "export_bd_synth"
    "export_ip_user_files" "export_simulation" "export_xsim_coverage"
    "extract_files" "filter" "find_bd_objs" "find_routing_path" "find_top"
    "flush_vcd" "generate_base_platform" "generate_hier_access" "generate_hwh"
    "generate_mem_files" "generate_ml_strategies" "generate_pblock"
    "generate_peripheral" "generate_reports" "generate_rl_platform"
    "generate_shx_platform" "generate_switch_network_for_noc" "generate_target"
    "generate_vcd_ports" "get_bd_addr_segs" "get_bd_addr_spaces" "get_bd_cells"
    "get_bd_designs" "get_bd_intf_nets" "get_bd_intf_pins" "get_bd_intf_ports"
    "get_bd_nets" "get_bd_pins" "get_bd_ports" "get_bd_regs" "get_bel_pins"
    "get_bels" "get_board_bus_nets" "get_board_buses"
    "get_board_component_interfaces" "get_board_component_modes"
    "get_board_component_pins" "get_board_components" "get_board_interface_ports"
    "get_board_ip_preferences" "get_board_jumpers" "get_board_parameters"
    "get_board_part_interfaces" "get_board_part_pins" "get_board_parts"
    "get_boards" "get_cdc_violations" "get_cells" "get_cfgmem_parts"
    "get_clock_regions" "get_clocks" "get_cluster_configurations"
    "get_constant_paths" "get_dashboard_gadgets" "get_debug_cores"
    "get_debug_ports" "get_designs" "get_drc_checks" "get_drc_ruledecks"
    "get_drc_violations" "get_example_designs" "get_files" "get_filesets"
    "get_gcc_versions" "get_generated_clocks" "get_gui_custom_command_args"
    "get_gui_custom_commands" "get_hierarchy_separator" "get_highlighted_objects"
    "get_hw_axi_txns" "get_hw_axis" "get_hw_cfgmems" "get_hw_ddrmcs"
    "get_hw_devices" "get_hw_hbmmcs" "get_hw_hbms" "get_hw_ila_datas" "get_hw_ilas"
    "get_hw_migs" "get_hw_pcies" "get_hw_probes" "get_hw_servers"
    "get_hw_sio_commons" "get_hw_sio_gtgroups" "get_hw_sio_gts" "get_hw_sio_iberts"
    "get_hw_sio_linkgroups" "get_hw_sio_links" "get_hw_sio_plls" "get_hw_sio_rxs"
    "get_hw_sio_scans" "get_hw_sio_sweeps" "get_hw_sio_txs" "get_hw_softmcs"
    "get_hw_sysmon_reg" "get_hw_sysmons" "get_hw_targets" "get_hw_vios"
    "get_interfaces" "get_io_standards" "get_iobanks" "get_ip_upgrade_results"
    "get_ipdefs" "get_ips" "get_lib_cells" "get_lib_pins" "get_libs" "get_macros"
    "get_marked_objects" "get_methodology_checks" "get_methodology_violations"
    "get_msg_config" "get_net_delays" "get_nets" "get_nodes" "get_objects"
    "get_package_pins" "get_param" "get_partition_defs" "get_parts"
    "get_path_groups" "get_pblocks" "get_pins" "get_pips" "get_pkgpin_bytegroups"
    "get_pkgpin_nibbles" "get_ports" "get_power_rails" "get_pplocs"
    "get_pr_configurations" "get_primitives" "get_projects" "get_property"
    "get_qor_checks" "get_qor_suggestions" "get_reconfig_modules"
    "get_report_configs" "get_runs" "get_scopes" "get_selected_objects"
    "get_sim_versions" "get_simulators" "get_site_pins" "get_site_pips" "get_sites"
    "get_slrs" "get_speed_models" "get_stacks" "get_template_bd_designs"
    "get_tiles" "get_timing_arcs" "get_timing_paths" "get_value" "get_waivers"
    "get_wave_configs" "get_waves" "get_wires" "group_bd_cells" "group_path" "help"
    "highlight_objects" "implement_debug_core" "implement_mig_cores"
    "implement_xphy_cores" "import_files" "import_ip" "import_synplify"
    "include_bd_addr_seg" "infer_diff_pairs" "instantiate_example_design"
    "instantiate_template_bd_design" "iphys_opt_design" "launch_chipscope_analyzer"
    "launch_impact" "launch_runs" "launch_simulation" "limit_vcd" "link_design"
    "list_features" "list_hw_samples" "list_param" "list_property"
    "list_property_value" "list_targets" "load_features" "lock_design" "log_saif"
    "log_vcd" "log_wave" "ltrace" "make_bd_intf_pins_external"
    "make_bd_pins_external" "make_diff_pair_ports" "make_wrapper" "mark_objects"
    "modify_debug_ports" "move_bd_cells" "move_dashboard_gadget" "move_files"
    "move_wave" "open_bd_design" "open_checkpoint" "open_example_project"
    "open_hw_manager" "open_hw_platform" "open_hw_target" "open_io_design"
    "open_project" "open_report" "open_run" "open_saif" "open_vcd"
    "open_wave_config" "open_wave_database" "opt_design" "pause_hw_hbm_amon"
    "phys_opt_design" "place_cell" "place_design" "place_ports" "platform_verify"
    "power_opt_design" "pr_recombine" "pr_subdivide" "pr_verify"
    "program_hw_cfgmem" "program_hw_devices" "ptrace" "read_bd" "read_checkpoint"
    "read_csv" "read_edif" "read_hw_ila_data" "read_hw_sio_scan"
    "read_hw_sio_sweep" "read_ip" "read_iphys_opt_tcl" "read_mem"
    "read_qor_suggestions" "read_saif" "read_schematic" "read_twx" "read_verilog"
    "read_vhdl" "read_xdc" "readback_hw_cfgmem" "readback_hw_device" "redo"
    "refresh_design" "refresh_hw_axi" "refresh_hw_ddrmc" "refresh_hw_device"
    "refresh_hw_hbm" "refresh_hw_hbmmc" "refresh_hw_mig" "refresh_hw_pcie"
    "refresh_hw_server" "refresh_hw_sio" "refresh_hw_softmc" "refresh_hw_sysmon"
    "refresh_hw_target" "refresh_hw_vio" "refresh_meminit" "regenerate_bd_layout"
    "register_proc" "reimport_files" "relaunch_sim" "remove_bps" "remove_cell"
    "remove_cells_from_pblock" "remove_cluster_configurations" "remove_conditions"
    "remove_drc_checks" "remove_files" "remove_forces" "remove_from_power_rail"
    "remove_gui_custom_command_args" "remove_gui_custom_commands"
    "remove_hw_hbm_pc" "remove_hw_probe_enum" "remove_hw_sio_link"
    "remove_hw_sio_linkgroup" "remove_hw_sio_scan" "remove_hw_sio_sweep"
    "remove_net" "remove_pin" "remove_port" "remove_wave" "rename_cell"
    "rename_net" "rename_pin" "rename_port" "rename_ref" "reorder_files"
    "replace_bd_cell" "report_bd_diffs" "report_bps" "report_bus_skew"
    "report_carry_chains" "report_cdc" "report_clock_interaction"
    "report_clock_networks" "report_clock_utilization" "report_clocks"
    "report_compile_order" "report_conditions" "report_config_implementation"
    "report_config_timing" "report_constant_paths" "report_control_sets"
    "report_datasheet" "report_debug_core" "report_design_analysis"
    "report_disable_timing" "report_drc" "report_drivers" "report_environment"
    "report_exceptions" "report_frames" "report_high_fanout_nets"
    "report_hw_axi_txn" "report_hw_ddrmc" "report_hw_mig" "report_hw_pcie"
    "report_hw_softmc" "report_hw_targets" "report_incremental_reuse" "report_io"
    "report_ip_status" "report_methodology" "report_objects"
    "report_operating_conditions" "report_param" "report_phys_opt" "report_power"
    "report_power_opt" "report_pr_configuration_analysis" "report_property"
    "report_pulse_width" "report_qor_assessment" "report_qor_suggestions"
    "report_ram_utilization" "report_route_status" "report_scopes"
    "report_sim_device" "report_sim_version" "report_simlib_info" "report_ssn"
    "report_stacks" "report_switching_activity" "report_synchronizer_mtbf"
    "report_timing" "report_timing_summary" "report_transformed_primitives"
    "report_utilization" "report_values" "report_waivers" "reset_drc"
    "reset_drc_check" "reset_hw_axi" "reset_hw_ila" "reset_hw_pcie"
    "reset_hw_vio_activity" "reset_hw_vio_outputs" "reset_methodology"
    "reset_methodology_check" "reset_msg_config" "reset_msg_count"
    "reset_operating_conditions" "reset_param" "reset_project" "reset_property"
    "reset_runs" "reset_simulation" "reset_ssn" "reset_switching_activity"
    "reset_target" "reset_timing" "resize_net_bus" "resize_pblock" "resize_pin_bus"
    "resize_port_bus" "restart" "resume_hw_hbm_amon" "route_design" "run"
    "run_hw_axi" "run_hw_hbm_amon" "run_hw_ila" "run_hw_sio_scan"
    "run_hw_sio_sweep" "run_state_hw_jtag" "runtest_hw_jtag" "save_bd_design"
    "save_bd_design_as" "save_constraints" "save_constraints_as" "save_project_as"
    "save_wave_config" "scan_dr_hw_jtag" "scan_ir_hw_jtag" "select_objects"
    "select_wave_objects" "set_bus_skew" "set_case_analysis" "set_clock_groups"
    "set_clock_latency" "set_clock_sense" "set_clock_uncertainty" "set_data_check"
    "set_delay_model" "set_disable_timing" "set_external_delay" "set_false_path"
    "set_hierarchy_separator" "set_hw_sysmon_reg" "set_input_delay"
    "set_input_jitter" "set_load" "set_logic_dc" "set_logic_one"
    "set_logic_unconnected" "set_logic_zero" "set_max_delay" "set_max_time_borrow"
    "set_min_delay" "set_msg_config" "set_multicycle_path"
    "set_operating_conditions" "set_output_delay" "set_package_pin_val" "set_param"
    "set_part" "set_power_opt" "set_propagated_clock" "set_property"
    "set_speed_grade" "set_switching_activity" "set_system_jitter" "set_units"
    "set_value" "setup_pr_configurations" "show_objects" "show_schematic"
    "split_diff_pair_ports" "start_gui" "start_vcd" "startgroup" "step" "stop"
    "stop_gui" "stop_hw_hbm_amon" "stop_hw_sio_scan" "stop_hw_sio_sweep" "stop_vcd"
    "swap_locs" "synth_design" "synth_ip" "tandem_verify" "terminate_runs"
    "tie_unused_pins" "undo" "ungroup_bd_cells" "unhighlight_objects"
    "unmark_objects" "unplace_cell" "unregister_proc" "unselect_objects"
    "update_bd_boundaries" "update_calibration_scheme" "update_clock_routing"
    "update_compile_order" "update_design" "update_files" "update_hw_firmware"
    "update_hw_gpio" "update_ip_catalog" "update_macro" "update_module_reference"
    "update_noc_qos" "update_sw_parameters" "update_timing" "upgrade_bd_cells"
    "upgrade_ip" "upgrade_project" "upload_hw_ila_data" "validate_bd_design"
    "validate_board_files" "validate_cluster_configurations" "validate_hw_platform"
    "validate_ip" "verify_hw_devices" "version" "wait_on_hw_ila"
    "wait_on_hw_sio_scan" "wait_on_hw_sio_sweep" "wait_on_runs"
    "write_abstract_shell" "write_bd_layout" "write_bd_tcl" "write_bitstream"
    "write_bmm" "write_bsdl" "write_cfgmem" "write_checkpoint" "write_csv"
    "write_debug_probes" "write_device_image" "write_edif" "write_hw_ila_data"
    "write_hw_platform" "write_hw_platform_metadata" "write_hw_sio_scan"
    "write_hw_sio_sweep" "write_hw_svf" "write_ibis" "write_inferred_xdc"
    "write_ip_tcl" "write_iphys_opt_tcl" "write_mem_info" "write_peripheral"
    "write_project_tcl" "write_qor_suggestions" "write_schematic" "write_sdf"
    "write_verilog" "write_vhdl" "write_waivers" "write_xdc" "write_xsim_coverage"
    "xsim")
  "List of TCL commands that are valid in *.xdc files.")

(defvar xdc-tcl-flags
  '("absolute_grid" "absolute_path" "absolute_remote_path" "add" "add_delay"
    "add_interface" "add_ip" "airflow" "all" "all_async_reg" "allmodels"
    "all_properties" "altitude" "ambient_temp" "append" "arch_only" "assert"
    "async_clocks" "asynchronous" "bd_folder" "bd_name" "binary" "bin_file"
    "black_box" "board" "board_layers" "board_temp" "boundary_of" "bsd"
    "buffer_ports" "bufg" "capacitance" "cascade_dsp" "cell" "cell" "cells"
    "cell_types" "check_ips" "check_only" "checksum" "clock" "clock_fall"
    "clock_groups" "clocks" "color" "color_index" "component_name" "config_path"
    "constrset" "control_efuse" "control_set_opt_threshold" "create_index"
    "csv_file" "current" "dataflow" "datapath_only" "deassert_resets" "debug_log"
    "default_static_probability" "default_toggle_rate" "delete_ip" "delete_mult_ip"
    "design" "design_power_budget" "dfx_mode" "dict" "directive" "disablebitswap"
    "disable_dont_touch" "disable_ip" "doctype_inject" "dump_project_info" "early"
    "enable_ip" "encrypt" "end" "exceptions" "excl_clocks" "exclude_cells"
    "exclude_layout" "exclude_pfm" "exclude_run_results" "exit_condition" "fall"
    "fall_from" "fall_through" "fall_to" "file" "file_path" "fileset" "filesets"
    "filter_cell" "fixed" "flash" "flatten_hierarchy" "force" "force_detect_xpm"
    "force_gui" "format" "format" "from" "from" "from_bd" "from_cell" "from_design"
    "from_file" "from_files" "fsm_extraction" "full" "gated_clock_conversion"
    "generic" "grade" "group" "gzip" "heatsink" "hier" "hierarchy" "hier_blks"
    "hold" "hw" "hw_emu" "ibs" "id" "ignore_minor_versions" "include_bit"
    "include_cells" "include_dirs" "include_layout" "include_local_ip_cache"
    "include_pfm" "include_sim_content" "include_xilinx_libs" "incremental_mode"
    "interconnect" "interface" "internal" "io_constraints" "ip_name"
    "junction_temp" "keep_equivalent_registers" "keep_paths_as_is" "keep_vcc_gnd"
    "key" "late" "latest" "leaf_cells" "legacy_csv_file" "lib" "limit" "lint"
    "list" "loadbit" "loaddata" "log" "logically_exclusive"
    "logic_function_stripped" "logic_location_file" "make_local" "mask" "mask_file"
    "max" "max_bram" "max_bram_cascade_height" "max_dsp" "max_uram"
    "max_uram_cascade_height" "merge_existing_constraints"
    "migrate_output_products" "min" "minimal" "mode" "multiple_files" "multithread"
    "name" "negative" "net" "network_latency_included" "new_severity"
    "no_binary_bitfile" "no_copy_sources" "no_ip_version" "no_lc" "no_mig_contents"
    "no_partial_bitfile" "no_partial_ltxfile" "no_partial_mmi" "no_partial_pdifile"
    "no_pdi" "nopin" "no_pin_mapping" "no_project_wrapper" "norecurse"
    "no_retiming" "no_srlextract" "no_timing_driven" "object" "objects"
    "of_objects" "orientation" "origin_dir_override" "part" "partitions"
    "paths_relative_to" "pblocks" "physically_exclusive" "pin" "pin_pairs" "pkg"
    "place" "port_diff_buffers" "ports" "positive" "power" "prefix" "process"
    "process_corner" "quiet" "radix" "raw_bitfile" "raw_partitions" "readback_file"
    "rebuild" "reference_bitfile" "reference_dcp" "reference_pin" "regenerate"
    "regexp" "remove" "rename_top" "repo_path" "report_only" "reset" "reset_path"
    "resistance" "resource_sharing" "retiming" "return_string" "rgb" "rise"
    "rise_from" "rise_through" "rise_to" "rm" "rp" "rtl" "rtl_skip_constraints"
    "rtl_skip_ip" "rtl_skip_mlo" "run" "save_ip" "scan_for_includes" "scope"
    "sdf_anno" "sdf_file" "security_efuse" "security_mode" "setup" "severity"
    "sfcu" "short" "show_defaults" "shreg_min_size" "signal_rate" "size"
    "skip_update" "smask" "source" "source_latency_included" "srcset" "srl_style"
    "start" "static" "static_probability" "steps" "stop_propagation" "strategy_dir"
    "strict" "string" "supply_current_budget" "suppress" "target_proj_dir"
    "tcl_output_dir" "tdi" "tdo" "temperature" "thetaja" "thetajb" "thetasa"
    "through" "timeout" "to" "to" "to_files" "toggle_rate" "top" "truncate" "try"
    "type" "untrusted_dcp" "updated_pfm_attrs" "update_module_ref" "use_bd_files"
    "use_netlist" "user_efuse" "validate" "vcd_file" "verbose" "verilog_define"
    "vlnv" "voltage" "write_all_overrides")
  "List of flags that are valid as options to TCL commands in *.xdc files.")

(defvar xdc-key-properties
  '("ASYNC_REG" "AUTO_INCREMENTAL_CHECKPOINT" "AUTOPIPELINE_GROUP" "AUTOPIPELINE_MODULE" "AUTOPIPELINE_INCLUDE"
    "AUTOPIPELINE_LIMIT" "BEL" "BLACK_BOX" "BLI" "BLOCK_SYNTH" "BUFFER_TYPE" "CARRY_REMAP" "CASCADE_HEIGHT"
    "CELL_BLOAT_FACTOR" "CFGBVS" "CLOCK_BUFFER_TYPE" "CLOCK_DEDICATED_ROUTE" "CLOCK_DELAY_GROUP"
    "CLOCK_LOW_FANOUT" "CLOCK_REGION" "CLOCK_ROOT" "CONFIG_MODE" "CONFIG_VOLTAGE"
    "CONTAIN_ROUTING" "CONTROL_SET_REMAP" "DCI_CASCADE" "DELAY_BYPASS" "DELAY_VALUE_XPHY"
    "DIFF_TERM" "DIFF_TERM_ADV" "DIRECT_ENABLE" "DIRECT_RESET" "DONT_TOUCH"
    "DQS_BIAS" "DRIVE" "EDIF_EXTRA_SEARCH_PATHS" "EQUALIZATION" "EQUIVALENT_DRIVER_OPT"
    "EXCLUDE_PLACEMENT" "EXTRACT_ENABLE" "EXTRACT_RESET" "FORCE_MAX_FANOUT" "FSM_ENCODING"
    "FSM_SAFE_STATE" "GATED_CLOCK" "GENERATE_SYNTH_CHECKPOINT" "H_SET" "HU_SET"
    "HIODELAY_GROUP" "HLUTNM" "IBUF_LOW_PWR" "IN_TERM" "INCREMENTAL_CHECKPOINT"
    "INTERNAL_VREF" "IO_BUFFER_TYPE" "IOB" "IOB_TRI_REG" "IOBDELAY"
    "IODELAY_GROUP" "IOSTANDARD" "IP_REPO_PATHS" "IS_ENABLED" "IS_SOFT"
    "KEEP" "KEEP_COMPATIBLE" "KEEP_HIERARCHY" "KEEPER" "LOC"
    "LOCK_PINS" "LOCK_UPGRADE" "LUTNM" "LUT_REMAP" "LVDS_PRE_EMPHASIS"
    "MARK_DEBUG" "MAX_FANOUT" "MAX_FANOUT_MODE" "MAX_NAMES" "MBUFG_GROUP"
    "MIG_FLOORPLAN_MODE" "MUXF_REMAP" "ODT" "OPT_MODIFIED" "OPT_SKIPPED"
    "OFFSET_CNTRL" "PACKAGE_PIN" "PATH_MODE" "PBLOCK" "PHYS_OPT_MODIFIED" "PHYS_OPT_SKIPPED"
    "POST_CRC" "POST_CRC_ACTION" "POST_CRC_FREQ" "POST_CRC_INIT_FLAG" "POST_CRC_SOURCE"
    "PRE_EMPHASIS" "PROCESSING_ORDER" "PROHIBIT" "PULLDOWN" "PULLTYPE"
    "PULLUP" "RAM_DECOMP" "RAM_STYLE" "RAM_AVERAGE_ACTIVITY" "REF_NAME"
    "REF_PIN_NAME" "REG_TO_SRL" "RLOC" "RLOCS" "RLOC_ORIGIN"
    "ROUTE_STATUS" "RPM" "RPM_GRID" "SEVERITY"
    "SLEW" "SRL_TO_REG" "SRL_STAGES_TO_REG_INPUT" "SRL_STAGES_TO_REG_OUTPUT"
    "SYNTH_CHECKPOINT_MODE" "U_SET" "UNAVAILABLE_DURING_CALIBRATION" "USE_DSP"
    "USED_IN" "USER_CLOCK_ROOT" "USER_CROSSING_SLR" "USER_RAM_AVERAGE_ACTIVITY"
    "USER_SLL_REG" "USER_SLR_ASSIGNMENT" "VCCAUX_IO" "USER_CLUSTER")
  "List of key properties valid as arguments to `set_property`.")

(defun xdc--convert-to-font-lock-defaults (face prefix words)
  "Build a simple alternation regex fo WORDS with optional PREFIX.
Associates each with font-lock face FACE."
  (let ((regex (concat prefix "\\<\\(" (string-join words "\\|") "\\)\\>")))
    (cons regex face)))

(defvar xdc-font-lock
  (cons '("#.*$" . font-lock-comment-face)
        (mapcar (apply-partially #'apply #'xdc--convert-to-font-lock-defaults)
                (list
                 (list 'font-lock-keyword-face nil xdc-tcl-commands)
                 (list 'font-lock-constant-face nil xdc-key-properties)
                 (list 'font-lock-variable-name-face "-" xdc-tcl-flags)))))

(define-minor-mode xdc-mode "Syntax highlighting for Xilinx Constraint Files."
  :lighter " XDC"
  (if xdc-mode
      (font-lock-add-keywords nil xdc-font-lock)
    (font-lock-remove-keywords nil xdc-font-lock))

  ;; As of Emacs 24.4, `font-lock-fontify-buffer` is not legal
  ;; to call, instead `font-lock-flush` should be used.
  (if (fboundp 'font-lock-flush)
      (font-lock-flush)
    (when font-lock-mode
      (with-no-warnings (font-lock-fontify-buffer)))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.xdc\\'" . xdc-mode))

(provide 'xdc-mode)
;;; xdc-mode.el ends here