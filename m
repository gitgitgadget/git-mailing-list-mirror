Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70476C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4594321D56
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 22:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iksiKpiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAQWhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:37:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41070 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728596AbgAQWhl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Jan 2020 17:37:41 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3C196607F5;
        Fri, 17 Jan 2020 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579300659;
        bh=BpIYUCms/WmgXE9qUzVvAZYB9E9uEyj30uH59KkzmOk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iksiKpiEphMSQe/tBiLp3/sv36shJYRaG9589QrZOhzCbC+KHinTZpKBYqqDW2+EN
         E6xK0enwmyWMTlCJKy7MY77hWxtDpordrlOT0iAqohj6xtTol6GcExnLtSaT+U+hci
         x1d6P22NDAG4zzQ0XX9iuYlC/19odpTwbj0G6mkE4JztfOWn1Eh6Cl87kiQGZZcGUB
         ZTCqD4nA0Wrye+qbJ+D7TYXDrbXe7zreLVdSSJTSjQxfzlM2tX4AFaTpdmIMfzU4cb
         dkHl5JZYHW6gCgkeizm98BOJhz5B6rbXuPCh/mrXL+NLNZTSb+DF63zLgnBUxXJ0o8
         izUmG0N5xejiqYnwX9OhOcxWHpwitEshWEDBtSLBCz7aSCylV+NXtT6fprSXRVxZJu
         WfRXCtxUyFcdVwLjY8WRiPb8lkMzN5QiHxefsMqGd9Ae4yoRrFt0feZcCJRRoTZKdO
         UMNxOYDWScDWGd6ZhYyf/U5JtEcyAwuEPaWTt7ZrezlX2mkOVaR
Date:   Fri, 17 Jan 2020 22:37:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Re-fix rebase -i with SHA-1 collisions
Message-ID: <20200117223734.GA6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
 <20200116235411.GZ6570@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2001171050000.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oh6wehMCKJhhoxlo"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001171050000.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Oh6wehMCKJhhoxlo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-17 at 09:51:42, Johannes Schindelin wrote:
> > This series looks great to me, and thanks for fixing this.
> >
> > As mentioned in the PR, I'm happy for you to drop the SHA-256 patch into
> > this series if you like, or I can carry it in a future series.  Either
> > way is fine with me.
>=20
> Excellent. Given that the re-fix to avoid short commit ID collisions has
> little to do with supporting SHA-256, I would like to keep the patch
> series separate, then.
>=20
> The question whether to move the SHA-256 support patch into your series is
> more a question to Junio, i.e. which patch series will be merged down
> faster.

I need to do a reroll of part 8, so I'll pick it into a future series
(part 9) of test fixes and drop my patch.  That way it won't interfere
with either series making progress, but it will still be included at the
end.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Oh6wehMCKJhhoxlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4iNy4ACgkQv1NdgR9S
9ovwwBAAkBauEqjtA+CwuFRw1DVOyVxWJSvIf/42vQ2Djt+Q6wj9eRzMJXJ85QEY
9Pdw47iZ1R43hPLy7vLngnh+Oxw98jSDielHR+L/4I8fGsJ6UcARKS/KMdqDPB7Z
sNcU44VJ+oSN0ohRG+5iNhQfj2oR9ngJybUSlgQd6I372kqRt19yFyTK/p6eTrm6
gpc5ym/Abf6FpUBFj4syXFyK/wu/LKqXNDS/ybcfkN4r/6StIl+sEAytO7ZuEcDF
vNHgJbA8n0cX0YgWWn0d76vaZ4+Uf59QEL6WiST9wEFbo00NiWsgUj/wvfGlFd4Y
yb2z6eFt8OXbpdXNRTexwi9dzXyJN6QCW1zDSAJV4jmZXrxwjZWcjyHDjmEjFM+G
zvilEyasURhh8n/UcSUIMyMQe0b7PswcbyRKgU1AIAZnGY/d+dB0d6KZmIadNVu4
hmy0X0t91uPBGfd3EwtM7/tnvXWD5cdmCItyRk0pY6PI7PBvUywBbynPioBJnosc
6h3jhjdmjsMIeVASYXxHt9ZV4g8KUuvorTRnsU/Mt4/nL6/kikVQZK3nfxLYK/OV
aQSdHB/nUNxXU+pOwv5tlHOdiv7Z05XXEQg++hfzejfbpiV5MKP5ebWyGeXJEeVT
GQuckOeaTVEZy1NcqQhn9AJlvYFmaER4NYG1gN1jBPLlbR67VqA=
=JzCz
-----END PGP SIGNATURE-----

--Oh6wehMCKJhhoxlo--
