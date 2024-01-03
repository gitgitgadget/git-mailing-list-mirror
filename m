Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38318C19
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XgWpXHpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="9nDx065K"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A2AA05C01F9;
	Wed,  3 Jan 2024 05:40:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Jan 2024 05:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704278456; x=1704364856; bh=vbaKC5lqZz
	xVFBgcrLr9LtqS/z8LQqil8DSAzgQEQ2Q=; b=XgWpXHpU43AghOVrMdw/OCCQf0
	h2tmlyK+lqsgyQ4LPtoI4Q6D7E3YTsItt6ULyuUfqLdlftOFUKV8VEsU1Jq4QuP7
	4AZaZER4gbuMsytL4u6LyL4kxb8ZwqZOYTF2Naef4jq5lQiOE3xoDETP2NIoH01K
	QSA+Yyiaxq+Dg366JdPp1ud0VkNCV2FUomvgc5ra4nQm++ExNZNvjXVfY2+0J1Xv
	Nc/zo9EC03p/xmSSXTC1t5rnf1cdtVHKPVQVPS+PM1+Yc6F80AO1VPHZ6ppf4mFC
	Lu+/dO2wlagsBsZWonDyHXJuV9G2Mx8GDfzkI6tzhVkK0S7V1uDc5cZrwbyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704278456; x=1704364856; bh=vbaKC5lqZzxVFBgcrLr9LtqS/z8L
	Qqil8DSAzgQEQ2Q=; b=9nDx065KdMOEdysw7QBlXtD9v+HIpFJk4+ju5FGYBNjq
	MCdKztrfmSx7SfiRkcd70qp8R36PyjrBstdxqaqPz05jabx98AE5RDXI8xTbX/4e
	3wPGMpDT1CUwjeUCVAh0YtlRzhW1sgLRqQDOnVcb8kdB3oGAhNj7IBrih76gUqZT
	vKHPefT/lY88/AdWXKBT71hXbu09oUafPA6TcOgS+8fvjbZFKARcgKZK2EHXPIJ2
	8uTjmrFqdc+lMqoJyMxe6fxE/+7ynetfj6LBwO/b+vw8HhYVGnS4oGnnyoAyJxlO
	uyjtGdC7CK9YtM99r7pWf8J0xlwcwKgBLY+pVesUcA==
X-ME-Sender: <xms:uDmVZf6B6hb3RK5PvmnxWELD4ywjS-JbHkQ4O0thBNoqBPr_qD4P0w>
    <xme:uDmVZU6pwdQXUWwseN-XK-NNAUVyzCf_-9qMHYGyYHH8z6SZTDahxMhaF27VOP117
    yeYKnybkkJlUC_Kcw>
X-ME-Received: <xmr:uDmVZWeC2UO4jkdtntF6FzKZ4UfKSqS731T8uBBP_rc4nVs6xKt2fyQutp0hYko32kMf0tvIxsKxpwQSL6pOV5Ep8w3TAzja2gC4AwcQnx6wqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:uDmVZQJ8nBw4aZBjtAD7pWsvKu-5L24AMgnwZzLs71Korl16CmnMhA>
    <xmx:uDmVZTJdJhBKs4tvK5iz5-kND9_cq6QX-T4vY2lfrJteuoznbCooRw>
    <xmx:uDmVZZw2Dx81LhDLEJZmcIhvlhV4uDqsCr0SV_5a_QwLY_Sj0MLc6g>
    <xmx:uDmVZaUe2St1Q5d5t-o6HM7AGD7Uhs4cFCiJZeb3Vp6mfYoVqk4YZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 05:40:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 283f95f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 10:38:27 +0000 (UTC)
Date: Wed, 3 Jan 2024 11:40:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
Message-ID: <ZZU5s4LKQF1NLgnC@tanuki>
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
 <ZZUNxNciNb_xZveY@tanuki>
 <ZZUWmy3rTjpBsH-w@tanuki>
 <ZZU1TCyQdLqoLxPw@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/eSlt0kbQJNWAsV3"
