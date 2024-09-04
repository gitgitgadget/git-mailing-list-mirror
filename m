Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8713D61D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476638; cv=none; b=kFnt/7+ux3d+y8daPZikb0BxTwqq0jjTABH524MJ1QubevHfTfnvF5RfcrKTGq8Aq+NB8cNpctLXG1nJ8olCzGiqXq+RpGNJTAYaR5Q6WXPplICipalghAxR/AR7gAgyHwQFgiXFQIb6Y+cZfD8WST7393Dq/xqudO88Wo1auhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476638; c=relaxed/simple;
	bh=KM9f44XfGpGkz/kU3qKyIIPsQRcpwZpq2IiqEIffFtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVFVmG29fKOpfzy2DfuujuPWkLxhWVv+uANHSjMT67j/bYvuoo/tc6TD+t6z3yQ9TZUDlwb4EZ3ytNjcUMiFjPYEnGoKvQOAKy/uD2GWNsO1cTNzE7NxTvtGo/yhy9xMEj2kN4V/QuZA3oor0+iQ55329s3WYuVYoAEiV3QR3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bFQg6ypt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bFQg6ypt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725476634;
	bh=KM9f44XfGpGkz/kU3qKyIIPsQRcpwZpq2IiqEIffFtc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bFQg6yptVnZm2eZiA/mYSMd7o2DoXW2Sl9IDgJjoFB1L8pULu5Rt6ochJ6w0//H4e
	 IHBW6Qd5vdIuJKYj/5RlvEfmT506EqYMdqgfQdwIzhqdc5snQMPJ7Kzz7f3mJ/bxLw
	 5Z685KG8I4hAKq3983Q/VeEVJwDy87gOcotL5i4PND4hXi3ha1JLsfmjAwkQBJGMUp
	 Cf59PtXDO7JEj0UiadkcfNJlvSBWbDzQmWshPBHRMYw1k/f8GcXfX2uhmgRorwqsJe
	 Eqe8UoqMXoyVcIuInH3VTAJkQvQN+8LX7JfMbm/k7Cw/IZIVuvD83+sQX+tnqdxwQ+
	 BeH6KeYj0CJEWgI7i9SFQ9H48+mpXPcjBw5xBFxBzsPXUHM7svNiBR/vh8bZ+XJ8U7
	 L40j+gPMRUt6TlmmSOdMUyH/jLLQn2YOAsxPYTAxyGGq5NzeC89EJ/toIYfKRxO3Yy
	 NNyKRmsDZxDh3P+fXKYz1dv415t6EXcrfqj2UMqoKvxAj5qd0Th
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DD871209AF;
	Wed,  4 Sep 2024 19:03:54 +0000 (UTC)
Date: Wed, 4 Sep 2024 19:03:53 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	git@vger.kernel.org, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
Message-ID: <ZtivGeDZ_MZDEDB_@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Calvin Wan <calvinwan@google.com>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	spectral@google.com, emilyshaffer@google.com, emrass@google.com,
	rsbecker@nexbridge.com
References: <20240904173053.1220621-1-calvinwan@google.com>
 <xmqq8qw79slu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6PS4yFANQFtv5BMb"
Content-Disposition: inline
In-Reply-To: <xmqq8qw79slu.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--6PS4yFANQFtv5BMb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-04 at 18:33:17, Junio C Hamano wrote:
> Is it "we need to access the guts of Git implementation from Rust"?
> Or does it merely serve as an example application to have Rust
> bindings, a good goal to have to give us an incentive to clean up
> the subsystem interactions in our code?
>=20
> If it is the former, we cannot reasonably achieve that goal until
> some form of standardized foreign function interface becomes
> available to wide audience.  If it is the latter, on the other hand,
> it does not have to be Rust---if the version of Rust that is
> distirbuted to the mainstream users is not yet ready to be used in
> such a way, we could pick another goal (like, "Can we clean-up the
> interface cgit uses to call into us, so that the parts used by them
> look more like a proper library?").

Traditionally, in Rust, you don't use the C-style types because that
leads to portability problems.  Look at how using "unsigned long" as
"equivalent in size to void *" has gotten our C code to have sharp edges
on Windows, where that isn't true. The approach one typically uses is to
use things like int32_t, which is i32 in Rust, and size_t, which is
usize in Rust.  This leads to much more predictable behaviour on both
sides of the FFI.

The C-style types have long been available in libc and other crates that
are designed to work with C FFI, and as a practical matter you do need
to use that crate somewhere in your stack (or reimplement it) to call
functions in libc and the other core system libraries, so you're not
really lacking those types.

They're also available in the `std::os::raw` module as of Rust 1.1; it's
just that as of Rust 1.64, they're in `std::ffi` and `core::ffi` as
well, mostly to help embedded systems (which don't have `std`, and thus,
don't have `std::os::raw`).  Using `std::os::raw` or `libc` should be
fine for Git, since we're not targeting operating system kernels,
bootloaders, or firmware such as UEFI (I hope).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--6PS4yFANQFtv5BMb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtivGAAKCRB8DEliiIei
gW4HAQDaAzoTJaNFPP2sx7eEDCai9Udu5x9Df11hsyLHf4HBKgD+LjTF6HHKr+xG
u9Zt22u40kYByGPv3Vv86ZYF64hXpAQ=
=CdQU
-----END PGP SIGNATURE-----

--6PS4yFANQFtv5BMb--
