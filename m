Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894C4C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C0D613E7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 00:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFCAJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:09:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47578 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhFCAJf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Jun 2021 20:09:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B5AAC6046C;
        Thu,  3 Jun 2021 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1622678841;
        bh=qTgf+fZ/9wlZyJhc+kPQhV/zSQiaurzTVdG1NBVcsrA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xA0VMo8BnmZuOe0m8vuV1tCphfeA1y0uLlh9F1SY0h6Rn6r9zomBm1utMYtvos7/a
         +45xKwgpESWR1zB1hgLiPGewS7dmkwZOsCeB1+AUE3s1q87dkze1aLk/Mr5aIpIi4h
         NDt4HNhqg6fp5Lh9r0+zGmgaKb7nzGeZKEahzzfa3sFOPzO0t5YLZ8tg7sTvVRLbKL
         vdqkahI069bCjJpa7Cr0S/BAOet5whcJiM21powdWqDj5B+9u4+edxdq/nV7vC+6c5
         GUQYtSkM1GF83k7D/Nryek9eJNdpwfxjjHaN2ucAVfOCYiSnF1b14DsFrfkpBSCpgF
         kf6LWjJ2A9kfhTMGRWHbXDcUq/hobFD5ym6+MpvLgwj88k5XpzLGLVsXkPqYAhjn2g
         j3J/9XmwkkbJvgQt9sbqlvbpKF89QOjURc7EEGdIZXyMWpBz4wKYzRFlmEldnVf1zI
         oQrX1PukVdQZv27sr49rEUBOFMW2cOYI3wsiUn75bx+YYRAsiqg
Date:   Thu, 3 Jun 2021 00:07:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Message-ID: <YLgdM7i1FkM3f5PN@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com>
 <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev>
 <87pmx47cs9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cFxaoO8yXY13v+Qp"
Content-Disposition: inline
In-Reply-To: <87pmx47cs9.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cFxaoO8yXY13v+Qp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-02 at 10:50:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I debugged this a bit more, it's probably *also* an issue in our use of
> libiconv, but it goes wrong just with our test setup with
> iconv(1). I.e. on my boring linux box:
>    =20
>     echo x | iconv -f UTF-8 -t UTF-16 | perl -0777 -MData::Dumper -ne 'my=
 @a =3D map { sprintf "0x%x", $_ } unpack "C*"; print Dumper \@a'
>     $VAR1 =3D [
>               '0xff',
>               '0xfe',
>               '0x78',
>               '0x0',
>               '0xa',
>               '0x0'
>             ];
>=20

This is a little-endian encoding of UTF-16 with a BOM.  The BOM is
required here since the default, if no BOM is provided, is big endian.
However, as I alluded to in 79444c92943, while the standard permits the
BOM to be omitted, doing so is generally improvident because that leads
to breakage when interoperating with Windows machines, many programs for
which assume little endian.

I mean, I don't use Windows and I think those programs are broken and
their authors rightfully should have known better, but practically,
using a BOM solves the problem easily, and if we can be slightly nicer
to the poor, hapless users of those programs, why not?

> On the AIX box to get the same I need to do that as:
>=20
>     (printf '\376\377'; echo x | iconv -f UTF-8 -t UTF-16LE) | [...]
>=20
> I.e. we omit the BOM *and* AIX's idea of our UTF-16 is little-endian
> UTF-16, a plain UTF-16 gives you the big-endian version. To make things
> worse the same is true of UTF-32, except "iconv -l" lists no UTF-32LE
> version. So it seems we can't get the same result at all for that one.

But what do you get if you just use UTF-16?  Is it little endian with
BOM, big endian with BOM, or big endian without BOM?  If it's big endian
without BOM, did you set ICONV_OMITS_BOM when building?

> So from the outset the code added around 79444c92943 (utf8: handle
> systems that don't write BOM for UTF-16, 2019-02-12) needs to be more
> careful (although this looked broken before), i.e. we should test exact
> known-good bytes and see if UTF-16 is really what we think it is,
> etc. This is likely broken on any big-endian non-GNUish iconv
> implementation.

We probably could have been more careful here.  Part of the problem is
that I don't have access to any affected systems here, so it's not in
general easy for me to write a test (or even a patch) for this case.

We also did use iconv(1) before that, but I _think_ it's possible to
remove it.  The thing that's tricky is the use of SHIFT-JIS, which has
known round-tripping problems, but I don't think we rely on using the
system iconv(3) there and encoding any valid SHIFT-JIS sequence is
probably fine.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--cFxaoO8yXY13v+Qp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYLgdMgAKCRB8DEliiIei
gWuzAP4/xe83jRLoIX8pukLSmWPkS9o0M4r/mKv7cmYTZsDTJAEAwHv4U3Wxrnh3
WemxjFcwN2DGd/37/QlH4knEDaM/ewM=
=7ibA
-----END PGP SIGNATURE-----

--cFxaoO8yXY13v+Qp--
