Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4C4C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 01:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiFWBog (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 21:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357211AbiFWBoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 21:44:34 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34A9434B4
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 18:44:32 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B10F15A47F;
        Thu, 23 Jun 2022 01:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1655948671;
        bh=2ltS+TdxyMKE6SI9w5W6HGpdLPjrQ/2QjaeNvlZHGig=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AbqILJqWfDpfMswnhYT6dUHrff1+W89j3E5dLsRCjmF4VgMdFSkM+lMNOEHI1Aj71
         X6XnjZC1otzRwXfpFUzZdR8jFH1cNVUYkD80gOiApMGbbvZ5XqmzV5yC9yy5xIxrgA
         4gPqam0TIlhxyyGct0LrxEaVC05E8KJuQzdDm/Vde8B4fDk0u+Hex2DLu3d7yWhnfT
         TI4Q39x+E6hEz+7lvhcX9mpNYbkFPXyaUnd0m79Sm/HWGV09e85c51lPjr0uphnKxQ
         ZTOqZrEAe6rAyQEYuJBX+jVa+wR9DF8RIyvni/QFseem/bkT3yEYkQtVeayQWixSfu
         SeRRW0BY5C/97t5fLK11GYyn1GXKXvySVAXqevWGRq+H1PrwfMK/eOMKbpTyVV4xzk
         0yHkVT94FGqfBjJWr+psvjBgF9AfaBDLElz0VjMaYus9Mm0TICCKP2do5HgQ1XS/ty
         akhDmLLD/k2MgUlvDlJ4A4diNjCna5eLLiE701iPUU9YHV4oSul
Date:   Thu, 23 Jun 2022 01:44:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stephen Smith <ischis2@cox.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.org>
Subject: Re: SHA-256 transition
Message-ID: <YrPFfk5eIX55oO8R@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stephen Smith <ischis2@cox.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.org>
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <12092182.O9o76ZdvQC@thunderbird>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="egpKApm/c+Yyxugj"
Content-Disposition: inline
In-Reply-To: <12092182.O9o76ZdvQC@thunderbird>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--egpKApm/c+Yyxugj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-23 at 00:45:40, Stephen Smith wrote:
> On Tuesday, June 21, 2022 5:29:59 PM MST brian m. carlson wrote:
> > On 2022-06-21 at 10:25:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > > But the reason I'd still say "no" on the technical/UX side is:
> > >  * The inter-op between SHA-256 and SHA-1 repositories is still
> > > =20
> > >    nonexistent, except for a one-off import. I.e. we don't have any
> > >    graceful way to migrate an existing repository.
> >=20
> > True, but that doesn't meant that new repositories couldn't use SHA-256.
>=20
> So, any idea when a graceful way to migrate a repository might show up?

I'm hoping that my employer will give me time to work on this in the
future.  Perhaps I'll have more to show on this closer to the last
quarter of the year.

At the moment I happen to be very busy in my personal life, so I'm not
finding a great deal of time to code much of anything.  But if that
changes, I'll try to get back to it.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--egpKApm/c+Yyxugj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrPFfgAKCRB8DEliiIei
gQlcAP4ii1AwoHBRARQV2mRugiy0yZqBy5meXrwvyCrWyNojOgEA2+Bb1eRK0/3I
FBneWsI5CmeGCPy0xxNFlWpu2Bo7+QE=
=k4jn
-----END PGP SIGNATURE-----

--egpKApm/c+Yyxugj--
