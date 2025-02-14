Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288B19066D
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564500; cv=none; b=rMB/h41gIzqNIgAfkCdCTqf7DlOlhdjmX3tgB3t5h5d8OcdgAzbN4En2Xrp8n9RN7se6VV3iKipOEnr4YPtpMwKKFWPMI1isWnyWPwC4DOHd9hQhGbkHDLJv8r2x3Le5yGHNG71OG4YHDcnvrpIDV0Cvv+m0+jW2afIdVhUlXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564500; c=relaxed/simple;
	bh=EhmimE99nhglC2l6Lw5ifs9+5HkRmyxAsv9Dm5GDgCY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHiSxPAdJfORlk41LEsSuKA12Dd+6AKigGBu2LDuO/YJMmYYnleV3Eh06EhH7O2PxfWVA/wVZFqnP0jWAEG9KOLzqjukzMCPPulxvpuxYtZ1YvVQP92aKFbJpe4zhfdO0b1JcIL1ZuLWFX3gF9j0a+8lMSRslflK+czTezgA+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dR4QjysC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dR4QjysC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739564490;
	bh=EhmimE99nhglC2l6Lw5ifs9+5HkRmyxAsv9Dm5GDgCY=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dR4QjysCQiruEA37VjkbTImj6XJiKR0cqCToGdVzNuPI3VI7uIn3S09//eHOKpGTQ
	 Z+2+uDimRjziYvcWuERX1tUmxPJJGHUPfQS7tareX/5LDBu0qc2gBF1HSO1KeEK3rD
	 Sm9UowcfEkl3Z/nKFzIg83AQG2DgrrKqpmfxEkdEi8QC+ypYFYJ4rNamxQx60GxjNW
	 u9KLmxv+pzmh+N1TaTGVXPaCoMfs1cpvcBdBAAR7aZ/kpW0Z34F91erCjU0YBcd6Jr
	 r8tcPR9G/QF5Vm7tmY5cHFsYrVO56KjltGXB2RC11wuOkt4M5QUAu8oTzHtmtByVbv
	 L66incJcppSXg461j/itPeWwRSi23Lg12tB2ClHvDgGrCVVTDBTmK5wohjiQ881RTc
	 vr+O5L2Lx4qtQKrT+lYfhr/CLjTejBZ1s/8cqVI4gJB9JHi8qMQd1B29z6wCPmkfP0
	 9z24ghIJ6A1kFXuyJAYRCuramaOR4fjgfLsHeSxTQh3pm4wZ/qT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9286A2007C;
	Fri, 14 Feb 2025 20:21:30 +0000 (UTC)
Date: Fri, 14 Feb 2025 20:21:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter, again
Message-ID: <Z6-lyJNvXHhrVXhg@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
 <20250211235707.GQ30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LG736JaDyxzyFtuO"
Content-Disposition: inline
In-Reply-To: <20250211235707.GQ30202@raven.inka.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LG736JaDyxzyFtuO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-11 at 23:57:07, Josef Wolf wrote:
> Still struggling with my filter problem.
>=20
> Here is what I do:
>=20
> - Set up a clean filter which enforces CRLF (yes, for this specific use
>   case I want CRLF even on linux)

Is there a reason you can't use `eol=3Dcrlf` instead of a smudge/clean
filter?  That looks like this in the Git repo:

  *.bat text eol=3Dcrlf

That might be an easier way to accomplish what you want and it will
always result in CRLF in the working tree, regardless of operating
system, even though in the repository it will still use LF[0].

Note that if you need a specific encoding, there's also
`working-tree-encoding` as well.

[0] Okay, technically someone can override it with
`.git/info/attributes`, but if they do that and it doesn't work, that's
their own fault.  We don't worry about that case in this project.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--LG736JaDyxzyFtuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6+lyAAKCRB8DEliiIei
gZYtAP91A1167seGvkfZm1bv4VQI85GPi5c42Ni4pLmCnSUxEQD9HSvkeo5ss2l0
37B4SjJ3Rp/YzJJr0xOVSfsY8QxtxAg=
=OLGE
-----END PGP SIGNATURE-----

--LG736JaDyxzyFtuO--
