From: Dave Jones <davej@redhat.com>
Subject: Re: merging problems with Linus' kernel tree.
Date: Tue, 21 Feb 2006 14:19:48 -0500
Message-ID: <20060221191948.GE22988@redhat.com>
References: <20060221183306.GC22988@redhat.com> <Pine.LNX.4.64.0602211052360.30245@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 20:20:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBd3P-0005DF-UV
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 20:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWBUTT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 14:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbWBUTT6
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 14:19:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42676 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932351AbWBUTT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 14:19:57 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k1LJJqXg012404;
	Tue, 21 Feb 2006 14:19:52 -0500
Received: from nwo.kernelslacker.org (vpn83-122.boston.redhat.com [172.16.83.122])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k1LJJp105147;
	Tue, 21 Feb 2006 14:19:51 -0500
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.5/8.13.5) with ESMTP id k1LJJorb022227;
	Tue, 21 Feb 2006 14:19:50 -0500
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.5/8.13.5/Submit) id k1LJJned022225;
	Tue, 21 Feb 2006 14:19:49 -0500
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602211052360.30245@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16543>

On Tue, Feb 21, 2006 at 10:55:15AM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Tue, 21 Feb 2006, Dave Jones wrote:
 > >
 > > Documentation/cpu-hotplug.txt: needs update
 > > fatal: Entry 'Documentation/cpu-hotplug.txt' would be overwritten by merge. Cannot merge.
 > 
 > This means that it's dirty in the index, not that you've committed any 
 > changes.
 > 
 > Do a "git diff".

For some reason, that shows that file being deleted.

diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
deleted file mode 100644
index e71bc6c..0000000
--- a/Documentation/cpu-hotplug.txt
+++ /dev/null
@@ -1,373 +0,0 @@

