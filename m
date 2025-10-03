Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0D21B1BC
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525588; cv=none; b=YJrJLpuTXOQpUtqATERqnVQgQxnCK26P5tdK2uE2ncuH70TY9LVuTAot4PeW80ZaGIPmdz0tO1vZWgusTQP4E1WqYGs3IylGpk3jtX7586CjiiaOXSkB1XCVbYllEBa4KLd2RcsKAX8eeldC3T1ikyDLgUhGOufeDyLAWjLrqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525588; c=relaxed/simple;
	bh=118U0GfJwxgsUGFsp5OCkB/mVv/bp5C27mgS5NqBhqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyWzL5ghJYnRTtB5O4g6Hye31pI1hXqqe7CkwH7iJF/jdo12Yn+DisriyjYg0eu18jA6bJp8vR1gs/oyfHDciO+jILNuWtPCctx8fb7aMEHO8LymnknXxe1tHWAmt5uJQK5gC3G4zBr8z1Mmbwg+HKXQ2pc3swLTjI3IHeFSJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mBDk//y7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mBDk//y7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759525584;
	bh=118U0GfJwxgsUGFsp5OCkB/mVv/bp5C27mgS5NqBhqk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mBDk//y7AoCQd/bJbEYJCk1rwEbohgBRQnoV7fk3hRL7MMBE/ziIplhZIkxxHGq/N
	 Rs32zTYcWrWeblR12BRkFxZFdi4cRuEblwtKEOVz0NsfjYz3lc7+tQC+SB71roV+Nn
	 AjtZEa8L9mp6aLdi0pXNaLR3XBJ8ludVqYOlyy3vSQLWlPD8/b+ZejzbOb/EqTfNoY
	 kZ1SwfN9rgTKey7MUSXtq2xJGXNDCToy0TtPw4KWhf6PzPsrl/vR5mMZIu8VzenuTu
	 lpmBrZgv3aFpbmkTNZwNrhq2+bt/djQv1/ljeZwinu4BHcEt5duXBJ6WCNpijt4QRf
	 5tQouNg1Ng4T8bCKHKt+SQ1rn4kDNXnRj5I9E/03h/5I15TrAgVr2SuqgSFhJMu7yO
	 TcvYfqSlKNE+p5Ty65tlNJ1s4RhxnkdTfneUCiP5X5OmVqcJJEhbZ59lRb6NJw7vFS
	 +oDzMWusprWB0i5VA1+4a45o4vQMQJVX+OhhzGVu3MyltkSzO5b
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a85:b88c:5160:2148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C0D7720119;
	Fri,  3 Oct 2025 21:06:24 +0000 (UTC)
Date: Fri, 3 Oct 2025 21:06:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/9] docs: improve ambiguous areas of pack format
 documentation
Message-ID: <aOA6z-kFCd78XtxX@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-5-sandals@crustytoothpaste.net>
 <xmqqv7kvud5o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4g61hGM6g2xX7cB3"
Content-Disposition: inline
In-Reply-To: <xmqqv7kvud5o.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4g61hGM6g2xX7cB3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-03 at 17:07:47, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +=3D=3D=3D Object encoding
> > +
> > +Unlike loose objects, packed objects do not have a prefix containing t=
he type,
> > +size, and a NUL byte. These are not necessary because they can be dete=
rmined by
> > +the n-byte type and length that prefixes the data and so they are omit=
ted from
> > +the compressed and deltified data.
> > +
> > +The computation of the object ID still uses this prefix, however.
>=20
> "however" -> "by reconstructing it from the type/length data as
> needed"?
>=20
> Other than that, the new text reads very well.

I've already squashed in a very similar change.  I'll wait to see if
Patrick or anyone else has more comments and then send v3.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4g61hGM6g2xX7cB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOA6zwAKCRB8DEliiIei
gWAzAP0ULR+WVii83QyNgg099sHxQEjBxLmM1yFdq5aJJ3gG6AD/Zbz+VzBlw0uU
O6HBXjDsTOs8VYgk0V7BvQ+cVDvu3Ag=
=HGGK
-----END PGP SIGNATURE-----

--4g61hGM6g2xX7cB3--
