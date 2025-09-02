Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C582DCF70
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831180; cv=none; b=QxlGCQZHEBYoqU7VgMwumhR20cDYkrXBf6H83AviM2hi25V/9fjQCaX6LQaVWp5CT+eKewpZSoEaio6spDa3qHAoJP6851b4c8tHYNJ+UFsiexqURg2tfZoKlueGPK4j3V6be5BsSWFxePFO0uUoBNHCPuYv3A+KM22XtxLqT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831180; c=relaxed/simple;
	bh=HMtNxDWgNwxR0LxTfMO992/txUPom+sO0m0Y5OK2+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5CaA09xhIPdyVdOTFK28xumZHyRPvLUkj7XT5sjVhA+mNioD7R3oweH9GeKKuDSCD38l/1eyIrBHK8WQGu0oQ2qAZsNcE4xDgvqxDC7vIdaGnWYwTxSK7KD78a9QHRSg//pM0DXjJ8MuR2RQHLXH0UtRJiVYz+MAekhTxMJ99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cNlyXqve; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cNlyXqve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756831171;
	bh=HMtNxDWgNwxR0LxTfMO992/txUPom+sO0m0Y5OK2+Bk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cNlyXqvesd+b6f5G7JCxjA4DyBiP32ffWrbgX+J9I2jd6wcRhsM+DYX8cyZT8xTYy
	 Tyxv3uSrr8RAB/hMZIRXP486AHdh4H59if/eDWm68pBvItMYm6npPHdPpkbOAw3Ova
	 RUv421x8WE6CIMtP57Z9ljAzFebJyJpHmQlYCQDy8mXUk/oGtGs/eoVGwBA6zM1lFE
	 tETQAPtaL4XZwBT0PpiC0MMpWv+xk/G4AGFmdiqCeGwzx3lQnKhPMdDAytI02FWk9R
	 4DxgYdLH1Ex2NbhiLxf9wm0+lcTrNJQAJV9y/Mrb8HLLN9nBa8xMLh3m3SAAWxr/6g
	 5uE1h+tBD1Sh/As6mN5GjIL4Lc092Uh8lCHnj2Z0MIYafx6z0I8ftWG01Ht/O+Udde
	 ZOqGb5cFI2itAzU8zLXOKwiDbSNv5Lg7ui1m7zDkd3Jwd1IAECSCo3n1bAkFI/qvIg
	 QuiOJeuqf9cDPiwzJlbqxPsCAfzXM6M+zeRNAgHdRsZ2KI5RUDx
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d044:75ae:17c6:f240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 387E7200BE;
	Tue,  2 Sep 2025 16:39:31 +0000 (UTC)
Date: Tue, 2 Sep 2025 16:39:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 01/15] doc: add a policy for using Rust
Message-ID: <aLcdwiRpD1Yo7SKy@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>,
	git@vger.kernel.org
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
 <aLIG5bLOisbxfn1y@fruit.crustytoothpaste.net>
 <CAH=ZcbBJV0oT1Ht6qVKmq7xG8ki9Enutq+VNes4n9+2r+0nrvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bF+YByBBcwdy6RoK"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbBJV0oT1Ht6qVKmq7xG8ki9Enutq+VNes4n9+2r+0nrvA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--bF+YByBBcwdy6RoK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-29 at 20:11:46, Ezekiel Newren wrote:
> Could you create a patch with your preferred wording about bindgen and
> cbindgen for me? I'd prefer to introduce bindgen/cbindgen in a
> different patch series because this one is already doing a lot just to
> make Rust exist in Git.

I think it's fine to introduce it in a different series.  I'll plan to
do that myself if it doesn't get done sooner.

My change to the text is the following:

Tools like bindgen and cbindgen create C-styled unsafe Rust code rather than
idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.
However, we may use bindgen and cbindgen to share existing Git types as an
interim step.

You can find the patch at https://github.com/bk2204/git.git in the
`rust-policy` branch.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--bF+YByBBcwdy6RoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLcdwgAKCRB8DEliiIei
gYZXAP91KTzBnpkWA8SeY30XCFcRGGXBcEFV5/2ci2xP3SbLewD8DHOI7qIeq78F
7M3/8W7W/2dG85xBcncGxtu389J3gQE=
=M7TH
-----END PGP SIGNATURE-----

--bF+YByBBcwdy6RoK--
