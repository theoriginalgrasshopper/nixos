# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# theoriginalgrasshopper's presonal nixos configuration.nix file. awesome, bash. 'home' is the hostname, 'nixhop' is the username. If you find any problems, refer to the issues tab on GitHub------------------- 

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "home"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
 
  # BLUETOOTH


  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # STUPID ELECTRON SMH

  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
  
  # SWAP
  
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 4*1024;
  } ];

  # DEV

  programs.direnv.enable = true;

  # GVFS AND THUNAR

  services.gvfs.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
  ];
  # SOUND --------------!

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  # VDAGENT
  systemd.user.services.spice-agent = { 
    enable = true;
  };
  # OPENTABLET
  hardware.opentabletdriver.daemon.enable = true;
  hardware.opentabletdriver.enable = true;
  # NVIDIA BULLSHIT ---------------!
  
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  hardware.nvidia.nvidiaPersistenced = true;
 
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # HYPRLAND ----------------!

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };    
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk];

  # I3    ----------------!
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  programs.dconf.enable = true;

  # ENABLE FLAKES ---------------!

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ENABLE MOUNTING NTFS FOR THE WINDOWS PARTITION

  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = [ "usbhid" "joydev" "xpad" ];
  # VMS  
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Set your time zone.


  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us, ua";
    xkbVariant = "grp:win_alt_toggle";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixhop = {
    isNormalUser = true;
    description = "grasshopper";
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    steam
    firefox
    krita
    git
    waybar
    alsa-utils
    fastfetch
    htop
    dunst
    libnotify
    swww
    rofi-wayland
    pciutils
    kitty
    glxinfo
    grim
    slurp
    swappy
    pavucontrol
    xfce.thunar
    font-manager
    vscode
    vscodium
    reaper
    audacity
    qjackctl
    clipman
    cava
    obs-studio
    zip
    unzip
    vlc
    nwg-look
    xorg.xinit
    libinput
    gvfs
    acpi
    picom
    xfce.thunar-archive-plugin
    patchelf_0_13
    steam-run
    home-manager
    sox
    numix-icon-theme
    appimage-run
    r2modman
    prismlauncher
    wayland
    obsidian
    spice-vdagent
    xfce.thunar-archive-plugin
    jp2a
    blender
    gtk-engine-murrine
    flameshot
    polybar
    arandr
#    opentabletdriver
    xorg.xinit
    feh
    spicetify-cli 
    spotify
    # ALL OF THE LINUX BUILDING DEPENDS
    bzip2
    ncurses
    flex
    bison
    bc
    libelf
    openssl
    xz
    autoconf
    libgcc
    gnumake
    libtool
    libpng
    freetype
    virt-manager
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    sassc
    libsForQt5.qt5ct
    libsForQt5.bluedevil
   ];
  nixpkgs.config.packageOverrides = pkgs: {
    xfce = pkgs.xfce // {
      gvfs = pkgs.gvfs;
    };
  };
  # FONTS
  fonts.packages = with pkgs; [
    font-awesome
  ];
	
  # QT
  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}