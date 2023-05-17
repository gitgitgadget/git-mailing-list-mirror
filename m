Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB2C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjEQUWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQUWf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 16:22:35 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 13:22:30 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:13a:16c2::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1837AA9
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:22:30 -0700 (PDT)
Received: from leda.eworm.net (p200300cf2f18320018F6571B32b1Eeb8.dip0.t-ipconnect.de [IPv6:2003:cf:2f18:3200:18f6:571b:32b1:eeb8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id DEAC9223E8B;
        Wed, 17 May 2023 22:12:41 +0200 (CEST)
Date:   Wed, 17 May 2023 22:12:37 +0200
From:   Christian Hesse <list@eworm.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <20230517221237.590fb984@leda.eworm.net>
In-Reply-To: <xmqqilcrq6a9.fsf@gitster.g>
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g>
        <ZGT6fEZFumAsZnxu@nand.local>
        <xmqqilcrq6a9.fsf@gitster.g>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I5B+Uz/ilBp1BbdywpBIIdb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/I5B+Uz/ilBp1BbdywpBIIdb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Wed, 2023/05/17 09:19:
> Taylor Blau <me@ttaylorr.com> writes:
>=20
> > On Wed, May 17, 2023 at 08:49:37AM -0700, Junio C Hamano wrote: =20
> >> Christian Hesse <list@eworm.de> writes:
> >> =20
> >> > From: Christian Hesse <mail@eworm.de>
> >> >
> >> > We use xstrfmt() here, so let's include the header file.
> >> >
> >> > Signed-off-by: Christian Hesse <mail@eworm.de>
> >> > ---
> >> >  imap-send.c | 1 +
> >> >  1 file changed, 1 insertion(+) =20
> >>
> >> Puzzled.  For me Git 2.41-rc0 builds as-is without this change just
> >> fine, it seems. =20

I prepared cgit to build with libgit.a 2.41.0-rc0. While cgit itself builds
fine (with some justifications of course), building git for the test suite
failed.

> > It will fail to build for ancient versions of curl (pre-7.34.0, which
> > was released in 2013), or if you build with `NO_CURL=3D1`. =20

Indeed we have NO_CURL=3D1 in cgit's Makefile...

> xstrfmt() is used at exactly one place, inside "#ifndef NO_OPENSSL",
> in the implementation of the static function cram().
>
> Ah, the mention of that function was a huge red herring.

Well, the warning about implicit declaration of xstrfmt() was this one that
popped up... :)
Sorry for the confusion.

> There are
> tons of strbuf API calls in the file outside any conditional
> compilation, and where it inherits the include from is "http.h",
> that is conditionally included.
>=20
> OK, so the fix seems to make sense, but the justification for the
> change needs to be rewritten, I think.
>=20
>     We make liberal use of the strbuf API functions and types, but
>     the inclusion of <strbuf.h> comes indirectly by including
>     <http.h>, which does not happen if you build with NO_CURL.
>=20
> or something like that?

Fine with me!
Do you want me to re-send the patch or do you modify this on the fly?
=20
> Thanks.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/I5B+Uz/ilBp1BbdywpBIIdb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmRlNTUACgkQiUUh18yA
9HaSeAgAiYsWlY0JBDnbzWM2VwDV1xbjrKjsgLoQIQWJcai7329bvj8fgoqOUSA8
goLv/nuMy88JxZgcmnabYHsOXcPEuypV/O+dxNmzNdBV/aGHM+8KyA0w2kl3Aua0
3xtzi/WTXv08bn8k26nOGAzwk9VqnFQHIu2Kfmv/xHDuMnf7+nbukWmgmeO2oN4E
eiVR8XCtBCM0kdRtajC0Z3uTC+PWl7A9+V5Cty6EhLwxDvFWUhY7vTxKiXCnRxmT
Ua84X3ivC0t00bFOL1Xqff4Rf1WNqOBeVFh86P842pc4s8pRdLOh88Nsrz5THG4c
6Ezh9rFP79jG4gek0VE8w3m87A8lOg==
=MgQv
-----END PGP SIGNATURE-----

--Sig_/I5B+Uz/ilBp1BbdywpBIIdb--
