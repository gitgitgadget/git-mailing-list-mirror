Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7066F1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 08:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJRQE5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 12:04:57 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:35528 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJRQE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 12:04:57 -0400
Received: from leda (unknown [IPv6:2001:470:99c1:708:d357:a202:545c:8439])
        (using TLSv1.2 with cipher DHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 2DCD6DB669;
        Thu, 18 Oct 2018 10:05:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 2DCD6DB669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1539849907; bh=ZtYpmGdfNM+gkTftDAbU9h0+Idw7nNPu0yjSWyO1AJY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=AGoi7iSVEwfbPLsFjUghbE61RyMH7fWGG22NliYGtgJJ6Vec96gK4PnKJ/p1QXRnV
         C9Cv4B6868HjyXpDued+D90FxrOnY2gHn5MSjnRrsWmKlKLmgWOxT/Ipc0k7gc4LaW
         x6iGAIKaMokKd86PRP/ozhfbMUzGxYPdIMaRGbrM=
Date:   Thu, 18 Oct 2018 10:05:04 +0200
From:   Christian Hesse <list@eworm.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] subtree: make install targets depend on build
 targets
Message-ID: <20181018100504.053e4827@leda>
In-Reply-To: <xmqqftx4vwe5.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
        <20181016075624.30176-1-list@eworm.de>
        <20181017024503.GA117170@aiede.svl.corp.google.com>
        <xmqqftx4vwe5.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c3K0nuuhTA=G2GZ_2sqZ2PW"; protocol="application/pgp-signature"
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: mpztn3sy9y8s3da1txw9gabcbob3x148
X-Rspamd-Queue-Id: 2DCD6DB669
X-Spamd-Result: default: False [-4.70 / 15.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-0.00)[15.46%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM(-3.00)[-0.999,0];
         SIGNED_PGP(-2.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:6939, ipnet:2001:470::/32, country:US];
         FREEMAIL_CC(0.00)[gmail.com];
         RCVD_TLS_ALL(0.00)[]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/c3K0nuuhTA=G2GZ_2sqZ2PW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Thu, 2018/10/18 11:09:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>=20
> > The rule says
> >
> >  install-html: html
> > 	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
> > 	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
> >
> > and $^ substitutes to "html" after this change. =20
>=20
> Sorry about that.
>=20
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 18 Oct 2018 11:07:17 +0900
> Subject: [PATCH] Revert "subtree: make install targets depend on build
> targets"
>=20
> This reverts commit 744f7c4c314dc0e7816ac05520e8358c8318187a.
>=20
> These targets do depend on the fact that each prereq is explicitly
> listed via their use of $^, which I failed to notice, and broke the
> build.
>
> [...]
>
> @@ -98,4 +98,4 @@ clean:
>  	$(RM) $(GIT_SUBTREE)
>  	$(RM) *.xml *.html *.1
> =20
> -.PHONY: FORCE man html install-man install-html
> +.PHONY: FORCE

We could keep the phony part at least...

--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/c3K0nuuhTA=G2GZ_2sqZ2PW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlvIPrAACgkQiUUh18yA
9Ha6fwf6AvkQYmC4xqOI3yE7ha//jUFep7reDMfVAiZerPaUJQq00fUCt//gn2t0
25C5ZL6KkGEMJK3m2w1laZMTgrkroY8RYZ01j9MUPweAIjndc9dXJ33yATnRaqK7
QWSPcZrWWXOjsEim65kOCcN7yqO/0yiMJMWmMixDvscwnaAllCuD5YKdWFjp0GOh
9mGsS8XhmCfN6qD3IxhSwBdeXL9vuIXYI+dzUCbY7IAynGXxJQc9YAxi3Rwk5ZRV
9cXdCV4NLjwMgaFqzldOYCfRRr56ngXIaRRddGt4RDjSbLpJ4hc3PUtrvAonZqSc
FTo16vvLhFm76+/CtWHSTeglxQT20g==
=snN6
-----END PGP SIGNATURE-----

--Sig_/c3K0nuuhTA=G2GZ_2sqZ2PW--
