Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9B2837A
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814828; cv=none; b=TC8n9KlaMh0x0/4NtmaJ1AuJymupmHB//8o1d9s5TT/d+/NpGvTDM2wyy6/tt/MuuKQhfin8AtlUfXVa+2qm71OSlsF/UiYgSDbUSAAY95tgQMzvOl4qFBZ/Mmq8dZdRt8pnmI3NqPNRhurRPTOI4nChIODpSO4Gqtn1kkDbsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814828; c=relaxed/simple;
	bh=JuYOhQxMDmf3jq48vikfh5Guvv3t3GQJ1KNVbQT0HXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTSf7fhN9PVnufjcaDzKgk3tXwqUMrXyQpdX7wAeCkXYiXUPLik5wolAvd8osspqugB0fXMvUY126uEGRqFtUPsf36+CO5GuG6f2+vTs0ldaiIgeZsS/YUglTcDwjLsKgUBfx64dbU34Poz8G3GbBftEyh9zizhvBv7IZo2eG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FcGSYGur; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FcGSYGur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732814825;
	bh=JuYOhQxMDmf3jq48vikfh5Guvv3t3GQJ1KNVbQT0HXU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FcGSYGurilbFtSsT2wT9MsUph0HdbZqnuw6sgs5MDo91Homf3RHv2D8AV8LMJ1STh
	 78Oja+Fnnx0MzUahX72edIv89qRKQ7vMw3YkSqZtiW1nZ36Bgt9QKmNUl8MonV1ATL
	 rmekj1OS0oS54VS+PuB5mk93xfbN7t4ljZ7iCtHLeNpa/1g4S0y0F6bvodhiTcPV1E
	 m+MxgeD991jzErJ7QpRVipJhB2KJoZtVOoQpYxmReEPQi1lxJVNw/kzURcWc7/MPDg
	 Xn5Pb1lK3F7I4RxzMkAiTufVMCFL+WyWxEeh46TAkRmnT1dEyeGONGlLGnphIGQNiR
	 w5KJ8euW8wXsSK0PhVNNj0zxenqRkKz0NqhxXSF+K2OD7SNmpNfdNQjaCJ4nuX6Two
	 DVX4BrAzqRcKjHcMTXjfRhLfZa9y+9esgLxmS6g3e8CSbCFLuzd+eJD0qawT1lfjlc
	 3vyPqsJWQ1WQtUsmjmRrhdia5gylGdwehFRTwOCUPi+UNiv13RT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2600:1700:f991:38c0::39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3141020994;
	Thu, 28 Nov 2024 17:27:05 +0000 (UTC)
Date: Thu, 28 Nov 2024 17:27:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/1] Restore the ability to clone repositories owned by
 another user
Message-ID: <Z0in54Kk-5eBN_Uh@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
References: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
 <xmqqed2yzc5z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="szk1cOPywfwnrZDS"
Content-Disposition: inline
In-Reply-To: <xmqqed2yzc5z.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--szk1cOPywfwnrZDS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-26 at 07:28:40, Junio C Hamano wrote:
> The breakage this fixes was originally meant as an extra "security"
> thing that turned out to have a larger blast radius than originally
> intended.  I was hoping that many many folks thank us for reversing
> the course, but unfortunately we didn't hear much about this topic.
>=20
> Unless there are strong objections, I'll mark the topic for 'next'
> soonish.

I think that will be fine, thanks.  I expect that a bunch of people who
experienced problems won't notice until this is in a released version,
so we'll probably hear from them after the fact.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--szk1cOPywfwnrZDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ0in5wAKCRB8DEliiIei
gSh8APwLrhGz7r7UPekxfJnWRWogEsdxpusvAjF+YQpJsDTzywD9Hpk9jjP7b+6T
GsFDv/PgfC8EZktz//OXfukgQ5swNwE=
=3uhA
-----END PGP SIGNATURE-----

--szk1cOPywfwnrZDS--
