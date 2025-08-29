Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58526BA4A
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497643; cv=none; b=dhH25+ZFD8+9hRrGA1gv1HO/fuEs5Cd+1IjNS4hGfl5HkfZ/Aynjd8vGmtpqwOLnkBa2IBANSK8mvfU0yhx+Y2qm2pXQuDNAq9m6lN1Ny9q/ICTqJO/UGXDzoAELYMcGFUvhDgmtuK+N93vWbsGYxfag2nIZCdSHJqsk6cL249o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497643; c=relaxed/simple;
	bh=MaA5c7eUBl/z0MRziDYBvLi7fA/xTNuBefeTZDsH7rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOqwtOTEj+y5Ut+s7oCxLmk6qCI7/KwexCY2gcEaQ1Rz1VamON11bKOy5jaPPKw7P0BEweewK9CpJaHKatWbji8IA5Hu5/Ylp0sICFA4K02vfKBzNn3/oXYNcuFX0Dr/7CL/nYd60ANnlErQzspHXve+l9BjW0UKayRgaIlKBuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RU4eRPkY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RU4eRPkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756497639;
	bh=MaA5c7eUBl/z0MRziDYBvLi7fA/xTNuBefeTZDsH7rQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RU4eRPkYqa35Q01P/d3VHcOcznu8jvFd/c1hV+TOco7nAmBNLQSvl2Sxj2smC7J/a
	 ivn2mL2Z9eW68Jq9mjcxibgzi8pTC8N58PUOtZtyJQ8Uch1DUAIS5VO/dYu3VUOZTZ
	 xqQFtFmhkXI5OOYqNDOIJ2TEoKebIdsg4/rBzeB8Vp4IGuz8FKMa3ntC0HRM5VQnPY
	 2vwbQj0K0CTmeRY2jJbi1KrxskyqGAMDUfWk7AzF5ZyByumgkOAgODRV2zzynlAPy5
	 pkFJMYcNo/pr4eVhG13tHJ8+RgtdxevIvum8V+ynmDZVoqXTiasjMUIvi/La7kr4W8
	 +0cqCVpvrKRCX5xJbt7CQbLkW1du5d2540ccQL7QHHQbpspgF0ejHbocOcGo6CLEv8
	 NN2GEwiAiQdGxNivGqD/0tYWu2uIi5Ewyu5b4irKqcpfuGLFdwb4BQ+xnhXqhm496D
	 /3nwC61JpVnNN/infNJcmBDj+Z9fZMiT79A7AzdpGdNcV0az1ec
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4f12:8b88:bfed:e81a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 32E64200BC;
	Fri, 29 Aug 2025 20:00:39 +0000 (UTC)
Date: Fri, 29 Aug 2025 20:00:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 01/15] doc: add a policy for using Rust
Message-ID: <aLIG5bLOisbxfn1y@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y2e+oeHIs+evgJpu"
Content-Disposition: inline
In-Reply-To: <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--y2e+oeHIs+evgJpu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-29 at 19:42:05, brian m. carlson via GitGitGadget wrote:
> +Crates like libc or rustix define types like c_long, but in ways that ar=
e not
> +safe across platforms.
> +From https://docs.rs/rustix/latest/rustix/ffi/type.c_long.html:
> +
> +    This type will always be i32 or i64.  Most notably, many Linux-based
> +    systems assume an i64, but Windows assumes i32.  The C standard tech=
nically
> +    only requires that this type be a signed integer that is at least 32=
 bits
> +    and at least the size of an int, although in practice, no system wou=
ld
> +    have a long that is neither an i32 nor i64.
> +
> +Also, note that other locations, such as
> +https://docs.rs/libc/latest/libc/type.c_long.html, just hardcode c_long =
as i64
> +even though C may mean i32 on some platforms.
> +
> +As such, using the c_long type would give us portability issues, and
> +perpetuate some of the bugs git has faced across platforms.  Avoid using=
 C's
> +types (long, unsigned, char, etc.), and switch to unambiguous types (e.g=
=2E i32
> +or i64) before trying to make C and Rust interoperate.

This makes sense.  I agree fixed-size types are better and less brittle.

> +Crates like libc and rustix may have also traditionally aided interopera=
bility
> +with older versions of Rust (e.g.  when worrying about stat[64] system c=
alls),
> +but the Rust standard library in newer versions of Rust handle these con=
cerns
> +in a platform agnostic way.  There may arise cases where we need to cons=
ider
> +these crates, but for now we omit them.

I'm fine with omitting them for now.  However, we may very well need
them in the future.

> +Tools like bindgen and cbindgen create C-styled unsafe Rust code rather =
than
> +idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.  =
Any
> +standard C library functions that are needed can be manually wrapped on =
the
> +Rust side.

I agree that we want to use idiomatic Rust whenever possible.  However,
I don't want to define structures and function definitions in both
languages and rely on people keeping them in sync, since that's a great
way to create brittle, broken code.  Very notably, I have seen these
kinds of misalignments break only on big-endian architectures, which
most of us do not use, so we can really end up causing problems that are
very subtle this way.

I would prefer we wrote these functions with cbindgen to avoid this.  If
we define structures only in Rust and never ever use C structures, then
we can avoid bindgen.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--y2e+oeHIs+evgJpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLIG5QAKCRB8DEliiIei
gdvZAQDur4QLd8QT9zEYHJfiLfI9j8PC1GOBun6OnqyAwKq+gAD/WI+wXETSKBvz
zCH62lKKVsARIFttsh2CbnMR0v/SDQ0=
=Kmfe
-----END PGP SIGNATURE-----

--y2e+oeHIs+evgJpu--
