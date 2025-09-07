Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB928725D
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757266973; cv=none; b=DauxA4Ic1kCHXl106q1CxSUzRMOMdsKwQZ/wYPOJM1QfmgbtnDudykMScYOITCQzgp93+tWlbmDWh4oaW7JfsCZoGO12PbV9x8IvJSqfogsLorVs8h25W0ml+SEoA0+tG8us02vnHHxiAMs20FNrrqWb0f/baWQvmP9VTvRlFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757266973; c=relaxed/simple;
	bh=eIbSk1Vz6UtOKDzPe+NRpnvch3ZxskrgAUdZPFIfrUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyKr8qoQO+zUPmFiIPjnVRg8TjfcLoKzdOEXidmC9TLhHoZhBfz13LX2+oRpTDtRZupBErAxi9vFsVVlRei143N1BrXMiZ6Vq/pPsS4eu5X8TqHJqF+Qp0AW647uh6l54+V78unW1V7fZWsLcxFf+pI9spczyoly+wY2E7Ywcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DLvshb0m; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DLvshb0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757266964;
	bh=eIbSk1Vz6UtOKDzPe+NRpnvch3ZxskrgAUdZPFIfrUw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DLvshb0mcxJcJ33fVo3SZ6b9etTNr27Pyb0H1a9JQXgWnGxhFVKMyXuR53HKk0KnN
	 L2Ot07m83pZxgdUGorTfZ9RW7GbrFuJXEjhhEClKKfWWgreB6MITtp/3ZMGAl6qEbv
	 Y+3ienNQkgRICn7QtI0sLuPCNisCnpIhyGvLNYCh4vrWbmHNfEe7AKUiCxlEhbJpwH
	 8r5a0TLkvvQPkblmsv0alpFeXnfG/brcnwTc04MIREwhFyx8xPyRUkUeyjXCoCsF3c
	 7tOnHD451tZikisKSvbJZFyxECIcAVa0Op91SIfQc5jcGtn9dBE+Gj7sj81sTPMYSc
	 EEQUNG00ncN27fv7V3c6Tx8trpqi/NjFlHEwi7ubwvRbPEkjbTGie/nAfzzz+s6kud
	 gcyRx1h8PFuTgD3QBx2cGPXcIImxR8i8W0IL/NFS3tWOrKIoPAeFfDDSnhoOA8VYg7
	 O7IMGl7R6ScrDfOcXeR624aDTSFLgX8NpSBRva+yd1vtY1aV0V8
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3b61:a7f:90:9d10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5C4B2200C9;
	Sun,  7 Sep 2025 17:42:44 +0000 (UTC)
Date: Sun, 7 Sep 2025 17:42:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Milan Hauth <milahu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
Message-ID: <aL3EE7dLMuj6ONZQ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Milan Hauth <milahu@gmail.com>, git@vger.kernel.org
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
 <aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>
 <CAGiEHCvFnhZRXwNVRyzQ4ABi3p0Opdo8+draXoDu5p1R6HZn1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cqaKSAJHb5C+mo7c"
Content-Disposition: inline
In-Reply-To: <CAGiEHCvFnhZRXwNVRyzQ4ABi3p0Opdo8+draXoDu5p1R6HZn1Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--cqaKSAJHb5C+mo7c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-07 at 17:23:28, Milan Hauth wrote:
> > HTTP push
>=20
> im only talking about "read" operations:
>=20
> git ls-remote
> git fetch
> git pull

Yes, as I said, reading directories is only possible with WebDAV since
HTTP doesn't offer native directory listing.  However, we don't use
WebDAV for fetches and other read operations and not all web servers
support it.  We get better web server support in many cases by requiring
that the server side do the work of updating the lists of packs and
refs.

Without some way to list directories, you cannot in the general case
iterate over the refs and packs in the file system without a manifest,
so creating a manifest is what update-server-info does.

This is also why most tools which provide HTTP access in the file system
require WebDAV, since it isn't very useful to have a file system where
you can't list directories.  (We abandoned directory-less file systems
in the early DOS and Macintosh days.)
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--cqaKSAJHb5C+mo7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL3EEgAKCRB8DEliiIei
gUI2AQDsH9Std9cd1M5c1zTAu1pS9Bd/zdUFg8WR1ApGH2DRrwD7BkmcMlqRUZMZ
AnhW87zG4CMh0BdZij/JmxsWtH/aWg0=
=j4hz
-----END PGP SIGNATURE-----

--cqaKSAJHb5C+mo7c--
