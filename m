Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E715C12F
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725720843; cv=none; b=MV8x0+q2M6wjQynDlu5jcSO1JbaX6UFUZdFPzynLHIPqfAUZOsAj5cQ1m8g9JK9JBmRJWMB8I+jgetTn99s1cjlecD/AMti4h4/7tlmBAWw28hZlre1mz0Dme45rIcR8N9jyyZno6lq1e86kdYffvUmAY9e4YG5+um1OdNbHtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725720843; c=relaxed/simple;
	bh=XhnG7GIN1MX8wmUCArzSM9hJzvGnhY0Ct0Bbxh++Ms8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz0dc/5IhTxzRk5qEYLFtiU2b6yTQUn85anJYZ4MFqQprMlx16MiqDHE5yiGjSKOEUnSdmNX2Isa34c353QI9EgOXHsSWy18tuB1V00+WHBcXC0N2Y7ho7jghZmD2vwb6iLGkh7dt9Xt1kYk5st1wP/7sOZex2VohviTUwY7lT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=d13M1his; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d13M1his"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725720832;
	bh=XhnG7GIN1MX8wmUCArzSM9hJzvGnhY0Ct0Bbxh++Ms8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=d13M1hisuhF4+M5ZXWkg4RbqWuuRY66GuDVm2qJwRVxELEGZ/V6NaZK6u2nHwV/P8
	 cjBS+XUJEbHQWPXYKB6nJLPE6ypvLBRZyDrrV/HobEyMgZ2DlHIUZ33Yky3UcwpQv6
	 Rfy/duRQl/znO10w+45F/b333R7/P3lWD/ax5CJ4OKp5ugFJxiE0+JOHIen/0D7muv
	 vld7nYg3wqe94NX5zaOmW9HO81xnvbp9V9mz3ihlunBHpkrowzP9rWkna7UJFuLe/i
	 glJ0TMKn+yq2AyPPU20t0BtyNB9wXp2o+a0kvO0/An9T8K/BiPQnf9+PkC/EqvOzwk
	 YAzM879DNA/Xe4gwW+3zHAFv37nxQ4jUUBmdK3tBbycihVSyVsYOLsO5UZjjs6IK5B
	 bzT+R+oWy0TJYYukj/5VKand84ihAp5QdtBhA+gKmfj7J8eCfVBJ/AiLE9zUDl8APQ
	 HaimV4vlcG9tXZWFMpJTmq2T9kLZwA+xUXwUtzkiujXTImKbF+u
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C131B24454;
	Sat,  7 Sep 2024 14:53:52 +0000 (UTC)
Date: Sat, 7 Sep 2024 14:53:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Calvin Wan <calvinwan@google.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	spectral@google.com, emilyshaffer@google.com, emrass@google.com,
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
Message-ID: <Ztxo_7ijHGmQKH5T@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Calvin Wan <calvinwan@google.com>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	spectral@google.com, emilyshaffer@google.com, emrass@google.com,
	rsbecker@nexbridge.com
References: <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>
 <20240904173053.1220621-1-calvinwan@google.com>
 <ZtidjMThNwiI_QG8@tapette.crustytoothpaste.net>
 <CAFySSZB56V-h0zxcv+TtP0jmTYAV1gixanCf0toYqak7Mz-yGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7IMiBG/q6BKvUq/B"
Content-Disposition: inline
In-Reply-To: <CAFySSZB56V-h0zxcv+TtP0jmTYAV1gixanCf0toYqak7Mz-yGQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--7IMiBG/q6BKvUq/B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-06 at 19:37:18, Calvin Wan wrote:
> While this gets rid of `std::ffi{c_char, c_int}` dependency,
> `std::ffi{CStr, CString}` are also 1.64 unfortunately, and I don't see
> the equivalent of it in libc. I'll reroll v3 without this change for
> now. Hopefully Debian stable just upgrades to 1.64 or higher and we
> don't have to worry about these ffi conversions :)

I think that's actually a mistake, since some arguments like
`from_bytes_with_nul` are labeled as 1.10.0.  In any event, the
following program compiles fine for me on 1.63, so I'm not worried about
their usage:

----
use std::ffi::CStr;

fn main() {
    let c =3D CStr::from_bytes_with_nul(b"abc\0");
    let c =3D c.to_owned();
    println!("Hello, world!\n");
}
----
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--7IMiBG/q6BKvUq/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtxo/gAKCRB8DEliiIei
gXgtAQDsoQKlhgBsvwEW/aFI3AfpRbXQiqxI6EQ0unXI7X5pFAD/V9AKvxmdV8yM
HbAWc1F+sxlGEIXfUAIw9T5nr5HVfQE=
=UbR+
-----END PGP SIGNATURE-----

--7IMiBG/q6BKvUq/B--
