From: Len Brown <len.brown@intel.com>
Subject: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 17:12:51 -0400
Organization: Intel Open Source Technology Center
Message-ID: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 23 23:06:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7fux-00036m-QB
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVHWVCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHWVCp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:02:45 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:57526 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S1750910AbVHWVCo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 17:02:44 -0400
Received: from firebird (WPIS-64-140-212-33.worldpath.net [64.140.212.33])
	by unix.worldpath.net (8.12.9/8.12.9) with ESMTP id j7NL2VrQ001703
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 17:02:37 -0400 (EDT)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7670>

I'm having trouble using git for merging kernel trees.

git seems to manufacture conflicts in files that
I never touched, and on some files it completely
throws up its arms, see "Not handling case" below.

Not clear how I got into this state -- probably
something to do with adding commits on branches
and them git-pull-branch'ing them into the master;
combined with updating the master from-linus.

when i switch heads, I simply remove .git/HEAD
and link it to the refs/heads/master or refs/heads/acpi-2.6.12
followed by a git checkout -f.  To merge the work
back into the master I switch back to the master
and git-pull-branch per jeff's howto.  I also
periodically pull from-linus after switching
the branch back to the master.

The merge issue below is reproduced in a "git clone -l" copy
with no plain files present.

Got any tips on how to recover?

thanks,
-Len

[lenb@firebird to-akpm.latest]$ git pull ../../from-linus
Packing 842 objects
Unpacking 842 objects
 100% (842/842) done
