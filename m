Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E317D2
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770249876; cv=none; b=W00VGYcDnp0AA2a/2MiYAr42/mHUW7WM7Ug1BaaaVNy/UsiL1Gp/EwrVtXPlewh1mv07G5v6lPEMzRx9WyeqnfGW6oqQNy9R3qbXlTMmSt3wsfWSOZ//4US1WvedpwQKo1MoX/n8BYE2LUO3Hkx9gvAMXuoJMQDXwTpuqivl/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770249876; c=relaxed/simple;
	bh=uoGEGmw3K+oTauLG8+nxZePOojspCHG4q7Yl6UowKhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsaX/zTcHFjmBdLq9eHK45syuKh2oV1QcI+wdEw/jIiO3mzHWhbIMImRMfWFdtRe1FgEMrAi8SjdY51dgKXXWsH9/OHxxzr+ozzoqL60r+6djFVlDi7aZ7JlvDwtbBAdjcG6Ns+zvVLAPRR4R+PW8UhAEo5rbfrI6py6bEse4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Hz3grX+F; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Hz3grX+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770249868;
	bh=uoGEGmw3K+oTauLG8+nxZePOojspCHG4q7Yl6UowKhc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Hz3grX+FI7IvBNXPlfQ/GPcUVCLPchadzXr+CObEeWnfAzqSjJPn3y3QD+lO5kT5g
	 ii8wLTfpKOf+DfbWrMv3sB/U2G0ELvMYX/ITWrN8REazAlwMQR7SWuIwFAYX81kSWd
	 VqQqpxqoeWYPYeRN6o/Odh1lxqeubIpjABK4kCoBDQJEt+n0xkUgwC0V1QMdn2x57v
	 MLJTan5tjuAqmwt6/qbwAVJPcMx46XtcxJLS7nV/a8YWY7qMECcrFNHtZVtwFTXhtr
	 mgOuTivZG3tSwQSilddOTTuCeSjVUoqTWjhcbmNp8f68/uEB2JmElo6I98O3kdyoEZ
	 enOMBSABq64ni0Ad6hw7j4LXiSdN1N2xlNWwH3LuVirvakpEnt9oNxfHgPPws+1fyS
	 gQxDsKKNDL4kwGDR/mnYfeKeSsz2PWlE1pCObH463IyyQ6XWQ3cvRF3E544qSOaGN5
	 56PYKGxZRLs56AyyKzFlac+0slvQUUk3Ie3UMu/8OycpHwGNaNa
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:139e:b5f:f1d6:55e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0860E200B0;
	Thu,  5 Feb 2026 00:04:28 +0000 (UTC)
Date: Thu, 5 Feb 2026 00:04:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 00/11] [RFC] config-batch: a new builtin for tools
 querying config
Message-ID: <aYPeiqkw41ln7De_@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OZBmwwdNfF+sW6lW"
Content-Disposition: inline
In-Reply-To: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--OZBmwwdNfF+sW6lW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-04 at 14:19:52, Derrick Stolee via GitGitGadget wrote:
> This RFC explores a new git config-batch builtin that allows tools to
> interact with Git's config data with multiple queries using a single
> process. This is an orthogonal alternative to the effort to create a stab=
le,
> linkable config API. Both approaches have different strengths.
>=20
> My main motivation is the performance of git-credential-manager on Windows
> platforms as it can call git config get dozens of times. At 150-200ms per
> execution, that adds up significantly, leading to multiple seconds just to
> load a credential that already exists. I believe that there are other
> benefits to having this interface available, but I can't recall any
> specifics at the moment.
>=20
> This RFC adds git config-batch with a protocol over stdin/stdout for
> executing multiple config queries. The implementation has a limited set of
> potential queries, but also creates a model for compatibility for tools to
> automatically adapt to different Git versions.
>=20
> I'm submitting this as an RFC before I've polished all of the details
> because I want to make sure I'm going down a good direction. Please focus
> feedback in these questions:
>=20
>  * Is this a worthwhile feature to add to Git?

Git LFS has the same needs, but I believe it can use `git config -l -z`
to do that and parse the config options itself.  If this is just config
fetching, I'm not sure of the additional utility that such a feature
would add.  If that interface _almost_ meets your needs, could we add
functionality there instead of a new interface?

If you need to set many keys, I'm curious as to why that is.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--OZBmwwdNfF+sW6lW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaYPeigAKCRB8DEliiIei
gZKLAP9tdziLJwQXYOULLkswzXWuvd627m6ATRcUBtQoHz9N9AD/Zz7l7tHZxSM2
3ciEwmSXNeh0PdfQJLUSlZQkHvL8+wk=
=V0JI
-----END PGP SIGNATURE-----

--OZBmwwdNfF+sW6lW--