Content-Disposition: inline
In-Reply-To: <ZZU1TCyQdLqoLxPw@ugly>


--/eSlt0kbQJNWAsV3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 11:22:04AM +0100, Oswald Buddenhagen wrote:
> On Wed, Jan 03, 2024 at 09:11:07AM +0100, Patrick Steinhardt wrote:
> > Ah, one thing I didn't think of is parallel fetches. It's expected that
> > all of the fetches write into FETCH_HEAD at the same point in time
> > concurrently
> >=20
> is it, though? given that the contents could be already randomly scramble=
d,
> it would not seem particularly bad if the behavior changed.
>=20
> the one real complication i see is the --append option, which requires us=
ing
> a waiting lock after the actual fetch, rather than acquiring it immediate=
ly
> and erroring out on failure (and ideally giving a hint to use
> --no-write-fetch-head).

I should probably clarify, but with "parallel fetches" I meant `git
fetch --jobs=3D`, not two separate executions of git-fetch(1). And these
do in fact use `--append` internally: the main process first truncates
FETCH_HEAD and then spawns its children, which will then append to
FETCH_HEAD in indeterministic order.

But even though the order is indeterministic, I wouldn't go as far as
claiming that the complete feature is broken. It works and records all
updated refs in FETCH_HEAD just fine, even if it's not particularly
elegant. Which to me shows that we should try hard not to break it.

> an extra complication is that concurrent runs with and without --append
> should be precluded, because that would again result in undefined behavio=
r.
> it generally seems tricky to get --append straight if parallel fetches are
> supposed to work.

Yeah, the `--append` flag indeed complicates things. There are two ways
to handle this:

  - `--append` should refrain from running when there is a lockfile.
    This breaks `git fetch --jobs` without extra infra to handle this
    case, and furthermore a user may (rightfully?) expect that two
    manually spawned `git fetch --append` processes should work just
    fine.

  - `--append` should handle concurrency just fine, that is it knows to
    append to a preexisting lockfile. This is messy though, and the
    original creator of the lockfile wouldn't know when it can commit it
    into place.

Both options are kind of ugly, so I'm less sure now whether lockfiles
are the way to go.

Patrick

--/eSlt0kbQJNWAsV3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVObMACgkQVbJhu7ck
PpTHWA/+Ixney1hVZv/TOCAlYGvUApuJJ7jd6KVwmmQG/otfxCm4XnkYJkZNlLQf
NGIMJLaYuqZnRkf0YPzXtuNNEqKLhk1x2NWhsF8qx6whvmPsdxr82IKlWGqrkFWl
leWWYMTK7wjIwrogf391YMvb71X0L9xpZJs2ehB3N8bmc4v/l1sI5V/PpHskxG/M
eYlGBtYPGJS4gjrmZiHRxx/4Szx+pJrM0R1KJfH0YTlnn86G5DZKq0JI3MArYv+b
p/2q0n5f560bgPE2vbFaoEdW9KnyE8/j86tEcLAhLSAONZRT5zlffSLqdWltJ24n
2klhCvPngV7gs/kVPP4qi9Nnr08ipRG9xzEoa2msr2wYY56bWSFyPI4jac9jLYJ+
lF6IuFmYLaaMByoME13GCbUhWVVcX6GE1rXhhGdzCVJedwlWN6M1Nr5Q7/Uhni6n
6cLC2WXnrbdd2XQsG9mHB93Wq8+6MVvUmrjFYpH89mpt5ob8jz4kV/TAVphjOfK+
eF6pWbWhWXi/D1kr6bJhXdl444BvPtQKgG+mVur20u91B4B4Rk0ux4qfdxV1IaAl
qlx4kZHYkvb0CnpREsW8MwWeDpQcpmKxArwye/cAcaO47KQ6w0XHF/cw2Ph+Grtj
canjTBfyvU8gYc0lgx7PxzYZSqJGDvsQhaWF6hPyV3t1zZMdb5Q=
=dUCN
-----END PGP SIGNATURE-----

--/eSlt0kbQJNWAsV3--
