Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CC195B1A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907874; cv=none; b=URXqhZGh1PnPNfkrgoVwXw2x9DoyxFlQ2B2V+MuoNNTOUkJbqhyL9uahrVBypYlkHRIaz2+HMeFJ0xZe5KCOQBxC7yLDkK4Ib75b0Vsf+Yo+Sov/yBkO0dI2XsXrY4VSNtxCZuTzI05o4i8yGEDgOoXsPWOR49Z7G2rmmfOH8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907874; c=relaxed/simple;
	bh=3Gj7nfQY94Y9oVX8uHyYLr/9bcmSVIvlH6tSrNXNx0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcIqF6OzblBplfLbzWs0u6M6tH2CPKz8hkl9t1Ohu/kZwrwn0fsMLC9Ekr2dk0g223rFq+UjdqqTeO5ObMIXx2OXOu0mW49wWdKaehI68y5Kw9MjehgRFeUzvtmD6/MGDeOhHrLZRfvhbNqRNRLu+T2ywjHa3NE/47pYymSf4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wll0iLm1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wll0iLm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727907870;
	bh=3Gj7nfQY94Y9oVX8uHyYLr/9bcmSVIvlH6tSrNXNx0s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wll0iLm1epL2nb3JO/OkoUDCwXa2USHFFxRlhe7nyCOaHF7vcEvHpvvzs9qfsulEN
	 +6JGaRM6sI4PcSM7BdssQiR8NcgJVEB+Q+EivzBm0RyqHNa13nHmpF2yNssBzPvSDo
	 eCe8mRwCvf7uviiwgBWtQBdl4QIzJN6TvYjthrI/NrI5mSuYHHPozgAHCjBZ+H0kbA
	 2s7mjs888IVTSDCtWgLF/Sc6VCUfkh3aZz0kLxF4tK2HX5nOKP1x5ndw462abCTwGU
	 13quG22iBc34mZUk/DphDhwTvGcBdROfveMdVHqudDHkJCRH3WuH5LjkUgHSD0r6RE
	 wapISQKXzWXBCpXnzsLzbh/hi3RS7YIoUcCNpysU9NauIVLPp6ACuQCyecT28eKZ5L
	 Ivbm1Qhg1KfXAvcBAceH72ZN1UB2XTCQdXiVzle9B9ZxWBTXNEBdS0rFao0dYDJelO
	 vWsHK8i5O/impTtKknXAIKCbEXfr/OXxzUJ6ZnbRhMyiVF7krvC
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5E5CB20075;
	Wed,  2 Oct 2024 22:24:30 +0000 (UTC)
Date: Wed, 2 Oct 2024 22:24:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
Message-ID: <Zv3IHd0c4_0NPjOK@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
 <CAPig+cRkA58wr_Pn-uhVM0zFA7B0hnArXDeumrjnWrgBbG64Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JEPah1aYJ5L922Ai"
Content-Disposition: inline
In-Reply-To: <CAPig+cRkA58wr_Pn-uhVM0zFA7B0hnArXDeumrjnWrgBbG64Yw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JEPah1aYJ5L922Ai
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-02 at 22:16:00, Eric Sunshine wrote:
> I'm not sure I understand your response to Phillip's observation.
> Idiomatic error handling in Go:
>=20
>     if oid, err :=3D repo_get_oid(r, "HEAD"); err !=3D nil {
>         return err;
>     }
>=20
> seems much closer to Phillip's more succinct example than to the more
> verbose example using GIT_ERROR_SUCCESS().

I don't think that approach works if you want to use `oid`, since it
scopes just to the `if` statement (and any relevant `else`).  If `oid`
were already defined, then you would need to omit the colon in `:=3D`, or
the compiler would complain about "no new variables".

That's why I usually see this:

  oid, err :=3D repo_get_oid(r, "HEAD")
  if err !=3D nil {
      return err
  }

which is much more like what Phillip's more verbose example shows.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--JEPah1aYJ5L922Ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZv3IHAAKCRB8DEliiIei
ge6qAQD66pSh2NSS+hntGXKOeBdkz6eZgdxBPaXgba856KJPjgEAo4Y5yfDyKaQE
/44z4okH4fq4bd/lNBfDuvz4GqesEgs=
=WoF/
-----END PGP SIGNATURE-----

--JEPah1aYJ5L922Ai--
