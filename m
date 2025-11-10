Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18723257845
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797727; cv=none; b=Vwv1LPqA8GykT8HBWu33Mr0hqH7ROofRQNGTqrOrga+kdbxjQZLA79sCYyYc1WEJphnXbnWKXnyOKAqIgwOrU5JLhofmN6H4Wy7Oil+A4PGiS1t2D7oGzjLE/C/LYlb7D5aboyAtFD6Ng91EQjND6lSfxInFWa+LlU1GiJqyIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797727; c=relaxed/simple;
	bh=bkWYYl8FmOojl2d06qQwISgVDsE1fft2h6oRoyHSKIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhTtXa8ODjXuD3VN3+AtbuvC8FuX5iJrlgvOEbKjsm1A52SCT/O+zAqz74XDqiZcFCasm45UTHUx+ypMkghnw4P1iYHexYK+sbBCk5vStaJ9GjzxjaFpQJsqgO0IbWGigZuWnIGWqMi9iLXjL1lnIcMjGjgtA9t4Ilf+JwzTpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TgRGFIYg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TgRGFIYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1762797718;
	bh=bkWYYl8FmOojl2d06qQwISgVDsE1fft2h6oRoyHSKIk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TgRGFIYglGx3GwM/wAw3i9LyLbkm53rVCUBA1Xt+FjCYIMe31AMK7lZDPw+lqsfiV
	 +w3sRSawOpOKAWH8TwFAwamuJMI7RupyzclY00yE82BH54Pk/V0r0DXBz8yp99nT8Q
	 Enddxn1mIp9iV3nOMdfS8JXxMRga0gHBHdUeGATxnN/9K1R2JjHjt4VOQUfcqkMKBa
	 fUsNdpP5bkxbcObEiRYcqeRtYEFRi18EoeHE5heKRPpvJQNxQsmE7b/ieq7S/VXqZk
	 a7bcguq2NDOSEZoyziUOerISV8tLSaTnVP4Bp2Mjqo715ab+y3gM39EPyeMqF4uhAM
	 snHs9tGJFTgmZV+I2h172EyAfAeiDktDbzXvj9abyKd2NDLpt0IwtRAz2mLtG5046k
	 J7aVSmvM7R0EU6eoy3uPn2ObLn1kZu7KOCDgFTGFpy+xomT9eO7aYtFA1eWVL79F8+
	 Y7FqGhz//1JlEs7NYOfarmPKvZSS94i0UqA8bqNQtZnfUs5lHQi
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3de2:5398:b9f2:76d2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8A8C620065;
	Mon, 10 Nov 2025 18:01:58 +0000 (UTC)
Date: Mon, 10 Nov 2025 18:01:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: phillip.wood@dunelm.org.uk
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] commit: add --committer option
Message-ID: <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk,
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AnJ81XhPqQ901aBB"
Content-Disposition: inline
In-Reply-To: <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--AnJ81XhPqQ901aBB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-10 at 16:50:04, Phillip Wood wrote:
> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >=20
> >      This patch introduces the --committer option to git-commit, provid=
ing:
> >       1. Consistency with the existing --author option
> >       2. A more convenient alternative to environment variables
> >       3. Better support for automated workflows and scripts
> >       4. Improved user experience when managing multiple identities
>=20
> What's the use case for the same person committing under different
> identities? We already have a config mechanism to set different identities
> for different repositories but I'm struggling to see why someone would wa=
nt
> to create commits under multiple identities in a single repository. For
> scripts it easy enough to set the relevant environment variables if a tool
> wants to create commits under its own identity.

Someone who works on the same project under both their personal and
corporate identities.  For instance, me working on the Git project.

Some open source projects also require a CLA and you have to use a
particular address to match the one that's listed on the CLA.  For
example, Google requires an address with a Google account, so in the
hypothetical state where I was going to contribute to one of their
projects, I'd need to use a different committer identity with my Gmail
address.

I've also kept business logs in Git when I had a small business and I
might well need to log approving a profit distribution (with my
corporate address) and log accepting a profit distribution (with my
personal address).  Those would need separate digital signatures from my
two different email addresses.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--AnJ81XhPqQ901aBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRIolAAKCRB8DEliiIei
gebyAQCcNTSFW0Kh4keqHXjDwXX8cMDiUJvKrgQqxd8+ujfM1gEAg+zGPjpBtYOy
w+TH4rOXTZnCVoTTmle1kXVaRVqKsws=
=SpNH
-----END PGP SIGNATURE-----

--AnJ81XhPqQ901aBB--
