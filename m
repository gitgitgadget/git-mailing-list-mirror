Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666D3A1C9
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784366; cv=none; b=sGmBUy5DrzouTKl7JoirutxVY7L7H/8UVubI8a/zh5CtRgYssz95PLNPtedUO2+AEc5TnnwIpdmcxDgwOXuB02VGeFITDbey9B1aCPo0a0JVrkg6p3xOW3fpE4dh8I69divibpIz8cRCESN0UxzX73l/6SS3w4gjFZvRun2tA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784366; c=relaxed/simple;
	bh=RhPocg5PLunoCP8EqJE4hZoHUMMkVvEHz7NpWfnB9No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwVOGkSPv+KJmamCObZUBzlEMrii90QGUMDYgreMN711BtZMq/kVyfP9VJsVC+qJRMPqoFmVlWmQWlmXvIOsHqzMJvnMtniPN20tQ8mb7p6OYnTuQ3H4zA4JwSB58DCPKpjSykubkbYhkl5r2so8JxGn7rF4bBQ6FYyPLAHqiRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cITS8C9w; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cITS8C9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761784363;
	bh=RhPocg5PLunoCP8EqJE4hZoHUMMkVvEHz7NpWfnB9No=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cITS8C9wgSDeaUhBDF9Fg3vdOUtqijMtNlNrJ8pRBliIY1IO+PFetHr+Y6Pmj0D1S
	 DZ8kHqqtDy4b1Y9MY7U8j03dn8R5GSeg6E27RJ0PEdXhRx1doJqh0+konhlyqw0fQa
	 1o2BENSjKJnuflRg7gOnbssyQdALz2WayYMS3CERz5MxST/vQcOm2JsIKobnVjA+Wh
	 yasrKN9HhSeoKiEqVtiaAdPtcwhiIaE3UwvrEB1qH8uHY/Qp0LVqqWsS5gCRXPitMy
	 3jLWLOTNKjMhfB1E4pndaZMNF6UrugN2ZfEZwgDxfiZcAN7ElWptqVpfFtKMMkaEZy
	 Z5PHA6odkg6uvWPX2JBna7cP/NvP7s30Redd/iV6dFivshr6UHLVcnVTlKrBlluOit
	 s8gENyStLoFIZEDnXneTFP8S5CEkHloW2g8dZo6tsP7O3NeLpBrr2VED85PTiAYGwb
	 zUbrdhDkaExNgDU3c767x3kJNkojriaafM3yvjn72dt706C7BCh
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8caa:b0a3:2e22:c46c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2D02620036;
	Thu, 30 Oct 2025 00:32:43 +0000 (UTC)
Date: Thu, 30 Oct 2025 00:32:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
Message-ID: <aQKyKU12229se0tU@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-5-sandals@crustytoothpaste.net>
 <aQCKD--ZmKnwBWs9@pks.im>
 <aQFhpAinB6HLC-Tw@fruit.crustytoothpaste.net>
 <aQHZda5I0JPSRwv1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9uBCPYa1rbRtQ4zC"
Content-Disposition: inline
In-Reply-To: <aQHZda5I0JPSRwv1@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--9uBCPYa1rbRtQ4zC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-29 at 09:08:05, Patrick Steinhardt wrote:
> I'm mostly asking all of these questions because this is our first Rust
> code in Git that is a bit more involved. So it's likely that this code
> will set precedent for how future code will look like, and ideally I'd
> like us to have code that is idiomatic Rust code.

In general, I'd like that, too, and that's a fair question.

> With the FFI code it's of course going to be a mixed bag, as we are
> somewhat bound by the C interfaces. But in the best case I'd imagine
> that we have low-level FFI primitives that bridge the gap between C and
> Rust, and then we build a higher-level interface on top of that which
> allows us to use it in an idiomatic fashion.

The reason I've made the decision to minimize conversions here is
because the object ID lookups are in a hot path in `index-pack` and
various protocol code.  If we clone the Linux repository (in SHA-1) and
want to convert it to SHA-256 as part of that clone, we may need to
convert every object and then deltify it to write the SHA-256 pack.
This is never going to really scream in terms of performance as you
might imagine, but it can be better or worse and I've tried to make it
a little better.

Similarly, if we have 500,000 refs on the remote[0], each of those
have/want pairs has to be potentially converted and we want people to
feel positively about our performance.

I will send a patch in a future series that will make this a little more
idiomatic on the Rust side as well.

> I guess all of this will require a lot of iteration anyway as we gain
> more familiarity with Rust in our codebase. And things don't have to be
> perfect on the first try *shrug*

Yeah, we'll come up with some standards and design guidance as things go
along.

[0] Some major users of Git do have this order of number of refs.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--9uBCPYa1rbRtQ4zC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQKyKQAKCRB8DEliiIei
gWWdAQCmgRQnkk/OOGJ3aa/+bkk8Lj+2n+OOW0QWZN35Y5RVWgEAuwOIU3wWjFNL
0xDtPvKye3MrtyxP0JLqsE40sQDeRwM=
=vMIU
-----END PGP SIGNATURE-----

--9uBCPYa1rbRtQ4zC--
