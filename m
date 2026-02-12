Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619832D0DA
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935955; cv=none; b=K7ZFadvs03DhXPRt7AL9wP7T/5OkGsXR3d8bCoZxlxxNBYn/hGAWLq6Jq/4IlZnsrgf564KpWcpQFpZhCii17M5c0+6tL4PprekNLB8i6hcAGZvqyBmJikOCPdgHeSvvta0JSz4WwR9XaK7MkDHUPuXW30N2tTUqo/ERLkvh2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935955; c=relaxed/simple;
	bh=Uqe/X06xqxbzcFthWj+yWXfMs21tThyy+aRlstaWWnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgB0DMoNr8f7wLsndVYCQbAGoMq0urVhPRdq3fMZOiBaMbaid8EWggwdO5Spw4sSGtR3OfrJRl1IC4GMaljHT3Pq21aFejQGOuxQGnLbMv/6irFey1mqY0RQchzEBVAS9DnT8GFfLYvZnurZW5LJuB+yteiO0K46y6kyUAD3aMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=og/H0UQi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="og/H0UQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770935947;
	bh=Uqe/X06xqxbzcFthWj+yWXfMs21tThyy+aRlstaWWnE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=og/H0UQiVJYmi3zi78kwgm66Vr5TZ35WfzAmBa5rR/pTRkuTZ1mPCyHM83T8UPjrT
	 LS2zs1uel4axSlGUaYcjMc1K9Lpfz0r9IkTC0xAfZnbbitEWUCKy9mfcYlzRRuaCk/
	 xDcGJHif+PYP9DPGiFO3kMt9pkQ5nkz4ZnfrvZNCbjwaZ0cCTuvF6ATWKoGXxw+Uqp
	 dMKqBq/1rMX9bcNRcRamA+2j9iUn5oLNiakx/PfY39KLUtFaa5LnQ1rBtr0chINBhq
	 Mj+NnMktV9pzAHYZA0lWHqEDLMuQe2DAUeCGIOF6h9kVhTbGyOoEARgfFXr9G0p28I
	 qO0/YSS7F6M5YcfueGuTqx7MQ0vd73BNX59yqhcvRWCyCLmx7/ysZ9a0yAkEXt5K0/
	 R1cvJf8u/PdBzKmD3kDqvcqb3iGRYwMcDZUiLzjmXmOC6J46v6VuNL6y8MZODCMAed
	 bfy+UQ9IAg5zQv0drb9cN+5Qs4yO4rlF9ifFyfDVjL0KACldGCt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e298:762a:be2c:ed79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4F226200C7;
	Thu, 12 Feb 2026 22:39:07 +0000 (UTC)
Date: Thu, 12 Feb 2026 22:39:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC] setup: fail if .git is not a file or directory
Message-ID: <aY5Wid6eg1-LwZm8@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
References: <20260211182122.35352-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2fOLUmqz7YwVTuk"
Content-Disposition: inline
In-Reply-To: <20260211182122.35352-1-a3205153416@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--t2fOLUmqz7YwVTuk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-11 at 18:21:22, Tian Yuchen wrote:
> Currently, `setup_git_directory_gently_1()` checks if `.git` is a
> regular file (handling submodules/worktrees) or a directory. If it is
> neither (e.g., a FIFO), the code hits a NEEDSWORK comment and simply
> ignores the entity, continuing the discovery process in the parent
> directory.
>=20
> This behavior can be very dangerous. If a user is inside a subdirectory
> containing a melformed/broken `.git` entity, the Git will traverse up,
> attach to a parent repository and might execute destructive commands.
>=20
> I tried to resolve the NEEDSWORK by using `lstat()` to explicitly check
> the entity's mode. If it is neither a regular file nor a directory, we
> kill the discovery process.

We used to allow symlinks as well.  That was used instead of gitfiles
for submodules at one point, I believe, and there may still be some
people using that.  A brief test indicates that that functionality still
works, so if we make a change here, we should be sure to accept symlinks
as well.

In general, we should allow people to use symlinks wherever they can use
a file or directory unless we can definitively prove that there's a
clear security or functionality problem that cannot be avoided.  Git was
originally written for Unix, after all.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--t2fOLUmqz7YwVTuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaY5WiQAKCRB8DEliiIei
gUGxAQDv0KX4BJWuhQ3Zd1HUyy8dFZ95dp3PdT2Br1LV6CZQcQEA7nymBnBBEp3V
k1j7t9D8shk9g074A/qqFwppC167dQM=
=jupC
-----END PGP SIGNATURE-----

--t2fOLUmqz7YwVTuk--
