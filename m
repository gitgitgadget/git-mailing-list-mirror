Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144726ACB
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731859417; cv=none; b=SeaM0Difnef+CDg4qoPZsfLP2M1hQQ1L+XK7wJnp8a5JCZS451zzU7cTbuWQVlMBZMSvBYSPrIQh/HZP2l1daVunxKXkPlw4665G9QO8Ffp5CU+pn2I0nFow4iDuG9Vuukv2zhWYdkKGmauJUOtmFbmXsK4VCVGZ+msi4cZPF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731859417; c=relaxed/simple;
	bh=8gtAJPiYPDPnxFPtgtgB3t/43zpwrolhLECYVJqjXjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbj+lfEym5/+pOWPJ1x8X0SA9u3pnAIGSL6oF5w9rp5FDHqaeHU06EAegTtT5L5fr3XaJ4JCQvLzMUW8cUPpF9abZQLeyx8gwJlhT85n47AKC377PX3YJta3IUgGjc2avv+bqFCLVEA8RanZPLV/WhhyHDyOVtkokbmJICqph/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fXAAJbgd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fXAAJbgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731859413;
	bh=8gtAJPiYPDPnxFPtgtgB3t/43zpwrolhLECYVJqjXjs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fXAAJbgdk5ZakM+ZL1Hk5qrrYbd42SWjeXoxZQcvZPB2togStspt2kSvX2XZrUKP7
	 hyABOy7tH9u4kfCObegE3P7jJ1QQYjdHaHSOltrgoh3kzUbh5O7ik5MckpreYBahRM
	 P/zE4TrV+27rdI+2GokfhKoHFEk4scf6JE3qR85m5mPlcrUsrF1U12IyvYofLM4Zoj
	 MxZYSgpgBmzI/uzcaYNMnQFOh9qqv5gA8joae6BK5H+6JzizjUBcMX4dXF0k1SW6ZX
	 m4MyXUkmzpYoCr3uqu+XWpbv7sgen08HlTJ3YDmAYPVdWeZdX0Quhy+cnDWqWX8Ylp
	 xXpfqPIjlGTrZLYplnLpzDADVY5rnx4iOx1K5ULj2FP1Eebf8bnlSaHyq9MCuyQ2nf
	 0wobFh8jjWOZXqZwvGiwMpfGiRjquAZIMQUogGzp1ePYGwoYYnq8wxDcpLA8BLBgJZ
	 x8MgoFmRx2aJBsOboSm4vW0vU/bdZ8pwI55WkiwAuisIi20r8ps
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 61C772443F;
	Sun, 17 Nov 2024 16:03:33 +0000 (UTC)
Date: Sun, 17 Nov 2024 16:03:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Sam James <sam@gentoo.org>, git@vger.kernel.org
Subject: Re: -Wunterminated-string-initialization warning with GCC 15 in
 object-file.c
Message-ID: <ZzoT03rsx7MTqSFl@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Sam James <sam@gentoo.org>,
	git@vger.kernel.org
References: <87wmh2o9og.fsf@gentoo.org>
 <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2xoeVGhLEUz2tHC"
Content-Disposition: inline
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--p2xoeVGhLEUz2tHC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-17 at 09:03:29, Jeff King wrote:
> Here are some patches. The first one should fix the warning (but I don't
> have gcc-15 handy to test!). Please let me know if it works for you (and
> thank you for reporting).

Just so you know, since I believe you also use Debian unstable, you can
install the gcc-snapshot package (which is, admittedly, rather large)
and use `CC=3D/usr/lib/gcc-snapshot/bin/gcc`.

> The others are cleanups and future-proofing I found in the same area.
> Not strictly required, but IMHO worth doing.
>=20
> +cc brian since I think this is a continuation of some hash-algo
> cleanups he did earlier, plus he piped up in the other gcc-15 thread. ;)

Other than the issue that Ren=C3=A9 noticed, this seems reasonable to me.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--p2xoeVGhLEUz2tHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZzoT0wAKCRB8DEliiIei
gXxwAQDyJNrRC2jSHbyDuyoPh/ckvftyk2ynVpnWBZnMI3aW7gD+PYrxQFXDPSqC
QCsOWgdRqLtAVLpq+AzHUPI83JlVEQA=
=ljxN
-----END PGP SIGNATURE-----

--p2xoeVGhLEUz2tHC--
