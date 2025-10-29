Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B617B50F
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698834; cv=none; b=G5wn2f1FoZeyqDBayzuxyJ+abnbXntP0Zd2gtDGgv+rWH2ImaPciYpPe8/F9BZ+GgIfqRtqVdZKei8omxlJrXkI8g+PgWO11IQlBeha9dzPKwDID1hjPXVN3vhwuygBhW1xF+xHV59Y4ilI3xLtmdDunHpooBzOIp3H4gcD38cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698834; c=relaxed/simple;
	bh=L1HbXWjhGD4HkMWakn6yY5rHodYhA/PA8Yvkbz2IU68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxMxtiX8T4Bw8e3zIyuEu9tpS/R8bJSiWZx6p9/N33DP5jomfsw0D07tiyy+qgMch2mq3u0ydTG4FqSchWuE9Ir01r63sllT5LDQpbjo18xxVvMITYsuwAi/5M54Zwq/lS9gT9TTMDffXJItUpRE+FDGj9rBpGF13g/u4+pNbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yuBcA2hQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yuBcA2hQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761698829;
	bh=L1HbXWjhGD4HkMWakn6yY5rHodYhA/PA8Yvkbz2IU68=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yuBcA2hQ035pdo9UXfWHLhesgfEs9FssvAap+7DAgmRkFLOE9JzOaAFtEiOk7YHxG
	 0doMhej/YYdBaVOMgwCYIpFq//aMhhdV8z0jd4XVej7pUAuHwDHtTwaWHP7gzawEZe
	 MiuboV5exZOVKRkxrKcsELtbQvymQtzVKKMdVTEDGjiKGMqIbb5iS8I+sbfVjmQ/Fi
	 mPEGOB8hRLs7AcxCAbeG7Updfa8JNWkku1YJuwjQpcCV2IHQe0HKDCfjMpeKEJQ9jx
	 2moDPejjYi66XMR+PvXqhebU1Ww/VobkWWT4iC3bI8HY2ediRxD+Z4/9UzHcuXndFq
	 sgoPVJZwJFrCypvihfq+cjq1hAkDqFnxM2A+WBKYtLxUyh+8fqA66buoq6Mj4xkFCE
	 jXOBFXhbBi+sAx9mdcr5Puj+A5F/uqN7uvnIFT2VY1TXNz/JUMKFggYDrhIIBn3NgY
	 oF0tOWo7xWWLgIWOe/25Ko69czCzvSnINgDIvCKfRl65zBXlQ/3
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9578:8587:8ed:424b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A5E5B20036;
	Wed, 29 Oct 2025 00:47:09 +0000 (UTC)
Date: Wed, 29 Oct 2025 00:47:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
Message-ID: <aQFkDBEmpR0wd-V0@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-5-sandals@crustytoothpaste.net>
 <aQCKD--ZmKnwBWs9@pks.im>
 <xmqqa51addc8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WCpIryJyqSbEj953"
Content-Disposition: inline
In-Reply-To: <xmqqa51addc8.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--WCpIryJyqSbEj953
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-28 at 19:40:39, Junio C Hamano wrote:
> Yeah, another thing that puzzles me is if src/ is a good name for
> the directory in the longer run (unless we plan to rewrite
> everything in Rust, that is) for housing our source code written in
> Rust (I am assuming that *.c files are unwelcome in that directory).
> But it may be a separate topic, perhaps?

That's a standard location for Rust files.  The root of the repository
has `Cargo.toml` and `Cargo.lock`, source files go in `src`, and output
goes in `target`.  So there's not much of an option, really.

The hierarchy of the source files also affects import locations.  So
`src/hash.rs` is the `crate::hash` module and , `src/foo/bar/baz.rs` is
`crate::foo::bar::baz`.

There's no reason that `*.c` files cannot live in `src`, but Cargo pays
no attention to those (unless they're compiled with the `cc` crate as
part of `build.rs`).  We had a project at work that moved from C to Rust
incrementally and we moved all the C files into `src`, which was not a
problem.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--WCpIryJyqSbEj953
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaQFkDAAKCRB8DEliiIei
gXPTAP48Exd0PTQX5RZk5R+Zew/zTGNdvd0KRg3R98yigYXHDwD8Di8LDuJPZWbs
FtupLzLkGjVK7X0c6YBE61EfkfNNxQs=
=ngNx
-----END PGP SIGNATURE-----

--WCpIryJyqSbEj953--
