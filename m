Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139D33C8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075454; cv=none; b=YcXJ/ihzPutkh+5A8NxtvaGxfFQ58M4ocuny9kKRyYS4bvgAeBz4ZdHkDC8QPhy8nG0NdTHQPwl1uhwX5Y8PjHDhh7UjqX4laEctsgWq6DNmJ17D9lbgsGDYDEOVHs0wU3fpitf6QZJzTNjaR+GoxPvfNVIvAcyuSNDWiKgj7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075454; c=relaxed/simple;
	bh=vmQDTtfzHwEr96CWpwuaTUJkD1BlG3eu4mDaTgkh4rU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtwTtJSd7g03uH/ogWuw6UOUe50sRNt+99bHk0wzL7PISAOwEi/dqrZ/fsF+qdg3+fm8RzLAzieunInRhalt37hczZVgn95V6K66VSIRbwhTeZoUoPfcWIoS4l+Hqa40SIokRm+MKAKJZovQioI627yd2nG9Ase5hmZ4MHIrL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NBFS8j1V; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NBFS8j1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723075450;
	bh=vmQDTtfzHwEr96CWpwuaTUJkD1BlG3eu4mDaTgkh4rU=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NBFS8j1V3iwuDMn3NFw33Tskarei/EornMFiEzTCz7vZXEaIb2VdQmW+PXj9ZNDst
	 pdShEEmr4KiMtfpdhszai3NfecDr/UPPNA9JGnV+OI2+XmF7Wg7psBpniY17GC9bZi
	 ewudYfZoBsK43jSZMGSPCsxlaC5Q09ZTu9SqRX6mMafkio3Zax9HN7XTbeaKROpxgQ
	 u97YRzdOoHqwq3qhtwhf6YL8sDI6CEj73iqcw2MePRHDIGIujBsnyPe7HpstN7Jbqs
	 xgy7w6yze4CAeEWW3co2xSQzh10Gvl17lJIRgOz1bgA7bHe7skhRWn8b8bFFQa7mMQ
	 FHa7q42KYgW+XG4zrgeTX8a9mR6QNjH4Qi15rknmBm7BDu8wLQee4iTk8ucX74mCMF
	 0OM+yxXC/Ba0Wmys/OAdXGPbn71kTuViVeLfF882s4WAEiR2+23RYIRuoV71rnQb3/
	 aQiRhdxzoLG7+ek9m0M/CUBYmUnq+z7/siyV+Mtf7z8KshFLdPm
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7AF08209BD;
	Thu,  8 Aug 2024 00:04:10 +0000 (UTC)
Date: Thu, 8 Aug 2024 00:04:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 4/6] contrib/cgit-rs: add repo initialization and
 config access
Message-ID: <ZrQLeQ9P8OcDWZX-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <b84a8210a05c2358dc29f24a56adcbeaa90c8654.1723054623.git.steadmon@google.com>
 <ZrPmmBqK3IIiQutV@tapette.crustytoothpaste.net>
 <2p3fkcw2iie53ojnqybhyxhzwsyhkm6qhreip7emeftkjprqrw@r6drczjhy7hu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icoZbrpI5H+r1bVb"
Content-Disposition: inline
In-Reply-To: <2p3fkcw2iie53ojnqybhyxhzwsyhkm6qhreip7emeftkjprqrw@r6drczjhy7hu>
User-Agent: Mutt/2.2.13 (2024-03-09)


--icoZbrpI5H+r1bVb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-07 at 23:14:43, Josh Steadmon wrote:
> Semi-relatedly, I was wondering if you might be able to answer a cargo /
> crates.io question: for a crate such as cgit-rs, which is not located in
> the root of its VCS repo, will cargo balk at downloading the full
> git.git worktree? Our build.rs expects the full Git source to be
> available at "../.." relative to the crate root. We've currently only
> tested consuming cgit-rs in JJ via a local path rather than through
> crates.io.

The documentation[0] says this:

  Cargo fetches the git repository at that location and traverses the
  file tree to find Cargo.toml file for the requested crate anywhere
  inside the git repository. For example, regex-lite and regex-syntax
  are members of rust-lang/regex repo and can be referred to by the
  repo=E2=80=99s root URL (https://github.com/rust-lang/regex.git) regardle=
ss of
  where in the file tree they reside.

If you want to test, you should be able to push it to a repository
somewhere, even if that's a local path, and specify like so to test:

----
[dependencies]
cgit-rs =3D { version =3D "0.1.0", git =3D "file:///path/to/git.git", branc=
h =3D "cgit-rs" }
----

and see if it finds it.

[0] https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--icoZbrpI5H+r1bVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrQLeQAKCRB8DEliiIei
gfIAAQCIlEXqm/lx1hZTjLB1zG/CJcZyLU9+021tFI1MUVzlcQEAvm9wBHh30d7T
DHWI9OmnnfXFihrdk2EQ9hkv1I/NSgM=
=cJDN
-----END PGP SIGNATURE-----

--icoZbrpI5H+r1bVb--
