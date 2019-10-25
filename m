Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D94D1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 16:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395563AbfJYQQv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 12:16:51 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:43516 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389696AbfJYQQv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 12:16:51 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 12:16:49 EDT
Received: from leda (unknown [IPv6:2001:470:99c1:714:e078:5e8f:bc9c:af22])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id B99E816E0CB;
        Fri, 25 Oct 2019 18:10:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de B99E816E0CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1572019817; bh=lQfn2eZZBr9LJ766SnCQvuuaQg6N0i+Tgd5zQIQ5f/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=YRF+Hxeq05XS4clWXc8HUjiLy3OdFF04nZcJwhBKuJ+h/ZTejOHxQ0iL+NobQZFd2
         smV16XfLYDD1g9tybaqK/YAUTMVS9b5sY9GFJy0T+rBHcDNwOfrXGvgEqEyBwGGIG+
         wLzBpn9uWf6uFBufaVLxWOdarCxnk3BA54kbPaAk=
Date:   Fri, 25 Oct 2019 18:10:15 +0200
From:   Christian Hesse <mail@eworm.de>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: cgit and global configuration
Message-ID: <20191025181015.50bf2b92@leda>
In-Reply-To: <20190612190845.GA14949@sigill.intra.peff.net>
References: <20190611170401.15d43623@leda>
        <1cdb3444-fb39-66a4-fb27-01e1617e538a@jeffhostetler.com>
        <20190612190845.GA14949@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U0axE58Dz.AITKW5Fs8XVPh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=mail@eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: gcc8xsjr8q1c7fahngo8q6ya8ai6ps89
X-Rspamd-Queue-Id: B99E816E0CB
X-Spamd-Result: default: False [-4.40 / 15.00];
         BAYES_SPAM(0.06)[57.14%];
         RCPT_COUNT_FIVE(0.00)[6];
         TO_DN_ALL(0.00)[];
         SIGNED_PGP(-2.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         ASN(0.00)[asn:6939, ipnet:2001:470::/32, country:US];
         ARC_NA(0.00)[];
         URIBL_BLOCKED(0.00)[zx2c4.com.multi.uribl.com];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         NEURAL_HAM(-2.76)[-0.920,0];
         MID_RHS_NOT_FQDN(0.50)[]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/U0axE58Dz.AITKW5Fs8XVPh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> on Wed, 2019/06/12 15:08:
> On Tue, Jun 11, 2019 at 04:22:32PM -0400, Jeff Hostetler wrote:
>=20
> > As for going forward, I see 3 options:
> >=20
> > [1] update your tests to allow this.  (I didn't dig thru your
> >     tests to see how extensive this might be.)
> >=20
> > [2] define your own version of common-main.c and link with it
> >     instead of git/common-main.c and delete the calls to trace2_*()
> >     in it.
> >=20
> > [3] define your own version of common-main.c and then call your
> >     prepare_repo_env() prior to trace2_initialize().
> >=20
> > Granted, I've only spent 15 minutes looking at your code, so
> > I may be mistaken about several things, but I think those are
> > your options. =20
>=20
> After reading the original report, my instinct was that (2) or (3) is
> probably the right way forward. We could make it a little easier for
> them by splitting up common-main a bit into two parts:
> [...]

We decided to go another way and introduced a constructor function which do=
es
initial environment setup:

https://git.zx2c4.com/cgit/commit/?id=3D034e3c7d56ba71ce281886fe8525b16d455=
9fac1

Everything (including tests) is happy with that.
--=20
Best regards,
Chris

--Sig_/U0axE58Dz.AITKW5Fs8XVPh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvYTecfST32gUsBZyVO3JFgm8kYMFAl2zHmcACgkQVO3JFgm8
kYPNKg//RIE43ylKFbx8luCSv/c1t/gsx9TOr2Rkbd19RtI0ty73NTuiZlquytfS
eKkV+Fpl9vCM5mHEfsMAdIAMaomLXnINg9hZhhkPgbvX6fVtZ1fgYgRUsJ92UA/b
Hsxd7655oQnkjuGL/B+OAKPjKGqQgjTkXgAFj8CpI/SlMIrXs2n2W87hIlwwX6NO
rxYCejx56fyNpzak191T/yFd33mkvQZ3DWDJVbzYiKTW5R9/QxHAbY6+ZQofKJHw
2DlFsv0RrHVSq7k3II3YeNlV9hOoZ948XsIF5Q1vySUCYYHLUqy++/nBxe8oXkYH
UeGQ6vuqLV9NltrR/6Pbk9+agKPmr9rBobhD2WLcX+yNO87LDCe735IE0uJ8qvEB
2U6FrzHxXXWAsYmD7PPiAw6t6CtUVpM2KoIaB786CV8jwtV/8BF6v7KhqL1NZBW+
8UjHHTBIYC7b6hCbo86HsXhmr9oDXE7XGzKl9ByfRlowfp8/FMDimKmj2v/4+32E
AKKcl8sVI/vs6N9ZpDoWld3b5LRvlpu2lVwJjJKBzgcSegn8HEmX0BdohonVMVKp
WO0+FnBc4QK5GzMrNK3YFNXgfcBq6oi//2mDdyMcBmqd9zyKrHwTcntgs9D3hrUa
qo87N8a+y6B/aWFc9jp9exnOAwpLJk2cuoo1LCh16+pPA8Ox74w=
=fvkG
-----END PGP SIGNATURE-----

--Sig_/U0axE58Dz.AITKW5Fs8XVPh--
