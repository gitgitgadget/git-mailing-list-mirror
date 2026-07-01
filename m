Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4671891A9
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923310; cv=none; b=caUoSgv4iVbHQLyLgH34DLC75feAdxDAYgpj8VjeymOJLXcuUMsBvrJa7mIG+9mCIQ38/N4K9h4E+q/vkPlwmb31ej5J2ZTNYHVIqzBZ3U8fu/Dz6nR2ew/eU+c9/yWrE3C6DhV/h1+gyzlX7CDq3ckx5QoS0URk7Lb0VUWKOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923310; c=relaxed/simple;
	bh=0SIBbZI3+dHH+J12sneHcT8Rb7i7ByCVqIZrC26kkdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOVsIZfvwo5sIKo8WnBzWA4IKKuNj4Jlw7rVhVskcIe4mDIhLL9aCGEO8B9S/sb4UwVoErrnmqXYM5+VumXboTigiVC3/RORscuGKG8spw39wTZYQYI0Uemq1gx/4AHe2/rEsgJo/w9F1fjnqp2z2WPdwOLLJ2YRnX0yTChntKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=WVo0uwpY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WVo0uwpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1782923301;
	bh=0SIBbZI3+dHH+J12sneHcT8Rb7i7ByCVqIZrC26kkdI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=WVo0uwpYjAiC9zBrtJZAQ3nn4jNNOfvPMm8qwfpx4rxIbXKy+s83QsOMSvoGlNqGF
	 0RhfHWCZ8dVjA/IRBHw8q9zL6mFqRbBGMDFVZucfDiRZbeppyqoxurbroJ0Xe1lras
	 XrO7TcNnmHS/loR+08F0OQysCJmHqZcAAAZBFuMsVn95NpiLUayn8uXBPmcCY9eoAA
	 oAQ53EVAPQgBGIDQNZywkkq9tdlEsoRcpExUI8WSILW6EQJrFRkslJCeYmRY5k2TR+
	 pXf8s4nheXa7lT/1D76V/O6e5Ex8Sbk0br4oRR/a0AmX9BXjHWUv7B45N2DCpXf5ti
	 oIaW3IveyDHb1/9edhMRWsE2MuW1BUaeLe16rJaUwwOzXDCQm1Qwy2QAfu3101nNno
	 8iIyjU/becgBJP96XxcRWXR3GuZu3bhujuaU939ZBEUE45TbSesTaCRFGU13NlPfv7
	 TPf3Xtd0O8q3bWCBrAzsvuj3rYoXFhYGu6LSGZ3f95bCnK5YzU2
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8be:d07b:4d0c:a513])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 18AC620074;
	Wed,  1 Jul 2026 16:28:21 +0000 (UTC)
Date: Wed, 1 Jul 2026 16:28:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jan Palus <jpalus@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: RUST_LIB dependency on LIB_FILE in Makefile
Message-ID: <akVAI4dJlC_ZdguT@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jan Palus <jpalus@fastmail.com>, git@vger.kernel.org
References: <akO9JTUIlHqBrgny@pine.grzadka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WlSO5x3C30ZxiTDX"
Content-Disposition: inline
In-Reply-To: <akO9JTUIlHqBrgny@pine.grzadka>
User-Agent: Mutt/2.4.0 (2026-06-19)

--WlSO5x3C30ZxiTDX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-06-30 at 13:07:29, Jan Palus wrote:
> According to Makefile $(RUST_LIB) target depends on $(LIB_FILE):
>=20
> $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
>=20
> but is that really the case? As far as I can tell $(RUST_LIB) does not
> use $(LIB_FILE) in any way and there's no such dependency in
> meson.build.

It is really the case.  The Rust code in `src/hash.rs` requires C
functions in `libgit.a`.  The tests won't run via `cargo test` if it's
not built.  There will be additional uses of this code in the relatively
  near future and they will definitely require calls to `libgit.a`.

The lack of Meson functionality is likely an oversight and I'm sure a
patch to fix that would be accepted.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--WlSO5x3C30ZxiTDX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpFQCMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/jkRIIQL7/holwnm83mHk6tD1pVcdIuKFsRXrGWa+63
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJ23APwKac4cEstXn2LDnqdTlYxTgaZh
XmkTyPxvR4LWKiesUwD/QfGbUEdLuoDbhe1DvytROk9Ksku/qbwJNqMZXJ+5VAA=
=iz+8
-----END PGP SIGNATURE-----

--WlSO5x3C30ZxiTDX--
