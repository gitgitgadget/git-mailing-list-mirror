Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D858AD0
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256465; cv=none; b=RqA9Rn40Crky3bWEH+3EdSOp/e5ls9RhOGE+NHiRgybI1HuolED72jfQeIla6JdLdaC0B/YSF2GTnUafei16AWZCjFmW3vkl248eNov+WmrB/ugToSne4Ufr1dBLLdScYkibUSLJYH71wFELBO39ElN5zzn9xcSusFPi4APe1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256465; c=relaxed/simple;
	bh=vyWNbmxQhN7ekXe58MZlkjsdkHkqwcD37fmKbORCJMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkGM4rkBWnZ88Ih+qaP31N1ZS2QkJdMZIjR4T7kp4YTbB2JfsNQcUkD1VfgDEXxIsTn80BlgwpUBxez+X1f01/Nnq39boCMVO80eCJYg++gCUIcIb09vzZDmyueyZ9BCWx3y0ziKpJgRzlNw7p8m0LRiMqG6HEg3rU8KSDNmOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=M8wsHBPF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="M8wsHBPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721256455;
	bh=vyWNbmxQhN7ekXe58MZlkjsdkHkqwcD37fmKbORCJMc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=M8wsHBPFr8UXBOd7PTTxFNWABYBCbWuNFU8qBchtjolNHTE6wZ0bPXujVyGNxL+I1
	 GVizSCmSZUvyaSdZ7Hj2zShOvBWIGSsCx3u9GdPzImZi7M+mjgYRRMxBfpYdNKXovZ
	 FgNmIsjmDMK3EFVXBpmDROou2rbG8G63SdI/rpInFjO4TPw/aEYisA1LcqIRDbRZKL
	 XS4cSxPqoKfY6dxJ929mTKdvQf5dkl7czGPDLs0mCW7YCN/XlUcFm8vvsuwsoxyenW
	 acJAVuDWZpW9qGFmMlENTilYdUY/qE7RORUP+wVmu/FTJwJxCaabmjukmDyAYG0j39
	 kbE+W3O5QxZIKxUpOEUL5It2QZAkKi5Am507Nayb193BnMNyl5rI4EEO+w/dyufNTh
	 LtOUwq6etOFZKMw++410SFIR9B/rycaOKshmpRd2QbF28L3cXznQ37sdvn/xMV9A51
	 /hCzgOzcdBwFfk6lhvhWIm7ko9nUWkRWGa8leFD0G1TWNLO4ACr
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:d026:90f3:853d:a63c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B1A10209B0;
	Wed, 17 Jul 2024 22:47:35 +0000 (UTC)
Date: Wed, 17 Jul 2024 22:47:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
Message-ID: <ZphKBe5gmWKJnrqm@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
 <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="riP9uXlyAMl99ynS"
Content-Disposition: inline
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--riP9uXlyAMl99ynS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-13 at 21:08:17, Johannes Schindelin via GitGitGadget wrote:
> Changes since v2:
>=20
>  * Now fspathncmp() is overridden on Windows just like fspathcmp().
>  * The win32_fspath*cmp() functions now respect core.ignoreCase.
>=20
> Changes since v1:
>=20
>  * This patch series now shares the logic that determines the path of the
>    Unix shell that Git uses between prepare_shell_cmd() and git var
>    GIT_SHELL_PATH.
>=20
> Johannes Schindelin (7):
>   run-command: refactor getting the Unix shell path into its own
>     function
>   strvec: declare the `strvec_push_nodup()` function globally
>   win32: override `fspathcmp()` with a directory separator-aware version
>   mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
>   run-command(win32): resolve the path to the Unix shell early
>   run-command: declare the `git_shell_path()` function globally
>   var(win32): do report the GIT_SHELL_PATH that is actually used

This series seems reasonable to me as well.  I of course can't speak to
whether the approach for finding sh is the right one, since I'm not a
Windows developer, but I have confidence you know the answer and have
thought through it fully.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--riP9uXlyAMl99ynS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZphKBQAKCRB8DEliiIei
gZyRAQCbACUlhrl/M6PWnixE2w/h+8q2JBkZJDr88v7TI+iwmAD9GFl+myY5sIom
ozZ1UqEGxLB9jN0LY+IY+RPIC09ibAk=
=YucX
-----END PGP SIGNATURE-----

--riP9uXlyAMl99ynS--
