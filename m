Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FF30277D
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131985; cv=none; b=j6qF9/6oCoQkkb68yFBIjEzL2f+11X/XpprkM/pzzXxmK61KcO5vroCIZkrklsFrLNgRVH1i2B8RSj6fRyKnOMmF8Mjj65Laj8PRyo9j701NrUNXg6pH3KGfJIhq1MPgcREq0KVQ21IJJpdy6wE437f8Jrt5H7mh8WPAzg3Y4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131985; c=relaxed/simple;
	bh=g6XF3g4DDLQyR1Mk+Ffc9Khao/iqLPsRjFEdjbxejqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV1RReF+j3WDqYJn9mu6QrnsGfDVnBf3StB2VOlgfgz3YGftzkSYuKUD5PP/wcUIA5Ob71LBkGU9h7m5sKI8vst1ag7sZaekL4c/gUngQ8A9C7EhR9UMbNc3DlcztS6CJq8GmH6GJwRV2LYyYZSauu+4orewOmdXNwf+lLZu5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Y+lyDdXW; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Y+lyDdXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760131981;
	bh=g6XF3g4DDLQyR1Mk+Ffc9Khao/iqLPsRjFEdjbxejqo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Y+lyDdXWr9kxhwtr60BJPV6jTZmnhYthNX9Z+NJfBCuhhoK0LmL2aZ89C+rNCuFyN
	 hGtW0MeyvQJCVaXojkyCeymHEwoGzt+lLT92J8JeLUq5Y6vYaY6ZcHpcyf5fwW7PmK
	 r8uc9mHMZ4m7dCVjM87qAnjVD6/A9XtktbjQyRKTrJEeMQzGzcfVxFUijdpx+lfvhA
	 Th3rp6OA8WApiYJ/K3Wake50+r56tOQzIzcfwMwoPP7wwqCuk9KJBAr3LTR9iPKbat
	 /5nVHe9lw3qkZ1ea2NLV+U5v7ADDdWrZBpA4rbfleOzcije46Mjd5FjQd2DdAKxZJF
	 OVhZqzU4dbCZqL8SPjqIDL1+uKh4WkZwuqCFdeTgMFuxUYjdSE+gXyF143zaohlMD3
	 0RO5ChKAPukMdDjaWdLn3Wqm+osUheQllbdwhTpQG6omtLNWa+i3rbMpdrFW6qaiTu
	 aqD2r9PZIhzDLmkNx2i6sPSliZr2PaOyO3p9Vsj3eL1Xb8e8A2u
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1219:5812:e069:d2bd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E0720200BA;
	Fri, 10 Oct 2025 21:33:01 +0000 (UTC)
Date: Fri, 10 Oct 2025 21:33:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci: fix broken jobs on Ubuntu 25.10 caused by switch to
 sudo-rs(1)
Message-ID: <aOl7jFj9Ftd4wNH6@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
References: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JEg1oJRmqTmkSKmk"
Content-Disposition: inline
In-Reply-To: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--JEg1oJRmqTmkSKmk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-10 at 09:41:14, Patrick Steinhardt wrote:
> Ubuntu 25.10 has been released. One prominent change in this version of
> Ubuntu is the switch to some Rust-based utilities. Part of this switch
> is also that Ubuntu now defaults to sudo-rs(1).
>=20
> Unfortunately, this breaks our CI because sudo-rs(1) does not support
> the `--preserve-env` flag. Let's revert back to the C-based sudo(1)
> implementation to fix this.

I've requested that functionality (which I also use in a variety of
cases) upstream:
https://github.com/trifectatechfoundation/sudo-rs/issues/1299.
Hopefully it can be implemented in time for Ubuntu 26.04.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--JEg1oJRmqTmkSKmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaOl7iwAKCRB8DEliiIei
gWVGAPwMWcDF1SEal1LdowFlGmzCFkjx+VUoWgxvOaf9sI8X6QEAyqUGJOOzva/d
vjflxhwHBr/CRcIVkZ2OUkrwXVP1LA4=
=s7tJ
-----END PGP SIGNATURE-----

--JEg1oJRmqTmkSKmk--
