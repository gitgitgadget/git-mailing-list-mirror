Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6E32B9B5
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076658; cv=none; b=nhn+XAcbzYCO1fTgn+pvI/fTPq7cGsV7kWVo5Qej85vkeBiBfSdzzBvObMbP6+2N1hHkp7ZggQVNeQmli9TQoIgfu1pfujWisq6I7eYklluq+UFXEIXBHgCSOcXYy6sEhLHnjaU0dLjO5bVWwo8ELCV0lYPM+SQciK8jJqVdlcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076658; c=relaxed/simple;
	bh=NQ5Bv3Ikc/D/mgg3dign3rbztxKxerSWsv2DR9W3z/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSG+u0C1vT/LA0TOSDstZ1zh7HxEAL9LWZFDsdq0nJF59D0Z+WUJxYx0mG1jgEO0loI2JXtU3nbXjpMA31EKCSRVuYgvxRAclhPOFtXz9Jt5nLOsncAuyqtX1SMED7KPm5Q9/pkIdZxV2j9x/s+i/Q3PgEe45g/hi+FxAjts9ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GSLg+cz2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GSLg+cz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763076655;
	bh=NQ5Bv3Ikc/D/mgg3dign3rbztxKxerSWsv2DR9W3z/Q=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GSLg+cz2vS4KiJTP0oT3g2lIhhrQEIEBXBrMjD8TTlj1gsHHyC1IYzD5kE+IYb3Ew
	 h9NCwiiMmSTe3LXu5mfV7YgD15pNh//8rRceAVI4ppUspNesv2kHheGmBKl/yLdIeg
	 n3PqgeUop0xE7dvbjd8+wkAcKvcVf4ubyp3IkIAF77OZAQsx6O8aXgxRl3ikSXgIXx
	 WDpSBRFLeqenmQUc0wycsdymFoyWrwGf0uY4kAv1oNBKhHYXezSxHVY+O55GhRqiiw
	 Cf0RTPRwjbgOau9xsQjyqsfBjYO8R7EBkAXcoTdPT4Odq8WerBB+BML33VQDHCGepC
	 tKhiwK93a7H4GagfEgyqn3OiFzPwG+1/hggGnapkAPYRx7JfktAL/u4QYRp0UlvkqT
	 s5NItLp4ZlV6YXBrv3bEm2LXydrlr7JaZBr6GDsoOe66sdNWC8IqwaPmrtWIT0kgiq
	 jR25hISrrgEpzGAZH8HggDWuyM/I2V8Tb2dTNkKPgdAq1uFLGhc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:663d:867d:4eb4:3b8a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7ED6220065;
	Thu, 13 Nov 2025 23:30:55 +0000 (UTC)
Date: Thu, 13 Nov 2025 23:30:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] Revert "osxkeychain: state to skip unnecessary store
 operations"
Message-ID: <aRZqLp__WdA4hbuD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
References: <pull.1998.git.1762930881599.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tz8LvVKg1VqToCdJ"
Content-Disposition: inline
In-Reply-To: <pull.1998.git.1762930881599.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Tz8LvVKg1VqToCdJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-12 at 07:01:21, Koji Nakamaru via GitGitGadget wrote:
> From: Koji Nakamaru <koji.nakamaru@gree.net>
>=20
> This reverts commit e1ab45b2dab51f94db9548666dfd7af626d2aa7e.
>=20
> That commit was trying to skip to store a credential returned by
> "git-credential-osxkeychain get" by setting
> "state[]=3Dosxkeychain:seen=3D1". However, this state[] is kept even if a
> credential returned by "git-credential-osxkeychain get" is invalid and
> another subsequent helper's "get" returns a valid credential. Another
> subsequent helper (such as [1]) may expect git-credential-osxkeychain to
> store the valid credential so that "store" cannot be skipped by just
> checking "state[]=3Dosxkeychain:seen=3D1".

I believe the intended approach here is that if we do a get and the
credential is invalid, we return the same state[] header to erase, but
we should not send it to subsequent gets for a new credential.  However,
we do need to send it to subsequent gets (which will not have an
intervening erase) if this is a multistage request because otherwise
multistage requests will not be able to keep state, which NTLM and
Kerberos require.  Does that make sense?

My guess is that the problem here is that we reuse the credential
structure without resetting it somewhere in the HTTP code rather than a
problem in this particular helper.  That is probably my fault, but in my
defence I would not say that the structure of the HTTP code is very easy
to follow.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Tz8LvVKg1VqToCdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRZqLQAKCRB8DEliiIei
gamdAP9rCsEFFZZLTZGSEoiI8WKlLDSxG6u4bQgaTQaZ7MM16AEA+gLMW0ugIkT8
OJykgJ77Br97KJcW3IEjbVO5QXcRowU=
=msC8
-----END PGP SIGNATURE-----

--Tz8LvVKg1VqToCdJ--
