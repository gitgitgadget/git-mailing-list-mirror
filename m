Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE92F4301
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685355; cv=none; b=Ozvq9QTILId3+D31M6w5akHuz6uLhc4O7uHCRTd2ssjJVwM5MHRb0Oaiz8pS83Yk5BmhJaLrzvmYjyr6Zuy55TdIHTRDeO9t+DNHU1fA7vUR19L2oEvPdg88Y+tR73aeNTd24c25iToKPtLajzgySthS2ooZkaFVHmVE5aEBy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685355; c=relaxed/simple;
	bh=/+2HYpRGplQOS5JQbOWfjGCIKgSvrpIYAgyZyrS5OVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqU/KvZQF0LskqZtoOIK0GRKBK+IIMIsfsxxhhJ1MHN6x3R1kMN5FWO+wdd3lmrPF3M5bE+UWDLXV78+heSYc2DH7BahZbDru7lQHCz2LB2aNhu4m+zbE9uqRyVohyefx9WB+91TiFzo4zkaOxyfjxTZJfNsRrKLUqOAXYIKqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T5suoo5H; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T5suoo5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749684918;
	bh=/+2HYpRGplQOS5JQbOWfjGCIKgSvrpIYAgyZyrS5OVE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T5suoo5HZXVBmMfzMJjhjWoiUEQEfNoCwJOGF5JFCvBU2SIx8gdXtDT50rP7kg+N+
	 FP9WkBnkb2zbyW84t+Cx3hWB+h+wS4ibsjRWSPDabM2LmTV/dmaczKUUqthhEYFb+f
	 +c8hzvQUKRQ1MTB+7RYK2itmHiIQOX3m0XqU1oS5doH4idaO1W5UJgfsxJUqXGAgbb
	 3uVe7/NvEQMKQguHA8y6SUTJkGu1YhSsNygSF9/zmZaIlmedgSVxqgfTHqx5LH3/8E
	 4YxSSxj7tFfLJ9TcFly+ZdWLMggtqF+PizLoUZiGl4JjmSLfluOcilFdcA1eZeuCO9
	 xe9hd9vrpvt5ziOnydTBGOqnxuxnOMHayEGvsR07IJILFdxeoPkZ5u1+owyOFdu5Ve
	 z3Wu6atnaD3N7Cd4KbVosF7m3Hn0gqTmf1bFEVI9pjLkta99zXCeFNZcg7XQZYNsb5
	 QeBMzFYuliBJetXF6Kj/xGbhZBvtYv0SjHNutxyGZx4CQQm6143
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B73E52008A;
	Wed, 11 Jun 2025 23:35:18 +0000 (UTC)
Date: Wed, 11 Jun 2025 23:35:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v7 3/4] builtin/stash: provide a way to export stashes to
 a ref
Message-ID: <aEoStanN-es2CyDr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250522185524.18398-2-sandals@crustytoothpaste.net>
 <20250601223225.464076-1-sandals@crustytoothpaste.net>
 <20250601223225.464076-4-sandals@crustytoothpaste.net>
 <8498845e-3580-4f37-b60a-8f32c5d41f15@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="87etOPrMYIwf2j0M"
Content-Disposition: inline
In-Reply-To: <8498845e-3580-4f37-b60a-8f32c5d41f15@app.fastmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--87etOPrMYIwf2j0M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-11 at 11:31:19, Kristoffer Haugsbakk wrote:
> I only bring up this minor point since I read that there will be a next
> version anyway.

I was just about to send it out, so I'm glad I saw this before doing so.

> On Mon, Jun 2, 2025, at 00:32, brian m. carlson wrote:
> > +--print::
> > +	This option is only valid for `export`.
> > ++
> > +Create the chain of commits representing the exported stashes without
> > +storing it anywhere in the ref namespace and print the object ID to
> > +standard output.  This is designed for scripts.
> > +
> > +--to-ref::
> > +	This option is only valid for `export`.
> > ++
>=20
> The existing options say =E2=80=9Cfor [the] `<cmd>` command=E2=80=9D.  So=
 that=E2=80=99s a minor
> deviation from the convention.

I can change that here.  I'll use "for the `<cmd>` command`" because I
think it reads better with the article than without, even though that's
a little less consistent.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--87etOPrMYIwf2j0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaEoSoQAKCRB8DEliiIei
gV9TAQCFo1dYPEYSCuex6c4mw1HzxkOQES0OTeaXzt+ZBM5tJgD+Km7NbrIY45vo
h1KnY8HM+j2hH7KXTihRToGZ6UWzfA8=
=GyS8
-----END PGP SIGNATURE-----

--87etOPrMYIwf2j0M--
