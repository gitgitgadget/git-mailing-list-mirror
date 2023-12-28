Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F29101ED
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nyPg/K+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DInPeMjs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 9213832009F4;
	Thu, 28 Dec 2023 14:57:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 28 Dec 2023 14:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703793465; x=1703879865; bh=ngzNmE/jmY
	69bS8VK7dcPGJrqukLj0NIho55Syiobe4=; b=nyPg/K+Me2HaD4xutXMGnMcjmL
	KF7Hx1S3Gkz8IH9oo0cQ62stHa1J+RzMXtYGhn0mDKm3prtKKyuRP3cdm7mpzjtk
	lBGrJUrwQ5T0YokjCCD7BxxRzLy1Qkr+UXPhQWzSDyo3KCS6A45foaa0aMk3urdi
	IgWpsduz7S97ZvZ8BCMDEaEPAGjjW2YUtuLE+dFojYN63y58OhhqD/GP+9Xjfhgw
	QFc1aJXyDq3kSS14e28fIDsEbJEm8ZoNbvD2yHPA3wd3qhACy/FUraU+pcGBGWn9
	6x+SzjuebLv4NtBmhprzh4n8MWA8qqn1h8ZgfKIa9YBiW6Cx6sY3p24TsApQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703793465; x=1703879865; bh=ngzNmE/jmY69bS8VK7dcPGJrqukL
	j0NIho55Syiobe4=; b=DInPeMjs8WlkzSgizxxlSmXMe9aaZ6G6/HOeUlfW7pYb
	NGlVSE8cKtQi425+1uKRev8JrvqOAQRL1A8F4tKa8H5icBO5ex4fsxcKlQhfnJfw
	8LAW7oEnJPn/h192HFhMH69fIXQB168roNyzXiCLQ/p5krM9ulg5izLe1vDs2rpg
	6kAAEwnpb40tTsdldMboX9mpho0++V3WFE1tyecgkpMACJRjGf+Bd6UQvTVG7lDO
	aRMDquiD2bSAhsxQSeP/Li0rd1X+0+qIRakt1kZaPtLP6DOvwxNVXWEpUAiB+u3V
	wgc5rUYKQ6SwZRxz52Er1ejjf50LAwfUrP8TvOIDGw==
X-ME-Sender: <xms:ONONZYEDyz4djHCSHzhw_LtPj2blYYjQeiSspNYQ5yptDbgiFpje7Q>
    <xme:ONONZRWAeIK8hVDDBKkuL0jEtLeO_mR2rus7YFY0IcfloJkkKKdNQLgblO6RrYonL
    8NNCzOT5sM43wzzsw>
X-ME-Received: <xmr:ONONZSK_HRFb_nfdU0jAWYrcenKdCl57Lq8TPJSbBtZEdwCiygGRSG_E421NzSoW7tcVPheOV6HlZWe13HFth1zCvebqBH52ngtJvu30KNENng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ONONZaFZnvc25IpeX-4UYYBEqb7LB5mc5xNHIhlfD4Wvd7iF7nCLAw>
    <xmx:ONONZeWToi2_uXz5ibFfn-6QIptBnpsKWvx3ukaL_w3wKE4tV1sKbA>
    <xmx:ONONZdNSG-15Vu0SFz--aMfITpI7A8iKA1YxDaOK0ogLV3RlDsdCew>
    <xmx:OdONZXfewpSz4LJ90a8ZXGHINfm3ILofYN3cSSUGntdfmYxyd5rDig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 14:57:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39ab6617 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 19:55:26 +0000 (UTC)
Date: Thu, 28 Dec 2023 20:57:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/6] worktree: initialize refdb via ref backends
Message-ID: <ZY3TMy75mYzz0Pab@framework>
References: <cover.1703754513.git.ps@pks.im>
 <xmqqedf6gpt8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DAAibA34WtQM1XPf"
Content-Disposition: inline
In-Reply-To: <xmqqedf6gpt8.fsf@gitster.g>


--DAAibA34WtQM1XPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 10:11:31AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > when initializing worktrees we manually create the on-disk data
> > structures required for the ref backend in "worktree.c". This works just
> > fine right now where we only have a single user-exposed ref backend, but
> > it will become unwieldy once we have multiple ref backends. This patch
> > series thus refactors how we initialize worktrees so that we can use
> > `refs_init_db()` to initialize required files for us.
> >
> > This patch series conflicts with ps/refstorage-extension. The conflict
> > can be solved as shown below. I'm happy to defer this patch series
> > though until the topic has landed on `master` in case this causes
> > issues.
>=20
> Resolution is not all that bad, but the change in function signature
> means comments/explanations near both the caller and the callee of
> the get_linked_worktree() function may need updating, I would think.
> For example, ...
>=20
> > diff --git a/worktree.h b/worktree.h
> > index 8a75691eac..f14784a2ff 100644
> > --- a/worktree.h
> > +++ b/worktree.h
> > @@ -61,7 +61,8 @@ struct worktree *find_worktree(struct worktree **list,
> >   * Look up the worktree corresponding to `id`, or NULL of no such work=
tree
> >   * exists.
> >   */
> > -struct worktree *get_linked_worktree(const char *id);
> > +struct worktree *get_linked_worktree(const char *id,
> > +				     int skip_reading_head);
>=20
> ... this now needs to help developers who may want to add new
> callers what to pass in "skip_reading_head" and why.
>=20
> We may indeed want to build this on top of the refstorage-extansion
> thing, as it seems to be relatively close to completion.

Fair enough. I'll wait for the refstorage extension topic to hit `next`
or `master` first so as to not build deep dependency chains when things
may still move around. I don't mind waiting another one or two weeks,
especially during holidays where things are moving slower anyway.

> Thanks (and a happy new year).

Thanks, the same to you, too.

Patrick

--DAAibA34WtQM1XPf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWN0y4ACgkQVbJhu7ck
PpS1Tw/+JgTkZqkXo/uUV4meEj5lSejsoo8Iq8g3PnH8VQjljSlGuunfm/IVTsKe
Xz7UJHYtZWcD4Etdm2GGRaahDliHLaZ6cVknTOXQhr9jcnNJ/F+OhuPveOPyj/8e
SAGW5bOHlyc1yD7arFTPJDuay0kr57BdBqRH5DUg6twN9+9o28m5QQtvcuSPI8wl
aXcYgZrrBPyHDAwLwJkZ5EXsJZ9GUe74Q/5K2nuX1eY8XsyNfp2VTopIoPsflCuv
GWp3s4z3Sl/f+MVA0uAYwPvx5eO6llYcONFx85DY70btDFgpRN1isLVNPJpqnNDj
WTMKV9x+y1+tkgfYZTT4H2hMVGCl4qix0a4Fel8+qEq8p4FoK73kQMiVrC2ipT48
S8FUc8uOEhC4suu18d5vvGyCcm5h8OiNv36B6kOADGMiI6GPbpKVB+cOAVEh9uch
ON8oj8ZJq9rHBfc3YFVItGw6anKbDL8pB/c6LQK85qg8TJZd8HasISKphPTo/V+7
AddL2OowFUo3ECDKea2XuyaEZMiAPmnq8lYjlRe5Q/qgXDhRPpj1WyHl9IPmYegS
mi78Yp2tJIubvWhP5x0awgXkOubrQZ9uctydmyywGckD3w5xNhy0/VhzpiEJHopb
naxHgeGlJMYdFPtV1U1r6QiYXu9W6mu2bcEa7Rr1SVjymttWbNY=
=y0Vl
-----END PGP SIGNATURE-----

--DAAibA34WtQM1XPf--
