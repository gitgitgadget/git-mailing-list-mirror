Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886635947
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 02:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739414985; cv=none; b=MlqM9VcW8bu1Hg/kr7Dy1dHUcOdsWC4LfPnmssM7LmvHeiDGcISi6f8Tp59uIfsSPPpcSeCDG29WIsCE4/vy0++CkTGC4/A7Z/L3ha8cK9vRYEGt0GmW0wcr7E763CCHQ/92Or/yHcQhhlOe0md3dZpAHuNUg/yGXQNtwoWlrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739414985; c=relaxed/simple;
	bh=DHyCmpJkh7fCtQqqLEpxFMxCTfyj6w7WDI131c01Pcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTZ2Nmyk1o1Nz2gZKy6p766XAbUlemwUt/NTOGawjv1kHcyhQbOpAXLPVGNAKreX1I2C891n7qoNxuA3OruePL9nUdMFoBYeP893UwpOfkYb6MBvuialqr4zihhgSL9Qr0tvr6a67GihMB6kijaF//LKxFe2FYf8q0/aRnAEDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Eq28f6Hf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Eq28f6Hf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739414980;
	bh=DHyCmpJkh7fCtQqqLEpxFMxCTfyj6w7WDI131c01Pcg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Eq28f6HfCoZchq56s6XWFVchT9vJe+R6um7xt27hhC8hDj4K62C7mJJCzBYRdNaI3
	 bVTrxbRaiOaD9gVwh3hMxQCkDQZbJzB7CD0hWryQljGed981rOpX3LTjmnk7qy6uev
	 Om7XjV0hr8UDPVEaKb9gePMmme1SzIZ75plMb3ghH8bkEiMp4Se0GlJXF1ONalqvcg
	 T27w1HalBf8GM53WOFR20cUhVMWQzbdtV5h6u5mIny6EMX5fooiD3DopRmqBIU3aS8
	 SUDdCxkFHGXYfBb3j5SkmtBr6TJLmakampia5MtXBjIvjzwMiHWBHUayKg5RJ/l0yJ
	 yDZPizqef2HpSkE+d5aWvi3whnhrziZcsqJbOF6H1XJi7b7LKwLiH77ucu2rzWq1gb
	 93kU2ur2hpsGq945C0Kx4SmGi9bz9aveMJ0xRgRt5bflhAePjxjj0G7OHX8MX6D87p
	 T7wrq1gmaA5iRBJFOi6H+3RHI5QpHtusK51KUB91pBQugsSrWo4
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B192F20078;
	Thu, 13 Feb 2025 02:49:40 +0000 (UTC)
Date: Thu, 13 Feb 2025 02:49:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jayce Cao <jaycecao520@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Get the commits to be pushed accurately in pre-push hook
Message-ID: <Z61dw-pzJKgs7U-v@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jayce Cao <jaycecao520@gmail.com>, git@vger.kernel.org
References: <CAGwx5_8wNzE51Z7pYA_skimZZ29b8C_Bxk_58kPOqcWAmSQpHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RRCa916yrnDmwrLa"
Content-Disposition: inline
In-Reply-To: <CAGwx5_8wNzE51Z7pYA_skimZZ29b8C_Bxk_58kPOqcWAmSQpHw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--RRCa916yrnDmwrLa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-13 at 02:05:47, Jayce Cao wrote:
> My goal is to check the commits to be pushed in pre-push hook to see
> if they contain sensitive data or not.
> I have an assumption that those commits which already exist in remote
> repos have no need to check.

You will probably want to read
https://git-scm.com/docs/gitfaq#restrict-with-hooks.  It's very easy to
bypass the `pre-push` hook locally by using `--no-verify` without any
way to detect that, so assuming you want to have an effective control,
you'll want a different approach.   Note also that I don't believe
libgit2 or other library-based Git engines invoke hooks at all, which is
also going to lend itself to probably adopting a different approach.

> So I read the Git doc and pre-push.sample file, I know that if we push
> to a new branch that the remote does not have,
> $remote_oid weil be zero, so we need to examine all commits in this
> branch. We can run `git rev-list $local_oid` to
> get all commits to be examined.
>=20
> But consider this case, if I'm developing a huge project which has
> millions of commits.
> I create a new branch (we call it feat/awesome-feat) based on the
> master branch on my local repo, and create three commits.
> Then I run the `git push --set-upstream origin feat/awesome-feat`
> command to push the three commits to the remote.
> But when the pre-push hook is called, `git rev-list $local_oid` will
> print millions of commits. The commits except the new three
> already exist in the remote repo. And the `git push` command will send
> data only in the new commits to the remote, instead of all
> history commits.
>=20
> So I mean we've no idea which commits will be sent to the remote
> indeed in the pre-push hook when pushing to a new branch
> that the remote doesn't have. I found a workaround:
> * Run `git ls-remote -q -h` command to get the commits the remote has.
> * Run `git rev-list $local_oid ^$haves` command to get the commits to
> be pushed.($haves are the commits obtained from the previous step).
>=20
> But this workaround seems to be stupid when the remote has many
> branches. I wonder if there is any better way to get the commits
> to be pushed accurately in the pre-push hook.

Git LFS has an optimization where it uses `git rev-list --not
--remotes=3Dorigin` (or whatever the remote is).  This excludes objects
reachable from remote-tracking refs for the origin in question.

However, this has some limitations.  For instance, if the remote is
specified as a URL and not a remote name, then there will never be any
remote-tracking branches, and this optimization cannot be used.
Notably, I believe EGit (and maybe JGit) _always_ specify the remote as
a URL and never as a remote name, so this will not work there.

You may wish to inspect that project's source code for more details.

I am not aware of a better way to do this, but as I mentioned above, you
may not want to do this at all.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--RRCa916yrnDmwrLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ61dwwAKCRB8DEliiIei
gSU2AP91UeuPh6p9dJnYa0NrXAYIx5ldjl+Aq1ZF3NxLt/jfqgD/YMVpxJh/XNgv
qgAmNPuzq1auHBCi+4/giiuKLBWrVwI=
=j7GT
-----END PGP SIGNATURE-----

--RRCa916yrnDmwrLa--
