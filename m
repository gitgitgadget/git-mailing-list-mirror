Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FAF4F1
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254504; cv=none; b=LCa7WL1e3y9Eb+q/Zosgi1K7POl1yU7cotdJEEjrGRPt6HnHH04UuQeTWZNac8E6XekyyI4H2YngS8Iym8xrocb1s4hL5ZjOu3B81Fmn6oILcDg+PDUmajHcZDQHjYDM9f1hE+JloP1izXbSyoDP0iUZmkpwq/vxyneY1Ve3fOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254504; c=relaxed/simple;
	bh=esXbwColg2d1lOYiyiOp0470HVtwi74veWuMhgh6iyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8pmYE6fj7E0L6a+WPne4r4uIuE3nQt6dCQNZiVTdeyPuTM13fHEyEh4XhFsOE75St0jKE0CqUIpqGdSx0lUs3m4C7NkAFRgtRwFy1NlIaJt/UL7Qz7yI+s9GGjNTWWnMr/WiA7HipShJ/EnFM17Ct6WkaDp1snYyiucMRWPf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zt8PnZvW; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zt8PnZvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756254500;
	bh=esXbwColg2d1lOYiyiOp0470HVtwi74veWuMhgh6iyo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zt8PnZvWpUxIKjz//NTbAgwqOO47P2WI2xA9hGU86sbnhiWwrgWw8Ltd8ivBFPNX2
	 DQIh2mmiWoTfUix7t/QRQLMunVjnVXQUZE081U4fmbyTOVEpTGLfkOnNw5WQghaHdM
	 l9bP0fWaF+SjFDihw8yEkeBl4wCDMoPzBH7ufSY9sUtncfLB1/XR8JcdGYZd0gii7S
	 th2Ix07pPCgTLRTWx7RvuwpGLmXwHbR8mEiNe/7K00Gh10q7LyO4S8KCoqrviHwjOo
	 Q420oNdJh8IuCXVPKBV5qzNzgH2C4AbDo1MtXO/DXKVPy7F0X6gkdTV/qLPVNpx0nY
	 jOBPGL3zsemPxAl+guG9l+Uo6jYFGgirOAbmyF0utipzbujrzpHmBEw2BFTM02Qw3+
	 +EeIpvw0HZoQif+ugb5E2UrBHdmiU7kxuJikdmsh2YhuMNkSNaRZWaM4bYK3QsdHB3
	 OpKe/PNWBzmhizRdmPLwIQB4Qd2G8YBPDkD9si1KIoQ6b2lXz6l
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6208:a4d:7e2:3785])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 589FD200C3;
	Wed, 27 Aug 2025 00:28:20 +0000 (UTC)
Date: Wed, 27 Aug 2025 00:28:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>
Subject: Re: [PATCH v4] send-email: add --get-smtp-server option to fetch
 SMTP settings
Message-ID: <aK5RInMzjC6vuLv_@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>
References: <20250822151039.36006-1-gargaditya08@live.com>
 <20250826133936.1569-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g1gI40Vj3Ugo6gA3"
Content-Disposition: inline
In-Reply-To: <20250826133936.1569-1-gargaditya08@live.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--g1gI40Vj3Ugo6gA3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-26 at 13:39:38, Aditya Garg wrote:
> Autoconfiguring SMTP server settings is a common feature present in many
> email clients. In order to get the correct SMTP server settings easily,
> this commit adds a `--get-smtp-server` option to `git send-email`. This
> option attempts to fetch the SMTP server settings for a given email addre=
ss
> via the following steps:
>=20
> 1. It first attempts to fetch the autoconfig file from the email
>    provider's autoconfig URL, which is typically in the format
>    `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[emai=
l]`
>    or `https://[domain]/.well-known/autoconfig/mail/config-v1.1.xml`
>=20
> 2. If that fails, it tries to fetch the settings from Mozilla's ISPDB at
>    `https://autoconfig.thunderbird.net/v1.1/[domain]`.

I'm sorry I didn't ask this sooner, but it just occurred to me.  Do we
have permission from Mozilla to embed this service into Git?

The reason I ask is that sometimes software vendors embed external
services in a way that causes excessive or unreasonable load.  For
instance, some router manufacturers hard-coded certain NTP servers into
their firmware in a way that polled too frequently and then effectively
DDoSed those servers, all without asking permission first.

If we embed this into Git, then it will be present on systems for a long
time.  Some Linux distros are going up to 12 or more years for software
lifetimes, so we should assume anything we embed here is going to be
present on OSes for at least that long and will be used at least
millions of times a day in a highly automated way.  Even if this only
lasts one release, it will likely be on a nontrivial number of machines
for at least 12, if not more, years.  (Not everyone actually upgrades
when their OS goes EOL, unfortunately.)

Is Mozilla comfortable with providing that service for that amount of
time and having every Git installation on the planet potentially use it
at top speed[0]?  If we haven't verified that, then we should probably
not include this service in the code.

> +sub fetch_config {
> +	require HTTP::Tiny;
> +	my ($url) =3D @_;
> +	my $http =3D HTTP::Tiny->new(timeout =3D> 10);

This needs to set `verify_SSL =3D> 1` explicitly, or we'll have a security
vulnerability due to not verifying the certificate.  Our minimum
supported Perl version is 5.26, which shipped with HTTP::Tiny 0.070.
Versions before 0.083 defaulted to not verifying certificates, so we
still need to set it explicitly.

[0] Even if we don't think users will use this that way, with the number
of Git users, there will be a nontrivial amount of users who do.  Many
of them will not realize they may be causing a problem, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--g1gI40Vj3Ugo6gA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaK5RIgAKCRB8DEliiIei
gbNZAP0eus83XKtXqTr+EGHd0bA1paikLj3u0vSn98qM/oJKeQEAydVSm4y1jhuK
qFQQ+IW7Yi0XUmPoQlIY6jyMNOeljg8=
=nHH3
-----END PGP SIGNATURE-----

--g1gI40Vj3Ugo6gA3--
