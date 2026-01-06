Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDAC189BB6
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741783; cv=none; b=FgO/KxPgBiYuMKdLCu47bpPlKMWzBVtuu7xp+wm3M3+Yly7lzMFqhhZyJ2G1zsdzDcK/4eno9CTCgWt+8lTuq3OVbs7heVeRzNKVP1FH8rmwj7VIECW4bPf3ytqB+0dH4hQ+V0u2ivGXnYjRN4vEP8ELOu3ZOsKTMDAYZx/FXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741783; c=relaxed/simple;
	bh=SrIXtYMtc+cukW+qztrLKCaOwXewXeiFc4fcNOAz3dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOgkfM5gheJo3hbnNfq02rDopvXUuFSAvYMovtnTYaaVeSLB4mi8Fx6E+RMxKR35ci+BgpygMfTlB6MbDdMJWU1waByEbPW4U31oLbdeOTQukC69qnV5eZ9iccUknf/RgZMAGRiaSDUrpH+Lk9jFtCMol2BRwiBk0zsgC6EI0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0QAfgpWz; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0QAfgpWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767741773;
	bh=SrIXtYMtc+cukW+qztrLKCaOwXewXeiFc4fcNOAz3dU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0QAfgpWz+SMGSI3ut5Q/kcG0nBLTjfZ/VG1vg1JrEtN3ZYAzIeRw9Ja0oJIItdrdo
	 K1VXxIey9fBzfltJVeRvBrIhJDXaX0RIlChZih+ntSjpwQ7moe17Y/jEd/GHyByXcj
	 wzXx+OY07fBi0TnSveozs1DY26nDezHNE5hQnsjSPTMZruOVgbVHnPn04qjoXS8MS8
	 mdlPQZwpVichwOjQQdjsmrs1023kIScIZGdanIYkQUjjN0OOVyyd+Hlp/uIyNHsWa4
	 DRs9zNXMSR76EepBXL9QJqwwjXyEpFgDV0Mh5PjbggQSc0xS9GcHqmcLiqJSfXplzA
	 y5AFi/3tgyKEbgmowSMmdLQrjhbOYETtdfQjltMHZL8LkFK9tSpMnOij7v3Ks6sOJn
	 2Mscy3EXWQkEGqylsMkzMHE04flPivfoMjz/o+WgmhoozPiXiLg/ptrpPfXQe3jxub
	 I4xec5mjz93tT+bCibBfgCN6xKJLgxYUrKiJuMQ2VoDI8/11JEN
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e55e:3716:cd07:8ce2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 31640200B3;
	Tue,  6 Jan 2026 23:22:53 +0000 (UTC)
Date: Tue, 6 Jan 2026 23:22:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>
Cc: Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
Message-ID: <aV2ZS1lvLivi8xRH@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>,
	Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
 <aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
 <CALH9GrYOjb92gjrtdjwapFH9L73XGg1Kan8uz1aVLpSXNURi+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xLyIB64B0hIxPhAx"
Content-Disposition: inline
In-Reply-To: <CALH9GrYOjb92gjrtdjwapFH9L73XGg1Kan8uz1aVLpSXNURi+Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--xLyIB64B0hIxPhAx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-06 at 20:45:56, Matthieu Beauchamp wrote:
> On Sun, Jan 4, 2026 at 2:40=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Ah, yes, here's the problem.  UTF-16LE is used on Windows, and on
> > Windows, Git stores pathnames as if they were converted into UTF-8, so
> > you do need to write the filenames in UTF-8 in the ignore file.
> >
>=20
> Yes, the conversion from UTF16-LE to UTF-8 would need to be platform
> specific.

We typically don't want platform-specific behaviour in Git.  Many Git
contributors do not work on Windows but we want things to work as much
as possible identically across all platforms because it makes
development easier, as well as making it easier for users to reason
about the project.  I, for one, don't have a Windows system (nor do I
want one) but I do want my Git code to just work there.

As an example, we still use a POSIX shell in aliases and other settings
on Windows despite the fact that PowerShell is built into Windows
because it means that aliases and similar functionality just work
correctly regardless of platform and it allows users to write a config
file that works everywhere.

Instead of trying to force Git to gracefully handle UTF-16 in its config
files, my strong recommendation is to adjust your PowerShell scripts to
use UTF-8 instead[0] or use a POSIX shell.  I'll note that Microsoft's
new Edit text editor[1] defaults to UTF-8 (and, except on Windows, LF
line endings), so I know that Microsoft understands that UTF-8 is the
proper encoding to use on the Internet today.

[0] https://stackoverflow.com/questions/5596982/using-powershell-to-write-a=
-file-in-utf-8-without-the-bom
[1] Available at https://github.com/microsoft/edit and apparently
shipped with Windows.  I will say that I was impressed at its
functionality for a 231 KiB binary footprint.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xLyIB64B0hIxPhAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaV2ZSwAKCRB8DEliiIei
gUlzAQDYx0ZOm5YfsZJjF7HA2G5LDvRIC49ijrnJTbBt2OCMnwEAoAf+rrg7xOFW
+r0BV+wwJ17Lcr8YanCLTixkhAwA+AE=
=v6Lj
-----END PGP SIGNATURE-----

--xLyIB64B0hIxPhAx--
