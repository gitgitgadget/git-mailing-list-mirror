Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A60C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC59A20724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ijOVpXe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgCVRLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:11:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgCVRLR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Mar 2020 13:11:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DFACB60478;
        Sun, 22 Mar 2020 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584897076;
        bh=C4jTx6agSag5sS/zxGHrhjBj07/CfPXiOq5EJexd1Vw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ijOVpXe0G2uIlTODhs6M3UXnZxv+0Nm6tutWYvEU0w2Aj3yjhYEJYzkFSdrGrZtD+
         LlRW/uAuEkxmqhy/I05i4ewdy5ugSKvxDi4Q7gXzZBQ/bj4BAtQpCdV5D+eErTviYn
         yYnesmzIllGoYYqEeS9K0WMQBo/XIGgpNV+W+qc3r/t0K7WswWoxCusUxUot9wyqNy
         tLWf7EwTL9BFO1/l44FpatLV2D1Cxj61yz64bBvcVLU2eLh93KW3GPVTYMchHJELqh
         vvqE5tYBVx/NwWr7r6p71U6+zJWI3X09D/ra24kEGZ76nj4x7wQGne0LOS1tC0LLEc
         xskm01xHwdxMjaaKYiHwam+jjxwCkA2qQR5fq3pLhQj7n5WN9DFkaI1nlt4gteoJen
         /iAOVjl5bQ0u6/5vlKTHaUxotUgkGsEDtV3qO4aXqwDjZC78bSuae1nupCaNdGFjfU
         57id8QpleWV57OEypuflUIPsXC11xKMYHAMIMPOToiYUps0aXKt
Date:   Sun, 22 Mar 2020 17:11:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t3419: drop EXPENSIVE tests
Message-ID: <20200322171111.GB6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <20200320213916.604658-1-sandals@crustytoothpaste.net>
 <20200322075140.GA600888@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20200322075140.GA600888@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-22 at 07:51:40, Jeff King wrote:
> When t3419 was originally written, it was designed to run a smaller test
> for correctness, and then the same test with a larger number of patches
> for performance. But it seems unlikely the latter was helping us:
>=20
>  - it was marked with EXPENSIVE, so hardly anybody ran it anyway
>=20
>  - there's no indication that it was more likely to find bugs than the
>    smaller case (the commit message isn't very helpful, but the original
>    cover letter describes it as: "The first patch adds correctness and
>    (optional) performance tests".
>=20
>  - the timing results are shown only via test_debug(). So also not run
>    unless the user says "-d", and then not provided in any
>    machine-readable form.
>=20
> If we're interested in performance regressions, a script in t/perf would
> be more appropriate. I didn't add one here, because it's not at all
> clear to me that what the script is timing is even all that interesting.
>=20
> Let's simplify the script by dropping the EXPENSIVE run. That in turn
> lets us drop the do_tests() wrapper, which lets us consistently use
> single-quotes for our test snippets. And we can drop the useless
> test_debug() timings, as well as their run() helper. And finally, while
> we're here, we can replace the count() helper with the standard
> test_seq().

I'm also fine with this solution.  As long as this test doesn't fail
with EXPENSIVE, I'm happy.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnecLwAKCRB8DEliiIei
gRNWAP4saSA9Dmz+9/XxduSaZmhZ35TZ9hZL84U1WmpNdzmrRQEAshRkqZfep7th
MLHvflCkc1Scb8DLJzAUn5+yYFsXxwc=
=tzqn
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
