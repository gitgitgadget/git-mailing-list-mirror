Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C9DC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F296206BF
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Cbyy8zQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZTsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:48:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37696 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgDZTsH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 15:48:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C1F9F6042C;
        Sun, 26 Apr 2020 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587930456;
        bh=7L0Y1V1bH0LvRtE9Y/+RvyeTOLq25cHvU9Cg5O9DgNc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Cbyy8zQsOXwmh6TiQNyDckWIiICaI3mY+hE0c8jlcadOdizQFpcDanNop4zF0/Nlx
         9mt0vbRyn4VCiY4KAuneDLFhjO3UuufNd50nuzIKnPYkLtecQbzUE1/V8oe7cmkJfP
         LBvAI0i4d+vWkKb8QkmGf0LFP+QxHNNcmyrgdQkCUWtJ5emVr9YEVY5AyLaaGoCMBD
         +iAg2VrKe3kr85kWIBiZ7aJq2F2OUKVuqpbUIUbQlnEkPvi5wDs0a5D0xxqez9VPtQ
         sgovoP9uI++Of1+WM+BHvgXCB63sXIXx3gUAnKBpfV6uya6NN3mn1IZsmC3KL4r2AG
         pI944bFaDgZFd1x7Yjy+zGE8CJn6rgbq3btEipXyXeFXssxk0lLNFFj+yp/T0NsemY
         GoF2TMO20R1hKOoCjPdjcTz0uJYZiyGqGDzyCfzvUYVxmyHU6k3ikfQtV3ohsaTXJO
         9yhU3B+2enNVgb6XU8qPG7XMPoOKSrG3/9KaC/DrOm5Ftcxfy/e
Date:   Sun, 26 Apr 2020 19:47:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git configure with static curl is failing
Message-ID: <20200426194729.GD6421@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Paul Smith <paul@mad-scientist.net>, Git List <git@vger.kernel.org>
References: <9d9fe8376e47a9f5330cd644c76d96987fc67c57.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <9d9fe8376e47a9f5330cd644c76d96987fc67c57.camel@mad-scientist.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-26 at 19:01:54, Paul Smith wrote:
> The problem appears to be that configure.ac is not using curl-config to
> obtain the correct options to link with curl.  If I run
> /other/curl/bin/curl-config --lib I get the proper flags:
>=20
>   $ /other/curl/bin/curl-config --libs
>   -L/other/curl/lib -lcurl -lssl -lz -lcrypto -ldl -lpthread
>=20
> If configure.ac tried to use $CURLDIR/bin/curl-config --libs to obtain
> the right linker options, then the link test for curl would work.

It doesn't surprise me that configure.ac doesn't use curl-config.  The
configure script is generally not used by the main developers in favor
of just using the makefile itself.

While we should fix that, the makefile does use curl-config, so if you
just use it with any appropriate options without running configure, it
will probably work for you.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqXlUQAKCRB8DEliiIei
gdLgAQCqlCAuu5rDu2zD3ARi9zxcuso9+LLht7W7HPW+RioBtwEAhNL6cdIYnuhK
VvYt2jOw/qrQM/8pUlJlw034ar5njAw=
=r5iP
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
