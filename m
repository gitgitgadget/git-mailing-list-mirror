Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF221E8338
	for <git@vger.kernel.org>; Mon, 19 May 2025 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684542; cv=none; b=VLb71tWmOAi+kL77oFbGJ27oVQu3PXBZQ5sEBFWD+cO2C0whX6O9JasJmAv+MsHE16fVpIw8O6lNs3VTh30IoEB932nJ72rWsOmICmU9EvfIoCrDYKRML4XaZUWIs+FIAElEeBe4Ic39IkRQRX947HfpGt0TB7DXg9upWxN2D/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684542; c=relaxed/simple;
	bh=0ImfOoQhI2rO7ZVHwNVnamiXFoliOgYiJDxNNxPEjSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIJf0BKFqgd99/M4G65M34EL2/JcAbbN4qWZQGXWcEi8Os0qDZ2jnIcKH2RfNtKI5HnnjC308KxB/ORc+DgAq9a1Ms08vZAyhyijxDRFbSrGfG725U8XZAM3LK+Y78s3W+kTgrgQV8naUKo3LMAfD3D4eNuszYOMcvG/mk/7hZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hXkTHcNH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hXkTHcNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747684531;
	bh=0ImfOoQhI2rO7ZVHwNVnamiXFoliOgYiJDxNNxPEjSI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hXkTHcNHQ4zAP7640knzlLxZq1ueglZsHnXk2Yc9sXoL98yjdtgcKNvRHwuYKGWSy
	 8+GOaWYAkIvxUDfHQtEI/gHqpody87N8FqtukvHyhlZVl8DmOVrEQDH9O6sUrw6O8w
	 Ss0Ir/c5vjzQMdUHj1hoVrB8FNtTxYFUKNkuQCXmQnYBvH/xZaYQoUTufcoSbqGtVz
	 BfRaLYhqCNV3haOdj/d2NJnuZinJoES67B23eSnBaus1iMJID/ysw2ryle+euD9sok
	 hecL7LKf9qQhvz1dtQRrAYGhLk350lEcEn1CJn0FLEcM8vbm6i8sd5YHD4f7yV2fFg
	 FNIoKVhnuYVf1SzwAfSp1Nx0EEr5qtk6u/M8brmcilAirap1Znmjmhlc+9ukH7gpsI
	 Gps1IXIwk3F+IoOOZzMaE3JOpx/KO0HAScvI3IQ8ksuXbezUOXG54vZn8DG4idA4Wv
	 SaJbQuBH83GezXxy3xvPi4aFBNU/LhmPwWv7aV/WzPiSJno+H5Q
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8C9AE2010F;
	Mon, 19 May 2025 19:55:31 +0000 (UTC)
Date: Mon, 19 May 2025 19:55:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Bleecher Snyder <josharian@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: make reset --hard add something to the reflog
Message-ID: <aCuMshOaqcuwMCpG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Bleecher Snyder <josharian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAFAcib_PV4EB-i4PUmTxCx_6LX=8aWDNT_ZPrN0-EDsRwRfi4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lYOlSGV+5h3ud2TQ"
Content-Disposition: inline
In-Reply-To: <CAFAcib_PV4EB-i4PUmTxCx_6LX=8aWDNT_ZPrN0-EDsRwRfi4g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--lYOlSGV+5h3ud2TQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-19 at 19:45:21, Josh Bleecher Snyder wrote:
> Hi!
>=20
> A feature request:
>=20
> I git reset --hard a lot. Every once in a while, it hurts, just
> infrequently enough that I forget the pain and do it again.
>=20
> I wish that git reset --hard would silently stash, add to reflog,
> stash drop (or the moral equivalent) and then do the reset. That way I
> could always recover my state post-facto.

I don't know if we want this by default (although I could be convinced
that we do), but I think this would actually be a great feature to add
via a config option.  You are not the only person who has accidentally
destroyed data with `git reset --hard` by any stretch of the
imagination[0] and this would make that much less painful.

I'm not going to commit to implementing it (although I might do so at
some point), but if someone else (or you) wants to do so, I'm sure it
would be quite welcome.

[0] I've been contributing to Git for at least seven years and I still
occasionally lose data (temporarily or permanently) this way.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--lYOlSGV+5h3ud2TQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgrjLEJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1Ht80g5VWsBst/bCyl0KMFfYAyQ1D+MUY8BLZC0NNUI
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJB/AQD9lmmPANzoYdtQi7tw1ooBmmok
zh5qYcN/xfn3nQo08wD/XlVAmnT9L2d3c3UBKH09idxTyhdb4IJuL1IoQRTkvQM=
=y4D2
-----END PGP SIGNATURE-----

--lYOlSGV+5h3ud2TQ--
