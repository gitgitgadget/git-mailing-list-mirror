Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20899C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 23:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiADXMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:12:15 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:59482 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiADXMP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 18:12:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 38B035B214;
        Tue,  4 Jan 2022 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641337934;
        bh=QO5Wp/qZmZUBj/lPtugIwtrAk/hx+h5Mpv2Mllh9fJM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lMV6/AKYBZ76oMTffgpmy4HQjyMUF3MIoNPuyhtidtjGUTd3Xu8vgNlL7SKwv6Sg4
         5/8G0b3npQf0kRV2y0PsfWm9edenhLVrplZQ0Ss97kBzLDUOIA+04sjCq+1Jousrc/
         qGNia6rqcV6yo6Spe5tpNR9t0x8YhziWU6WmbjSeYTgcvvXc4l5paTPGmFWHRWPpp0
         ATDRS4MsXhfG6Csohw+O5wmfP9AzED5k/ceEjYo/L9WL1fr9sYD+Wy4Ea+j/PLdTH3
         Qu0Y2WLZG74HdhhxhGqCBWIPe9PmEyhEXnxlTvqEMkXZyGEG933tcFDahbie5AWxFD
         yTMS75FE3TCjlQzg3iTpF+y+mqzukTjTrVO9oX5tND4WJfiOz8JG2hHITil91PKa0f
         GFCy1wFBxIzbLLtSNMuq/XPNasxki1iDm1ZC2lJRAVHl+EB2kIavjXzj7fOiSzx7eA
         KK39MYNPoLa5DNVsUG6KweZDsUAcYZTLphVnJpYDoGmJLVHgsWB
Date:   Tue, 4 Jan 2022 23:12:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH v2 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YdTUTASUsJg3DJb2@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220104015555.3387101-2-sandals@crustytoothpaste.net>
 <xmqqsfu3b4gw.fsf@gitster.g>
 <xmqqlezvb2p2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9z8lXYSads1m+hb"
Content-Disposition: inline
In-Reply-To: <xmqqlezvb2p2.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v9z8lXYSads1m+hb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-04 at 21:39:37, Junio C Hamano wrote:
> Another thought.  As far as I can see on the C code side in the
> later part of the patch, we are prepared to see multiple HAVE_* for
> CSPRNG defined by the builders, and let us choose the best one for
> them.  I wonder if it makes sense to allow
>=20
>     make CSPRNG_METHOD=3D'arc4random getentropy'
>=20
> as a way to tell us that they have these two and want us to pick the
> best one for them. =20
>=20
> It does not add much value for human builders, but I suspect that it
> would make it simpler when we need to add autoconf support. =20

That shouldn't be a big deal.  I can do that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--v9z8lXYSads1m+hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdTUSwAKCRB8DEliiIei
gWqOAQCvrn9i8VlFqF14ISfN9SIuiB/inNqX8PPhWJh1pIA7qAEA5gaKOwKTVUrD
8b8SAHdGFIlUhj6px9oRDEw2nX8QcQM=
=5XHw
-----END PGP SIGNATURE-----

--v9z8lXYSads1m+hb--
