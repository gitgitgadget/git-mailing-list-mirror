Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B33DBBB
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678592; cv=none; b=TqnyD6zTGoRfbWGDjDotHpG1TJBD+p2F25oHrwETS7EeCTTA/AtqLsTULfYtl6tLs8mIhcPwZqk/YNJb2P+SzSly18fJI7qtiNEB1Vxo9m/QHEqw8iZmd+EXrMO5juvAdSOwc1ME2b1UcNDYniWBDQ/cbDB3pSbLzaO8fYxeep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678592; c=relaxed/simple;
	bh=fdiCcdO3n7cV8qsJEB5wnr9nF4Ujm+AByueqCJqmQwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onHZ1DQoLOvz3nbziEunv+UJ6QZv2VBbczgEnB6gV8YAmlBfJ+rfOH8LCRFuahNjkPbNivNz03nHfco84VDuIGmwcN8zr2Hmge8eYgEJTOi6OEcW58Mf6vm7qShVcD0QEQ0lulqMQt1rEEv7ChdRBc9ZqW0k1EVz0yP+M+MLasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=plQRvqPs; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="plQRvqPs"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 195205B2F5;
	Sun, 11 Feb 2024 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1707678587;
	bh=fdiCcdO3n7cV8qsJEB5wnr9nF4Ujm+AByueqCJqmQwI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=plQRvqPsIzNzo6GJBcuQCU51mQy/UE657G8o7h4l4cI7GtyT7iuAhz8DwCfdugBuX
	 nGdPfU5M8V7gmGlF99wxFEQ5pxJswfpVkKKLVujFofWqEkmDS6tXI5sjquqp1f1mx6
	 qNWg1al6HjHD3zoPsfP2Tae6n2EZ30F58cSHXC1XPwFibEr59mF4ekYE+RRL2WkYz4
	 wLrIGHTtdasohZXr21P9dtaEdFDYQV7odQVHWuWCGFWSZBoLCTluIC3kR536uLgqgc
	 TExdmXNjb0CnFBbGkmcXZleIdqC5ujTgeArzcfx/lx8oiD7EhrqLWp7I20UoNoFkhx
	 up1XZZmgHQjhQcsCJNovkCRKhMmr9WaaxLjHm2fiWaHjhbsQkPNh/zOIbkZwU/HsfX
	 B+DdMgDOj9sXjnFrQGxCDJrLI9N/Fzvi5GxbhAgJRAImfH5oBV3bpce1u4XTVNvW0Z
	 r3kiNADA48zIGBdoClR4lAoKuQowl4FeNLZsEDpMGJ/VRw/155q
Date: Sun, 11 Feb 2024 19:09:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	K_V <zinen2@gmail.com>, git@vger.kernel.org
Subject: Re: git gc changes ownerships of files linux
Message-ID: <ZckbeJqdvIfY4YPu@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	K_V <zinen2@gmail.com>, git@vger.kernel.org
References: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
 <20240211151455.GA27103@tb-raspi4>
 <ZcjnuSAZiNHvA5h1@tapette.crustytoothpaste.net>
 <20240211154345.GA28699@tb-raspi4>
 <xmqqcyt39cju.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t+tInotCSAj3yV4i"
Content-Disposition: inline
In-Reply-To: <xmqqcyt39cju.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--t+tInotCSAj3yV4i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-11 at 16:43:33, Junio C Hamano wrote:
> You definitely must set up your initial directory with g+s if you
> are usihng the group-writable shared directory model (which I would
> actually be surprised to see in 2020---is a shared machine with more
> than one user-account still a thing???); adjust_shared_perm() will
> not help you there.

I think it's relatively common to have shell hosts from which to log
into production machines, or to have shared hosts for students at
universities, and I do know that shared web hosting is still quite
popular (because it tends to be very economical and low maintenance for
the user).

I don't know that shared repositories are really that common anymore,
and I do usually recommend that people clone their own copies whenever
possible, but I have seen posts on StackOverflow where people are in
fact using a shared repository (possibly with multiple worktrees) on one
system for various reasons.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--t+tInotCSAj3yV4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZckbdwAKCRB8DEliiIei
gbn9AQDa3DmZXBc1zZ5OdUePX1oHCUvtreRhb2hwa8lEnSmFVwD+Kt1rKvantLHW
GplEd7wkJYCQe0ho3SIu1xMJjc1dZgE=
=DY/t
-----END PGP SIGNATURE-----

--t+tInotCSAj3yV4i--
