Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C7C1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 15:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDRP0k (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 11:26:40 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:42920 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbeDRP0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 11:26:38 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2018 11:26:38 EDT
Received: from leda (unknown [87.190.244.126])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id C1583264BA;
        Wed, 18 Apr 2018 17:17:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de C1583264BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1524064658; bh=xBXmtnpYccXHSZE50BIjLnv+8RXDkD57atldMqSxWEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=T/8Uqc9GnwDEfDusZuOEaDFhtsU7+IgnMqfmxSHu02324KWOdwyEtNI+LmClbTvEA
         i0efCRKJqm7WS7BPGy/0anAxhKVyh14N8W432A2LPiJjdt8ML2LJvr2c7T8DkFM3oa
         t5Vg0VeRYmkrZtH2MzVRrApfhUZmMfkxw8HgSglQ=
Date:   Wed, 18 Apr 2018 17:17:33 +0200
From:   Christian Hesse <mail@eworm.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
Message-ID: <20180418171612.5647cf12@leda>
In-Reply-To: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wk5kYpX43fefNvF+mhaZpSl"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/wk5kYpX43fefNvF+mhaZpSl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Tue, 2018/04/17 15:07:
> * ab/simplify-perl-makefile (2018-04-11) 1 commit
>   (merged to 'next' on 2018-04-17 at 4448756934)
>  + perl: fix installing modules from contrib
>=20
>  Recent simplification of build procedure forgot a bit of tweak to
>  the build procedure of contrib/mw-to-git/
>=20
>  Will merge to 'master'.

Looks like cooking is v2 of the patch, while we were at v3, no?
--=20
Best regards,
Chris

--Sig_/wk5kYpX43fefNvF+mhaZpSl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvYTecfST32gUsBZyVO3JFgm8kYMFAlrXYY0ACgkQVO3JFgm8
kYNcbRAAjZ4EPIgxQGCXEWY+XnC6N+aOEAvih3j8Nd+swn9atMDVVqh/O0dN+Llt
FBEobi4xZrTbhj9BNtFmnfRLBtrvINNvYf67mEEZDiSIzK92of8nVLpm17u7SWdl
hOnXh/b5bhLAQUum5dzGyrtz5/7QMRRaVQxZltfKjweON0GS6++Zff/kSWYpTMCJ
zVtoFCIOZG7azzU+hnahFGKPUITHYJYtMSDeTR04U4H1T9DLDP231VxIqfGFY+fH
GsDanP2Fju+5eG4AD1Wz0XCujUYbLp4DtS7h790G1QEw0bJKSWZTMIPaYRUb0kRt
coJGgGPiahrOjpVoyrc1QGGPfOVH/fwCd1HPReUXLNXI0MKCcTTBKxmbpUjPfHsz
dUvN44rbJjjT+QtdhzyKB3pLKlotRz/D/i71xg3s01A9Ko0H0bzgTSk18jNTcQuw
v9SDrj8uWesIwAyj9JxuSW5kaKef3HSZFUb1cVV3HqKl3BUQLssAeXwGFI0btibW
MwaJZkWrJ+xzp1SpNmWZupwOuSfrSJjJ4+AXDaN9p4Nwg4XtJjL3hbhOYMyt9hqk
TmqFXU9tB5gfdtYk33Q/mb+DxM6IzXzABdnox+TcJgnLwJhyevgUdPBwEHk8c0rw
MBOjLY5fk2nop0343UIt94EJUiqoozxMEN+TkbmY+pcHiTQhcLc=
=pMXV
-----END PGP SIGNATURE-----

--Sig_/wk5kYpX43fefNvF+mhaZpSl--
