Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAF3BB40
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250232; cv=none; b=Hi7zWogXcaVSEnnM5xpyGu9eHY1JwiCIuL0B1v3MDaTEi+jvddgraYLQhMeFFqteG0HkRD1JW2ixV9AigaTEu+HuTXXPHb0km6Qa5nKU5CXwu1NTugRpXjykqDjerk/w2fQ3zJrSBSMAJad1YnSF/nPnBSUvs7xbn8Cnydb+6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250232; c=relaxed/simple;
	bh=nBERx+CnD1tsN4M8jLYF+yxpqu9z+sSIAcKQyvfsDGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/1BE9f91LY7DDSBlyq0P7wre9Rb0MoCMGazQnU9YDLVuEtXOmtyIgZ+Q6Gt/GU9/im0j80U9sDi/neMp+KKdd08m1Yo2XyWzlDfa6HudSwwDM8KjyaDroJmymRSuUiWM64D5XpdZled33hSD5xgusJSn+qisv83GExV4B5KJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T7RFfu/M; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T7RFfu/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770250230;
	bh=nBERx+CnD1tsN4M8jLYF+yxpqu9z+sSIAcKQyvfsDGY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T7RFfu/Mc4htyi8xx6K7MDX7vWjQNiBbvhtF3tYMT7fbCoIdkzueEKwAVtHe5kOEl
	 N4kgUW+STbBaF9afCuzKUkxcDmlCJGj25jrYl36ZW0akM2nIVXZc89+Fv83KGdMhhT
	 JHmJglfGNWVflN7LzXCXzyAlB4QO6i7ZGE1VbU5WR6Sc5Jc/dJvgpt/p0odQirq97w
	 a/VthC6jKXJ/Rr4qmMZWzUcrnsliN/j1G+VVlKceD6lAb3/Fi7sepRr4Q2Pkt5pOgP
	 3V8fcdMmjm/Qog4TXKBMQov0U/QnKIFLPS7w8ijBesT8GaQZtwJ154ZkzkRK4HwAYY
	 OwJ7KlVMvx/v8zGM2zfmmYVF61DvAavmUkUaassZIiyF+NJoNltpEZyI8KR11RTSDv
	 d6aYMnFrOXYTNnke+XfFk2vjzaYcdIBFA0Qc7z9r1zS3z/+W8osnWLfLmZJ1yP4q38
	 m92wXDkZF4xsXcegm3DJj3QkTCmQ84kgZcWXc5avlXLFYENdT1S
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:139e:b5f:f1d6:55e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 11E33200B0;
	Thu,  5 Feb 2026 00:10:30 +0000 (UTC)
Date: Thu, 5 Feb 2026 00:10:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: Re: [RFC PATCH] Move rust gitcore crate to a different subdirectory
Message-ID: <aYPf9CnNLjJtinqw@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	gitster@pobox.com, ps@pks.im
References: <20260204232208.1615320-1-mh@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VoXkB4qglhOwkKB0"
Content-Disposition: inline
In-Reply-To: <20260204232208.1615320-1-mh@glandium.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--VoXkB4qglhOwkKB0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-04 at 23:22:08, Mike Hommey wrote:
> While `src/` is the default directory convention for Rust projects, it
> is too generic in the context of a multi-language project that is barely
> starting to (optionally) use Rust code.
>=20
> Additionally, having `Cargo.toml` at the top-level of the repository
> implies that one can run `cargo build` directly, but this doesn't
> produce anything useful on its own.
>=20
> Moving all Rust-specific files into a dedicated `rust/` subdirectory
> makes things clearer.

If we're going to do this, we should place the `src` directory under the
`rust` subdirectory to maintain the normal layout.  There are many tools
that depend on this repository layout and we want to make it as easy as
possible for people to use native, standard tooling to build things.

Note that I don't have strong opinions for or against placing the Rust
code in a subdirectory, but I do very much want the standard layout to
be honoured.

> The above is a post hoc justification. I do think it makes sense to do,
> but I should mention my real immediate motivation.
>=20
> git-cinnabar, a git remote helper used to talk to Mercurial servers, is
> a project based on libgit (the C parts). As such, its repository
> includes the git codebase as a submodule.
>=20
> As of about 3 years ago, most code that is not libgit in git-cinnabar is
> written in Rust, and is published on crates.io.
>=20
> Part of publishing on crates.io involves running `cargo publish`, which
> does `cargo package` under the hood. `cargo package` has the feature
> of... not including directories that contain a Cargo.toml, so upgrading
> libgit to 2.52.0 breaks the publishing process because all of the git
> source code is skipped, and git-cinnabar can't be built as a result.
>=20
> Of course, what this means is that this change is merely kicking the can
> down the road, because the problem will reappear when the rust code
> becomes non-optional in Git, thus why I'm making this RFC at the moment.

Perhaps you could ask Cargo upstream to add a feature to override that
in the meantime (or add such a feature yourself).  I can imagine other
uses for such a feature.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--VoXkB4qglhOwkKB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaYPf9AAKCRB8DEliiIei
gctUAP4iRZ+xbiCYMYYECdf/K6ywsJzlaLHySniunuUKIO28VAEAj5pvbQbFg2b7
+MKn+3Lbcr2xjJTtX9w9CgSey8d72Q8=
=fDZL
-----END PGP SIGNATURE-----

--VoXkB4qglhOwkKB0--
