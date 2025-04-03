Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB92E62A6
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743720907; cv=none; b=R4lvkciaaifakUVsC9CLOrZoNH1iVTHF1EXWnwToNje4daJlLASX8Uh+LO3zImxednZF6PqrT9531o6+TpcsBrwbHiI4Jyx5ASLpXxl1xPJCiTlxYdvQzqeJWF4KPyoKtQbdxH527dgduZKQf8LD33owDm9UvkDksbXRvfC3xN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743720907; c=relaxed/simple;
	bh=clkXHm65+KyBO+OPxa4TLoAUeetVv7lyQZB0yP7mK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEDs55guszLjmLnGdbndadXbsrZX3MekPN4WiWR92RmlRv15XVAs7PBicHNKwQx02i1qzaAsxJ80tGRkf2xN4oGiQQTsbysoQVsoI44yJY8KJfOVFcKkrf7BqRmtovnb/fdZpmAQ1ErVGsoIoZEo3orqjyFwCZ/bCUc8HTjHYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fty5yOij; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fty5yOij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743720904;
	bh=clkXHm65+KyBO+OPxa4TLoAUeetVv7lyQZB0yP7mK68=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fty5yOiji6VHDAKCabZd+SzDPh7G1MFlNAH8qzu8JBaOlsocwLP9ktoj/faNTrwb6
	 0ULgjdejbbM3v5+8Ip+m0b6CpmcTPzqFr01UAOMKeMYn6BchTMx7212qDSLPbpewz0
	 uDuXQbnMgQpVFWKApOr8uUAMhmxljr4rYGZzGo0eAkz8fKbSswMuA2apwJpfFuGb9x
	 su8NYGz8Fd/JJzIIfQ7hXVYZhLokVDu/qtqk9zaPIZ4A8Wzd7J07xgefTVpNbF+VG+
	 Xe9csfk0X72hx0Z5jfGctoRwF1YQvDt4YysEQ9AME9oejSZe8aa2n/zqq4eVnl6vqk
	 v43SH5vHf9NtF+xY9S97NQ0mc4wb9Mz1wD/C56Ga9jSgAm7DB1zJCyf4VD+L//mXn9
	 IirN8BVi/b9MnIJd+agaWeuWe2++87pDWSBSKX8VKnCShaZU3UxidYMQd0fVhmk5I+
	 72Ys9vvFZWePoPNtDHFZ/aTA9iqeD7d4HIruR+90W0L106qMawC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4D6E3200BE;
	Thu,  3 Apr 2025 22:55:04 +0000 (UTC)
Date: Thu, 3 Apr 2025 22:55:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] git: add --no-hooks global option
Message-ID: <Z-8Rxy4IK5EHKzLW@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io,
	Derrick Stolee <stolee@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fi2DrrSHOUsZN9jY"
Content-Disposition: inline
In-Reply-To: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--fi2DrrSHOUsZN9jY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-03 at 22:38:08, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>=20
> Git has several hooks which are executed during certain events as long
> as those hooks are enabled in the hooks directory (possibly moved from
> .git/hooks via the core.hooksPath config option). These are configured
> by the user, or perhaps by tooling the user has agreed to, and are not
> required to operate a Git repository.
>=20
> In some situations, these hooks have poor performance and expert users
> may want to skip the hooks as they don't seem to affect the current
> situation. One example is a pre-commit hook that checks for certain
> structures in the local changes, but expert users are likely to have
> done the right thing in advance.
>=20
> I have come across users who have disabled hooks themselves either by
> deleting hooks (supported, safe) or setting 'core.hooksPath' to some
> bogus path (seems unsafe). The supported process is painful to swap
> between the hook-enabled scenario and the hook-disabled scenario.
>=20
> To that end, add a new --no-hooks global option to allow users to
> disable hooks quickly. This option is modeled similarly to the
> --no-advice option in b79deeb554 (advice: add --no-advice global option,
> 2024-05-03). This uses a GIT_HOOKS environment variable to communicate
> to subprocesses as well as making this a backwards-compatible way for
> tools to signal that they want to disable hooks.
>=20
> The critical piece is that all hooks pass through run_hooks_opt() where
> a static int will evaluate the environment variable and store that the
> variable is initialized for faster repeated runs.
>=20
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>     git: add --no-hooks global option
>    =20
>     This is hopefully a helpful feature to more than just the experts I've
>     been hearing from.

I think this is functionality that Jenkins wants because they've
configured `core.hooksPath` to `/dev/null`, allegedly for security
reasons.  Of course, enabling this feature will also break Git LFS, but
in a less noticeable and detectable way (currently, Git LFS will fail on
attempting to install hooks with that setting of `core.hooksPath`, which
is at least noticeable).

I do think that in general certain types of hooks, such as pre-commit
hooks, should absolutely be optional.  There are lots of reasons to
commit WIP data that doesn't meet whatever standard and we shouldn't
impede expert users from expert workflows, even if there are many fewer
reasons to do things like bypass pushing Git LFS objects (which are
important for integrity).

So I can see the utility of this feature but I can also see how it can
break lots of things when handled poorly.  Of course, we also have `git
reset --hard` and there's lots of hand-wringing on Stack Overflow about
having deleted important data, so we have some precedent for expert
features that could break things badly.

I don't otherwise have a strong opinion either way, although I'd lean
slightly in favour of this series.  I'd of course welcome other people's
thoughts here.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--fi2DrrSHOUsZN9jY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+8RxgAKCRB8DEliiIei
gZZ1AP9TxLkj2w6ppsNmYmtvpeDLvyOYvG0mkdoFk8+Bu+QrbgD+NRjY8bfMVqLY
q4Mj/mTDT1atnmvIwrSsiTVAEvVItwY=
=tLhN
-----END PGP SIGNATURE-----

--fi2DrrSHOUsZN9jY--
