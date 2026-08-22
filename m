Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8D3F0AAC
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787414629; cv=none; b=cfL7IHAXHeWxf10SWE9RLlNdvQ3kqROnxeKs7oM75Kdkc+PmMJpRmb3wQZxi4uPETa74mdNkPm5xjXPDLoS9AOugO6EKFMhjiukQShQVwlhPxd0CUu0TT0l71J+LR5T/D7q2uF0QhRNqLcM8+SKmRywn7qIMc8RCLh5cxpVvM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787414629; c=relaxed/simple;
	bh=vCLqMBclHhGt2LS+p7AOX7VjU+Ub0ejjv2SKeGyUhFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM3ibTIMIJdAS+s/4areHJwOQXdzvqFL3LE95oTKxmyRbfay3qHg64dooKFGJsZYXGkHLqNN+LgjByo3tar7Qy9nnIGfT5mGhMEnLlAz+Xj4BvxRb0ibtEsCdfKG6mNG3jM2sBXMzDPCaaZ/rsLXY1FKEiGDMbNd9VK7c9PMrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=c7BTUQrc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="c7BTUQrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1787414616;
	bh=vCLqMBclHhGt2LS+p7AOX7VjU+Ub0ejjv2SKeGyUhFw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=c7BTUQrcPJVegxSw2Kv0XjINVbRf8mSypxLIEnrpYMoVHUNuW/S8y0bSmuN1tBV/K
	 t1BHU+4TRhKm6NJZiJiwwrEmMNulyY+IJgBqyFHaSD0Egx9HgggTg8NZ/MryeALHat
	 fgHc3xbbD2eXDF89VxY4XSVU0nQCkt4d2HBMnRdXd4xsR7td+fQQMxSAeqkyLCfWtR
	 2dEsKA8LMXZsYRelrJRJA9gcU37gUMm2ofnKv4cP7l+VUmQ7Vu2JmRQ7GqylzDAabf
	 C3rWqN4X+VPDSiVQbrCh0lfz+E8jXegcfav6b661FQQuIMHaUhzQyIUvnZXAmMVZjr
	 J8V9bJrVjQJnFYUCdRAPJGlNq5BvyI3n47/odImGC7HAj1BoGhZf0fWY/S+xalsQBI
	 tLVqlwbQ/9WnELdlDszQ6cV1IgdSR5W4FqR/ydNyFud5urRktZP6r3EiyfkZKs1cZw
	 OZDL5LUEnPE5nYCxxjHULOKnswtAtrUqjeEQno3NPaqjtXqxW1Y
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ca36:4c7:5dcd:6322])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5677320101;
	Sat, 22 Aug 2026 16:03:36 +0000 (UTC)
Date: Sat, 22 Aug 2026 16:03:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alexey Samsonov <vonosmas@gmail.com>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
Message-ID: <aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Alexey Samsonov <vonosmas@gmail.com>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Yg24tiwWjkji3vQ"
Content-Disposition: inline
In-Reply-To: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--/Yg24tiwWjkji3vQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-21 at 14:23:20, Alexey Samsonov via GitGitGadget wrote:
> utime() function for setting access/modification time for files (and a
> corresponding <utime.h> header) have been officially removed from POSIX
> starting from POSIX.1-2024. While existing system library implementations
> still provide this function for compatibility reasons, its implementation
> may be removed in the future, or otherwise degrade over time. Some newer
> libc implementations (e.g. LLVM-libc, currently under development) don't
> provide utime() function at all.
>=20
> This PR switches the git codebase to recommended alternative: utimensat()
> POSIX function (which supports nanosecond-level precision) from <fcntl.h>,
> and, as a possible fallback for older systems compatibility, utimes()
> function from <sys/stat.h>. It also provides the corresponding MinGW
> wrapper.

I seem to remember that we cannot use the *at functions because of
Windows and the fact that it doesn't offer the proper semantics.  I'm
curious as to how you did this, but I didn't read the series because of
the below.

> The alternative is to unconditionally use utimes() where possible, but gi=
ven
> that utimensat is available in glibc starting from 2007, and on BSD syste=
ms
> since 2012 or so, it makes sense to use the newer variant by default.
>=20
> No behavior changes is intended or expected (except for Git explicitly
> passing nanosecond-precision timestamps to kernel, where previously only
> second-level precision was used).
>=20
> This change is generated by Gemini Flash from Antigravity, but all the co=
de
> has been manually verified by me, and, where applicable, adjusted to match
> the existing behavior as closely as possible.

Unfortunately, I don't think that's allowed.  From SubmittingPatches[0]:

    The Developer's Certificate of Origin requires contributors to certify
    that they know the origin of their contributions to the project and
    that they have the right to submit it under the project's license.
    It's not yet clear that this can be legally satisfied when submitting
    significant amount of content that has been generated by AI tools.

I therefore haven't read this series to avoid being influenced by code
we're not allowed to include.

[0] https://git-scm.com/docs/SubmittingPatches#ai
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/Yg24tiwWjkji3vQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqJyFYJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1TRp7kvbASYvcE7IL8Mu37CgYqN/qdriASaCNTJrWCe
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKwNAP9E4ps4Lsk8Lf9+UYnX2piVzEpr
ENB3mzIzkaXvtaPNOwEAk5vrB0VLqhfsoyoBPGBmXg46zy8ZED4CDvTiowmSrAU=
=xVcf
-----END PGP SIGNATURE-----

--/Yg24tiwWjkji3vQ--
