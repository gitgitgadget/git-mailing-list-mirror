Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C75219315
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743548297; cv=none; b=Ea5qRlPWqslwaVRF9/5OwvFKbn3k5rKkJ8Yh+Nd5i1TN50ScM+lx0PPO4oVM9snNTQc/iLnKZ6CLmbaRrq8qKrc9T+B77jbRMjXblUpv4Q0eIf3jCNZgWCjxIJW2SKR+1rhHTvRaGOt8pXIwONo1sFBQSGttZDhhK9hXGzrsFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743548297; c=relaxed/simple;
	bh=PgxsIefYUAieq0immYk2ChqYB8ynIapVYCIB96COdB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8Nv6NSXylo9Frm0nCdnbH9hkqNdydLmAYQxvW+Q+j+rV3N63YaSNwzlzyr7QeRCSyDHW9LwaXn0BCPsdjjPmK3YpX4YLPpA3ebLFkKQB0j/UmDGM8vrVu+I4IauXFZVMfPPypBCn/fTbuCGjcjbJ2XcYJf/BlQEM4ZbU2znwFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=N7iVufbV; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N7iVufbV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743548288;
	bh=PgxsIefYUAieq0immYk2ChqYB8ynIapVYCIB96COdB0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=N7iVufbVzvYOvZCVJHtqpMFGjY9vAND/AoFUOddtFmm5q6BXBAAWYzLq+oYEQUEJF
	 30hI9wGHujTw/+7smOlgYeg/IeksNavEJw3GrLbqtGgI0ebz3D8mK3/PrvUuhydgiT
	 wA6k6uFIxo+LJrSK8ydHH2zlEv2brgK9drR7gljODkk/HokqNwVFnRf5d4K6j2+3CI
	 6DJHyMKrMOP5FArPO/PvwI6Clg+zTyryAZRIvFl5cLzIJ/8+Zq9uOqEHeGxgw4HLl0
	 mwPhowN5h/IF+5rdTMPItXZfbZEKoBUnI5jUG0qVPoP+HkKYByZDgIkBi7ogtuyfsj
	 xQgrm/ccCX7Xb005f82s38OliiLZXh4MlmwVlWyxNmNE2+k9skxCCjozb02ko5O/gN
	 EFv60YB78YB9YE9D1lwfeT0IcSk39NumL6dxdk0Wq16TM7sIDoEkk2ROkVCKmk8DY9
	 6ULvV7XL/mZweC4V0CIVFYElU6x5ppGISzYCpWhdsw8nnmB2Vsz
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0112A200BE;
	Tue,  1 Apr 2025 22:58:07 +0000 (UTC)
Date: Tue, 1 Apr 2025 22:58:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: --reset-author does not reset author date when used in
 post-commit hook
Message-ID: <Z-xvfqCsQnDIGaXx@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Devste Devste <devstemail@gmail.com>, git@vger.kernel.org
References: <CANM0SV2huiGtWMcP+eEkNBHoieeoXmy_fM7vAOwyoW4=FXw1pg@mail.gmail.com>
 <Z-s2p-ak-KpU6uaX@tapette.crustytoothpaste.net>
 <CANM0SV0Np+52vjoopvAJ88U3Ue0EF35iarwBpOozrBH9KbH2Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BD39GR/WxKqR3NqK"
Content-Disposition: inline
In-Reply-To: <CANM0SV0Np+52vjoopvAJ88U3Ue0EF35iarwBpOozrBH9KbH2Uw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--BD39GR/WxKqR3NqK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-01 at 03:44:17, Devste Devste wrote:
> >your call to `git commit` will still invoke the
> `prepare-commit-msg` (and possibly `commit-msg`) hook
>=20
> Since I used --no-edit --no-verify in the example/hook, that shouldn't
> be the case though?

My testing demonstrates that `commit-msg` is skipped with `--no-edit
--no-verify`, but not `prepare-commit-msg`.

> >such as by using an alias that sets `TZ=3DUTC0` to commit.
>=20
> Unfortunately, (at least on Windows) most tools and IDEs don't even
> load a bashrc file (e.g. intellij) for their git UI, so that's not an
> option (and setting the TZ as a global environment variable has
> unwanted side effects, since it will set the timezone in various
> applications randomly, e.g. Electron/Slack will use the TZ for some
> but not for other things,...)

What I could recommend instead is setting a shell script or PowerShell
file or such as the default Git binary (instead of git.exe) and setting
`TZ=3DUTC0` in that script (possibly only if the command is `commit` or
`commit-tree`).  I use Neovim with the fugitive extension, and
it provides functionality to override the Git executable, so I suspect
other editors will as well.  This is something that will likely be
robust and unlikely to break.

The reason I make that recommendation is that I suspect you're going to
find that there are other infelicities or weird edge cases in what
you're doing and this would be a use case that I could see getting
broken accidentally.  We've accidentally broken people doing `git add`
in `pre-commit` hooks (which we also don't recommend) in the past, for
instance.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--BD39GR/WxKqR3NqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+xvfgAKCRB8DEliiIei
gSydAQDcwOQM0N9aNUVWDlQeAfoqKUyhunQSfQUzMhXRW6nQ3QD/TnKBMFRRDIl7
rlxfSYnQOX9sRBbbmnmOqU594MaoBwc=
=NRWB
-----END PGP SIGNATURE-----

--BD39GR/WxKqR3NqK--
