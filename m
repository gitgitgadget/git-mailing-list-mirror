Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F319C546
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836939; cv=none; b=dZsg4kgNt4aQIwDhZYOWq8I3W7omRBXSmQ9rJXRcy7LFDNCpPrnS7DLG/TfLH2tL/IPc9rGwjibwMh28oiBRR2uxH8p3HOc/CyrP2+ooiW4Fw+7IRmBxJYO2EoNQZaRYlIFEyHlUd6Wj5A9duFo0Dg+vCdatpjz/fzUtmQIop6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836939; c=relaxed/simple;
	bh=sLpNoLV+AVXP6G4W71qfiUXX8lR08/gGbNrqXxV/Z7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaM8TuXObMgWf5sk2ZIAeY1Rx7EBTrWXNO4j0ULKOCi3kLWRd2dJruKNR6CAaJtsXFux88rIS29eqVVt/gSgZGwlBRB3CMnJEiH6chUMg0SCkIhT8vZ06/rExUjwLNeR4nXFINjnCYoUlWneIB8vfgExMZBttLEFerneD/fx25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=05hjJyTM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="05hjJyTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758836937;
	bh=sLpNoLV+AVXP6G4W71qfiUXX8lR08/gGbNrqXxV/Z7o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=05hjJyTM5pby3u4FtaFB0DciDcTeekemKGwiHs1w+S1ieM9kiUMUIRQtyGuEPFZSd
	 anDcZDZyYdGCHRWwKlIlVtjLi69HkqWSztpr/N5+seyfyx05Nqn8FLGhvRmGJxvsv5
	 bzji4lNyy5GA6dRVXPyYUwLaPbOoT4peJUkZZNcHkub4rEwqUWWD0tx10H/bgSyIY2
	 gCKx87uvSBYaq1a5P9+HbAqwQxoj1c2KALA+818x50wPch5kQJmN3SgwePQ3KfM+2j
	 EjX9SjuFNnkuhepy9WvgwnlqOtbKhqm6zHFegb0+kTKRQPr5Gbotgp3BmI+jwbTdDp
	 eJza5GzUtJ9nb4J1tPP4VlihnpfDDmp8W14i0TCCYZ/v0SyGEfr9+DC0WdS5g1bvq1
	 LbbgEJ+0yVlTTvQjk5msxwpeQVpDwPs6RKtjI4mNnPsQzANf66lSGVgh7BWfP8QFx8
	 S2m8hVMDuRdhztnrNiYl1QqlB2HfMPhPzqDB9heQk7Djw1HAYND
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:916c:9d5f:e4b:808d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 149CC20107;
	Thu, 25 Sep 2025 21:48:57 +0000 (UTC)
Date: Thu, 25 Sep 2025 21:48:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 6/9] rev-parse: allow printing compatibility hash
Message-ID: <aNW4x6Tb1g-YKqzw@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-7-sandals@crustytoothpaste.net>
 <aNOkDEsJIfq0Ufgg@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xZ3amuw0oEwt0XG7"
Content-Disposition: inline
In-Reply-To: <aNOkDEsJIfq0Ufgg@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--xZ3amuw0oEwt0XG7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-24 at 07:55:56, Patrick Steinhardt wrote:
> On Fri, Sep 19, 2025 at 01:09:08AM +0000, brian m. carlson wrote:
> > diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> > index 58a4583088..98c5a772bd 100755
> > --- a/t/t1500-rev-parse.sh
> > +++ b/t/t1500-rev-parse.sh
> > @@ -207,6 +207,40 @@ test_expect_success 'rev-parse --show-object-forma=
t in repo' '
> >  	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
> >  '
> > =20
> > +
> > +test_expect_success RUST 'rev-parse --show-object-format in repo with =
compat mode' '
>=20
> Does this test really depend on the RUST prereq? I cannot see anything
> here that would require it.

I think that should move up into part 2.  Will fix for v2.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xZ3amuw0oEwt0XG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNW4xwAKCRB8DEliiIei
gSxJAQCIv03BR8xuliHPbeOB/mWuOhweBHKCslSj+XgwiSgUpQD/a6RBtzvFw2SE
pxUqUA2egrZiIEj/P/eqdgfQAPwBUwQ=
=Gkx5
-----END PGP SIGNATURE-----

--xZ3amuw0oEwt0XG7--
