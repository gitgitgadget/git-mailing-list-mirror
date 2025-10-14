Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF91EA84
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482183; cv=none; b=t8PubLGjWxv3t+xRDo5DSIKV96qRueR8NEdX4COsm/aJObtlzws+5c9rgAUx9QsC1tPwXA5PUcEyGMtrqGYvMSdRbrP2RAc3HErM6RQfK5chcZFNnAjWjHUQXm4L6Lnsf8Sb9DT1UbyzDH8553VILtEjOLIKu06Ar7Wwv365UDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482183; c=relaxed/simple;
	bh=uAoamOuE0y3WK5PZjAfrbT0Cj5SIgyUCo9a4rZ2bfiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt0WJ/CyTKl1xj/wCAE7O1OEbFKNhxndmLxa9TQdRPa5YPVuZRed9Md7sKbpjjdN5YxSGLUqxFP5qwN3JFDMTclGVyPLjle9Be39stur26cYfZc1mAVgW8mi93iWsdagPJxQq3CRHP4BEeSWRe5h5lQkFR7S40pXRgRj9Gxfug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FuNmtph9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FuNmtph9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760482179;
	bh=uAoamOuE0y3WK5PZjAfrbT0Cj5SIgyUCo9a4rZ2bfiE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FuNmtph9oz1187CJHMloVVm3bi6tAWXFNoSMS18eFMV1GJuL5FVPPy4BWXlNnm6ZD
	 0AmnL64uqsijlSxGBxaKQ3qzELmE896QKhT06LdHayI3YWJKYNiGPnN1mG1djpshW3
	 pky1eXeJS0hzeypyqkK84kV7LNJleDCluzc3mN+UJuqPq2oO5p9E1y6CK8Q+86bXb/
	 rDPq6CMr1iva+mmrV559euxEM1v5ZBzxf40Zu0xYWHtZrUcoxwORfK5UsGjmCkN86O
	 AvTn+pPHmP5q/iC/ZW5wNM3KDBaiOPsXOr0BSGzNHHMcHx2xFvx0GfUtpBpQvT12bR
	 Tfz9JiOSYlnHPoQ4SJF/KjB1It3Eh35DEbpOSUa089DoFDxSnoWuf6zkAMFo93idCV
	 DEEc852IdqrUOliE5LmwhXSVJ565qhH8n5c+ETjzWk7xH9I6I4LYNNfLyqt9klYh4h
	 CRbEWzUefP/lG/E4220mXE02PkTxpxFdUSiR5iXygaU2O5G3Aff
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:dfcf:298c:5ecb:a3c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 81A8D200BA;
	Tue, 14 Oct 2025 22:49:39 +0000 (UTC)
Date: Tue, 14 Oct 2025 22:49:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1
 usage for patch IDs
Message-ID: <aO7Tgj4OJVLhFASW@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
 <aO6-LBqhW87GWD-5@fruit.crustytoothpaste.net>
 <xmqqjz0xw20h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lHsMNb6imFWO/jzq"
Content-Disposition: inline
In-Reply-To: <xmqqjz0xw20h.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lHsMNb6imFWO/jzq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-14 at 22:29:34, Junio C Hamano wrote:
> I do not quite agree with that, as SHA-1 in patch-id is merely used
> as "a hash function with good distribution that we happened to have
> handy access to" without any security requirement.  Being able to
> compare patch IDs computed long ago stored somewhere with patch ID
> on a patch that claims to be freshly written and find them the same
> to say "you know, somebody wrote exactly the same patch 7 years ago"
> would be valuable, and we do not want to lose it even when you
> happen to store your payload in a SHA-256 repository.

I think that's too late, though.  We already use SHA-256 in a SHA-256
repository, so people already expect that to work now and in the future.
The time to make this decision would have been in 2020 with Git 2.29,
but we now have people who will be using SHA-256 patch IDs and we need
to support them.

We have also specifically discussed in the past people eventually
wanting to compile Git without SHA-1 support at some point in the future
for regulatory or compliance reasons, so we should full well expect that
to happen and we'll need to be agile about the algorithm.  SHA-1 will
definitely disappear from at least some distributions of Git in the
future.

Given that context, I think allowing the specification of an algorithm
would allow people to say, "Yes, I am in a SHA-256 repository, but I
want SHA-1," or vice versa, which would work with your use case better.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--lHsMNb6imFWO/jzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaO7TgQAKCRB8DEliiIei
gdzcAPwNCvdxAcKXFKF8cnJV1mpUWG/go0EgosuqFCqY/5pqHAEAnDrDQg0B9viQ
KheAhNQvj9sKUDwacH3dkgShLu96Jgc=
=gROF
-----END PGP SIGNATURE-----

--lHsMNb6imFWO/jzq--
