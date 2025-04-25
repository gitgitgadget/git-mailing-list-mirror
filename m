Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9618DB02
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611986; cv=none; b=fSQ5DBp9Ra81BplxDvIIwLrEmHSh0Gz9X4sXmaN6EiMujMxpPF8i02kaCqcNNS8Th4x9GH5qdDLJS06Dr8vNaHPvQjI95fAOi7DBgJlIKDk5Xm2AR9BlmOmQRAhkXck6eNf/Huu2qh8DS3b3+ZbNkjZix/Q/+JIRhk7thVn9ojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611986; c=relaxed/simple;
	bh=CpZbA7SIQOXPUaGtCtpHwNXMIKP7zCuIo5JR1ce0hCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymt+AGuXGWXDc/AnxW7+1xFZQNCA0/4CDgppauLjlefQQXp0fqQ91cDJ7KOoRbh4Ic0dtSRwbtzWBETzF6qaYhtxTyhhxZkZd4A1qk7yGMXSEHo1HP5io30Yjo7dwQwOXZ5861bLHVVpdHBkK/zwiXcCEInkDW/12pbHnVnLpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Yq1zpFYm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Yq1zpFYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1745611983;
	bh=CpZbA7SIQOXPUaGtCtpHwNXMIKP7zCuIo5JR1ce0hCc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Yq1zpFYmIKDbhLh8WTo8FmWGmOe0QcOoshLWgNVJOzsPe3VXZD4jAdke3TcP0ZBRK
	 +lV8rfONilkPgYjdRjA9Jlw+hGvwjjl954L5/o+nsBZB0+f01XaI0gx6s/3khM51+7
	 vSDPBBBs7W3c8n6mg6i8FU+8RKgKzmKQJnXHx7sd/we9ttnugKPfqBbYuK+OapyhBC
	 WUHSJ2JyvpMe65bN3XNW4lewzlZP6O/rWpk6geIOClqMIXmZg75knGjiw4MiXsVoth
	 zHSOyp36DHvOZZGgU6gE723QR0b/5X3GnMhlNlEeSINhejH7L32lsxK2yQOhzCMJsi
	 gzDE0H3hsaFQjM4/HRbsHmHG601ej2KCZN9H/3W7lRbQ0c4MB8/5kSYJ/VxSmRZ5LM
	 XlvW+OTZrcjGJ+pHDggv1Z/rgeVZaaougd9ZuqgdcsFRsbbcQbJq6iqSYbMih4oMDI
	 NUaXjwIht0Uk/lfAK5ss8lEM8gs+W/ashsbvQkfEWpe5zdn/brL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F183220117;
	Fri, 25 Apr 2025 20:13:02 +0000 (UTC)
Date: Fri, 25 Apr 2025 20:13:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
Message-ID: <aAvszaVi1TGxP56N@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Justin Tobler <jltobler@gmail.com>
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fnQ8Dx/07KY9/Smg"
Content-Disposition: inline
In-Reply-To: <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--fnQ8Dx/07KY9/Smg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-25 at 14:11:29, Patrick Steinhardt wrote:
> Meson detects the path of the target shell via `find_program("sh")`,
> which essentially does a lookup via `PATH`. This may easily lead to a
> subtly-broken Git distribution when the build host has its shell in a
> location that the target host doesn't know about.
>=20
> Fix the issue by appending "/bin" to the custom program path, which
> causes us to prefer "/bin/sh" over a `PATH`-based lookup. While
> "/bin/sh" isn't standardized, this path tends to work alright on Linux
> and BSD distributions. Furthermore, "/bin/sh" is also the path we pick
> in our Makefile by default, which further demonstrates that this shell
> fulfills our needs.

I think this description is much better, thanks.  I agree that choosing
`/bin/sh` is the right thing to do on Linux and the BSDs, even on
usr-merged systems (where `/bin` is always a symlink to `/usr/bin`).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--fnQ8Dx/07KY9/Smg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgL7M0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ02ng20ceyaFTvY33odBBOGU3xFuXaAAH55+4+lo25/m
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAA7LAP9pARosI2oGfqu2VEFNNUxuMBQE
vv8w5WR53uwpCKf29QD8C/o9e+CcZvO8TKcptvXCBh7p9+w2DZkOxbF/NDtx7ww=
=iFNK
-----END PGP SIGNATURE-----

--fnQ8Dx/07KY9/Smg--
