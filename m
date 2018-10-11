Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B721F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeJKH1M (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:27:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50114 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbeJKH1M (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Oct 2018 03:27:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D0AA461B7B;
        Thu, 11 Oct 2018 00:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539216158;
        bh=suPmv84sPrlu/z8lTS1B/0uVuIRYx7qLyI5a3gTKT20=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tnTZaQLG13msErPocNYt0IT9LOzmaNZiWETV05wFR8Q73WTPQk7tBTL2ouJeaP7tA
         7mFiLIwvKGH9L2Cs857oZz+j95U4lCBsQCkzXmuUFGGsPvvt425mVzoMI/OJNN/6dG
         X5hBPO8f/rSiKEZAupV4oZnvNF1BweSz5GhDNAnobOWp208NQkT0HXFy6TGBA1nDHq
         ef1B30Fs+FuCx/PQ9vjZsjv7ugYERXcCqWtCP6kpbO1Ya50iJsnuFv7N2LktaIFCdW
         9aIyMG4nAtPOjq4yGtHPqbUu7PYT0rzTLBdPwbYcbpcBmhEU4X9wW2j31kq0bmUB5w
         Wul0l9YN1ePMH4u7d8JScdjlMZi+um0sT26Vfmg/RJZJ+QK/s/pD/XIjKyWuX63V4o
         SgqqWgcPU0PfGgGSQ1mjDASi20aeHBu7EO46WFxUfHz0B6AHL6UIl5qnBts/snhOBW
         HZ/E+SpzGOjdUVugPKeDCaZdcppnWWfcwVDYnUp1FmCE3vaEpaQ
Date:   Thu, 11 Oct 2018 00:02:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
Message-ID: <20181011000233.GX432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lucas De Marchi <lucas.demarchi@intel.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, lucas.de.marchi@gmail.com
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+31Goo6fsQAntfNs"
Content-Disposition: inline
In-Reply-To: <20181010150916.4295-1-lucas.demarchi@intel.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+31Goo6fsQAntfNs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 08:09:16AM -0700, Lucas De Marchi wrote:
> Do like it's done in grep so mode doesn't end up as
> 0160000, which means range-diff doesn't work if one has
> "submodule.diff =3D log" in the configuration. Without this
> while using range-diff I only get a
>=20
>     Submodule a 0000000...0000000 (new submodule)
>=20
> instead of the diff between the revisions.
>=20
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  range-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/range-diff.c b/range-diff.c
> index 60edb2f518..bd8083f2d1 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const char =
*name, const char *p)
>  {
>  	struct diff_filespec *spec =3D alloc_filespec(name);
> =20
> -	fill_filespec(spec, &null_oid, 0, 0644);
> +	fill_filespec(spec, &null_oid, 0, 0100644);

If we have a system that has different mode values from the common Unix
ones, is this still correct or does it need to change?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+31Goo6fsQAntfNs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlu+kxkACgkQv1NdgR9S
9ouQQQ/7BNkyC0TPzXhFcRu3m0mzSXJuoj6sX3dGs7DKQIOik1Z1csbN9HTUtKoh
pGbq8vepVxb6OpvBkrppjaHWxXKQJRfxZIAt8p5upvjqzU6kr/SlLkNPwIa48Ox1
PjuhatMYHTP2VrilyLp7YYGjQz/fjqQmVDp1+bmurzOR2EN4SX7f108mZMsm4g2n
TyfYLty8t3ljGroyGBBOlHOAgZrjPCHkvDckImuWOTqy+5f6s9Ixb7t/JUtlu1Ro
1GGD3up1lmLpMqLahqRyLtLiLlYFslWdqRp1chGcljGSXrmR6Pq5Ip/W/9tLU2Zo
0mM6eAteK6xJrHM1lPCUvJ44Ip48pGy7JeKbxdn8aGtXZ4k8b12pNdZ8lDJ3jO0d
S3uI6PZnCyluF8h2o1gFzgZugLo+B/d07W5ClV7tFctsV3x8UcX80xFE0ys8Q69X
v8dhD4XB4yoC/sDd3eBcakk+ccHcDA7X7w3I5/OCedK/vHAW/PEib/soBiIyIJBI
j4P69IXPLuIZgM1HHF0KV/VK+IlQmUs9dOJWkI1sZwHCQAfx1UbEmY94gtQ07Eex
c4uN5nHedivBTSB+qpI5bdjsG7E28updVc4KD1gu1wAOX9QHfBMrUlR8rSn++OHq
vYyOLUv9PLKwrHdaY5a2sP5gFCZFIdKhL3xY/4TTkACPnkiLzNE=
=iynP
-----END PGP SIGNATURE-----

--+31Goo6fsQAntfNs--
