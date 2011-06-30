From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the security-testing tree with the 
 tree
Date: Thu, 30 Jun 2011 14:29:10 +1000
Message-ID: <20110630142910.2fea4257.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__30_Jun_2011_14_29_10_+1000_bVTEKV1TNToCoMCY"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@vger.kernel.org, Linus <torvalds@linux-foundation.org>
To: James Morris <jmorris@namei.org>
X-From: linux-next-owner@vger.kernel.org Thu Jun 30 06:29:40 2011
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1Qc8sm-0002W4-FH
	for glkn-linux-next@lo.gmane.org; Thu, 30 Jun 2011 06:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab1F3E3W (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Thu, 30 Jun 2011 00:29:22 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:55053 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab1F3E3V (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Thu, 30 Jun 2011 00:29:21 -0400
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id 18D67144B83;
	Thu, 30 Jun 2011 14:29:16 +1000 (EST)
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.24.4; i486-pc-linux-gnu)
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176469>

--Signature=_Thu__30_Jun_2011_14_29_10_+1000_bVTEKV1TNToCoMCY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

Today's linux-next merge of the security-testing tree produced a large
number of conflicts in files not modified by the security-testing tree.
I assume that this is a bug in "git merge" but I cannot complete the
merge as such.

I have used the security-testing tree from next-20110628 for today.

More information for the git experts:

The security-testing tree is at
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6.=
git
and I am trying to merge branch "next" into linux-next at commit
9fd8fab5e299a ("Merge remote-tracking branch 'voltage/for-next'").

I can merge commit 0e4ae0e0dec6 ("TOMOYO: Make several options
configurable") from the security testing tree without conflict and also
commit 25e75dff519b ("AppArmor: Fix masking of capabilities in complain
mode").

I cannot merge commit bcd05ca10420 ("Merge branch 'for-security' of
git://git.kernel.org/pub/scm/linux/kernel/git/jj/apparmor-dev into next")
which is the child of the above two commits.

The tree to commit 25e75dff519b only containes two simple commits
(modifying 2 files) and is based on v3.0-rc5.  The tree to commit
bcd05ca10420 containes several commits and is based on commit
06e86849cf40 ("Merge branch 'pm-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6") from
Linus' tree (between v3.0-rc2 and v3.0-rc2).

After attempting the merge I get this:

$ git status
# On branch master
# Changes to be committed:
#
#	deleted:    Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870
#	modified:   Documentation/accounting/cgroupstats.txt
#	modified:   Documentation/cgroups/blkio-controller.txt
#	modified:   Documentation/cgroups/cgroups.txt
#	modified:   Documentation/cgroups/cpuacct.txt
#	modified:   Documentation/cgroups/cpusets.txt
	.
	.	[lots elided]
	.
#	modified:   tools/perf/util/PERF-VERSION-GEN
#	modified:   tools/perf/util/trace-event-parse.c
#
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      arch/arm/mach-shmobile/board-ag5evm.c
#	both modified:      arch/arm/mm/context.c
#	both modified:      arch/arm/mm/proc-v7.S
#	both modified:      arch/arm/plat-mxc/devices/platform-imx-dma.c
#	both modified:      arch/arm/plat-s5p/include/plat/map-s5p.h
#	both modified:      arch/m68k/Kconfig.nommu
#	both modified:      block/blk-throttle.c
#	both modified:      drivers/gpu/drm/nouveau/nouveau_fence.c
#	deleted by them:    drivers/net/usb/kalmia.c
#	both modified:      drivers/net/wireless/iwlegacy/iwl-dev.h
#	both modified:      drivers/net/wireless/iwlegacy/iwl4965-base.c
#	both modified:      drivers/net/wireless/iwlwifi/iwl-agn-rxon.c
#	both modified:      drivers/net/wireless/iwlwifi/iwl-agn.c
#	both modified:      drivers/net/wireless/rtlwifi/pci.c
#	deleted by them:    drivers/video/backlight/adp8870_bl.c
#	both modified:      fs/namei.c
#	both modified:      fs/nfs/nfs4proc.c
#	both modified:      fs/nfs/pnfs.c
#	both modified:      fs/proc/base.c
#	both modified:      net/bluetooth/rfcomm/sock.c
#	both modified:      net/ipv4/ip_output.c
#	both modified:      net/netfilter/ipvs/ip_vs_core.c
#	both modified:      sound/pci/hda/patch_via.c
#	both modified:      sound/soc/codecs/ad1836.h
#	both modified:      sound/soc/soc-cache.c
#

None of the "Unmerged paths" are modified in the tree I am merging in.

The linux-next tree will be published later today and James' tree is
available already (I can publis my copy of it if James modifies his).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__30_Jun_2011_14_29_10_+1000_bVTEKV1TNToCoMCY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOC/uWAAoJEDMEi1NhKgbsQFkH/RrLSNYUWZK25hIoBVYD8Gwm
ImLWa+VnKW26C55oWNvSPdN26LfnaODhUSs7PRIjDaIOjThLOAmHnpNhlsgjJZ6X
u2od5zv3mbOybgy7QbWsHliTJoag9E0VX64K8PuNsh+rm/9KPeDiY9RnK6YcoyrB
ydi8TN7XvvIuu+X79Sxu5/d6WOMgn+5nJnTzQh6WnpEeYnPgBfhfJ0ddszWC84EU
uG2D9ugpcr1XLL0na/OJuROHleM6cW8JVWJxcS0GQCOOUc6D/rg6+z6cgsn+/4X6
15wj/3BjgDhbfo9YYlP6ai33bvYaQiWrsZtdpLtRbJEqTzW1OOILfYYwTV9gDck=
=C6Zn
-----END PGP SIGNATURE-----

--Signature=_Thu__30_Jun_2011_14_29_10_+1000_bVTEKV1TNToCoMCY--
