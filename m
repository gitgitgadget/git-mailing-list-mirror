Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842124677F
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257195; cv=none; b=R4LJl5RJL16He/KSXnARtS+VLSymwcYN1qrDTEZjzENXOxP052lf93zOiVtR12u1AwsWziUYLun56w4tcFl11EkyEKLeqeXmJdbs+SVNsoVTGsUM1WsP+3CVguRlnjleKDHNRUVriwmXdhzdmyNz5RAmkapSMG5XQ8ICDGeS1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257195; c=relaxed/simple;
	bh=ltNNdVkMUYfYl56Ap81L2PIAkiLw0TRq6F/AZ5i7kPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0Geu9w/T/OeKG8s+dEb2gwO79HpBHHMcV9Rtjk9fyDfoHaHqbzrDDlxnRxtPDldszqY+GO8E+pAoErHsQjMAhaJOBIL3jDRJuteSWSMF0rl//hfxMfqCVQshCRparLLsqEbmH8RstZ9NLqlbaBxFoCdByl8Hf8bH3ttCeK6kF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HGAhgQ+R; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HGAhgQ+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770257193;
	bh=ltNNdVkMUYfYl56Ap81L2PIAkiLw0TRq6F/AZ5i7kPI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HGAhgQ+ReeSkckmaX/cxFV1pjPzRkK12sQMypThf91m5V1K50zhChCTPUr+qEDNsW
	 KHN0K8IPB8mZF04rNA+a+j+U7jvMMXHX+fNBOnKraEKKQz0rikNqK8iNnhH/wnikLz
	 nu9ysYb5TciJiaxY7vlxttOmiuIcZrDpbydEdt83YDATfkVCtYpIRjfV1mr454zIhN
	 c9co1YsEkNStbfkNHtG6N9N7xcvs4r/9v3uEwdEVjjp2BphX09QOPhg60xH25UdkNb
	 eW6VIcZOEibzR5DOCjooYls+rk7jt+todzirnJ3OD9FGFRVhiAjMzSRodZxTvkt5f7
	 MEEzzzHnMQsVCanreizyExtdg0Y6nuTU6Ye1lliX/sAZCV+Yg/X/KZc/r0FbZW7rw4
	 g+A6IsvgtsX1GsGoIU0wl23tSknFb6SKatVYwF45X2O5Wqg10qJOYdkyfpTl5O5KRy
	 qBlr6s4IunQ8GSdoYEJlKZe4gnJ52kfX2cmo13JVrcPKPCooWAT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:139e:b5f:f1d6:55e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ABB3A200B0;
	Thu,  5 Feb 2026 02:06:33 +0000 (UTC)
Date: Thu, 5 Feb 2026 02:06:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: Re: [RFC PATCH] Move rust gitcore crate to a different subdirectory
Message-ID: <aYP7KKD1tDsormI3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	gitster@pobox.com, ps@pks.im
References: <20260204232208.1615320-1-mh@glandium.org>
 <aYPf9CnNLjJtinqw@fruit.crustytoothpaste.net>
 <5h7fs4smilvvuqyry4uef3rjgky5woodmapb3fy72src2hvlzv@o3bbh7zxqqvt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQnpUisJ78KbEb+z"
Content-Disposition: inline
In-Reply-To: <5h7fs4smilvvuqyry4uef3rjgky5woodmapb3fy72src2hvlzv@o3bbh7zxqqvt>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LQnpUisJ78KbEb+z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-05 at 01:45:53, Mike Hommey wrote:
> On Thu, Feb 05, 2026 at 12:10:28AM +0000, brian m. carlson wrote:
> > On 2026-02-04 at 23:22:08, Mike Hommey wrote:
> > > While `src/` is the default directory convention for Rust projects, it
> > > is too generic in the context of a multi-language project that is bar=
ely
> > > starting to (optionally) use Rust code.
> > >=20
> > > Additionally, having `Cargo.toml` at the top-level of the repository
> > > implies that one can run `cargo build` directly, but this doesn't
> > > produce anything useful on its own.
> > >=20
> > > Moving all Rust-specific files into a dedicated `rust/` subdirectory
> > > makes things clearer.
> >=20
> > If we're going to do this, we should place the `src` directory under the
> > `rust` subdirectory to maintain the normal layout.  There are many tools
> > that depend on this repository layout and we want to make it as easy as
> > possible for people to use native, standard tooling to build things.
>=20
> Not that I'm going to argue your preference, but I'm curious what tools
> you'd know that would not support a layout different than the typical
> one, because that means they're broken with some existing crates (e.g.
> those from https://github.com/servo/servo/) and should probably be
> fixed.

One of my goals is to see if we can get Git's Rust code to compile with
mrustc since that might make it easier for NonStop, as well as some
Linux OSes on obsolete architectures.

I can tell you from my experience that mrustc's cargo implementation is
extremely limited and does only the bare minimum in terms of
functionality.  It already needs some help to work with static
libraries, but I'd really like to minimize the work that needs to be
done on it since it's not lovely code, and using a standard layout is
going to help with minimizing the necessary changes.  I will admit that
I haven't tested using a non-standard layout, but I fully expect it will
not work based on my experience of the codebase.

Certainly people may think this is folly, but it costs nothing for us to
keep the standard layout and make the porting process a little easier.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--LQnpUisJ78KbEb+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaYP7JwAKCRB8DEliiIei
gaxfAP9TNPPS+U7vhFtwZP04icf+W73Kzfu0MpnVwnmxUUkvmgEA1qWYheaVYyhA
4Z17bESMWOnHwfGdyp4SjuNqWhrWvwg=
=tBDl
-----END PGP SIGNATURE-----

--LQnpUisJ78KbEb+z--
