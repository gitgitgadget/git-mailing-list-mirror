Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D31E5B68
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771630167; cv=none; b=uAVkcWtKPlIgQaHsYDNijiWRtbwtpW9FMKC9vgxXvXDGQKlDBzGXWrJiJxp0PtbSp3HwhYfnyJvADVvAh+bAoHJdk/4agm0IDYWj1eiXNMJVUrfJc7FRBbYHq/u8H47EwdWY8OSvjPOhw6+fuMrLrYHFZn3RVHB/3THs4R+ze54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771630167; c=relaxed/simple;
	bh=X+MRyGOK3PNWhwTjvSyeDOzbw3urdRj0R6RlQIAKLZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAY0wo9HZTusynkK7tKabrkOMqwwZwtZp5LZtz4/DrNuUr/9sZX4QYintZjl+PHAuLH8/0U0ZSrGC9V/WuJ5JfcP9S/a/n3zrwS8K1tGo34d2KT+zH6XjMBizl0I0NUH+7CwLUn76ssdk08viSBHqxm5Kz6wgSASNlYsrmy32BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XjmFdA0a; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XjmFdA0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1771630158;
	bh=X+MRyGOK3PNWhwTjvSyeDOzbw3urdRj0R6RlQIAKLZ4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XjmFdA0aeIoy602XvCxivdutBeRb7RjCRY+iThBAjVlTzqKmrcn08v1xeyJqArmwg
	 x6176M6wFLIbemGgZSBz8cm/a1S/1m0s/Ke4/4WPxC/17Yhqd/eTgIjuEGCXV+9xoI
	 su4ZTQ8uU+TTaaptAqrYb7aRgDSrnS8zlTP88i9CZMNzDME1wDR4vWObZ1S927f4I+
	 83moWIk1SnLKQ+jlX1qofr3NTS/pGkaFmP27z0qyL7paJbJnCogxrivN/io10PW8m8
	 PXcS21zMQN5Dofdl/hU+bausPEZXttgf3tVSCRi9EGR2WpwoViG88FLkimIHzzfue8
	 6S5JHUn+o4/uG4nMkaJiwELmLuLJ2kI4BhFmIH5Kxrwg7jWjUwvckOUva/DMLuR8Ty
	 uDjG8kcDk4DA2wEI6ilvBjr4IgvgdT+pWaRyL8yjA/EAteiTt/jSC9yq4wcuMt8ICt
	 1C5dxESk+q05gWPvhld1ngWKo1M3MncHS1aeNTAcqWFoKowkNJR
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:175a:ef7c:2354:3e78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D1B7420083;
	Fri, 20 Feb 2026 23:29:18 +0000 (UTC)
Date: Fri, 20 Feb 2026 23:29:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
Message-ID: <aZjuTSopOMvwR4hQ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aarAYtTcXRO4L8xO"
Content-Disposition: inline
In-Reply-To: <20260218222352.55393-1-adrian.ratiu@collabora.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--aarAYtTcXRO4L8xO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-18 at 22:23:44, Adrian Ratiu wrote:
> Hello everyone,
>=20
> v2 addresses all feedback received in v1.
>=20
> This series adds a new feature: the ability to specify commands to run
> for hook events via config entries (including shell commands).
>=20
> So instead of dropping a shell script or a custom program in .git/hooks
> you can now tell git via config files to run a program or shell script
> (can be specified directly in the config) when you run hook "foo".
>=20
> This also means you can setup global hooks to run in multiple repos via
> global configs and there's an option to disable them if necessary.
>=20
> For simplicity, because this series is becoming rather big, hooks are
> still executed sequentially (.jobs =3D=3D 1). Parallel execution is added
> in another patch series.

I'm interested in how you plan to make parallel execution work
gracefully.

We've already established that it's necessary to preserve stdout and
stderr (including wiring them up to the TTY) so as to not break
existing, widely deployed hooks, such as those in Git LFS.  That means
that to get parallel execution where the hooks don't write over each
other's output and fight for the terminal, you'd need to multiplex each
one, including providing a PTY if the appropriate descriptor already has
a terminal, such that the output is at the very least handled line by
line and ideally batched into per-hook chunks.  Is that the plan, or do
you plan to do it differently?

I ask because situations where the hook output is not handled gracefully
and hooks fight over output or where the existence of TTY on a file
descriptor is not preserved will result in bug reports and broken tests
for tools that use Git, which I think we'd all like to avoid.

Of course, that's not in this series, so it may not even be written yet,
but if it's not, then this is something to keep in mind for when it gets
submitted.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--aarAYtTcXRO4L8xO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaZjuTAAKCRB8DEliiIei
gZdSAQDt/GRsvF09uW7R3vg9ZRJ7m5pO70/xlH2PppChM7zBnAD/fQPZ4ZgG+5Un
YW2lRLGFwQpfu5sLUFjSBChNKg0o/wY=
=S1TA
-----END PGP SIGNATURE-----

--aarAYtTcXRO4L8xO--
