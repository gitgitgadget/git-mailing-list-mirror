Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982862877FC
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769566909; cv=none; b=BSthdP0whKLG8b7Tt1V9FYXDipsnN5qSYmREXSfKvJ0EY1+VVb17rtferIH8WpSI/Ekw44As+WIVHPM69O3XeXH82fq7os9K+w33k6hbdYZRmsveQPxiKw0vMOVOqq5h56JBjWy729t8O42z3oos015cCJ/v2ix8UAktL3sOyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769566909; c=relaxed/simple;
	bh=Lvst+2HGXAbTbjH3XelxJR+Nc+za2jPG4OApWjZBke8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shDm2TP603Va3LljaSK4YwNG2/sZzMC0/b26/0O00v95oTeCfRUfHE4nLQrxR8fgaqShQrmEPPULjhQkVP/l+colCOzg+UDwqZnD0WP9YwLDTk3gRXKZxJEdouymqvzGt6bF/ciYpbaVFAD+5aF3c84GbFJDU/52XGiysZaAF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GppJDou0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GppJDou0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1769566458;
	bh=Lvst+2HGXAbTbjH3XelxJR+Nc+za2jPG4OApWjZBke8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GppJDou0k9a39bQQ3KXkTCvLGdM+ZIde2ZxP12SADvkSRADJiZLTkvR46ViVauRPG
	 5EUrscxBfNJxg8YCEPoTSs0EohNDK14+xFFk2wyA8FmgyLzj/Gzffon3ZKTw7eGvXB
	 oPI76xVez04xeocYW/RhBz6wy5u/9Dhb/RAvTst0hYeC9ibISC4jutGZW8pYsVEMgh
	 ZoWrRV1krV6bbdiFZTD6u2/vXrtpmgUeWY56niLNsMTz7Mx0LeeLj0UtLtb2F+KlHf
	 WClr5C4ZdLws6b+3zS+T9vKvbv8DDi1hFnTVrjnI5mO/tUz+PdaOmyjDMeDFWFIyHN
	 lRRP+Qmf6BgcusJi+UQVQejE0ONmkpJyG9lSFezt2/gvbTJb/kBN0TOBeWgxb/GWcD
	 neLkAxLO6WMUc1LWAJRYk7BTAzyoEd/m4+9RimeFX4l6GPefnMyxETChjGxZqI7Hbh
	 c3YsjRGMaqF0DoEtB3jcx2Vx3oyydGRBmxpuV87Qs0c8rB8sz+M
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4d5a:95c1:507f:bdad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EACCB200B4;
	Wed, 28 Jan 2026 02:14:18 +0000 (UTC)
Date: Wed, 28 Jan 2026 02:14:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: ZH L <lzh2587379717@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Question: supporting multiple named ignore files (in addition to
 .gitignore)
Message-ID: <aXlw-RN82f3CquNH@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	ZH L <lzh2587379717@gmail.com>, git@vger.kernel.org
References: <CA+5Chmhwcz=gOQHW18_w+uYojshjFj8MCE+srUpJgEhbh8J09w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1lzPvteS7zszCdxJ"
Content-Disposition: inline
In-Reply-To: <CA+5Chmhwcz=gOQHW18_w+uYojshjFj8MCE+srUpJgEhbh8J09w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1lzPvteS7zszCdxJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-28 at 00:42:12, ZH L wrote:
> Today Git only loads ignore rules from .gitignore (plus global and
> info/exclude),
> which works well but can become hard to maintain in large repositories wh=
ere
> editor, build, and miscellaneous rules are mixed into a single file.

It's also possible to put `.gitignore` files into subdirectories if
that's more convenient.  But yes, there's basically one per directory.

I want to also point out that editor ignore rules belong in personal
ignore files, not in projects.  I use Neovim, and if I had swap files
enabled, it would be my personal responsibility to ignore those, just
like any other editor files, so as not to leave or check in detritus to
the repository[0].  Similarly, I'm confident that Junio, the maintainer,
has Emacs backup files ignored or disabled.  A project cannot possibly
account for all the possible editors one might use to contribute to it,
so it's better for each contributor to be responsible for their own
editor, which means that those rules only have to be set once, not per
project.

> Would the Git project consider supporting additional named ignore files
> (for example editor.gitignore, build.gitignore) that are automatically me=
rged
> with .gitignore, with a well-defined and documented precedence order?
>=20
> This would allow semantic separation of ignore rules while keeping full b=
ackward
> compatibility, and could reduce the need for external scripts that curren=
tly
> exist solely to generate .gitignore.

This wouldn't actually be backwards compatible.  Say Git 3.0 added this
support, but someone continued to use Git 2.50 (because they're on an
LTS distribution).  Git 2.50 wouldn't honour those files, so it would be
possible for users to check in files that were only ignored by the new
rules.  I assure you that there are many people using very old versions
of Git and that even in corporate environments, there are a wide variety
of Git versions in use.

That doesn't mean we couldn't implement this functionality, but I have
not yet seen a project that needs it.  Many modern languages put all
build products in one directory, and if the `.gitignore` file contains
only the necessary rules (instead of combining multiple large template
files), it can usually be pretty small[1].

I'm of course interested in what other folks think about such a
proposal.

> I=E2=80=99m mainly interested in whether this idea has been considered be=
fore, and
> whether the maintainers see fundamental design objections to it.

I don't know whether this specific policy has been requested before, but
we did recently see
https://lore.kernel.org/git/LV8P220MB2017EA88974F2311DCFB7665F52AA@LV8P220M=
B2017.NAMP220.PROD.OUTLOOK.COM/.

Between the proposal requested here and the one I linked above, I would
prefer an approach that provides for explicit inclusion syntax, since I
would think that would be easier to reason about and more flexible, but
doing so in the least backwards incompatible way would be difficult.
Perhaps we could make the first line something that contains a special
pragma (e.g., `#/gitignore pragma on`) to turn on a new syntax.

Even if this were implemented, we'd probably want to do so in Git 3.0,
which is coming up soon, and we'd need someone to do the design and
implementation.

[0] In my particular case, I have turned swap files off because I find
the way they work and the detritus they leave behind annoying.
[1] Go has 53 lines, Rust has 79, Neovim has 87, Git has 260, and Emacs
has 383.  Git could have many fewer if we built our binaries into a
build directory, though.  Emacs probably could as well.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1lzPvteS7zszCdxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaXlw+AAKCRB8DEliiIei
gQvhAP4nk3ytnUwMiizdyyKU4bKjin9oOEG9xG/kBp9IbBwfWAEA4awVN+m1HqR8
2tTs6dcO43h4Bvnv9khBnIoD9NqkYAE=
=FHZa
-----END PGP SIGNATURE-----

--1lzPvteS7zszCdxJ--
