Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B3E541
	for <git@vger.kernel.org>; Sat,  6 Jan 2024 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OBmQrbf4"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CB9ED5A388;
	Sat,  6 Jan 2024 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1704565317;
	bh=UYP12V9hJtjKhgDg/QCwlIqiNv5cIPFxuVzXVdj//QU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OBmQrbf4lFSujf8jBjTi0LEf6lYZmjRUfpjV73iGE6nJf8z1rIkJP8RLXsgoBPDxN
	 +HcX++BlFhgNyMFrRRyDO1CLsXXLkhzMEGM0P2RlRCDj36vgHs/6fUR/joukKnbk5f
	 kxuR/h+OtQwu5ZYBRn/wmtlU51M9usOlP7921ajSXFGV9QnskMFSLwN3ZAAvhYL9Gj
	 Q5vrLtyAGxxGHPVzR5y8IT4Ll1DSzcj0eUwOdIMuRONUjsRf3/zb/BkZSdmpNk1YKM
	 By+iPSWw2sfJikAualbxDMYVYJCESl5qBph/Wow3GWhxe0jfgjFGRAVslFIZvCo2Rs
	 aL47YgL0C0fLQ+AKCKg0JiCe0He5NkDiiIFcqZzgPVD2A0ltjin6JwGoBI5g8IlOIM
	 cKe6X0u7tO2w3RI4NvxmPy4v85+1PVIv26qQ3yGB3iy9mYEfy/61ukX3c/0J93XW54
	 0Cm7T+3BBldy/pYuIqyUE9MWnM3G1/eb+aUGO1l7uLv21WwNcaF
Date: Sat, 6 Jan 2024 18:21:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Maxim Iorsh <iorsh@users.sourceforge.net>
Cc: git@vger.kernel.org
Subject: Re: Bug: git log with log.showSignature enabled
Message-ID: <ZZmaQ0RoxJpU2PSH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Maxim Iorsh <iorsh@users.sourceforge.net>, git@vger.kernel.org
References: <CADQ_TR56X_iMitPEiaOyR_h=1dp9ThUQMu_Vqjest1i8xbh9Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0D/8p0lt1gEZ21Ab"
Content-Disposition: inline
In-Reply-To: <CADQ_TR56X_iMitPEiaOyR_h=1dp9ThUQMu_Vqjest1i8xbh9Tw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--0D/8p0lt1gEZ21Ab
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-06 at 16:56:29, Maxim Iorsh wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> iorsh-linux:~/devel/fontforge/build> git log -n 1 --oneline
> 2aa98f6a5 (HEAD -> master) Dummy signed commit
> iorsh-linux:~/devel/fontforge/build> git config log.showSignature true
> iorsh-linux:~/devel/fontforge/build> git log -n 1 --oneline
> 2aa98f6a5 (HEAD -> master) gpg: Signature made 17:47:50 2024 =D7=99=D7=A0=
=D7=95 06 =D7=A9' IST
> gpg:                using RSA key XXXXXXXXXX
> gpg:                issuer "iorsh@users.sourceforge.net"
> gpg: Good signature from "Maxim Iorsh <iorsh@users.sourceforge.net>" [ult=
imate]
> Dummy signed commit
>=20
> What did you expect to happen? (Expected behavior)
>=20
> When asked for oneliner or any specific format, `git log` shouldn't
> show signature event when configured.
>=20
> What happened instead? (Actual behavior)
>=20
> `git log` always show signatures with log.showSignature enabled, even
> for explicit formatting requests.
>=20
> What's different between what you expected and what actually happened?
>=20
> Anything else you want to add:
>=20
> This behavior obviously breaks any script which relies on git log to
> produce preformatted info about commits. It's also quite rare, becaus
> e probably very few users set log.showSignature config option.

I think this is behaving as designed.  git log is a porcelain command,
which means it's designed for the user to use, but is not intended for
scripting.  The documentation for `log.showSignature` says this:

  If true, makes git-log(1), git-show(1), and git-whatchanged(1) assume --s=
how-signature.

As long as the output is what you would have gotten if you manually
added --show-signature, the result is correct.

However, if you want to script things, you can use git rev-list, which
is a plumbing command that's specifically designed to allow scripting.
It works very similarly to git log, but doesn't have configuration
options that change its behaviour, so it doesn't suffer from this
problem.

For example, on one of my branches, I get this:

$ git rev-list -n 1 --oneline HEAD
404bf1f83a credential: add an argument to keep state

Note that the implicit HEAD of git log doesn't work with git rev-list,
so you need to specify HEAD explicitly.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0D/8p0lt1gEZ21Ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZZmaQwAKCRB8DEliiIei
gWYOAP9fH+UmrS3A/GIRAv6Wqc38dv4UAFwL4ejAz9a3QqlGjAD+LGp0OL/6Tq8Q
ggiIkB1PUw9R4hs1TpQMtchNl27T3Qg=
=9t0T
-----END PGP SIGNATURE-----

--0D/8p0lt1gEZ21Ab--
