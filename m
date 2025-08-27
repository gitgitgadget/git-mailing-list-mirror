Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11210A1E
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255884; cv=none; b=NSFug6UQdp8fau/0rAAT8xsEvpu8KkbKLX1ZdtREgM4l7y8XgTn48UAzSfGknWY9aK6bFv1NnjHafiKRjacfPrUsW2vri92NXNqYjZU1V1uTzqI7rfTqwm4yk7BLikwPShOtXjnC/oAgeBV2BGIbw/3ifptUptfG18QNiDBnMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255884; c=relaxed/simple;
	bh=Enxi9sFH5f7WcepyX3s6200eICPIWhCaYRIBfIPBIH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ao4qLr8cJud1mlkA8bv2abwiceDMid7cWyquQgt6+AGJarOSz0QK96vY1gF7WD5FjLFHHwJC2a7lTsMEO4hcu301ckNzm4zhkRAhOx1k8cCTFPrLKdilXe0XmOKd4z/cxvrHCCsBwbmsbsMb/zLTvI2fyiFJUGNFTcHISPMZkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RNwvMTMo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RNwvMTMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756255880;
	bh=Enxi9sFH5f7WcepyX3s6200eICPIWhCaYRIBfIPBIH0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RNwvMTMoiNubwc5D4cy7cwugraES4+U8SgavNnLza+mgjYwQOSMNLiWlvLhmGPXg0
	 8MADXVZGnl3JOV33fPKs7szW8Z9a7blBSWgu+iYMK8CCkK2qPDdViWSol1MC4VORzq
	 Vl/nkp9Q0OApUEeR45kXHL5KlULgEQfvDMXx7CPw9SANaOq8Fl9JuyZFlLNUxTkXan
	 67E5oiCVoFOAB6j5X2mCgNGYBMtAt2xJ2MAFFc1EOxxR5DIhubY17VmZC+UOxI2sh1
	 39EXSXACiXffZy3UQQDbiir8vOhXkFjgxDdFJdpc1L93ha0kl4CnRiTKJdQDfGMU05
	 6j1yQffAjbrS+73LHxdDPtBtWvcbtmMLleYghnPsNddL1+wu3eKoibpukSJMGr5xLw
	 XXkbEM/Nt4ghcBtGY9Cuyz1ge0Lo/PcZNiyow5Z4Ojbkwao1wrt+X5dEKf4u1kY6Bc
	 xm5Lo5r53qBx2i4HC/ZEIFq1OCSZ06IQNPLjxV3eiFsV3Xa/QKg
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6208:a4d:7e2:3785])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 57B7B200C3;
	Wed, 27 Aug 2025 00:51:20 +0000 (UTC)
Date: Wed, 27 Aug 2025 00:51:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [Suggestion] Handling Rust in upcoming releases
Message-ID: <aK5WhxsEZJDLqsDS@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, git@vger.kernel.org
References: <014e01dc16b3$dfae4750$9f0ad5f0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vPRwqEXTNQ2r4hZX"
Content-Disposition: inline
In-Reply-To: <014e01dc16b3$dfae4750$9f0ad5f0$@nexbridge.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vPRwqEXTNQ2r4hZX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-26 at 18:04:26, rsbecker@nexbridge.com wrote:
> Hi All,
>=20
> I would like to propose a mechanism where some platforms can keep using g=
it
> even where Rust is not available.
>=20
> Basically, make Rust a dependency for commands that need Rust but for tho=
se
> that are still in C, do not require rust. This will mean that git can keep
> being
> available, but new development can be done in Rust. It also means that
> CVE patches, if they come, can be done without leaving non-Rust platforms
> hanging out in the cold. It does mean that some commands will not be
> available on some platforms. This has been a well-established position
> by git for many years for other non-portable dependencies, like p4,
> subversion, and send-mail.

Unfortunately, this is going to be very difficult.  The first proposed
Rust change will wire up the diff code to use Rust.  That's used in a
lot of places, including diff, log, format-patch, show, and others.

I plan on using it to implement a new format for the SHA-1/SHA-256
interoperability mapping, which will be involved in a large number of
code paths: index-pack, fetch-pack, upload-pack, and others.
Theoretically it could be compiled out if someone doesn't need that
functionality, but then all of the code that is involved in speaking to
remote systems needs to learn to not activate, and that's a lot of messy
conditional code that almost nobody will test.

A lot of the memory safety and performance benefits that we'll get from
using Rust code are going to involve core functionality.  I will admit
to having written my share of segfaults in my time as a C programmer,
and if I can write substantially fewer of those by using Rust in core
places in the code, I'd like to do that, especially if that means we
have fewer security problems.

It also contradicts the proposed policy.  Under non-goals:

    Implementing C-only versions of Rust code or compiling a C-only Git.
    This would be difficult to maintain and would not offer the
    ergonomic benefits we desire.

It also doesn't address the memory safety benefits outlined in that
document, including the fact that memory safety vulnerabilities
constitute about 70% of vulnerabilities in software written in
memory-unsafe languages or that the U.S. government is planning to
classify development in memory-unsafe languages as a "Product Security
Bad Practice".[0]

So I don't think this approach is going to work.

[0] To be clear, I don't mention this because I agree with everything
that the U.S. government says or does (I certainly don't), but because
this advice (which I believe is correct) is influential on policies
around the world, including in governments and large companies, and that
will affect people's willingness to use and adopt Git.  I would like Git
to continue to be the version control system of choice for users around
the world, whether at home, at work, or in the government.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--vPRwqEXTNQ2r4hZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaK5WhgAKCRB8DEliiIei
gUVBAP9LeDpahSr3yDekZm3dQO1u5HeYalZEJsG1ZEQcAhx0+wD/dqLWomogRttu
fe18b0RT2yjYAgA8SHinJe3gDjQf3Ac=
=CFzY
-----END PGP SIGNATURE-----

--vPRwqEXTNQ2r4hZX--
