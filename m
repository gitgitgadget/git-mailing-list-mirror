Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58313BC08
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713553984; cv=none; b=iQ60NrrV6XT/5AlzG9cjjn45pe8nTRboMiPIS60YwmImpGPapEoxHC1ESUZNCW5u/W7UibQ/DbDcnTvVKlcKgX9rpWcI7AjOEdNu4s0TCXTK3wqHDrKIzJenrpnhsqDGzktE7b+SQOqG6psEBRg/eoPeBc4ILcBqNPghLmatHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713553984; c=relaxed/simple;
	bh=JE51tzE2ORZxr03ndcsddvatKdCzhnkcggPuea4ZGVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou55TmEEDe5YIFC7k7E+R0KpIELNAjuoEoJ9rXFOmOe8YDImin4IeqXjxHZt7oY/k+k/dTbLAWXEU5++OFaYgYm4942OcZZbB5KzGsB+EPUYE8+0VzuxeSgS1xmwoLfp1WqZ7e0RUbxnEQoOZXEOe//IZ06ZOabzy9LJ2Gwq6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1GZNwqOI; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1GZNwqOI"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 599D15D4E5;
	Fri, 19 Apr 2024 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713553981;
	bh=JE51tzE2ORZxr03ndcsddvatKdCzhnkcggPuea4ZGVc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1GZNwqOIm/5rqqGDaHpKq7yqVCsjiw0/Wd+sXv3DdI4h9lH0s7AIjtnlZdFO/czgK
	 IsiYIF1Kqv6xbo1B+oQ6F1AeAbnFNLEZJYqZC+/tIwbUfEfjva0VZaMBTV12UqHwfb
	 faW1NigrjwrOdDfg+txf9z13rgaywqngLloGBnDLJrX4qsXGRlWEf7NxtrIcT7Wij5
	 TBgG7M9d6O4jyfHIZoGLJtNFvt0KoRIQiauZLApI62rqQUD8F2tkl/xJGXq3zQDGtx
	 Iu54lhlaPI1pDN6sSUEfcZk+z8LcCLZ7XQ3Q1YwEkyYp91RgFdZ8bJZvAOTOEJ+uPi
	 M417ZHyteqcTt2EDSRBFKTLh2jKey0l3i9F6qO/KfnAcMDfGg7zj+Oiax8bUYQuu/j
	 nI6HiC4DEyaYkWs00a+w1d3TfMRz47xpES0fFOBgPx/kxtiDyosl+GSj73cZKLC0g5
	 gyeizv4EYsHQ34Jwz/QohPww+xtfS1FzxqgDpCvRF/znfS4TwSv
Date: Fri, 19 Apr 2024 19:12:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/11] Stop relying on SHA1 fallback for `the_hash_algo`
Message-ID: <ZiLCO8Wn0-4jyDdp@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4JSXm8W/MbQeTigM"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>
User-Agent: Mutt/2.2.12 (2023-09-09)


--4JSXm8W/MbQeTigM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-19 at 09:51:03, Patrick Steinhardt wrote:
> Hi,
>=20
> when starting up, Git will initialize `the_repository` by calling
> `initialize_the_repository()`. Part of this is also that we set the hash
> algo of `the_repository` to SHA1, which implicitly sets `the_hash_algo`
> because it is a macro expanding to `the_repository->hash_algo`.
>=20
> Usually, we eventually set up the correct hash algorithm here once we
> have properly set up `the_repository` via `setup_git_directory()`. But
> in some commands we actually don't require a Git repository, and thus we
> will leave the SHA1 hash algorithm in place.
>=20
> This has led to some subtle bugs when the context really asks for a
> SHA256 repository, which this patch series corrects for most of the
> part. Some commands need further work, like for example git-diff(1),
> where the user might want to have the ability to pick a hash function
> when run outside of a repository.
>=20
> Ultimately, the last patch then drops the setup of the fallback hash
> algorithm completely. This will cause `the_hash_algo` to be a `NULL`
> pointer unless explicitly configured, and thus we now start to crash
> when it gets accessed without doing so beforehand. This is a rather
> risky thing to do, but it does catch bugs where we might otherwise
> accidentally do the wrong thing. And even though I think it is the right
> thing to do even conceptually, I'd be okay to drop it if folks think
> that the risk is not worth it.

I've taken a look, and other than the minor typo I noted, this seems
fine.  I'm in favour of getting rid of the SHA-1 default, even though my
gut tells me we might find a bug or two along the way where things
aren't initialized properly.  I still think that'll be okay and it's
worth doing, since it'll help us prepare for the case in the future
where we want to switch the default and also for libification, where we
won't want to make those kinds of assumptions.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--4JSXm8W/MbQeTigM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZiLCOwAKCRB8DEliiIei
gSJ4AP0YFbituXV6kLxF7FFplsl84zSmnixXFNVq1xaABlfNWgEAz0AFb7NXLRNM
znz5a5jsQcpz1rhQyD4r4kWimy5NjwY=
=Y4u3
-----END PGP SIGNATURE-----

--4JSXm8W/MbQeTigM--
