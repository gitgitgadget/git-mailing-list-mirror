Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6B237A4F
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373764; cv=none; b=t2mZ5tfY5NddXfpTro0SvBbjaKamIRm3DH+lRc4nu1VlahLXYtLFcOieZkG4OsghuTr8QEc5jJsbV6e6JmIfPZELwD0uqWi9gICvhCI7mzxFaCDcCZ+6kg1751XGA4yO6o+srakdebxCVgvAURmk9+Wu+4OWNnPfRRecmb/QAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373764; c=relaxed/simple;
	bh=3z1POV6wgvUdnN+EwaQK5+8lSLgacEiiJuqEaB7PwJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8wynT+FmGDKTXo5r1rPdiSogdAcatmraE7iVB0fC9qbqUWJlW0dhLcFil5KlMdshSwd0qo0/hScOyBIAnN8YrdnkQobd0TmhXeL+RXbrKbhSfXl1ejvVBTMEycOJYylQIUtlvR1WHUp7IDUTU+FWk0CCKFY8hAt7jlcwz7xpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0WTmZ7Mq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0WTmZ7Mq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760373289;
	bh=3z1POV6wgvUdnN+EwaQK5+8lSLgacEiiJuqEaB7PwJo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0WTmZ7MqiEnhrlnqminCOOPyqzCzjyi5MjMvNHVAW1VCFvIYrmg7VRerAFv7ark8L
	 YxRd0eoQPPrHu40LI5fQKrysE1Dw/m2Elgf0kVHv/CF9Zoopm7KTMzRvZxdu+rdG52
	 pqfaeJvc8ITRE8EuHZVRK+uH2y7Au4DPVYRD1785xZbbLIP51dtqsxk3/HLQl7dKoR
	 cEumrVT4NbecaQ/+6mxY44vuOr1mysCdmOgHSYZWVAz+mI8D9aBsmqH4BCxK68Oiug
	 i6qN91ExdOTLFOCb7N7GNqi+hR9FQJWDjSA8OmCOMSZ9AZySzI4LacsARAT5fwQxlr
	 N8QjJvmmgqvieMRAmcvMmFgXMbHc4fnw+y8/Z+qbjhhbTlvDZy2U6hycNgPB5LZaI3
	 YIkoR8zpRF6s3KDtNViHTaN8rM+1Uvn4s+CaRSM8uZVyBRnSGBR1ARFKZpECUqx+nj
	 S01KmmoCJO/CErJI3rrWID0rXUF2I7Ays6Kt+PggRXrxkV2zVgB
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1ed6:9f5a:5bfe:b572])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1F999200BA;
	Mon, 13 Oct 2025 16:34:49 +0000 (UTC)
Date: Mon, 13 Oct 2025 16:34:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/9] SHA-1/SHA-256 interoperability, part 1
Message-ID: <aO0qJwFQfSXsi7lA@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251009215626.3089287-1-sandals@crustytoothpaste.net>
 <xmqqzf9u3jug.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rK8LfHGyMvF7K9fs"
Content-Disposition: inline
In-Reply-To: <xmqqzf9u3jug.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--rK8LfHGyMvF7K9fs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-13 at 15:24:55, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > brian m. carlson (9):
> >   docs: update pack index v3 format
> >   docs: update offset order for pack index v3
> >   docs: reflect actual double signature for tags
> >   docs: improve ambiguous areas of pack format documentation
> >   docs: add documentation for loose objects
> >   rev-parse: allow printing compatibility hash
> >   fsck: consider gpgsig headers expected in tags
> >   t: allow specifying compatibility hash
> >   t1010: use BROKEN_OBJECTS prerequisite
>=20
> The topic has been quiet ovre the weekend.  Shall I mark it for
> 'next' now?

Yes, I think it's ready.  The only difference between v2 and v3 was your
comment on the text and there were no other comments.

Of course, if Patrick or anyone else would like more time to review, I'm
happy to wait.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--rK8LfHGyMvF7K9fs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaO0qJwAKCRB8DEliiIei
gQ70AP9QfbtdGcir60H1leGkQ1oujBE0BP2aqnh6tGUYZdJo7QD/aQEaNof+8f+D
2D+vKOeFskkWWdbjoUL2mhlh3/mJmAY=
=dXgq
-----END PGP SIGNATURE-----

--rK8LfHGyMvF7K9fs--
