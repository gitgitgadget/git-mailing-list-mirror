Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2011B260
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MJwg5OFJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUAhrjZS"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C51101
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:58:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id BDE195C024C;
	Mon, 23 Oct 2023 09:58:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 09:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698069529; x=1698155929; bh=Up
	ib5W2XKW29wtjwIcp1oOyVsNIzdmVgU3WGzwVQ7Oo=; b=MJwg5OFJ6Qz82qnPHK
	727Smp/BCsU40AXo2FMDuz/QEhn+G+DFlvM3DfkWzgLq8rvwygn0clUex9YKC3Fv
	vqPge1TbBklXT0RRmSF328G9ut2+Nrn45rAJ7f7pw/kT+QzT4WVPW7jtQju/Wf0A
	3EhQIcdDqttejDExrD877p6nqEQu+vT1BJEFsrwF+6Vwj5mWZDZHqjuBM9nwi8qZ
	RNuSdlKN8Jh3TkzDSYXW7dv9Zl2wevbVuIawHg/E2G8Ncl7sH9Zz9sR25aDvWqhT
	21P99ZsC3WQC1r9C5W5BkrVTYzdoFYi/YHv+btuTq6q2aPBSjREDELMD048hl8ns
	sIHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698069529; x=1698155929; bh=Upib5W2XKW29w
	tjwIcp1oOyVsNIzdmVgU3WGzwVQ7Oo=; b=BUAhrjZS/c3Jx8sL8HPKbIHT99kRb
	cnKfc5vDBzt1qp6S4gN3QyxZ2TSSunyKGmESiKhYsaCYbt0GM4w2BKEJhtTZmcs9
	dMkyuG8Qd0FfuIAR7DJ6PaASkx8UC4qqKinzog5Xp0CCk9lnzFQ83KWPlhN0HBRa
	qerPjzRa1Nf1ZmOSjAFA/ceRa2Xrf0jvzjI/pqARPajr7gxLrqsulzZjFhY8hTx1
	gs0MZ3/3ODQAWU4AUCmUPvx3b2hDHottYLYO0xvvR1/cj2KzkqW/0te4nY3cHtgg
	6kxB+URpRsC6b2z//wwzKIEt6kInXa21UzRigk+cehWpFkO1yrtaQIXhg==
X-ME-Sender: <xms:GXw2ZdG3Mx5ocedS0vEEvS3RMQAFcORiSLWI9iy3a9bJ84gZIpgT6w>
    <xme:GXw2ZSUmzU1gnfdNevj7i3t7KRkVhduIh1SDbSFyN3tAna3D2We9eqemD9dNPKA9h
    oRBQSnpo3OGgLYTGQ>
X-ME-Received: <xmr:GXw2ZfLTGqhRKjwnidJACFsNi1HMYbKSawIUcC9lctRb4hkbmekvzHjaqFzsjnE-aru8v7bDBJStMFScIy68zjuys_WHl3H94jRF9N1wOadQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:GXw2ZTEW0zEZtwF2493gCgOsreyUOwqs0cLssM5FylNuhME--DJAwg>
    <xmx:GXw2ZTU9QAx3UIJVnxGlgzx1iaAycV-ddTfajMaDkhlj3Pk5e5HmUw>
    <xmx:GXw2ZeNJGtLECpVN3V_R1Rxaz5sgkznsE1-c6guhoJdV4E2kq60B3Q>
    <xmx:GXw2ZadWakYpRxflgvVFLO6V_3o56nA5QGpwgqpppsmmNeeeuzVB1g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 09:58:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d9274ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 13:58:45 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:58:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 01/11] t: add helpers to test for reference existence
Message-ID: <ZTZ8Fm1Gk7Rxn6Yu@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>
 <xmqqmswfud7p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mUoZPZ2PunDlxArv"
Content-Disposition: inline
In-Reply-To: <xmqqmswfud7p.fsf@gitster.g>


