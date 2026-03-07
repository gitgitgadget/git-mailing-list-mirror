Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B32CCB9
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847249; cv=none; b=thDq6RXFO9MPLLTQmrAU9pNl5YNbMINwlEIVDu/Du2wMqOsmFW6jRPjYwWqeGp6WRCVj6RTnVxEBniHYUqEH9FhHih32YVnzdag0Gqzi+oZLt6QNlu+uw/oz9kkUrOPWuyURakOV0MNWmvAVpBRAn0JXbrWfR3cwB/EW1idFgAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847249; c=relaxed/simple;
	bh=uA6kqzDFFc5nph/+T6uHkTuDG2Pz0u+9dR2WR1SRSyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLCKQ/QWZe4/T265OaZhWsZQ6l1kdN4vD8CYA/EGozBjhiVbmQ0MpcbI15IIfkRxSXVYAw/+gQi6qfUiG6kZcpn1kJHAwHW7CbieX91jBdo1KHatyTRwFhn40qiX/PX2VCGlJDZQh4cIXK7mNrh68Ij3nYrGKeGNZ1jZ35Oq0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YUIkJzkt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YUIkJzkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772847246;
	bh=uA6kqzDFFc5nph/+T6uHkTuDG2Pz0u+9dR2WR1SRSyc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YUIkJzktHevCqwjRoOl8a/Gim8ICFMmAN26ZYfbd87WviMkPn2UyI1v2yVwwxjJzC
	 5kF9bpgRTlfIsvH8aFLsrLFt/YtrGIF1b8xvXESnCkcslZMpWyC9vUxL5Afm11Aq+V
	 ijL6eyAMRo0EUNG86l+yXvRGEDZoZxJV/nD6RSWHIJ29fzEw1XyaNw03hvbi82Vrxv
	 G+Q/ARvVmz+9/0muWi/jDI0O2xOuSijySZwWyIDwef7A2B2XheVLMYjJ8/EE5Me7Z9
	 55KAQcKs9wny/RzJd4tTMTL7+nwVXe5w2DRtS0cXTvvdl4M2yHp9ZDmK60+X12xGbv
	 atoJe2pl4bRFn5yNRucd8vtIlDT+phHjEyJtPKxb8CRhBZfnKyalW6/FTEBtooENa8
	 DZT2NGTMs7Zcp2rZxpQfqzAODqbskXf0j9ux7Mh2hdG4e7Z/bPGlk4vdOyG/Hh49SO
	 3qHmc3pqnbpd/265SfplgoG5xUt2R/XyrW3lk79y8LW7t6rtCnr
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ffb:2fcd:f6c3:a675])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C402C2006D;
	Sat,  7 Mar 2026 01:34:06 +0000 (UTC)
Date: Sat, 7 Mar 2026 01:34:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Banon <mikebdp2@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] clone, progress: add --no-turtle-speed option to abort
 slow clones
Message-ID: <aauAjQhhh7pxIxjD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Banon <mikebdp2@gmail.com>, git@vger.kernel.org
References: <CAK7947msLiGgrYTcg1m3ew+bP0F+VNbRaTy=ZW7zkkHh69bN0Q@mail.gmail.com>
 <aatjasMiPIeT0s27@fruit.crustytoothpaste.net>
 <CAK7947n9gqhRoykNUR4NvPFiaCB4nuotxQTT=eftSF8O9ZO2rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlz0BTu9gr+NQ90O"
Content-Disposition: inline
In-Reply-To: <CAK7947n9gqhRoykNUR4NvPFiaCB4nuotxQTT=eftSF8O9ZO2rg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--wlz0BTu9gr+NQ90O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-07 at 00:29:18, Mike Banon wrote:
> Brian, thank you very much for your code review!
>=20
> This problem has been happening to me for a couple of weeks while
> using GitHub: as a part of my "floppinux-amd64net" pet project (2.88
> MB Linux floppy image with Ethernet/WiFi =E2=80=93 for putting into a cor=
eboot
> BIOS image), I wrote a large [1] script that clones a lot of GitHub
> repositories and builds everything from scratch. With some non-zero
> probability (floating between 5%=E2=80=9330% depending on day/location and
> other unknown factors), my git clone operation gets directed to a
> really slow Git server with around ~70 KiB/s download speed, which is
> especially painful if it tries to clone some large repo like a
> linux-firmware. But if I terminate that git clone and start it again,
> there is a good chance that my next connection will be fast (at least
> a few MiB/s). So with the bash code like [2] below =E2=80=93 in case of a=
 slow
> connection, it will simply restart until it gets a fast server and
> clones successfully.

GitHub doesn't throttle speeds once the operation starts, although it
sometimes does delay the _start_ of an operation if there's excessive
use (for example, if you're cloning the same repository too many times,
as in some automated systems).  GitHub wants the operation to complete
as quickly as possible once it starts because a clone or fetch will take
the same CPU and memory resources no matter how long it's running and
obviously freeing those resources faster is better than consuming them
for longer periods (since then they can be used for other users).

If you're seeing this, I'd recommend opening a ticket at GitHub and
including the output at https://github-debug.com/, since that will be
helpful in troubleshooting the problem.  For instance, it may be that
there's a bad connection between your ISP and GitHub and that can be
addressed.  Or, if there is an overloaded server impacting things, that
would be a thing that GitHub would want to look into.

If you can capture the problem with `GIT_TRACE=3D1 GIT_TRANSFER_TRACE=3D1
GIT_CURL_VERBOSE=3D1` before your Git command and you include that output
and the repository you're having problems with, then that will allow
GitHub to look up the request by its ID and find what's going on.

My participation in the list from this email address is in my personal
capacity and my personal capacity alone, but I do work on the Git
services at GitHub and obviously we want everyone to have a good
experience provided they're using a reasonable amount of resources and
otherwise behaving appropriately.

Of course, I think people would still find the `--min-speed` patch
useful, but my hope is that it's not a feature you'll need to make use
of.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--wlz0BTu9gr+NQ90O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaauAjQAKCRB8DEliiIei
gfhWAP4z1VVGilgrVECL3Q0uDXaoIIrn4aWr0OuMQu2IuYm+VwD/e6aJ+flA4WLO
xoBDwb5bksrTeSwWW62U8U92fCylcA4=
=MhVt
-----END PGP SIGNATURE-----

--wlz0BTu9gr+NQ90O--
