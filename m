Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27A319858
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599696; cv=none; b=loOYDJSTQTC6eF7RvnR8gjoZv9x0fRjY52z032BxsSAI7vq75KbdQAmVX7VoAq4mFBKz7WNMXc2d0dzInr12YPFIjucZIWtICcC0Ge1/yTdCDihczerEkfIv3KCYfkSuAAsYXECllauZMRuw1XcomuVtHu2bxaEj6XprxtAIUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599696; c=relaxed/simple;
	bh=OrFgLjtoQu5wT/wDU9jEWpg8311iqQMAzMk45NVlKlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmJYIL2+L6LLzHoMhDO6kd0I3fqHOfL1H2wv79rgcc1/75GsYenwdnXjo3QglKKE1GuIcXd8dWXeLcsnK3zPR+8Gx+WHGQfvICjE6QwLy1TuoMb3mzHH5VnL4JyyqTOuhvH/qL6tlgqUf+FeMnrhlg+si8XRp94SpPSbi0LLdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=z4JXbFQx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="z4JXbFQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761599692;
	bh=OrFgLjtoQu5wT/wDU9jEWpg8311iqQMAzMk45NVlKlM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=z4JXbFQx7dYLXmYI9o75nQHUsanvjLTI2yWo4fPf67+YJSVKld3nZ5AsN8ymm/sp/
	 leNYGQ4TVjOpJtK71psxa8uw5yRzl4ZtzpgVeU1JqTuwk5/6qfomonLbvS0tK+8xNu
	 x+OzZZdIjjobofZK7zOAGj2CPRLrlibCImdt4KZ0Sh3R3WhXWxkI0863Z/k9ppeaPi
	 L9P5RhJQ3s+NsUe1SPsi86kfeeSAanMoWtlxEHVtJAVECpi1x+H1pZ7HWG4gh5A5RS
	 pezDtiSiY3LfWUCugktdgr2kx+G5UkSxAUdp16BtSLTSfMbP0yBXLgbBH+imWSUcRp
	 wFhv29W1WorQsY1UMGS7uOmsKBNcrwFNZKSSPKO4UcW9pgyTDbJ4sNQKHNOzpvnfS4
	 fdBYpt9DKkmt1KqRt33nDdt7gpiclulHEsAO5T3FZep0vm6CE15kMuzk+hZzqS1k6E
	 vyAsnPxxevdp2GHyMD/Cvw+gPjvdodCdrdX9F+Q98VYv90vG+7F
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5123:c4f8:c4f5:61ae])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A523E20036;
	Mon, 27 Oct 2025 21:14:52 +0000 (UTC)
Date: Mon, 27 Oct 2025 21:14:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
 <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EFaq097eccvlbIw3"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--EFaq097eccvlbIw3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-27 at 20:35:59, Ezekiel Newren wrote:
> On Fri, Oct 24, 2025 at 12:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > cbindgen is a Rust crate and it should be specified in the Cargo.toml
> > > under [build-dependencies] block.
> >
> > What is the benefit for us? The generated code is not a dependency of
> > the Rust code, and neither do we use it via "build.rs". And if we use
> > cbindgen via "Cargo.toml" we'd be forced to build it first, which slows
> > down our CI jobs.
> >
> > Please let me know in case I miss any reasons to have it in our build
> > dependencies instead.
>=20
> You're targeting a very old version of Rust (1.49). I'm not even sure
> that cbindgen will work with a version that old, but if it does then
> we should use it in build.rs to make sure we're not using any features
> of cbindgen that aren't available until later versions. If we use
> cbindgen that is packaged with the platform then we can't precisely
> control which version of cbindgen is being used. This is a matter of
> reproducibility. There may be platforms that can compile Rust, but
> can't generate C header files via cbindgen because cbindgen hard codes
> that a certain minimum Rust version is required in its own Cargo.toml
> file.

Yes, I agree with this.  Not all systems have cbindgen and it's not
guaranteed that the system's cbindgen will work with the version of Rust
that you want to target or that's being used to compile.

For instance, I'm using Debian unstable with a system cbindgen 0.27.0.
This requires Rust 1.70 or newer. If I use rustup to test my code on
Rust 1.49, then the code won't compile for me.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--EFaq097eccvlbIw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaP/gygAKCRB8DEliiIei
gTMIAQC49gPGk0S9G3sltmfZzfjPysQ544UwYuKyRuAvAoR82QD/QQm3+DTWDi8o
wTu4iIZvKmfAFdhYhEm+UZ4Kv2/xMwU=
=4giy
-----END PGP SIGNATURE-----

--EFaq097eccvlbIw3--
