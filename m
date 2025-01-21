Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F4A41
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417909; cv=none; b=JmwQ9rSsL2sRNAN5ba6IkScj7TR784YRCjLUAtKbhdxbsH3zCRptxXPsPccGkA2FYuZeCJvtbWGr9CONq+UUqueUlXwICCCXPaZpiiOe1brZj0NEmEc3we4FlpqQdoW4+IeFXsW/Ba0nn53mgY6ElTp8Ar7TOo/kdiX+G370fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417909; c=relaxed/simple;
	bh=mHfsfB9h2fB+8Nn9tkRuGPVXBK8zmOAH3baEVcZsvJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbJR9vJd0qYtAYOPfx/3HoNJMibSy65eyf3S+EMnNtah7g16pN4gNRpolvOL//6I+vN/QvVUNOXCGG6WOASHsY5TYcMYO/Lti4+jdBcPj83HALLMShncNnOz9Akd+9NklDXzJd6QynAnZVR0oLm9Gps2tY7I+GHIGhzadda3N6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sYVEq1ZQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sYVEq1ZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737417905;
	bh=mHfsfB9h2fB+8Nn9tkRuGPVXBK8zmOAH3baEVcZsvJ0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sYVEq1ZQ2OigbQbjO7B1gnu/N83601haQEFjQbToDXWBZ4uRvnP3neiVuWoAPHTbS
	 nxlyb1RSt88FZQ9yYlMrmzf+V9FSTUkBWq87xNVOeU05GJVCwa2RD/44YcRwLjJDms
	 w0g/l+no5PBzkICs40sTYAnKHM57X8I8Zg5EGfiv53IWUt6pV/ycDXgP2zsDZ/7t3r
	 scPM9CggowOm5ahtHw+jLHrvC5rroSPeHcxkGOUz3OxH5MSa9rfq65KOFK/wWfp9aR
	 8m9X5mBZDT2BJ9pb5uhq8SRwX6+FFsBk7B33DEPNfsOHjnTh6VL7vgYmJ6wKaxGdb+
	 ES25OacN9ArAyDhj/fS1AeuqTm9WP0WsKR878liG8Vs3jNwCtOMZbxAHDObl8V+3MF
	 TBPepAwG/Pa5yFo3X9v+qlXv5nC6fq9VP/NAr4QIo+pbQxIlGgABDvqmQslxZWCDh7
	 7+i7c0nkGZUY2iYBPAWFpLYeWF/Ii9V+UZix2IkU9I1G+BZKkDN
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1557A20033;
	Tue, 21 Jan 2025 00:05:05 +0000 (UTC)
Date: Tue, 21 Jan 2025 00:05:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com,
	emrass@google.com, gitster@pobox.com, mh@glandium.org, ps@pks.im,
	sunshine@sunshineco.com, phillip.wood123@gmail.com,
	allred.sean@gmail.com
Subject: Re: [PATCH v6 0/5] Introduce libgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <Z47kr0_fYYdaMWyA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, nasamuffin@google.com, emrass@google.com,
	gitster@pobox.com, mh@glandium.org, ps@pks.im,
	sunshine@sunshineco.com, phillip.wood123@gmail.com,
	allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1736971328.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9lO1h3uXbp9RqR4y"
Content-Disposition: inline
In-Reply-To: <cover.1736971328.git.steadmon@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--9lO1h3uXbp9RqR4y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-15 at 20:05:39, Josh Steadmon wrote:
> Apologies for the long delay on V6; I am finally back after several
> months of $DAYJOB firefighting, holidays, and sick leave. I should have
> time to devote to this series again, but given the lack of feedback on
> V5 I am hopeful that this will be the final iteration of this series.
>=20
> This series provides two small Rust wrapper libraries around parts of
> Git: "libgit-sys", which exposes a few functions from libgit.a, and
> "libgit", which provides a more Rust-friendly interface to some of those
> functions. In addition to included unit tests, at $DAYJOB we have tested
> building JJ[1] with our library and used it to replace some of the
> libgit2-rs uses.
>=20
> [1] https://github.com/martinvonz/jj
>=20
> There is known NEEDSWORK, but I feel that they can be addressed in
> follow-up changes, rather than in this series. If you feel otherwise,
> please let me know:
>=20
> * Investigate alternative methods of managing symbol visibility &
>   renaming.
>=20
> * Figure out symbol versioning

It looks like we're building a general Rust lib crate and a static
library here, so symbol versioning isn't an issue.  I expect in the
future we may want to provide a shared library, in which case we will
indeed want to do that, but I agree that can wait until later.

In any event, I overall think this series is a nice improvement, and I
am very enthusiastic about it.  (This is mostly for the benefit of
Junio, since I think the authors of this series already know that.)
Once it lands, I do plan to build on it somewhat.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--9lO1h3uXbp9RqR4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ47krwAKCRB8DEliiIei
gbWcAQDHEfkIwFXh04QfjtDCEH5JMi4t6M/oJ39A2afndsit+wEAkv7/ufYdxPIC
Swz22vRxHe+/IHuQzcwCBvgRVuzN/ws=
=gZ21
-----END PGP SIGNATURE-----

--9lO1h3uXbp9RqR4y--
