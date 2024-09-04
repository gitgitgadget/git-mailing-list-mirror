Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158E1DFE1A
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472146; cv=none; b=R6rrXlAGQVyZzIRN9Wi8dsIt7VM9PEEl1PqCW6tLe4mdKPW0FjtFK/3M/k/9QxBiRrrzX2qvmCA69p7IMNKiSbFfkHklILFDGVz2HNjHHzbb4gjzIU8KI9NBPDrmAxTqD/IVzVQeG36L+ydccIUz0cjT7UhU7oGZeODOMlP+39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472146; c=relaxed/simple;
	bh=DVfYwJulhlyg5Guju0PzIpwZKZnKP+xMOpWE4QwbSDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNQDw+aCzGTrjSsoztfzFY1TmeNGcLvv7pr5j/Nf8d/18Auj+giM6LwIxEHfOVH6srKc444hhA6VrXtDdANzdISxMz+f27jBf4Dhw5c7O2Mancu3+60X4rTRoPx8kJoESinU/J7C0gyZE0y8O7YgCQvI41vghoBMvzLx4cieql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bRtwp5DP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bRtwp5DP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725472141;
	bh=DVfYwJulhlyg5Guju0PzIpwZKZnKP+xMOpWE4QwbSDo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bRtwp5DPd2fRBnWb+tSSTSlruyJnbTpvP4okp93AeIVZoIjwtoY25y88iwNWCjIBO
	 dIuMPKPk8xtiYo+irETVfOPQN4n3uhXM0GwgDtxmK3gnRQ94H1tKSnQkut3rVjVzJn
	 KUWZO4UsZ81s2ZgBxFnPYaNdOVYj1zS2fKn4zV4mzOvXNy9tTcqihYYYwK5hrPFT7/
	 JdZaUDQG51UtPZzU5ha6byDgkTesp0e24d1ehMrbtxglLc5/xSzslNF4TN+DXMKRav
	 iO/biX4zOv3jVwGGq/4zuvpBrAWNs8fC93TgloCTBlkRNoNCDbGR8eHVK5tvxkmu5I
	 2SNoI0tHHC/9tjLyT6a8g/djdYZPcc+Tifk88rw0YAZYA0jcIs253xx/1XR8XWM5h1
	 f5Cpl1RVmUYZ7nCvzu/LcEjUoOFabKhhPRVm6nV56uhc3ukL8s2EMkYiHvXBT6iY8r
	 ryMX0TYQ219lHh3o1w7S6v1mAFvSjD91p2QPEOi8lnH3bUem03a
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E6956209AF;
	Wed,  4 Sep 2024 17:49:01 +0000 (UTC)
Date: Wed, 4 Sep 2024 17:49:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Calvin Wan <calvinwan@google.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	spectral@google.com, emilyshaffer@google.com, emrass@google.com,
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
Message-ID: <ZtidjMThNwiI_QG8@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Calvin Wan <calvinwan@google.com>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	spectral@google.com, emilyshaffer@google.com, emrass@google.com,
	rsbecker@nexbridge.com
References: <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>
 <20240904173053.1220621-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y1x0fylUzZlTLg6z"
Content-Disposition: inline
In-Reply-To: <20240904173053.1220621-1-calvinwan@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Y1x0fylUzZlTLg6z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-04 at 17:30:53, Calvin Wan wrote:
> After getting rid of the `home` crate, the only other issue we ran into
> downgrading the version to 1.63 was with `std::ffi{c_char, c_int}`.
> Those were only made available in 1.64 and they are obviously quite
> necessary for us to be able to call C functions. Do you know of any
> alternatives we can use? I also don't think reinventing the wheel with
> our own implementation makes sense in this case, and even if Debian were
> to upgrade stable to a higher version today, we would still need to
> support oldstable for another year.

I think we can do this with libc, which you're importing at the moment.
You can do something like this:

src/types.rs:
----
pub use libc::{c_char, c_int};
----

and then do `use crate::types::{c_char, c_int}` wherever you want them.

Then, when we upgrade to 1.64 or newer, we can simply replace the
contents of `src/types.rs` with this:

----
pub use std::ffi::{c_char, c_int};
----

and that's the only thing we'll need to change.

If we switch to using rustix instead, then it will look like this:

----
pub use rustix::ffi::c_char;

pub type c_int =3D i32;
----

While the C standard requires that `int` only has 16 bits, Git doesn't
target any platforms where `int` is anything but 32 bits and it won't
work with any other configuration without serious changes.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Y1x0fylUzZlTLg6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtidiwAKCRB8DEliiIei
gY5FAP9cAPg66/LpxOmkU1HDlwbvmDTN+6tk1ijzdZerShz6bwD7By1qUXIA1VkY
5OQBsQwEcTvc9PSrSVc160Wl6MK46gU=
=89wP
-----END PGP SIGNATURE-----

--Y1x0fylUzZlTLg6z--
