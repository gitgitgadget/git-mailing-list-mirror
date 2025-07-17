Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60B1A2541
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794000; cv=none; b=NOuJen49aBRVonZSFz5joOkqxMmrLcFrhUAv1BJtmtXoFan8ho88YlkxXB1X1U1v4DMfthlxy9RTCxU35RYigQxBaboTxzk1cxB7Xo9X0sP6tFpLmbEkhZiVj5GpibMTa/kAUV1JD5C68OsFkuFev50Kvamyl5ZjKiwGv44IuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794000; c=relaxed/simple;
	bh=5nEenwYxQ1P8feHL64LRdzjxprGJPTl67gB3SZj1WpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCFh5TuhD12rKE53v8B5FQP7kbUH7OQ/hSHy38UfcJf7ebBoWfVv5TY6d7z8YvZpupHmdXENeVpVSWsHZKMGmhmvvKrKBBVx+BzPCMSUygiG3Evk3SwChZGKjOUAy3X9Grf1wiFHB2Kv06O7lmfOgfTypCygrrho+jd4DzUI+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Lr/Nu43z; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Lr/Nu43z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752793996;
	bh=5nEenwYxQ1P8feHL64LRdzjxprGJPTl67gB3SZj1WpU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Lr/Nu43zYJS/C77pSlLSZyxtuah1S6nSmN8SnNNnUgD0kG+ZgTixRhrFvM2noKXM8
	 JT1l1cIJBF5Hw0X0bmCXRzV2MIgly1OM8LC/bOp0fXGaz1DvAN8+c1hQCUW6rAzsDI
	 F/Zvh8J5U68+Wc94KD1K65JknnQsRdQ11ojJjdOBSPWu0hEdfmXSMzmxgk/ja2gy4O
	 Yd+7WS0AB1WlMJx0DrSSBksGnIV5S/fSf6t3KfhWeAthy7R9Jn319s/yDPuy4/yvUy
	 HjVRtTZNVbZq/LDrD13jmCjDFImTtqeXMmL9tgXA65AcbkVK6pglHNoVTdmMpa09Ng
	 6xDHVeZ1iuttjCJc2qAJJxajb6e7cwk/k5vktQvJJyqLgI6d+mL67PbLWBIkRyo17X
	 VzPfFiWi4/JNcBWQt/E+QMQ+BjrxSrpN9Cs+2gZm0p+q8jIkDemC4yYVZzrwzO2wPB
	 3V2U7jp44GH1CcCm7jx6KHDcse71d5Uj83Xu3ymQilVtmIFCMuQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c351:2fb1:6e4f:b4fb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 01CDA2007E;
	Thu, 17 Jul 2025 23:13:15 +0000 (UTC)
Date: Thu, 17 Jul 2025 23:13:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
Message-ID: <aHmDiqsBsDJJ6m8C@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <aHl9YLc823uWwgIp@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xEBluuAaJX/OBE7m"
Content-Disposition: inline
In-Reply-To: <aHl9YLc823uWwgIp@nand.local>
User-Agent: Mutt/2.2.13 (2024-03-09)


--xEBluuAaJX/OBE7m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-17 at 22:46:56, Taylor Blau wrote:
> On Thu, Jul 17, 2025 at 08:32:21PM +0000, Ezekiel Newren via GitGitGadget=
 wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > A few commits ago, we added definitions for Rust primitive types,
> > to facilitate interoperability between C and Rust. Switch a
> > few variables to use these types. Which, for now, will
> > require adding some casts.
>=20
> Hmm, interesting. I am not super familiar with how people typically
> handle interoperability between C and Rust, but having to change types
> on the C side to make it work with Rust is a bit surprising to me.
>=20
> I would have expected that the Rust side would have declared its types
> using libc::c_int, libc::size_t, and so on. I think I have a vague
> preference towards putting the burden of casting on the Rust side, but,
> again, I am not super familiar with how transitions like these are
> typically approached.

Rust normally handles byte strings as slices or vectors of u8 (that is,
C's uint8_t).  C handles them as char, which may or may not be unsigned,
as we all know, which leads to some "entertaining" problems from time to
time.

Also, in general, Rust doesn't offer generic system-specific types, such
as `long`, except for C FFI.  This is actually a strong benefit, since
it means we're not inclined to write `unsigned long` and then wonder why
things are broken on Windows: instead, we write either `usize` (the
equivalent of `size_t`) or `u64` (for things like file sizes).  This is
much more ingrained than it is in Go, which has a tendency to use `int`
(Rust's `isize`) a lot and much less often specific types.

If we're going to move this code entirely into Rust, then it makes sense
to cast temporarily, and I'm fine doing that in C, since it's C that has
the weird system-dependent behaviour (arbitrary decisions on the
signedness of char).  That actually allows us to have more confidence in
the safety and maintainability of the Rust code since it is less system
dependent and leave the suspect pieces in C.  It may also, interestingly
enough, also allow us to easily get rid of the weird 2 GB limit on diffs
due to the unpleasant dependency on `int` in the xdiff code, which I
would absolutely love to see.

However, I'm not dead set against casting in Rust if that's what
everyone else wants instead.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--xEBluuAaJX/OBE7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHmDigAKCRB8DEliiIei
gfc0AP9ITuoeiYtuLHZWSk+tC3h/VJdWohZ+zEnzFnwXGmjgmQD+I3qMlox5VMCR
sH/EMenafMfh+aXIpqO4xtH9CEnztgI=
=tUeh
-----END PGP SIGNATURE-----

--xEBluuAaJX/OBE7m--
