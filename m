Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E62D9EE5
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650939; cv=none; b=mvVhUbmMPc0KxBDlcqGamoOp491rRYp1VO3FKjmc7G7RfCLngkcTWSvV8fyrhd3xQ1zKNVEtlKUSx5dYH86Ptq7coCNlbeAFMJi8UGYGkDDeyIsHwwSQluWc+nZSLTMZECWL2ZrUTbekKMGMVX8SBsI52uSTzJrT/6NruK1zLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650939; c=relaxed/simple;
	bh=Fkf+VVwZdDZNCDa3J6pyNM5QV3FnnPxa/MdSQK3QOuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qONS6i2D9n3ASOpw0N2RNlp7OqV8HM8x8e8cRr/fYnki3P0KmJNml/302zYWKlsGc6oFRgFNZ2ubUAAuqnB6OEr4MpMSBQYGzDvZ1GtJf/yaOIdnW86cvKhCbaaQ/gp6rJZ2iKfmnRw7dBL4VvJPhOyMCVYcGKi6k1V/WMKxobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zeH1o8i2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zeH1o8i2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760650936;
	bh=Fkf+VVwZdDZNCDa3J6pyNM5QV3FnnPxa/MdSQK3QOuI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zeH1o8i2b9KZwG5GDgVvVJ8m6d6LY24+mRcoxtIvGK8J4PwHyfPOtd6CYj6L2GKVL
	 cd6tHMRlLW+FrOjtjnZtC049BzpV5AkxfOugwjCNu+wf1eYVeq9FcL3Z5Gh02NxZAT
	 nmwcDnL+E+H2hyq+/AaqSx7AactK7CazeM8OhnVM9aMX1QUbMKSphMiqBwqvkN7uxn
	 opIVKt7j+n+e6VqqhlbQM8P/ZC7P2vbp6gF/FOvrW8uFdNW303c69c5o+yzSsgJIkm
	 kcwf5fZ0vflUCN22GmqidxWl1EcqtB9R8KaojMkVQwyQ59z9MwZv1qkhs2dRWwVwhk
	 CigtZhMEXTUwEGtSHokICSmDvOFBAMtYNFli0RDe+bhbmOJ6mw2wbBQ1TMPiQbxTEw
	 fWxiQzBM8jKi2rnuU+FXr3lalkehTwr2MWGfwd1pZ85Var0LsO+xuoekRL5GnH0kkn
	 oA6zDMqeU6xSBCbzHmj0pSVbgC8Qp1Ici/C3g/FR/8/W1m5nkdp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5c18:db3b:8800:f1b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F0719200BA;
	Thu, 16 Oct 2025 21:42:15 +0000 (UTC)
Date: Thu, 16 Oct 2025 21:42:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aPFmtqFvzB2kMDqA@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
 <aObep4lUP8hcWXxG@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iUrWFLZLGhK2XIYu"
Content-Disposition: inline
In-Reply-To: <aObep4lUP8hcWXxG@nand.local>
User-Agent: Mutt/2.2.13 (2024-03-09)


--iUrWFLZLGhK2XIYu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-08 at 21:59:03, Taylor Blau wrote:
> I would imagine that the definition of "roadmap" here is fairly
> lightweight, since I imagine that some organizations may not want to
> share details beyond "we will have it done by X date".

Certainly.  I think the more details stakeholders are willing to give
us, though, the more flexible we can be.  If a forge says, "we're about
75% done, but our CI product needs another month," that's a more
compelling argument than, "well, we just need another month for
reasons," especially if their previous deadline has already slipped
(which tends to happen on software projects, as we all know).

For open source projects, of course, seeing progress is relatively easy.
Many companies may have alpha or beta programs and could share that
status with us if they don't wish to be more specific.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--iUrWFLZLGhK2XIYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaPFmtgAKCRB8DEliiIei
gR6gAP9c5w5TOZ5vIc3Q8bjMH2ZsOLKCOSQpYmXfOSSg3KwPmQEA9PbrsGBmK5mS
AfuV1UzH2eSqgjxGp2fEFUdUyCkwaAU=
=mb6U
-----END PGP SIGNATURE-----

--iUrWFLZLGhK2XIYu--
