Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2087D27470
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981425; cv=none; b=ITkaj6hGHt1ZzGGLFbuTu6Lan7f8AyzjZhhtQAEplOABLHM9FnclS6uPe1CQ+9RNfjXDN/Nj4KcxlMOSO559stJx1R2EtGpaf3fVKFZUrjWrdWRk5ONppjBNGDVSxbVR2zDvHu6cj73/a4lD0a+9MwWv1M2ysYtr7oI+nKERXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981425; c=relaxed/simple;
	bh=s90udXaU0oRwYmOIJVJ407dNLMGcX9f9JYDpQaOzbz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNnnCWhaupcG7PmuJD8qGcUwOL4czfSpq6pCzUdXhNpYbGig+R+LW7Dr4rDTlS55WW1MVzPjktQwwEBWWFJzj42AE6iiN76EnFogLUQBV//Q/Nk15MGRUK3+yGvGLwSOpENGz6JxK9A5ZTuCmqXYQIwi/1SO1MHYqtrF7ujSAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YiqUUOcJ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YiqUUOcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776981415;
	bh=s90udXaU0oRwYmOIJVJ407dNLMGcX9f9JYDpQaOzbz8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YiqUUOcJM6QcMC5wGipPilQ8f7ePFGWRts0snD//hHpFHwsM2bXagtfzKANsGh0TW
	 7zXikMMyaOhep/ISxnnbHy/hJGgYk5uwJBeqUi5G9U8uwMKSSRWhGfN/RH4hUeC674
	 jIR9wfoOlHDR2fO6wknHYk8gHYSjXxtWLg1WgZqIfvxdRb8PcXdXLwJRbkOVsTPkYL
	 LhligQ04sOf9I11aZ4gTsxFTXAJtox0JmK5RQos4/dfKR+eKDjr0BpKVTCY2z6HGFD
	 n3Vl+nKDtp2dsY+Z9FEy8wSrvCM1yFKhdR558H5k9bhGpLfCLMouoChMKYi7KDSurU
	 ZQ2evxpepz766YTwphNYgR8eq3pYAZA8zKWDGqpvLHd6+DJqWhTI9YAAJqGYMYSasq
	 YGTyDEQ5IhopYy3c5PPxkXpUzxbt0HON/eh3W1GxyPZGKutGc8dW5OMspHdiWGOxVS
	 Zt8nY38nnPpXhklWY+VG1usqjhG7bMKF3oOIE3qfeKLLd/AixRG
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:55cc:40d2:74ee:685e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D308B2006D;
	Thu, 23 Apr 2026 21:56:55 +0000 (UTC)
Date: Thu, 23 Apr 2026 21:56:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: Advice on per-worktree private gitignore?
Message-ID: <aeqVpjPSyyvHDLWR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
References: <CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyQ91GYIcvOO+ASh"
Content-Disposition: inline
In-Reply-To: <CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oyQ91GYIcvOO+ASh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-23 at 21:26:05, D. Ben Knoble wrote:
> Today we have $GIT_DIR/info/exclude for the main worktree, but $(git
> rev-parse --git-dir)/info/exclude for secondary worktrees does not
> actually contribute to ignore specs.
>=20
> Is this a "we never got around to implementing that", an intentional
> omission, or something else? Since --git-dir is described as parsing
> $GIT_DIR, I would naturally combine that with the gitignore(1) manual
> to think that the worktree.git/info/exclude should work.
>=20
> (Currently it seems that main-worktree/.git/info/exclude applies to
> all worktrees, which may not be desirable in some circumstances.)

I'm not aware of it being an intentional omission.  I think what you
want might be useful in some circumstances, but there also might be
circumstances where it's not wanted and the user might want the settings
in the main worktree to be used everywhere.

So I'd say that we could add it as an optional extension, like
`extensions.worktreeConfig`.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--oyQ91GYIcvOO+ASh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnqlaUJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2kjqfVSbQmylsHG0JJHfSFvy1Z40q3dqMGYJSMntTQC
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIoTAQDs7+IXdk0H/FnsdiXB6HQy25WM
c3X4wzxCiW59FAUZKAEA0/JMEljU8DB/fLgB/yZjqBfINPN0NmH/mpo6Kwhd/As=
=mo9D
-----END PGP SIGNATURE-----

--oyQ91GYIcvOO+ASh--
