Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55ED285404
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698566; cv=none; b=ZjnSw4OgqGExi+H3yfKTxnJodz48ZOpCxa2W92PcmvqLuhc9wVgZ4Xp022QHzLDzYKJBk3hJYXNqkSEMTf04Qul74ukDzJh5gf71a7E1rXNUCcdZ2pKC8KrKOr/To9RTGnTBoaFV9Fzcqh0A7ix4K63iEQmrg+tagJLsfFQPU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698566; c=relaxed/simple;
	bh=HkwXviy/vl676Nmkh8Ymx3FDiGJUb03uYS6+xcQDCzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MycKZx7FnXVHcVUlmTi02GbinWLHc1h/c7/P7ujg9f2DseBqgagIJW5SibFlx279iKDGLa0n2z/TzAqWKoQ9SfYQOqyvt5cQbPF1bq0CZhfv10BtNUdfYMYnS0sUDz8mlXPXcxrCl6QuJktxvbaqR25oQHU+2LytbxzkQ8nYwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=BrVNONEq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BrVNONEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761698563;
	bh=HkwXviy/vl676Nmkh8Ymx3FDiGJUb03uYS6+xcQDCzg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=BrVNONEq74j9+WqOhzchANWh7tSFwzoTESB6pJVjN402qVxOL0BCPfFaj1wal7cQf
	 hrBLkITHGa5yVuXrrZSJTc1tniRjZZhavCL8MK64gBFkIMo2vXQxHsLFFo9qqeOC/I
	 ad2kYCchQe5Afjff0er+uuaoYm4Yi8oZ/azKXFAiwrjeM2nlV46Hnz3K7k1GGFe5XA
	 loXq4+5QWM50DgH6nUFeT+EL5zI6EfAdQucEozzb7l8lu3Pr1NNSFSmTncFbd/ZXPR
	 cy9RGcrwnAikqnmnViUW6J6J4ZMK9yqa//WxLsSj3Yeq0CrxpqtPsd9GY5Z0CoCrHA
	 /oqD2oalfEVnn19wbZiZqV1bhOYH8Nw1i3k9olSasswMdJ6XaCHd7lTa5MPLgxSwJo
	 IhkKxkiNrLoY/TwVLBd27bkop2Fhmwlen9WWGc95ZO6p68A/hvpDugShiGv7Xpg+MF
	 UXwt9QOqO68H3U+wWWF7sgadBxAc1RxBFpTIgm6OKlrx0ojbYwN
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B903220036;
	Wed, 29 Oct 2025 00:42:43 +0000 (UTC)
Date: Wed, 29 Oct 2025 00:42:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
Message-ID: <aQFjAm-aIYvtsEyK@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-5-sandals@crustytoothpaste.net>
 <aQCKD--ZmKnwBWs9@pks.im>
 <CAH=ZcbBnTAWe=2SihD5G63e6T__wWj870u3eRE+rueH51gpqnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9OhH0L/AvCOLP6pO"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbBnTAWe=2SihD5G63e6T__wWj870u3eRE+rueH51gpqnA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--9OhH0L/AvCOLP6pO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 19:07:36, Ezekiel Newren wrote:
> I'm wondering this too even though you gave a reason in your cover
> letter. I'm against putting licenses in each source file, and don't
> see how it's better than having a separate license file.

As I said, the DCO says the "open source license indicated in the file".
I also see lots of open source code being sucked into LLMs these days as
training data and I want the LLM to learn that Git's code is GPLv2, so
when it produces output, it does so with the GPLv2 header in the file.

We already have similar notices in the reftable code, so there's plenty
of precedent for it.

> This would be fine if it was used exclusively in Rust, but since this
> is a type that has to cross the FFI boundary it should be defined as a
> struct in C and Rust. If you run size_of::<ObjectId>() you'll get 33
> (but it could be something else). Without #[repr(C, u8)] the Rust
> compiler is free to choose how to define the discriminant (its length
> and values) to distinguish the 2 types. If you do use #[repr(C, u8)]
> then you have the possible problem of C setting an invalid
> discriminant value which would result in undefined behavior. It also
> doesn't make sense as an FFI type since a Rust enum is closer to a C
> union than a C enum. The point here is that Brian is matching the
> existing C struct with an equivalent Rust struct.

Exactly.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--9OhH0L/AvCOLP6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFjAgAKCRB8DEliiIei
gdH8AQD5cU3gHcEniWsYsEBGO3RdENfA2eVa/2qq+cKyH+aFjQD+KCMht+dM0cCE
0fvu2O2L8DemI8ZK7hZxDOKRxnP60Q8=
=4vG9
-----END PGP SIGNATURE-----

--9OhH0L/AvCOLP6pO--
