Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9F1C27
	for <git@vger.kernel.org>; Wed,  8 May 2024 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128331; cv=none; b=BH655HKHaoYA0xMg5vcGHwLbISybjBvfogCFAcvIQETiGYbSbT8bCEH5LAD2XmkglHecxjWPrf2BGzQK610D2B2JKHGP3lRWUWuxZ+9MpNsB3WhiG2LchaD5hxEfBmweIQ7OrRDd4CgQRDZXPXgoBXbTe9HNLHC+eGbRB4qdkjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128331; c=relaxed/simple;
	bh=wzRKpkUd6waeG5dV0ScrwPMscpUk4UBMW2joMrmEED0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNxJ8MK9IMgMAPdN1QrGKpm3IoxwecQOeMF/e9YzKhLsOTIT1pU0agvXkVktN0m4qMBtX6EFD/foTsCftm9Btr8oJyBjsmZwhZnF2YnV0lC8u9MsbnCmYPVc+Lh3yFU9O+tjluq4jfYj4XDF3x0JjEaZiJoKoVeuTeF66Sao3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pz46hmhs; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pz46hmhs"
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EFAF85DA74;
	Wed,  8 May 2024 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715128322;
	bh=wzRKpkUd6waeG5dV0ScrwPMscpUk4UBMW2joMrmEED0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pz46hmhs3zsEQLhteBfPeeL2fnzUApeZe0V2/bGUAQzPk+ec1mx47zHFILEoX7CeF
	 gDKznjuRJIS2Kv5g/Xnd/bLsGhoMdhQJPVNZzYPLyF4wx7ylaZoxsRwe2iqP2g37RP
	 z2QWZ0fzvdKo8uHw/1kYT26UMfMeQfv6D1HZHfed3kuyQk/lHXguiZqWi4toRD3xO1
	 AvmNMmcUoFuCVP/WPwpfTulUMZnzhMwY2no4wTDwvGZA3qEnjX06n14sE4NA3YW6s8
	 /6oX/a5+LMFKT5RKxujeSQx3f3DrPJjxM1q7PJtNsEcL8kBIexPgQNsIiELPH1qNHL
	 fzgeXKPT1A2+N8cQe9gRfUFHKR4J5UBNUz37A5MrMvdMctZJ9+TBCJzGbu49oJcfxK
	 m4RrfGjFA6kfNvPpRxgxvK3U+dY4LOc6beQt+9FsJxO3HeRzGNfYwSp7KnqUvK3lhz
	 rylsh68UppnzyqWPZyCjhiJHNLvAPPQy2addLi5NsBmH13sjr8k
Date: Wed, 8 May 2024 00:32:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: tboegi@web.de, git@vger.kernel.org, takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v1 2/2] strbuf_getcwd() needs precompse_strbuf_if_needed()
Message-ID: <ZjrIAEq54EVS6yXR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	git@vger.kernel.org, takimoto-j@kba.biglobe.ne.jp
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240507084431.19797-1-tboegi@web.de>
 <xmqqv83po6o2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IQU1j1Eaw0jkeCJa"
Content-Disposition: inline
In-Reply-To: <xmqqv83po6o2.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--IQU1j1Eaw0jkeCJa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-07 at 17:47:41, Junio C Hamano wrote:
> tboegi@web.de writes:
>=20
> > From: Torsten B=C3=B6gershausen <tboegi@web.de>
> >
> > When running under macOs a call to strbuf_getcwd() may return
>=20
> You spelled it as "macOS" in [1/2].  The hits from
>=20
>     $ git grep -i 'mac *os' \*.[ch]
>=20
> tell me that we seem to say "macOS", "MacOS X", "Mac OSX" and "Mac
> OS X" pretty much interchangeably.  We may want to eventually
> consolidate them to whatever the official name Apple uses, but in
> the meantime let's make sure we do not add even more.

I believe the current preferred form is "macOS".  That's what I see on
Apple's website, and that's consistent with my understanding as well.

It was previously "Mac OS X", which is why we probably have that in our
code base, but it's my understanding Apple has moved away from that.

Wikipedia's opening sentence states, "macOS, originally Mac OS X,
previously shortened as OS X, is an operating system developed and
marketed by Apple since 2001," so I think Wikipedia agrees, too.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--IQU1j1Eaw0jkeCJa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZjrH/wAKCRB8DEliiIei
gUWeAPwJT300hqAMK8RaP55xGcozgaYe3mqeGhb0tl4qY06QEQEAuQkML8TiLLkJ
Nh5zT9ucsyjqenxWnHj1I7rN1e41EAo=
=bgd5
-----END PGP SIGNATURE-----

--IQU1j1Eaw0jkeCJa--
