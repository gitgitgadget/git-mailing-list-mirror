Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824521F453
	for <e@80x24.org>; Mon, 15 Oct 2018 21:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJPFLn (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 01:11:43 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:45372 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeJPFLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 01:11:43 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2018 01:11:41 EDT
Received: from leda (p5B1019A6.dip0.t-ipconnect.de [91.16.25.166])
        (using TLSv1.2 with cipher DHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id C18E6C456D;
        Mon, 15 Oct 2018 23:15:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de C18E6C456D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1539638103; bh=CaC/chNxgUUDHEOFu27Y3DhI/OBganZMre64v4tRQqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=fyZqRkgOZT3a60pP4K9pywWzunIc0JZBrc+lK89OQzywp91+j8Jvok5fb9YMmkacA
         xgEfCv6G60XzWAY5LW8Q1KmX5KKA9jTkyIUTLkRvVlKik3DG0uH2BJJEdtdKOciTd4
         8iLfWpcff5G21Hf/EDRw+7dZCKsdlD/fyCIZees8=
Date:   Mon, 15 Oct 2018 23:15:01 +0200
From:   Christian Hesse <list@eworm.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] subtree: add build targets 'man' and 'html'
Message-ID: <20181015231501.5a7524b0@leda>
In-Reply-To: <xmqqmurmmt9j.fsf@gitster-ct.c.googlers.com>
References: <20181007073036.30643-1-list@eworm.de>
        <xmqqmurmmt9j.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/p9h=jKz_LK9xjbT8jCMCtEf"; protocol="application/pgp-signature"
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: 7spdrs9dtqhxbq7kxub73r5aysewj7c9
X-Rspamd-Queue-Id: C18E6C456D
X-Spamd-Result: default: False [-4.70 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         TO_DN_ALL(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         NEURAL_HAM(-3.00)[-0.999,0];
         SIGNED_PGP(-2.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:3320, ipnet:91.0.0.0/10, country:DE];
         RCVD_TLS_ALL(0.00)[]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/p9h=jKz_LK9xjbT8jCMCtEf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Wed, 2018/10/10 11:26:
> As 'contrib' material without real maintenance, I do not care too
> deeply, but shouldn't this change be more like this to avoid
> duplicating the list of targets?

Probably, yes.
Do you want to add this yourself or do you want me to send an updated patch
or one on top of the last change?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/p9h=jKz_LK9xjbT8jCMCtEf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlvFA1UACgkQiUUh18yA
9HbZJAf+O2VRe4SEUlu6eUWcTLhbAoauWvodwkd4G/cXtPvzQGoWSWTNkUWSaCyu
/Kk3bEyMvFECouyOh3+bchNZuyDzectG1PDwcRZGhFkHLsaO8A6b349rQt6Qj5IO
n/TXJOs1RrHm1BteOADYJNXhMc3OHfA2Q20tXHtLKqcKL+uUnBcbR0CNBHG67lrp
Qeyn+t5T6UA0j3GG3jLu3UB4IJ96dmCrBD694/gNCtgchKVqtt1BTGF2CCUxGANw
xEK3AhVUUp+cQpjRP9VojNogkJYo47nAq6i9N11NjJiINvwEQrv7p34Mi58N+oDM
vGJUhsdKqd6n//wpSqjGJq2DnIuBPA==
=GDob
-----END PGP SIGNATURE-----

--Sig_/p9h=jKz_LK9xjbT8jCMCtEf--
