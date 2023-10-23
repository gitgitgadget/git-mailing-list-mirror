Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD211CAC
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gtk2m/a7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eu9DIiS/"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2110B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:58:17 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id E1F435C0332;
	Mon, 23 Oct 2023 09:58:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 23 Oct 2023 09:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698069496; x=1698155896; bh=C7
	aeqj34qEDMRr1o8remr5ulI7fvJroUD4cG0uQEsSo=; b=gtk2m/a7wlxDEiv1eN
	1Uamd/0ajry5rWEcMNkC6x14nF8ER1Eym89dkdLrlkPQlCdq99zUgg5Px+F+R/Yi
	a8X6yXx725lVNd8ZcjygixXsTNFo14vVLZv9Flq6Q2C3AOONmkpheq5d3vm6xEw8
	W5Ker4BfPwrJ8dgDiGeepH7gVojQqiuUZTgrqLT4/5vHDbWL8Wm6+b2jn2Jhgooe
	Uny/hdY58XqsygUKLJ4eyMGUWR8+F/Zztwm/e1ViRZdKrAjYw6mOXSN6n6yJv+hj
	PEAeD7VABOcul4dGdW582LciLR5VDfWLswqCJXvXcZ/EZGpXgDoLPZmLU5RxU5QP
	wYOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698069496; x=1698155896; bh=C7aeqj34qEDMR
	r1o8remr5ulI7fvJroUD4cG0uQEsSo=; b=Eu9DIiS/yvmuqBSNkqqWC849HnQhL
	MfOgnksJJnJaGzzVAXOFEAeEZy4do6pEB3wMoxr6H5MLztWH8SS5a0+TXfhXZGUi
	cw0vtJrjnKOjuL2242Hr7KMmdsIinboRelk9fS057k0/sCDwYHq9kTLkOVzT3HRF
	jNs0rZ32xDloKSYm/pSYUDlggmMLvuFHJam4887PQ4uER2XIuxP9NmEhL9tJ/2Ig
	21/35t+X2wnpDnImh+FUaW9WAALp0mZCYu4uBY1WKBlXi7UaeOA4vgGp+JfPL184
	eQhEuShYjdBwX6goIt6uFHFhzllv4qdqVXDzQ3Xlknip9j9z+WtkGOtbQ==
X-ME-Sender: <xms:-Hs2ZU0tfnAz81QjP0QhRLduZI1_u_f_vsj4qQ2NEUgDk8pIJUFpKg>
    <xme:-Hs2ZfGTXhPpo0CA-jYhz2SYt5wsByHKm4EhoHs5LM_cH6lLFK6W3kQwSqC9iFLir
    85o7AvEjH6l_RTH1A>
X-ME-Received: <xmr:-Hs2Zc7bu48HLyPK-5teeSsiJVccGPPVUhTddngYk3MmZT-DxV3UaPB-DURVJP7vAZ6LS6rn_4KEkMduoY89UbnUoGfMlX2aESF6CVBcEpr9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:-Hs2Zd0WQ4XoELsPsxVgj9SDi0kyF-pKPQ-HPo7ZIe755hSNjQ4dBw>
    <xmx:-Hs2ZXEOG_qV7OaS7Cd7eQ7OLGwzPYZ4uaCPhecULFsZUoxyHy_svw>
    <xmx:-Hs2ZW9IkZsDsvuNhEP86tgnPlPf-lyDclpwWWawwpj9bJdI9tM76Q>
    <xmx:-Hs2ZdNAIYWCsmigBkOAVQI44VuhLLDzUStZ-rhgjrYoIwKLIUPtPg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 09:58:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9462acfa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 13:58:11 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:58:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwen@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] t: reduce direct disk access to data structures
Message-ID: <ZTZ79DENl6c-1C0q@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <xmqqbkcwuetq.fsf@gitster.g>
 <CAFQ2z_Om724+o+EG1FAhC9VrvJECnQ5UA+Z04Rzycpi_mXvMHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qCz1R6Q9aFUh6ZnD"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_Om724+o+EG1FAhC9VrvJECnQ5UA+Z04Rzycpi_mXvMHg@mail.gmail.com>


--qCz1R6Q9aFUh6ZnD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:13:12PM +0200, Han-Wen Nienhuys wrote:
> On Wed, Oct 18, 2023 at 5:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > > this patch series refactors a bunch of our tests to perform less dire=
ct
> > > disk access to on-disk data structures. Instead, the tests are conver=
ted
> > > to use Git tools or our test-tool to access data to the best extent
> > > possible. This serves two benefits:
> >
> > Laudable goal.
> >
> > >     - We increase test coverage of our own code base.
> >
> > Meaning the new code added to test-tool for this series will also
> > get tested and bugs spotted?