--mUoZPZ2PunDlxArv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 09:06:50AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > There are two major ways to check for the existence of a reference in
> > our tests:
> >
> >     - `git rev-parse --verify` can be used to check for existence of a
> >       reference. This only works in the case where the reference is well
> >       formed though and resolves to an actual object ID. This does not
> >       work with malformed reference names or invalid contents.
> >
> >     - `test_path_is_file` can be used to check for existence of a loose
> >       reference if it is known to not resolve to an actual object ID. It
> >       by necessity reaches into implementation details of the reference
> >       backend though.
>=20
> True.  It would be ideal if we can limit the use of latter when we
> _care_ how the ref is stored (e.g., "we expect it to be stored as a
> loose ref, not packed").  "The ref R at must be pointing at the
> commit X" is better asserted by using the former (or "git show-ref")
> as we not just only want to see the .git/refs/R file holding the
> object name X, but also want to see the production git tools observe
> the same---if what rev-parse or show-ref observes is different from
> the expected state and they say ref R does not point at commit X, we
> should complain (rev-parse or show-ref may be broken in the version
> of Git being tested, but we can assume that their breakage will be
> caught elsewhere in the test suite as well, so as long as we trust
> them, using them as the validator is better than going into the
> implementation detail and assuming things like "new refs always
> appear as a loose ref" that we might want to change in the future).
>=20
> > Similarly, there are two equivalent ways to check for the absence of a
> > reference:
> >
> >     - `test_must_fail git rev-parse` can be used to check for the
> >       absence of a reference. It could fail due to a number of reasons
> >       though, and all of these reasons will be thrown into the same bag
> >       as an absent reference.
> >
> >     - `test_path_is_missing` can be used to check explicitly for the
> >       absence of a loose reference, but again reaches into internal
> >       implementation details of the reference backend.
> >
> > So both our tooling to check for the presence and for the absence of
> > references in tests is lacking as either failure cases are thrown into
> > the same bag or we need to reach into internal implementation details of
> > the respective reference backend.
>=20
> > Introduce a new subcommand for our ref-store test helper that explicitly
> > checks only for the presence or absence of a reference. This addresses
> > these limitations:
> >
> >     - We can check for the presence of references with malformed names.
>=20
> But for the purpose of tests, we can control the input.  When we
> perform an operation that we expect a ref R to be created, we would
> know R is well formed and we can validate using a tool that we know
> would be broken when fed a malformed name.  So I do not see this as
> a huge "limitation".

This is explicitly about the case where such a ref R is not well-formed
though. This limitation was mostly a problem in t1430-bad-ref-name.sh,
which verifies many such scenarios.

> >     - We can check for the presence of references that don't resolve.
>=20
> Do you mean a dangling symbolic ref?  We are using a wrong tool if
> you are using rev-parse for that, aren't we?  Isn't symbolic-ref
> there for us for this exact use case?  That is

Again, t1430-bad-ref-name.sh has been the inspiration for this:

```
$ git symbolic-ref refs/heads/bad...name refs/heads/master
$ git symbolic-ref refs/heads/bad...name
fatal: No such ref: refs/heads/bad...name
```

The mismatch that you can write but not read the reference is kind of
astonishing though. We could fix this limitation, but I think there were
more usecases than only bad reference names. I honestly can't quite
remember right now.

> >     - We can explicitly handle the case where a reference is missing by
> >       special-casing ENOENT errors.
>=20
> You probably know the error conditions refs_read_raw_ref() can be
> broken better than I do, but this feels a bit too intimate with how
> the method for the files backend happens to be implemented, which at
> the same time, can risk that [a] other backends can implement their
> "ref does not resolve to an object name---is it because it is
> missing?" report incorrectly and [b] we would eventually want to
> know error conditions other than "the ref requested is missing" and
> at that point we would need more "special casing", which does not
> smell easy to scale.

We actually rely on some of these error codes to be consistent across
backends. E.g. "refs.c" itself has higher-level logic that verifies
specific error codes when resolving symrefs. And as we explicitly made
these error codes part of the API design with `refs_read_raw_ref()` my
assumption is that any other backend needs to match the behaviour here.

I also think that this is a somewhat sane assumption to make. While it
may not be a good idea to tie this to standard error codes, the backend
should indeed be able to signal specific error cases to the caller. We
could refactor this to be more explicit about the expected failure cases
in the form of specialized error codes. But I'm not sure whether that
would be worth it for now, but it's sure something to keep in mind for
future patch series.

> >     - We don't need to reach into implementation details of the backend,
> >       which would allow us to use this helper for the future reftable
> >       backend.
>=20
> This is exactly what we want to aim for.
>=20
> > Next to this subcommand we also provide two wrappers `test_ref_exists`
> > and `test_ref_missing` that make the helper easier to use.
>=20
> Hmmmm.  This may introduce "who watches the watchers" problem, no?
> I briefly wondered if a better approach is to teach the production
> code, e.g., rev-parse, to optionally give more detailed diag.  It
> essentially may be the same (making the code in test-ref-store.c
> added by this patch available from rev-parse, we would easily get
> there), so I do not think the distinction matters.
>=20
> > diff --git a/t/README b/t/README
> > index 61080859899..779f7e7dd86 100644
> > --- a/t/README
> > +++ b/t/README
> > @@ -928,6 +928,15 @@ see test-lib-functions.sh for the full list and th=
eir options.
> >     committer times to defined state.  Subsequent calls will
> >     advance the times by a fixed amount.
> > =20
> > + - test_ref_exists <ref>, test_ref_missing <ref>
> > +
> > +   Check whether a reference exists or is missing. In contrast to
> > +   git-rev-parse(1), these helpers also work with invalid reference
> > +   names and references whose contents are unresolvable. The latter
> > +   function also distinguishes generic errors from the case where a
> > +   reference explicitly doesn't exist and is thus safer to use than
> > +   `test_must_fail git rev-parse`.
> > +
> >   - test_commit <message> [<filename> [<contents>]]
> > =20
> >     Creates a commit with the given message, committing the given
> > diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> > index 48552e6a9e0..7400f560ab6 100644
> > --- a/t/helper/test-ref-store.c
> > +++ b/t/helper/test-ref-store.c
> > @@ -1,6 +1,6 @@
> >  #include "test-tool.h"
> >  #include "hex.h"
> > -#include "refs.h"
> > +#include "refs/refs-internal.h"
> >  #include "setup.h"
> >  #include "worktree.h"
> >  #include "object-store-ll.h"
> > @@ -221,6 +221,30 @@ static int cmd_verify_ref(struct ref_store *refs, =
const char **argv)
> >  	return ret;
> >  }
> > =20
> > +static int cmd_ref_exists(struct ref_store *refs, const char **argv)
> > +{
> > +	const char *refname =3D notnull(*argv++, "refname");
> > +	struct strbuf unused_referent =3D STRBUF_INIT;
> > +	struct object_id unused_oid;
> > +	unsigned int unused_type;
> > +	int failure_errno;
> > +
> > +	if (refs_read_raw_ref(refs, refname, &unused_oid, &unused_referent,
> > +			      &unused_type, &failure_errno)) {
> > +		/*
> > +		 * We handle ENOENT separately here such that it is possible to
> > +		 * distinguish actually-missing references from any kind of
> > +		 * generic error.
> > +		 */
> > +		if (failure_errno =3D=3D ENOENT)
> > +			return 17;
>=20
> Can we tell between the cases where the ref itself is missing, and
> the requested ref is symbolic and points at a missing ref?  This
> particular case might be OK, but there may other cases where this
> "special case" may not be narrow enough.

Yes, because `refs_read_raw_ref()` doesn't concern itself with recursive
resolving of the reference, which is done at a higher level. It only
reads and parses the reference without caring whether their target
actually exists.

> As long we are going to spend cycles to refine the classification of
> error conditions, which is a very good thing to aim for the reason
> described in the proposed log message, namely "rev-parse can fail
> for reasons other than the ref being absent", I have to wonder again
> that the fruit of such an effort should become available in the
> production code, instead of being kept only in test-tool.

Fair enough, I'm happy to lift this up into production code. I just
didn't think this would be all that useful in general, but I can see
that somebody might want to use such functionality as part of our
plumbing interfaces.

I wonder what the best spot would be for it. Should we add a new
`--exists` switch to git-rev-parse(1)?

Patrick

--mUoZPZ2PunDlxArv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2fBUACgkQVbJhu7ck
PpQrMA//be44e1ptNNDaItI0ykzJLdYJULjSL4Kn9YzR6MEkmnY2fDkgZCk9u1sg
NBUvyX2KZjzzL+34JfS4Wy12sn5qeOJh6NjnjfHo7jukJLEW6r/HQwAeFJCOJjub
61uTN9fyKx5wkzB7bdem2kyFoIx5oSM3Ln+4YK/W+/RU3ii7O2KMsik4M5nGuGj0
w08zRw+lF7bLwAM89J0OvEAiLrLHCYCpLmjXgkkMsz7eCOaGTrEY8q9TVmlLM9Fq
VCfeYUPa2rS6I4cJCv2MjXV3/JpZvOhdV3o1jFYZFuc/4J71pnQbZQN5iOhTWaHB
SpgsSb1ORW0Lu7bjQ19iV90oJ82aZhaSr9iK4whW8P/2sQxOHaeWkPDBsvqfpIrz
7ocBuH/VwzfxpYVh3cRVWUHtpw1AisixRQsM+xzfbOuWbCeKjvF3hNhSfrUToQgl
w2wwgnwTnUc3YWPvHkX6nREKNv3TcvM8Runl2FY/dZ/6q/oNGasiJe6cErVHnfAv
gEenhAgGKVgdj2Q8UkPYjdBxaANEzg9cJtDpN7PBAZgFWnYixEDKV1i7HUBxwvj4
ksU0on5f1zCldF48JAqHaBFDNQ6KJruXwrROhoFSBVcVg97MKs4QO2X7GT6THKT8
QjI+duJgv5DvTqaA2BUmwf0MPV/MEB+WCfiHAAIy+nXbdOyiPl8=
=M8l/
-----END PGP SIGNATURE-----

--mUoZPZ2PunDlxArv--
