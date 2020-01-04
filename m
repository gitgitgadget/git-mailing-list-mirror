Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F1DC32771
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 20:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D160E22B48
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZgpDlz4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgADU6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 15:58:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58916 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgADU6K (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Jan 2020 15:58:10 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 93E6D60787;
        Sat,  4 Jan 2020 20:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578171488;
        bh=jI3dMrOsZ8zaR4uAqxY4r0IxoM9RAqFAjsRouBPOXwc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZgpDlz4NV9oyiu4fWS2PMK1NIKyhwLOgFgfJx0KE2P0vbWJ+MbxpsXBM3qN/LSUt1
         G2W3SoiBr+OGJevZJP4McF+HUxobY7uhObl+Fdx5It+dcnT2ds5zUqPT/nM52J8W8u
         adgOj6zWQy+96I9/jSb7E199ExEUZ56MwkTqlIatJoQINwZQubYoxlo7xRzjjzRGJM
         XkH0y8SwyxzeIkDT2tOE7+Pq3PvrgL7QGPLPnkSFSuBspky/dmqeKvuHHEHMi0n+tM
         6NhpXw1vQVQE6jNWjB3KKNhlb/QJte+Oei5TDq2GQuCiA2lFbRhsIt3XlG9WXeCjzX
         pg3LrsrTD2vTSEPf6USwpHvnsWQP4sKuB7h2C6AdjSRbIezXyWBsqbovwLJMgh1UG+
         3dCuAhTJnrqjAP0ziT6D1a8hlboRuwHPClt/tmnxuEljAynpb/e62sU5OzOOXX8h7d
         oNLCKLTvtpBSVKXVouQ/Lb1tSUkoQ5152UadTsbr2MaH/84CApj
Date:   Sat, 4 Jan 2020 20:58:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: Testsuite failures on ppc64, sparc64 and s390x (64-bit BE)
Message-ID: <20200104205803.GE6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        git@vger.kernel.org
References: <34ed7497-643e-5a38-d68c-7c075b647bcd@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <34ed7497-643e-5a38-d68c-7c075b647bcd@physik.fu-berlin.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-04 at 20:14:31, John Paul Adrian Glaubitz wrote:
> Hi!
>=20
> It seems that git is failing its testsuite on all 64-bit Big-Endian targe=
ts,
> full build log can be found in [1]. There seem to be multiple failures.
>=20
> The issue first showed with 2.25-rc1 [2].

This is interesting, because there are different failures on different
platforms.  s390x shows failures only in t9100, which is one of the svn
tests.  From the diff between rc0 and rc1, I don't see anything which
should affect git-svn in that way.

ppc64 and sparc64 failing a lot more tests, mostly due to segfaults, but
=66rom a cursory glance they all appear to be SVN-related.

Are we sure that some dependency of libsvn1 hasn't caused this problem?
I noticed that all of the broken builds seem to have libserf-1-1
1.3.9-8, which appears to have received an overhaul recently.  Of
course, it could be something else as well.

I got rid of my UltraSPARC hardware when I last moved, so I won't be
looking into this further, but it seems unlikely to me that the problem
is in Git when the only non-Windows C change between the two versions is
a one-line file name change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4Q/FsACgkQv1NdgR9S
9osXUw//Uq71VStVFabnwVASl79PrxNfbhLChTaTf5fwc4TvrpdHE0AmkSKy/bNL
x5Bp9/BKXShUmNHfNw2p+SiDjUdUQKkO6iH4XBdZPruPPWcUm9P4yxjRP4TTm3AQ
MlvOMFUXUH5MXTaaMhFdQUS4dEmKKxR5AGeJyQ3aB2Gty2dOU5bBYa71wJiq4WGp
WUy5o5wE7BhJ87Q4ymihhgKQ+6N3mqv+HWIBeGnpeut++NqEBblSIOlO3c5tTVzG
fFId1s0+K6bDCZmBhXRiP+d8R51xarqn+0FyBLsphNCEgZgmZ9T8w5YDzAgJUYpS
qRxAAdV68UNytH/eEqH6Y7Bie62f3zSXIYa/3fIY8BttWGsm7mJpv/k9Td2IV/T/
s0kWp2ZB19oPtoAwmnhUOawwRNnibcnTDePpfqbxh1J12daLSXPmvgKbglAK/2HC
uK5GDznQor/myf3OxqZdP00CX1Weg38HIKp8t4EHrh478QEdoy/Pw+q9f1Vd5thf
J0xRRu62d/B6+ZovxFtZyFXO5SVPVqNhE1oz8VkxBED3agqrMUnw4E1qu+Df1raL
cTNm2uYpfDCU367HUUsTB/PMMevgTP7cIWPFKVGhmdSJ7EV623uhq9rEgoDSj8EY
C1ls9PYO+HfgkRIdjDvOwppLNLw94nkN544n7dbDnxRxkZU4jTY=
=KKUv
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
