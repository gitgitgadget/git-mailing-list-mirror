Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50FC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB62F61007
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhDKVs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:48:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231405AbhDKVs7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Apr 2021 17:48:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8F2DA60422;
        Sun, 11 Apr 2021 21:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618177718;
        bh=8UZbFWDhtqvuQRcpmR4pOLa5fT7AURUMWLspiOKOr2Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EMFMdHQJZoCFkjL5DZ0YNBXLXLdt+K+Rwy5ZYAeBekH7EfLjiMatbqIi6FurKtu6B
         ZOfoxjUMPpaVsAyUAfPsoru9yJ2on2ycJ8sf/MCpSJHjBiL6RLRQkXb9Ashw6fwHJl
         2I2sYpKPx8dmms4Gm4HTRLnS631vC9HIufP8EPuLa+Rh/IQ2MVrWtJnJ1I2qXviTEK
         QI0O1s/TtaPyFlLiO8LrnG31IX796PpY1JztbTpWGmRvmZywnqWiB8CDCsO/wpp9oU
         ySvAaMGSQf1UUOIA4TSOekZ8eI3GtYKI2QzR/WUL3wmX0yQn4RHLZikBPDnQHirYDX
         pXq1nOLHwkkBbjgGn1bdAjTzzqRcjxblkADsZ2rMrSr2yq0+JyqnBia2y/uQRnUi7p
         6uT330j7AnTR6IIemCYZ3XBP+4cxPRCakFjU2AA8+3BvOsHTiqXBzcC8QsjZ8f9VCO
         GPf2xmYOLBucDKqsnpA988/v4/Fj7r7GB75XmMX8B7lPyDuxPYS
Date:   Sun, 11 Apr 2021 21:48:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 09/15] hash: set and copy algo field in struct object_id
Message-ID: <YHNusqcmwv75P6Ck@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-10-sandals@crustytoothpaste.net>
 <87k0p9f2z9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yv+FjrbyfuzkVaqU"
Content-Disposition: inline
In-Reply-To: <87k0p9f2z9.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Yv+FjrbyfuzkVaqU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-11 at 11:57:30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sat, Apr 10 2021, brian m. carlson wrote:
>=20
> >  const struct object_id null_oid;
> >  static const struct object_id empty_tree_oid =3D {
> > -	EMPTY_TREE_SHA1_BIN_LITERAL
> > +	EMPTY_TREE_SHA1_BIN_LITERAL,
> > +	GIT_HASH_SHA1,
> >  };
> >  static const struct object_id empty_blob_oid =3D {
> > -	EMPTY_BLOB_SHA1_BIN_LITERAL
> > +	EMPTY_BLOB_SHA1_BIN_LITERAL,
> > +	GIT_HASH_SHA1,
> >  };
> >  static const struct object_id empty_tree_oid_sha256 =3D {
> > -	EMPTY_TREE_SHA256_BIN_LITERAL
> > +	EMPTY_TREE_SHA256_BIN_LITERAL,
> > +	GIT_HASH_SHA256,
> >  };
> >  static const struct object_id empty_blob_oid_sha256 =3D {
> > -	EMPTY_BLOB_SHA256_BIN_LITERAL
> > +	EMPTY_BLOB_SHA256_BIN_LITERAL,
> > +	GIT_HASH_SHA256,
> >  };
>=20
> In this and some other patches we're continuing to add new fields to
> structs without using designated initializers.
>=20
> Not a new problem at all, just a note that if you re-roll I for one
> would very much appreciate starting by migrating over to that. It makes
> for much easier reading in subsequent patches in this series, and in
> future ones.

I'm happy to do that.  I thought we were not allowed to use C99 features
because only recent versions of MSVC support modern C.  I was previously
under the impression that MSVC didn't support anything but C89, but they
now support C11 and C17 in their latest release[0], much to my surprise.

If we're willing to require C99 features, then I'm happy to add those.
I'll also send a follow-up series to require C99 support, which I think
is overdue considering the standard is 22 years old.

[0] https://devblogs.microsoft.com/cppblog/c11-and-c17-standard-support-arr=
iving-in-msvc/
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Yv+FjrbyfuzkVaqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHNusQAKCRB8DEliiIei
gX/RAP9hh7BilcaIaBKNWyVAnL3O4eGM9wIOij/g5uFRnP+YpAEAlzWzjMbdufLy
htl4bo8Zgn7FMW64gLeiKBNj8qwNwgg=
=KUer
-----END PGP SIGNATURE-----

--Yv+FjrbyfuzkVaqU--
