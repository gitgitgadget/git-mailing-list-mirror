Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529F145FF5
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074944; cv=none; b=Kw4G80Xiz33Ik8VwDFSj5ARlCN7d2FehYH38bh+QcqqIdR2WmM2pRk61jeyUwlcdCzoyf528krDAb6FV551KQqcY5eyk+csVOjIriCvKWM3pvB7b2ZjlixJ4F5xUd//NcI2c/xtgIIccYfbRoL1UBkF/vE0hzP0kYILYTpPmSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074944; c=relaxed/simple;
	bh=l0O/0XbJCqCWafdC4VLOz5WxhYSHPlKVIYrFBcgdDXw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1EYDO3eDHc32lhZssujc+LDHyeAIcS45XhFI4m3g62rQiFV7tYKnusnjKSFxxmb2HDFEhMNX4cPadAeho8BNFpDFlN5zL3VHRWQ8vXudfQpEmt70/RcDbCYeb6zeQ8DGW4jDjZpIk2gZuebLgVlZUL3EFUboEnhSXwBVkEjNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=x9bFTvPu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="x9bFTvPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723074941;
	bh=l0O/0XbJCqCWafdC4VLOz5WxhYSHPlKVIYrFBcgdDXw=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=x9bFTvPunL68L6ve+BrtmahBdb+yw4+rf3fG59lra4+VshunGgnLSFe+foNn7Hlly
	 eMCgCoI4IcvopNUmvFkZLDZRjiavK8Gx4bnjInRHwi87QERZo1x/Eag7xLVmUeZC7H
	 3pKyO3+mbdnRpoHI0WtZ2nv+PaA66CAIGLUeURMoEeOOB1q1hKOchQYr61FH8DSsMc
	 zyZUB+ALb+N6cVnNM+zEAV/8Qk/l9BhwCtCQJZLvIgycp0JxeuFPssE+3g9bJlvVDy
	 mjupp7LqNIc83L06Ql5zrD41XJU7FXIUNngODVDjb1g3Bzz0nt8uC0Vx0Xg3mgkNrf
	 KacXJRC6OkLAiJOfmZE/6ba6Gu+CKmb5Zn17Sfrk4SB6w2LgXvm1DDhVLgqgpTD5gX
	 DnLHvzy2wZHNBuwsdKB48O/Rr6Kduo/2lhgB4aTm+NVHyd4ED+jRznlwJ6lFTjLptc
	 U+nDR0ImPTx5nqu3TQEKfv+KX2DyA4NRxQaPp4DeQYDRPg17RJf
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 066BA209BD;
	Wed,  7 Aug 2024 23:55:41 +0000 (UTC)
Date: Wed, 7 Aug 2024 23:55:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <ZrQJe32sYNOTSJGf@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
 <b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pDZGdjvUbYDxD1X/"
Content-Disposition: inline
In-Reply-To: <b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
User-Agent: Mutt/2.2.13 (2024-03-09)


--pDZGdjvUbYDxD1X/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-07 at 23:05:00, Josh Steadmon wrote:
> Yeah, needing to free() is the only thing we striclty need from libc
> right now. Please correct me if I'm wrong, but IIUC then any memory that
> is allocated on the C side and then passed to Rust needs one of:
> 1) freed by libc::free() on the Rust side,
> 2) passed back to the C side to be freed there, or
> 3) leaked
>=20
> Am I correct in assuming that your opinion is that writing additional
> *_free() functions on the C side is worth it to avoid libc? If so, then
> I'm fine with including that in V2.

I think if we're going to be writing a general purpose API for
libification, we probably should provide free functions.  Normally, that
will be a call to free(3), but in some cases we may need more complex
logic, and by providing those, we're making the API more consistent and
easy to use.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--pDZGdjvUbYDxD1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrQJegAKCRB8DEliiIei
gYI8AQCH9L/6rhR0lNklUFMROPj6wUgL8elzOINuAnsqs1RenAEAojrG5DSYSHiN
3QktxyKI8xfaqhkw0HOcQehohYUeJwA=
=3K6F
-----END PGP SIGNATURE-----

--pDZGdjvUbYDxD1X/--
