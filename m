Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400F2868D
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484764; cv=none; b=GLQq27iYyJmcKk6YBlz9h7BFBG9AQIk+Lbz6sUffE9kZpZ07E8bwhIfoUwwr4qwFAT0BxD5cAXPYHfbYVo1iWU/TFrZ6nfkP8HCxsJyiySyYOWExjLZrQtKdOzzCxofarHJkWyAUU8wr1UE4ftjXlPcMI9zG9wM7HUndxiVUu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484764; c=relaxed/simple;
	bh=8+G4dkzECSk3CjAoV5jbi/+Kd99fP7reH5JgybEHW5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOuz+mtdLKk/y6zOqeqpu7vnesp4vjut5d6rClWRTmrpyaQkVEM3J1r+V7ad7a0ut8xlYNsXAUwdzrTGdLTAgPTBVBdvxL35W3oq9bv6nELFuzUQwtCGyhs0JqXlbUr+n9zc5iTAk+4FNDToFBshjhZIyfbhZsT7cNtGWJHYDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0MEe/dq+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0MEe/dq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720484760;
	bh=8+G4dkzECSk3CjAoV5jbi/+Kd99fP7reH5JgybEHW5s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0MEe/dq+UIeIwKNLfTxRozgwynqg8F1TG+lOeVwLwMFm6+axtHhJzxsMDT5YR9w5b
	 ppvcnW7eK8DnrZe5WBpN0ZBRuyxXsQ5vtpAdzXN9NWuXTQ4Ua1IFp07LYllydgDBpd
	 CUuSqiV2YjRwpF+i4mJZ4b6hH6cD9BxcpkiZ+7ZG93aQqMGzufAeO5ERFcKvOKZh4V
	 LCcbo0bobMmmx5p3EMbqhA0kpJOdx3xZaZbFEALW9zj0tvaDzG7c+sl+2uN/C66Vk7
	 i6Kyj2+vdIQ/NVoS0gAI+cmjbYPi1e1qPjbjS/cxNP0oTmcsxo3gJAp6ihlc5qsr8I
	 oBBQFLmiXmnlX/sbArw9wqc22/Ud26yz5invs7D6lOnVgG0+tnBcFpdoUXXBYVFwYc
	 vnTbeH+ujDOaliol21kAsh5YQcVpMXLqqoCgEiS3MhUduVSOSZmiId80OWJc/HD3so
	 wbD81N2nzep07M9Ay9Na4XAp+X1fX9EhV+QpVEuaJlRyivAN3eD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 52D1520991;
	Tue,  9 Jul 2024 00:26:00 +0000 (UTC)
Date: Tue, 9 Jul 2024 00:25:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] var(win32): do report the GIT_SHELL_PATH that is
 actually used
Message-ID: <ZoyDlrcmyXUX_dki@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
 <xmqqed83g1e6.fsf@gitster.g>
 <Zox48sVp-PybvLxi@tapette.crustytoothpaste.net>
 <xmqqr0c3h21e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4FfvlkYR6Xw0O4v4"
Content-Disposition: inline
In-Reply-To: <xmqqr0c3h21e.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--4FfvlkYR6Xw0O4v4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-08 at 23:55:25, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > That's because external users who rely on Git for Windows to furnish a
> > POSIX shell will want to know the path, and this variable is the best
> > way to do that (and the reason I added it).
>=20
> If Git for Windows furnishes programs other than POSIX shell, paths
> to which external users would also want to learn, what happens?
> GIT_PERL_PATH, GIT_WISH_PATH, etc.?  Locate them on PATH themselves
> shouldn't be rocket science (and instead of locating, just spawning
> them themselves would be even easier, I would presume).

In my experience, they have not always been on PATH.  It may be that
they are now, which is fantastic, but I seem to remember that at some
point bash.exe and git.exe were on PATH, but sh.exe and other commands
were not.  (There's also a different path under Git Bash than the
regular Windows PATH.)  You might say, "Well, why not use bash.exe?" and
that works great until you realize that there's also a bash.exe that is
part of WSL and will attempt to spawn WSL for you.

However, that doesn't always work, because sometimes WSL isn't installed
or is disabled or broken, and so the operation fails with an error
message.  Also, users will typically have wanted Git for Windows's bash
and not a Linux environment's bash, since the two environments will
typically have different software available.

Why not add Perl or Wish or something else?  Because once you have the
Git for Windows sh, you can use a fixed Unix path to look them up and
get a canonical Windows path with cygpath -w.  Thus, this is just the
minimal bootstrapping functionality to get that information.

Of course, on Unix, there can still be multiple Perl implementations,
but you're typically either going to build against one in particular,
which may or may not be what Git was built against, or you're going to
use /usr/bin/env and choose whatever's first in PATH.  In that case,
it's very unlikely that anyone cares what version of Perl Git actually
uses.

The only major benefit of using Git's shell on Unix is that you know it
supports POSIX functionality (which /bin/sh does not on some proprietary
Unices) and it also supports local, which may be convenient for
scripting.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--4FfvlkYR6Xw0O4v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoyDlgAKCRB8DEliiIei
gYzPAP9us1j6GAsl6xgIv/n+njVNOuBqHO5WvZyoBBX4CiiFKgD/cVXPf88VjYst
Jy9M3zTvoZNbbg38BL9UEtWqZ4MWlA0=
=Xc8p
-----END PGP SIGNATURE-----

--4FfvlkYR6Xw0O4v4--
