From: Pete/Piet Delaney <pete@bluelane.com>
Subject: git-cvsimport - losing changes in subsequent pulls of a CVS branch
 that I thought I wasn't modifying in the GIT repo.
Date: Tue, 19 Aug 2008 00:00:30 -0700
Organization: Bluelane
Message-ID: <48AA6F8E.70807@bluelane.com>
Reply-To: piet@bluelane.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig712B2875BE6605E320C0B423"
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Piet Delaney <piet.delaney@gmail.com>,
	Piet Delaney <pdelaney@bluelane.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:08:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLJr-00053u-FF
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbYHSHGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbYHSHGt
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:06:49 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:30666 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751716AbYHSHGs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 03:06:48 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Aug 2008 03:06:47 EDT
Received: from piet2.bluelane.com ([64.94.92.242]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 Aug 2008 03:00:34 -0400
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
X-Enigmail-Version: 0.95.7
X-OriginalArrivalTime: 19 Aug 2008 07:00:35.0173 (UTC) FILETIME=[4738D150:01C901C9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92817>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig712B2875BE6605E320C0B423
Content-Type: multipart/mixed;
 boundary="------------050709080306010700090906"

This is a multi-part message in MIME format.
--------------050709080306010700090906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'm running into a problem with git-cvsimport. The last
import went fine; in that case the import was a new
branch to the cvs repo ('virtualshield_saflow').

In this new case the cvs branch was modified. I thought
I hadn't modified this branch, but only merged it into
other branches (that unfortunately were in the cvs repo).
We haven't checked anything into those branches so it seems
like that mistake isn't/wasn't causing problems.

This recent merge appears to be discarding changes that
I've made in the git repo. The merge seems to default to
a repo without the changes.


The command I used to import the 'virtualshield_saflow' branch
from the CVS repo was:


    git-cvsimport -o virtualshield_saflow -r origin blux

I can't find my notes on the for I used last time, but as
I recall I didn't have to use both the -o and -r options.

It appeared that a few changes were missing and it seemed like
the problem was resolved last time by doing a second cvsimport.

This third git-cvsimport proceeded without any errors. The output seemed
to show changes in most of the files involved since the creating
of the 'virtualshield_saflow' branch (2nd cvsimport), not just
the recent changes (just a few files).

Attaching the log during the cvsimport.

I'll take another stab at it tomarrow. Any thoughts or
recommendations appreciated.

-piet

--------------050709080306010700090906
Content-Type: text/plain;
 name="git-cvs_import"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="git-cvs_import"

/nethome/piet/src/kilo/blux.prev$ git branch -a
* master
  origin/HEAD
  origin/beta1_branch
  origin/echo_branch
  origin/engg
  origin/integrated_branch
  origin/master
  origin/mg250_branch
  origin/origin
  origin/port_redirect_branch
  origin/rc1_branch
  origin/rel1_0_branch
  origin/rel2_branch
  origin/test_version_branch
  origin/upgrade_test
  origin/vendor_tag
  origin/virtualshield_saflow
/nethome/piet/src/kilo/blux.prev$ git-cvsimport -o virtualshield_saflow -=
r origin blux
Generating pack...
Counting objects: 19166
Done counting 21689 objects.
Deltifying 21689 objects...
 100% (21689/21689) done
Writing 21689 objects...
 100% (21689/21689) done
Total 21689 (delta 13062), reused 21181 (delta 12718)
Pack pack-d58901c5098e7d286b2f1c227f42019cca30558a created.
Removing unused objects 100%...
Done.
Updating 8be945b..6d2edd2
Checking 207 files out...
 100% (207/207) done
Fast forward
 .gitignore                                         |  111 +
 .toolchain.revisions                               |   32 -
 Makefile                                           |   37 +-
 README                                             |    2 -
 cli/quagga-0.96/lib/bluelane.c                     |   21 +-
 cli/quagga-0.96/lib/bluelane.h                     |    4 +
 cli/quagga-0.96/lib/dbg.h                          |    2 -
 cli/quagga-0.96/vtysh/vtysh_bluelane.c             |  224 +-
 cli/quagga-0.96/zebra/interface.c                  |   11 +-
 cli/quagga-0.96/zebra/zebra_bluelane.c             |   43 +-
 doit                                               |    2 +-
 doit.fast                                          |   12 +
 .../blue_lane/bin/config_remote_syslog_server.pl   |   50 -
 files/common/blue_lane/bin/getsystemtype.pl        |  107 +-
 files/common/blue_lane/bin/image_name.pl           |  700 +-
 files/common/blue_lane/bin/install_image.pl        |   44 +-
 files/common/blue_lane/bin/show-ethernet           |   11 +
 files/common/blue_lane/bin/show-stacktrace         |   82 +-
 files/common/blue_lane/bin/slottools.pl            |   21 +-
 files/common/blue_lane/bin/syslog_conf.pl          |  118 +-
 files/common/blue_lane/bin/techsupport.pl          |    1 +
 files/common/blue_lane/default_files/passwd        |    1 +
 files/common/blue_lane/license.txt                 |    3 +-
 files/common/common/etc/passwd                     |    1 +
 files/common/etc/logrotate.conf                    |    6 +-
 files/common/etc/passwd                            |    1 +
 files/common/etc/rc.d/init.d/bluelane              |   19 +-
 files/common/etc/rc.d/init.d/syslog-ng             |   29 +
 files/common/etc/rc.d/rc3.d/.symlinks              |    1 +
 files/common/etc/shadow                            |    1 +
 files/common/etc/syslog-ng.conf                    |   50 +
 files/common/etc/syslog.conf                       |    2 -
 files/distributor/fsscan.log                       |    1 -
 .../blue_lane/configs/system.info.g650             |  103 +
 files/gateway/fsscan.log                           |    1 -
 files/manager/fsscan.log                           |    1 -
 .../mg/custom_files/blue_lane/bin/db-reinstall.sh  |    5 +-
 .../custom_files/blue_lane/bin/gen_vmwall_logs.sh  |    9 +
 .../custom_files/blue_lane/bin/gen_vmwall_stats.sh |    9 +
 files/mg/custom_files/blue_lane/bin/kernel_bypass  |  153 +
 .../custom_files/blue_lane/bin/print_vmwall_rules  |  217 +
 files/mg/custom_files/blue_lane/bin/vmwall_rules   |   26 +
 .../blue_lane/bin/vmwall_server_state_lookup.pl    |  167 +
 .../blue_lane/configs/system.info.g250             |    4 +-
 .../blue_lane/configs/system.info.g250.revB        |    2 +-
 .../blue_lane/configs/system.info.g450             |    2 +-
 .../blue_lane/configs/system.info.g650             |  103 +
 .../custom_files/blue_lane/configs/system.info.m10 |    2 +-
 .../custom_files/blue_lane/configs/system.info.vg  |    2 +-
 .../custom_files/blue_lane/configs/system.info.vm  |    2 +-
 .../blue_lane/configs/system.info.vmware           |    2 +-
 .../blue_lane/default_files/zebra.conf.g650        |   33 +
 .../mg/custom_files/etc/rc.d/init.d/bl_catalina.sh |    2 +-
 .../custom_files/etc/rc.d/init.d/bluelane-gateway  |   19 +-
 .../custom_files/etc/rc.d/init.d/bluelane-vmwall   |   58 +
 files/mg/custom_files/etc/rc.d/init.d/crash        |   26 +
 .../custom_files/etc/rc.d/init.d/gateway-startup   |   62 +-
 .../custom_files/etc/rc.d/init.d/irq-affinity.pl   |   56 +-
 files/mg/custom_files/etc/rc.d/init.d/rc           |  126 +
 files/mg/custom_files/etc/rc.d/rc.local            |    2 +
 files/mg/custom_files/etc/rc.d/rc1.d/.symlinks     |    1 +
 files/mg/custom_files/etc/rc.d/rc1.d/S01crash      |    1 +
 files/mg/custom_files/etc/rc.d/rc3.d/.symlinks     |    1 +
 files/mg/custom_files/etc/rc.d/rc3.d/S01crash      |    1 +
 files/mg/custom_files/etc/rc.d/rc6.d/.symlinks     |    1 +
 files/mg/custom_files/home/secureall/.ssh/id_rsa   |   15 +
 files/mg/custom_files/home/secureall/.ssh/identity |  Bin 0 -> 536 bytes=

 files/mg/custom_files/root/.ssh/authorized_keys    |    2 +
 files/mg/custom_files/root/cat-ip-conntrack.sh     |   66 +
 files/mg/fsscan.log                                |  547 +-
 files/mg/install_script                            |   16 +-
 files/mg/setup_version                             |    8 +-
 .../custom_files/blue_lane/configs/system.info     |    2 +-
 .../blue_lane/configs/system.info.g250             |    2 +-
 .../blue_lane/configs/system.info.g450             |    2 +-
 .../blue_lane/configs/system.info.g650             |  103 +
 .../blue_lane/configs/system.info.m10.0            |    2 +-
 .../blue_lane/configs/system.info.m10.1            |    2 +-
 files/recovery/fsscan.log                          |    1 -
 packages/Makefile.rules                            |   11 +-
 packages/Orbit2/Makefile.ORBit2-2.14.7_1st_attempt |   24 +
 packages/Orbit2/ORBit2-2.14.7.tar.bz2              |  Bin 0 -> 729469 by=
tes
 packages/bypass/Makefile                           |    2 +-
 packages/crash/Makefile                            |   10 +-
 packages/crash/crash-4.0-5.1.tar.bz2               |  Bin 0 -> 17748934 =
bytes
 packages/eventlog/Makefile                         |   11 +
 packages/eventlog/eventlog-0.2.7.tar.gz            |  Bin 0 -> 322603 by=
tes
 packages/gdb/Makefile                              |    2 +-
 packages/gdb/gdb-6.8.tar.bz2                       |  Bin 0 -> 15581304 =
bytes
 packages/git/Makefile                              |   11 +
 packages/git/git-1.5.4.2.tar.bz2                   |  Bin 0 -> 1586823 b=
ytes
 packages/glib-1.2.10/Makefile                      |   17 +
 packages/glib-1.2.10/README                        |    3 +
 packages/glib-1.2.10/glib-1.2.10-gcc34-1.patch     |   19 +
 packages/glib-1.2.10/glib-1.2.10.tar.gz            |  Bin 0 -> 421480 by=
tes
 packages/glib-2.4.1/Makefile                       |   17 +
 packages/{glib =3D> glib-2.4.1}/glib-2.4.1.tar.bz2   |  Bin 2028551 -> 2=
028551 bytes
 packages/glib/Makefile                             |    2 +-
 packages/glib/README                               |    9 +
 packages/glib/glib-2.12.12.tar.bz2                 |  Bin 0 -> 2938743 b=
ytes
 packages/glibc/.gitignore                          |    7 +
 packages/glibc/.symlinks                           |    6 +-
 packages/glibc/Makefile                            |   23 +-
 packages/glibc/Makefile.glibc-2.3.4-20040701       |   41 +
 packages/glibc/doit                                |   10 +
 packages/glibc/glib-2.12.12.tar.bz2                |  Bin 0 -> 2938743 b=
ytes
 packages/gtk/Makefile                              |   17 +
 packages/gtk/README                                |    4 +
 packages/gtk/gtk+-1.2.10.tar.bz2                   |  Bin 0 -> 2248777 b=
ytes
 packages/iptables/Makefile                         |   24 +-
 packages/iptables/README                           |    8 +
 packages/iptables/doit                             |    9 +
 packages/iptables/iptables-1.3.2.tar.bz2           |  Bin 186255 -> 0 by=
tes
 packages/iptables/iptables-1.3.6.tar.bz2           |  Bin 0 -> 185438 by=
tes
 packages/iptables/iptables-1.3.8.tar.bz2           |  Bin 0 -> 172584 by=
tes
 packages/irqbalance/Makefile                       |   24 +
 packages/irqbalance/Makefile.irqbalance-0.55       |   22 +
 packages/irqbalance/classify.c                     |  126 +
 packages/irqbalance/doit                           |    9 +
 packages/irqbalance/irqbalance-0.55.tar.bz2        |  Bin 0 -> 19055 byt=
es
 packages/kexec-tools/Makefile                      |   37 +
 packages/kexec-tools/Makefile.kexec-tools-1.101    |   12 +
 packages/kexec-tools/doit                          |    9 +
 packages/kexec-tools/kexec-tools-1.101.tar.bz2     |  Bin 0 -> 172107 by=
tes
 packages/kexec-tools/kexec-tools-testing.tar.bz2   |  Bin 0 -> 828793 by=
tes
 packages/libIDL/Makefile                           |    2 +-
 packages/libIDL/libIDL-0.8.8.tar.bz2               |  Bin 0 -> 335188 by=
tes
 packages/libnet/Makefile                           |   11 +
 packages/libnet/libnet-1.1.2.1.tar.gz              |  Bin 0 -> 1021236 b=
ytes
 packages/libxml2/Makefile                          |    2 +-
 packages/libxml2/libxml2-2.6.31.tar.bz2            |  Bin 0 -> 3641593 b=
ytes
 packages/linux/Makefile                            |   75 +-
 packages/lmsensors/Makefile                        |   13 +-
 packages/lmsensors/README                          |    5 +
 packages/lmsensors/lm_sensors-3.0.1.tar.bz2        |  Bin 0 -> 186183 by=
tes
 packages/lmsensors/sensors3.conf.new               | 2450 ++++
 packages/n2261-r6d/Makefile                        |    3 +-
 packages/nfs-utils/Makefile                        |   15 +
 packages/nfs-utils/nfs-utils-1.0.10.tar.bz2        |  Bin 0 -> 528352 by=
tes
 packages/openssh/openssh-3.8.1p1.tar.bz2           |  Bin 657788 -> 6645=
06 bytes
 packages/pci-utilities/Makefile                    |   13 +-
 packages/pci-utilities/pci.ids                     |14949 ++++++++++++++=
++++++
 packages/pci-utilities/pciutils-2.2.3.tar.bz2      |  Bin 0 -> 1115369 b=
ytes
 packages/perl/Makefile                             |    8 +
 packages/perl/packages/Expect-1.21.tar.gz          |  Bin 0 -> 53881 byt=
es
 packages/perl/packages/IO-Tty-1.07.tar.gz          |  Bin 0 -> 22004 byt=
es
 packages/perl/packages/Net-SSH-Expect-1.09.tar.gz  |  Bin 0 -> 15074 byt=
es
 packages/perl/packages/Text-ASCIITable-0.17.tar.gz |  Bin 0 -> 20647 byt=
es
 packages/pkgconfig/Makefile                        |    2 +-
 packages/pkgconfig/pkg-config-0.22.tar.bz2         |  Bin 0 -> 747667 by=
tes
 packages/portmap/Makefile                          |   16 +
 packages/portmap/doit                              |    8 +
 .../portmap-5beta-compilation_fixes-3.patch        |  705 +
 .../portmap/portmap-5beta-glibc_errno_fix-1.patch  |   17 +
 packages/portmap/portmap_5beta.tar.bz2             |  Bin 0 -> 18321 byt=
es
 .../portwell_bypass/ABN-484_development.tar.bz2    |  Bin 0 -> 115941 by=
tes
 packages/portwell_bypass/ABN478_Utility.tar.bz2    |  Bin 0 -> 105117 by=
tes
 packages/portwell_bypass/ABN_484_1st.tar.bz2       |  Bin 0 -> 121466 by=
tes
 packages/portwell_bypass/Makefile                  |   17 +
 packages/portwell_bypass/Makefile.ABN478_Utility   |   16 +
 packages/portwell_bypass/doit                      |    9 +
 packages/qt/Makefile                               |   17 +
 packages/qt/qt-x11-free-3.3.8.tar.bz2              |  Bin 0 -> 14360483 =
bytes
 packages/raidtools/Makefile                        |   11 +
 packages/raidtools/README                          |    6 +
 packages/raidtools/raidtools-1.00.3.tar.bz2        |  Bin 0 -> 137864 by=
tes
 packages/smarttools/Makefile                       |    2 +-
 packages/smarttools/README                         |    5 +
 packages/smarttools/smartmontools-5.36.tar.bz2     |  Bin 0 -> 443297 by=
tes
 packages/smarttools/smartmontools-5.37.tar.bz2     |  Bin 0 -> 478833 by=
tes
 packages/strace/Makefile                           |   13 +-
 packages/strace/doit                               |   10 +
 packages/strace/strace-4.5.16.tar.bz2              |  Bin 0 -> 457272 by=
tes
 packages/sudo/sudoers                              |    1 +
 packages/syslog-ng/Makefile                        |   12 +
 packages/syslog-ng/syslog-ng-2.0.9.tar.gz          |  Bin 0 -> 378779 by=
tes
 packages/sysmgr-daemon/link_watchd.c               |   35 +-
 packages/sysmgr-daemon/sysmgr-daemon.c             |   17 +
 packages/tcp-wrappers/Makefile                     |   41 +
 .../tcp-wrappers-7.6-patches-1.0.tar.bz2           |  Bin 0 -> 16128 byt=
es
 packages/tcp-wrappers/tcp_wrappers_7.6.tar.gz      |  Bin 0 -> 99438 byt=
es
 packages/tcp_wrappers/Makefile                     |   17 +
 packages/tcp_wrappers/doit                         |    8 +
 .../tcp_wrappers-7.6-shared_lib_plus_plus-1.patch  | 1035 ++
 packages/tcp_wrappers/tcp_wrappers_7.6.tar.bz2     |  Bin 0 -> 78615 byt=
es
 packages/tcsh/Makefile                             |   11 +
 packages/tcsh/README                               |    4 +
 packages/tcsh/tcsh-6.15.00.tar.bz2                 |  Bin 0 -> 727440 by=
tes
 packages/tomcat/updates/catalina.sh                |    7 +-
 packages/wireshark/Makefile                        |    8 +
 packages/wireshark/README                          |   12 +
 packages/wireshark/wireshark-0.99.7.tar.bz2        |  Bin 0 -> 13179467 =
bytes
 scripts/build_tarimage.pl                          |   30 +-
 scripts/majornum                                   |    2 +-
 scripts/make-release.pl                            |    2 +-
 scripts/minornum                                   |    6 +-
 scripts/params.pl                                  |   11 +
 scripts/update-sources-fm.pl                       |  268 +
 scripts/update-sources.pl                          |  327 +-
 scripts/version.pl                                 |   75 +-
 tarballs/glibc-2.3.6-inotify-1.patch               |   45 +
 tarballs/glibc-2.3.6-linux_types-1.patch           |   33 +
 tarballs/glibc-2.3.6.tar.bz2                       |  Bin 0 -> 14014977 =
bytes
 tarballs/glibc-libidn-2.3.6.tar.bz2                |  Bin 0 -> 101041 by=
tes
 toolchain/glibc/Makefile                           |    2 +-
 upgrade/install-script                             |    9 +-
 206 files changed, 23121 insertions(+), 1540 deletions(-)
 create mode 100755 .gitignore
 delete mode 100644 .toolchain.revisions
 create mode 100755 doit.fast
 delete mode 100755 files/common/blue_lane/bin/config_remote_syslog_serve=
r.pl
 create mode 100644 files/common/etc/rc.d/init.d/syslog-ng
 create mode 100644 files/common/etc/syslog-ng.conf
 delete mode 100644 files/common/etc/syslog.conf
 create mode 100644 files/gateway/custom_files/blue_lane/configs/system.i=
nfo.g650
 create mode 100755 files/mg/custom_files/blue_lane/bin/gen_vmwall_logs.s=
h
 create mode 100755 files/mg/custom_files/blue_lane/bin/gen_vmwall_stats.=
sh
 create mode 100755 files/mg/custom_files/blue_lane/bin/kernel_bypass
 create mode 100755 files/mg/custom_files/blue_lane/bin/print_vmwall_rule=
s
 create mode 100755 files/mg/custom_files/blue_lane/bin/vmwall_rules
 create mode 100755 files/mg/custom_files/blue_lane/bin/vmwall_server_sta=
te_lookup.pl
 create mode 100644 files/mg/custom_files/blue_lane/configs/system.info.g=
650
 create mode 100644 files/mg/custom_files/blue_lane/default_files/zebra.c=
onf.g650
 create mode 100755 files/mg/custom_files/etc/rc.d/init.d/bluelane-vmwall=

 create mode 100755 files/mg/custom_files/etc/rc.d/init.d/crash
 create mode 100755 files/mg/custom_files/etc/rc.d/init.d/rc
 create mode 100644 files/mg/custom_files/etc/rc.d/rc1.d/.symlinks
 create mode 120000 files/mg/custom_files/etc/rc.d/rc1.d/S01crash
 create mode 120000 files/mg/custom_files/etc/rc.d/rc3.d/S01crash
 create mode 100644 files/mg/custom_files/home/secureall/.ssh/id_rsa
 create mode 100644 files/mg/custom_files/home/secureall/.ssh/identity
 create mode 100644 files/mg/custom_files/root/.ssh/authorized_keys
 create mode 100755 files/mg/custom_files/root/cat-ip-conntrack.sh
 create mode 100644 files/recovery/custom_files/blue_lane/configs/system.=
info.g650
 create mode 100644 packages/Orbit2/Makefile.ORBit2-2.14.7_1st_attempt
 create mode 100644 packages/Orbit2/ORBit2-2.14.7.tar.bz2
 create mode 100644 packages/crash/crash-4.0-5.1.tar.bz2
 create mode 100644 packages/eventlog/Makefile
 create mode 100644 packages/eventlog/eventlog-0.2.7.tar.gz
 create mode 100644 packages/gdb/gdb-6.8.tar.bz2
 create mode 100644 packages/git/Makefile
 create mode 100644 packages/git/git-1.5.4.2.tar.bz2
 create mode 100644 packages/glib-1.2.10/Makefile
 create mode 100644 packages/glib-1.2.10/README
 create mode 100644 packages/glib-1.2.10/glib-1.2.10-gcc34-1.patch
 create mode 100644 packages/glib-1.2.10/glib-1.2.10.tar.gz
 create mode 100644 packages/glib-2.4.1/Makefile
 rename packages/{glib =3D> glib-2.4.1}/glib-2.4.1.tar.bz2 (100%)
 create mode 100644 packages/glib/README
 create mode 100644 packages/glib/glib-2.12.12.tar.bz2
 create mode 100644 packages/glibc/.gitignore
 create mode 100644 packages/glibc/Makefile.glibc-2.3.4-20040701
 create mode 100755 packages/glibc/doit
 create mode 100644 packages/glibc/glib-2.12.12.tar.bz2
 create mode 100644 packages/gtk/Makefile
 create mode 100644 packages/gtk/README
 create mode 100644 packages/gtk/gtk+-1.2.10.tar.bz2
 create mode 100644 packages/iptables/README
 create mode 100755 packages/iptables/doit
 delete mode 100644 packages/iptables/iptables-1.3.2.tar.bz2
 create mode 100644 packages/iptables/iptables-1.3.6.tar.bz2
 create mode 100644 packages/iptables/iptables-1.3.8.tar.bz2
 create mode 100644 packages/irqbalance/Makefile
 create mode 100644 packages/irqbalance/Makefile.irqbalance-0.55
 create mode 100644 packages/irqbalance/classify.c
 create mode 100755 packages/irqbalance/doit
 create mode 100644 packages/irqbalance/irqbalance-0.55.tar.bz2
 create mode 100644 packages/kexec-tools/Makefile
 create mode 100644 packages/kexec-tools/Makefile.kexec-tools-1.101
 create mode 100755 packages/kexec-tools/doit
 create mode 100644 packages/kexec-tools/kexec-tools-1.101.tar.bz2
 create mode 100644 packages/kexec-tools/kexec-tools-testing.tar.bz2
 create mode 100644 packages/libIDL/libIDL-0.8.8.tar.bz2
 create mode 100644 packages/libnet/Makefile
 create mode 100644 packages/libnet/libnet-1.1.2.1.tar.gz
 create mode 100644 packages/libxml2/libxml2-2.6.31.tar.bz2
 create mode 100644 packages/lmsensors/README
 create mode 100644 packages/lmsensors/lm_sensors-3.0.1.tar.bz2
 create mode 100644 packages/lmsensors/sensors3.conf.new
 create mode 100644 packages/nfs-utils/Makefile
 create mode 100644 packages/nfs-utils/nfs-utils-1.0.10.tar.bz2
 create mode 100644 packages/pci-utilities/pci.ids
 create mode 100644 packages/pci-utilities/pciutils-2.2.3.tar.bz2
 create mode 100644 packages/perl/packages/Expect-1.21.tar.gz
 create mode 100644 packages/perl/packages/IO-Tty-1.07.tar.gz
 create mode 100644 packages/perl/packages/Net-SSH-Expect-1.09.tar.gz
 create mode 100644 packages/perl/packages/Text-ASCIITable-0.17.tar.gz
 create mode 100644 packages/pkgconfig/pkg-config-0.22.tar.bz2
 create mode 100644 packages/portmap/Makefile
 create mode 100755 packages/portmap/doit
 create mode 100644 packages/portmap/portmap-5beta-compilation_fixes-3.pa=
tch
 create mode 100644 packages/portmap/portmap-5beta-glibc_errno_fix-1.patc=
h
 create mode 100644 packages/portmap/portmap_5beta.tar.bz2
 create mode 100644 packages/portwell_bypass/ABN-484_development.tar.bz2
 create mode 100644 packages/portwell_bypass/ABN478_Utility.tar.bz2
 create mode 100644 packages/portwell_bypass/ABN_484_1st.tar.bz2
 create mode 100644 packages/portwell_bypass/Makefile
 create mode 100644 packages/portwell_bypass/Makefile.ABN478_Utility
 create mode 100755 packages/portwell_bypass/doit
 create mode 100644 packages/qt/Makefile
 create mode 100644 packages/qt/qt-x11-free-3.3.8.tar.bz2
 create mode 100644 packages/raidtools/Makefile
 create mode 100644 packages/raidtools/README
 create mode 100644 packages/raidtools/raidtools-1.00.3.tar.bz2
 create mode 100644 packages/smarttools/README
 create mode 100644 packages/smarttools/smartmontools-5.36.tar.bz2
 create mode 100644 packages/smarttools/smartmontools-5.37.tar.bz2
 create mode 100755 packages/strace/doit
 create mode 100644 packages/strace/strace-4.5.16.tar.bz2
 create mode 100644 packages/syslog-ng/Makefile
 create mode 100644 packages/syslog-ng/syslog-ng-2.0.9.tar.gz
 create mode 100644 packages/tcp-wrappers/Makefile
 create mode 100644 packages/tcp-wrappers/tcp-wrappers-7.6-patches-1.0.ta=
r.bz2
 create mode 100644 packages/tcp-wrappers/tcp_wrappers_7.6.tar.gz
 create mode 100644 packages/tcp_wrappers/Makefile
 create mode 100755 packages/tcp_wrappers/doit
 create mode 100755 packages/tcp_wrappers/tcp_wrappers-7.6-shared_lib_plu=
s_plus-1.patch
 create mode 100644 packages/tcp_wrappers/tcp_wrappers_7.6.tar.bz2
 create mode 100644 packages/tcsh/Makefile
 create mode 100644 packages/tcsh/README
 create mode 100644 packages/tcsh/tcsh-6.15.00.tar.bz2
 create mode 100644 packages/wireshark/Makefile
 create mode 100644 packages/wireshark/README
 create mode 100644 packages/wireshark/wireshark-0.99.7.tar.bz2
 create mode 100755 scripts/update-sources-fm.pl
 create mode 100644 tarballs/glibc-2.3.6-inotify-1.patch
 create mode 100644 tarballs/glibc-2.3.6-linux_types-1.patch
 create mode 100644 tarballs/glibc-2.3.6.tar.bz2
 create mode 100644 tarballs/glibc-libidn-2.3.6.tar.bz2
/nethome/piet/src/kilo/blux.prev$


--------------050709080306010700090906--

--------------enig712B2875BE6605E320C0B423
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIqm+PJICwm/rv3hoRApdrAJ9bT4al2o4KUGu5AHfRLUkfd0zrCwCfdU1g
y6Ytw5jz8eCpamjFpUR9hq0=
=nn+Q
-----END PGP SIGNATURE-----

--------------enig712B2875BE6605E320C0B423--
