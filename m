Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD301BDC2
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ojfY16yn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tnugv4gx"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id CEDC83200B1C;
	Wed,  3 Jan 2024 11:17:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Jan 2024 11:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704298652; x=1704385052; bh=r+2ZA0Xs4M
	jgMHBHCtOttveWcjdik2mFQSLY75h/fLY=; b=ojfY16ynvpQmoylR0IR0Ss/1I5
	cW1SUGUne00dz0fzgKuxd46y9CQzeORztUFfvyBJ9fO+uxTDTe5C5tIDJw/z/w6T
	LtntzRcR6QsNS1Lyr7MH9/laDgo8KwEbqaDXZe9/yrjB5ra8PfIjzFY1w1OiYM/8
	7kLqTsDcDu+mhROoGjeNhi/HsGk4FN9CFfCPjjOdJ2pvYJvkz0EbJtMLAObLjKux
	m+OH9FcfmBohaqYk5glJaqzD4R+kdJKJwr/TVAak/fcN6oUzF5/xb+aux67pv8s1
	4K4AstX+ek4/hr2DcIvVwZHK6J5gzpoMLqxW8QxujEOK+6asMk60VF6IzjtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704298652; x=1704385052; bh=r+2ZA0Xs4MjgMHBHCtOttveWcjdi
	k2mFQSLY75h/fLY=; b=Tnugv4gxTNCaPgzRNDAsnpgnBN8qiSQfyis9sRmxIyJ8
	6kgCIESc0RioLLa9Ckglrv0eOY0YFdEignfLSuH/TnwTerUIrNRDvVNj0nJo+WYm
	TpzZu1txxCuMrR9N96rk9zm27wjKWUfOXex+yRMb69OueONYsiAJIcCL0HdhJKiW
	xsrh01VWFL5vEGIpYNfYMsGKwHILp5dqbevdtE0wxKIVVafjAFnK0aILlamt/xmd
	oF8RBKfgRQbGv6WbA9GIyh2F/0Elmyg1GywMZkdmOy/E6gGSvTSDGtoBur+SFNre
	BOjwQssn8+R32YaNOoo4guO+W1xXlF+StrPHLHBsqg==
X-ME-Sender: <xms:nIiVZZra1uiDCCGGeTXIGp19BBWalR7gCTF1MeBETtiN5qc6Paijlg>
    <xme:nIiVZbqLz4XeKOCiHvrHnCITEeWHEZW9sKitpQ-qsLQMwTP7tyhDiShxc9opTlPK3
    2cBwoGMUgjcILnXPA>
X-ME-Received: <xmr:nIiVZWPyv4N5BwDXR93NshHIvXumQnp3K0potf10d-5YVAG5n_47b2Yf26Lhkosz6oK6Rrmx4aXzWuoco7OD1hVmkYCHX0ywMKUG2I5QoKo_xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nIiVZU6Sph7WeA0b7SVqSg8a7j2nzwb4qJ3s-gKKkiI6GoNa_naarw>
    <xmx:nIiVZY4jinQ7k3IUa1ZxbPoxNjdLdeqgLTJnGAGUjiI7Bwg-aCkmJA>
    <xmx:nIiVZchTkSavkAY6iHsd2Rb7R-nQO9ewNokkMPVGzPhGdMfmhcYdRQ>
    <xmx:nIiVZWlqVXWlcN8qvlvgx5nj2yVMnLsI_rkNivK6WrY7xOHHpROy-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 11:17:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b65dfba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 16:15:03 +0000 (UTC)
Date: Wed, 3 Jan 2024 17:17:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZWIlx-9D2r9AfDW@tanuki>
References: <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local>
 <ZZUgUUlB8A-rhep5@tanuki>
 <CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
 <xmqqwmsqbhyt.fsf@gitster.g>
 <ZZWCXFghtql4i4YE@tanuki>
 <xmqqsf3ebe1l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cqZWbe4I2Bx2tu3h"
Content-Disposition: inline
In-Reply-To: <xmqqsf3ebe1l.fsf@gitster.g>


