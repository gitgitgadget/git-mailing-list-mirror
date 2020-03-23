Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A0C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F59C20409
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 23:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C9gQOQHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCWXN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:13:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60442 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbgCWXN5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Mar 2020 19:13:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E6F216077B;
        Mon, 23 Mar 2020 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585005237;
        bh=MOn3p717lfEa86KxrwTTwSXTboEVwP8IIsHD68tWZ88=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=C9gQOQHOBuQ7m3ygUzdPOPkSIhA487lpwAmkHscNuvUc2UUQ0ZSaG5r4paE8ph7QK
         pjV8XZOLdNeylXc0K4RPrz1BAf7mSp/uoEvnT9rNkPejaNskq/sixbOZE21at+s+Oo
         qZiRlwkYGnC8bmhdxronHauyw+Us9hyu2pMyGBeLl7/nR3M+6G/wKVozZiuAbv7mY6
         yzxAJBKKk2PwgYyrCOzGjeoovG7j1/u/LIGVqWylRY1z4Srb3e+UVcs0d8CiMDFjPB
         +c3wyVzQHuudvtFIN44nWexRR4iJ5WNgenejL+qlCXq5WxgG/Efggi6gVI5GEaudMg
         d+a/+2QNEtoMDiU+pmJPBym/LJ5V0FIqFfXBTZ46PajKUzhaDaX+Er068m3UfcLjFL
         9PxiUulL8ljYFAuEg9N+1P9IVZVX8xweIVDyzYFtsIzIAEq2UwG+luI65LGj5R8Xck
         1mSUY7XE8bgEc3QlyQhxqvOiwBQ/NqYTBY2J62OFV/yK65h3v6D
Date:   Mon, 23 Mar 2020 23:13:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Smalls <jon@smalls.rocks>
Cc:     git@vger.kernel.org,
        Torey Adler - NOAA Federal <torey.adler@noaa.gov>
Subject: Re: git > 2.10.1 fails to update index on macOS 10.14.5
Message-ID: <20200323231351.GD6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Smalls <jon@smalls.rocks>, git@vger.kernel.org,
        Torey Adler - NOAA Federal <torey.adler@noaa.gov>
References: <7b8b23f8-e12a-bde9-4b9e-ca8c908d1203@smalls.rocks>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <7b8b23f8-e12a-bde9-4b9e-ca8c908d1203@smalls.rocks>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-23 at 14:37:30, Jonathan Smalls wrote:
> After upgrading my work station, I found in git-2.22 that git would not
> recognize any file changes until I ran  `git reset --hard`. I thought that
> it was a problem with my own settings.
> 	However I upgraded to git-2.25, and the problem actually got worse. In 2=
=2E25
> the index still failed to update, but `git reset --hard` no longer had any
> effect.

I have a bunch of colleagues who use the latest Git on macOS, so I
expect it does work most of the time.  Let's see if we can figure out
what's going on here.

What exactly do you mean by "doesn't recognize any file changes"?  Can
you tell us what commands you ran and what you expected to see, and what
you actually saw?  That information would be helpful for us to track
down what might be happening.

Also, are you using any specific workflow or tool that might be related?
Are you using an editor integration or GUI, and if so, does this happen
without that editor integration or GUI as well?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnlCrwAKCRB8DEliiIei
gZ4qAP47GXpKdj+oFY0c1qVnmGz9D3HyJKuma+VnkQtiiDhULgEA45+TwFRevUrU
4+6ckVrFWnwMz4qbyPLE2TuF3Ui/Uww=
=JIKs
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
