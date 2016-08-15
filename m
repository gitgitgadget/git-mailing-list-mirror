Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730131F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbcHOMaP (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:30:15 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:38629 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbcHOMaO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:30:14 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Aug 2016 08:30:14 EDT
Received: from leda.localdomain (unknown [87.190.244.126])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 682C025B12;
	Mon, 15 Aug 2016 14:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 682C025B12
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1471264212; bh=heUUM0AEJq15uviPXcCD8P9Zoc0G62npmwHAQENDVNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bI0kT/16ZXwcvqfH2CJONL8XLI1TJKvKa38RWdjC8ni23UdEsh+TZqcoGt3aO52EH
	 PpuUho9TJ4pKl770SjZGdb8yDtGMI4aCEuslmPUarLURzPbP5DDTI8OceyMxKOgs8k
	 LcNPg84A8JPtHse8nM/ta8yNfjUpww4uohCH6WHI=
Date:	Mon, 15 Aug 2016 14:30:07 +0200
From:	Christian Hesse <list@eworm.de>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] do not add common-main to lib
Message-ID: <20160815143007.2225c655@leda.localdomain>
In-Reply-To: <alpine.DEB.2.20.1608151418150.4924@virtualbox>
References: <20160815075207.31280-1-list@eworm.de>
	<alpine.DEB.2.20.1608151418150.4924@virtualbox>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
X-Face:	%O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:	iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LYPRUmqanFjMz67Kk+QdbuD"; protocol="application/pgp-signature"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--Sig_/LYPRUmqanFjMz67Kk+QdbuD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin <Johannes.Schindelin@gmx.de> on Mon, 2016/08/15 14:20:
> Hi Christian,
>=20
> On Mon, 15 Aug 2016, Christian Hesse wrote:
>=20
> > From: Christian Hesse <mail@eworm.de>
> >=20
> > Commit 08aade70 (mingw: declare main()'s argv as const) changed
> > declaration of main function. This breaks linking external projects
> > (e.g. cgit) to libgit.a with:
> >=20
> > error: Multiple definition of `main'
> >=20
> > So do not add common-main to lib and let projects have their own
> > main function. =20
>=20
> I am opposed to this change.

Me too. :-p

> For one, libgit.a is *not* a library with an API, for a good reason:
> nothing in Git's development guarantees any kind of stable API. For that
> reason, libgit.a is not installed, either, and neither are any headers.
>=20
> And even more importantly: *iff* you *insist* on using libgit.a in your
> project *despite* having been told not to, it is your responsibility to
> stay up-to-date with the requirements of it.

cgit pulls in the git tree as a subproject. We are aware that the API chang=
es
all the time and that's fine. Usually we just fix it, this time I missed the
background information of the change.

> One such requirement is that you now implement cmd_main() instead of
> main().
>=20
> So if you want to continue to have an out-of-tree project that links
> against the (private) libgit.a, it is your out-of-tree project that needs
> changing, not libgit.a.

Already updated my code. ;)
Thanks!
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/LYPRUmqanFjMz67Kk+QdbuD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXsbXPAAoJEIlFIdfMgPR2cIQIAIfzlUacBrIjtfszA3RnFOXV
hV6tKr2/TtRp/K7xdISsYEBgcms6uX+NHNGTu2aa4Q/JzKXXPc8q3TsV12hyYVcZ
eTtMdIbbHENXxSr+dQDWukanhD92P5wHsAX5EjNQH70ptahdEO0Y8EmNOoUaGsbF
bK9spU6MAELKrnZxGjYT9+Y7jWoRClzBiBzSdoOB4k0XyXRQy8EQJMbJEFB52lFu
aR6Llzbtic1oTj+7W3vxCDV96XCJ2xaP3aGYutvBKe0rKJIJPm5WD5CER59i0vki
+ovLPIGE1u5SjJL+lBUcqiK/J13o/ly6eU6zXvmQLFeSSeGHtA54JcarA6bp/t4=
=WnuV
-----END PGP SIGNATURE-----

--Sig_/LYPRUmqanFjMz67Kk+QdbuD--