Trying to merge 81065e2f415af6c028eac13f481fb9e60a0b487b into
702c7e7626deeabb057b6f529167b65ec2eefbdb
Simple merge failed, trying Automatic merge
Auto-merging CREDITS.
Removing Documentation/DocBook/scsidrivers.tmpl
Removing Documentation/dvb/README.dibusb
Removing Documentation/i2c/chips/smsc47b397.txt
Removing Documentation/i2c/sysfs-interface
Removing Documentation/networking/wanpipe.txt
Auto-merging MAINTAINERS.
merge: warning: conflicts during merge
ERROR: Merge conflict in MAINTAINERS.
Removing arch/arm/configs/omnimeter_defconfig
Removing arch/arm/kernel/arch.c
Removing arch/arm/lib/longlong.h
Removing arch/arm/lib/udivdi3.c
Removing arch/arm/mach-omap/Kconfig
Removing arch/arm/mach-omap/Makefile
Removing arch/arm/mach-omap/Makefile.boot
Removing arch/arm/mach-omap/board-generic.c
Removing arch/arm/mach-omap/board-h2.c
Removing arch/arm/mach-omap/board-h3.c
Removing arch/arm/mach-omap/board-innovator.c
Removing arch/arm/mach-omap/board-netstar.c
Removing arch/arm/mach-omap/board-osk.c
Removing arch/arm/mach-omap/board-perseus2.c
Removing arch/arm/mach-omap/board-voiceblue.c
Removing arch/arm/mach-omap/clock.c
Removing arch/arm/mach-omap/clock.h
Removing arch/arm/mach-omap/common.c
Removing arch/arm/mach-omap/common.h
Removing arch/arm/mach-omap/dma.c
Removing arch/arm/mach-omap/fpga.c
Removing arch/arm/mach-omap/gpio.c
Removing arch/arm/mach-omap/irq.c
Removing arch/arm/mach-omap/leds-h2p2-debug.c
Removing arch/arm/mach-omap/leds-innovator.c
Removing arch/arm/mach-omap/leds-osk.c
Removing arch/arm/mach-omap/leds.c
Removing arch/arm/mach-omap/leds.h
Removing arch/arm/mach-omap/mcbsp.c
Removing arch/arm/mach-omap/mux.c
Removing arch/arm/mach-omap/ocpi.c
Removing arch/arm/mach-omap/pm.c
Removing arch/arm/mach-omap/sleep.S
Removing arch/arm/mach-omap/time.c
Removing arch/arm/mach-omap/usb.c
Auto-merging arch/arm/mm/Kconfig.
Auto-merging arch/arm/mm/proc-v6.S.
Auto-merging arch/arm/nwfpe/softfloat.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/arm/nwfpe/softfloat.c.
Auto-merging arch/i386/kernel/acpi/boot.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/i386/kernel/acpi/boot.c.
Auto-merging arch/i386/kernel/acpi/sleep.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/i386/kernel/acpi/sleep.c.
Auto-merging arch/i386/kernel/apic.c.
Auto-merging arch/i386/kernel/nmi.c.
Auto-merging arch/ia64/Kconfig.
Auto-merging arch/ia64/configs/sn2_defconfig.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/ia64/configs/sn2_defconfig.
Auto-merging arch/ia64/configs/tiger_defconfig.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/ia64/configs/tiger_defconfig.
Auto-merging arch/ia64/configs/zx1_defconfig.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/ia64/configs/zx1_defconfig.
Auto-merging arch/ia64/kernel/acpi.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/ia64/kernel/acpi.c.
Auto-merging arch/ia64/kernel/domain.c.
Auto-merging arch/ia64/kernel/iosapic.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/ia64/kernel/iosapic.c.
Auto-merging arch/ia64/kernel/perfmon.c.
Removing arch/ia64/sn/include/pci/pcibr_provider.h
Removing arch/ia64/sn/include/pci/pic.h
Removing arch/ia64/sn/include/pci/tiocp.h
Auto-merging arch/ia64/sn/kernel/io_init.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/ia64/sn/kernel/io_init.c.
Removing arch/mips/vr41xx/common/giu.c
Removing arch/ppc/boot/utils/addSystemMap.c
Removing arch/ppc/syslib/ppc4xx_kgdb.c
Removing arch/ppc64/boot/mknote.c
Removing arch/ppc64/boot/piggyback.c
Auto-merging arch/ppc64/kernel/LparData.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/ppc64/kernel/LparData.c.
Auto-merging arch/ppc64/kernel/Makefile.
Removing arch/ppc64/kernel/XmPciLpEvent.c
Auto-merging arch/ppc64/kernel/head.S.
Removing arch/ppc64/kernel/iSeries_pci_reset.c
Auto-merging arch/ppc64/kernel/iommu.c.
Auto-merging arch/sparc64/kernel/traps.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/sparc64/kernel/traps.c.
Auto-merging arch/um/kernel/skas/process.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/um/kernel/skas/process.c.
Removing arch/um/kernel/skas/time.c
Removing arch/um/kernel/tt/time.c
Removing arch/um/kernel/tt/unmap.c
Auto-merging arch/um/os-Linux/elf_aux.c.
Auto-merging arch/x86_64/kernel/smpboot.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in arch/x86_64/kernel/smpboot.c.
Auto-merging arch/x86_64/mm/fault.c.
Auto-merging drivers/acpi/Kconfig.
Auto-merging drivers/acpi/container.c.
Auto-merging drivers/acpi/osl.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/acpi/osl.c.
Auto-merging drivers/acpi/pci_bind.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/acpi/pci_bind.c.
Auto-merging drivers/acpi/pci_irq.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/acpi/pci_irq.c.
Auto-merging drivers/acpi/pci_link.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/acpi/pci_link.c.
Auto-merging drivers/acpi/pci_root.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/acpi/pci_root.c.
Auto-merging drivers/acpi/processor_core.c.
Auto-merging drivers/acpi/processor_idle.c.
Auto-merging drivers/acpi/scan.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/acpi/scan.c.
Auto-merging drivers/acpi/sleep/poweroff.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/acpi/sleep/poweroff.c.
Auto-merging drivers/base/bus.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/base/bus.c.
Auto-merging drivers/base/class.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/base/class.c.
Removing drivers/base/class_simple.c
Auto-merging drivers/char/hpet.c.
Removing drivers/i2c/chips/adm1021.c
Removing drivers/i2c/chips/adm1025.c
Removing drivers/i2c/chips/adm1026.c
Removing drivers/i2c/chips/adm1031.c
Removing drivers/i2c/chips/asb100.c
Removing drivers/i2c/chips/ds1621.c
Removing drivers/i2c/chips/fscher.c
Removing drivers/i2c/chips/fscpos.c
Removing drivers/i2c/chips/gl518sm.c
Removing drivers/i2c/chips/gl520sm.c
Removing drivers/i2c/chips/it87.c
Removing drivers/i2c/chips/lm63.c
Removing drivers/i2c/chips/lm75.c
Removing drivers/i2c/chips/lm75.h
Removing drivers/i2c/chips/lm77.c
Removing drivers/i2c/chips/lm78.c
Removing drivers/i2c/chips/lm80.c
Removing drivers/i2c/chips/lm83.c
Removing drivers/i2c/chips/lm85.c
Removing drivers/i2c/chips/lm87.c
Removing drivers/i2c/chips/lm90.c
Removing drivers/i2c/chips/lm92.c
Removing drivers/i2c/chips/max1619.c
Removing drivers/i2c/chips/pc87360.c
Removing drivers/i2c/chips/sis5595.c
Removing drivers/i2c/chips/smsc47b397.c
Removing drivers/i2c/chips/smsc47m1.c
Removing drivers/i2c/chips/via686a.c
Removing drivers/i2c/chips/w83627hf.c
Removing drivers/i2c/chips/w83781d.c
Removing drivers/i2c/chips/w83l785ts.c
Auto-merging drivers/ide/Kconfig.
Removing drivers/ide/cris/ide-v10.c
Auto-merging drivers/ide/ide-floppy.c.
Auto-merging drivers/ide/pci/generic.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/ide/pci/generic.c.
Auto-merging drivers/ide/pci/serverworks.c.
Auto-merging drivers/ide/ppc/pmac.c.
Auto-merging drivers/ide/setup-pci.c.
Removing drivers/input/gameport/cs461x.c
Removing drivers/input/gameport/vortex.c
Removing drivers/isdn/hisax/enternow.h
Removing drivers/isdn/hisax/st5481_hdlc.c
Removing drivers/isdn/hisax/st5481_hdlc.h
Removing drivers/isdn/sc/debug.c
Removing drivers/macintosh/macserial.c
Removing drivers/macintosh/macserial.h
Auto-merging drivers/md/md.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/md/md.c.
Removing drivers/media/dvb/b2c2/skystar2.c
Removing drivers/media/dvb/dibusb/Kconfig
Removing drivers/media/dvb/dibusb/Makefile
Removing drivers/media/dvb/dibusb/dvb-dibusb-core.c
Removing drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
Removing drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
Removing drivers/media/dvb/dibusb/dvb-dibusb-firmware.c
Removing drivers/media/dvb/dibusb/dvb-dibusb-remote.c
Removing drivers/media/dvb/dibusb/dvb-dibusb-usb.c
Removing drivers/media/dvb/dibusb/dvb-dibusb.h
Removing drivers/media/dvb/dibusb/dvb-fe-dtt200u.c
Removing drivers/mtd/maps/db1550-flash.c
Removing drivers/mtd/maps/db1x00-flash.c
Removing drivers/mtd/maps/elan-104nc.c
Removing drivers/mtd/maps/pb1550-flash.c
Removing drivers/mtd/maps/pb1xxx-flash.c
Removing drivers/mtd/nand/tx4925ndfmc.c
Removing drivers/mtd/nand/tx4938ndfmc.c
Auto-merging drivers/net/8139cp.c.
ERROR: drivers/net/dm9000.c: Not handling case  ->
5fddc0ff887822fde5cbf904e3db8e46b4becca1 ->
6440a892bb813ca4a08e0a1878cf0dedb43b254d
Removing drivers/net/fmv18x.c
Removing drivers/net/sk_g16.c
Removing drivers/net/sk_g16.h
Removing drivers/net/skfp/lnkstat.c
Removing drivers/net/skfp/smtparse.c
Removing drivers/net/smc-mca.h
Auto-merging drivers/net/tg3.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/net/tg3.c.
Removing drivers/pci/hotplug/acpiphp_pci.c
Removing drivers/pci/hotplug/acpiphp_res.c
Auto-merging drivers/pci/msi.c.
Auto-merging drivers/pci/quirks.c.
Auto-merging drivers/pnp/card.c.
Removing drivers/scsi/pci2000.c
Removing drivers/scsi/pci2220i.c
Removing drivers/scsi/pci2220i.h
Removing drivers/scsi/psi_dale.h
Removing drivers/scsi/psi_roy.h
Removing drivers/serial/bast_sio.c
Auto-merging drivers/serial/sn_console.c.
Removing drivers/usb/atm/usb_atm.c
Removing drivers/usb/atm/usb_atm.h
Auto-merging drivers/usb/input/wacom.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in drivers/usb/input/wacom.c.
Auto-merging drivers/usb/net/zd1201.c.
Removing fs/freevxfs/vxfs_kcompat.h
ERROR: fs/ioprio.c: Not handling case  ->
97e1f088ba00b3b63f7f9ea594b756781fcf6596 ->
d1c1f2b2c9da9796affc6be18b8793489b9f2873
Auto-merging fs/jffs2/symlink.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in fs/jffs2/symlink.c.
Auto-merging fs/jfs/inode.c.
Auto-merging fs/jfs/jfs_logmgr.c.
Auto-merging fs/jfs/jfs_logmgr.h.
Auto-merging fs/jfs/jfs_txnmgr.c.
Auto-merging fs/jfs/super.c.
Auto-merging fs/jfs/symlink.c.
Auto-merging fs/namei.c.
Auto-merging fs/nfs/dir.c.
Auto-merging fs/nfs/file.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in fs/nfs/file.c.
Auto-merging fs/nfs/inode.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in fs/nfs/inode.c.
ERROR: fs/nfs/nfs3acl.c: Not handling case  ->
1b7a3ef2f8131f4f9c02534f55d5a42de4633f67 ->
6a5bbc0ae941aa690e1f73137cbce4af38902092
Auto-merging fs/nfs/nfs3proc.c.
Auto-merging fs/nfs/nfs4proc.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in fs/nfs/nfs4proc.c.
Auto-merging fs/nfs/proc.c.
Auto-merging fs/nfs/read.c.
ERROR: fs/nfs_common/nfsacl.c: Not handling case  ->
18c58c32e326281bfa7226edbaaec135b45c2b70 ->
251e5a1bb1c4cbe0308c042073b0d83cfe71d73d
Auto-merging fs/nfsd/nfssvc.c.
Auto-merging fs/ntfs/ChangeLog.
merge: warning: conflicts during merge
ERROR: Merge conflict in fs/ntfs/ChangeLog.
Auto-merging fs/ntfs/aops.c.
Auto-merging fs/ntfs/mft.c.
Auto-merging fs/proc/base.c.
Auto-merging fs/reiserfs/inode.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in fs/reiserfs/inode.c.
Auto-merging fs/sysfs/symlink.c.
Auto-merging include/acpi/acpi_bus.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in include/acpi/acpi_bus.h.
Auto-merging include/acpi/acpi_drivers.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in include/acpi/acpi_drivers.h.
Auto-merging include/asm-i386/processor.h.
Auto-merging include/asm-ia64/iosapic.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in include/asm-ia64/iosapic.h.
Removing include/asm-m32r/m32102peri.h
Removing include/asm-ppc/fsl_ocp.h
Auto-merging include/asm-ppc/ibm44x.h.
Removing include/asm-ppc64/iSeries/HvCallCfg.h
Removing include/asm-ppc64/iSeries/LparData.h
Auto-merging include/asm-ppc64/iSeries/LparMap.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in include/asm-ppc64/iSeries/LparMap.h.
Removing include/asm-ppc64/iSeries/XmPciLpEvent.h
Removing include/asm-ppc64/iSeries/iSeries_proc.h
Auto-merging include/asm-sh/unistd.h.
Auto-merging include/asm-sparc64/thread_info.h.
Auto-merging include/asm-x86_64/processor.h.
Auto-merging include/linux/acpi.h.
Auto-merging include/linux/fs.h.
Removing include/linux/ioc4_common.h
Removing include/linux/netfilter_ipv4/lockhelp.h
Auto-merging include/linux/nfs_fs.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in include/linux/nfs_fs.h.
Removing include/linux/pci-dynids.h
Auto-merging include/linux/pci.h.
Auto-merging include/linux/pci_ids.h.
Auto-merging include/linux/sunrpc/xdr.h.
merge: warning: conflicts during merge
ERROR: Merge conflict in include/linux/sunrpc/xdr.h.
Removing include/linux/xattr_acl.h
Auto-merging include/net/ax25.h.
Auto-merging include/net/sock.h.
Auto-merging kernel/sched.c.
Auto-merging kernel/signal.c.
Auto-merging kernel/timer.c.
Auto-merging mm/shmem.c.
Auto-merging net/decnet/dn_neigh.c.
Auto-merging net/ipv4/icmp.c.
Auto-merging net/ipv4/ipcomp.c.
Auto-merging net/ipv4/tcp.c.
Auto-merging net/ipv4/tcp_ipv4.c.
Auto-merging net/ipv4/tcp_output.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in net/ipv4/tcp_output.c.
Removing net/ipv4/utils.c
Auto-merging net/ipv6/ipcomp6.c.
Auto-merging net/ipv6/netfilter/ip6_queue.c.
Auto-merging net/ipv6/raw.c.
Auto-merging net/ipv6/tcp_ipv6.c.
Auto-merging net/sched/sch_generic.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in net/sched/sch_generic.c.
Auto-merging net/sunrpc/xdr.c.
merge: warning: conflicts during merge
ERROR: Merge conflict in net/sunrpc/xdr.c.
Removing sound/pcmcia/vx/vx_entry.c
Removing sound/pcmcia/vx/vxp440.c
Auto-merging sound/ppc/pmac.c.
fatal: merge program failed
Automatic merge failed, fix up by hand
