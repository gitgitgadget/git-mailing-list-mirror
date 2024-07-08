Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4738C06
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482040; cv=none; b=UvZyzgvcOWyUZ0zZeF1Bon2/INrjIAqHECo5TDF73wcY3J4nHvJ1V4EHZoa5d2eHCfT35WAwqoKH8PJ4X1lZybvQtnTAed2IyB4NB+tWwpwuQ6AHDWdiMiSnEbRvZCFjyyko6DW94Yj/1ugDW/lDrLp05JNH6o2qMhs/YCz3F2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482040; c=relaxed/simple;
	bh=UaVbP41sOU38v3w3aUuGZ3HEUgTCMvQM3q5iPX69FMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkbzAGKlx3EU5xWyEdQpKJFgzZYwRARSD4BqjDzYIyrimage6Xg93OGMecM/nPu4sWoViUbO9YY3f2s88OEkCgHxOc2Ru7D+KgNSXle1qts4cFjUAytdqqolQ9Zpl/5jAtAuqUpY5fXj9slxa4lCjxO5iw3OXz+EJkcNHZW14n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UhZpjqzU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UhZpjqzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720482036;
	bh=UaVbP41sOU38v3w3aUuGZ3HEUgTCMvQM3q5iPX69FMc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UhZpjqzUGDhelKT3ST/GHxaSgn9SLm+ADEElVJVABeERX/73mq3vJeSh5HJXzx5my
	 y4NGktc50yvb5dPCbXnaBnbVrJmt08rX0UHcKM8bqkxWjp5SmMuCAE53SFKzEr59EU
	 tjVJX0Z2SDtDZKkBY/9CsM6duKGgIQHyjTvbY78b62UB7gRBGnU6AIhENmeFsHW03i
	 99+/sR9AHN6wlVvGF1aZKM4jzHqQeIB1ZFYwm5zUIJdFocwK2EIZG3bxQquIWjPrIK
	 L6zRrViWzRzGIaovlRonB7dvKn+Jv9tEHxu+TrdtzY5+E/Oh0c9UA/vJcgTaUkke5E
	 dLOqfYZPwaf2/Pbbh7LvzT0mdyPEclB2zm4Wn+DzKdNIc0YeF8SWxMahyYvz50SYXz
	 z8njUMumWeEvZgTjro5fVa1d5Phow2RcKnRdy2EJ9RL6La/n676l4zs0I8fzmqAPk/
	 JrIq9dqJXnad+ykpEKewcJmJeh96bx5phGuYEU3A0WSz9zU3VcT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2ECDC20991;
	Mon,  8 Jul 2024 23:40:36 +0000 (UTC)
Date: Mon, 8 Jul 2024 23:40:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is
 actually used
Message-ID: <Zox48sVp-PybvLxi@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
 <xmqqed83g1e6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o2qzUfUYJPPq1X9u"
Content-Disposition: inline
In-Reply-To: <xmqqed83g1e6.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--o2qzUfUYJPPq1X9u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-08 at 18:54:41, Junio C Hamano wrote:
> This asks for a few na=C3=AFve questions.
>=20
> If there is a fixed path the "git" binary was compiled for, which
> can be referenced with a single variable GIT_SHELL_PATH, even though
> on non-POSIX systems it won't be like /bin/sh, wouldn't there be a
> path like "C:\Program Files\Git for Windows\bin\sh" (I do not do
> Windows, so you may be installing somewhere completely different)
> and wouldn't such a path work regardless of which drive is
> associated with the current directory?
>=20
> I would actually understand that, with relocatable build where
> everything is relative to the installed directory, a single
> GIT_SHELL_PATH that is defined at the compile-time may not make much
> sense, and when you need to interpret a shell script, you may need
> to recompute the actual path, relative to the installation
> directory.

I'll jump in here, and Dscho can correct me if I'm wrong, but I believe
there's one build that's always relocatable (well, there's MinGit and
the regular, but ignoring that).  You can install to almost any drive
and location, so it's not known at compile time.

> But I wonder why the replacement shell that is spawned is searched
> for in PATH, not where you installed it (which of course would be
> different from /bin/sh).  In other words, when running script that
> calls for "#!/bin/sh", looking for "sh" on PATH might be a workable
> hack, and it might even yield the same result, especially if you
> prepend the path you installed git and bash as part of your
> installation package to the user's PATH, but wouldn't it make more
> sense to compute it just like how "git --exec-path" is recomputed
> with the relocatable build?
>=20
> The "look on the %PATH%" strategy does not make any sense as an
> implementation for getting GIT_SHELL_PATH, which answers "what is
> the shell this instanciation of Git was built to work with?", at
> least to me.  Maybe I am missing some knowledge on limitations on
> Windows and Git for Windows why it is done that way.

Well, it may be that that's the approach that Git for Windows takes to
look up the shell.  (I don't know for certain.)  If that _is_ what it
does, then that's absolutely the value we want because we want to use
whatever shell Git for Windows uses.  I will say it's a risky approach
because it could well also find a Cygwin or MINGW shell (or, if it were
called bash, WSL), but we really want whatever Git for Windows does
here.

That's because external users who rely on Git for Windows to furnish a
POSIX shell will want to know the path, and this variable is the best
way to do that (and the reason I added it).
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--o2qzUfUYJPPq1X9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZox48gAKCRB8DEliiIei
gd6AAP40y4BtmVs3ykuFOzloqTPBorpN2ztWCaFIMQqtgmXZ4gD5AdQdxNZfIRxv
0JSJ3uwmDcdCNZ75wmFOX+Q81XJ1bQM=
=X0tp
-----END PGP SIGNATURE-----

--o2qzUfUYJPPq1X9u--
