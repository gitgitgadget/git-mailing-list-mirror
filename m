Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C233DDC5
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369383; cv=none; b=JirKXTdRznMiGwGvFyc8eAiTxas9XyWqqdEEeM5nIfqsjt1v/fHz9KpBYBDGpCXGVWKYenw5SRv7azuGIk2mOIF/I9S28tiWhuWRmRvpln/IXE7DXpVs4miXMxyVrjE9eSpjpd5Ou8pueSzi2OmrGK5/WQzZGa64MHhQ7l6iH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369383; c=relaxed/simple;
	bh=jGgLdV5bq4PxMKmdxaFo3BZorkFIsNQdvTIqBPsm5po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihr2DMi3/16mxYB5EqhkU2ZeBT49j8HXzVSPRR5CrQX0ggtEHbRYvATqEZFYaCp7Ec2+HojTL0YM071BUXHW8GQMf/URGpf+dJbQ/iqGSq9C8+EEQOVo7qvfGc3TpwSkneXdT6Ul2WUxm+8r9g1PX72CqmmXujmOQ88vKyG+0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qiwCJsfl; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qiwCJsfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757369379;
	bh=jGgLdV5bq4PxMKmdxaFo3BZorkFIsNQdvTIqBPsm5po=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qiwCJsfl4NewtZbMBqRysngWuYFRO7JX2tru7EhT3+ndEy8atJJBFc27TBaBaGyAo
	 0425w3PX90CUJawzIShuiLyzgZqY7oWkO6gSOhQCt/3j8TyBz4wjrSkvoViR9Ms39z
	 FJWe7CKwLhkQP9sbPNVJKTfgOqDX8yene8GkQUlk6dh5+oxtA4Wvy01bFAZfCywnyK
	 8Laf+hLciDB5ndieBeDFQzvcAstER73gNCROYnnXOxzohry5TAiBXEbAXf3COUvICg
	 TbB7dA/cDWbusGOi34K604H46a2JI7V3k+AkOXGoRIkOgoraFpx/IwaXIWzJGmDR1h
	 0rEZvKXqiTYzmZdXRqoLirKMJO49aEL8PzJxT9KuerCg04+ISVXJNUZIGtnxXrLgY/
	 ywj0vWWyNV83hEAuP/glgJdvRZOYlO0oR5B2om+nIhTEaqqnHTxXGiuKFHPfMoVmy4
	 vsgtOnzQiwDaKj4wH3Zom5ShCAeVeHSzJNBv7utWdjMsnsWfOoT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:91aa:86f1:d85a:ac64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0348B200C9;
	Mon,  8 Sep 2025 22:09:39 +0000 (UTC)
Date: Mon, 8 Sep 2025 22:09:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v3 1/8] meson: add infrastructure to build internal
 Rust library
Message-ID: <aL9UIeyUqmwwPt2c@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
 <20250908-b4-pks-rust-breaking-change-v3-1-1cd7189fed3b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74SBdoJzsHrFnyPO"
Content-Disposition: inline
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-1-1cd7189fed3b@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--74SBdoJzsHrFnyPO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-08 at 14:13:08, Patrick Steinhardt wrote:
> diff --git a/Cargo.lock b/Cargo.lock
> new file mode 100644
> index 00000000000..2b80a01e22a
> --- /dev/null
> +++ b/Cargo.lock
> @@ -0,0 +1,22 @@
> +# This file is automatically @generated by Cargo.
> +# It is not intended for manual editing.
> +# Fix this to version 3. This is required so that older toolchains can s=
till
> +# read the lock file. Furthermore, while an argument could be made that =
we
> +# should not even commit the "Cargo.lock" file in the first place, there=
's two
> +# reasons to still do so:
> +#
> +#   - It thwarts supply-chain attacks by committing checksums into the
> +#     repository.
> +#
> +#   - It is required by Meson so that it can extract Cargo dependencies.

If we check this in, then we basically cannot use any dependencies.  As
I mentioned elsewhere, the problem is that invariably, if we're going to
pin to an older version of Rust, we're going to be faced with the
problem that some crate is going to require a security update that is
also going to break older versions of Rust, and we will then have users
aggressively demanding on the list that we update it immediately and
ship a new release, breaking those older compilers.  (And yes, I've seen
this happen with Go dependencies on Git LFS, even when the vulnerable
code is not used.)

This is made worse by the fact that you want to support Rust 1.49
instead of Rust 1.63, as I proposed.  Absent some compelling proposal on
how we're going to deal with this situation, I think we need to omit
`Cargo.lock`.

I think the better approach is to leave it out and use Cargo to build
the Rust code instead of having Meson do it directly.

> +# Starting with Meson 1.5, it knows to parse the "Cargo.lock" file and e=
xtract
> +# dependencies from it. So from hereon we don't need Cargo anymore to bu=
ild
> +# Git.

Ah, yes, I've already broken this in my branch (early this morning, in
fact).  I've added a `build.rs` file (used by Cargo) which is necessary
to properly link the tests against `libgit.a`.  (I'm using the hashing
code in some of my tests.) Meson fails to honour that and so the
compilation breaks.

I don't think it's going to be viable to try to maintain two separate
build systems that build the Rust code.  Everyone who uses rust-analyzer
(the Rust LSP) will use Cargo because that's the build system it uses,
and everyone uses Cargo anyway, so as a practical matter we need to
support it.  Trying to have Meson do its own thing is unlikely to work
here, and it demands that we use the `Cargo.lock` file, which we'd like
to avoid.

> +  cargo_command =3D [
> +    cargo,
> +    'build',
> +    '--lib',
> +    '--quiet',
> +    '--manifest-path',
> +    meson.project_source_root() / 'Cargo.toml',
> +    '--target-dir',
> +    meson.current_build_dir() / 'target',
> +    # `--out-dir` is unstable, but supported since 2018. It's been recen=
tly
> +    # renamed to `--artifact-dir`, but for now both options are supporte=
d.
> +    '-Z',
> +    'unstable-options',

`-Z` is only accepted in nightly versions of the compiler.  This won't
work with stable Rust and it definitely won't work with either 1.63 or
1.49.  It didn't work for me using Rust 1.89.0 when I removed the other
branch.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--74SBdoJzsHrFnyPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL9UIQAKCRB8DEliiIei
gfYXAP9ntf02oUQwuJCx+3S/udQ8RbT+T/tojZi02uEAPPDVQgD+K5Zfv7xTul8H
chVKTaVRexD3GcR7RKz9zToPm2vslAU=
=eJnu
-----END PGP SIGNATURE-----

--74SBdoJzsHrFnyPO--
