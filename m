Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7ED1C07C9
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798771; cv=none; b=igFMinYefL4JmtSfynZd9+TxQBFHaxcl+pXPd7tnv1GQtbBH0ZgVc3qL38h4y2NyDl47O4kB6mRcF74RkxFmLBVPQ3gZS2LL1AhosYDrn4mBu4IFhpy4xyHdpsp7SryiiL0bySPa2tA/H+kdDs2TFNVfffh87iK2u0olmG8jfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798771; c=relaxed/simple;
	bh=DdYw6WA/RICwR0x7G8oFhO19PwHKAqLupmgSGyoiyIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SquN1tw3cNZW7SihuMXBlJTyAbNXB/UvgD1rNzN0gW+xTQkEa0UueXkU0CHV5p+XvRxVplv/W60tUrFaoM2fa56thO8Z9u7+sWYIoeG7euDJ4KihW+AB1YfmkElMUi+m5Swx3yXbEopFgKfMi2dqmbCeW88Ggo/xJi/Z8Qn4gnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KtcGh7k6; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KtcGh7k6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1733798765;
	bh=DdYw6WA/RICwR0x7G8oFhO19PwHKAqLupmgSGyoiyIY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KtcGh7k6QZTJO0fxobSR6GumHg17dYKFAXs4In+bLbOpbkEtWdc7MSibQSTuri06u
	 ZVuCAx+JO3TA7RURNMzw5DXHbFFuQPZ2/+ECwAgWAfbYOozqZ55wk5ggdodH+RntrP
	 ybev0Va58lxyh5va2Qro+ANRVN5O6sC9nLnS/KImX6OZm+mskUjbVvVsnMDd/FtuGQ
	 67xq3TeNJgsxJOcndZo30zykuboybws3hCLq6me5/LMyXPs6eq68wRb4+WUY/IvXUv
	 9I6EcIVLx+K76oc7Q9xWL9sM3L9B6i0o67+ADXHzCUysMzr0U5D/8s7FllhHkuSy8H
	 CzbsBfPD1xBJebfEKZv3wkp2J46n6xx9rvGJ/PNkwo1AlvQDgS0qA3tza5OMEMxqAx
	 Z2iBwcuIuyP5lNA8VvTHh9DY8Z38/Rh5pvAzeNbB6wopgxF+2bTQ+2pjv+T7jAVhWt
	 csideMULm2NqHnvfwodIrvlXvRGjODeXV4tRwWZCKVC4F8J0Dfg
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8441820994;
	Tue, 10 Dec 2024 02:46:05 +0000 (UTC)
Date: Tue, 10 Dec 2024 02:46:04 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sergey Ivanov <icegood1980@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git credentials store: removed line when token expired
Message-ID: <Z1erbLD33V7ENGGq@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sergey Ivanov <icegood1980@gmail.com>, git@vger.kernel.org
References: <CAJCbrz5_8nCWSsb2PYGmQoYDKE2vH5kURx9ePabPjosbJsMH_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gAmQWSaOGASpv6b4"
Content-Disposition: inline
In-Reply-To: <CAJCbrz5_8nCWSsb2PYGmQoYDKE2vH5kURx9ePabPjosbJsMH_g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gAmQWSaOGASpv6b4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-12-09 at 16:03:49, Sergey Ivanov wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1) My remote token to git repo was expired
> 2) I have git config --global credential.helper
> store
> and had line with given url added here
> What did you expect to happen? (Expected behavior)
> Git will say that token is not working
> and will NOT touch credentials file.

When a credential is not valid, Git invokes the helper with the `erase`
argument to delete the bad credential.  That's documented in
git-credential(1) and gitcredentials(7).

If Git didn't do that, then when it needed to prompt for a new
credential, it would get exactly the same credential before, and it
wouldn't work.  Because most credential helpers store data in opaque
stores (like the system password manager), it would be nearly impossible
for the average user to understand how to clear the credential if Git
didn't do it itself.

> What happened instead? (Actual behavior)
> Git removes whole urk from git-credentials
> and says 'not token'

This file is entirely managed by the credential helper.  I know it seems
like a plain text file you can edit by hand, and you can, but it's an
implementation detail that the data is stored that way.  It's not
designed as a general-purpose URL store or user-owned config file that
the credential helper will never edit.

> What's different between what you expected and what actually happened?
> I want manually change token only, noe whole URK format of which i
> constantly forgetting

I'm very sorry that this didn't end up working out how you expected.  I
think your URL may be available via `git remote -v` in your repository,
which hopefully should let you recover the URL if it was associated with
a remote.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--gAmQWSaOGASpv6b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ1erawAKCRB8DEliiIei
gTIUAP4ndxtMvU9/v2C952YutM5Qt5yTlSOMnAsT6xKhjdSeewEA04dUs0nN1YfD
gRJiewP/tK8SgEY9rmIQWXnnK1ucdQI=
=e6ce
-----END PGP SIGNATURE-----

--gAmQWSaOGASpv6b4--
