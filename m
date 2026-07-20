Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702431AF1B
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584410; cv=none; b=QS8WbqK8hdur7sWdqH/teVM7bSAcBDnUjYPP7V38B+0I1IdSVSbKrMmh00t4kcR+gG/OoT6vek06bqhTSDu9pazfKJFZizF14n0Aw7Wl7bEG+C6oadplFUzjs4Jb1GFgTCTOhn6jDnxZPqPtSibQlHhbY4dNR+QnqAz7Jli3YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584410; c=relaxed/simple;
	bh=oaDZEQ2tKDg8PcOzjOSgYTaq6RAXEXi6ag5Hd7cq7ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mia9uw/wNeAGBDqCZBlduNfU/xmAPmBKXVaWHCerRcUw8aNcGCcf1KSKa7tLHSKmFwN6vI7yhmFglm0L5o1mmYMIt2DZlDhphWGiunOw+D47EiuLjvGKKmaQMi2nvdr7bqZCoGLWQywlVNf10s+k+hV1+Ej22ESV3fPXrvNjrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xgPq+sF8; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xgPq+sF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1784584401;
	bh=oaDZEQ2tKDg8PcOzjOSgYTaq6RAXEXi6ag5Hd7cq7ts=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xgPq+sF8RSrivvwHHgJl1t85i+WAX7xyA+WKYyFRyRDi8SrjhD8R65xbjUKmUKUki
	 Oyt7KUq0M+vPSTCjJFxIhaDf7av0Jn3u+mdDdgrNcu+XJSNIMfWtVQEMp/jlUruH7/
	 3w1jFdYkcgF32udDZrlokAky0mjX8CLwPNiNjkTZOMjrG80wu0kuUpSU8cl3Oy2dCp
	 lkjm9TGfZvWcPCDCXDMoPkmuBxL0XAnUHQ0Pt8frThF8QNxzqF894IKdzj3KbbrnQm
	 9DOb65+S41RMIr5OFSjC0QAxE4bhTz21rFM6wbUk2PO1+HuQB1gvx0eKmlspmP6e+t
	 ewXLxhjo0FpSHilXvMLVM6Dw5MyiIC9gSj5vZ49Q6EiqBEMUzQn5FVu1vwhjJ5GNG4
	 u5OupBIM2zCmrY9AU2ykLbc/H1dV/Rm25QNIloFQR+xo3jhDOaINQjcjfsv0eLvwMt
	 rlWnRmrNULSm8pdmVpi/nuKfS0Hxpg2OC2VGiCfRBz0ZJAZJHTu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c120:46e:6a37:97e1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6E5B9200B0;
	Mon, 20 Jul 2026 21:53:21 +0000 (UTC)
Date: Mon, 20 Jul 2026 21:53:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <al6Yz_QMlyU1GETv@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oi+aJw0Ks2Hu9hN8"
Content-Disposition: inline
In-Reply-To: <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
User-Agent: Mutt/2.4.0 (2026-06-19)

--Oi+aJw0Ks2Hu9hN8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-01 at 06:59:27, Patrick Steinhardt wrote:
> This move does not come for free though:
>=20
>   - The mass rename introduces a cutoff point in the history of every
>     moved file, as tools like git-log(1) do not follow renames by
>     default.
>=20
>   - Any in-flight or not-yet-submitted topic that touches the moved
>     files will have to be rebased, and backporting fixes across the
>     boundary becomes more cumbersome as a patch can no longer apply
>     cleanly to both the old and the new layout.
>=20
> My own (obviously subjective and biased) take is that the tradeoff is
> worth it, as these issues are a one-time cost while the benefits to
> discoverability will be permanent.

I agree this is worth it.  I found it odd even when I started working on
Git many years back that most of our code was placed directly in the
repository root when most other projects put it under a directory.  I
think it would be valuable both for existing contributors and for new
ones to tidy this up.

> Furthermore, especially the first downside is a limitation in Git
> itself. We're not the first or last project to do such a mass rename. So
> if our provided tools are insufficient, then we should improve them to
> make the experience better for other projects, as well. Subjecting
> ourselves to the same pain may even give us more incentive to eventually
> improve rename following for everyone.

I would very much welcome better rename support and I'm sure the
community would as well.  If we can incentivize ourselves to step up and
implement that, I'm all for it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Oi+aJw0Ks2Hu9hN8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpemM8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3eWlxgv1+p1SkAG0tRHnqT3a5jweuJpqK3qdbtR3DMg
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHcLAQC8Qqry3AkiBef8gc315g65wG8k
P+AE+Yj3xS+DQCwQkAEAupF15KnPkp//xczkBtc60531xUZCVnJeASXjZoAN1AY=
=MZWo
-----END PGP SIGNATURE-----

--Oi+aJw0Ks2Hu9hN8--
