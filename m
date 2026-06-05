Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868B345CC0
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690117; cv=none; b=WfJImd/5b+LdysWv+mPxBOxAnqsQJxxeD3BZ1pSXkbOrGe64kWTLgWAM+C2xYc7FUx8f8Ust50KvKjOjiHnRyayRadD4IC6htvfRHNOMj1hTFPnEzheWZMaTSW3/GalVD8aEbt57wZETx+nrzQiCeeEY1oW2YHT+vWyfZzm6EH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690117; c=relaxed/simple;
	bh=J9bgJb4I2zXLmhTzVeYivVMzirUGYSK9Rokd2dseA+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgbe/raRvJPu7av261udvFFt/y4aFW5Hvxd7vCqMl/Y5CSyrK9ks5vjG0x7lbsoa6plgaVjsI4npQMIksaMCAoWYr9gSh5Kf6nypC2lUyZ50JeMYzwi5vRayPLpnz9518ncLUO6CshcZnT7i9a0geef7TJBVpNap7VSwPh1d9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=duGbpc/S; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="duGbpc/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1780689583;
	bh=J9bgJb4I2zXLmhTzVeYivVMzirUGYSK9Rokd2dseA+w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=duGbpc/STt/9BAG0PINKCUxaKGPvGtchkjhh8VBoLoDyNmgFXBZ0hdgm+WFK10VjD
	 IQmKwlj1X2tk/7EUaE7fOfbpGWOgcWwMvRQaS+pRYMutgi7yLxolMTC9ChAOz2wAYu
	 1nMzok7w74RcjzvGLHB8SBsQ+sinlYFhQ/B7ROIIgLw+Ok/GBD8DipgSmftn+J6p3V
	 /+vrO51EB/nFYWkOenINQGyl3JMn79hSfnHInTBXL8hVSB9g80CMIFVcpJoMiC7GcI
	 I4Eft4YSte7y21TgFNUHDJrNlqrkvyy2xpTdunCJE3ofOpsaPwODGpV1ieEGpP4Oyl
	 qJT/Nsflqf5Yq7aS/Zd9h9ywiPFrUojZAOUNUFFQeKloNBw0ILF61+bhjtF414a+V+
	 6xGonYU4d+dn9OOtLYHDrY3AF8hvPmHhXVVhG6HVaIe/7jWIDxUTGXw6gXb49+o9Te
	 TRsu6O+A4jIGAQS+fcscPWPv8o5WTuJOLGLNfwL8U8wrSuADgfh
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6abe:4f2b:24a3:5d5f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 38FCD200AA;
	Fri,  5 Jun 2026 19:59:43 +0000 (UTC)
Date: Fri, 5 Jun 2026 19:59:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jason Newton <nevion@gmail.com>
Subject: Re: [PATCH 0/2] worktree: copy-on-write creation and shared-branch
 worktrees
Message-ID: <aiMqrVQ6NRl4gImh@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jason Newton via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jason Newton <nevion@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0RR5w//EAa7B3lHa"
Content-Disposition: inline
In-Reply-To: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0RR5w//EAa7B3lHa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-06-05 at 18:49:26, Jason Newton via GitGitGadget wrote:
> When many worktrees share one repository -- e .g. a fleet of agents each
> needing an isolated checkout -- "git worktree add" is costly at scale.
> Objects are shared via the common dir, but the working tree is not: each =
add
> rewrites every tracked file, so N worktrees cost N full checkouts of disk
> and I/O. And a branch can only be checked out in one worktree.
>=20
> Patch 1 adds "git worktree add --reflink": on a copy-on-write filesystem =
it
> populates the new worktree by reflinking the current worktree's files and
> index, then "git reset --hard" rewrites only the paths that differ from .=
 A
> reflink_file() helper in copy.c uses FICLONE (Linux) and clonefile()
> (macOS); elsewhere (other filesystems, Windows) it is probed up front and
> falls back to a normal checkout. Defaulting is via the worktree.reflink
> config (true/false/auto); --no-reflink overrides.

Windows apparently has CoW functionality if you use ReFS.  I believe Git
LFS has code to do this and you may be interested in checking it out.

Also, how does this work if worktree A is dirty (but `git update-index`
and `git status` have not been run) when the reflink occurs?  Does B
have stale files from the working tree?  If not, how do we plan on
detecting that?  (While I'm curious, this should also be explained in
your commit message because we want to know that you have thought about
this problem and have a good answer for it.)

I was curious as to how this would work with containers, which typically
use overlayfs, but some searching reveals that overlayfs does indeed
support reflinks.  Thanks for the opportunity to learn something new
today.

> Patch 2 lets a branch be checked out in several worktrees, for parallel w=
ork
> on one checkout. A branch mid-rebase or mid-bisect elsewhere is still
> refused.

So how does this work if you have two worktrees for the same branch, A
and B, and A commits, and then B does?  What we don't want to happen is
that because B's worktree is not up to date, it effectively reverts the
changes that A made when adding objects to the index to commit.  (Again,
this is a good thing to explain in your commit message, since reviewers
will be curious.)

My personal approach, if I needed many worktrees of the same commit,
would be to create many refs pointing to the same object ID and check
those out.  `git update-ref` can perform a single ref transaction with
many refs, which is especially efficient with reftable.  That would
avoid the need for multiple checkout support, although I could still see
the utility of reflinking if it can be done safely.  If that's a
solution that you think would be valuable, you could propose it as a FAQ
entry or an edit to the manual page, since I'm sure there are other
people with your use case.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--0RR5w//EAa7B3lHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmojKq0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyWW7MtFWO6lb5+wUP05s6G4ghOr3Df+hc8ror2/5Z5T
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACQAAP9AIu5aMAWogBWdteGuXm6xD16W
wgyeOuMBGMB+7sNV9gD/TzdetSw5UdfqaF4K+Wto4vPBdpuGE1OdGWgvo5x+JA0=
=FZ33
-----END PGP SIGNATURE-----

--0RR5w//EAa7B3lHa--
