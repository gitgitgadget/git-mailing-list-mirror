From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rerere failed to parse conflict hunks
Date: Wed, 09 Dec 2009 10:47:10 +0100
Message-ID: <4B1F721E.9050609@drmicha.warpmail.net>
References: <20091209084648.GA30139@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 10:48:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIJ9w-0002Ee-KM
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 10:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbZLIJs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 04:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbZLIJsZ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 04:48:25 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33998 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753130AbZLIJsY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 04:48:24 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B3961C5FCA;
	Wed,  9 Dec 2009 04:48:27 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 09 Dec 2009 04:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=MFaQLgr0t5hqYn3RjvM7acqFIYw=; b=Ye9Bv3uCRHH5U5s+yvfmGayRuVVADyuaV+yF3/9kU2JvcrEwDw+TflUSxXezFg0gcxfS2wWRNrV1TF/kjflt8UGzpMOIGZpmip6TrXiRl/ZmJ+atFZiNX1tyt75/KfS3UaXXOnqQUBLogtlVvvpueQ77CCDlNsuALbQxnPUmXbo=
X-Sasl-enc: bkiff8k4Gpag/sFc/ataCZPQ01IzmcJTgYLh8rRed1Q0 1260352107
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F12BD1FFA4;
	Wed,  9 Dec 2009 04:48:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <20091209084648.GA30139@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134954>

Uwe Kleine-K=F6nig venit, vidit, dixit 09.12.2009 09:46:
> Hello,
>=20
> I just tried to merge linux-next
> (5c1af82119f11c5b322156b09d38cc37318849c4) into my private tree
> (based on 2b876f95d03e226394b5d360c86127cbefaf614b) and this
> happened:
>=20
> 	...
> 	Removing sound/soc/au1x/sample-ac97.c
> 	Recorded preimage for 'arch/Kconfig'
> 	Recorded preimage for 'arch/arm/mach-s3c2440/mach-anubis.c'
> 	Recorded preimage for 'arch/arm/plat-mxc/Makefile'
> 	error: Could not parse conflict hunks in arch/arm/plat-s3c/dev-hsmmc=
2.c
> 	Recorded preimage for 'arch/arm/plat-s3c/include/plat/sdhci.h'
> 	Recorded preimage for 'arch/arm/plat-samsung/Kconfig'
> 	Recorded preimage for 'arch/x86/include/asm/x86_init.h'
> 	Recorded preimage for 'arch/x86/kernel/x86_init.c'
> 	Recorded preimage for 'drivers/net/wireless/ray_cs.c'
> 	Recorded preimage for 'kernel/Makefile'
> 	Recorded preimage for 'kernel/power/hibernate.c'
> 	Recorded preimage for 'net/sctp/sysctl.c'
> 	Automatic merge failed; fix conflicts and then commit the result.
>=20
> If you are interested, I can provide you the two trees above.  When
> reproducing the line "error: ..." came later, but is still present.
>=20
> I guess this should be reproduceable with
>=20
> 	git clone -n git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux-2.6.git
> 	cd linux-2.6
> 	git remote add -f next git://git.kernel.org/pub/scm/linux/kernel/git=
/next/linux-next.git
> 	git checkout 2b876f95d03e226394b5d360c86127cbefaf614b
> 	git merge 5c1af82119f11c5b322156b09d38cc37318849c4
>=20
> I havn't tried though.
>=20
> The only non-trivial conflict is:
>=20
> 	#include <plat/sdhci.h>
> 	#include <plat/devs.h>
> 	<<<<<<< HEAD
> 	=3D=3D=3D=3D=3D=3D=3D
> 	<<<<<<< HEAD
> 	#include <plat/cpu.h>
> 	=3D=3D=3D=3D=3D=3D=3D
> 	>>>>>>> next-s5pc1xx
> 	>>>>>>> next/master
>=20

Someone committed a file with conflict markers. Bad bad boy. I guess
a8c4f01 (fixup sdhci merge failure, 2009-11-23) did not quite what it
promised.

Michael
