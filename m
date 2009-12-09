From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: rerere failed to parse conflict hunks
Date: Wed, 9 Dec 2009 11:00:38 +0100
Message-ID: <20091209100038.GD23236@pengutronix.de>
References: <20091209084648.GA30139@pengutronix.de> <4B1F721E.9050609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Ben Dooks <ben-linux@fluff.org>
X-From: git-owner@vger.kernel.org Wed Dec 09 11:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIJLk-0006x1-Ci
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 11:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbZLIKAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 05:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbZLIKAf
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 05:00:35 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbZLIKAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 05:00:34 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NIJLc-0005D1-RC; Wed, 09 Dec 2009 11:00:40 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NIJLa-0006x8-I7; Wed, 09 Dec 2009 11:00:38 +0100
Content-Disposition: inline
In-Reply-To: <4B1F721E.9050609@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134955>


Best regards
Uwe

On Wed, Dec 09, 2009 at 10:47:10AM +0100, Michael J Gruber wrote:
> Uwe Kleine-K=F6nig venit, vidit, dixit 09.12.2009 09:46:
> > Hello,
> >=20
> > I just tried to merge linux-next
> > (5c1af82119f11c5b322156b09d38cc37318849c4) into my private tree
> > (based on 2b876f95d03e226394b5d360c86127cbefaf614b) and this
> > happened:
> >=20
> > 	...
> > 	Removing sound/soc/au1x/sample-ac97.c
> > 	Recorded preimage for 'arch/Kconfig'
> > 	Recorded preimage for 'arch/arm/mach-s3c2440/mach-anubis.c'
> > 	Recorded preimage for 'arch/arm/plat-mxc/Makefile'
> > 	error: Could not parse conflict hunks in arch/arm/plat-s3c/dev-hsm=
mc2.c
> > 	Recorded preimage for 'arch/arm/plat-s3c/include/plat/sdhci.h'
> > 	Recorded preimage for 'arch/arm/plat-samsung/Kconfig'
> > 	Recorded preimage for 'arch/x86/include/asm/x86_init.h'
> > 	Recorded preimage for 'arch/x86/kernel/x86_init.c'
> > 	Recorded preimage for 'drivers/net/wireless/ray_cs.c'
> > 	Recorded preimage for 'kernel/Makefile'
> > 	Recorded preimage for 'kernel/power/hibernate.c'
> > 	Recorded preimage for 'net/sctp/sysctl.c'
> > 	Automatic merge failed; fix conflicts and then commit the result.
> >=20
> > If you are interested, I can provide you the two trees above.  When
> > reproducing the line "error: ..." came later, but is still present.
> >=20
> > I guess this should be reproduceable with
> >=20
> > 	git clone -n git://git.kernel.org/pub/scm/linux/kernel/git/torvald=
s/linux-2.6.git
> > 	cd linux-2.6
> > 	git remote add -f next git://git.kernel.org/pub/scm/linux/kernel/g=
it/next/linux-next.git
> > 	git checkout 2b876f95d03e226394b5d360c86127cbefaf614b
> > 	git merge 5c1af82119f11c5b322156b09d38cc37318849c4
> >=20
> > I havn't tried though.
> >=20
> > The only non-trivial conflict is:
> >=20
> > 	#include <plat/sdhci.h>
> > 	#include <plat/devs.h>
> > 	<<<<<<< HEAD
> > 	=3D=3D=3D=3D=3D=3D=3D
> > 	<<<<<<< HEAD
> > 	#include <plat/cpu.h>
> > 	=3D=3D=3D=3D=3D=3D=3D
> > 	>>>>>>> next-s5pc1xx
> > 	>>>>>>> next/master
> >=20
>=20
> Someone committed a file with conflict markers. Bad bad boy. I guess
> a8c4f01 (fixup sdhci merge failure, 2009-11-23) did not quite what it
> promised.
obviously, yes.

Ben, you might want to redo commit a8c4f018ba69266aeb3cccf73c36b6663189=
e730

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
