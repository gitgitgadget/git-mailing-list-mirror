Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A303E7BBF
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977749; cv=none; b=H/SsYyDdXanaXGtvB3gyRms3Y1KA9GNF+QadzvWshMokbKNWHBslB7DCFXs+NZCrmmBNPBzUcKwUDpWdMwoj5w6GdiMHMcrg02mUNexyWtGAwdW+aSRSk2PhhjQ4j1O6MbTbC9iykO71vhWS6a5KS/Q97BipkgpGvnMP8wHB8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977749; c=relaxed/simple;
	bh=bj8P8n/x2lBYoulqUGeeqafn0RXDeifciDrCaJG/J/8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LhDc1AzS5DV8vL7R1ogls5BtRk3ocf3qEwSmHnAYIuPnD5rHWvx+MMoPKbhFS14V4gN4X0Vl14qtHn5yK1p8siSuSa5RSSCIeopFIlxPNvaUOWBxHFmmWXtEPR5iaV/x56v5Bz2yB9vXTKZSgdT75yA1k3kYZWt7X28ReKhPl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEI+PSvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEI+PSvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DE01F000FF
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790977745;
	bh=bj8P8n/x2lBYoulqUGeeqafn0RXDeifciDrCaJG/J/8=;
	h=Date:From:To:Subject;
	b=UEI+PSvcKmYZOMQ601PERUh9k6Fp1TFVoo7kAHAATpPURiCDgyRynVt31hD+ZxlI+
	 FP+TCTqbvvQLvqFRXhAWtdVONXPREFum7ZaffxDo7RQM07AlLoxKCuoC+ZtGH6f+zp
	 jEj7XDzQHsqMTm8Mg7GrP5Qf1+o63FaCqZy8sEKbf8dW4R7sO8Yzr39YJaWAnlMu1f
	 ++iW5VvegbDYP4uOOBkxP9V4hKHYYliqI6KjANd2zLJjAOhUYcy8EHTMd25UX886Uk
	 EV/aNiTEb1t8Q/vAmyEww/glBdYHsZhnnJtjX63HZXi1VVbnho3GZZdTYcGZnz+WvD
	 jMgGEgX+WeU9Q==
Date: Fri, 2 Oct 2026 23:49:01 +0200
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-bisect(1) next after finding the commit
Message-ID: <asAbOSQ4BkuCTPY5@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6fexxhi3owbiezki"
Content-Disposition: inline


--6fexxhi3owbiezki
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-bisect(1) next after finding the commit
Message-ID: <asAbOSQ4BkuCTPY5@debian>
MIME-Version: 1.0

Hi!

Is there a plumbing command for retrieving the bisected commit after
a git-bisect(1) session has successfully found it (and of course before
resetting the session)?

I expected `git bisect next` would bring me to it, and then I'd rev-list
HEAD -1, but it doesn't bring me to it.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--6fexxhi3owbiezki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrAJs0ACgkQ64mZXMKQ
wqnaRxAAo97x7ba4mF25OP6zlDiTrfXFtkDTSELjmw0n2fgsSHo4qnkjQ5SLB/XP
zmb1/+nFyyYfCnuoxmLoWYAeXJwwTqr3+FJV/PdIbJB4z4LaE5XiF4cQOjgyVonR
JBDHPKU88RUJD06Nc5QyPrOh7QetR+j6AA+9uzIJhqScoM2PYuazEbY6qTU1rge3
J1DCn8nrAFgyzlzhrclorRXKu/cLQeb0IkwOxOtw6bYfyGfydYs/7kT1PlJR1kNQ
Fb7u66TIWFkcGmIlIq0E2Qcwomkpe6gMpK52H2sLu0O1k6rnZrPTL2g3f2AfZ3hb
zBhJZ1jEcv4EI8Pnbj9QblZjnS1oZp6RGDsWvhO87XxbebFUub/fC9pn+dSSmisK
QjaT2VTRxK2seXXVs799Az9qMgQrYheRJZlNU4Btp31rD4GxnHctG2nrzxjuVqsC
EzMZcVeWbti7A58WqX3/sZEqkaQBvz5kb9d62hjKi0BzjX8jKbibTuGXZb4oY2oH
PPeGvRVmHOely1XZBZwGo7JKtA8YVJ65SfPytWMXODok3e+L+YTr8vr9PxmsmCFQ
35ntTuQlE7vhkSQ7BL2k5/oLNyPTViMHCdA2cCgcbsPiw/e1UivC9je7tTBWoq07
89jdDBC/vw/e03IBzedr54F1isfPYSHn9OGZDDVniN/IhHoHG+o=
=XTJW
-----END PGP SIGNATURE-----

--6fexxhi3owbiezki--
