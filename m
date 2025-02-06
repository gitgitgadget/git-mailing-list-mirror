Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DC195
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738806400; cv=none; b=X/lz9oYuSelLuUwPQBxwp/wezAvqQQlZT6PUd5jTexEfXSinUxF5/RIaOxmHN3HUbifEs/RhVLmBjFROGle9jKGzatbC25+h/LTVMG7whOTjB2X065A6vTClvNSZDAun5ajFWTrQXRA8TZlA1JmQVmXMHALFQxngbV0OHgMiAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738806400; c=relaxed/simple;
	bh=1x8i+I6W18P1Ltbf05sTtiCuOc+nyHjZAFKx79oUy+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjG/htfspuPKWPaP+dmqCglyv2JD0JC4iTUFUf1e1FwemtB44deJLphEdexqJMUYlCUqMH0g0YfgDI80v/qFIwpbrVr/TlpmUdam+dxoknRkJH454QinQz/FuOVOsm8VFNSG16guqLYjPSVi7BHpStUUPZ2uy+ih0Mk335sAkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Nmdmw/MA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Nmdmw/MA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738806396;
	bh=1x8i+I6W18P1Ltbf05sTtiCuOc+nyHjZAFKx79oUy+g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Nmdmw/MAJxLzlhFzJe3ONW5PA6g74/VLg4XR6U41RzvdW/2VUvlq3CCUCoUxPyn2Z
	 uKlZrp+ol3ADH+u8qGM12J/p2jCrzJXR+mryUZoFDpAJkzKqpWdwlLs5gJeUrgHhPM
	 1FBpMshsj7GlO5UtjHZfJ7+XPphm2rX5k+cUSYeCURoP+7ac1q+62ILdWNP+JAOS6f
	 WxndhWEqf6HFXSFAkDR17o3JsIAoFUwsl5D4TN2bikNILx0AWRASUvMWY3z4D1KhwZ
	 HUMYKLjToUBpdfkbXXht6arATIXQJ6fuahG88Gvr8NyysFwzu2QFQEGS1ZCEuQ6G6Z
	 vge3MjYywa1uKbpEBo5g8jMrK/Ic6rgVcLWydSlmKeiv4O0vve4IcmW3OCWBQA7XyF
	 Jtekwmbpdf1ZxIyvrNtyYtkH+av1pmUNU/EjDaBsftXDL2ZuOtwulHn0wdHqRXkjb4
	 m4EzK8ItAgcLPTWXA+4G7vr2OoQcJDtTX+CRVGXIHu6Kp9KR9bI
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 32C4C20067;
	Thu,  6 Feb 2025 01:46:36 +0000 (UTC)
Date: Thu, 6 Feb 2025 01:46:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kapil Somani <kmsomani@alumni.ncsu.edu>
Cc: git@vger.kernel.org
Subject: Re: `git p4` broken on machines which do not have python on path
Message-ID: <Z6QUeaoH_tV2ncwn@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kapil Somani <kmsomani@alumni.ncsu.edu>, git@vger.kernel.org
References: <CANF_+=4dG7bVF5n+s4ezHR=HneeMgvYNhsOjsz7e7bFapG2f2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WMESyItR05LYjpbE"
Content-Disposition: inline
In-Reply-To: <CANF_+=4dG7bVF5n+s4ezHR=HneeMgvYNhsOjsz7e7bFapG2f2w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--WMESyItR05LYjpbE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-06 at 01:27:48, Kapil Somani wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> Run `git p4 clone //path/to/p4/depot --destination=3D/tmp/localcopy`
>=20
>=20
> What did you expect to happen? (Expected behavior)
> The command should have imported perforce depot to a git repository
>=20
>=20
> What happened instead? (Actual behavior)
> The command threw error
> fatal: 'p4' appears to be a git command, but we were not
> able to execute it. Maybe git-p4 is broken?

Can you mention where you got your version of Git from?  Is this a
Debian Git, one you compiled yourself, or another one entirely?

> What's different between what you expected and what actually happened?
> The command did not perform desired operation
>=20
>=20
> Anything else you want to add:
> The machine does not have python on path
> I noticed `git-p4`'s shebang line points to python.
> On my local git installation, i was able to update shebang line on
> git-p4 to python3 and
> the command worked as expected.
> With python3 now being default should be update git-p4 to run using pytho=
n3 ?

I think if you compiled this yourself, you probably need to set
PYTHON_PATH to a suitable Python when running the Makefile, and that
will rewrite the shebang.  If you got this from another source, then
they should have compiled the package with a suitable PYTHON_PATH and
depended on an appropriate version of Python.

I realize that Python 3 is now the default, but there were apparently
still some people who want to use Python 2.7 last time this came up, so
the default shebang hasn't changed. According to Python upstream,
`python` can be of any version, although for all distros I'm aware of,
`python` is always version 2.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--WMESyItR05LYjpbE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6QUeQAKCRB8DEliiIei
gabdAQDKP7KneuxJEHMPktcsYf+JgoBF09ZWEGLhf/unccCXowEA3x82k9uhpLhd
JUVeSpYXDw2sBvCPKPYaZ87EPe4QRAc=
=LAdb
-----END PGP SIGNATURE-----

--WMESyItR05LYjpbE--
