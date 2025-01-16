Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B8242262
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069713; cv=none; b=HAxthS6keeYSguVWziPBVLKJYloPKA82htpNdDdncxAlEqUH+UgX5GBHUXv9aHuzZXHhGCZRQya8uQ2uwEOtHzqo+k2Igl/3iAwDb7BwCIXlbVTGKigx7Mqnseu9tvC6wtgrPdI44gF2MHHPy3AaN7yGtBuH/efzB2AHmuK+T5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069713; c=relaxed/simple;
	bh=5F2dCFptF9iy0KAGIcTUGiTpNH3ozG4nakE4i3O/V8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbpgtufZjYkdtyvabSvbovhCKFFFDg6xAfunAJfuooUOJTfrnkmWOmXr7qvtaBT3ZdDfQrGNhh87few5i//Fm+EVTSRKFh9TYcXKZI8ZKFoEyqr5ytn+2VKaORX8XuoPgtSdunUTvJQuQ+osolllLZaO02Ztnq478lLY6i5FC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fkehM+jr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fkehM+jr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737069708;
	bh=5F2dCFptF9iy0KAGIcTUGiTpNH3ozG4nakE4i3O/V8E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fkehM+jr00ncZdd9CkBLxqim8kfUGA0Yfbp5cGWEIL1XY/P9+MyEyK1uTQWdoTCBg
	 4BIYW1HLfTlFTMxEPRtkvISBm1o4gfAci1+10n4jEAaKAJW/U7s7AKL9B91woyJBRt
	 6hWqv0/QbHeL6NJUAVZyDMg+0YdcLAzDVEkd9KkXhdlSyihE2WvuG2M8hka1xYekQH
	 jI6efHnJgJgnuygXsmAKhapm0CT/PlLHGTRIzTUSeoIUUJLbTLv9dlNq2DAR4EfyCj
	 upu10ozlsZO0EgXSwv+VgMYP7ETfHKoSk36/vXcGIlpmoex9+pZmTnV69mwvfZZJtW
	 Jm9WPXJ5Kx9ldcQflaxRUtC8EQIPOwgbadU2Dz8J0a/20SyqpEZh0MWxdxsq9Wc9R2
	 W61rj3UiqzTpMf/fHhZHJoA8wO5wKb/D10Ojw3AenRbqrbPVaaGesJ4FSN7Ikwp2KG
	 TgXvTr0JJ78DvxlRVl5TN2CVqVCmZokZxwBN4BkyKZe7xbH2M1i
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E525020033;
	Thu, 16 Jan 2025 23:21:48 +0000 (UTC)
Date: Thu, 16 Jan 2025 23:21:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: Bug in 2.48 with `git refs migrate`
Message-ID: <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
 <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymF40QxFCnhayMse"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ymF40QxFCnhayMse
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-15 at 11:54:51, Karthik Nayak wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> I'm attaching a patch below which should fixes the issue for me and also
> adding a test to test against the same. I'd be grateful if you could
> also test the patch against the repositoryies you mention.

I can confirm that the patch did indeed fix the problem.  I was able to
convert both repositories successfully (and very quickly, no less), and
they both work fine (I did normal development activity with them) with
an unmodified Git 2.48 after the migration process.

Thanks again for the quick fix.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ymF40QxFCnhayMse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4mUiwAKCRB8DEliiIei
gUpJAQCmL/ixo+FwTiRnoLWhvdKI6le3qwtkcuPcqDK+9LUAQgEAoh3bV2XXcq7X
Pv4+lYBRNYKzi8BSiJFQRKVVhpltxgc=
=t0wv
-----END PGP SIGNATURE-----

--ymF40QxFCnhayMse--
