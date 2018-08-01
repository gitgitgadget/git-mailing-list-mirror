Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9261F597
	for <e@80x24.org>; Wed,  1 Aug 2018 23:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeHBBNg (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 21:13:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41354 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbeHBBNg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Aug 2018 21:13:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b423:857:b27f:2f08])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DB61D6046D;
        Wed,  1 Aug 2018 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533165922;
        bh=mRXwZiafRj7moNiwVXkQOHeSgB8LddmSxr4y9AIz4jw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Co0RqqcV553SVrXL4gT5RlON9UFk5mbpAsQQnT4PFZKQXZT95mE+PPhlYs/UzObxq
         uDZBg2THhip1AnjvFs6BdwrlZyeuJm7w93QLFZ6ACHkstES8zf7Dxebxmjz33L8h14
         Ob4KUs9HsxrUNnITM0raf3b7yVg/HFB3Ke0odFsnexq2TgoO/Q7K8ipz/OAG9oV5bg
         F6wHKKguiIUN/Gs+7Yrq8gFYbI64RmDphuPB3EpfYTUxz2JUOob+FtexdsClFP1CpT
         MWYpipnYP6TXqxV1etMmGk9f7cPYEun07GAqOopr3SbF9JcPAyvJYqBdVf5sjFMZQP
         foSiRE2mtk/ydP8kRtvq1yfoE72DBt6VCVGmDObh7hOSRtI4ERSEdx09SRL72U0nZJ
         TylSmkD/IpeJVfkhWiyYGAFa3sALwxQRg+alNmDL1nOLO7/S3QkNMNTxOHnam8gEfu
         b+XafPRkZm+Be2S4gq6boDPy1aJGzi2PG1MFe3oL9Iqc7QRkesu
Date:   Wed, 1 Aug 2018 23:25:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
Message-ID: <20180801232517.GB106068@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2018 at 03:33:27AM -0400, Eric Sunshine wrote:
> This is a re-roll of [1] which fixes sequencer bugs resulting in commit
> object corruption when "rebase -i --root" swaps in a new commit as root.
> Unfortunately, those bugs made it into v2.18.0 and have already
> corrupted at least one repository (a local project of mine). Patches 3/4
> and 4/4 are new.
>=20
> v1 fixed these bugs:
>=20
> * trailing garbage on the commit's "author" header
>=20
> * extra trailing digit on "author" header's timezone (caused by two
>   separate bugs)
>=20
> v2 fixes those same bugs, plus:
>=20
> * eliminates a bogus "@" prepended to the "author" header timestamp
>   which renders the header corrupt
>=20
> * takes care to validate information coming from
>   "rebase-merge/author-script" before incorporating it into the "author"
>   header since that file may be hand-edited, and bogus hand-edited
>   values could corrupt the commit object.

I looked at this series and it seems sane and logical to me.  Thanks for
acting quickly to fix the corruption.

Reviewed-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltiQV0ACgkQv1NdgR9S
9ovWgA/+LKOE9TvyGWuDbbXVnD+hjOWAokHuKCbEwGLC9J3gPKViFshOsAC/qs0j
1l4VqZyQUAttcd0c5aNfSb+KP/KBRW4f/L7r0yG+QUc8C4Lv3ZUI4zPMkrgU+Bah
T24c0EQQPjFHnk+B6mwxNWEK+uq0qm0g/v6N3CBDb3x8iBWw8mKZih9oE78SAqqj
eWS0PbR/4hH7Lh68f1b7vi9Yi0fUMhMih8Eog+hHlhqNs2AV7t3t4KyJZzHWl+pj
FrHxawjLdg/P+hNy9oPnnmUW5NmVsPI6uQ9MxILrHEDJJgrJ4BPD+dNLmcUwtmDa
ziiFeMXml1nyrPgeDfrMrD3yQrsv534WODPK6hXmWLCf6MFM4saiOPey7PfsmIZX
4xklXJeDNw11HM9KmV+wlUT1SH6vyMrLrVX4uAbwgvFM5OO2zDRt/TcdRdQbM2f4
sc54TMUNaqLtN/WQQ0ddngwDSexnQk3bK90ylrVOKvOY64tfu81eqbfNW9VVMrLs
9dq801LKs9HaAu/OvQMz3LU1CLKEGsZEeBxEeo4cCfzFc4o+/SaFoiTqrnvDgZt+
kYOnd7KJh6Q4zAKLmyqGnyMyqqK1V8qck6Hnd8BBmL1IPXuPVnrjWXbu611KAteC
G9gzek95VW3HU6EgUWDnqLuRHW6UskJhQR9VIzFrMT3XRxDocmE=
=wkUa
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
