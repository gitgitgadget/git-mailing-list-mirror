Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84A1E570E
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967918; cv=none; b=Li0JPk9ShYFN6bBYobrqnhPEncSAhnBqSmMQWPk6zwndHCFLEBSlznQypZX+FjI67Y/WeDnsJ5KGP+WpJ76kFO1JyJcKMnDsSYHRchI4PQ8uXHBnJZfvIGCX2mzzP6KayMMcz4TX8v5gLNxft+wrmBBg+6tlrNR/A4iXM7lp38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967918; c=relaxed/simple;
	bh=W9NBijvoEyFn74nKHg93xZW7I7PVJtjxWTfoIhs5ZUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/abPmxBNvri6gBuiauGrjirQnCl9VUZnQuvHr8fqhYnaHI7K1rgQwcgjQeYw0X0FhR+k8v+Fl8jsPeA2ks7B/By0JkoPhLaOnrYmCxaksPiadSsRUriZTzfN6l/AjzGu5GLxQ7GthCsyNcoWH9J8qjIjZhqiYLTwxJLvK/r3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Ti5EA1Sf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ti5EA1Sf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731967908;
	bh=W9NBijvoEyFn74nKHg93xZW7I7PVJtjxWTfoIhs5ZUM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Ti5EA1SfnMv3cL2RN+ELPnQkFZr3J/GB0v7a4e/Wm0bdfT/AeKeJwjjih0/mUXsce
	 /rwuc0fhlE7HtjQX6R2dNGLJRpn8L4JmCpn67r8u4yv4qA56aQKrEW1MANGSEoTa7a
	 H3ul8mDvVhDHHa78UFn/4qdGpdJpY/9Op9mnTWoP3DOoyNLL17tFMxfRgTVeNQ0iVA
	 5LBGPheNzGeYqC9XDcFUHZtzCPyVk5C3pdvHMhU3atCh250HKizV+9kvRt5vLhpjOu
	 0WigQVV45Etw697ZDtiVIfRblO1QmK/Z2xlgnBB7nyTohuOlkLYws151ir6JU9MnBu
	 1lbTmgyDVE+q3+QKHs4aBSAPzSpQuj7wJyff7oqTAhYnCqXGQRh4Wi/F95woapVRBB
	 p3jr4/2WYOujmzMj3fMNimLB44ffEHVaApvGzo9C9TB7aGx9VxmcdweMlPoh6cru8X
	 Z2NLsFsPutFQmqrz7avsurQXbIKua6veuivRET9dlzQbH7G0QwU
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:d026:90f3:853d:a63c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 29D9E200C4;
	Mon, 18 Nov 2024 22:11:48 +0000 (UTC)
Date: Mon, 18 Nov 2024 22:11:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH 0/2] C23 compatibility
Message-ID: <Zzu7oiJ8PTWgmJUc@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>
References: <87ed3apy2u.fsf@gentoo.org>
 <20241117013149.576671-1-sandals@crustytoothpaste.net>
 <Zzrwf2B36RgbhxEa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SvnnxdsLZyPVS7Gf"
Content-Disposition: inline
In-Reply-To: <Zzrwf2B36RgbhxEa@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--SvnnxdsLZyPVS7Gf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-18 at 07:45:03, Patrick Steinhardt wrote:
> Both of the patches look obviously good to me. I was a bit surprised
> that this is required in the first place as I thought we were passing
> `-std=3Dgnu99` to our compilers, but that is not the case with our current
> Makefile. So I must have been misremembering.

We can't do that because FreeBSD's system headers require C11 and won't
work with `-std=3Dgnu99`, in addition to the general unportability of that
construct as mentioned by Peff.  There's a comment to that effect in
`config.mak.dev`.

I'm pleased you found the patches acceptable, though.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--SvnnxdsLZyPVS7Gf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZzu7oQAKCRB8DEliiIei
gWLGAP4/3oQYSI2xJctI4fpDktbAXR1IVVPPGX+9o2FzyD1GNwEA2PWxiorrNST3
1v+kj1ze9DeEuPwPedaItA076WsMSwE=
=1wFV
-----END PGP SIGNATURE-----

--SvnnxdsLZyPVS7Gf--
