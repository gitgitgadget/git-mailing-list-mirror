Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2E25D21D
	for <git@vger.kernel.org>; Fri,  9 May 2025 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821720; cv=none; b=qH+1orAGVjOhBr6H6MGRZXaKs9+aioCGmtSyvIIGwDnBwlC2a3VfBBgau7fDuT188U7mGOZpWCyKRt3/gWavtI71hjzejWoILmj0oB9UGh8sI7s1hFT/X2ONBzK5eU1Ra0lC4fok2/uJB2xfS9iUKYwr2InpZyGAKSNHmT1/oIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821720; c=relaxed/simple;
	bh=/n9UtRRSST9uKt6+yY7rCOchMnKP1lZw8gDwEyznQ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGVyDbCzExOuzshgm886LpyhG8s6giY2+m6egIzJO0iH8K+2/Sqfqqk7bLGlZTcfLR0Pcz3QUi+qGada/ImISZcvSUlTFK0elNqBFxRYrmEPA3HadjmPVy18mB7s9unS4DKjVRc5jXr69IW/lnw6lrebB+GRShTNS9sFg/2/3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KKyuBe1x; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KKyuBe1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746821715;
	bh=/n9UtRRSST9uKt6+yY7rCOchMnKP1lZw8gDwEyznQ8o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KKyuBe1x9MXbOz0EO14boYJZ+lpHzAY9elXpuCz3UrV53mgY6W15uGvgQTYyuvyPo
	 iZFiNOsUq/mlg3Yg3/AENtNcSJ0r5ps0y8QexKvroRQ8NHBJTSKzepCFjlAUCJdWzV
	 +Sv/J7XGRYI5hP8ZxrqELKPmMc/srNmBD42gWOYteLx6Lz7P0NoBynhZ28s7YFsCZH
	 86GZEEBmQcIXeD+s/A+nros+/BpNDlB8IIrs/tIK42CFbqIbqBPziOp8eEr89JubgR
	 WYxDqWbYcBtXx3BROdIToXjjee17lw5qU0MfbzszLwcAjg4kUoj9UYvKRTdDcii34y
	 Sq0LQKoMq7rabHHXlkvUJBIZTPNWQt76lWHJn5EFmNj7f7JXxlx6UCikkjEm2V4PaN
	 OGT71fuODVtuG1pMgLzG5ujeUghO8JqRv+VRg/xUXLq/YtzU6/B0Ckef59iZl1Kkht
	 2hprAVp7Jg0LCXIksUmPp4hExWRcHlIVLVXXbzwBL59HAZOPO1S
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5DDE7200C6;
	Fri,  9 May 2025 20:15:15 +0000 (UTC)
Date: Fri, 9 May 2025 20:15:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/4] Importing and exporting stashes to refs
Message-ID: <aB5iUmASx7BxgbAj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <CALnO6CDDrd=XpkkTFYfAoiNcoG5q83Z8c+Ey4jKTBriA=M7TwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2GIQGxwhGtVWZAhc"
Content-Disposition: inline
In-Reply-To: <CALnO6CDDrd=XpkkTFYfAoiNcoG5q83Z8c+Ey4jKTBriA=M7TwQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--2GIQGxwhGtVWZAhc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-09 at 16:53:17, D. Ben Knoble wrote:
> - Can't we "git push <remote> stash[@{n}]:<branch>" to share a stash some=
where?
> - And then, doesn't "git stash apply [--index] <arbitrary sha>" work?
> (At which point you could presumably create a new stash, though I'll
> admit that's cumbersome relative to dedicated export/import.)

I haven't tried, but it does certainly seem plausible that you can
import and export them in that way.

> I can see how that doesn't help you quickly export a whole _chain_ of
> stashes, so I'm not saying "this series seems like the wrong tack"
> (far be it from me, who doesn't understand your use case, to say
> that!). Rather, I'm confused about the inability to move a (single)
> stash across machines.

Let me explain the intended use case here.  At work, many people use
GitHub Codespaces, which are throwaway development environments.  Since
one's whole set of stashes cannot be imported or exported, it's hard to
use stashes effectively in such a case, since they'd be deleted when you
destroyed the environment.  I like stashes a lot (my personal Git
development repository has 153), so I want to synchronize all of them
across.

The other case is people who routinely work on multiple machines.
(Remote or throwaway development environments, like GitHub Codespaces or
Devcontainers, are just a special case of this.)  Many of these users
want to keep their working tree and other state across machines and lots
of them rely on cloud syncing services, such as Dropbox, to do this,
which often ends up corrupting the repository (as outlined in the FAQ).
Providing a way to quickly and easily synchronize the working tree
across systems, including any stashes, is really important to encourage
best practices that don't result in data loss or have unpleasant
security issues (such as untrusted local config).

> Unrelated question: Can we import arbitrary refs into stashes? That
> is, what happens if the commit structure doesn't look right? (Maybe I
> should go read the tests and see.)

That doesn't work because the commit used here has to have a fixed
number of parents, since we need to keep track of the index and the
working tree.  Stash commits, even the regular ones used in the reflog,
always have to have a certain structure.

If you try to do that anyway, you get this message:

    % git stash import HEAD
    error: 3bf235c35ef51d01663f2ab9665026b05b8af1dd is not a valid exported=
 stash commit

I did try to avoid people accidentally destroying data.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--2GIQGxwhGtVWZAhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgeYlEJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/gZSjNEqLg9iQU+UgaZgYr/igyjqymG+oLdoZRjvFMd
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADr/AQD+BzEpquoCcTn6ubLE6mP0NaOq
LSylpHSCab49c1B04wD+KC1xVW7Ey+mNcoU9LPSPhGAGpjkHA+E5kOKni2dlbQQ=
=uMLV
-----END PGP SIGNATURE-----

--2GIQGxwhGtVWZAhc--
