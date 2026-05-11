Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10C35675A
	for <git@vger.kernel.org>; Mon, 11 May 2026 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539092; cv=none; b=lwB9Tvi4ARrBQIEN3jDzccbjiXoT3YdGp0V9iBV2ieTkB8MEf4RRnZjqR2IJhnh/P2X5QPAWdlJyusXe6Tn/IyIKAUkBg1fIDOUZ8O74OkPUTrBj/vVri4lRTyDfcUW01maH9ENXdDC0rC8witZKI1UiiE53oawGWhiUBgFooTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539092; c=relaxed/simple;
	bh=TTOoeuPQHcbSwZNwKekys6413SNGDnK65EsO96W9HLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYDOKiXWMD08odxPgq25WKk43orx33/pbvWx4YYTevVtpt23gAtQEw56NZuB95QVfQnmv87JIn8ruPK/DKxr/ROugOGbd3qqFpsplP73SlL11dpKiBZ/BJhMgd5hQhFWCFqQ2IhQz+wYMV2idyab6V3BbLhlqeev1mE1spYjuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DYMWvq0S; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DYMWvq0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1778539084;
	bh=TTOoeuPQHcbSwZNwKekys6413SNGDnK65EsO96W9HLI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DYMWvq0SgZ9YZyVTtJywQMah4VfmwNavTkkYexTGLjoDdlN6r5wAl87a1YYmX0kPU
	 jyPPntmZvGaohrlZuWJzDhuCbRG7RdjfcFYUXVXZhTQxn5howlW+lB9lWRc0RX1S+b
	 lfQSVtKFMGLMtY+SoJX2qmQiEr/NUSXyR+zf9iAcUasDNngqgq81OWduho9WGswBQY
	 R0svEQyhjLnlkf1tG00/3ostKErgONfkdokSpjpxw60SuEWY7MjIaSyO/C9Zc5wrDG
	 fOS6JFZwUtPgmq2sZgRUrBna3SHzOFc7TtHNK5DSjIkruD3gsXd0rCQE+gDoDT3x02
	 9Ud0ppoMfPxcZTcwvUiwm7IhN09WKU9rXEDDMdPucaj0icrlalEKUlsAAc1iiBDSi0
	 AYbivWN5fvyiN6sGfAkGURIqdTk5sJErhzplg1uaRfh4Qxw8DK/5/DarnfG7KSSBlO
	 bB4lg+U/IEKoGMqL0+uK9sP1QRr97ii3n2PM2MSky0c2ox3y7Q9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d69b:5cc5:c796:2ef2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A8759200D8;
	Mon, 11 May 2026 22:38:04 +0000 (UTC)
Date: Mon, 11 May 2026 22:38:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Thorsten Glaser <tglaser@b1-systems.de>
Cc: git@vger.kernel.org
Subject: Re: git hard-codes use of /bin/sh for aliases
Message-ID: <agJaS0xuMaLm6UZv@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Thorsten Glaser <tglaser@b1-systems.de>, git@vger.kernel.org
References: <6791cb26-16af-dcda-1dae-82b85da6fb0f@b1-systems.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J7Z3H+DzNCFQysLH"
Content-Disposition: inline
In-Reply-To: <6791cb26-16af-dcda-1dae-82b85da6fb0f@b1-systems.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--J7Z3H+DzNCFQysLH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-11 at 21:13:18, Thorsten Glaser wrote:
> Hi,
>=20
> git aliases don=E2=80=99t use the user=E2=80=99s shell but a hardcoded /b=
in/sh,
> and this cannot be made configurable.
>=20
> This, unfortunately, breaks quite some aliases and they cannot
> be made portable by adding something like core.sh =3D /bin/mksh
> to the .gitconfig.
>=20
> I=E2=80=99d love if this could be made configurable.

Yes, I believe they use `/bin/sh`, except on Windows, where they may
look up things in the PATH.  It is very much intentional that they use
sh because it means that aliases work in a consistent way across
platforms and that they work at all.

On Linux, I have mksh, but my work machine on macOS does not, so
specifying `core.sh =3D /bin/mksh` would not work on all my systems.  If
you have system-level aliases as well as user-level aliases, then you
need to pick a particular shell and letting the user choose will likely
break the system-level aliases.  This is not a hypothetical: my last
company shipped system-level aliases on development VMs while users were
free to customize their user-level aliases (and shell).

This will absolutely be a problem on Windows, where you have CMD,
multiple versions of PowerShell, and bash, all with different syntax.
Some versions of PowerShell also corrupt non-Unicode data sent through
pipelines as well, which means they're effectively useless for
general-purpose scripting.

It can also lead to odd behaviour on some shells because, for instance,
zsh runs a config file with `-c`, `.zshenv`, that can make the shell
very much less POSIX compliant, so behaviour can differ substantially
=66rom sh.

I'll also note that Git doesn't handle aliases specially.  Git has a
with-shell and a without-shell mode for running commands, and we use the
former for aliases.  We definitely do not want the with-shell mode to
generically allow arbitrary shells because we cannot handle non-POSIX
shells and will not quote correctly for them (almost certainly leading
to security vulnerabilities).  We also format the shell command as "%s
\"$@\"", which also basically requires a POSIX shell to work, and we
don't want to work around people's use of non-POSIX shells; that way
madness lies.

However, because mksh is POSIXy, you could build Git on your system with
`SHELL_PATH=3D/bin/mksh`, which would use `/bin/mksh` everywhere that the
shell is invoked.  That feature exists primarily for systems where `sh`
is not POSIXy or doesn't support `local` (which I know mksh does), but
there's no reason you can't use it yourself.

There has been some discussion about this issue in the past (in the
context of PowerShell) at
https://lore.kernel.org/git/CAAXzdLXt4+-34+OhS=3DJn=3D-VeORN3Y2jMzzg9+bhyn8=
8aN4hm0A@mail.gmail.com/ .
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--J7Z3H+DzNCFQysLH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmoCWkoJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzm9I6UE0jqFm7N20u64IQpsYhEp9DxbJNPOg8rA+2HI
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHZpAP9/oFRMbcpCWgj1xwWswofpZHc5
fHy0WzV5ZwdstP44YAD+KsOq6wTyGWRYbXsZ46Fs5ku9hVtGjEqEt4kJzpzFYA4=
=exxG
-----END PGP SIGNATURE-----

--J7Z3H+DzNCFQysLH--
