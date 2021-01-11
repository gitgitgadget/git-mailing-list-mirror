Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B4C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA3E22D57
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391801AbhALA0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:26:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51238 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404125AbhAKXbM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 18:31:12 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8900D60781;
        Mon, 11 Jan 2021 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610407801;
        bh=gFTY3SG7jZEUw+QLvT/Ri7eadQ3duB45PaWIVgZpYiY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sRN4k+9GkS6hhkt4LMXmGAIOvvtN6TPiBr7lOfijxuvT34BaIbk/v0XHQwRjVXi6K
         E4Bb5neJ0Xm0DLVTjl4lrYivygXvlAqepNXZRXBgTMqO7iWWG9NqQrTUws7hDQbrgt
         syIF3K52kReu8+bwdgAyWVgdztFjXjqk1DrznzluU2upI2dhAia9Tk3JICXar2NgTV
         PO7qSmg2S4w5v3nE6z1kUhJ9Bo+SvxVU5j8dI5OhcGI2CSPYbBJUc2acXONNIvlNmy
         yPy5tufh+6XuSIFw79mRR/4c9+aim3+8iY42dUez4fGDC1mvHb4G49DRxnMRihIz+X
         XIusTjFNTQn5GgsNLxQWiEPqnE/G4BIemIciiFw4kK9yBW7xAnMxjQSYpPOZsFcbzM
         P6XRdyV0Ctrq6GZdPYIEa3Nv8EVFgyi6/fIIRWOT3VVV2rHWXDPZCVeSrEZV5/37mO
         pkRWEVRJFOiDLeFt8NjBXCuzn2o8rnkXxRr6/idj8P3tWiPeAi0
Date:   Mon, 11 Jan 2021 23:29:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Support for commits signed by multiple algorithms
Message-ID: <X/zfdA8uUAdx0oEu@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
 <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <xmqq5z436rwe.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9MTyW25hekXqSiFh"
Content-Disposition: inline
In-Reply-To: <xmqq5z436rwe.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9MTyW25hekXqSiFh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-11 at 22:16:33, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This series introduces support for verifying commits and tags signed by
> > multiple algorithms.
> >
> > Originally, we had planned for SHA-256 tags to stuff the signature in a
> > header instead of using a trailing signature, and a patch to do that was
> > sent out in part 1/3.  Unfortunately, for whatever reason, that patch
> > didn't make it into the master branch, and so we use trailing signatures
> > there.
> >
> > We can't change this now, because otherwise it would be ambiguous
> > whether the trailing signature on a SHA-256 object was for the SHA-256
> > contents or whether the contents were a rewritten SHA-1 object with no
> > SHA-256 signature at all.
>=20
> How widely are SHA-256 tags in use in the real world, though?  Is it
> really too late to fix that already?

I don't know.  I don't know of any major hosting platform that supports
them, but of course many people may be using them independently on
self-hosted instances.

I don't think it matters one way or the other, honestly, because the
functionality is the same either way, whether we always put SHA-256 in a
header or whether we put the non-default algorithm in the header.
Multiply signed commits and tags are still unverifiable on older
versions because the older versions consider the header to be part of
the payload and not something to be stripped.

I just noticed this because I'm now getting to the case where we write
(and sign) both SHA-1 and SHA-256 versions of commits and I thought I'd
better send in a patch sooner rather than later, since there's a lot
more prep work (surprise) before we get to anything interesting.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--9MTyW25hekXqSiFh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/zfcwAKCRB8DEliiIei
gdY+AP9BH8VG/4WQHxrfqHzQGTde5kwsaEl3kMCVv9IXWgzD0wEAhzTrmUERTI82
Xy7t5Ydgovufhq4cKV+661NC6LWb+AI=
=Hlxe
-----END PGP SIGNATURE-----

--9MTyW25hekXqSiFh--
