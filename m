Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E224689
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742084912; cv=none; b=bbMJAtOPexGbHRmNYDznaUadQFbKlzpU62thv8/wgRnUFCtxkk2Ry4/LF9vC1yKuvFRX+thCRsw8O8k9BMGTiLocwfCu9qbarzembIaMi0ljCS2QWwaQPRvuUypdIr0C5DgivYenWca7nWvNlAmvp0NmQVPxdgIbCVTczVMYWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742084912; c=relaxed/simple;
	bh=NRLBOG2DgjQ2hFHDDJW5ghNUrsquopjUq5sajyBAyOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eblJxvU1FDLSjoQz3IuVCDr6n1wlspo+XtVtx3Itl6xhbJutJqNrW2RXz7zJ3ufPw65APCONKcHWPCz5D/drAtCY+S+Hf1Qhow+pcMrDacuyDL+WmFBswwh8BwCn/yl5EoN0nmw1drDFyujQokdORgPgIHk+MlnD8D5rtGac/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=P3tdTAEF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="P3tdTAEF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742084901;
	bh=NRLBOG2DgjQ2hFHDDJW5ghNUrsquopjUq5sajyBAyOM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=P3tdTAEF1UBabMfo2AlHVXshOS+H+vFxrDqSlFNABfxapDxzaxKUxI14Us8pchfX2
	 2lRALbsMxoBL380GFPnNitn53/u3DHTy3WSDLJzGZggUrWeEfpreffFfiEaVtn0VZ1
	 iw0cYpUFnf2thZ3moCSpb+X5G9rZLTWzIeg0WwLV6nBZO/Pryk8gHIdaAT85QMmNNu
	 TV1Fq1rX2MZXOCs7qk/CzQJTbVNtaYV/pJSvTEC0kJ0UFaXnEz7ZVmjQpqq/Sp0FYc
	 +E6PM2WsXL9rTTlonlEiGbnAgXzGUsGhohMmnapxH5GYFfEPBF4cKmtuIAlhbDUtfI
	 kYMJgOKTz/VQe0sDtc6rnDkY3aDitxDaEOK3si/OAZ5KHsYIAD2P9iY1ZBal3/Ijr7
	 39Bp151WpB9N9Th7qmk5CA8H5jN+HgeJMmWhJkznLhPIR6PW0J7oimtgKcgoAfz8ii
	 K4PmnbB9MP/rTyd4p6PbNLWtDy7WJZjQicvlWSP2ItbvwDJfTsp
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 95303200B7;
	Sun, 16 Mar 2025 00:28:21 +0000 (UTC)
Date: Sun, 16 Mar 2025 00:28:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
Message-ID: <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <git@dinwoodie.org>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BTPnoUmH0A9p2kPD"
Content-Disposition: inline
In-Reply-To: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--BTPnoUmH0A9p2kPD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-15 at 02:49:18, Ramsay Jones wrote:
>=20
> Commit 05cd988dce ("wrapper: add a helper to generate numbers from a
> CSPRNG", 2022-01-17) added a csprng_bytes() function which used one
> of several interfaces to provide a source of cryptographically secure
> pseudorandom numbers. The CSPRNG_METHOD make variable was provided to
> determine the choice of available 'backends' for the source of random
> bytes.
>=20
> Commit 05cd988dce did not set CSPRNG_METHOD in the Linux section of
> the config.mak.uname file, so it defaults to using '/dev/urandom' as
> the source of random bytes. The 'backend' values which could be used
> on Linux, in order of preference, are 'arc4random', 'getrandom' or
> 'getentropy' ('openssl' is an option, but seems to be discouraged).
>=20
> The arc4random routines (ar4random_buf() is the one actually used) were
> added to glibc in version 2.36, while both getrandom() and getentropy()
> were included in 2.25. So, some of the more up-to-date distributions of
> Linux (eg Debian 12, Ubuntu 24.04) would be able to use the preferred
> 'arc4random' setting.
>=20
> If the meson build system is used on a newer platform, then they will be
> configured to use 'arc4random', whereas the make build will currently
> default to using '/dev/urandom'. Add a note to the config.mak.uname file,
> in the Linux section, to prompt make users to override CSPRNG_METHOD in
> the config.mak file, if appropriate.

arc4random operates differently on Linux than it does on the BSDs, and
the right choice on Linux is `getrandom`.

The reason is that on the BSDs, a userspace ChaCha20 which is seeded
=66rom the kernel is used, along with an integer representing whether it's
inititalize, and this state is stored in a page that is zeroed on fork,
so that it automatically becomes uninitialized then (and is hence
reseeded).  Because it is in userspace, it avoids the overhead of a
syscall, and is thus usually faster.  arc4random has also been around
longer than getrandom or getentropy on the BSDs and is widely supported
there, and so it's generally the right choice (and hence, the default).

When arc4random was added to glibc, the Linux kernel CSPRNG maintainer
argued that it was not a secure approach (I disagree), and convinced the
glibc maintainers to just make it a wrapper around the Linux kernel
CSPRNG, which it now is.  So there's no actual benefit to calling
arc4random versus getrandom, and since it's newer and less commonly
available than getrandom, as well as slightly slower (because of an
extra function call), getrandom should be preferred.

All Linux distros within our current support window have glibc 2.25 or
newer (RHEL 8 being the oldest one), so we may want to just default to
getrandom on Linux.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--BTPnoUmH0A9p2kPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9YbJAAKCRB8DEliiIei
gZFDAQDDHUqknhGyIIzGTWUchBnOjsYgAK11p+3bImpg7L9dXwD9EiTOqbs6rL/2
9kOjidp1v3T39vP8ndZWbpmmOlwDXwo=
=hdI+
-----END PGP SIGNATURE-----

--BTPnoUmH0A9p2kPD--
