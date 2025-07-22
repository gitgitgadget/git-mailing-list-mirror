Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9216288C06
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228367; cv=none; b=tLtzzSerpxh8zdY3Sun4L0h5AhKo2YaJ9kR/10FBddX8BWlVvOVzc8ogvN+unU9l+GnGnMn92vXfoELXfeqKmNCFtp1uWEHBQL8JAdgonFl8G7BSCUkRy2x1klkBz3fcd+uizujw1VqLXdIkMfMCBhAhQmsbU0g8hV6zpnuqEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228367; c=relaxed/simple;
	bh=Zc8MgHe6QBdwnRyd6DJsWvni1K/jzi+7jOEzs1Lx/Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjqv69Jb7fpJLAWzHZL0or9ZP4S8Qx75f0X3liN5B31Lw6xjlALluKN6s9eBSM75E8+AY/deaCxg7dVsNgevzTeFKcyldDU5Acize/E2zlXQuXnTSO/NzTc3+XYu0sFiH1MGgJ2FsLnIQSp30z2uYOlq5WWZ76yjSf9RS+bCgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JHcJdh51; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JHcJdh51"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1753228363;
	bh=Zc8MgHe6QBdwnRyd6DJsWvni1K/jzi+7jOEzs1Lx/Gs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JHcJdh51AWZ/80zMfHLocLIFY8OF2rBJk2Me6mugGo0WY0iT7/aVxjzVowdJG5cSw
	 2OvIylu9tdMoG7XSRBTVn3cxO9Ty7gPWDZR1zh1y3YWePzyf2T949vQEIWe6dqqo2h
	 Kw9DWPmHSUM5xVTq5fbeKtgHErdNFXiUdLi379C6Ub0VNbpD8xMnKbwIso9AOd/4LP
	 1otgFABJ6V5Y13hmtQt7DjV9Cj+JEOf62ZckBHAH5oRSzoHR5YW8BBmIKHDmsagjRE
	 aj6cbxYNP/pVAyV9xRI0LfkmmqR7ooF1Z3s+zRENMun71iKjvGXyFi52a+GOOExPw7
	 RYEVYVnW1cKdHCr0yPoatLogFtyThvJ3bqKVVcjdifvvTZBtZP7OJJcIM4Z/50PjMl
	 APW7LtcMSfcgF/hTM9jYVhWAkwQceP2CsPVzezsYBx0paxpdpe++gVrCLRFdP2DokD
	 IPFbild5t1rfxVo9tJnNLJ7svjW0P/c5LJWj7mofS/MhloKWluq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e00e:6194:ba6a:22b1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 616EF20079;
	Tue, 22 Jul 2025 23:52:43 +0000 (UTC)
Date: Tue, 22 Jul 2025 23:52:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Hommey <mh@glandium.org>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
Message-ID: <aIAkSiPeDy5MLe4N@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Hommey <mh@glandium.org>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
 <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
 <20250722220233.7rdako7zjwyjqlmv@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DKkN+zoV4qFXBTv7"
Content-Disposition: inline
In-Reply-To: <20250722220233.7rdako7zjwyjqlmv@glandium.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--DKkN+zoV4qFXBTv7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-22 at 22:02:33, Mike Hommey wrote:
> On Thu, Jul 17, 2025 at 09:30:43PM +0000, brian m. carlson wrote:
> > I would prefer that we not check in Cargo.lock in Git.  Part of the
> > reason is that it changes across versions and so building with a
> > different version of the toolchain can update the file.
>=20
> That actually doesn't happen unless the file needs to be updated for
> some reason, like Cargo.toml having new dependencies or `cargo update`
> being run.

I've actually seen several cases in my local Rust development where
Cargo wants to update the file despite it not being necessary and
`--locked` simply refusing to work without good cause.  Perhaps those
cases have been fixed, but it has happened in older versions.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--DKkN+zoV4qFXBTv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaIAkSQAKCRB8DEliiIei
gQvkAP0Qm4LoVgS5UJQD5rfhFasb3wPvKEvJLRT0d1vEZVb0ZAD9HMioFK6g3yIN
hRXkpFZm2qhP9vVpfvaSBAJrQtpIGgc=
=pl2t
-----END PGP SIGNATURE-----

--DKkN+zoV4qFXBTv7--
