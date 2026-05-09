Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214B3909AB
	for <git@vger.kernel.org>; Sat,  9 May 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778335723; cv=none; b=jEoPjwGz3n/AvArC3HAmPIeGLNeHl+17ghqXS7V4K33DfdXfgzi1wqTBK+rK6urcVz2dXVj4gLZqsbxJH7uOod+PMvDgpvAX4VBseX9W5v9n5qfMqvww4TYTGnqMUSj1+8OmDiXnWUZAlFV3OG2xWKS25nFxs3zTdmYiW+6gXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778335723; c=relaxed/simple;
	bh=JpSS7nd9s2zTZXSZ8I0SiXyFvPMfODXtg86v3RMrjxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlsXnRMzvhqN/3+UTLID/TB+5yIPMtbM8BeJNOJBFHWMIcQ0SIBfUU5QLf8fcnB9GZhyEJ5Lec/1pc9jgFau9gXMwuNwrnvLA23xF1kydughG64z1u20aeedUaiCrBMnveCU3E3GGIIV18UMkxDWEROAMqJBA3CZ6ZKTjFqC+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qq1XkyW+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qq1XkyW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1778335714;
	bh=JpSS7nd9s2zTZXSZ8I0SiXyFvPMfODXtg86v3RMrjxM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qq1XkyW+nPRCt6gj/TT2aJiy0LooyT8qAem9d1v8zmYI+IdmDlg9KRwGm2nGLspW6
	 Udm0eY1aQJBWlxt7t6vUj/dCpbPiikUccBzipdaJEprY/CwJ+HXRcw5nvSdIrvxVQS
	 sOfQJCr1IUVwJuSrgeDZpa9UGVnlZwQYVVDTBIkuEe61V6lJsHsW76UWF0RTqn2lmd
	 9JceQdVl0y6MmKFWbLpcKLCdvNAfrQmZ/vQUUzNeS91sFw07jnDUIgBQLZPj9SEP0L
	 dl5vtnQeDJPeTE5uMZVPrjcSrRnESQLIQuxkEY3A0D8ilZcwUpzbfXHQskxfTAMoPg
	 dVkRRATM3JaBojyCdk0LC/m6azCWGB0s0QyzoHDghYDaoy+N4oFZby7AzVniognf/I
	 V08sTZTfuN9CnhTto/ZA157/qjtqEoGg5EkILW4NKUWg2u9+KbIg1CLLi0PiAln1hO
	 NqAWow/08N/yV3n+Eg0Je123dx3Kl3FNb94oAb6fdhrP+Ae6YiH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bf3f:e933:4716:816f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A5F47200D8;
	Sat,  9 May 2026 14:08:34 +0000 (UTC)
Date: Sat, 9 May 2026 14:08:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Caleb White <cdwhite3@pm.me>,
	Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Andrew Berry <andrew@furrypaws.ca>, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] ignore: note info/exclude lives in GIT_COMMON_DIR,
 not GIT_DIR
Message-ID: <af8_4cHEESb-Zit2@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Caleb White <cdwhite3@pm.me>, Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Andrew Berry <andrew@furrypaws.ca>, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
 <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="38PPvsGhl+cAtoNg"
Content-Disposition: inline
In-Reply-To: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--38PPvsGhl+cAtoNg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-08 at 14:14:14, D. Ben Knoble wrote:
> gitignore(5) says that the per-repository ignore file is
> $GIT_DIR/info/exclude, but in a worktree that is not the case:
>=20
>     git rev-parse --git-path info/exclude
>     /path/to/main/worktree/.git/info/exclude
>     git rev-parse --git-common-dir
>     /path/to/main/worktree/.git
>=20
> We actually use $GIT_COMMON_DIR/info/exclude. Adjust the documentation
> to say so.

This seems quite reasonable.  I always appreciate documentation patches
that clarify things or fix inaccuracies.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--38PPvsGhl+cAtoNg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmn/P+AJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4irBIsfDbC94yGUyqwR93IZpLy66sJxSlg75NFV0xuJ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGdXAPsGnTP4tVuHAUojofZE4ldW6b/O
saDUdF6riI2IdAZT3gEAtuPOBTnirSihYnt5Jz7/7BVbo5f9ytFfd8UDfp+RWA8=
=srcq
-----END PGP SIGNATURE-----

--38PPvsGhl+cAtoNg--
