Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2514EC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 13:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhK3NU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbhK3NU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 08:20:58 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4AC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 05:17:39 -0800 (PST)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4E4B15CB78;
        Tue, 30 Nov 2021 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1638278258;
        bh=vDry8NDi7NKULQ6PetTPr71ke5LCpU+3nPZ2NM8bRB8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zooHaBGk8Be7XCS4COCp4HSAX7Ifm3tFcUWn1IPVaEHK9m8ZRKgG4YtYg/htmHVdW
         OtvtrSNv9oTnHCdtd1FrdcV/P7RplGPd2Uz3Ojm3dmRArpsP7s48BxxMoC4t7rc2AR
         W4Ve09fSMW7F6Gq5JQKjH6s7j2ChViEUOnB6kohAYu7/C24aKqTRfy129T5ecaRyq+
         +vSbRyh8OoLiKO4DiszAzDwNhPvvJjoF8WHQH3hXKjJH3/NqxFF6Ztr8fLmq801pLv
         3u0lcaRYn/4lNZruRv9KX93343+2LrJlKyhhQJqYAocf7ZlCQGV3tbIMXBlc828b5L
         rHQphLyKOILGGIcSGvF26JcNtEjGObdICVWBJhgf2Z7AvJHgNIfbncwCCfRVDl+d08
         3oFplqBhBNCpfqWBafzDf1LNFf8+jfbll/ubBob3BehIkuh44Gw9mKYvyygkL00ZoR
         IAttDfIVKQ6X+yXKFe+/yK6CIIwh+N1AL24j1quo26frQ6f3r17
Date:   Tue, 30 Nov 2021 13:17:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: jk/loosen-urlmatch, was What's cooking in git.git (Nov 2021,
 #07; Mon, 29)
Message-ID: <YaYkcLNPODqzQNgu@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <YaXTxTW9ihC1/deN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5oqhuEtRU3JSWcR"
Content-Disposition: inline
In-Reply-To: <YaXTxTW9ihC1/deN@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u5oqhuEtRU3JSWcR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-30 at 07:33:25, Jeff King wrote:
> On Mon, Nov 29, 2021 at 06:16:54PM -0800, Junio C Hamano wrote:
>=20
> > --------------------------------------------------
> > [Graduated to 'master']
> >
> > [...]
> > * jk/loosen-urlmatch (2021-10-12) 1 commit
> >   (merged to 'next' on 2021-10-25 at f66ca39ebe)
> >  + urlmatch: add underscore to URL_HOST_CHARS
> >=20
> >  Treat "_" as any other URL-valid characters in an URL when matching
> >  the per-URL configuration variable names.
>=20
> Sorry, I hadn't noticed that this one had even made it to 'next', and
> was surprised to see it graduate.
>=20
> I think brian corrected my assertion in the commit message that RFC 1738
> says that underscores are OK. They are for URIs in general, but not the
> specific case of hostnames in HTTP schemes.

=46rom my memory of the research I did, they're okay for URIs according to
the grammar, but they're acceptable only if you're using something that
isn't DNS, which as a practical matter is never the case.

> Now that isn't strictly a reason to drop the patch. Even though
> underscores aren't allowed, they do work in some limited circumstances,
> and curl is happy to take them. So in some sense this is harmonizing our
> urlmatch behavior with curl for an iffy-but-workable practice, and there
> may be value in that. But it does take us further away from the
> standards, which could possibly have surprising consequences down the
> road.
>=20
> I don't have a strong feeling either way on reverting it at this point.
> But I wanted to make sure that if we kept it in, we were doing so
> consciously, and not just because folks involved in the discussion
> didn't realize it was still working its way through the process.

I don't think it's necessarily worth reverting, but we should avoid
continuing to make further improvements in this area.  In other words,
we shouldn't take this as an opportunity to support more of this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--u5oqhuEtRU3JSWcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYaYkbwAKCRB8DEliiIei
gU5bAP9giA5FxaeYv5B2tigEvwqUe7E3A3eKJsTR8y0RYRwQ8AEAkGIsYJ6g/y0F
FcTw1jIfNqRM/o9MRPZ1DUI/SuKYXgU=
=3wY+
-----END PGP SIGNATURE-----

--u5oqhuEtRU3JSWcR--
