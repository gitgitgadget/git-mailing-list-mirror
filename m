From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: linux-next: manual merge of the security-testing tree with the
 tree
Date: Thu, 30 Jun 2011 09:25:59 +0200
Message-ID: <20110630072559.GA4048@pengutronix.de>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Morris <jmorris@namei.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	Linus <torvalds@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: linux-next-owner@vger.kernel.org Thu Jun 30 09:26:08 2011
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1QcBdW-0003kH-Ld
	for glkn-linux-next@lo.gmane.org; Thu, 30 Jun 2011 09:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988Ab1F3H0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glkn-linux-next@m.gmane.org>);
	Thu, 30 Jun 2011 03:26:05 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36964 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab1F3H0E (ORCPT
	<rfc822;linux-next@vger.kernel.org>); Thu, 30 Jun 2011 03:26:04 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1QcBdR-0007kg-Vs; Thu, 30 Jun 2011 09:26:01 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.76)
	(envelope-from <ukl@pengutronix.de>)
	id 1QcBdP-0001Yf-3t; Thu, 30 Jun 2011 09:25:59 +0200
Content-Disposition: inline
In-Reply-To: <20110630142910.2fea4257.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-next@vger.kernel.org
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176478>

On Thu, Jun 30, 2011 at 02:29:10PM +1000, Stephen Rothwell wrote:
> Hi James,
>=20
> Today's linux-next merge of the security-testing tree produced a larg=
e
> number of conflicts in files not modified by the security-testing tre=
e.
> I assume that this is a bug in "git merge" but I cannot complete the
> merge as such.
>=20
> I have used the security-testing tree from next-20110628 for today.
>=20
> More information for the git experts:
>=20
> The security-testing tree is at
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testin=
g-2.6.git
> and I am trying to merge branch "next" into linux-next at commit
> 9fd8fab5e299a ("Merge remote-tracking branch 'voltage/for-next'").
>=20
> I can merge commit 0e4ae0e0dec6 ("TOMOYO: Make several options
> configurable") from the security testing tree without conflict and al=
so
> commit 25e75dff519b ("AppArmor: Fix masking of capabilities in compla=
in
> mode").
>=20
> I cannot merge commit bcd05ca10420 ("Merge branch 'for-security' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jj/apparmor-dev into ne=
xt")
> which is the child of the above two commits.
>=20
> The tree to commit 25e75dff519b only containes two simple commits
> (modifying 2 files) and is based on v3.0-rc5.  The tree to commit
> bcd05ca10420 containes several commits and is based on commit
> 06e86849cf40 ("Merge branch 'pm-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6") fr=
om
> Linus' tree (between v3.0-rc2 and v3.0-rc2).
>=20
> After attempting the merge I get this:
>=20
> $ git status
> # On branch master
> # Changes to be committed:
> #
> #	deleted:    Documentation/ABI/testing/sysfs-class-backlight-driver-=
adp8870
> #	modified:   Documentation/accounting/cgroupstats.txt
> #	modified:   Documentation/cgroups/blkio-controller.txt
> #	modified:   Documentation/cgroups/cgroups.txt
> #	modified:   Documentation/cgroups/cpuacct.txt
> #	modified:   Documentation/cgroups/cpusets.txt
> 	.
> 	.	[lots elided]
> 	.
> #	modified:   tools/perf/util/PERF-VERSION-GEN
> #	modified:   tools/perf/util/trace-event-parse.c
> #
> # Unmerged paths:
> #   (use "git add/rm <file>..." as appropriate to mark resolution)
> #
> #	both modified:      arch/arm/mach-shmobile/board-ag5evm.c
> #	both modified:      arch/arm/mm/context.c
> #	both modified:      arch/arm/mm/proc-v7.S
> #	both modified:      arch/arm/plat-mxc/devices/platform-imx-dma.c
> #	both modified:      arch/arm/plat-s5p/include/plat/map-s5p.h
> #	both modified:      arch/m68k/Kconfig.nommu
> #	both modified:      block/blk-throttle.c
> #	both modified:      drivers/gpu/drm/nouveau/nouveau_fence.c
> #	deleted by them:    drivers/net/usb/kalmia.c
> #	both modified:      drivers/net/wireless/iwlegacy/iwl-dev.h
> #	both modified:      drivers/net/wireless/iwlegacy/iwl4965-base.c
> #	both modified:      drivers/net/wireless/iwlwifi/iwl-agn-rxon.c
> #	both modified:      drivers/net/wireless/iwlwifi/iwl-agn.c
> #	both modified:      drivers/net/wireless/rtlwifi/pci.c
> #	deleted by them:    drivers/video/backlight/adp8870_bl.c
> #	both modified:      fs/namei.c
> #	both modified:      fs/nfs/nfs4proc.c
> #	both modified:      fs/nfs/pnfs.c
> #	both modified:      fs/proc/base.c
> #	both modified:      net/bluetooth/rfcomm/sock.c
> #	both modified:      net/ipv4/ip_output.c
> #	both modified:      net/netfilter/ipvs/ip_vs_core.c
> #	both modified:      sound/pci/hda/patch_via.c
> #	both modified:      sound/soc/codecs/ad1836.h
> #	both modified:      sound/soc/soc-cache.c
> #
>=20
> None of the "Unmerged paths" are modified in the tree I am merging in=
=2E
Hmm, looking at bcd05ca10420 and the difference to its first parent:

	$ git diff --stat bcd05ca10420^ bcd05ca10420
	<void>

	$ git describe bcd05ca10420
	v3.0-rc5-28-gbcd05ca

	$ git describe bcd05ca10420^
	v3.0-rc2-221-g0e4ae0e

So commit bcd05ca10420 reverted many commits between v3.0-rc2 and v3.0-=
rc5.

If I redo what should have been done in bcd05ca10420 and compare with
bcd05ca10420:

	git checkout bcd05ca10420^
	git merge bcd05ca10420^2
	git diff --stat bcd05ca10420

I get the same list of touched files as you above.

Long history short: James probably used -s ours or similar and it's fin=
e
not to merge that commit into next :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
