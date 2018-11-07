Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5321E1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 01:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbeKGK6l (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 05:58:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53384 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388866AbeKGK6l (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Nov 2018 05:58:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ED5B96077B;
        Wed,  7 Nov 2018 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541554232;
        bh=aCF5oqvxIqRz1tZGy6jh9AYhVTPDJgQTwmGQQJCxtTQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WdqV1qN/MiPQnOlBaM97nroaNwiW7t5y24lTT6bTBwaM6XjeS2753dW6MRieRLf4F
         A6j8C5uU3VBzAgkDdXQ22bP7Y9uBePNeMQYR8ubl226xMuJaEGWw1fiMpYJt8LRbAX
         BMryzXDMLdYhwJlBTWKMYmwjYsx7uHQHbw63m3Ps3EAbktYvLfBTKyXgHQw8Gw3dQ3
         6kc86wDYhEyqcEgrf+JSm0ws+FAstr4aqmEQx/lTutD+QZ28rn2YqijgdmEoexA/nd
         Zz55agKb9cqUBPfM7jAoDldV7TOXjhW+QrRfk85fwQuiXdAxAE1fwttjMD62ribvKr
         Ey23bItOgpxralMMF7PGjC0+b4bx8jLB2MnMTn6kaDDJtnqniSF9FwYDIXB97yzqrl
         dQvZiKBqJ9ujk4OnEmNFo4Jr6Jnx/L463aWnWnvH0/xLlL8fC5rjRdHauVVuXJoVV6
         xI9vb3wU9JVbDYVZ8OTWzi9v9c/y9+F6fb1dQIukfXhF6tX8qBA
Date:   Wed, 7 Nov 2018 01:30:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 10/12] Add a base implementation of SHA-256 support
Message-ID: <20181107013026.GD890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-11-sandals@crustytoothpaste.net>
 <87h8gv7nz1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <87h8gv7nz1.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 12:39:14PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Sun, Nov 04 2018, brian m. carlson wrote:
> > +	{
> > +		"sha256",
> > +		/* "s256", big-endian */
>=20
> The existing entry/comment for sha1 is:
>=20
> 		"sha1",
> 		/* "sha1", big-endian */
>=20
> So why the sha256/s256 difference in the code/comment? Wondering if I'm
> missing something and we're using "s256" for something.

Ah, good question.  The comment refers to the format_id field which
follows this comment.  The value is the big-endian representation of
"s256" as a 32-bit value.  I picked that over "sha2" to avoid confusion
in case we add SHA-512 in the future, since that's also an SHA-2
algorithm.

Config files and command-line interfaces will use "sha1" or "sha256",
and binary formats will use those 32-bit values ("sha1" or "s256").

> >  const char *empty_tree_oid_hex(void)
> > diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
> > [...]
>=20
> I had a question before about whether we see ourselves perma-forking
> this implementation based off libtomcrypt, as I recall you said yes.

Yes.

> Still, I think it would be better to introduce this in at least two-four
> commits where the upstream code is added as-is, then trimmed down to
> size, then adapted to our coding style, and finally we add our own
> utility functions.

At this point, the only code that's actually used from libtomcrypt is
the block transform.  The upstream code is split over multiple files in
multiple directories and won't compile in our codebase without many
files and a lot of work, so I don't feel good about either including
code that doesn't compile or including large numbers of files that don't
meet our coding standards (and that may still not compile because of
platform issues).

> It'll make it easier to forward-port any future upstream changes.

I don't foresee many, if any, changes to this code.  It either
implements the specification or it doesn't, and it's objectively easy to
determine which.  There's not even an argument to port performance
improvements, since almost everyone will be using a crypto library to
provide this code because libraries perform so dramatically better.
I've tried to not make the code perform worse than it did originally,
but that's it.

Furthermore, the modified code carries a relatively small amount of
resemblance to the original, so if we did port changes forward, we'd
probably have conflicts.

It seems like you really want to include the upstream code as a separate
commit and I understand where you're coming from with wanting to have
this split out into logical commits, but due to the specific nature of
this code, I see a lot of downsides and not a lot of upsides.

> > +	perl -E "for (1..100000) { print q{aaaaaaaaaa}; }" | \
> > +		test-tool sha256 >actual &&
> > +	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0=
 actual &&
> > +	perl -E "for (1..100000) { print q{abcdefghijklmnopqrstuvwxyz}; }" | \
> > +		test-tool sha256 >actual &&
>=20
> I've been wanting to make use depend on perl >=3D 5.10 (previous noises
> about that on-list), but for now we claim to support >=3D5.8, which
> doesn't have the -E switch.

Good point.  I'll fix that.  After having written a lot of one-liners,
I always write -E, and this was originally a one-liner.

> But most importantly you aren't even using -E features here, and this
> isn't very idoimatic Perl. Instead do, respectively:
>=20
>     perl -e 'print q{aaaaaaaaaa} x 100000'
>     perl -e "print q{abcdefghijklmnopqrstuvwxyz} x 100000"

I considered the more idiomatic version originally, but the latter could
allocate a decent amount of memory in one chunk, and I wanted to avoid
that.  I think what I'd like to do, actually, is turn on autoflush and
use a postfix for, which would be more idiomatic and could potentially
provide better testing of the chunking code.  I'll add a comment to that
effect.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlviQDIACgkQv1NdgR9S
9otjOxAAgMIwfOcbv4Jni/3fK40NBrDi72uHWFbzze01bjlcUMYkTugS6dboOcZg
jrUYF210LmPlT1c6OpG9sIIGrhz+MUGuxHBtNjRhOw75qpihSlE2ZnAwj6BaF5Hj
zqCGS8iRD5v77SgCtAPmxp5L72g0a0A23LDLTW1nA98ypP3MLKcNUS/UbiJ14KM7
9YE4Qj/TKmZJKouJ/arDbAsalhoaCp7gej7ieqWQnFlBKDl1Q7+5g/ODBsEH5YBg
M4dkO6ILmjsLSC0V2YOA2i71BDQp8hMnkSA/qY6d4PaNP+LbHdfitcDjuZOkGL4/
l+OnQdyHc6BiH/3bKkTbjSlzwZuvgEBRF1Nsy0ZHK+Eo8nFcuBuTLeJpTedVCt8w
Y5dxpFRMD4EOzM3xlMezw3J8Y6su/c8MABkgOk+wqp/0cIAt6u8TRIYu4R6IFCig
0FFN9zUSH/D8Z4ZBoIviuwumwSw4N/17I/xeeK14Cacq5ER60Wz/aWH/wJhUn0SX
ELNKrslVc6QbILMd69P7VwpKHE+6BLLorWchCeW96ogMu9Jh8oWyPKIvHnTSm2FR
NzeCnRa56+7l9iM9Hr+ci8LVYadSmEULCSF/kDxcStkHbo6EdYGnvzXWpvgiM0lC
2MtGPsQoY5pLovCFIQqbvzD11bGUIyvpkfk83362L87DLCaxDAc=
=kFKG
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
