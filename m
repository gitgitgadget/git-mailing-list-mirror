Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A441DAC90
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805303; cv=none; b=KqOWsEYFg7OAfmKtJChvpg8qb8unZehmHEP5X4sb2wYx/mfz6go2WCqwqkxVRzc4GVmPBBe1mZyNO7MMvuukSjN+DLE+MRoU8zgxIbmv9ikJG7Zs8N9hNq22HCZTfAXxa0O9cLNhjiyLbox2Xuj8K/7uJIQgleAHUZXkI7dHULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805303; c=relaxed/simple;
	bh=EluFn5lunVwccnHvcrIafrCOa18UTzhKBl3f7lEf4QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY4UcYvG2lSUhOhwdRmuHc+9RThjN3jz02dmE7YSU88+ZFFeqls2N9dW3HeCX1F+Fs9cEhMFcrVx80ZT3ctbVYFlULQdd7zleCCHRopUaOgRRPFSWuX5PrNdMMcFizTOFYpIZJAXpxfEEXUEHu/gyruEjVt/k62WxTIoQHn6hFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FPrawyA9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FPrawyA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736805299;
	bh=EluFn5lunVwccnHvcrIafrCOa18UTzhKBl3f7lEf4QY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FPrawyA9AN/M9DWd2nvB2vOinCJH2wGJt5OQ+CxF3nTpHWXHu8eaUIq0BK7dDGNlm
	 BOuvKyj3ZQn7UUXOdnw4QFMZ2MHzdI3J++K1353JpGDseTriFYY//d1x2yTTD6m51B
	 1unb2A+2uhgdTWkM4BYjiHB9X7dR/0+GLGgvqdqWye0fbI8pwOR9iTNljkkK/fmyLI
	 fHSk4amFiQcGupU3V6StWKc37xYmAPlAaVSDHvV0WMAMvyW7ZLQmY/+4Dvg0J0gY4G
	 G20fRBdsS4PKQIigvbZX4RcS/OC1AKzolLFaAb0Vwf7wZaDc5imu4PlQqgeyvkbO0j
	 QnK6O49UewxLopXM/wTZao3RO873lBJoVDOghL4qrEno2UAuS9gVVRZhMGXA9XbThS
	 HdranyZapQtNKZ1t5X+NhIwOkdvWml/iPMLXUip6oT2OH3aqSIMihfwvZe+EWGpRZX
	 3n+hEDwqV0oQUpZeP9kELN1m00lhOxpsj70SLAESvGpHHEeVHIz
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5F51320008;
	Mon, 13 Jan 2025 21:54:59 +0000 (UTC)
Date: Mon, 13 Jan 2025 21:54:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	stolee@gmail.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
	peff@peff.net
Subject: Re: Changing transfer.credentialsInUrl to default to "warn"
Message-ID: <Z4WLsmq4rPEMnUXK@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	stolee@gmail.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
	peff@peff.net
References: <20250111071500.710169-1-mirth.hickford@gmail.com>
 <xmqq1px6br7p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MWCKGtbIZOkfFtiu"
Content-Disposition: inline
In-Reply-To: <xmqq1px6br7p.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--MWCKGtbIZOkfFtiu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-13 at 16:42:34, Junio C Hamano wrote:
> M Hickford <mirth.hickford@gmail.com> writes:
>=20
> > In order to nudge users towards more secure practices (namely,
> > using a credential helper), would anyone else be in favour of
> > changing transfer.credentialsInUrl to default to "warn"?
>=20
> I personally do not have a problem with the proposal, but it is
> curious that it is documented as inspecting only .URL and .pushURL
> is not checked.  So, in addition to "once we start warning by
> default, we'd need an advice message to tell the users how to turn
> it off" Derrick says in the commit log message, we would probably
> want to see if we should/can cover .pushURL and need necessary updates
> before it happens.

I agree.

It's not clear to me from the documentation if this only warns if
there's a password in the URL or also if there's just a username.  (To
me, the word "credentials" doesn't seem to explain that very well.)  The
former I think is fine, the latter is not.  Looking at the code, it
appears it is the former, so that's good.

Perhaps we should also clarify the documentation so that users can make
an educated decision.  I'll send a patch.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--MWCKGtbIZOkfFtiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4WLsQAKCRB8DEliiIei
gT+NAQDQutN6gsREta1SI/XlFqmzV72RG0nygZbs8kuJouxW0QD/YtxKHQ5x/U/k
peDCDzKoaXGqIEZGm7g9zWKmoS6cHQM=
=z8cI
-----END PGP SIGNATURE-----

--MWCKGtbIZOkfFtiu--
