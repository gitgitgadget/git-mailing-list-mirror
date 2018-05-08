Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA191F424
	for <e@80x24.org>; Tue,  8 May 2018 23:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932740AbeEHXJ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 19:09:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42632 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932368AbeEHXJ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 May 2018 19:09:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DD6DC6046C;
        Tue,  8 May 2018 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525820967;
        bh=np9u/YvxJH2FQ+0v8Rci+TLpJ4IFCOADKZgCHY9UbpY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CS5AAlQq+WXmHFBS91Tc0vxUfcCu9qIis7cxA7ZSH0E4R2CE5+7mvo7JYs9xLIWj2
         gXKJWSSZMec2+Xks9RItvpt5gXvNeVOXlTMTr/0iJbL7rYTBld9hXvoOwLn/tmTUZN
         8B8UfTqzx3cwNfQ8949U5Z+G1x42NZkDv22bhjy3jS8YmfTz5wRgWk8wP2buxiPe/l
         ZgCDiiNW8M+yFzxSnZHsTX8FdAfpbWU5Upof3LWpq7Qh9zBQlZsKLlQQ6gVhhjzkOa
         lp+aBZlxZ3RyP7YDbiFEDE7+pvzQsozP2BkM8J0jtagc42tMY9VRxMgWg69J65gJVf
         KBZvq7v9a+EG67BxwU0xCY32fuqDP/xmL1B/Ab1TeG8RDLIoWvX351XRceLcKP1OPh
         gLSdUdYjoMrdrx8TGWtu4J2x/uvTf9Ykc31ZMlg67AaQ42UP8smpFY/kiO5ya3Samc
         TzP1UWJiuLZELfFxswXxJlH0kxLKjHVIKV61Tgtti7LFPPRDqRX
Date:   Tue, 8 May 2018 23:09:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180508230922.GB275488@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Ben Toews <btoews@github.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net>
 <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net>
 <20180507094459.GA3412@sigill.intra.peff.net>
 <20180507230650.GH953644@genre.crustytoothpaste.net>
 <20180508132814.GA24975@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20180508132814.GA24975@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 09:28:14AM -0400, Jeff King wrote:
> OK, so my question then is: what does just-gpgsm support look like?
>=20
> Do we literally add gpgsm.program? My thought was that taking us the
> first step towards a more generic config scheme would prevent us having
> to backtrack later.

I think the signingtool prefix is fine, or something similar.  My "just
gpgsm" proposal is literally just "check for PGP header" and "check for
CMS header" in parse_signature and dispatch appropriately.

> There are also more CMS signers than gpgsm (and I know Ben is working on
> a tool). So it feels a little ugly to make it "gpgsm.program", since it
> really is a more generic format.

Okay, so signingtool.cms.program?  signingtool.smime.program?

I suppose Ben still intends to use the same command-line interface as
for gpgsm.

> Or would you be happy if we just turned the matcher into a whole-line
> substring or regex match?

A first line regex would probably be fine, if you want to go that way.
That, I think, is generic enough that we can make use of it down the
line, since it distinguishes all known formats, TTBOMK.

It would be nice if we could still continue to use gpg without having to
add specific configuration for it, at least for compatibility reasons.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlryLiEACgkQv1NdgR9S
9osa5BAAipC7BRu++H+GbPQCmYaSEnttaSwnQLHJ8DxlwMnbqQninwX56TI3zAZr
nNqVQmST0psmktWk37NzgLLkA7FH04+Fd81D1Mn+/intUwOrFgrlou/SgwE4rskS
70mYniXyfopij/Ts4qI4zAySc3d2/71K9yHFpe8s10tlSZWT1pVoOqPy+y48UJkM
3xZb1CGtiPeUMfa3eqx4fNXiFMoqETYSMipsS6rv2awTxkHPVw0xiQqEwd4tOG/X
l/1AhvgTuicT+IQ4IJrykE88FoEybLxxtw0KpzZhDwoy1W+n+WsTkjrDaX7a4tRL
R52Fw2bpR3P6y+q75u52PlDmWc3G7wzmE85wj9KRpSbRoW3BNpmRQMcSFnRVBK4v
Wy6mHSuyPCB7GpKfd2kII5nGP8r93zDUMRFEITMhgNM6YYcuBEzymWi8qr+3cUMn
JafRYGKStGAnBOLc2kF5bYIxLBFRVja06wlw/YYE8bBCN+LZUJZk+iAtxNoDD1D1
bM3nTPIDAyyyP92K0ZH2rVrqMXCeQ4e1LvUDqttBnhsw2w0Dt26BI12IllWEeZXj
P5RuJljwctMovdY0aawkt52RwOFsCQPuv3UhMjUaOjeFIQVaYbIdL6ZPpOVkN2Ey
Tz2xaAigjqAkF/DHMROkyRVn1RAfRQE4YLHxgftyr1yApoDXYEw=
=qLcl
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
