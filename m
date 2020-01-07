Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567A8C32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 02:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2222B2051A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 02:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="B8p1Glis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgAGCQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:16:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60718 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbgAGCQR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 21:16:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DFE8060787;
        Tue,  7 Jan 2020 02:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578363376;
        bh=Q4cP5Lg3IcPo9NJtKfqOGU84mzsqjPH+zuHkGTQ2Kqg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B8p1Glis9vZZ0DrxzijTNxlFrZ/y68ezYlFuNqy/TUywKuYRNXLejBJjtzXVITYaE
         lMGnyTG0kiNC7sj11dxWEJy/t1SDUlSFwKJDE1iun88oIxVVkf7lwtRO3Dpr0rloVH
         y95/Vf4KeTsMDVR48fuoLudqmo5fCFt39GZQuwJTKlFOth3t3YHfTz4jXpAY6kP6LK
         I5nlCQinzwAvumCJQrMmvDciOFEKbwqGsK8TWTAhQLv8UmIlHp0bRDR9nkv4y67tYf
         gsvBhFLkb8UFRfJy9OGWOTmuWWPho0h9ND4+cAo77uMIxkEsmtJY35BHdBTA8/0bQm
         3bSCzlEqZGd2x2nX4hRiTMmYJNCf/Nyb0uERtP2NYf7R+X3MXAqWsg39p0WYoiowTU
         HibTM7yWhBxdV6T5P5q8rlNPEGcLTFJ+4PUscMpjWExnfVx2mScWNW1h5Yp8N+NeEp
         /HwgyyKS/yobZVANRYufxY4n26KNMQvpT3Gr73puTTT+RobWRZW
Date:   Tue, 7 Jan 2020 02:16:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
Message-ID: <20200107021611.GK6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
 <20200107020425.GG92456@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9JSHP372f+2dzJ8X"
Content-Disposition: inline
In-Reply-To: <20200107020425.GG92456@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9JSHP372f+2dzJ8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-07 at 02:04:25, Jonathan Nieder wrote:
> brian m. carlson wrote:
>=20
> > In this function, we free the pointer we get from locate_in_PATH and
> > then check whether it's NULL.  However, this is undefined behavior if
> > the pointer is non-NULL, since the C standard no longer permits us to
> > use a valid pointer after freeing it.
> [...]
> > Noticed-by: Miriam R. <mirucam@gmail.com>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  run-command.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>=20
> This API that forces the caller to deal with the allocated result when
> they never asked for it seems a bit inconvenient.  Should we clean it up
> a little?  Something like this (on top):
>=20
> -- >8 --
> Subject: run-command: let caller pass in buffer to locate_in_PATH
>=20
> Instead of returning a buffer that the caller is responsible for
> freeing, use a strbuf output parameter to record the path to the
> searched-for program.
>=20
> This makes ownership a little easier to reason about, since the owning
> code declares the buffer.  It's a good habit to follow because it
> allows buffer reuse when calling such a function in a loop.
>=20
> It also allows the caller exists_in_PATH that does not care about the
> path to the command to be slightly simplified, by allowing a NULL
> output parameter that means that locate_in_PATH should take care of
> allocating and freeing its temporary buffer.

Sure, I think this is a nice improvement.  The user can reuse the buffer
in a loop if they want by resetting it, which as you point out would be
convenient (and potentially more efficient).  And we're already using
one internally, so there's no reason not to just pass one in.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9JSHP372f+2dzJ8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4T6esACgkQv1NdgR9S
9ovt4xAAzDsGEroDzWr6VS8qu3hpLMIb4TBS8ojhUgbVRDIrs5pncxqd6Z1UP/DC
kkgscWpU0oFg94NZqyiUJorm1NIscJjZX1oQ8sxxbFjMP0zoXcrWOvNc1fxr1iNp
AhcCE0ud/7+Nf9cDGFzRC8ADVM/tGi3ptU8ifIsQAClIkmTA5BZi0ajD0ZKWYYOW
v7pcE/jsF1fA/iZY4C9V8HRuHCYVkPvXVyROTCFuyoyZU6VupVP8BrjmVziyNFOW
qU/RaZ6HWtYbbAD+lhq2XJLHR63sSk8yjS8lbucTe289nXeJtHWKjKMe5KEbN/ro
QW5s8HHdDL9Cg+7ihy8pEx8wD6hV5VhNxyWFewZ08U4IEq/w7aFoMz200wu95k48
N9Ahp//LKAPYRnhel+lqq67TZ2uQyUeZ5X4xdMR5nEiZJMqypShuKxjepCLJa6kQ
d2uIc710qMV3yWWhyvHEhSaMPc5J8CbApXTdmH4kikjRNTWHVCysmquhrMMQbrgQ
iZE1mVPgDi9TFWhLblsc8bRU8vFGEZuu2KDhtw2xaLfxyApaGg3TEKzZSAzqvb8Z
T9PhhEX0Bn8lq3E79lDmFXtAZuqlR8Dd1qECuMKwRAe4drehNUIXANRVO+VNCqQn
xKm+4p0VWdt8ZtCDAklft7bqZaFf6AjHuszllMSRICjjjXw4Sjs=
=rSQF
-----END PGP SIGNATURE-----

--9JSHP372f+2dzJ8X--
