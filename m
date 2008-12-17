From: Gili Pearl <gili.pearl@yahoo.com>
Subject: Re: how to work in hirarchical git model?
Date: Wed, 17 Dec 2008 00:23:05 -0800 (PST)
Message-ID: <753177.33978.qm@web112212.mail.gq1.yahoo.com>
References: <703400.93370.qm@web112210.mail.gq1.yahoo.com> <4948AB14.8030004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:24:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCrhp-0004ND-60
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYLQIXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2008 03:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYLQIXI
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:23:08 -0500
Received: from web112212.mail.gq1.yahoo.com ([67.195.14.75]:36969 "HELO
	web112212.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751740AbYLQIXH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:23:07 -0500
Received: (qmail 34950 invoked by uid 60001); 17 Dec 2008 08:23:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LsnMlXzWB7YuiFsRNrgWIc8BxVXFib+NjrnxW0+zCIx32sIrnyb2qgYrI8pAa5g+xUP8johDBAQm3Y82RV6AvCqlfKTAAuNBKcYU4HLl1DaTIG7YzAQFmvvdp4zVhEInIS8wIvbvqQdYZfJNjDNQB/JdVXaAmbh/NJHHDwrcjcE=;
X-YMail-OSG: gJY4L1oVM1kTqNt3D_PGC.jnSRKhj495DT3QXSUUQu0cgGR.b.brYngXss1mlpJUOfA0abPU4BH4R3b.Jk.FoD.ZAqsvarusBMcYv58CE0xCUCzlhwgBEFq2zzLKshPuTaSpKeI6TS1PA8doPxESFpoKmhvFaKcLPJMkq.lBaZQZUofYX.Hm3YNuSlvAXPgMcULG2ICLOixw9.LFfSnRbW66KAFx7AoAJrq79Cp2vBFi1UFesW5t2w--
Received: from [80.179.89.178] by web112212.mail.gq1.yahoo.com via HTTP; Wed, 17 Dec 2008 00:23:05 PST
X-Mailer: YahooMailRC/1155.45 YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103316>

----- Original Message ----
> From: Johannes Sixt <j.sixt@viscovery.net>
>=20
> Gili Pearl schrieb:
> > Here is one problem I saw when trying to work in the three-level mo=
del.
> > At some point, I had the following setup:
> >=20
> > top-level : A----B----C----D
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > mid-level1:=A0 =A0 =A0 =A0 K----L----M
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > low-level1:=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 X----Y
> >=20
> > The maintainer of mid-level1 has decided that commits K L M are rea=
dy to be=20
> > merged into the top-level repo. So he rebased on top-level before a=
sking=A0'please=20
> > pull', but after that the low-level was not able to rebase on the m=
id-level=20
> > any more.=20
>=20
> In this model, the mid-level1 maintainer should *not* rebase against
> top-level. Rather, he should ask the top-level maintainer to *merge* =
K-L-M.
>=20


But what if K-L-M conflict with C-D? The one who should take care about=
 it is=A0
the mid-level1 maintainer (or possibly one of the low-level1 maintainer=
s).

> > So what is the right working flow for us?
>=20
> The only ones who should be allowed to rebase are developers at the l=
owest
> level. Everyone else should only pull or merge.
>=20

I still don't see clearly what happens next in the example above=A0when=
 the low=20
level developr wants to push X-Y upstream? On which branch should=A0he =
rebase?=20
Need he rebase on mid-level (where K-L-M were already merged=A0upstream=
),=A0or=20
maybe direclty on the top-level??=A0

Thanks



     =20
