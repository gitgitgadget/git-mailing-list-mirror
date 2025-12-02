Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0A315772
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676357; cv=none; b=MVr0D5ivL9kzP+VPaT9MG/8zVkOWvxmWD1iXxfF7bI9Di1qnlFjklwldmooq1IUR8/0Ig9l6v8CH8WUWSnUHNJvbvRnEsaJvouDXadCj7Hvnh2l+M2q+P6yocir79QzCV6ULLRYT+zMT9Oz75Gg2/+ltdvl8aJoexqRK6MzXUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676357; c=relaxed/simple;
	bh=7mwXyyB4ttmYZ6zGxbIsswGaUdCWX57MgqwR5ItbkwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvTJSLwwe8meivXzpKJgyUzjHM/fP9q3P1KdB8Qt13gISiTQKRwiFoUvSS2zzaO7T73zIU3vh2NiKOfCXQhaXHbzJPAfpkIb4cxuJQ3VcHnkv0BQCzDKPemPmCRTgAsU5cPFYd2YpCFnB8TXUmwrtDZpAq9AZZYU8WHsepWbDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MFdt24Ug; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MFdt24Ug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764676353;
	bh=7mwXyyB4ttmYZ6zGxbIsswGaUdCWX57MgqwR5ItbkwA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MFdt24Ugdb3cg7hyHIDLEDSra4xYsZPl6xw5jD6KxZSyeqSLQqSfOtXO5pi78rsPN
	 H2yphdofafwATsmJXLj0w0oF/jmtBpR64pd0F/HWxVqp7XP7lwohy+VJWZCgTHzJ/f
	 PjM03+1Kkeevu5PMESemEJLb8DgOR4DrRUZIoacLhQsakwbjEYs115PHIPo00xTnOi
	 ggNYCvDMMCAC2AFvuq63gdrTcCU3gm5Kcp5Y+/ink3+SJ516cY3g5Ah0gDCAX5Ip2c
	 AXn5/F0niZF7zik0nyVcgCbXVtTvToiAWaRsfOukCppemBm4KnNTokiwUxqBhiHN6E
	 VfE9vPkpyOB51xnTmOdLQNMQCizIDI4a9f0xi+zVG8JhnYgMi+VZkFldIOWWTlaUY3
	 BwO3Vz6coLqioEtMmYdKBUWhR8uRO/yvqYztG4LeEfPE6rWSNWtS8CTczWpdEzKPv4
	 hiocnEMuY1n+j151A1e5MQPM2EONx+rPUCGCqI9NBKnU3vl6NK1
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb0a:dd97:4aaa:b0f9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 522232007E;
	Tue,  2 Dec 2025 11:52:33 +0000 (UTC)
Date: Tue, 2 Dec 2025 11:52:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix doc default hash algorithm in
 WITH_BREAKING_CHANGES mode
Message-ID: <aS7S_zSpfk3r7jxh@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <20251202014605.52110-1-sandals@crustytoothpaste.net>
 <aS6g0Zjzd5OEd-mb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RgZ+Vsvsw27nCD9r"
Content-Disposition: inline
In-Reply-To: <aS6g0Zjzd5OEd-mb@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--RgZ+Vsvsw27nCD9r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-02 at 08:18:25, Patrick Steinhardt wrote:
> On Tue, Dec 02, 2025 at 01:46:01AM +0000, brian m. carlson wrote:
> > When WITH_BREAKING_CHANGES is defined, the default hash algorithm is not
> > SHA-1, but SHA-256.  However, our documentation was never updated to
> > reflect this, and as a result, we end up misinforming users.
> >=20
> > This series fixes four places where we indicate a default hash algorithm
> > in our documentation such that they conditionally say that either SHA-1
> > or SHA-256 is the default, based on the the with-breaking-changes
> > attribute.  This both improves accuracy now and also makes it less
> > likely that we'll forget to update these places when we hit Git 3.0.
>=20
> All of these look good to me. One alternative would be to introduce an
> attribute that we can then reference in the docs. The below patch shows
> how to do this with Asciidoc, but of course we'd also have to do this
> for Asciidoctor.
>=20
> I don't mind much which approach we use, but wanted to suggest this as
> an alternative.

I think it may be easier to set this in the Makefile and Meson config,
but I'll try to see if I can adopt a similar approach here and if so,
I'll send a v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--RgZ+Vsvsw27nCD9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaS7S/wAKCRB8DEliiIei
gTdCAP9wTM3Hy+xyS5GGB6V0FCXnNbWHxwSCd1bTYqp68S+fwwD/TLl4CVBoylGD
lEJQLnwN35/3IQgB1jzvTuuiH50vFgA=
=u7h0
-----END PGP SIGNATURE-----

--RgZ+Vsvsw27nCD9r--
