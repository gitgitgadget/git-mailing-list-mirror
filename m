Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3F44C63
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712525636; cv=none; b=oJ3nJ6T/LUn2t3x3dRBsiEPtMCfdaf2GXRoJUP8sbRBtFFnEQwjzQei50mCN3TnJTXvMgZdQZACTMe/EKTZhrEyIkWwUoLbmwgCXIFV2oS6RUZ6sm0sBU1ejt9h8IN/Nggrn98EcGC6O/eVBOULcJYJa6aWRN+sGgYrvO03RG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712525636; c=relaxed/simple;
	bh=dO8ZnqmKnEb0wi85sqxBI6rdxtJW8XBI9K5njt4EyDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKyIz0VWkWDP6XD+DACc+GwXR157HVXPiIHoSk2fwj0SlGVX97dffHCaoofHxHBmdbEF3eWnHA74avwvUjUDLi6403XCsdOQ8OVpcAkRwdJwiLSNYPxwpa94YOMpKBSY9O9Bn1jRLVrgNfv0knb2jqNCsQyfebvmIdyo57G2ZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tlAasgkS; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tlAasgkS"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2CFE25D4CA;
	Sun,  7 Apr 2024 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712525626;
	bh=dO8ZnqmKnEb0wi85sqxBI6rdxtJW8XBI9K5njt4EyDA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=tlAasgkSd0CmRfnynrKRnaQzhvX2PtbbypKOQKZ/HS1Ow6TSFwobpF7F6R68XnsEk
	 L3YHSxhjKyx+2+U7fu7gTwlqr5PtAJn9LDBaO22xrdWrqfCsMp4fdnYOxuGbqDrK0r
	 uDooRWb/vfQgCIZ3EfZqSh0VdFlI2tGYDyVP26ycWmzEIMczaZDK3v3UJSiciwTiid
	 b8h3kHZIkTkhA/LasnXBuksw3FF2Sxr3Emg43B6LH3HlXlr5CY49sqnSOtU1Lg7qKT
	 zgGhjaS5ZNCrjGvU5SkQIT1uvWvOqWJ9PUzyZ/KKmg1zRdA6A1MO9dkyGv6EjbKmDr
	 JEV1gqewg4svhAu9L07sRpMbHU0RjSAbnzyV47gUfXTmI9buBSUi5Nrgxybb40nM5G
	 hMiOZf1glLm9yRALCLrtDki+1D07r+TbefZXsgb5xvIJdA7kmkHn0QX7nINkNsT4Jp
	 nfQUspSpeYtPepX80GUVl7uf6qHrXhkxO3nExrPSnR0EzAnQ8Vx
Date: Sun, 7 Apr 2024 21:33:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
Message-ID: <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Calvin Wan <calvinwan@google.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeW4gWbS/SpQuSvg"
Content-Disposition: inline
In-Reply-To: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--EeW4gWbS/SpQuSvg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-02 at 14:18:51, Calvin Wan wrote:
> Issues
> ------
> - Symbol name collisions: Since C doesn't have namespacing or other
>   official name mangling mechanisms, all of the symbols inside of the
>   library that aren't static are going to be at risk of colliding with
>   symbols in the external project. This is especially a problem for
>   common symbols like "error()".

Yes, I think this is important.  We'll want to avoid the mistake that
OpenSSL and Perl made by just exporting random symbols or using more
than one namespace.

We'll also need to consider that libgit2 is currently using `git_` and
thus we'll either need to use something different or avoid conflicts.
Perhaps `gitlib_` might be useful.

I might also suggest that we enable symbol versioning on platforms that
support it, which is a nice way to avoid conflicts.

> - Header files: This is actually several related problems:
>   - Git codebase's header files assume that anything that's brought in
>     via <git-compat-util.h> is available; this includes system header
>     files, but also macro definitions, including ones that change how
>     various headers behave. Example: _GNU_SOURCE and
>     _FILE_OFFSET_BITS=3D64 cause headers like <unistd.h> to change
>     behavior; _GNU_SOURCE makes it provide different/additional
>     functionality, and _FILE_OFFSET_BITS=3D64 makes types like `off_t` be
>     64-bit (on some platforms it might be 32-bit without this define).

I should point out that _FILE_OFFSET_BITS=3D64 is effectively standard
these days.  Nobody wants their files limited to 2 GiB.

> - Tolerant. The header files probably won't be the first/only #include
>   in the external project's translation unit, and they should still
>   work. This means not using types like `off_t` or `struct stat` in the
>   interfaces provided, since their sizes are dependent on the execution
>   environment (what's been included, #defines, CFLAGS, etc.)

Sure.  If we need a file size type, it should be something like
`int64_t` or `uint64_t` and not `off_t`.

> - Limited Platform Compatibility. The external interfaces are able to
>   assume that <stdint.h> and other C99 (or maybe even C11+)
>   functionality exists and use it immediately, without weather balloons
>   or #ifdefs. If some platform requires special handling, that platform
>   isn't supported, at least initially.

I think this is fine.  It's 2024.  We should assume that C11 (a
13-year-old spec) is available and so is POSIX 1003.1-2008 (except for
Windows).  We may want to have a nice `#ifdef __STDC__ < 200112L` (and a
similar check for POSIX) to just produce an `#error` if the system is
too old.

We should therefore also assume that threading is available because
POSIX 1003.1-2008 requires it as part of the base specification (and
Windows obviously also supports it).  Because this is a library, we'll
want to avoid interfaces that are clearly not thread safe and document
the requirements for thread safety (either that the object must be
externally synchronized or that it is internally synchronized).

> - Non-colliding. Symbol names in these external interface headers should
>   have a standard, obvious prefix as a manual namespacing solution.
>   Something like `gitlib_`. (Prior art: cURL uses a `curl_` prefix for
>   externally-visible symbols, libgit2 uses `git_<module_name>_foo`
>   names; for internal symbols, they use `Curl_` and `git_<module>__foo`
>   (with a double underscore), respectively)

Yeah, I think we came up with the same idea.  I do like the
`gitlib_module_foo` approach.

Overall, I read through this and I didn't see anything I obviously
disagreed with.  Everything seemed to be either reasonable or something
I didn't have a strong opinion on.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--EeW4gWbS/SpQuSvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZhMRNgAKCRB8DEliiIei
gftMAP9lWIov7pHttlSFtUH1KSmMAmtDTJU4XQqy8VqVdoeppQD/S4dx6wAz2Hos
2NNMwd6s98JbPjF1wcrD01ck1cERhgk=
=lJh6
-----END PGP SIGNATURE-----

--EeW4gWbS/SpQuSvg--
