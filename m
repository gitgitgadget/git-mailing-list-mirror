Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14824C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E228D61606
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhEKXGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:06:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229714AbhEKXGI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 19:06:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2F55760456;
        Tue, 11 May 2021 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620774271;
        bh=H26Xq4ugfH5Lgjc2ATQbdZ9+a82RcblKTMbfp1wUutk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=snCw8yA6nPUtw+fgXelYT8w5om43OMzf+R65nptTp75+AcHsIgZZBK7ug71M0y+ou
         97yZx6d4cj0zyJdvcEwSAI5uJUaD7S2yCtwheTEHuWkB41xqHR+ea3HRHzkZLCf+oX
         1d6vYEC5RuSlVHhn08NQq8WLPg94IAU6Bqke1lhdhHrj/sbINFmaJj6dzM/Jt+hdUP
         o9KKxWIBa3GCwG3Wjvrub72uPW5t/Atf/0UsK0K/2xMGAyEOeLp97/swT7ffDxBT6p
         RlJQqxXH0L8aDeYnKI7/5kEN4Zs6pCW+boQMZh0ri3o28XVXXJFj3DTYdqhF2/FPpN
         hcokoHhGdgbTxnxo2Og+et1qJu77UHeyw4SgbI1gF7T+EsIW26DcByNj/Cnli2M6C2
         VrpJuVnHjr6DN+diUGZw/ld5+oKJUaG03TKx2NN9x60JmIYIISLH+LIHmVKJ/06yRj
         OYSrqailvQ9N0IHFg5+GJDm9i8VRFU/QOAWaPsSS4vP5ekIQK3Q
Date:   Tue, 11 May 2021 23:04:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
Message-ID: <YJsNe5chEb+z4fN5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210511103730.GA15003@dcvr>
 <874kf9tjgj.fsf@evledraar.gmail.com>
 <YJrMNmH92mKrIX0N@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6OaHsQqd4ACmnnX4"
Content-Disposition: inline
In-Reply-To: <YJrMNmH92mKrIX0N@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6OaHsQqd4ACmnnX4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-11 at 18:25:58, Jeff King wrote:
> On Tue, May 11, 2021 at 04:47:28PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>=20
> >=20
> > On Tue, May 11 2021, Eric Wong wrote:
> >=20
> > > I'm not very familiar with the way some of this stuff works, but
> > > the patch below seems to fix clone for me.
> >=20
> > Me neither, but it seems that whatever issue we have here we've got a
> > big blind spot in our test suite.
> >=20
> > GIT_SMART_HTTP in the environment will be ignored by test-lib.sh,
> > manually changing the code to use it leads to a lot of test failures,
> > some are definitely expected (incompatible server responses), but some
> > might not be...
>=20
> There are specific dumb-http tests in t5550. And I think we can and do
> run the suite with GIT_TEST_DEFAULT_HASH=3Dsha256. But I suspect that
> covers up the problem. If I understand the problem correctly, it comes
> about when the client thinks the default hash is sha1, but the server is
> sha256. Whereas GIT_TEST_DEFAULT_HASH affects _both_ sides.
>=20
> So I think we'd want interop tests in t5550 that specifically create a
> sha256 server and access it with a sha1 client (and possibly vice
> versa).

This is pretty easy to do just by unsetting GIT_TEST_DEFAULT_HASH from
the environment.  We do that in some places in the init tests.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--6OaHsQqd4ACmnnX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJsNewAKCRB8DEliiIei
gdlwAQCInoR9He9XI1b0RQXGVfPZNQIrq1BS67jpZs6TcaAZvAD/RLYE6b873B1/
lKasf2ddA+3dxUh9PyOUfq4irVG2MgI=
=c2cG
-----END PGP SIGNATURE-----

--6OaHsQqd4ACmnnX4--
