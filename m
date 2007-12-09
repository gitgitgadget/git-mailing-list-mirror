From: Christian Couder <chriscool@tuxfamily.org>
Subject: git-bisect run make -j64 kernel/ (was Re: git-bisect feature suggestion: "git-bisect diff")
Date: Sun, 9 Dec 2007 06:33:33 +0100
Message-ID: <200712090633.36086.chriscool@tuxfamily.org>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071208152922.GB30270@elte.hu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w43WHZw8lVYxRyc"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Dec 09 06:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Ehb-0001UP-9W
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 06:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbXLIF1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 00:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXLIF1W
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 00:27:22 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:44664 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbXLIF1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 00:27:20 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ACCB51AB2B3;
	Sun,  9 Dec 2007 06:27:18 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5B9CE1AB2AD;
	Sun,  9 Dec 2007 06:27:18 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071208152922.GB30270@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67596>

--Boundary-00=_w43WHZw8lVYxRyc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le samedi 8 d=E9cembre 2007, Ingo Molnar a =E9crit :
> Currently, in the Linux kernel, if i do this:
>
>  $ git-bisect run make -j64 kernel/
>
> it fails with:
>
>  running make -j64 kernel/
>    CHK     include/linux/version.h
>    CHK     include/linux/utsrelease.h
>    CALL    scripts/checksyscalls.sh
>  bisect run failed:
>  bisect_good exited with error code 1
>
> although the command "make -j64 kernel/" returns with 0.
>
> i have to write a script around "make -j64 kernel/" to get this to work
> - it would be nice to have this "out of box".

It seems to work for me. After creating a .config, I did:

$ git bisect good v2.6.23
$ git bisect bad HEAD
$ git bisect run make -j64 kernel/

Then I had to answer some configuration questions (I hit <enter>  everytime=
)=20
but it run fine.

My git version is:

git version 1.5.3.7.2200.g9275-dirty

I attached the log (from git bisect log) and here is the end of the=20
bisection:


Bisecting: 74 revisions left to test after this
[09f3eca2b7e2762e223fdd359f9d0f6303a85f6c] Merge branch 'for-2.6.24' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc
running make -j64 kernel/
scripts/kconfig/conf -s arch/x86/Kconfig
#
# configuration written to .config
#
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/x86/kernel/asm-offsets.s
  GEN     include/asm-x86/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC      kernel/sched.o
  CC      kernel/fork.o
  CC      kernel/panic.o
  CC      kernel/printk.o
  CC      kernel/profile.o
  CC      kernel/exec_domain.o
  CC      kernel/exit.o
  CC      kernel/itimer.o
  CC      kernel/time.o
  CC      kernel/softirq.o
  CC      kernel/resource.o
  CC      kernel/sysctl.o
  CC      kernel/capability.o
  CC      kernel/ptrace.o
  CC      kernel/timer.o
  CC      kernel/user.o
  CC      kernel/signal.o
  CC      kernel/sys.o
  CC      kernel/kmod.o
  CC      kernel/user_namespace.o
  CC      kernel/pid.o
  CC      kernel/rcupdate.o
  CC      kernel/workqueue.o
  CC      kernel/params.o
  CC      kernel/posix-timers.o
  CC      kernel/kthread.o
  CC      kernel/kfifo.o
  CC      kernel/posix-cpu-timers.o
  CC      kernel/mutex.o
  CC      kernel/hrtimer.o
  CC      kernel/rwsem.o
  CC      kernel/latency.o
  CC      kernel/nsproxy.o
  CC      kernel/extable.o
  CC      kernel/wait.o
  CC      kernel/utsname.o
  CC      kernel/notifier.o
  CC      kernel/sysctl_check.o
  CC      kernel/futex.o
  CC      kernel/srcu.o
  CC      kernel/irq/handle.o
  CC      kernel/power/main.o
  CC      kernel/power/pm.o
  CC      kernel/time/timekeeping.o
  CC      kernel/power/process.o
  CC      kernel/irq/manage.o
  CC      kernel/time/ntp.o
  CC      kernel/irq/spurious.o
  CC      kernel/time/jiffies.o
  CC      kernel/time/clockevents.o
  CC      kernel/time/timer_list.o
  CC      kernel/time/tick-common.o
  CC      kernel/rtmutex.o
  CC      kernel/dma.o
  CC      kernel/cpu.o
  CC      kernel/power/console.o
  CC      kernel/irq/resend.o
  CC      kernel/power/poweroff.o
  CC      kernel/irq/chip.o
  CC      kernel/irq/devres.o
  CC      kernel/time/clocksource.o
  CC      kernel/time/tick-broadcast.o
  CC      kernel/irq/proc.o
  CC      kernel/irq/autoprobe.o
  CC      kernel/irq/migration.o
  CC      kernel/uid16.o
  CC      kernel/spinlock.o
  CC      kernel/module.o
  CC      kernel/acct.o
  CC      kernel/kexec.o
  CC      kernel/stop_machine.o
  CC      kernel/kallsyms.o
  CC      kernel/audit.o
  CC      kernel/auditfilter.o
  CC      kernel/ksysfs.o
kernel/power/pm.c:205: warning: 'pm_register' is deprecated (declared at=20
kernel/power/pm.c:64)
kernel/power/pm.c:205: warning: 'pm_register' is deprecated (declared at=20
kernel/power/pm.c:64)
kernel/power/pm.c:206: warning: 'pm_send_all' is deprecated (declared at=20
kernel/power/pm.c:180)
kernel/power/pm.c:206: warning: 'pm_send_all' is deprecated (declared at=20
kernel/power/pm.c:180)
  CC      kernel/utsname_sysctl.o
  LD      kernel/power/built-in.o
  LD      kernel/irq/built-in.o
  LD      kernel/time/built-in.o
  LD      kernel/built-in.o
