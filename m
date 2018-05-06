Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79B9200B9
	for <e@80x24.org>; Sun,  6 May 2018 21:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEFVJu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 17:09:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40954 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751833AbeEFVJt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 17:09:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 635B560444;
        Sun,  6 May 2018 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525640988;
        bh=OhaL38ughvsNtWyOzp6ve4DtYEKtzNlgqAMSHAMQcLo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nvBR+Hk1/CmuCtzpJBLfxBnfRsGC4elXkMIk5ACEBi5h/DEuN/nmdiVc9p2jFQWaA
         tD0ILXiOw8kFsvIRx3ruBjT65tg4KMoe8nYM8iqOYR39FN02ph9wm1BQhP5QvK0KJt
         jbUbdXzWm91+KxRVx3wA8qZgSHG0DW/DERCZ4z8ynaW9ymMO50sNm7lrg98A/+40Gb
         MYun/ic2rXPseKdPQfVNp0G09elQS09TThW2AyZ89c7I3/MB/LllQLitDdXCyLas/d
         yA7DtULQ0gx/zUUEZsqx0uW79ABONecm1li1Y/qVI7uK/hWRo1hqd0jSj87nfFueLR
         MH1Rni6aEaXV3ZA2E7CSPAqkQkwJVHTT8JbL7MaBp88XXttsm+6gsuvaQl4nxl78s2
         xyuoxpy1cWv/O7hZVJKyMA9TbuzpIu+VfT3I/dEBv5xLxYmL3QPblTgW9PyVIEFA7m
         0WDkS3Glxwo7HqAc8GR4uuQczaiyeCgVB0s5HPbD61fZQVbOKVj
Date:   Sun, 6 May 2018 21:09:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Shulhan <ms@kilabit.info>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [bug] Multiline value should error if the next line is section
Message-ID: <20180506210943.GA953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Shulhan <ms@kilabit.info>, Git Mailing List <git@vger.kernel.org>
References: <20180507020348.31b473b4@kilabit.info>
 <CAN0heSooYuGkxP9u0Uuwu_TCEOd_pj20L05=bwwHynPOapej6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <CAN0heSooYuGkxP9u0Uuwu_TCEOd_pj20L05=bwwHynPOapej6g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 10:03:10PM +0200, Martin =C3=85gren wrote:
> This behavior looks correct to me, though. It seems very hard to me to
> second-guess what the user meant. For example, what if that third line
> contained a "=3D"? Like:
>=20
> [alias]
>         huh =3D !dd \
>               bs=3D1024 ...
>=20
> Should Git guess that the backslash on the second line was a mistake?
> Or maybe not, because alias.bs =3D "1024 ..." would be a useless alias?
>=20
> I think such guessing would be theoretically possible, but especially if
> Git guesses wrong, that could be very frustrating to fight against.

I agree that trying to guess what the user wanted here is likely
impossible.

Furthermore, Git intentionally ignores unknown options.  For example, I
have advice and diff options set in my .gitconfig that would not be
valid on the Git shipped with a base CentOS 6 (which, unfortunately, I
sometimes have to use).  It's very convenient for users working across a
variety of systems that unknown options are simply ignored, even if that
means sometimes mistakes are not caught.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrvbxcACgkQv1NdgR9S
9otXIhAAg3/0UVaZXxugCs9q6P8PpwRlfHCTbZ2B5NMNZAUgJzXD8sAWAL7F2FdC
uuHSxWwJPgclfo4NjX6YoU9r+cdn5yCGM15Hz+P/QPXJALshABxh5uAv42MWhzqP
D6M8bsgBgZcO+fkDgHmI3efK+jXH0FHrYs3C0oF9a9VN5kRap5DwDdMwRdEf74UZ
1J61Aj5E3Hb5NPVu3tnRMOehT3uISlN44LqT9durrQwkz/5/iHZx6B7sFE9XwiFp
hIOjI5Jf2+HNKA89xzQH67kfeGsO7+e1lQO5hzy28XIzl65LT3gBX81y6JSauJ9X
JuTOS8nyoNCgnoWj5m/0eRV07G0Ji4Bg466WiFTAX9yrMMWsgYQ78Gbw9N4gbcGG
Uhy2EfZpn19fGc4Izl3nU6Doj8oTHf/BQd+CltjLZXNG5uPs2+p7dnUFn7ziFcOq
aSvkGLXP05obuK1iu9iFlEnmBKNsJJ9SGcGgUSrsXswwNXFu5bpN8iKjtxbpMTwc
Dh77+3tHM4sXenMQUSLnKf6BYLTaBEiMeHVuedj90vaJwSeJ0QACRNObLa/RWmbl
yU+EOlZYftvM8jWM1hqcQK45QgNFWFiod54wyWMMmx7g1saNMlcLWmVGwqFCw/Qx
QcsFGLtLt+Z2n60opP2P0kKGo5SuYTpebioiz4aAUGmEFLjr7s8=
=WzUo
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
