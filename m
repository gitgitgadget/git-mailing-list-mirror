Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D6111AD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729127431; cv=none; b=BQ2boDe18edkW4rdVL8Dl3aetDg/0E6k+JOAMCLO0bXiEvkp/HZc3J/8z2kt9loCog54V7Qv8FEV/H9gxaOh4h483S+Cx82iq8S2eHEZ1ndvacxeksLaoxPe7LfOhk7DQHiuFbCu//i6/GsKFpN6OFmTNw2iQES8stfufP3T1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729127431; c=relaxed/simple;
	bh=WtwLZfzYTy8u2koNMdRMvF7rCvuvtD9QzHrVqfVyOmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZqTtFRRfQDFrGEGDQ/BT8Dc2QzZIYkq8PQjfF70F0SBm7EpO/w1lXt1mXDG0zAYbg61yJ2zEwTetcRVCKJ3eS8HL4c/iiZiwOVk0LLHnrI0zTu3omBo4xxDN7sxDlWLrG/B+pqULK0JHOMF4hgHVMIaudQf4dgauyFK4m5IlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zwEA8Nb4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zwEA8Nb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729127421;
	bh=WtwLZfzYTy8u2koNMdRMvF7rCvuvtD9QzHrVqfVyOmg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zwEA8Nb4SYI2QJr9wevBa71B1ocdGFtrDsOhmLgdj+X59VEdlsKXlwAHEiYl6I7tq
	 0I+QYdAJ91f5UzoI6ip6Dh5GbL807CHIH22LFI8C4M8T1bVPg1NnWExM+xxWoOBxUe
	 ZKNbdL7vO3t7ItmSEWEeZaKCuuYTIx36rMy3uTrqWM8PEo/58dQXFVNqUO0TBGWfOz
	 pXlPpXetr8z/SX9ma0z8hVp9ISEd5kP7EtuwoF9vinzTgO6pTqowp4nvQwTDWKus5I
	 HPXe5W6XaL5L9vY6oKr1mWaBPNXyGDdrPKZG9jEd5SiAN1vbwEjm5kblI1sNHGCBet
	 YE29YxlPXuRVoAmt/LxY4C79y8nCzHNSWHsAu/43O2sJ6/sBr7TyrVU5J/e4TBgN35
	 TZE2LcbdLYUgUm4vA3sJq1X6KEzy/L8LVhhHNNcmjSf5gqTU7KKK6yEqk5dw3+giUC
	 Ct8Rt4GLpye6oSxmL5XQ8jxb7uXLzKaGpPvI1V3Cg6wKCmeYLu/
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CDE01200B3;
	Thu, 17 Oct 2024 01:10:20 +0000 (UTC)
Date: Thu, 17 Oct 2024 01:10:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <ZxBj-VEU6M2TVL2W@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
 <c046e5f03bf9e3eeda803133b88c3ae414fd0c69.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8mNAVvSuKv3qzi/K"
Content-Disposition: inline
In-Reply-To: <c046e5f03bf9e3eeda803133b88c3ae414fd0c69.1729060405.git.ps@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8mNAVvSuKv3qzi/K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-16 at 08:12:53, Patrick Steinhardt wrote:
> The iconv library is used by Git to reencode files, commit messages and
> other things. As such it is a rather integral part, but given that many
> platforms nowadays use UTF-8 everywhere you can live without support for
> reencoding in many situations. It is thus optional to build Git with
> iconv, and some of our platforms wired up in "config.mak.uname" disable
> it. But while we support building without it, running our test suite
> with "NO_ICONV=3DYes" causes many test failures.
>=20
> Wire up a new test prerequisite ICONV that gets populated via our
> GIT-BUILD-OPTIONS. Annotate failing tests accordingly.

I don't really have a strong opinion on this patch, but this has been a
part of POSIX since the 2001 revision, so everyone except Windows should
have it by default (and Git for Windows ships with their own version).
Perhaps if people are not seeing the tests fail, that's because everyone
is building with iconv enabled?

I will also add that as much as we might like people to be using UTF-8
everywhere (and to be clear, I very much would), many repositories still
have commits encoded in older ways (such as the Linux kernel) and there
are unfortunately many people using working-tree-encoding to convert to
UTF-16LE-BOM for compatibility with legacy Windows software, so in
general, only users in highly restricted Unix-only environments would be
able to confidently run without support for more encodings than UTF-8.

I think this patch is fine for now, but given what I mentioned above,
maybe we want to add a weather balloon in a future series to see if
anyone is compiling with NO_ICONV.  After all, if everybody has easy
access to iconv(3), then we might be able to drop support for NO_ICONV
and the work maintaining it entails without negatively impacting anyone.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--8mNAVvSuKv3qzi/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxBj+AAKCRB8DEliiIei
ge4vAQCr/+UXKmy1f/6K24l4KGau6D+0UCcNFoHt6IVdqWhv5gD9Hzbb1QYEmRcC
FPNENWsm9RR13VsnZPJfqKiaGYDBBAU=
=Yp2t
-----END PGP SIGNATURE-----

--8mNAVvSuKv3qzi/K--