Bisecting: 38 revisions left to test after this
[e17587b5b90da78f56c7a948e54dbac3dc791f31] Merge branch 'for-linus' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/hskinnemoen/avr32-2.6
running make -j64 kernel/
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
Bisecting: 17 revisions left to test after this
[c32bc6e9b0778c891f7f3b97cd05c8cdf98b6721] e1000: fix memcpy in=20
e1000_get_strings
running make -j64 kernel/
scripts/kconfig/conf -s arch/x86/Kconfig
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC      kernel/sched.o
  CC      kernel/hrtimer.o
  CC      kernel/time/clockevents.o
  LD      kernel/time/built-in.o
  LD      kernel/built-in.o
Bisecting: 8 revisions left to test after this
[4696c3c406a8b32112f8e1f70b3db1114950dcb1] ibm_newemac: Correct opb_bus_fre=
q=20
value
running make -j64 kernel/
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
Bisecting: 4 revisions left to test after this
[7962024e9d16e9349d76b553326f3fa7be64305e] S2io: Check for register=20
initialization completion before accesing device registers
running make -j64 kernel/
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
Bisecting: 2 revisions left to test after this
[d1aa690a7d1afa673c3383bfcd6e96ddb350939a] ata_piix: add Toshiba Tecra M4 t=
o=20
broken suspend list
running make -j64 kernel/
scripts/kconfig/conf -s arch/x86/Kconfig
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
Bisecting: 1 revisions left to test after this
[459ad68893a84fb0881e57919340b97edbbc3dc7] libata: kill spurious NCQ=20
completion detection
running make -j64 kernel/
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
94545baded0bfbabdc30a3a4cb48b3db479dd6ef is first bad commit
bisect run success

It found the HEAD as the first bad commit as expected, because I had no=20
compilation error.

Christian.





--Boundary-00=_w43WHZw8lVYxRyc
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="make_j64_kernel_bisect.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="make_j64_kernel_bisect.log"

git-bisect start
# good: [bbf25010f1a6b761914430f5fca081ec8c7accd1] Linux 2.6.23
git-bisect good bbf25010f1a6b761914430f5fca081ec8c7accd1
# bad: [94545baded0bfbabdc30a3a4cb48b3db479dd6ef] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev
git-bisect bad 94545baded0bfbabdc30a3a4cb48b3db479dd6ef
# good: [92d15c2ccbb3e31a3fc71ad28fdb55e1319383c0] Merge branch 'for-linus' of git://git.kernel.dk/data/git/linux-2.6-block
git-bisect good 92d15c2ccbb3e31a3fc71ad28fdb55e1319383c0
# good: [c09b360a2b0779e08bacb88d3fcd8458ebc49658] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev
git-bisect good c09b360a2b0779e08bacb88d3fcd8458ebc49658
# good: [6fa02839bf9412e18e773d04e96182b4cd0b5d57] nfsd4: recheck for secure ports in fh_verify
git-bisect good 6fa02839bf9412e18e773d04e96182b4cd0b5d57
# good: [b5faa4b89e4d83203b1f44f143a351b518f7cda2] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/cooloney/blackfin-2.6
git-bisect good b5faa4b89e4d83203b1f44f143a351b518f7cda2
# good: [c99da91e7a12724127475a85cc7a38214b3504e2] Merge branch 'master' into upstream-fixes
git-bisect good c99da91e7a12724127475a85cc7a38214b3504e2
# good: [131b17d42de6194fa960132c1f62c29923c4f20c] spi: initial BF54x SPI support
git-bisect good 131b17d42de6194fa960132c1f62c29923c4f20c
# good: [09f3eca2b7e2762e223fdd359f9d0f6303a85f6c] Merge branch 'for-2.6.24' of git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc
git-bisect good 09f3eca2b7e2762e223fdd359f9d0f6303a85f6c
# good: [e17587b5b90da78f56c7a948e54dbac3dc791f31] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hskinnemoen/avr32-2.6
git-bisect good e17587b5b90da78f56c7a948e54dbac3dc791f31
# good: [c32bc6e9b0778c891f7f3b97cd05c8cdf98b6721] e1000: fix memcpy in e1000_get_strings
git-bisect good c32bc6e9b0778c891f7f3b97cd05c8cdf98b6721
# good: [4696c3c406a8b32112f8e1f70b3db1114950dcb1] ibm_newemac: Correct opb_bus_freq value
git-bisect good 4696c3c406a8b32112f8e1f70b3db1114950dcb1
# good: [7962024e9d16e9349d76b553326f3fa7be64305e] S2io: Check for register initialization completion before accesing device registers
git-bisect good 7962024e9d16e9349d76b553326f3fa7be64305e
# good: [d1aa690a7d1afa673c3383bfcd6e96ddb350939a] ata_piix: add Toshiba Tecra M4 to broken suspend list
git-bisect good d1aa690a7d1afa673c3383bfcd6e96ddb350939a
# good: [459ad68893a84fb0881e57919340b97edbbc3dc7] libata: kill spurious NCQ completion detection
git-bisect good 459ad68893a84fb0881e57919340b97edbbc3dc7

--Boundary-00=_w43WHZw8lVYxRyc--
