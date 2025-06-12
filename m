Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1196C2F2
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687892; cv=none; b=ooZO+TjzIAJnLKNXVT54UCxzyeQBHWL5vgYgU7ZUue8NFilblo3rVdIltR6eEi1bkZpIibiRyr7d9LA1nExRxuL6AugSZkSTr/7dB3mG4gERfBBdnoXIvAwEquJT+u5UkiIi6PaorgaW9YHGeQf1OwpwjilzeLPlRJ5Cf9Equk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687892; c=relaxed/simple;
	bh=AMgz2RQXB+wj8MIshlWNjafUF9wFeI+w89P6COLl/po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia6W8bA2nnX3Z1NAAaSbc8TyXE+QgfhYiD32KBNiFf4Q60NGaJ8ZV6DcMH9rL/LOSyjZDlciFFaaDIRKG+eGY5EHj2tBRluJDqL0r2dqCT6r5NgiaM8Z17FidTX7CxNIDNckP0Uh+hhfBZSu670/mmFmuwLW0FZ1HNSOFKw4Fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=j6U+Og3w; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="j6U+Og3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749687889;
	bh=AMgz2RQXB+wj8MIshlWNjafUF9wFeI+w89P6COLl/po=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=j6U+Og3wadDc5DiQPFtyTMeJMtT/5jAClHhC63igzVINGmyXmJe0+0Sq2aOsxOaqn
	 uz2c45etwPuiYQPaPVWr/8GwjLwi+RxBFgnu7oIHZ65XTZ2pWPMAXfIvPMikuIKtSs
	 2rY7z99DqLszgI0WHdjqM/KUXjN3U7eMsLb1iM79x/Yu7uPc9SjChkF7pCAbPyq02/
	 gP8AnehcaGcpXNwKhQXWLwJXoGKrj+F4c9Yvs6DuRBWBJkJAuHQa7cl5Oi2oSj3OOf
	 E9GIpNB94YWmRc855Ba16Iz2ocx1k3TJsZ/GYWxYssZYWLRxg45RTJIeEQDFjln6gF
	 R+jvt9rBYMBNh+dVzri/fKrXmwOf4lCD3XcsxOfh2LAJBZ3gtAlxGKpvsAZ7p71HXZ
	 VfSeeO5BZeaF4kddCbj2deYAUkOVk3bpxCWYGt7pPN4ZzusAG4UbwcfukmYA+jqwe5
	 U3o+HRLsAglk9NgznkkyJMb7krol58iMRKlzQ9e27Cos0Fh2usT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7CF552008A;
	Thu, 12 Jun 2025 00:24:49 +0000 (UTC)
Date: Thu, 12 Jun 2025 00:24:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/6] bswap.h: Add support for __BYTE_ORDER__
Message-ID: <aEoeUCcXYByjU5HR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	git@vger.kernel.org
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
 <20250611221444.1567638-3-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="imjwamQaknGVaCk9"
Content-Disposition: inline
In-Reply-To: <20250611221444.1567638-3-sebastian@breakpoint.cc>
User-Agent: Mutt/2.2.13 (2024-03-09)


--imjwamQaknGVaCk9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-11 at 22:14:38, Sebastian Andrzej Siewior wrote:
> The __BYTE_ORDER__ define is provided by gcc (since ~v4.6), clang
> (since ~v3.2) and icc (since ~16.0.3). It is not provided by msvc as of
> v19.43 / 17.13.6.
> The __BYTE_ORDER and BYTE_ORDER macros are libc specific and are not
> available on all supported platforms such as mingw.
>=20
> Add support for the __BYTE_ORDER__ macro as a fallback.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
>  compat/bswap.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/compat/bswap.h b/compat/bswap.h
> index b34054f2bd728..0a457542dd76a 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -116,6 +116,12 @@ static inline uint64_t git_bswap64(uint64_t x)
>  # define GIT_LITTLE_ENDIAN LITTLE_ENDIAN
>  # define GIT_BIG_ENDIAN BIG_ENDIAN
> =20
> +#elif defined(__BYTE_ORDER__) && defined(__ORDER_LITTLE_ENDIAN__) && def=
ined(__ORDER_BIG_ENDIAN__)
> +
> +# define GIT_BYTE_ORDER __BYTE_ORDER__
> +# define GIT_LITTLE_ENDIAN __ORDER_LITTLE_ENDIAN__
> +# define GIT_BIG_ENDIAN __ORDER_BIG_ENDIAN__
> +

One additional option you can add if you want (it's completely optional)
is that if `__STDC_VERSION__` is 202311L or larger, then you can
`#include <stdbit.h>`, which has `__STDC_ENDIAN_LITTLE__`,
`__STDC_ENDIAN_BIG__`, and `__STDC_ENDIAN_NATIVE__`.

That will work on a modern GCC or clang with an appropriate compiler
flag.  I don't know about MSVC, but it might be an option for people who
want to use more esoteric compilers which support standards but aren't
very compatible with GCC and clang.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--imjwamQaknGVaCk9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaEoeUAAKCRB8DEliiIei
gdZNAP0fVYg+ero+6ccIo76riDlSAN9+xFl2IcBjPv/JxI/BvgEA7/RxUFMYpkv1
WdRg/t1lqQNEAvyAt0FNFYUCfOvl+ws=
=ldxA
-----END PGP SIGNATURE-----

--imjwamQaknGVaCk9--
