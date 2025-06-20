Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FD30E82F
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750447089; cv=none; b=FW0w3jIUsYQM8ttcKpcI3stkPqWu2deiB3Hy20BwI6hewJ7qTXnYpyOvhcF4qxKu7/7fKkdlbu13njTc6SjoiQozh0A39nTa5Mio/lypA9rIsmZZwqNW0qjEmrsJX/yRsOUNYB6MM3edZwyK/4ddkavjloREqz+mfcyiZcjPITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750447089; c=relaxed/simple;
	bh=OZeGG/+praEdn2EUTou3LtguZH+oRNylHzgY8iboyKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1sKRfmTtawUrWpJYkbs0JSNsy+aQ3wb2Y/u5kp52xViQnytMVRXfJ91Sv/dlHCMWvJABdcW0j4IBoJatJcWEiuCq2YeuOYbmruCyomY9iI24K7OxplipB6oS1NHW8JO5wM9iSTHVKTe9VNixoHtZYrS3BPasxJBmstlAryJ7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lgdNmJUq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lgdNmJUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750447086;
	bh=OZeGG/+praEdn2EUTou3LtguZH+oRNylHzgY8iboyKs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lgdNmJUqGWJWs3MUkUAICkOdElzq7wIGNxPkI5elVXcTDKuCMNoX1ilkdAajOxuTJ
	 UxXeJSbcpR9/hrofwCxyEEuoF/gz3Mxm6ZwE/R0c3/fZkiOq0TFk3RIFIYV8P9GNuO
	 ub2ZM93s4RRs0oTPGYECc89Ft43ubr9UeMZAaHf5CqP3ksTaaCvU5bNiHrsSU/NZVM
	 ji+Wq4GyGDcLtnmYdQT7HIxC802XpaBHinLhKDF30sJDz+zEDKANVfSb+H8Q+Asq75
	 GNcA95optbY409VxEPdq0L98oy5+VMFETDTVFPfCnjHGNNXkBAour3Uu/TtLEToLj5
	 VoNmL/XCwB3Ehy2MENTr9XdT47CWC2idJYuQ5mJVwVvBIviOAWmLQ+QUlZYLvtoWS6
	 rCsbpU8ElbuEyjbjLcKBpvlwSUQtMODGszb7Lxiff4ydeHQNTX4i7QJfPxp26teM7g
	 B+wn9tx5/ZKeNCXG0KsQWWjesDntZfzq12/ZUiAccxRUsQZfmb1
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4E97E20069;
	Fri, 20 Jun 2025 19:18:06 +0000 (UTC)
Date: Fri, 20 Jun 2025 19:18:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
Message-ID: <aFWz7UGQUAIC7h0v@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-11-sandals@crustytoothpaste.net>
 <xmqqmsa25ukg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M8b7IW+qa94XV21e"
Content-Disposition: inline
In-Reply-To: <xmqqmsa25ukg.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--M8b7IW+qa94XV21e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-20 at 14:58:07, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  hash.h        | 6 ++++++
> >  t/test-lib.sh | 7 ++++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/hash.h b/hash.h
> > index 0e14cade4e..144b53b7d6 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -174,8 +174,14 @@ static inline void git_SHA256_Clone(git_SHA256_CTX=
 *dst, const git_SHA256_CTX *s
> >  #define GIT_HASH_SHA256 2
> >  /* Number of algorithms supported (including unknown). */
> >  #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
> > +
> >  /* Default hash algorithm if unspecified. */
> > +#ifdef WITH_BREAKING_CHANGES
> > +#define GIT_HASH_DEFAULT GIT_HASH_SHA256
> > +#else
> >  #define GIT_HASH_DEFAULT GIT_HASH_SHA1
> > +#endif
>=20
> I think we decided to format the above this way.
>=20
>     #ifdef WITH_BREAKING_CHANGES
>     # define GIT_HASH_DEFAULT GIT_HASH_SHA256
>     #else
>     # define GIT_HASH_DEFAULT GIT_HASH_SHA1
>     #endif

Great, I'll put this in a v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--M8b7IW+qa94XV21e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFWz7QAKCRB8DEliiIei
gZPVAQDfEBO4Lbr2JHHgs92W2ebnm8dgDzc8N70k5OmG6WEVXwEAy6I8x5uDkNkn
cl7OZJREcCZ0S2QMWA986CW104G6UAA=
=If1v
-----END PGP SIGNATURE-----

--M8b7IW+qa94XV21e--
