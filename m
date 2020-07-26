Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D2C433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F00206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OMp5ORVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGZTCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:02:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40642 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgGZTCU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:02:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4BCCB607A2;
        Sun, 26 Jul 2020 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595790139;
        bh=LwnCDRaDwG1SBaxAjPVy8/jd/gs4zENjXf9C1eLSNsY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OMp5ORVKefy74aCt1+6CzHDnPrV/uaGPQvnxazuBwB6Cn2GwcZ1KrM9Apyp7KavfI
         eC4wIqWCJUNzepJKznwY2mEW4MLx7+SWKwQHFjyPtXGSQRT4GvrkBJ1vwT312xtpgP
         Wdo7ZEb7h4iUOh1DsH3+Jl+OQscACY7kuDVbbyg1WnKMVFrLVnjAKhNRhrEFWectaV
         5RNGvLHvbxkqh0P8BdZTijkRsphur1g+N/MhsH/bvPU5HpaRRQqYSaannGvUSKD8QE
         0AF/aOniB/ljdl5wOwfkRypa/TuKTyFn3/b6k7NvBl6rOmGQH97LsSJCKmZm+8IO6Y
         4sr/MD/tpnO1wFjThWN+BKgS6r1R6I8ZWUtUt1AeLIjWJGcDSNTPROe4iGhFnLXhSR
         zQ+cKT6WqetdooHLKbpKvNhZ2gj9VHKyNzXxvbZHsROIGAu7ru+VdhMRLQC9W7mRoH
         88os2vJyP4tg8PYKBwJKjuqu3ygUt7hESxxj/W9VVSLYn506t33
Date:   Sun, 26 Jul 2020 19:02:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH] bisect: use oid_to_hex_r() instead of
 memcpy()+oid_to_hex()
Message-ID: <20200726190214.GB6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>
References: <c2f9ec40-71f5-122c-add8-08d6a4bfa859@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <c2f9ec40-71f5-122c-add8-08d6a4bfa859@web.de>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-26 at 17:41:12, Ren=C3=A9 Scharfe wrote:
> Write the hexadecimal object ID directly into the destination buffer
> using oid_to_hex_r() instead of writing it into a static buffer first
> using oid_to_hex() and then copying it from there using memcpy().
> This is shorter, simpler and a bit more efficient.
>=20
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  bisect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bisect.c b/bisect.c
> index d5e830410f..be3ff1e962 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -709,7 +709,7 @@ static enum bisect_error bisect_checkout(const struct=
 object_id *bisect_rev, int
>  	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>  	enum bisect_error res =3D BISECT_OK;
>=20
> -	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), the_hash_algo->hexsz + 1=
);
> +	oid_to_hex_r(bisect_rev_hex, bisect_rev);
>  	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REF=
S_DIE_ON_ERR);
>=20
>  	argv_checkout[2] =3D bisect_rev_hex;

Yeah, this seems better in pretty much every way, and as a nice perk we
lose an explicit dependency on the_hash_algo.
--=20
brian m. carlson: Houston, Texas, US

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXx3TNAAKCRB8DEliiIei
gR78AQCIzZYdhqccbxu7Ns9ivjJL79K0sXtFOdXqtG1d2LHM9gEA/G5Ao2UdinXC
zzpi74KrlhFYxIUHmS3MoIoebbG6ewU=
=dqDh
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
