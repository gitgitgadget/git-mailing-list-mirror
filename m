Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106D28030E
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701970; cv=none; b=HNl8EkiQs/LLNNJrb+Ehl7PT9TweEuqjr/yoJRTBoweZv4RMloT6DYrf8v/a/KPBYiS0DD2Vzo95H+qcwj0j6/IOjpok5nblC6aFRfETtjOT90hhfA/49B3gi3I/A6yG5ppciPa5ltm8hP5EuhcnGdqrlXXDSQcVLAHfViMaAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701970; c=relaxed/simple;
	bh=ZZYzCdR3iV7VtRbO3GlZcXGjTNztLI0jkyVV9Oeyqyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5du2vK2qRyKLJni/k7V0BXufrxc9lty+gT6aYdcWgRR9L2KX70j/TGZj9gkki7xwJPpR67q6TfFtlw5ksETaxSR9LGd9QISnL0JFvz91Gdk/MEn8zV1IXHK7kLr6IWrxVRzVJ2K4ZcF0DiF0zXySDMT2gBv8H+rgdy7Gk2a68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MT2MnMpr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MT2MnMpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761701968;
	bh=ZZYzCdR3iV7VtRbO3GlZcXGjTNztLI0jkyVV9Oeyqyg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MT2MnMprfr89AIKjk6xrn3gXalk5aYz6LLXMov0o1obupVnXepzCb4Fg27GJvPqVt
	 nLHbxnc9Qx8jInSlXG5TOLJdRJgcH5KMAx2bdXcM/Y9nvJYLThJjAIHG9A+EMSbToJ
	 UXiSUMH0o/lohEcCrb5zmBq8q8CPmeRP3dupGbHvaG/x8ddtrid2CMyg9ZbTOhdD7D
	 fK7Y/tkgaobOUHH96oAg1O1qLi8ijCnvvsBBieX9fqE58nWlpUh6zE4h9XynLAO5zK
	 YL6XZMAMMEV7FjDnObB9koHgFXdHa44YDwBb5q8hGvAKsETUJeuV7c3CKQIWqVX/3L
	 hZDY/o352uTEWuxkuDhX0ayX3T4aj2GsmOPzCVl5B09VNIKTBwt/X+sbctlgdRwkpm
	 JAPVlmoK9aAVLvJHI+Y2dewTFwy9V36ipgcXF62WTOZYiFHst6gP/CfQhu3FPPi36F
	 LfK9RzoLRmK2gomiyqjD9+9DzC6WXHVI5TjRmzeyXt7zsnW/7Z3
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4FA6020036;
	Wed, 29 Oct 2025 01:39:28 +0000 (UTC)
Date: Wed, 29 Oct 2025 01:39:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 13/14] rust: add a small wrapper around the hashfile code
Message-ID: <aQFwT_9I13yiUXyc@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-14-sandals@crustytoothpaste.net>
 <CAH=ZcbBUw0Rm-O=Xc8835dWKYbmK0L1eksONAzRUa0fgdppb5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8sCIUq0mrSA0lT1W"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbBUw0Rm-O=Xc8835dWKYbmK0L1eksONAzRUa0fgdppb5A@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8sCIUq0mrSA0lT1W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 18:19:27, Ezekiel Newren wrote:
> On Sun, Oct 26, 2025 at 6:44=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>=20
> > +use crate::hash::{HashAlgorithm, GIT_MAX_RAWSZ};
> > +use std::ffi::CStr;
> > +use std::io::{self, Write};
> > +use std::os::raw::c_void;
>=20
> std::os::raw has been deprecated, only std::ffi should be used.

std::ffi with the C types is not available until Rust 1.64 and we're not
planning on targeting that for some time.  This was intentional, but
I'll mention it in the commit message for v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--8sCIUq0mrSA0lT1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFwTwAKCRB8DEliiIei
gSlOAP4sWbqmNNhDpJ5ok06Ef3L7sFazl/d6s9mf6U8g5posHQEAzRGBurIZdEAe
YCKl5CF4gWu84lgk0VVyLPQlRoQZNg0=
=wPNg
-----END PGP SIGNATURE-----

--8sCIUq0mrSA0lT1W--
