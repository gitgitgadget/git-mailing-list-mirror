Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7790366051
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059357; cv=none; b=fEaxXEEitBASBeFA07CtGLN2GqBAleu5Q5Mw+/l/byOKFE+IQJsXzAKVVbOuVvYCQgzl8hzoxQfnktDpbXej2MnWrAzG6WjkLxVK9yD2+Sk5JMv7Hv6jocq89QzDVwEO4tBlhh0lfCvkx8zC8Uw0w7JEydJSJk0SnKZT47zDJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059357; c=relaxed/simple;
	bh=EFSBS6LGXrCrmUX4VzvZ7y7jJDMHaJq8wsFwpceEWlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2xFZ6K2nI39ZSYv9ytVGnWSWBP+eyw8s2d0PBY39s3oMS/0uUxV0lWG1vhMt1ehrLhgxR1Y892bKo6i7Z3SR30wffg+eqVPT6Eu2dyJK5gg1rNEPIMLzaLeBNYw8+cOD5BRVvQIc1j2VVSv9FbAp7MtlpcpvF/aH9KOzF0TQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hGTaf53p; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hGTaf53p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1777059353;
	bh=EFSBS6LGXrCrmUX4VzvZ7y7jJDMHaJq8wsFwpceEWlc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hGTaf53pEzlFuqBPQWbXASzuQpyvfPjWG2t6NVeqGwDteWaKRLcjRB8dFXlojq6VA
	 MWZIc6gLcdNiULQ+BzyroamITofhn85EA41Rg5+MsgBBki675VkUorT2O2UYUnsHnI
	 ZsuIxUytw7BGNS8StKw4N3Yhq1FfMZ8taCb4VqkD+dquZ9eTuAJOnvdaizdjB54GIb
	 iQKeUGlNBvgOowPzWIYyouswx01l0RBbsw+XScnfGeKe3peD8laZ5EEWrczgvZNkvZ
	 hUO+QMAVQhCSI2QfE//lfdSXhfzd39W6a477HDGlmqLWPSxDxI1/uuQ1wPZaID5MT+
	 xPhpYvR8GKExy1U8oDRG/rB/eNeOW/hlPMi6e9+Y9WqI/HRZZTdjXT0Fd5+vlL3Fkq
	 b0GeHApIJlFF5aGgf0VHIJSstOZ3ENgVQAQdEcwZdY4pwVk1R1ms5uY5/F9nffr90F
	 vkwatQ8F2um5issQATZ89J0I1bPyIJt6Fjzq80UgkwkO3wuDz5u
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:55cc:40d2:74ee:685e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 15D212006D;
	Fri, 24 Apr 2026 19:35:53 +0000 (UTC)
Date: Fri, 24 Apr 2026 19:35:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Caleb White <cdwhite3@pm.me>,
	Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Andrew Berry <andrew@furrypaws.ca>, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] dir: use per-worktree repository ignore patterns upon
 request
Message-ID: <aevGF3z5VtQLxJm3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Caleb White <cdwhite3@pm.me>, Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Andrew Berry <andrew@furrypaws.ca>, Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>
References: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4aPbQjYovgn9riO"
Content-Disposition: inline
In-Reply-To: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--s4aPbQjYovgn9riO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-24 at 17:09:19, D. Ben Knoble wrote:
> Today we have $GIT_DIR/info/exclude for the main worktree, but $(git
> rev-parse --git-dir)/info/exclude for secondary worktrees does not
> actually contribute to ignore specs; instead, secondary worktrees also
> use $GIT_COMMON_DIR/info/exclude.
>=20
> Some users may prefer each worktree use its own ignore file; some may
> prefer both; some may prefer the current behavior.
>=20
> Add, test, and document extensions.worktreeIgnore that controls which
> set of ignore files to use for worktrees.

I was wondering if we could make something like
`extensions.worktreeInfoFiles` or something and also make the
`info/attributes` (and maybe `info/sparse-checkout`) file used instead.
I think that would be somewhat better than having additional options
added on after the fact and be a little more generally applicable.

What do you think?  My apologies for not mentioning this sooner before
you'd already sent a patch.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--s4aPbQjYovgn9riO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnrxhcJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9g3ZtAq9Ht+/yAzJnuBdEKHR+UKBnvc9nYsrVZx77mS
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKt2APwNNY+8a2ac+nNpbHe5bz5Mn3qv
CTKdeAE8AkUQJFq8bAD/e1reMVM1PoP6yv10GJKEPYLD0sL6hWp2hoIeBM5Z6Ac=
=6JbI
-----END PGP SIGNATURE-----

--s4aPbQjYovgn9riO--
