Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855057333
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454262; cv=none; b=BVaMrb1qbGD8nad6YG+frBAZU9NoNj1LMK7CoCzs/heRGaEmFFHQvU7j0qniMv8G8qVV+yYigVls9eVhYQxMuwWXzRaRN+BXQPk4jRMS/e7pDCS7w8+NjFbLgu43aqihXjlEOKUCkAWwVFQklmas+z6CrzSl/4SatUriKAUm5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454262; c=relaxed/simple;
	bh=aNF+R4flyqf15cXpJlIigA6gWonvYllS76yyfJcN9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrJxJxWlhD2PCCKpc9ILKkX+NHJkUCczbVdXqPYhEK8Wh+vPlEDiYOGg4ojsRTR6JtLdKxLDUYzZZR9y5vMGzq5f/y+Y4ecXJzFEIWz0v82xB+Xu6KO0TnQNNc1m8ZnywS1/SJx2D1DqPj+3a3XwbWXyNK75HJk/oeJlOjfl+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=X4wHcQ0A; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="X4wHcQ0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1717454258;
	bh=aNF+R4flyqf15cXpJlIigA6gWonvYllS76yyfJcN9Ng=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=X4wHcQ0AFgLh2wqV9mVcCkHsHDolSCp/08rFKGItTZPtSybdTYbRRksCJ7/9gNfiZ
	 yY4ep7mtO8dtURaKh1sb46gySxd3fuTpR36Cjk0SfSTgm9oxZ9Kdd3RdVVdhUOVUsQ
	 +Y7PJMje+zqJZT4F+mcgEXh7U2oa5QnKL/nQJ/B03r+/y6yF/BheT51Zy5Qi56c/kS
	 osjOmhHRwhfKZiLYQaeD23oBlQp9KrjCi3dAWndPTLNDCfVJLL7phOFFtqvTqZUhE2
	 pwYTZCYKntLGzw+tbstkToRAaVKQKNFB4eimHUJuFQdNf3slthMLW7dZ65QpW9c1JV
	 VzRH5zXdAtGLy7dkty+dGbJXCG1ukQcquoF0oaKc7JmAGKF6TFXmjt61UhlP6n8PcA
	 hMHhnGiY4aOTNJjAnRIgg9aPHphF3dglm/Vr1NrHAs19DEMxl9mDiRlfMv3eX9HWvu
	 1W5NOmxJRmxPg5FUiBmaip7HYDFD/fxZlqg47KPgc+UNZDp3tuv
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 71E652638B;
	Mon,  3 Jun 2024 22:37:38 +0000 (UTC)
Date: Mon, 3 Jun 2024 22:37:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Workshop BLE <workshop.ble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git hangs forever after updating to V.2.45.1
Message-ID: <Zl5FsMHT0k53TMJk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Workshop BLE <workshop.ble@gmail.com>, git@vger.kernel.org
References: <CANXjuPnUr81bKGMqZMvDjVZ+1suddoR5-8-SZn8W4EehW5-siw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FsPDp+xjxX5q4Fz7"
Content-Disposition: inline
In-Reply-To: <CANXjuPnUr81bKGMqZMvDjVZ+1suddoR5-8-SZn8W4EehW5-siw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--FsPDp+xjxX5q4Fz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-28 at 09:01:14, Workshop BLE wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> Upgraded git-bash (windows) to latest version 2.45.1
>=20
> What did you expect to happen? (Expected behavior)
> git works as usual
>=20
> What happened instead? (Actual behavior)
> git pull and git clone just hangs forever when remote is dev.azure.com
> (did not try any other remote)
>=20
> What's different between what you expected and what actually happened?
> see above
>=20
> Anything else you want to add:
> When executing with GIT_TRACE=3D1 GIT_TRACE_PACKET=3D1 GIT_CURL_VERBOSE=
=3D1
> it can be seen, that git connects successfully to remote, but hangs
> after a cuple of this lines:
> 10:51:38.026547 git.c:465               trace: built-in: git config
> --null --type=3Dpath http.dev.azure.com.cookieFile
> 10:51:38.065783 exec-cmd.c:243          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 10:51:38.071783 git.c:465               trace: built-in: git config
> --null --type=3Dpath http.https://azure.com.cookieFile
> 10:51:38.110297 exec-cmd.c:243          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 10:51:38.116296 git.c:465               trace: built-in: git config
> --null --type=3Dpath http.azure.com.cookieFile
> 10:51:38.155881 exec-cmd.c:243          trace: resolved executable
> dir: C:/Program Files/Git/mingw64/libexec/git-core
> 10:51:38.161881 git.c:465               trace: built-in: git config
> --null --type=3Dpath http.cookieFile

Can you provide an affected repository that's publicly available?  I
don't know of one myself that reproduces the problem.

Can you also tell us what version you tried that _didn't_ have this
problem?

I also don't see any calls to `http.cookiefile` or related paths on my
system, which is a Debian sid/amd64 system using a next version.  Is
this maybe from a credential helper that you're using?  If you're using
Git Credential Manager Core, which comes with Git for Windows, it looks
like you may be seeing
https://github.com/git-ecosystem/git-credential-manager/issues/1620.

If so, you probably want to follow up on that issue or with the Git for
Windows maintainers, since that credential helper isn't a part of core
Git, and as such, there's nothing we can do to fix it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--FsPDp+xjxX5q4Fz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZl5FsAAKCRB8DEliiIei
gU8uAQDTa7Y6YT9hlfrNuQULA5xFEuU/cWEGfkyyDTLL2V6LIwEA5JU7HkcK52TA
AaibRvNjQAyVloL2VFHf5Z/bF8AAlA0=
=6VsZ
-----END PGP SIGNATURE-----

--FsPDp+xjxX5q4Fz7--
