From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [FAILED] BLD phyCORE-i.MX35 + linux-next git kernel
Date: Wed, 7 Jul 2010 08:47:35 +0200
Message-ID: <20100707064735.GE2502@pengutronix.de>
References: <E1OVsw1-0006iT-LS@himalia.hi.pengutronix.de> <20100706152246.GB2502@pengutronix.de> <20100707114858.e52cec1b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de
To: Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 08:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWOQ9-0003Qe-KL
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 08:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab0GGGro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 02:47:44 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40067 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab0GGGrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 02:47:43 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OWOPw-0003KW-7D; Wed, 07 Jul 2010 08:47:36 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OWOPv-0004D9-CE; Wed, 07 Jul 2010 08:47:35 +0200
Content-Disposition: inline
In-Reply-To: <20100707114858.e52cec1b.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150453>

Hi,

On Wed, Jul 07, 2010 at 11:48:58AM +1000, Stephen Rothwell wrote:
> Hi Uwe,
>=20
> On Tue, 6 Jul 2010 17:22:46 +0200 Uwe Kleine-K=F6nig <u.kleine-koenig=
@pengutronix.de> wrote:
> >
> > our -next autobuilder barfs:
> >=20
> > On Mon, Jul 05, 2010 at 11:10:37PM +0200, Pengutronix Sisyphus Drui=
d wrote:
> > > ...
> > >                               Source URL .... git://git.kernel.or=
g/pub/scm/linux/kernel/git/sfr/linux-next.git
> > >                         Current git hash .... 288092896e2097eebee=
7d4bf1df9a0c7b550e225
> > >                     Kernel configuration .... use config: mx3_def=
config
> > >                             Kernel build .... [FAILED]
> > > ...
> > >   CC      arch/arm/mm/fault-armv.o
> > >   CC      arch/arm/mm/flush.o
> > >   CC      arch/arm/mach-mx3/clock-imx35.o
> > >   CC      arch/arm/mach-mx3/mach-mx31ads.o
> > >   CC      arch/arm/mach-mx3/mach-mx31lilly.o
> > >   CC      arch/arm/kernel/armksyms.o
> > >   CC      arch/arm/mm/ioremap.o
> > > arch/arm/mach-mx3/mach-mx31lilly.c:300: error: redefinition of 'd=
evices'
> > > arch/arm/mach-mx3/mach-mx31lilly.c:295: error: previous definitio=
n of 'devices' was here
> >=20
> > The problem is a mis-merge of i..MX/for-next as it contains a patch
> > c0d1dac4a91a665fb5b5f1674acf57dc8cdc07ec that is already in Linus' =
tree
> > as 4d5d85906ad109987504033fa04991f1b0a2e552:
>=20
> OK, this is only the third time I have seen git mismerge something
> automaitcally. :-(
I can reproduce that here[1].  Is this a bug in git?  Can somebody expl=
ain?
I expected a merge conflict or only a single occurence of devices[]

> > Stephen: The obvious fix is to remove one of the two identical devi=
ces[].
>=20
> I have fixed this up in today's linux-next (and will continue to do s=
o
> while necessary).
How do you remember this.  By "hand" or do you have some automatism for
such things?

Best regards and thanks
Uwe

[1]=20
	git clone -n git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
	cd linux-next
	git checkout 815c4163b6c8ebf8152f42b0a5fd015cfdcedc78
	git merge c8adc84533d7e98487b77154eedf2eaf0ed6037e
	grep devices[[] arch/arm/mach-mx3/mach-mx31lilly.c
=09

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