--cqZWbe4I2Bx2tu3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 08:02:46AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The downside of an empty prefix is that you wouldn't be able to filter
> > refs outside of the "refs/" hierarchy in case we'd use the empty prefix.
> > A better alternative would be to use "/" as an indicator that you want
> > to list refs outside of "refs/". That'd allow for more flexible queries:
> >
> >   - "/" prints all refs and pseudo refs, even those outside of the
> >     "refs/" hierarchy.
> >
> >   - "/refs" prints your normal refs.
> >
> >   - "/something/else" prints refs in "$GIT_DIR/something/else".
>=20
> I do not get this at all, sorry.  What makes your "/" cover "refs/"
> but not "something/"?=20

It does cover "something/". But...

> Unless you have some rule that special cases "/" to apply the
> "hierarchy prefix" matching rule unevenly, that is not possible.  So
> you can easily lose the "/" all of your above patterns share, go back
> to what I showed, and apply the morally equivalent special case to an
> empty prefix and you'd be OK.

=2E.. I think you're right -- I was arguing under the misassumption that
the typical rev-parse rules kicked in for git-for-each-ref(1) (e.g.
matching "heads/foo" to "refs/heads/foo"). But they don't, so my point
indeed becomes moot and I see what you're getting at now and agree with
you.

> In any case, I do not think supporting anything other than
> pseudorefs and HEAD outside "refs/" is a good idea to begin with
> (the "worktrees/$name/" example), and requiring that all normal
> references live inside "refs/" hierarchy is a good idea, so all of
> the above is moot, I would say.

Yeah, I'm on the same page: anything outside of "refs/" should not be
supported. But the problem is that tools like git-update-ref(1) don't
enforce this, so something like `git update-ref foo/bar HEAD` happily
creates "$GIT_DIR/foo/bar". And I bet there are other ways to write refs
at arbitrary paths.

With the files backend it's easy to see that this was created and can be
rectified. But with the reftable library you wouldn't be able to learn
about the existence of this ref at all if we ignored anything but
pseudo-refs and refs prefixed with "refs/".

So while I agree that we shouldn't endorse such refs, we need to at
least give an escape hatch in case such refs end up in the refdb anyway.

Patrick

--cqZWbe4I2Bx2tu3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWViJcACgkQVbJhu7ck
PpSCvw//Zqwd5prB84/eQanU6hUCwzeUOgQn7niqMUDtACnlr0Wd9ln0V/pdLaXA
Fx3BbPI+Q7YjkkMalZOIRHIs9HE9M4aKWvOp2XgLRTN0xjvf9HVH3zkyKlL866v5
OPXYV78IJ4/k2DsCeZlZ0OBOySAH9h8kXJjo+RK3/QXqhUwsOw3J4q752mSAOSC0
1qxmoN5Ctl1/P0SBd0UttgFqswowkioqXtkLsigWxE5K/YLU8nbDnrisw0IcxSsm
WhqaSwHCKSk5g2nNt4TD691l4xep1gf3pQfXtWx7zeZ07zSVkFX0zWL/VYx+I2n4
bAGkwZTEn9kwFyFsK5xpmBpF5eCy1unfNL02IQ9LuMvxtkW34an7rNa2iD8If30c
JEEbFq8WMeD6I6B25mjXfKny5GX9j+xb2d2pYlNwsghqPW8etJQsR2CzoyteY+qQ
slm/icPRy+rj8wj5PFrjC9d6bLk8fUEgkWUNZfLDlIVJtrt2sMuXiEVfKIq7qhej
EkOvEUzhhpnvmJvRmOseKrMcHfpQAfI6bVhWZvlwO0l7e6k6QTIRlTLjXbZABZqT
zEJW8ElUaQNZj+Le2fK8hf/cebFDiF1Hhj343GGOROm5esWEpRMPX5k5OCSXfwsO
RSj1dSFs9mrtg68i7i+m0Ur4LshG7zd7+iMGtapuO6HCFX6o8Gk=
=cZnw
-----END PGP SIGNATURE-----

--cqZWbe4I2Bx2tu3h--