...

 > (It may also be that the diff is empty, and only shows the filename. That 
 > means that you've changed the mtime - for example edited it, and then 
 > undone the edit

Hmm, this tree is on NFS.   The server was 2-3 seconds ahead of the client
(for some reason ntp wasn't running), but I wouldn't expect such chaos
to ensue from this?

 > - so that the file is dirty in the index, even if the 
 > _contents_ are the same. If so, do a "git-update-index --refresh" or 
 > similar, or just ask for "git status", which will do it for you as part of 
 > checking the status of all your files).

Hmm. git status shows a ton of modified files, that I know I've never touched.
(arch/frv is somewhere I'd rather not venture)

#
# Updated but not checked in:
#   (will commit)
#
#       modified: Documentation/cpu-hotplug.txt
#       new file: Documentation/fujitsu/frv/kernel-ABI.txt
#       modified: Documentation/hwmon/w83627hf
#       modified: Documentation/kernel-parameters.txt
#       modified: Documentation/kprobes.txt
#       modified: Documentation/mips/AU1xxx_IDE.README
#       modified: Documentation/powerpc/booting-without-of.txt
#       modified: Documentation/scsi/ChangeLog.megaraid_sas
#       modified: MAINTAINERS
#       modified: Makefile
#       modified: arch/arm/kernel/calls.S
#       modified: arch/arm/kernel/setup.c
#       modified: arch/arm/kernel/smp.c
#       modified: arch/arm/kernel/sys_oabi-compat.c
#       modified: arch/arm/mach-integrator/platsmp.c
#       modified: arch/arm/mach-iop3xx/iop321-setup.c
#       modified: arch/arm/mach-iop3xx/iop331-setup.c
#       modified: arch/arm/mach-ixp4xx/nslu2-setup.c
#       modified: arch/arm/mach-realview/platsmp.c
#       modified: arch/arm/mach-s3c2410/mach-h1940.c
#       new file: arch/arm/mach-s3c2410/s3c2400.h
#       modified: arch/arm/plat-omap/pm.c
#       modified: arch/frv/Kconfig
#       modified: arch/frv/Makefile
#       modified: arch/frv/kernel/break.S
#       modified: arch/frv/kernel/entry-table.S
#       modified: arch/frv/kernel/entry.S
#       modified: arch/frv/kernel/head.S
#       modified: arch/frv/kernel/irq.c
#       modified: arch/frv/mm/kmap.c
#       modified: arch/h8300/Kconfig
#       modified: arch/h8300/Kconfig.cpu
#       new file: arch/i386/boot/.gitignore
#       new file: arch/i386/boot/tools/.gitignore
#       new file: arch/i386/kernel/.gitignore
#       modified: arch/i386/kernel/cpu/transmeta.c
#       modified: arch/i386/kernel/head.S
#       modified: arch/i386/kernel/syscall_table.S
#       modified: arch/i386/kernel/timers/timer_tsc.c
#       modified: arch/i386/kernel/vsyscall-sysenter.S
#       modified: arch/i386/oprofile/backtrace.c
#       modified: arch/ia64/kernel/acpi.c
#       modified: arch/ia64/kernel/entry.S
#       modified: arch/ia64/kernel/ia64_ksyms.c
#       modified: arch/ia64/kernel/setup.c
#       modified: arch/ia64/kernel/smpboot.c
#       modified: arch/ia64/kernel/time.c
#       modified: arch/ia64/kernel/traps.c
#       modified: arch/ia64/sn/kernel/io_init.c
#       modified: arch/ia64/sn/kernel/setup.c
#       modified: arch/ia64/sn/kernel/sn2/prominfo_proc.c
#       modified: arch/ia64/sn/kernel/sn2/sn2_smp.c
#       modified: arch/ia64/sn/kernel/sn2/sn_proc_fs.c
#       modified: arch/ia64/sn/kernel/sn2/timer.c
#       modified: arch/ia64/sn/kernel/sn2/timer_interrupt.c
#       modified: arch/ia64/sn/kernel/tiocx.c
#       modified: arch/ia64/sn/kernel/xpc_channel.c
#       modified: arch/ia64/sn/kernel/xpc_main.c
#       modified: arch/ia64/sn/pci/pci_dma.c
#       modified: arch/ia64/sn/pci/pcibr/pcibr_ate.c
#       modified: arch/ia64/sn/pci/pcibr/pcibr_dma.c
#       modified: arch/ia64/sn/pci/pcibr/pcibr_provider.c
#       modified: arch/m68k/Kconfig
#       modified: arch/m68k/fpsp040/bindec.S
#       modified: arch/m68k/fpsp040/binstr.S
#       modified: arch/m68k/fpsp040/bugfix.S
#       modified: arch/m68k/fpsp040/decbin.S
#       modified: arch/m68k/fpsp040/do_func.S
#       modified: arch/m68k/fpsp040/fpsp.h
#       modified: arch/m68k/fpsp040/gen_except.S
#       modified: arch/m68k/fpsp040/get_op.S
#       modified: arch/m68k/fpsp040/kernel_ex.S
#       modified: arch/m68k/fpsp040/res_func.S
#       modified: arch/m68k/fpsp040/round.S
#       modified: arch/m68k/fpsp040/sacos.S
#       modified: arch/m68k/fpsp040/sasin.S
#       modified: arch/m68k/fpsp040/satan.S
#       modified: arch/m68k/fpsp040/satanh.S
#       modified: arch/m68k/fpsp040/scale.S
#       modified: arch/m68k/fpsp040/scosh.S
#       modified: arch/m68k/fpsp040/setox.S
#       modified: arch/m68k/fpsp040/sgetem.S
#       modified: arch/m68k/fpsp040/sint.S
#       modified: arch/m68k/fpsp040/skeleton.S
#       modified: arch/m68k/fpsp040/slog2.S
#       modified: arch/m68k/fpsp040/slogn.S
#       modified: arch/m68k/fpsp040/smovecr.S
#       modified: arch/m68k/fpsp040/srem_mod.S
#       modified: arch/m68k/fpsp040/ssin.S
#       modified: arch/m68k/fpsp040/ssinh.S
#       modified: arch/m68k/fpsp040/stan.S
#       modified: arch/m68k/fpsp040/stanh.S
#       modified: arch/m68k/fpsp040/sto_res.S
#       modified: arch/m68k/fpsp040/stwotox.S
#       modified: arch/m68k/fpsp040/tbldo.S
#       modified: arch/m68k/fpsp040/util.S
#       modified: arch/m68k/fpsp040/x_bsun.S
#       modified: arch/m68k/fpsp040/x_fline.S
#       modified: arch/m68k/fpsp040/x_operr.S
#       modified: arch/m68k/fpsp040/x_ovfl.S
#       modified: arch/m68k/fpsp040/x_snan.S
#       modified: arch/m68k/fpsp040/x_store.S
#       modified: arch/m68k/fpsp040/x_unfl.S
#       modified: arch/m68k/fpsp040/x_unimp.S
#       modified: arch/m68k/fpsp040/x_unsupp.S
#       modified: arch/m68knommu/Kconfig
#       modified: arch/mips/Makefile
#       modified: arch/mips/kernel/process.c
#       modified: arch/mips/kernel/scall32-o32.S
#       modified: arch/mips/kernel/signal-common.h
#       modified: arch/mips/kernel/signal32.c
#       modified: arch/mips/kernel/signal_n32.c
#       modified: arch/mips/kernel/smp_mt.c
#       modified: arch/mips/mm/c-r4k.c
#       modified: arch/mips/mm/c-tx39.c
#       modified: arch/parisc/Kconfig
#       modified: arch/parisc/kernel/syscall_table.S
#       modified: arch/powerpc/Kconfig
#       modified: arch/powerpc/Makefile
#       modified: arch/powerpc/kernel/Makefile
#       modified: arch/powerpc/kernel/systbl.S
#       modified: arch/ppc/kernel/misc.S
#       modified: arch/s390/Kconfig
#       modified: arch/s390/defconfig
#       modified: arch/s390/kernel/compat_linux.c
#       modified: arch/s390/kernel/compat_signal.c
#       modified: arch/s390/kernel/compat_wrapper.S
#       modified: arch/s390/kernel/machine_kexec.c
#       modified: arch/s390/kernel/process.c
#       modified: arch/s390/kernel/setup.c
#       modified: arch/s390/kernel/smp.c
#       modified: arch/s390/kernel/syscalls.S
#       modified: arch/s390/lib/delay.c
#       modified: arch/sh/Kconfig
#       modified: arch/sparc/kernel/systbls.S
#       modified: arch/sparc64/kernel/sys_sparc32.c
#       modified: arch/sparc64/kernel/systbls.S
#       modified: arch/v850/Kconfig
#       modified: arch/x86_64/defconfig
#       modified: arch/x86_64/ia32/ia32entry.S
#       modified: arch/x86_64/ia32/sys_ia32.c
#       modified: arch/x86_64/kernel/apic.c
#       modified: arch/x86_64/kernel/entry.S
#       modified: arch/x86_64/kernel/head.S
#       modified: arch/x86_64/kernel/io_apic.c
#       modified: arch/x86_64/kernel/mpparse.c
#       modified: arch/x86_64/kernel/nmi.c
#       modified: arch/x86_64/kernel/pci-gart.c
#       modified: arch/x86_64/kernel/time.c
#       modified: arch/x86_64/kernel/traps.c
#       modified: arch/x86_64/mm/k8topology.c
#       modified: arch/x86_64/mm/numa.c
#       modified: arch/x86_64/mm/srat.c
#       modified: drivers/acpi/resources/rscalc.c
#       modified: drivers/block/pktcdvd.c
#       modified: drivers/bluetooth/bt3c_cs.c
#       modified: drivers/char/drm/drm_pciids.h
#       modified: drivers/char/esp.c
#       modified: drivers/char/hpet.c
#       modified: drivers/char/tipar.c
#       modified: drivers/char/tpm/tpm_infineon.c
#       modified: drivers/char/tty_io.c
#       modified: drivers/char/watchdog/pcwd.c
#       modified: drivers/char/watchdog/sa1100_wdt.c
#       modified: drivers/cpufreq/cpufreq.c
#       modified: drivers/hwmon/it87.c
#       modified: drivers/hwmon/vt8231.c
#       modified: drivers/hwmon/w83781d.c
#       modified: drivers/i2c/busses/i2c-isa.c
#       modified: drivers/ide/ide-taskfile.c
#       modified: drivers/ide/pci/sgiioc4.c
#       modified: drivers/infiniband/core/mad.c
#       modified: drivers/infiniband/hw/mthca/mthca_cmd.c
#       modified: drivers/infiniband/hw/mthca/mthca_dev.h
#       modified: drivers/infiniband/ulp/ipoib/ipoib.h
#       modified: drivers/infiniband/ulp/ipoib/ipoib_multicast.c
#       modified: drivers/input/keyboard/Makefile
#       modified: drivers/input/misc/Makefile
#       modified: drivers/input/misc/ixp4xx-beeper.c
#       modified: drivers/input/mouse/logips2pp.c
#       modified: drivers/input/mouse/trackpoint.c
#       modified: drivers/input/mouse/trackpoint.h
#       modified: drivers/input/serio/Makefile
#       modified: drivers/input/touchscreen/ads7846.c
#       modified: drivers/isdn/i4l/isdn_tty.c
#       modified: drivers/macintosh/windfarm_smu_sat.c
#       modified: drivers/message/fusion/mptbase.c
#       modified: drivers/message/fusion/mptbase.h
#       modified: drivers/message/fusion/mptctl.c
#       modified: drivers/message/fusion/mptctl.h
#       modified: drivers/message/fusion/mptscsih.c
#       modified: drivers/mmc/mmci.c
#       modified: drivers/net/Kconfig
#       modified: drivers/net/appletalk/cops.h
#       modified: drivers/net/bonding/bond_main.c
#       modified: drivers/net/sis190.c
#       modified: drivers/net/skge.c
#       modified: drivers/net/sky2.c
#       modified: drivers/net/tokenring/smctr.h
#       modified: drivers/net/wireless/atmel.c
#       modified: drivers/net/wireless/orinoco_cs.c
#       modified: drivers/net/wireless/wavelan_cs.c
#       modified: drivers/parisc/ccio-dma.c
#       modified: drivers/parisc/sba_iommu.c
#       modified: drivers/s390/char/sclp.c
#       modified: drivers/s390/cio/chsc.c
#       modified: drivers/s390/cio/device.c
#       modified: drivers/s390/cio/device_pgid.c
#       modified: drivers/s390/cio/device_status.c
#       modified: drivers/s390/net/lcs.c
#       modified: drivers/s390/net/lcs.h
#       modified: drivers/s390/net/qeth.h
#       modified: drivers/s390/net/qeth_eddp.c
#       modified: drivers/s390/net/qeth_main.c
#       modified: drivers/s390/scsi/zfcp_dbf.c
#       modified: drivers/s390/scsi/zfcp_def.h
#       modified: drivers/s390/scsi/zfcp_erp.c
#       modified: drivers/s390/scsi/zfcp_ext.h
#       modified: drivers/s390/scsi/zfcp_fsf.c
#       modified: drivers/s390/scsi/zfcp_scsi.c
#       modified: drivers/s390/scsi/zfcp_sysfs_adapter.c
#       modified: drivers/scsi/3w-9xxx.c
#       modified: drivers/scsi/aacraid/aachba.c
#       modified: drivers/scsi/aacraid/aacraid.h
#       modified: drivers/scsi/aacraid/commctrl.c
#       modified: drivers/scsi/aacraid/comminit.c
#       modified: drivers/scsi/aacraid/commsup.c
#       modified: drivers/scsi/aacraid/dpcsup.c
#       modified: drivers/scsi/aacraid/linit.c
#       modified: drivers/scsi/gdth.c
#       modified: drivers/scsi/ipr.c
#       modified: drivers/scsi/ipr.h
#       modified: drivers/scsi/iscsi_tcp.c
#       modified: drivers/scsi/iscsi_tcp.h
#       modified: drivers/scsi/libata-core.c
#       modified: drivers/scsi/megaraid.c
#       modified: drivers/scsi/megaraid.h
#       modified: drivers/scsi/megaraid/megaraid_sas.c
#       modified: drivers/scsi/megaraid/megaraid_sas.h
#       modified: drivers/scsi/qla2xxx/qla_attr.c
#       modified: drivers/scsi/qla2xxx/qla_def.h
#       modified: drivers/scsi/qla2xxx/qla_gbl.h
#       modified: drivers/scsi/qla2xxx/qla_init.c
#       modified: drivers/scsi/qla2xxx/qla_iocb.c
#       modified: drivers/scsi/qla2xxx/qla_isr.c
#       modified: drivers/scsi/qla2xxx/qla_mbx.c
#       modified: drivers/scsi/qla2xxx/qla_os.c
#       modified: drivers/scsi/qla2xxx/qla_rscn.c
#       modified: drivers/scsi/qla2xxx/qla_sup.c
#       modified: drivers/scsi/sata_mv.c
#       modified: drivers/scsi/sata_vsc.c
#       modified: drivers/scsi/scsi_lib.c
#       modified: drivers/scsi/scsi_scan.c
#       modified: drivers/scsi/scsi_sysfs.c
#       modified: drivers/scsi/scsi_transport_iscsi.c
#       modified: drivers/scsi/sym53c8xx_2/sym_hipd.c
#       modified: drivers/serial/8250.c
#       modified: drivers/serial/Kconfig
#       modified: drivers/serial/ioc4_serial.c
#       modified: drivers/usb/host/pci-quirks.c
#       modified: drivers/usb/host/sl811_cs.c
#       modified: drivers/usb/input/hid-core.c
#       modified: drivers/usb/misc/Kconfig
#       modified: drivers/usb/misc/ldusb.c
#       modified: drivers/usb/serial/pl2303.c
#       modified: drivers/usb/serial/pl2303.h
#       modified: drivers/usb/storage/unusual_devs.h
#       modified: drivers/video/Kconfig
#       modified: drivers/video/fbmem.c
#       modified: drivers/video/gbefb.c
#       modified: drivers/video/neofb.c
#       modified: drivers/video/nvidia/nvidia.c
#       modified: drivers/video/s3c2410fb.c
#       modified: fs/cifs/file.c
#       modified: fs/compat.c
#       modified: fs/exec.c
#       modified: fs/ext2/xattr.c
#       modified: fs/fuse/dev.c
#       modified: fs/fuse/file.c
#       modified: fs/jbd/checkpoint.c
#       modified: fs/jbd/commit.c
#       modified: fs/lockd/clntlock.c
#       modified: fs/lockd/svc4proc.c
#       modified: fs/lockd/svcproc.c
#       modified: fs/ocfs2/dlm/dlmcommon.h
#       modified: fs/ocfs2/dlm/dlmconvert.c
#       modified: fs/ocfs2/dlm/dlmlock.c
#       modified: fs/ocfs2/dlm/dlmmaster.c
#       modified: fs/ocfs2/dlm/dlmrecovery.c
#       modified: fs/ocfs2/journal.c
#       modified: fs/ocfs2/journal.h
#       modified: fs/reiserfs/super.c
#       modified: fs/reiserfs/xattr_acl.c
#       modified: fs/select.c
#       modified: fs/stat.c
#       modified: include/asm-alpha/mman.h
#       new file: include/asm-arm/arch-s3c2410/h1940-latch.h
#       modified: include/asm-arm/mman.h
#       modified: include/asm-arm/smp.h
#       modified: include/asm-arm/unistd.h
#       modified: include/asm-arm26/mman.h
#       modified: include/asm-cris/mman.h
#       modified: include/asm-frv/atomic.h
#       modified: include/asm-frv/cacheflush.h
#       modified: include/asm-frv/io.h
#       modified: include/asm-frv/mman.h
#       modified: include/asm-frv/spr-regs.h
#       modified: include/asm-frv/system.h
#       modified: include/asm-frv/uaccess.h
#       modified: include/asm-frv/unistd.h
#       new file: include/asm-generic/mman.h
#       modified: include/asm-h8300/mman.h
#       modified: include/asm-i386/mman.h
#       modified: include/asm-i386/thread_info.h
#       modified: include/asm-i386/topology.h
#       modified: include/asm-i386/unistd.h
#       modified: include/asm-ia64/acpi.h
#       modified: include/asm-ia64/machvec_sn2.h
#       modified: include/asm-ia64/mman.h
#       modified: include/asm-ia64/sn/arch.h
#       modified: include/asm-ia64/sn/bte.h
#       modified: include/asm-ia64/sn/pcibr_provider.h
#       modified: include/asm-ia64/sn/sn_feature_sets.h
#       modified: include/asm-ia64/sn/xpc.h
#       modified: include/asm-ia64/timex.h
#       modified: include/asm-m32r/mman.h
#       modified: include/asm-m68k/mman.h
#       modified: include/asm-mips/cpu.h
#       deleted:  include/asm-mips/gcc/sgidefs.h
#       modified: include/asm-mips/mach-generic/timex.h
#       new file: include/asm-mips/mach-rm200/timex.h
#       modified: include/asm-mips/mman.h
#       modified: include/asm-mips/r4kcache.h
#       modified: include/asm-mips/uaccess.h
#       modified: include/asm-mips/unistd.h
#       modified: include/asm-parisc/mman.h
#       modified: include/asm-powerpc/mman.h
#       modified: include/asm-powerpc/pgalloc.h
#       modified: include/asm-powerpc/unistd.h
#       modified: include/asm-s390/bitops.h
#       modified: include/asm-s390/mman.h
#       modified: include/asm-s390/setup.h
#       modified: include/asm-s390/smp.h
#       modified: include/asm-s390/unistd.h
#       modified: include/asm-sh/mman.h
#       modified: include/asm-sparc/mman.h
#       modified: include/asm-sparc/unistd.h
#       modified: include/asm-sparc64/mman.h
#       modified: include/asm-sparc64/unistd.h
#       modified: include/asm-v850/mman.h
#       modified: include/asm-x86_64/hpet.h
#       modified: include/asm-x86_64/ia32_unistd.h
#       modified: include/asm-x86_64/mman.h
#       modified: include/asm-x86_64/proto.h
#       modified: include/asm-xtensa/mman.h
#       modified: include/linux/compat.h
#       modified: include/linux/jbd.h
#       modified: include/linux/kernel.h
#       modified: include/linux/ktime.h
#       modified: include/linux/lockd/lockd.h
#       modified: include/linux/mm.h
#       modified: include/linux/netfilter.h
#       modified: include/linux/netfilter_ipv4.h
#       modified: include/linux/pci_ids.h
#       modified: include/linux/ptrace.h
#       modified: include/linux/sched.h
#       modified: include/linux/syscalls.h
#       modified: include/linux/time.h
#       modified: include/linux/timex.h
#       modified: include/net/bluetooth/rfcomm.h
#       modified: include/net/ip.h
#       modified: include/net/irda/irda.h
#       modified: include/net/xfrm.h
#       modified: include/scsi/iscsi_if.h
#       modified: include/scsi/scsi.h
#       modified: include/scsi/scsi_transport_iscsi.h
#       modified: include/video/neomagic.h
#       modified: kernel/cpuset.c
#       modified: kernel/fork.c
#       modified: kernel/hrtimer.c
#       modified: kernel/power/snapshot.c
#       modified: kernel/power/swsusp.c
#       modified: kernel/ptrace.c
#       modified: kernel/sched.c
#       modified: kernel/sysctl.c
#       modified: kernel/timer.c
#       modified: lib/radix-tree.c
#       modified: mm/hugetlb.c
#       modified: mm/madvise.c
#       modified: mm/memory.c
#       modified: mm/mempolicy.c
#       modified: mm/page_alloc.c
#       modified: mm/swap.c
#       modified: mm/vmscan.c
#       modified: net/802/p8023.c
#       modified: net/atm/signaling.c
#       modified: net/bluetooth/hci_sock.c
#       modified: net/bluetooth/rfcomm/core.c
#       modified: net/bridge/br_netfilter.c
#       modified: net/bridge/br_stp_if.c
#       modified: net/core/datagram.c
#       modified: net/ipv4/icmp.c
#       modified: net/ipv4/ip_gre.c
#       modified: net/ipv4/ip_output.c
#       modified: net/ipv4/ipip.c
#       modified: net/ipv4/netfilter.c
#       modified: net/ipv4/netfilter/ip_nat_standalone.c
#       modified: net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
#       modified: net/ipv4/xfrm4_output.c
#       modified: net/ipv6/icmp.c
#       modified: net/ipv6/netfilter/ip6t_REJECT.c
#       modified: net/ipv6/raw.c
#       modified: net/netfilter/Kconfig
#       modified: net/netfilter/nf_conntrack_core.c
#       modified: net/netfilter/nf_conntrack_proto_tcp.c
#       modified: net/netfilter/nf_conntrack_proto_udp.c
#       modified: net/netlink/genetlink.c
#       modified: net/xfrm/xfrm_policy.c
#
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       deleted:  Documentation/cpu-hotplug.txt
#


Spooky.  I'm seriously questioning myself whether or not I have
done something to this tree, but I'm 99.999% sure it's unmodified
(by me at least).

git diff on any of the modified files shows no output, which
could be explained by your modified timestamp theory, but
how about the deleted/new files ?

		Dave
