Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1213B215F4
	for <e@80x24.org>; Tue,  1 May 2018 01:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeEABN7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 21:13:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36948 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751298AbeEABN7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Apr 2018 21:13:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7DD7C60129;
        Tue,  1 May 2018 01:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525137237;
        bh=VHA29J1uje+3rV1MCAc/Iu4joFBcq6mXs/psGsaPMX0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TvxQ3kDBtLLYyVicdpVxUAcmeQLBiHpT6UrXR7h++X3jxUx7Gfg7dfyRq1uqQwvhh
         0u10OJvF/UhooIh1vASuN/lgsTTZ3h/hsgjzUTMp4+f3O4fdBN6LDN+ZRoUDWHZUi3
         uJw4OxnRYhEg5okrb0DoM3CC5Bsf7RT1+U6C83urdBWggbyTCf5a9cKfHJZZe9n77X
         TLMb3f9wnuK2i0XC20pfGz3TKQ9V91lj5WpKYYGCzZ+BAlax18pOXPFS/Nq7s1QJpV
         X+YovOxd5X7iKHQb8Q0J32NbDaTvnoBQbF5oPfSg5dFZaww+O3xMO67AD9wbs1+G3U
         7oc6iRWH9gkU33vkaKLQwx+1Lq3GhqFbMB1FOs6NU3DOK4HlSgEaGuoQ/4HRTsomFF
         75dVvDhH4cBwbaGJvjJYG3PD2PQHl2IkMWd++PvjYjiUEduCNIHbXDdXOEDSFVpK6/
         dhAxetFGEa8J2LWuiiamjjrK1oHLZzd/uaY/khVeyV5WR/vLNnW
Date:   Tue, 1 May 2018 01:13:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] get_short_oid / peel_onion: ^{tree} should mean
 tree, not treeish
Message-ID: <20180501011351.GD13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <20180430220734.30133-1-avarab@gmail.com>
 <20180430220734.30133-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20180430220734.30133-8-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 10:07:32PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> diff --git a/sha1-name.c b/sha1-name.c
> index 023f9471a8..b61c0558d9 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -970,7 +970,7 @@ static int peel_onion(const char *name, int len, stru=
ct object_id *oid,
>  	else if (expected_type =3D=3D OBJ_TAG)
>  		lookup_flags |=3D GET_OID_TAG;
>  	else if (expected_type =3D=3D OBJ_TREE)
> -		lookup_flags |=3D GET_OID_TREEISH;
> +		lookup_flags |=3D GET_OID_TREE;
>  	else if (expected_type =3D=3D OBJ_BLOB)
>  		lookup_flags |=3D GET_OID_BLOB;
> =20

I was concerned at first that this might lead to some sort of wrong
behavior when we do something like "git rev-parse v2.17.0^{tree}", but
looking at the code I've mostly convinced myself that that should still
work.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrnv08ACgkQv1NdgR9S
9ovOHg/+N+7+9mJLfMLud+HYWQqzanm5rfxmOQ27djdqc38Tww8IHhcEWYoxsiO3
YZ6X+QwunyvjYqcxHyUiM5dLxEtjMbI6z8pc8Voa8CwoEhUU31LJ81FypTEpj+Uv
qxppWLgoA0pnF0/tH5XwxF3bpbcEQCwaBZGJS2aYWJ/AExcSf1LUP6JvX1bHYWDv
lcx+5z1/Q+Oi93s1TUQ0A/ouxlsQOjaJQeko4RmyNx4MvnhZzZTdPjrzMQWJg8SQ
dp5vd63FQ80o5lJwSZKh8LdUOGQcSgNHChh3sBx/H98N/MSRv2Uvi5fBTROEnC5m
nBbLc3jT0NJ8kDzlRNBFta4pqmr/xrQaq13bM26s7tjpVjflZUvPVD6cyDTrcHoG
qiFen9FfaG+yh68aSLPGGtbhQm6Zh7BLHq5yf9HWI5zkOO6/Lkr7F4nAmm3/nGHi
a7HZ/UWEwtBr+iUHMxEAJpNAnLLf9havUS0qubeifEk8NKgBHzc5MtiZ7LF+1SHw
Nkl2K8yR2sPixGgUUcV5TFo6IYOFQtcLzm3VqjgRZQvv58paYypDGNqTiyfT4QOg
62czRf+cyVckii7jZgFUeLAgsg0JpiayK68MvmmFByFGu8D6EY2qX5M6+8bnX6O8
O79fUH80DqER4wn3Z6D8b0E8nuQg3lc017qRD+qNLGtteqWUe0Q=
=PW5Y
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
