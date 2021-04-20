Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC77C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1290613AB
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 01:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhDTB1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 21:27:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37328 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhDTB1S (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 21:27:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E7A3660744;
        Tue, 20 Apr 2021 01:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618881977;
        bh=OAWyvO0T1YX6gaII7V74ZDV1aDAL4XHBG7AnWzBpSvQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mc7li8YnKjtKP3itO+uE8PI/bfIXSC3ISOVB6uN9xiMugZ9Apcg1cwGXIwGdJ3NYO
         FI43nGx4W9g/C43JEpHFn5Pj/8c6pB19XNBoRfk9k1A/Ei/xYhmkCo5SyYx+VHkufm
         l9HC4vKp/l3jsKbMeiSKLWVVvuBB6s8X4bMw5tu2hDw4KoKxqsTsnwE45s8auo1JEB
         OSl1lATRWx8lgKXPInVqgE5ykTOmqHqu6aNHarU7h6PS5nm5yeKiwsUohyL459R676
         cacq1nCd+ezOFk0ak+zzajNxr+XtGB9k3IHrK3HOp2Sod7eBmk8LwWQWZKe5PBMPME
         w/pFJ9bxl4x+Jt22Bnp0fEIc9LKhuqsdgfs/PMDhDGKfLp9MOf7OJjviHeREU3HigH
         9aqy6yvQZkNa7jpxYomeSKnBMcyU5IYC3eSFvrRJqUlH8oT6z46EQMszHyoayFIVIa
         BiidoZSW9Kwti0o2NGSju/0g2gvOLr0JDW42dVCih4JAUSIer3Q
Date:   Tue, 20 Apr 2021 01:26:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Joonas Harjumaki <joonas.harjumaki@fi.abb.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git push --mirror hangs
Message-ID: <YH4tsaCBMJBGp0bC@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joonas Harjumaki <joonas.harjumaki@fi.abb.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM6PR06MB4263DD69639AFD60663D1DD6A7499@AM6PR06MB4263.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KwXZUYSCnESCXU2F"
Content-Disposition: inline
In-Reply-To: <AM6PR06MB4263DD69639AFD60663D1DD6A7499@AM6PR06MB4263.eurprd06.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KwXZUYSCnESCXU2F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-19 at 17:11:01, Joonas Harjumaki wrote:
> Git has been stuck for an hour and half after printing these:
> Writing objects: 100% (116519/116519), 3.69 GiB | 2.99 MiB/s, done.
> Total 116519 (delta 74981), reused 116519 (delta 74981), pack-reused 0
> 18:42:45.650572 trace.c:487             performance: 1266.567544063 s: gi=
t command: /usr/lib/git-core/git pack-objects --all-progress-implied --revs=
 --stdout --thin --progress
> 18:42:45.743254 pkt-line.c:80           packet:          git> 0000
> 18:42:46.465637 http.c:703              <=3D Recv header, 0000000013 byte=
s (0x0000000d)
> 18:42:46.465693 http.c:715              <=3D Recv header: HTTP/2 200
> 18:42:46.465707 http.c:703              <=3D Recv header, 0000000024 byte=
s (0x00000018)
> 18:42:46.465716 http.c:715              <=3D Recv header: cache-control: =
private
> 18:42:46.465727 http.c:703              <=3D Recv header, 0000000053 byte=
s (0x00000035)
> 18:42:46.465734 http.c:715              <=3D Recv header: content-type: a=
pplication/x-git-receive-pack-result
> 18:42:46.465744 http.c:703              <=3D Recv header, 0000000124 byte=
s (0x0000007c)
> 18:42:46.465752 http.c:715              <=3D Recv header: p3p: CP=3D"CAO =
DSP COR ADMa DEV CONo TELo CUR PSA PSD TAI IVDo OUR SAMi BUS DEM NAV STA UN=
I COM INT PHY ONL FIN PUR LOC CNT"
> 18:42:46.465763 http.c:703              <=3D Recv header, 0000000055 byte=
s (0x00000037)
> 18:42:46.465770 http.c:715              <=3D Recv header: x-tfs-processid=
: [stripped]
> 18:42:46.465778 http.c:703              <=3D Recv header, 0000000064 byte=
s (0x00000040)
> 18:42:46.465785 http.c:715              <=3D Recv header: strict-transpor=
t-security: max-age=3D31536000; includeSubDomains
> 18:42:46.465795 http.c:703              <=3D Recv header, 0000000050 byte=
s (0x00000032)
> 18:42:46.465801 http.c:715              <=3D Recv header: activityid: [st=
ripped]
> 18:42:46.465810 http.c:703              <=3D Recv header, 0000000053 byte=
s (0x00000035)
> 18:42:46.465833 http.c:715              <=3D Recv header: x-tfs-session: =
[stripped]
> 18:42:46.465842 http.c:703              <=3D Recv header, 0000000051 byte=
s (0x00000033)
> 18:42:46.465849 http.c:715              <=3D Recv header: x-vss-e2eid: [s=
tripped]
> 18:42:46.465858 http.c:703              <=3D Recv header, 0000000082 byte=
s (0x00000052)
> 18:42:46.465866 http.c:715              <=3D Recv header: x-vss-userdata:=
 [stripped]
> 18:42:46.465899 http.c:703              <=3D Recv header, 0000000029 byte=
s (0x0000001d)
> 18:42:46.465910 http.c:715              <=3D Recv header: x-frame-options=
: SAMEORIGIN
> 18:42:46.465919 http.c:703              <=3D Recv header, 0000000068 byte=
s (0x00000044)
> 18:42:46.465926 http.c:715              <=3D Recv header: request-context=
: [stripped]
> 18:42:46.465936 http.c:703              <=3D Recv header, 0000000048 byte=
s (0x00000030)
> 18:42:46.465945 http.c:715              <=3D Recv header: access-control-=
expose-headers: Request-Context
> 18:42:46.465954 http.c:703              <=3D Recv header, 0000000033 byte=
s (0x00000021)
> 18:42:46.465961 http.c:715              <=3D Recv header: x-content-type-=
options: nosniff
> 18:42:46.465972 http.c:703              <=3D Recv header, 0000000104 byte=
s (0x00000068)
> 18:42:46.465980 http.c:715              <=3D Recv header: x-msedge-ref: [=
stripped]
> 18:42:46.465990 http.c:703              <=3D Recv header, 0000000037 byte=
s (0x00000025)
> 18:42:46.465996 http.c:715              <=3D Recv header: date: Mon, 19 A=
pr 2021 15:42:45 GMT
> 18:42:46.466009 http.c:703              <=3D Recv header, 0000000002 byte=
s (0x00000002)
> 18:42:46.466017 http.c:715              <=3D Recv header:
> 18:42:46.466294 pkt-line.c:80           packet:     sideband< \2\15Analyz=
ing objects... (41535/116519)
> remote:

I suspect by the content of this sideband packet, that Azure DevOps is
doing something with those objects.  The text "Analyzing objects"
doesn't appear in Git, so it's presumably some operation specific to
Azure DevOps that's being performed.

I would ask them what's going on on their side that's making this so
slow.  It's possible that waiting will help, but it's also possible that
it won't.  Since I don't know what's actually happening on the server
side, I can't say.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--KwXZUYSCnESCXU2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH4tsAAKCRB8DEliiIei
gQd1APwP9pxFjpPdktiIEBwdxGQgo3KAC/gqXmmSdvNR6BqH6QD/e+ke7s9+PYVy
m186wgjO7zlXy7fdJ62kFPZg8BYk/ww=
=0QAN
-----END PGP SIGNATURE-----

--KwXZUYSCnESCXU2F--
