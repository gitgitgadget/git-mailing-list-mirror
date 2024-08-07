Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B614A09D
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066825; cv=none; b=QL4NOM6Y1ZGxj//80Dw2sd/3zjmSnmqcatdsrlknV8iPiKYuF8hxPIZ4SNANz1+aJLgeRhwaQlRG9EUO1g4t8YFJqsdT4m2RsQQ3DRFxZ/7hbQocvalW0lrPNTFasxsgkXTLjRjuCvlC+hTwUB2ZFv8nwvxEyZTFewl3mRQevR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066825; c=relaxed/simple;
	bh=Ud+dtGOmiI+BEP8USOvYk75F1Tbx35Cy0klEbdAYGbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLehBLSfMb8MV5aq7I66ArGHnXrG+i9tJeLZBVc+7UMVfAU9Q6V1OhunNw0LunPIO5NvDH3vb16fKma2ykjuuStzU/6guzohkCDtHOgnwgJr8eQToUkNjf1koQvYeL5FOoMQjEmC1h61F5kHkzogGH9nVZraHBb/CUE9K1Mnm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mW+al6GT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mW+al6GT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723066821;
	bh=Ud+dtGOmiI+BEP8USOvYk75F1Tbx35Cy0klEbdAYGbg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mW+al6GTkCFm3G4wulwh95l5lB+MvD99IQCW64k5vlIIUXO1WxCR+SE/f5c0oZVWG
	 6piQ5zmRqjSUV1X6sCQMIsZmm5K6lJp+MJ0WKf31EPKm3vJM5afoDslygSU5djUMXk
	 K1eux1bliE//dHY7QmCMzYuOJHYf7X3OItDNYGqtGbSNrgZg6detuP6oM6F3a95YGY
	 fmHYRCn7UgUJx+PB4XfzWwUYkiD47wcchE3+ePn1RwcPVA5cnr7HzOl1guRBYlC3fV
	 0NEy/1hVPLoSwxbU7ALg+dHUVFr4fzP3zPNq3Cg3OpemZO+H1Gf8+YyiNyGMdavuwt
	 taZeXlEjLz3fxQalJNKwfrgltJcGkmTwTJpRvZX3vxHmPlG8e11fSAx/qX9R2xLIym
	 DNvl1LHsjF9xGdqJFY8QUWBOVUEHFcEgJQyCSAjbJ6z0mdKYWIYbqbgnwx41K3sYKN
	 Tg5TNmLV+WvdP2gZmcZ29hE+k9GhhQt/QNWYEFxU2GnEl0ZmNUO
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BE9E0209BD;
	Wed,  7 Aug 2024 21:40:21 +0000 (UTC)
Date: Wed, 7 Aug 2024 21:40:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
Message-ID: <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <1e981a68802ac5aa7538381eb9469e524265ee40.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EKDVR/3jzF6+65pP"
Content-Disposition: inline
In-Reply-To: <1e981a68802ac5aa7538381eb9469e524265ee40.1723054623.git.steadmon@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--EKDVR/3jzF6+65pP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-07 at 18:21:31, Josh Steadmon wrote:
> diff --git a/contrib/cgit-rs/Cargo.toml b/contrib/cgit-rs/Cargo.toml
> index 7b55e6f3e1..5768fce9e5 100644
> --- a/contrib/cgit-rs/Cargo.toml
> +++ b/contrib/cgit-rs/Cargo.toml
> @@ -14,3 +14,4 @@ path =3D "src/lib.rs"
> =20
>  [dependencies]
>  libc =3D "0.2.155"
> +home =3D "0.5.9"

Okay, here's where we get to my previous mention of supported platforms.
This depends on Rust 1.70, and Debian stable has only 1.63.  Trying
`cargo build --release` on that version returns this:

  Downloaded home v0.5.9
  Downloaded libc v0.2.155
  Downloaded 2 crates (752.3 KB) in 0.17s
error: package `home v0.5.9` cannot be built because it requires rustc 1.70=
=2E0 or newer, while the currently active rustc version is 1.63.0

My recommended approach here is to support the version in Debian stable,
plus the version in Debian oldstable for a year after the new stable
comes out, which is what I do.  That gives people a year to upgrade if
they want to use our code.  We _don't_ want to follow the
latest-stable-Rust approach because it isn't appropriate that software
has a six-week lifespan of support and that isn't going to work for
software like Git that people often compile locally on older versions.

We also need to be conscious that while Rust upstream provides some
binaries for some platforms, many platforms rely on the distro packages
because Rust upstream doesn't ship binaries for their target.  Thus,
simply using rustup is not viable for many targets, which is another
reason that latest-stable-Rust won't fly.

Debian stable is the version that most projects who have defined
lifespans track, so it's also what we should track.  According to my
recommended approach, that would be 1.63.

If the Rust project agrees to provide LTS versions, then we can switch
to those.

In any event, whatever we decide is necessarily going to involve us very
carefully planning our dependencies since some crates depend on the
latest version whenever it comes out and we're not going to want to do
that.

I'd also note that we don't actually want the home crate.  The
README says this:

  The definition of home_dir provided by the standard library is
  incorrect because it considers the HOME environment variable on
  Windows. This causes surprising situations where a Rust program will
  behave differently depending on whether it is run under a Unix
  emulation environment like Cygwin or MinGW. Neither Cargo nor rustup
  use the standard library's definition - they use the definition here.

Except that in Git, we _do_ want to honour `HOME` at all times.  Thus,
the use of the `home` crate instead of the standard library provides
exactly the wrong behaviour, and we should remove this dependency.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--EKDVR/3jzF6+65pP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrPpwwAKCRB8DEliiIei
gaLMAQD9hul8NNNd6RDHvjdoV43iaFPm8MfdmZ8AChcur/lsUAD/SBeMTwOyWnOV
khp/tCsNCYF4n5edcmqklBNgDh/3Dgs=
=NCS7
-----END PGP SIGNATURE-----

--EKDVR/3jzF6+65pP--
