Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD838DFC
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486619; cv=none; b=KUcY6AcofuvH4qKW6bGZgslpRFZmu5+NS6FQ8wCzQSg9GnibdiJVt1AdFikR+L5b56htaVD6hbMjVWV/R3qeINIWe3dlb2OjOp/NzSC1VcOYuCf/EucDLJh6MhCAfthJX8zCujFA4ZKb6ENeiZTj/MjCrffp+GRY/4bLzX3oK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486619; c=relaxed/simple;
	bh=l2PH/CaUWKAoDaAGxubUIa/WbRDA3AgnuKKLBWWOFAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvbwArenYveaQOtZgFdf4rj+DC/Mfji0TSY19Q0hdz+8CPYao5xcfc4V8jgzlWhaGZ8OJoXt48b/B1zGli7Alq8KTdCJncIcrsQshlGXeEg4nVXb79y2fhMLV0l5F3oUHNs7x6Q/QsloYrLSKOZws02IAntvqZ74prYC5GWP3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1WoKI9rj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1WoKI9rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720486616;
	bh=l2PH/CaUWKAoDaAGxubUIa/WbRDA3AgnuKKLBWWOFAE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1WoKI9rjkuJE2FAw6B+D4p6o2kzGbb81K1Gi1jcwOb3NUxJ1eDViXTb9ukVSB4NEw
	 8SU1ZvGwacb7iM2yFefEh8zzJ6CT9fVL+H/g8aap4/cWO953XNkb1RC2IvIVUlKmD8
	 yiIQWAl0Yoni7RzDv1Y5AUFPBcOMoxKGEzGL4L9WkksP+NEKWghr0tvp4gjQ2FpGkb
	 LcjBGhhvwJyTqfBv8Zk0CewDjncUzZfasWSIBJsX25JFXwwEFEQSsSGgy7AYPx5jBN
	 SWP6qoRZC378rHwviv8i4QmGGrAd3qy+/K/lMSkrJNATwp67mWDBMGfkKU0nWQTutw
	 mKKFrGnrqhZq1ixSO6HVVadDi4FSCnTBgVyTcNBulfLeUmcbN/F1Igt+AKKy5/lVAg
	 +zhBU1mI65WCh+PBkdfzUoTMemaEAk0dw+F4mSlFhamqVmEwpd5n/74/yip3G7fdXI
	 1d1JyLvDO+vHSNVi9owbM/0oZk2q3or+IA3/iddRreyYL+gG6bP
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 50B2120991;
	Tue,  9 Jul 2024 00:56:56 +0000 (UTC)
Date: Tue, 9 Jul 2024 00:56:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	jltobler@gmail.com, chriscool@tuxfamily.org
Subject: Re: Re* [PATCH 7/8] ci: run style check on GitHub and GitLab
Message-ID: <ZoyK1iZIRVDKQ4-f@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com,
	chriscool@tuxfamily.org
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com>
 <xmqqr0c3hkjs.fsf@gitster.g>
 <xmqqwmlvcx9g.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5IlajQlozly6ZCpt"
Content-Disposition: inline
In-Reply-To: <xmqqwmlvcx9g.fsf_-_@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--5IlajQlozly6ZCpt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-08 at 22:52:11, Junio C Hamano wrote:
> Subject: [PATCH] ci: unify bash calling convention
>=20
> Under ci/ hierarchy, we run scripts under either "sh" (any Bourne
> compatible POSIX shell would work) or specifically "bash" (as they
> require features from bash, e.g., $(parameter/pattern/string}
> expansion).  As we have the CI envionment under our control, we can
> expect that /bin/sh will always be fine to run the scripts that only
> require Bourne, but we may not know where "bash" gets installed
> depending on distros.
>=20
> So let's make sure we start these scripts with either one of these:
>=20
> 	#!/bin/sh
> 	#!/usr/bin/env bash
>=20
> Yes, the latter has to assume that everybody installs "env" at that
> path and not as /bin/env or /usr/local/bin/env, but this currently
> is the best we could do.

This seems sensible.  We know that /bin/sh is not POSIX-compatible on
some proprietary Unices, but we're not targeting those in CI, and Git
for Windows, macOS, and all of the major open-source Linux and BSD
distros have /bin/sh as a POSIX-compatible shell.

/usr/bin/env bash is also safer than /bin/bash, because bash is not in
/usr/bin on most of the BSDs.  Every other project I've seen writes
/usr/bin/env, so I think that's a fairly safe assumption most places,
and I agree that it's the best we can do.

So I think is the right move.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--5IlajQlozly6ZCpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoyK1gAKCRB8DEliiIei
gSwFAP9MWTj3NvjPD3vpkUFpVZM093DpCBPsH6ZM3RS8/XjqMQD9Hy/rbeYhgLLk
8cghiMhO9mpg0YViug7spWIWfLtzOgg=
=9uSW
-----END PGP SIGNATURE-----

--5IlajQlozly6ZCpt--
