Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643CC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 02:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEC760FE7
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 02:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhKOB5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 20:57:09 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:42866 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKOB5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 20:57:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9359E5B482;
        Mon, 15 Nov 2021 01:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636941250;
        bh=yLeZZ42GBCrKhfInk3LzJ7zwugEd9xpzAmwekMUBU8E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jdR7lGqp+qYZH8ZzW71wox9YDAbuhshZp3Ml66Tz1qdBoM0m9IMWsKuMByHr8TMv3
         wzosO+sIq8xd/jY609U74Ucunt4JF0xMbsL9fVn+6AZdhCtIGIls6xA0BRibBJoUbw
         zhStVSIhtCzAOtLzobPcsyxe7cX5nIQAe8RSnoRb0mjtN0t8IgmM+ACatF5PoDMfHl
         JKo+Yb/2fIBv6gGf2AeLciPQfIjr//JwDIZ5CtZadamHrQH6qT0cmuI9ns0JB7bYOr
         7OCeGYx9ahUmHKpvWsL+uGRRGPuuXQ09M1ZiLMQnWsOdfpRz/yORFi+i+83gM6IsdD
         V/HvjFy1rG2/s90sZnyHrujlfMqC+y3XrHm0aYlCBRX5qPtdRFrLth0bYzMitMQ9um
         LCOHR6y/hD+gyN6U0HQwQsoqAFFsCxShp0HBKR035lJfM+iHnmIgJIs2P+0HguP+Jk
         L8eeuGTtc2dQ77hWIp5sYzT1EwtSr2LyiW+dljnbAFmhzyolQob
Date:   Mon, 15 Nov 2021 01:54:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
Message-ID: <YZG9wF56unj7eYhl@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211114212437.1466695-2-sandals@crustytoothpaste.net>
 <211115.86v90urz21.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5SVoKmpX3fjpaK5f"
Content-Disposition: inline
In-Reply-To: <211115.86v90urz21.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5SVoKmpX3fjpaK5f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-15 at 01:14:42, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Nov 14 2021, brian m. carlson wrote:
>=20
> > The C99 standard was released in January 1999, now 22 years ago.  It
> > provides a variety of useful features, including variadic arguments for
> > macros, declarations after statements, variable length arrays, and a
> > wide variety of other useful features, many of which we already use.
> >
> > We'd like to take advantage of these features, but we want to be
> > cautious.  As far as we know, all major compilers now support C99 or a
> > later C standard, such as C11 or C17.  POSIX has required C99 support as
> > a requirement for the 2001 revision, so we can safely assume any POSIX
> > system which we are interested in supporting has C99.
>=20
> I like this direction.

I felt like a test balloon would go over better than a wholesale
changeover.  I feel confident we can make this change, and we may even
in the not too distant future be able to switch to C11.

> > Sparse is also updated with a reference to the gnu99 standard, without
> > which it defaults to C89.
>=20
> Do we really need it in SPARSE_FLAGS though...
>=20
> > @@ -1204,7 +1204,7 @@ endif
> >  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
> >  # tweaked by config.* below as well as the command-line, both of
> >  # which'll override these defaults.
> > -CFLAGS =3D -g -O2 -Wall
> > +CFLAGS =3D -g -O2 -Wall -std=3Dgnu99
> >  LDFLAGS =3D
> >  CC_LD_DYNPATH =3D -Wl,-rpath,
> >  BASIC_CFLAGS =3D -I.
> > @@ -1215,7 +1215,7 @@ ARFLAGS =3D rcs
> >  PTHREAD_CFLAGS =3D
>=20
> Since $(CFLAGS) ends up in:
>=20
>     ALL_CFLAGS =3D $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
>=20
> ...
>=20
> >  # For the 'sparse' target
> > -SPARSE_FLAGS ?=3D
> > +SPARSE_FLAGS ?=3D -std=3Dgnu99
> >  SP_EXTRA_FLAGS =3D -Wno-universal-initializer
>=20
> ... and this will be used for this rule:
>=20
> $(SP_OBJ): %.sp: %.c %.o
>         $(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
>                 -Wsparse-error \
>                 $(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< [...]
>=20
> I.e. unless it needs to be later on the command-line the $(ALL_CFLAGS)
> should put it there already.

I added it to SPARSE_FLAGS before adding it into CFLAGS, so I can look
into dropping it from the former.

> Also (and this pre-dates this patch) it's unfortunate that CFLAGS is a
> mixed bag of compiler tweaking and "mandatory" flags. I think the below
> would be a better approach, particurly since our own config.mak.uname
> will override CFLAGS in some cases, and probably everyone who works on
> git to any degree has a local config.mak which sets it to something
> already.

We don't want to do this, because some people are using other compilers
(i.e., neither GCC nor clang) that need different options.  We
definitely do want them to be able to override these values as
necessary.  I believe config.mak.uname does this in some cases for
certain Unix systems.

> But why gnu99 and not c99?

I'll explain in the commit message in a reroll, but essentially, because
we do in some case use GNUisms when we're working with GCC.  Right now
those are mostly limited to providing C99 features on C89, but I'd like
to leave the opportunity open for us to do this in the future.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5SVoKmpX3fjpaK5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZG9vwAKCRB8DEliiIei
gVSGAP9qTkqcgZYauPbbvT5C5hiG5KHHfdpGsbCp1DsmwtRuTgEAinb0NycXaRtE
SsU++zD46tyiOVEi4Ik7I4HIMGNXqA4=
=gNx0
-----END PGP SIGNATURE-----

--5SVoKmpX3fjpaK5f--
