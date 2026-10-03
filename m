Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFED3A6B89
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791025166; cv=none; b=D41K5xcvVaDDJKWa2eNyyUy84EPBXTEYJ4c0Htv5m3mh4f59CbHQRodvUralC+uCMg6gxLNQUoE4QQaddnbx9/D5p8+f/uJ4F1i1kpXhDoczA592HVbXeWKjWz8dGoXyOwvatqDY/hjdqbwl5+x7tJXYGjscv2pps53U6YIxDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791025166; c=relaxed/simple;
	bh=ROTSo3FVR/chxUdYX5Rrxsl5yGmC1oJuTstnRTojrRU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SyxHwGFDmp5cAjYnNKmvecINvTHudtxZ95QMe6+iWkA6nLLM0WbFsyN//vAQJ92LLoQcmEDUgWcmAn/6w2F+B1D9LS+R7zpEjvj+7C0YUzV1KBkjFg8Bfxgw+3V+F35cROgUjiIUo6rXmuPX3cAu+nenlb6v/3spDjCpQJeqqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioZT24Fl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioZT24Fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4061F0089C
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791025164;
	bh=ROTSo3FVR/chxUdYX5Rrxsl5yGmC1oJuTstnRTojrRU=;
	h=Date:From:To:Subject;
	b=ioZT24FlcKqD8VmwjkzWy0SX/QhtzR01u8vcw3kNN/GHGCFb5sUtCelJ5Zl8LM+kj
	 38+ii1/9QGrXltecUikd0wd+LfCbuhcZBxPLAXKbPCrvfxbYGkO1ATDgNcSxAHNsZj
	 hPxVHbVTi2TR/NNkxakbkXHjottDBFSBh59wE1deSX1tFPlmasP2OV6ikyDAtwC7HT
	 ccPIJkBkuEJH0k5WehMJcHPoTFXukf8g+Tdpribd+94dilxt+fyFlPa4UDPieTM6/0
	 A/Tdhdt16Aakt9uDu1grfdMNsrPt5A72dmSdfqFWNSHcttx4NM6yM+QyRU7Cx5Ain8
	 9rr5UOZ7uq31Q==
Date: Sat, 3 Oct 2026 12:59:18 +0200
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-bisect(1): BISECT_HEAD without --no-checkout
Message-ID: <asDezml3pAHrcI-0@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mjjzo4vb7lpcg5t7"
Content-Disposition: inline


--mjjzo4vb7lpcg5t7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: git-bisect(1): BISECT_HEAD without --no-checkout
Message-ID: <asDezml3pAHrcI-0@debian>
MIME-Version: 1.0


Hi!

I'd find it useful to have BISECT_HEAD set even without --no-checkout.
I need git-bisect(1) to checkout the commit being tested, to perform
some test, then switch to a different branch (perform a rebase), then
remember which commit was being tested to let git-bisect(1) know which
one I'm testing, to tell git-bisect(1) whether it was good or bad.

I was using BISECT_HEAD as in "git bisect good BISECT_HEAD" when I was
using --no-checkout, but now that I need to do something else, I don't
have BISECT_HEAD available, which would be quite convenient.

Would it be possible to set it unconditionally?

In the meantime, I'll set up a variable to remember it, but I think this
would be a long-term improvement.


Have a lovely day!
Alex


--=20
<https://www.alejandro-colomar.es>

--mjjzo4vb7lpcg5t7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrA4AYACgkQ64mZXMKQ
wqlTxA/9HElS9h5d99yBlZYK/KglrO1ul90BeJytWZ5Mgir+atnaoNJfQkRFdpCj
AC9VexkrKik8vJRm+OcIP00MIMJnuVE7DyuwyNpUIFbxtweWPKpzbvVG7Lri5LDz
SlLCtdpWL0FFnGNcGHOvjP8KDfXMCmDrfT9u6SwN9HWkrRR2PF2aErWn3Jg7s7FY
URvs/W5o8jbNtx5i3KK81W/x+CL6ww982uD+1KjJZEvGkwkWdsuUieJu4IwGO5+8
AX5sbYjrS2P6GwRGywKb8qXZuAW9Xn0QDycx9On3XSRHKYWlxkEYscNb+TcYVinK
QePgjGIKGYm2Q6RU5BlmDxKysjHMoiOvdnCdLla2pNO+n8UYrTSsLbjDof+pSx3C
bm2Zx08bvhDCmv63b6+/o+dv4fvIt1rGq4YPCSNugo0VcGojKIkSEyGzC6LuhJt8
DXGq6qTdQ9ZuH7E2HQHmOYpbvSuFRWqFeeo5Vxoy2/MvDlPtRVLMKBPEKmNjZo/a
+MejPizvVzzPI1sZFRF55IQko+kbVIeCwB9XimN0LI1u6Gedy8VmMJDoS8jCV3iG
0Djb1cDLZXTwGhYhTVmqPR4ZAe8sIEs6KFAfkRx5iugsydyDLrEBBeOmO9oVAxlQ
Y3iu/thPogyBCIahH3bt1HGAteC2UJ89Z9mrnSgg7qmDmHr93qQ=
=NW9P
-----END PGP SIGNATURE-----

--mjjzo4vb7lpcg5t7--
