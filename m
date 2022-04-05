Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00F0C35273
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 11:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiDELev (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354882AbiDEKQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 06:16:28 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0116CA5E
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 03:03:25 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 32FB05A0EC;
        Tue,  5 Apr 2022 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649153004;
        bh=ufiUjW6uacUuceHAxYSsfuMgJnPudx8mTp/CT8Q5fBw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ob3TgG431umFNfrouNedcxr/2QRg3SZmQKPwtVE9dCXGUGdEsTSqQrI8cu/s6+Nub
         UR7Whxoxvvr8G8DoNCn4dG49KGqNMMby5FSa1eD4FubwVFEJjBQqrZOyaxQui82DsX
         9VQvkzVWfalP2A7QQibeoxzwLjO4POIE91K4By1owDRv5IDE7WKDNJMpm0wEbRXV8b
         uL/OgE45yV0EE+1XUXw29QK7Z15hq0P6kGbYfRAvlfkcVQlWLrLkwSv2RQFWVKBnSw
         Apxkm4w02rb2sya4a/uqYY1kY+P43E3O7gyaEnLNQQOxM9XG5RZXnFOgW2Rfn+wSGL
         ukRqRqpzJkZH8GOgXQBob4BI7LMMnC49ZJwbG0eBHEJbd+lbXoT5djuvDufY4oPDSN
         G75czMeABUPxEYV/0uSaptN6wrRq/oAEqZOK4gt0RmhQ0kIcIQVBlrpmnLSJywKxsj
         373dhva4TF/cdtR67oahAYO6zl8+bqjKa6xQHKQwJn/OpB8bFCo
Date:   Tue, 5 Apr 2022 10:03:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <YkwT6pwfC1d/PG4Q@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-5-sandals@crustytoothpaste.net>
 <220404.86czhxjewx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bVU9yOlnIS30ZU1q"
Content-Disposition: inline
In-Reply-To: <220404.86czhxjewx.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bVU9yOlnIS30ZU1q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-04 at 10:38:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Apr 03 2022, brian m. carlson wrote:
>=20
>=20
> > +	struct object_id *items =3D NULL;
>=20
> Is there a reason for why this...
>=20
> ...can't just use the existing "oid_array" APi?

None in particular off the top of my head, except that it didn't
originally.

> I think you want to use usage_with_options() here instead.
>=20
> In any case, I think you can de-init "ret" above I think, as the
> compiler will then spot a future logic error if we don't reach this:

Sure, I can do that.

> This whole variable assignment/test/manual rev-parse would be better as
> just feeding tags you created earlier to test_cmp_rev, should be a lot
> fewer lines that way, I.e. these last 4 lines become:
>=20
> 	git tag t-stash0 # earlier
> 	test_cmp_rev t-stash0 stash@{0} &&
> 	test_cmp_rev t-stash stash@{1}

Yeah, I think this would be a nice improvement.

> Perhaps adding N files in one commit isn't critical, then you could even
> piggy-back on "test_commit"....

I don't think test_commit works here because stash only operates on
things that are not committed.  The original goal here was to ensure
that we round-tripped the untracked files.  Since the design has
changed, that's not as critical, but I still think it's a useful thing
to check.

> FWIW I think I'd save myself the trivial disk space here and less shell
> trickery with:
>=20
> 	git log >out &&
> 	cat out out >out2
>=20
> Then:
>=20
> 	test_line_count =3D $(wc -l <out2) actual
>=20
> Or just:
>=20
> 	test_line_count =3D $(cat log-out log-out | wc -l) actual
>=20
> I.e. parts of this are presumably working around the $(()) operation not
> jiving with a whitespace-padded $count, so you're doing the echo instead
> of a more obvious redirection to avoid that.
>=20
> Which, I'd think is made more obvious by just cat-ing the earlier output
> twice. Just my 0.02...

Your assumption is correct, and I can make that change.

> > +test_expect_success 'stash export can accept specified stashes' '
> > +	git stash clear &&
>=20
> This looks like it belongs as a test_when_finished line of an earlier
> test that should be cleaning up after itself.

Not really.  We don't clear the stashes elsewhere in the test.  In fact,
last I looked, we had about 25 of them by this point in the test.

> > +	git stash import foo &&
> > +	git stash export --to-ref bar stash@{1} stash@{0} &&
> > +	git stash clear &&
> > +	git stash import bar &&
> > +	imported0=3D$(git rev-parse --verify stash@{0}) &&
> > +	imported1=3D$(git rev-parse --verify stash@{1}) &&
> > +	test "$imported1" =3D "$stash0" &&
> > +	test "$imported0" =3D "$stash1" &&
>=20
> This test has an implicit dependency on your earlier test and will break
> if it's not defining stash0, e.g. if you use --run=3DN or use other skip
> test features of test-lib.sh.
>=20
> Just factor that into a setup function & have the rest call it?

Yes, most of our tests have that problem.  I don't think it's worth
changing the way we do things unless we plan to make a concerted effort
to do that across the codebase and verify that in CI.

If we really want to make that change across the codebase for the
future, that's fine, but I haven't seen such a discussion on the list so
far.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bVU9yOlnIS30ZU1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkwT6AAKCRB8DEliiIei
gc8WAQCEh9+onVHdsPrMmxkYaVclO5rt6eALGIqylLl+s4e1SwD9HKw1Hwj8Gu7b
jXwdgKwAuhIaw4jMaUBc0fd5LVZwFA4=
=BaRl
-----END PGP SIGNATURE-----

--bVU9yOlnIS30ZU1q--
