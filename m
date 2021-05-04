Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5286C43461
	for <git@archiver.kernel.org>; Tue,  4 May 2021 11:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D21613BC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 11:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEDLW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 07:22:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47530 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230151AbhEDLWJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 May 2021 07:22:09 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E2AB76042C;
        Tue,  4 May 2021 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620127243;
        bh=35VaNQ2RlqgMMxvO6U8EJmrOW/BIHVuU7a15mKJhasg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FLoMCWeNCAkqAYsBpHcK43Qkej4FXsajI497F0bAMo4nhAYzvnVIpVV1xjRFfOuTe
         QiMref1pB9KMJcG9mTpNWUYrmfi82WnNI8Wc420g49hk12ytDNOV0Hq9LS1/QLdrKD
         CISrdfXFKWEJ4VSh8YzHBzaWmvZwKvA55qhF/dma+8wMiknculZ1oPgNd6xJSAcnG7
         Vbv23L5nJebj03MqNvq1wS1JukK5Q1EZ+yOoW5abptDTZCJonleA69p2Nev4pKa4h1
         FEuPlKdo4HLiOscBdbKYeXAicTkCcos6zD8vW0T7ntbzcGV9r3h53IFgXbkCQDKJCY
         rSdsCQYu8ZsuhnQNx/RkKn2nw0NTazPEXQPfShgfHXHnljZd1+tPQwqFc/V0H3uo5M
         2ux/yIo1bmbdeETbjt1GanbavSiia3h2AY6n08+A4GVCPjf0SZZMGJH/U9THP7v7bY
         OTM6dtrrhnTRaqCr4OEiGkD47l4ojDNNN3KWaQrdEgjgvy0D+Tr
Date:   Tue, 4 May 2021 11:20:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
Message-ID: <YJEuBqVVa/7x+jrZ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
 <YJCABtAGT7s70jl1@camp.crustytoothpaste.net>
 <xmqqfsz36u0r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uqWXXGZYp/ZKDtqx"
Content-Disposition: inline
In-Reply-To: <xmqqfsz36u0r.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uqWXXGZYp/ZKDtqx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-04 at 03:46:12, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Yeah, this is because your operating system returns EINVAL in this case.
> > POSIX specifies EINVAL when you're trying to make a directory a
> > subdirectory of itself.  Which, I mean, I guess is a valid
> > interpretation here, but it of course makes renaming the path needlessly
> > difficult.
> > ...
> > I suspect part of the problem here is two fold: on macOS we can't
> > distinguish an attempt to rename the path due to it folding or
> > canonicalizing to the same thing from a real attempt to move an actual
> > directory into itself.  The latter would be a problem we'd want to
> > report, and the former is not.  Unfortunately, detecting this is
> > difficult because that means we'd have to implement the macOS
> > canonicalization algorithm in Git and we don't want to do that.
>=20
> I agree we'd probably need to resort to macOS specific hack (like we
> have NFS or Coda specific hacks), but it may not be too bad.
>=20
> After seeing EINVAL, we can lstat src 'foo' and dst 'FOO', and
> realize that both are directories and have the same st_dev/st_ino,
> which should be fairly straightforward, no?
>=20
> For that, we do not exactly have to depend on any part of macOS-ism;
> we do depend on the traditional "within the same device, inum is a
> good way to tell if two filesystem entities are the same".

Yes, although that won't work on Windows, which I don't believe has the
concept of inodes and almost certainly has the same problem.  CCing
Dscho in case he has some ideas on how we can make this more resilient
there.

In any event, I'm not planning on writing a patch for this since I have
no way to test it, but I'm sure someone who uses macOS could probably
write one reasonably easily.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--uqWXXGZYp/ZKDtqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJEuBgAKCRB8DEliiIei
gQyYAQCsVG0psYwuoCL6yymjwcYMWChdyUfWUdHkHolAcePVSgEAjBm3PFX3f8li
0OfacWtt/cpQpeI26YILcdBsvVZF6w4=
=pZCD
-----END PGP SIGNATURE-----

--uqWXXGZYp/ZKDtqx--
