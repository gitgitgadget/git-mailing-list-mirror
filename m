Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D838C7EE22
	for <git@archiver.kernel.org>; Wed, 17 May 2023 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEQUTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 16:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQUTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 16:19:00 -0400
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 13:18:53 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [195.201.174.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B041FE1
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:18:53 -0700 (PDT)
Received: from leda.eworm.net (p200300cf2F18320018f6571B32b1eeB8.dip0.t-ipconnect.de [IPv6:2003:cf:2f18:3200:18f6:571b:32b1:eeb8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 48B3B223ED8;
        Wed, 17 May 2023 22:18:51 +0200 (CEST)
Date:   Wed, 17 May 2023 22:18:50 +0200
From:   Christian Hesse <list@eworm.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <20230517221850.1117204b@leda.eworm.net>
In-Reply-To: <20230517221237.590fb984@leda.eworm.net>
References: <20230517070632.71884-1-list@eworm.de>
        <xmqqwn17q7ou.fsf@gitster.g>
        <ZGT6fEZFumAsZnxu@nand.local>
        <xmqqilcrq6a9.fsf@gitster.g>
        <20230517221237.590fb984@leda.eworm.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kX7puJQkeV0T.wMSKm4ZndO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/kX7puJQkeV0T.wMSKm4ZndO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@eworm.de> on Wed, 2023/05/17 22:12:
> > OK, so the fix seems to make sense, but the justification for the
> > change needs to be rewritten, I think.
> >=20
> >     We make liberal use of the strbuf API functions and types, but
> >     the inclusion of <strbuf.h> comes indirectly by including
> >     <http.h>, which does not happen if you build with NO_CURL.
> >=20
> > or something like that? =20
>=20
> Fine with me!
> Do you want me to re-send the patch or do you modify this on the fly?

Found it in next branch already. Thanks a lot!
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/kX7puJQkeV0T.wMSKm4ZndO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmRlNqoACgkQiUUh18yA
9HZI5Qf/RhBAlCTDI9uFaRlSohjjPiNwIbkNIHeeLt5jjQDe0RRcmoBCIFz1+f7L
dI99arfE92LSvML6MSo8yHWkD805G8u/cSoDdkfT1h2d7vf2lfn9tlyfjoIpoH3X
zgUXtV2rLDjJnJgJDQNU/Gl1o6zjMvRSvaT1ubaiQD2L/1zz4AH/bEiDxFpEtJ+N
TuWOJq156eaAybZIzeXB7MbWChQ1R0np5Qa2i5+tJIUOt4E2nFN+Tb2ZsZ0xWdMc
14DD+CnuP9ckmuq995UiW+Ape/XL/Gpy8u55T0oxesIGTQYBIvs0zFy4/oB/tSML
Ohbhi8+Rq2fcW8DrsmTL7z3Fex3ZzQ==
=bUty
-----END PGP SIGNATURE-----

--Sig_/kX7puJQkeV0T.wMSKm4ZndO--
