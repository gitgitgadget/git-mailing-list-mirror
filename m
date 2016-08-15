Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55411F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbcHOMbZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:31:25 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:38716 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcHOMbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:31:25 -0400
Received: from leda.localdomain (unknown [87.190.244.126])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 6898725B0F;
	Mon, 15 Aug 2016 14:21:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 6898725B0F
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1471263696; bh=h1Ba1tXXZJppOLLxoboiOh5i+det1H0QP2b194fkwL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=0Ctnz3Atfrqg1tZSYPVXdboD/3HYL9Je5X8m4b5f2h6DpaX8GEw7HopFIN6Ttas3F
	 m4jzvQl3Z89xSIzm8Z68fTLwufWb2PH+wC0H+XuhIiVzBQhtR0j/8eqJghHqLv3iXC
	 USMPe2Jv00x1BC9346D3E9e8FTfdH52CdEOm4P24=
Date:	Mon, 15 Aug 2016 14:21:25 +0200
From:	Christian Hesse <list@eworm.de>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] do not add common-main to lib
Message-ID: <20160815142125.0ca30e0f@leda.localdomain>
In-Reply-To: <20160815120223.4lr23aiqmqzjprch@sigill.intra.peff.net>
References: <20160815075207.31280-1-list@eworm.de>
	<20160815120223.4lr23aiqmqzjprch@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
X-Face:	%O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:	iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pEP.pfB8D8dYkYlAVt92txY"; protocol="application/pgp-signature"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--Sig_/pEP.pfB8D8dYkYlAVt92txY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> on Mon, 2016/08/15 08:02:
> On Mon, Aug 15, 2016 at 09:52:07AM +0200, Christian Hesse wrote:
>=20
> > From: Christian Hesse <mail@eworm.de>
> >=20
> > Commit 08aade70 (mingw: declare main()'s argv as const) changed
> > declaration of main function. This breaks linking external projects
> > (e.g. cgit) to libgit.a with:
> >=20
> > error: Multiple definition of `main' =20
>=20
> I'd expect the culprit is actually 3f2e229 (add an extra level of
> indirection to main(), 2016-07-01).

Ah, probably you are right...

> > So do not add common-main to lib and let projects have their own
> > main function. =20
>=20
> That is certainly an option, but I think it means that those projects
> are potentially buggy in the same way that some git commands were prior
> to the common-main series. Namely, the common main() may do some
> run-time setup that parts of libgit.a assume has been done.

Ok, got it.

> I would not be surprised if cgit crashes on Windows, for instance, for
> the reasons detailed in 650c449 (common-main: call
> git_extract_argv0_path(), 2016-07-01). I would also not be surprised if
> nobody actually builds cgit on Windows. :)

I never tried and probably nobody else did. :-p

> The "right" way to do it (according to the way libgit.a views the world)
> is for cgit's main to become cmd_main(), and let libgit.a do its
> run-time startup before getting there.

Looks like that does the job. I will give it some more testing.

Please ignore my patch... ;)
Thanks a lot!
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/pEP.pfB8D8dYkYlAVt92txY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXsbPFAAoJEIlFIdfMgPR2cz4IALZmpaaKt7YjYiyanjj0NCGS
S78bq1mKTtg8gXz5oKnwbHds+7Byi5OzFmkxPZ/IlKXPDJsaqfCcXs52mb2KKsbf
aPzm2LbaRU9ASKPffZyuUB+OjxEg4BQZySh5ymg7vtJlCPtWSBPvrqCKDjmSTwD2
A/WHSs9rOYlPEG+UEkfyQG7MBYn5cfC06Ee82nHz+EsXIjePBdbMNBOxTjOoHV36
KVOTQDah9H8Ho0b4fSkiX4m1etnmpCimAUVsYFKZUNWl2mpZP2u2v8dEVSwakWUx
LXPjKseaorBZ5Le8mnuwZ/RNovkMEFFypFuBKKnWFJCp3W+rZ6GSKWYy7vaY0+8=
=AjXY
-----END PGP SIGNATURE-----

--Sig_/pEP.pfB8D8dYkYlAVt92txY--
