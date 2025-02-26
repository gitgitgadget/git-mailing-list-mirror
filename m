Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8322620C6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612983; cv=none; b=smLtviHB4cH6LOgdbTMB2YGvlqOR6U3IClb1jAhDby9jQ0st5PpZ4KnyJpqfpH8iy1DPkHaOMbFn8uGRfc3KicxKwNuDUGF92AVWBbzp4/l7eFjwqwsZd24fAdNKioipHrdqg/Y45WN/Nj0P1e5PEPMNAko2KZpTLIBt3/UlDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612983; c=relaxed/simple;
	bh=w0EfLjPbjhHrLtss3LbKMS+jWxajP5lmvfJDtMFkOQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4WiKFFKv6cQiBpNxE75I2f5H6GA8DIyCX3rf/b6A1UnMM7D9pR834QMqf/55JhaC+vHOlf0JpsIhMb0/Whr+7FVNCRgx5my0ndc7706VMZn6RSF79J5lwq+b1VtrjtuSgpWZyVkBqShtNtrP472Hj0oS9xwYRhQ2hTdwS1I6/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1QdRxN7D; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1QdRxN7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1740612973;
	bh=w0EfLjPbjhHrLtss3LbKMS+jWxajP5lmvfJDtMFkOQc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1QdRxN7D7YG3kTgGJ1iay3TA5g3Po+jaHo7AjsIZCX1v8jRFemxVu98Sfv5RwSfvJ
	 aSPvql8qIkHoIbmyodsuMi5YL7KYTmMfwPki7kJdnDe6RgwcmRG4htc8VSUHdscyJI
	 8X9+wp4uFiDWji1tUPaMkcOCbI0Lqom4sdxjrQRYlcaOpUq6p0HQJVPgy2Y3fkVBbI
	 k3dY5/o+DdvK5/2L1f0ftIAr6UDXSagk+isnSOr1h/xk2eKH4PT+hfNeLHJ2ZZyidA
	 h3iisp53VsCcJ3ewEZGU9XvODn9NDpG46m4XNcFUxkMk8oeaXa/KyiSxa8fu4ndLSe
	 td3CBLLGdBVGkFO7HxqQEQ4Ks6cQaQztCv8dGLQnHjcIwp3snFWJJSQON5lWB6DVU1
	 q9G9MNQgP60r8DEWv96ltrSO6UNPztr0vh9nWoma3iEWIMP1Q+aX1a0KHeiknVMrBx
	 DyXNt8oFMgV07JEnTj3+6bo26/6XouKGavf/in4W5nRzLfLZdrg
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f900:8f49:f307:5d4e:79ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EF3B1200B3;
	Wed, 26 Feb 2025 23:36:13 +0000 (UTC)
Date: Wed, 26 Feb 2025 23:36:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
Message-ID: <Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
 <20250226073822.GA21138@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I6Zs/9rtSI0RD6QT"
Content-Disposition: inline
In-Reply-To: <20250226073822.GA21138@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--I6Zs/9rtSI0RD6QT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-26 at 07:38:22, Jeff King wrote:
> On Tue, Feb 25, 2025 at 11:44:33PM +0000, Yaakov Smith wrote:
> > When using "git config --list" however, this is emitted in its raw form=
at, and can be used to mask or hide an actual (probably invalid) value:
> >=20
> > $ cat .git/config
> > [core]
> >         somevalue =3D "true\b\b\b\bfalse"
> > $ git config --local --list
> > core.somevalue=3Dfalse
>=20
> But here, the point of "git config" is to show the output. If we
> sanitized it (especially in a lossy way like we do for error messages),
> then any program reading the output would not see the real data.

Yes, I should point out that, among other programs, Git LFS reads this
output.  Changing the output format would break those programs.

> > Should "git config" be smarter here and print something other than a
> > literal backspace to the terminal, like "git fetch" does?
>=20
> So I would say no here, in general.

I agree this is the right choice in general.  I wonder if we might want
some sort of human-readable output option that might escape these that
users could use.  The output might still be machine-readable, but it
might be easier to parse than the current format, which has some tricky
edge cases when a config value contains newlines.

We already have precedent for this in core.quotePath and could easily
use similar logic here.  That format, while using octal, which I find
ugly and hard to read, does have the pleasant side effect that it works
correctly with POSIX printf(1) (which I'm sure was intentional), unlike
hex escapes.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--I6Zs/9rtSI0RD6QT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7+lbAAKCRB8DEliiIei
geaeAQDGdtjI6RnvBq3ArzT0knmVq5rNIbNLhW93sN/dsCiLqgD/QVJRvwMNbDXw
7ek8x/DjqNyxx4AQZX+XKyhMMmLgvgI=
=DtrT
-----END PGP SIGNATURE-----

--I6Zs/9rtSI0RD6QT--
