Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B799020899
	for <e@80x24.org>; Sun, 20 Aug 2017 20:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbdHTUhK (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 16:37:10 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56964 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753340AbdHTUhK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 16:37:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0DD40280AD;
        Sun, 20 Aug 2017 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503261429;
        bh=91ulmMnODuX71qRVvdTsYYRDRj+y0VDSXutppQxyoWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFkiw5jgDKsI+DW03e1yelxmaNoPG3LvKd1utSSbKOKYqg6zq2JXfXtp8Xwet2cKS
         qz5XMVjutI5aw7SRyJH2jTz95rUxBuBJgTE3yBztgYaPoqnGS0lfs7jjKyu+Ji3m/S
         symFxb/soNyylkWUinhY7XjHiQdYm/Ou5Y785M2ZunJ0skgxPblI+Z7FBxRoZVWEW2
         YFDxgRtj30ncKN1sRb+aOXbUMu/zdMkKq0yniTW67SrhvjhdNcmIh5UchtgOug9QfZ
         hhRcSGFtCJA13664vxE0sGDUxw6Oy9GjO8RpUUiDYlVWRIKr5DcRDsY5F7p+x/QrY9
         ggOX4C3LOmcVY3+ivqToGJ7Rw18PmiT+5Y7eoj4nJsfHIY03YSECYfFT9w9g1bnQvd
         6a/7twWKnuq8bfKBXYP0aZblMcVUVHdNyliTLOVb7v2LQS0yyL6qgIYP/Kl17j0t1w
         tfJbMdJFrswgzq1+45lnnlMX0Oac7CBI6NvzjfejaZ0O9w1Oxcd
Date:   Sun, 20 Aug 2017 20:37:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] sha1_file: convert hash_sha1_file_literally to
 struct object_id
Message-ID: <20170820203705.knec7ggodonh7j7y@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1503258223.git.patryk.obara@gmail.com>
 <0cbcf737983cd0a76269010f6a9028a03c8cac1d.1503258223.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x7figgbf23ugeiwy"
Content-Disposition: inline
In-Reply-To: <0cbcf737983cd0a76269010f6a9028a03c8cac1d.1503258223.git.patryk.obara@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x7figgbf23ugeiwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 10:09:30PM +0200, Patryk Obara wrote:
> Convert all remaining callers as well.
>=20
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  builtin/hash-object.c | 2 +-
>  cache.h               | 2 +-
>  sha1_file.c           | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 8a58ce0..c532ff9 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -24,7 +24,7 @@ static int hash_literally(struct object_id *oid, int fd=
, const char *type, unsig
>  	if (strbuf_read(&buf, fd, 4096) < 0)
>  		ret =3D -1;
>  	else
> -		ret =3D hash_sha1_file_literally(buf.buf, buf.len, type, oid->hash, fl=
ags);
> +		ret =3D hash_sha1_file_literally(buf.buf, buf.len, type, oid, flags);
>  	strbuf_release(&buf);
>  	return ret;
>  }
> diff --git a/cache.h b/cache.h
> index eaf3603..237adb5 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1199,7 +1199,7 @@ static inline const unsigned char *lookup_replace_o=
bject(const unsigned char *sh
>  extern int sha1_object_info(const unsigned char *, unsigned long *);
>  extern int hash_sha1_file(const void *buf, unsigned long len, const char=
 *type, unsigned char *sha1);
>  extern int write_sha1_file(const void *buf, unsigned long len, const cha=
r *type, unsigned char *return_sha1);
> -extern int hash_sha1_file_literally(const void *buf, unsigned long len, =
const char *type, unsigned char *sha1, unsigned flags);
> +extern int hash_sha1_file_literally(const void *buf, unsigned long len, =
const char *type, struct object_id *oid, unsigned flags);

We probably want to rename this function, since it no longer handles
exclusively SHA-1.  When I've made changes to the "_sha1_file"
functions, I've converted them to "_object_file" instead.  However, if
people like "_oid_file", we could do that instead.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--x7figgbf23ugeiwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.23 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmZ8vAACgkQv1NdgR9S
9osk6Q//fd39UPBcV3AHE2Yj/t13xz48H66VobXsIT9jUvrghl+yf0lta3SCqj0E
lzYkZfT76VNva29BgHhrkQkJOcJuPPiHgaLAk07kgoudrLFHIG7TmAmk6oxOlbiM
kYdL6AJ/nqHej7GdjA46r5L8Qm1yitF+Az39FEANl21CseVeaxNoORqrDIbVst1V
hmWCoqbWTlgLSWPaygA1YVaH7va08dQjHEqnyVzrCDf/ISZ/0htWEbb+DF2OO9QT
fkCJt9GZ/PoFC+JDOrtZxMiu4hxWKIjjZ4qAcigoA31Z/+XUJo5KErkNJmEiAMqe
6XvgNaX2hHRh8Z+AX4lffUUhUWv9GM1vw0o1eJR1IAbdfN7Mo3F74kd1jItfnmmW
rqX1QY4BcCrvzorpyiWGVe5Pn2YEvpa8onLbFa9TaWdZ2G4WGNvW7h8PDwFhsK+m
nmqgEqXmCl/XtEkcIjhTnO2+VAQlP666VY3gQYSGJkK1aa9rB76tlGbBI3V1iEGI
VaH6Bhp+gvlC3hvo1qwXem0SZ3lcHqMZWJbNCmndtgFBLQf6El9zpEB2+HkZDDBS
SCuN39edv0vFOd+JG9xR3iByU28TtilTYKmAs2tDM/9+5ckJPxf1q4A/exXz73I0
BtSQR83TXddg6OrpZ7m97D3vQZESr/yZJLUwxX4MSvNS8p/rqkw=
=wJ1y
-----END PGP SIGNATURE-----

--x7figgbf23ugeiwy--