For now all the helpers of the test-tool only have implicit test
coverage, but I get your point. If we decide to instead transform this
test tool into production-level code as you suggested (e.g. `git
rev-parse --exists`) then this becomes less of a discussion point as we
would of course have proper test coverage for it.

> > >     - We become less dependent on the actual on-disk format.
> >
> > Yes, this is very desirable.  Without looking at the implementation,
> > I see some issues aiming for this goal may involve. [a] using the
> > production code for validation would mean our expectation to be
> > compared to the reality to be validated can be affected by the same
> > bug, making two wrongs to appear right; [b] using a separate
> > implementation used only for validation would at least mean we will
> > have to make the same mistake in unique part of both implementations
> > that is less likely to miss bugs compared to [a], but bugs in shared
> > part of the production code and validation code will be hidden the
> > same way as [a].
>=20
> I think it would be really great if there were separate unittests for
> the ref backend API. Some of the reftable work was needlessly
> difficult because the contract of the API was underspecified. The API
> is well compartmentalized in refs-internal.h, and a lot of the API
> behavior can be tested as a black box, eg.
>=20
> * setup symref HEAD pointing to R1
> * setup transaction updating ref R1 from C1 to C2
> * commit transaction, check that it succeeds
> * read ref R1, check if it is C2
> * read reflog for R1, see that it has a C1 =3D> C2 update
> * read reflog for HEAD, see that it has a C1 =3D> C2 update
>=20
> Tests for the loose/packed backend could directly mess with the
> on-disk files to test failure scenarios.
>=20
> With unittests like that, the tests can zoom in on the functionality
> of the ref backend, and provide more convenient coverage for
> dynamic/static analysis.

Agreed. Ideally, I think our tests should be split up into two layers:

    1. Low-level tests which are backend specific. These allow us to
       assert the on-disk state of the respective backend thoroughly and
       also allow us to explicitly test for edge cases that are only of
       relevance to this specific backend.

       The reftable backend in its current (non-upstream) already has
       such tests, but we don't really have explicit tests for the files
       backend. This is a gap that should ideally be filled at some
       point in time.

    2. Higher-level tests should then be allowed to assume that the
       underlying logic works as expected. These tests are thus free to
       use plumbing tools that tie into the reference backends.

Patrick

--qCz1R6Q9aFUh6ZnD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2e/MACgkQVbJhu7ck
PpSOsw/8D3lN4krl+uVG7rKaId5UspvTI/imV0ofQlUH/TzS1GdbqnLrsm9lJEW+
iQUifq9Qem0xabjJ07ES6cdVZSnDMbcB9X7yMNfdgDZ7DZojnTxdfZV+q8UO8egy
gs8qfqzIuRkzKklwzxP9v5n4ZG8hKBjSDDbeMVR+FB/lIxfn1nkn9xO46ZmtTMwk
jUEE6tJuJV9kIZIUxD39GO/RsNtp9Q7tvxIBSBV8RzbjYykzg3LBjL3ULiNlGUZT
KMUXmSC4VQzdB/G1d/3O+oPSuQeFlFWr0XnO0GGbkK16HvC7u8GIW05HVwFjyjUS
bqyESKUnIVWtlmOPeT6pfK3Zllod3Q7sVijJYrgGDGKxG3R5WxPr8eXRlDQ+89+A
ybUA+HcNXU9abM4rK46V5YKERzwlt/6/aQWD22vdki3ZfO2Vyu/KwyijqiBa3f73
jFcHHOjUhv1dyzTV24FgfCvLcV6SN6ksuo0Bsp3B0A8Ia2kB4etaHUeEAfbEypAV
9bR6JGiutjzOd29g4i0yelR0yN2wM43OX34hoxBso138pqbinlaPGIiZ62z4tsru
XiHs5vcgXRjSAeqwBQiIt+PhzrJNkWWkM7ssAZookxxgn5bgwkFMgw2wmDe1x2A0
10yRXLZS3yUecNLY/mSVdDOwjVPR02zCg/X4qyqjQnAF6hEDCVI=
=syA3
-----END PGP SIGNATURE-----

--qCz1R6Q9aFUh6ZnD--
