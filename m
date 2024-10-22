Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FC16F85E
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632630; cv=none; b=WCsJ9qC0bpz/Y2426bkYXBkbQXQwKMiGFKuAmzB5TGRBQU/aLqd44btKAOWXRQWxxLJFSZQOIAT1GNeJFH5nRwLQfTcE5lR/rycjdS58kjloUlTYXVHgDqevWxtoX+wba9fA4EgIi8/1AEofvXaZaSU5UoGUIfP6gWI026FSYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632630; c=relaxed/simple;
	bh=Ba4BgvBh4cxS1lMgJXMWxHt0wjHSdqd7e56OO1suVRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJKJaxvjD6cldrmDjoYZk4i2848sU+xHk6UxRNxDEUmDj6S3/fGMxCAXHNWuvCT6+QwzHfpeOmvPe0I8tkbqZyS+keLGTqlKVWFbEJtP2DTkqhA8SN3W0OtdKI2uRhREPNnvXVRrBt3GbMZ5hg13CqIlF5WJbT6fMNx0NxJlp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=jW841c17; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jW841c17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729632620;
	bh=Ba4BgvBh4cxS1lMgJXMWxHt0wjHSdqd7e56OO1suVRM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=jW841c17fB0sHFiXjhGeuRyt+7QOFg8mjodI2xPpczdXAIWIlT3zqR+lwnckLr5J2
	 fUHTe87Tusklvm0JBk/Rns7ysGk6QSKOVRWG39sVsZom2XRo3H5figkimmPTfnC8sQ
	 I6nSYZ4LhDlNNhYASQp6YAZthKBJ8fxySoghzd+rTnMXsu5J8dcZPZ7uHKZcRo0IsI
	 u7ucV+NKgwzmHYWsFES5SZLpCIy16Tz8gn2B9vgkMojJzyZFO8/K3V7hvs6kOKhESv
	 6/X1UCQ7rNY0RxmwUOboeP7s2CPYYmqLUCsbnqPyiMi4hyQcA3tKj/g8JiWJkGNNfD
	 XEetv3uOv0jauRI81wBK22GQSg2809Jh4I7zcYmNA7/jUsGUCR4RZduH8Pxdve2CrZ
	 gdO1GZBW6EIQ0yZoNNEGenqq4TCTrxC4BZcQ6P+1V1YDtpOdh3MQV8o3g5RNYT0pXq
	 BvsiP6WSxu2OPDuUtuw/qakBRhVfspe5D90Fqgk07TZ2tRMzr1X
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C327E20031;
	Tue, 22 Oct 2024 21:30:20 +0000 (UTC)
Date: Tue, 22 Oct 2024 21:30:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Mike Lothian <mike@fireburn.co.uk>, git@vger.kernel.org
Subject: Re: Build failure on RHEL7 with 2.47.0
Message-ID: <ZxgZa74fplSUUL5W@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Mike Lothian <mike@fireburn.co.uk>, git@vger.kernel.org
References: <CAHbf0-GMV9VS7BAjvZiNENNOdZqV3jQ4+0k1kTZLkQhFT=6D-Q@mail.gmail.com>
 <20241022140340.GA31399@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LahJJmTmEWxq81fz"
Content-Disposition: inline
In-Reply-To: <20241022140340.GA31399@tb-raspi4>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LahJJmTmEWxq81fz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-22 at 14:03:40, Torsten B=C3=B6gershausen wrote:
> On Tue, Oct 22, 2024 at 02:04:52PM +0100, Mike Lothian wrote:
> > Hi
> >
> > I'm seeing build failures on RHEL7 when trying to build 2.47.0 - RHEL8
> > seems to be fine
> >
> >
> []
> >
> > Have I done something silly or is it just too old?
>=20
> 2 questions, 2 answers: No, yes.
> There hasn't been much focus on supporting these/this old platform(s)
> the last weeks or months.
> Thanks for reporting, I myself can no longer compile Git under centos 7
> any more, but I am happy to work on patches.

I think RHEL/CentOS 7 is too old to support according to our platform
support policy.  It's no longer receiving regular LTS support.

The clar patches I do believe will be coming in soon, but I think users
will need to upgrade on CentOS 7 nonetheless.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--LahJJmTmEWxq81fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxgZagAKCRB8DEliiIei
gcmSAP0coc/8vm8utRWVntQl8wdmIQPAS3Cesqfj11QhZ/GH5wD7B4LNTSOTpLK6
i448/QiudHViiDzBaFFRaXEw0cM/OwA=
=+0GD
-----END PGP SIGNATURE-----

--LahJJmTmEWxq81fz--
