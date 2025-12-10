Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B223505E
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765332357; cv=none; b=c/gc7HBFe97JserN/GOpbdHgY0OJh2U0bcDAvK4YebfAMaN/VXok/wULkquryYR1+Ysvu/K+2FMNPrMSfMCNU5NTc+Pd/5P6tv9biQH522ZeDEjTMwBaGtzJ8YsQ9P/GtXuAxO16BbXqf5hXrMnVHvM+FCWstl6Gh2oj/Uhemjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765332357; c=relaxed/simple;
	bh=DeXCo2qF3GRMt+p+/oYE44ogjAMWwrDW66aKs2NsC8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlYfMoWmZt2sMqFvFn0dxffhQREuw2riN0rwlZJnGH9xE3GAu6m75+nwtL1UI2KRRZjQuuJlT6hMsPgpfmy5QzafMAvNJ3rJC4T/ShYCixS2ALAinlTPad9Afm/Y2nWD+uYLNTLlO9uWFXqXVJsNi0k8BpDEZ/HFR4I8c6Dg2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ed/8gZEX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ed/8gZEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1765332348;
	bh=DeXCo2qF3GRMt+p+/oYE44ogjAMWwrDW66aKs2NsC8Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ed/8gZEXMqTBbb8FSPWGoolVu30z5j/Yu0zZdw8FKr+wUn/8wp49VszgMRRHnb2+f
	 gqQuyFOiy5u+6Qgw4780A+5VqXJPJV2XQ4N/mtPD/sZPjlZBdCHyWT8wTdIPg2vuN1
	 o6A8cLZS5yjL95Um/uA/BGYddiKWDWGlz+L/ODhwPFqLzxHHmHbGd1j9uPOzOP1m+7
	 LLvHtF79G/nXaH2HLjLsudQqnAISTBS5ZVMgnRXkApxF16L95PlBeobtWrjJuCyBLL
	 vjCK+kDwxF8LcX8Wg+YN1DtBXYD4ntp6IFso1xeV9qEOFpSD3XR/lMrDJZkDQM9wKx
	 8u8NoMUwMvxwIFNtc2KHngoxJLDYVmwEfKE3JlVaQCv2imdTO2HPMZcW34jZ31leXS
	 jN4OhAsC/+HXD9ff2OF5lHnQkNiAPN7laDYZjA9dR7KxsdUBwdKw+ndMLNSXRafR9R
	 05zBW07XHIDxmr6uWVGfLxQVwITDq42ioILckI8cihODhcLjWka
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:a9ed:1b83:88ab:ade3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 158B5200C2;
	Wed, 10 Dec 2025 02:05:48 +0000 (UTC)
Date: Wed, 10 Dec 2025 02:05:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] http.c: prompt for username on 403
Message-ID: <aTjVenutFBprwrrz@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ashlesh Gawande <git@ashlesh.me>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me>
 <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
 <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
 <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net>
 <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvWIptiq9mpJaCMb"
Content-Disposition: inline
In-Reply-To: <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me>
User-Agent: Mutt/2.2.13 (2024-03-09)


--kvWIptiq9mpJaCMb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-09 at 08:22:49, Ashlesh Gawande wrote:
> I was working on separating the tests and thought about the original
> proposal a bit more.
> To stop the credentials from being erased on 403 could something like the
> following be acceptable?
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (results->http_code =3D=3D 401 || res=
ults->http_code =3D=3D 403) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((http_auth.us=
ername && http_auth.password) ||\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ht=
tp_auth.authtype && http_auth.credential)) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0// Do not override existing credentials on 403
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (results->http_code =3D=3D 403) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return HTTP_ERROR;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (http_auth.multistage) {
>=20
> So then we would prompt on 403 only if credentials are not configured.

Can you tell me what file you see this in?  I don't actually see any
place in the code that has "http_code =3D=3D 403" in the latest version of
the main branch.

I wonder if your issue may already be fixed in a newer version than you
have.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--kvWIptiq9mpJaCMb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaTjVegAKCRB8DEliiIei
gcDMAQCCWY5vQhAijEITqZJoo0y2AsN7SSuLtvMRW6iaBEDUVgD7B6T6sB8EKRw6
EWk2FYSVZie2WMpugpdulL7mzuP/wQg=
=WrGp
-----END PGP SIGNATURE-----

--kvWIptiq9mpJaCMb--
