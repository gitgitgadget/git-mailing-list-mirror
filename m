Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A719F471
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532325; cv=none; b=NrxJ7c+xwCX50Wl+JSP5Q4tgjxEq7aGUbDyWADht7H0/AU6+d3tdq6hCUjKj9COwd1hbr7EbWjkkqUxV83FuVs6LrN9SoO8eThDAnEXFKBcpE0F7yULOiUo7mp+OAT+nlBW9H5JOZsM3jsPtASX+bnvEEVblvHhjFKMmkIABF54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532325; c=relaxed/simple;
	bh=zC0tlY9ek2F7R1YEprVAZW0LjARlEW6C3BFSt5pndkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXZJOOmibeiVKRgimjDInbKU5CSlU0vHBdLP1sG/EwORzX3eghKcpWODKy5Gxtjq0FBiAEH3z0qdb/tV0fs+67n2tNe6AiMVw5PemsjXKFwU3z7AVDiLNOoWp70hUKPApIY6fN4lLWKNAUYm1+4YuN17ZrDly6HazGwEbSwE1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TJuLIgzj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TJuLIgzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1745532319;
	bh=zC0tlY9ek2F7R1YEprVAZW0LjARlEW6C3BFSt5pndkw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TJuLIgzjJb9GzjDxCgKQBddwfqpVHEYJV6SL6ExUJjNqMOxuqEXXlkW+biRiDAKOs
	 AmFx9qzBEvYcwUXIWH5ITkrkkCh4mqqdj99jnFEfE6UOUmUx8ak2z2/+siLBYKqjoT
	 SP3cNWTVInSOrhZIxIsqiON8gkN/OFY6ZQqEB3wBnHru0oFU4Ody/LeWJPOccm4Atg
	 kjDLyE9V/2VBEHrSX1aWlzmcK7Z5Hn/q0sihlASlXF1jHtTvvxc01VHQeDbAkNMCjw
	 tlMNQKYV50sO9aVX5IGOGici+nyDyE1kIlSZaUxHOQZIZL6RCyRP4+MSA9rSy4Yqxy
	 xK8kKabVb6Pi2lTUOPhFp9YMPw/jtEBtkibjHIOeDpUY8Z489F0b+zMRB5wsJ1bf07
	 wufr/L+lcbYdzwuSx7mKjSda1fOEu4lLhoB4rnHSagRXaLjjuKfZYCNfjvRS2mEcpJ
	 BTORoKHFfQH4Nd7dNYZfdI43MSA9Jrt9q+Hb3ij351ldjudnvOJ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B394E20107;
	Thu, 24 Apr 2025 22:05:19 +0000 (UTC)
Date: Thu, 24 Apr 2025 22:05:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm
 name
Message-ID: <aAq1nvcPRlIPal5l@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
References: <20250424203904.909777-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2tL17YFLqnWvZOaG"
Content-Disposition: inline
In-Reply-To: <20250424203904.909777-1-christian.couder@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--2tL17YFLqnWvZOaG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-24 at 20:39:04, Christian Couder wrote:
>  Here <alg> specifies which hashing algorithm is used for this
> -signature, either `sha1` or `sha256`.
> +signature. Current valid values are:
> +
> +* "openpgp" for SHA-1 OpenPGP signatures,
> +
> +* "sha256" for SHA-256 OpenPGP signatures,
> +
> +* "x509" for X.509 (GPGSM) signatures,
> +
> +* "ssh", for SSH signatures,
> +
> +* "unknown" for signatures that can't be identified (a warning is
> +  emitted).

I don't think this is a good set of options.  We can have SHA-1 or
SHA-256 options for any of the three.  If I create a SHA-256 commit and
sign it with SSH, then it couldn't be exported with this type.

It is even possible and valid to create a signature over the SHA-1
content of an object and sign it with one protocol, say, OpenPGP, and
then create a signature over the SHA-256 content of the object and sign
it with a different one, such as SSH.  Git does not natively support
this, but it is possible to do by hand.

These should be separate fields: one for the hash algorithm and one for
the protocol.  Alternatively, we can just keep the hash algorithm field
and parse the protocol by reading the first line, which will differ for
different protocols.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--2tL17YFLqnWvZOaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgKtZ4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ91eUcJ6OuI7qtfo8MP/umunh0BmfJD2oyumg7WERykv
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAE1MAQDJJJEkvLrTBP9BjUJtjM8x0rhg
V6F4lmXLbQEpcKs95AD/eaPe18jDbAW0nR+BHC+bgizGN5zq0spZ3Uw5IOyrEwE=
=pLCg
-----END PGP SIGNATURE-----

--2tL17YFLqnWvZOaG--
