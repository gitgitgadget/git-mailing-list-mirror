Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE4BC433FE
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 12:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiDENAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379244AbiDELkh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 07:40:37 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496213CEC
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 03:55:25 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 59EE55A0EC;
        Tue,  5 Apr 2022 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649156125;
        bh=/wJ+gC69dTVyXvYXE5DQFw+ve3rNfxume8Rp9inm32Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YPPpAbRv7jZPmrMrRD0QjPPD6/XTPVJv3tzi24FsWuvr25OSXdCTmYvXnzEvJDc/H
         kDjNTLjyklb7nmex/H/CF42edjUXK8xFVWo+Z73+8oxN1dg19k+qpxXOoLEO2l8eQv
         bOUH4YN1IioYVn/daFhZV6yqzHP8PMOFbjw5Oo1YIj0W7mC5RlRuOOR5O8aAaUbOXW
         2U3pP4If7Sspy+jTYzK2rWdVTOU865Mg41A/pQghnNLfONlqbY6aj4WaU2rEgYlXq2
         Rlm4OBMKqeH6wQ6MzcHST0SOhe9te6esYb8cgShS2lvdxbvnxDq7W84peN9xzIbFRi
         4r+eyCFxzcQAULaiSTkRLZVX9x88ksKKgocJ2dmWV+Jv+dbGp+p3DYJt4EleNBdyQX
         7yExU5M3xhLTG16ETQEbpsEhkxQTASoNl9xnKji+qhoRLRKxaGNm+gpGMUIyKJ97Em
         j3Zltb2L1HR6YigeEtFEuEP4uuJxmtVbWx+bxjkCYvCy7bLuZVp
Date:   Tue, 5 Apr 2022 10:55:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/stash: provide a way to export stashes to
 a ref
Message-ID: <YkwgGjj0JIcOhlMH@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-4-sandals@crustytoothpaste.net>
 <220331.86pmm2swm9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m5XaSVFSDx2E38IP"
Content-Disposition: inline
In-Reply-To: <220331.86pmm2swm9.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--m5XaSVFSDx2E38IP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-31 at 01:56:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, Mar 29 2022, brian m. carlson wrote:
>=20
> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> > index 6e15f47525..162110314e 100644
> > --- a/Documentation/git-stash.txt
> > +++ b/Documentation/git-stash.txt
> > @@ -20,6 +20,7 @@ SYNOPSIS
> >  'git stash' clear
> >  'git stash' create [<message>]
> >  'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
> > +'git stash' export ( --print | --to-ref <ref> ) [<stash>...]
> > =20
> >  DESCRIPTION
> >  -----------
> > @@ -151,6 +152,12 @@ store::
> >  	reflog.  This is intended to be useful for scripts.  It is
> >  	probably not the command you want to use; see "push" above.
> > =20
> > +export ( --print | --to-ref <ref> ) [<stash>...]::
> > +
>=20
> I think this extra \n here isn't needed.

All the rest of the entries have it that way.  Junio likes it, you
don't, but it's consistent with the rest of the file and I'm just
following along.

> > +static const char * const git_stash_export_usage[] =3D {
> > +	N_("git stash export (--print | --to-ref <ref>) [<stash>...]"),
> > +	NULL
> > +};
> > +
> > +
>=20
> Stray too-much-whitespace.

Fixed in v3 already.

> > +	this =3D lookup_commit_reference(the_repository, oid);
> > +	buffer =3D get_commit_buffer(this, &bufsize);
> > +	orig_author =3D find_commit_header(buffer, "author", &author_len);
> > +	orig_committer =3D find_commit_header(buffer, "committer", &committer=
_len);
> > +	p =3D memmem(buffer, bufsize, "\n\n", 2);
> > +
> > +	if (!orig_author || !orig_committer || !p) {
> > +		error(_("cannot parse commit %s"), oid_to_hex(oid));
> > +		goto out;
>=20
> ..isn't this a logic error, shouldn't we return -1 here?

Yes, it is.

> better as "ret =3D error(..."?

Yup.  v4 will have it fixed in both places.

> Can nalloc be moved into the if=3Delse scopes?

It _can_, but it's used in both, so I don't see a particular reason to
do so.

> Some very long lines here.

Will wrap in v4.

> > +		return error(_("unable to write base commit"));
> > +
> > +	prev =3D lookup_commit_reference(the_repository, &base);
> > +
> > +	if (argc) {
> > +		/*
> > +		 * Find each specified stash, and load data into the array.
> > +		 */
> > +		for (int i =3D 0; i < argc; i++) {
>=20
> ...as this is size_t, not int.

I'll make argc int.

> > +				goto out;
> > +			}
> > +		}
> > +	} else {
> > +		/*
> > +		 * Walk the reflog, finding each stash entry, and load data into the
> > +		 * array.
> > +		 */
> > +		for (int i =3D 0;; i++) {
>=20
> Aside from the C99 dependency Junio mentioned, this should also be size_t.

Nope.  I specifically decided not to do that and mentioned it in the
cover letter.  Since Windows doesn't let us have nice things like %zu,
I'm going to switch to int here and be consistent.  I'm not coding for
16-bit systems here and I feel 2 billion stashes is sufficient for the
needs of the project for the indefinite future based on the capabilities
of current human beings.

The C99 dependency has been removed in v3.

> > +	/*
> > +	 * Now, create a set of commits identical to the regular stash commit=
s,
> > +	 * but where their first parents form a chain to our original empty
> > +	 * base commit.
> > +	 */
> > +	for (int i =3D nitems - 1; i >=3D 0; i--) {
>=20
> Did you spot my "count down" suggestion in
> https://lore.kernel.org/git/220311.86bkydi65v.gmgdl@evledraar.gmail.com/
> on the v1?

I did, and I prefer this approach.  That would be necessary if we were
using size_t here, but we're not.

> > +		struct commit_list *parents =3D NULL;
> > +		struct commit_list **next =3D &parents;
> > +		struct object_id out;
> > +
> > +		next =3D commit_list_append(prev, next);
> > +		next =3D commit_list_append(lookup_commit_reference(the_repository, =
&items[i]), next);
> > +		if (write_commit_with_parents(&out, &items[i], parents)) {
>=20
> Here we returned -1 from this earlier, I think this would be more
> straightforward as:
> =09
> 	res =3D write_commit_with_parents(...)
> 	if (res < 0)
> 		goto out;
> =09
>=20
> > +			res =3D -1;
> > +			goto out;
>=20
> So one doesn't have to wonder why we're ignoring the error value, and
> using -1, but then treating all non-zero as errors.

That will be fixed in v4.

> It looks like we don't need to initialize this.

It'll be removed in v4.

> > +	ret =3D do_export_stash(ref, argc, argv);
> > +	return ret;
>=20
> Aside from the "ret" case above, maybe this would be better if the
> "action" check became a swith, then the compiler would help check it
> against the enum, and this wouldn't implicitly be both ACTION_PRINT and
> ACTION_TO_REF, but could be done via a fall-through.

Normally I'm a big fan of switch statements, but I don't feel in this
case that it logically represents the current code.  I think, given the
context, that an if-else is easier to read.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--m5XaSVFSDx2E38IP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkwgGQAKCRB8DEliiIei
gZN2AQCZQOvmDcQkL3BXSgI0Jmc5Fz1DYori5kNPJ4qYj35ACgD/fjjC0v6pGpB5
seJZoYPWMq7lbYW5mV/MbFp2E7n99gs=
=2KKu
-----END PGP SIGNATURE-----

--m5XaSVFSDx2E38IP--
