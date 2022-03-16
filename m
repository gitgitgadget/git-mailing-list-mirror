Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AF7C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 21:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358178AbiCPVtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358172AbiCPVtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 17:49:42 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568DDF16
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 14:48:26 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4A0415A0CA;
        Wed, 16 Mar 2022 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647467305;
        bh=VHNk4DtdbUJeOlSzDjkdsWegINM06BJSGYGoDVN7Og0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=N09JWGW2V75467GNe22F6CvvrIE4pD/86MImBfAz1y9644BaIfybqKcodKeZGTeIx
         J3JSWTqhGbOkhl5yTZD+L/waxM9EzOtomIFXSy2C0sxFvetzVm+u3WxqeUjYSTHZG3
         y55+5kvq2FbiecdA/jQW6o+1lfAoea1x9fPWjMoQJy2xl3uk3O1Li4NUtpFMuXzrpW
         JxA8QkWTrgiLZcWm7Jh4Nvhsvu7LnNSEk+WuH3g8992OSo7SweWQ8vw6eTiQMfRQdz
         xeb8suRtqEjgeEtKJEbcwMgnZ5XIrwVak+HwH6YY3oq7PkZB7DGBknS/HkQtSq61Kt
         dZOz9o3/yjojoR5oMS9yT/jNF2sEC60wS87SSB1D3d2BzhIPWKNs9aZ8j4jce6V/nf
         iLCw//KyqZ3sYoyUcRkar+t2Gg2Cn962xBbzlOqeiwtT0w1bGXGjFl/6iOHvHmT7nH
         x0WMQXXEnIN2bSDZ/QIbWHB8L3Vn7XRA4CgM6Cj7H6diFpUTVuK
Date:   Wed, 16 Mar 2022 21:48:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/6] builtin/stash: provide a way to export stashes to a
 ref
Message-ID: <YjJbJ9ZXlUAd2evC@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-5-sandals@crustytoothpaste.net>
 <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
 <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OF4yP899iWyP1d1i"
Content-Disposition: inline
In-Reply-To: <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OF4yP899iWyP1d1i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-14 at 21:19:10, Phillip Wood wrote:
> Hi Brian and =C3=86var
>=20
> Firstly I think this is a useful feature to add to git stash, thanks for
> working on it Brian

Thanks.  I'm glad folks other than me will find it useful.

> On 11/03/2022 02:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >=20
> > On Thu, Mar 10 2022, brian m. carlson wrote:
> >=20
> > > +	size_t author_len, committer_len;
> > > +	struct commit *this =3D NULL;
> > > +	const char *orig_author =3D NULL, *orig_committer =3D NULL;
> > > +	char *author =3D NULL, *committer =3D NULL;
> > > +	const char *buffer =3D NULL;
> > > +	unsigned long bufsize;
> > > +	const char *p;
> > > +	char *msg =3D NULL;
> >=20
> > These shouldn't be initialized unless they really need to..
> >=20
> > > +	this =3D lookup_commit_reference(the_repository, &info->w_commit);
> >=20
> > ..and some are clobbered right away here, so all of these should not be=
 initializzed.

This function got hoisted out of what would otherwise be duplicated
code, and that's why they're all initialized (because we would otherwise
have called free on an uninitialized value).  I can remove the ones that
aren't strictly needed.

> > > +	buffer =3D get_commit_buffer(this, &bufsize);
> > > +	orig_author =3D find_commit_header(buffer, "author", &author_len);
> > > +	orig_committer =3D find_commit_header(buffer, "committer", &committ=
er_len);
> > > +	p =3D memmem(buffer, bufsize, "\n\n", 2);
>=20
> You could start searching from orig_committer rather than buffer but I'm
> sure it doesn't make any real difference. The sequencer does something
> similar to this to replay commits when rebasing - is there any scope for
> sharing code between the two?

I can look into it.  The amount of code that would be duplicated here is
very minimal, so I'm okay with just adding a few lines here.

> > ...since by doing so we hide genuine "uninitialized"
> > warnings. E.g. "author_len" here isn't initialized, but is set by
> > find_commit_header(), but if that line was removed we'd warn below, but
> > not if it's initialized when the variables are declared..
> >=20
> > > +		for (size_t i =3D 0;; i++, nitems++) {
>=20
> Do we need i and nitems?

I can look into removing them.

> > > +			char buf[32];
> > > +			int ret;
> > > +
> > > +			if (nalloc <=3D i) {
> > > +				size_t new =3D nalloc * 3 / 2 + 5;
> > > +				items =3D xrealloc(items, new * sizeof(*items));
> > > +				nalloc =3D new;
> >=20
> > Can't we just use the usual ALLOC_GROW() pattern here?
> ALLOC_GROW_BY() zeros out the memory which would mean we could remove the
> memset() calls in the loops. I noticed in some other loops we know the si=
ze
> in advance and could use CALLOC_ARRAY().

Yeah, I can switch to that.  I was looking for that, but I was thinking
of a function and not a macro, so I missed it.

> > > +			}
> > > +			snprintf(buf, sizeof(buf), "%zu", i);
> >=20
> > Aren't the %z formats unportable (even with our newly found reliance on
> > more C99)? I vaguely recall trying them recently and the windows CI jobs
> > erroring...
>=20
> According to [1] it has been available since at least 2015. It is certain=
ly
> much nicer than casting every size_t to uintmax_t and having to use PRIuM=
AX.

If we're relying on a new enough MSVC for C11, then it's much newer than
2015, so we should be fine.  It's mandatory on POSIX systems.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--OF4yP899iWyP1d1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYjJbJwAKCRB8DEliiIei
gW3dAP96FXj4vdgr7C+lQH/9McB01I05PjIHFgc6Xqm5kArbnAD/W0JnGVkZ2XOV
LB9C1o/rMaoafUU/3y+gCEZEMneB3QU=
=Mjyr
-----END PGP SIGNATURE-----

--OF4yP899iWyP1d1i--
