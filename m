Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4E30C110
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144114; cv=none; b=Lvcf8h532bK7WLpRkP1FRUbaH6ToY0qFaC+w70dwImB5f0ispHjV6Ja8wx+eZAcJo0JWuvdUkBt/AbbCL7D6/9KFqgbYWtkasXL+4I5SQh+IxQTaMZBTBHM9CK5JLeReKHKmbi4vC7+r+nL9gqk1iNPKBnia06IEmYECIt/KdMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144114; c=relaxed/simple;
	bh=7DeeIT+z5RAr1YNcQr0Mc5jBKXnbl/XSVhcaA1GKSZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuamTQbmbh6ugLTRH1B09pkXTbTir6NRMR6m4m+cBgzZYZ9oJL2xcPDnookLxU5X/BHTzke8httNmvBcEdzkfVBsBKj2VX4jMvQvf/Rfq/sqxlPdvIFNI6Sc+oxIzqNn5whMc8Jk+Nn1By9zlunfwUGDAVazc487cJoFle6quKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=O0dqliQQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O0dqliQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758144110;
	bh=7DeeIT+z5RAr1YNcQr0Mc5jBKXnbl/XSVhcaA1GKSZg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=O0dqliQQINdaKTJhT7pDi5079CPrpIwvzCi7okOoo+s8dJVr5hTwzgb3Qx6nrTIdU
	 ZqAq+OUcNyh1a3UcVk74wwPWv4zxfRWhd7EmGsmWhQKzlVBXrDwhLJ65yuHwuR2f6H
	 m3OmxAy3OQuGBTOotplRedlQgUfTv7+jYDlNfVltKTrDsZSas4WsbHTXX8ovf1GWtt
	 WFUev00BfNhRuYHpTLe2XuIG/UumBJCyL4AUfaQzuGs1qxrQeOC2zzH9m0XGW+GePc
	 qX77VBIpUf+/eoxTxWesFMIpEqeicDedfD7aSr9ijmY+OZoa8R/W+wJTOe/l6TdzVE
	 IPxfrT+Oh3Rz9f+sOHvvEd28L74wkUUeH01pa7+ky5TdckmrWAPPuDq9LXe33/hzFL
	 Ojud1kt3MeQzqOrYzq9NlfCA/GBXMCpom/0N3jSMbeKvVu52fZfKwpBhR7YdgizfL0
	 TZ2vx4k0ZhsOdBELvnwdXakknT4BFvgo8hz/Xct8I5C0ybYlOe4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cc20:46b1:6e9f:44d1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5C20520105;
	Wed, 17 Sep 2025 21:21:50 +0000 (UTC)
Date: Wed, 17 Sep 2025 21:21:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kevin Puetz <PuetzKevinA@johndeere.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Bug] git fetch --dry-run --filter makes changes to .git/config
Message-ID: <aMsmbU_Cg0L6kOlm@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kevin Puetz <PuetzKevinA@johndeere.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="79+tdnicQkodp1ci"
Content-Disposition: inline
In-Reply-To: <CY8PR05MB100119985C7C25A72E530556DB517A@CY8PR05MB10011.namprd05.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--79+tdnicQkodp1ci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-17 at 14:44:00, Kevin Puetz wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
>     `git fetch origin --refetch --dry-run {commit} --depth=3D1 --filter=
=3Dtree:0 --no-auto-gc`
>=20
> What did you expect to happen? (Expected behavior)
>=20
>     I expected it to fetch just the one commit object (no blobs, no trees=
, no history),
>     as a means of checking whether that commit is actually known to the r=
emote.
>=20
> What happened instead? (Actual behavior)
>=20
>     the .git/config file was modified, adding
>=20
>     [remote "origin"]
>         promisor =3D true
>         partialclonefilter =3D tree:0

I will note that if this command actually downloads any data, this is
required.  That's because your repository is incomplete: you want to
download exactly one commit and without marking the promisor remote, you
will lack the ability to acquire trees or blobs and your repository will
then be corrupt.

> What's different between what you expected and what actually happened?
>=20
>     I did not expect any changes to the local clone (due to the use of --=
dry-run)

I agree --dry-run should not change your repository.  However, I would
also say that it should not contact the server, either, so it may not do
what you want.  If that's not what it was intended to do, perhaps
someone can clarify the documentation as to its functionality.

> Anything else you want to add:
>=20
>     Context is https://github.com/conan-io/conan/issues/18949
>=20
>=20
>     trying to avoid a full-re-download in the process of checking
>     whether the HEAD commit hash exists in a remote.
>     The command was expected to either be a no-op success, or fail

I don't think that the command you've provided is a good or efficient
way of doing what you want, but I'm also not sure that there's a good or
efficient way to do what you want using command line Git (you might need
to write a small portion of the protocol, for instance).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--79+tdnicQkodp1ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMsmbAAKCRB8DEliiIei
gRVqAQDOFRo69TFrxNsEr//ftUGiaFoBJ0nRveB6ZHilncat3AEA+HhxsRTgzivn
Te54zIqPwqE1AlnXXhzADSEhbUpPWQc=
=3PdW
-----END PGP SIGNATURE-----

--79+tdnicQkodp1ci--
