Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6A7E782
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618728; cv=none; b=G/LuUksHRUIh9xkhwcJ6y+BLPpuwVy7WBNIipOYRV3pVX6REALUseoeHUfoImFwpPgh5K8NTKOQgdq1qgS0g6kHYlllFxfnlPNr9Toae4+I0rUVNQjlqUOVNhNMtiJKyvSESXD7GXukMGHKTa5HDCmGIta0OHulp6AXbHCimtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618728; c=relaxed/simple;
	bh=9JsjxiklyLy3KGeNl6ZCx8/cDzE54pTLqNMHvegWS0I=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XT3jV55NESXSsK5LhSx/LnrdAvVfjHJots55Mf6gHOqHiwO01EeYh7mMwySUlpsM0stDYaibjW0I2Qv7WroJ/wadxK4JcVzhFeenJWAMbDkwJBGqEbJhRjgqXquLjlDzu2zruITwsFbP0Vdw5BKLySIiAGyz/ndb6uBTaoSlFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SS/FsC3y; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SS/FsC3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728618724; x=1728877924;
	bh=ZNwFJR8R2W4w1f3IrykX0D0wpMxkUsHj135t1ctca4c=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SS/FsC3ykP9wPmvufp6DUP+lwxXSL62YjqPNTQAkhFNvs5+c1IqsJ7c+aHNqq88Nx
	 vd+gBo9YIPfPbV6LsaiNsSEnQyMq9beldSrmixwcvnw2U/7ifGK/O7kEaY9NeUZTu3
	 GR5765mKDkOU9oxyFBDmAFYDIuhAGjwIWLU5exYQzxI5ADwtWWbPLQ0uh0O8OIrHNq
	 DGdGdYg+uv3X5WtjW60wkDw85u9wHmsgPENcyvW+nRBWZVoXOThILSe6nBXB+g7FFv
	 nxeoINZLfL3Z8ep9A8gQnwzYQD8KMjA/uIpla4fm3pTzelVX83qZXSWFM4vvkZbJ6p
	 LzQZZd734TA0Q==
Date: Fri, 11 Oct 2024 03:52:02 +0000
To: rbt@fastmail.com
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: `git worktree list` when bare repository is named `.git`
Message-ID: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: bd3f7c42e5a32ea7d035d8573135454bb9c78819
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------55279e5849383c0bbe25f91c1d111eaf924b1091cae487334942ebcc868b0eda"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------55279e5849383c0bbe25f91c1d111eaf924b1091cae487334942ebcc868b0eda
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Date: Thu, 10 Oct 2024 22:51:59 -0500
Message-Id: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me>
Subject: Re: `git worktree list` when bare repository is named `.git`
In-Reply-To: <8f961645-2b70-4d45-a9f9-72e71c07bc11@app.fastmail.com>
Cc: <git@vger.kernel.org>
From: "Caleb White" <cdwhite3@pm.me>
To: <rbt@fastmail.com>
X-Mailer: aerc 0.18.2-69-g1c54bb3a9d11

> It seems that `.git` is always stripped from the `git worktree list` outp=
ut (including in `--porcelain` mode). This becomes relevant with bare repos=
itories. Here is a bare repository functioning as expected:
>=20
> $ mkdir bare1
> $ cd bare1
> $ git init --bare
> Initialized empty Git repository in /private/tmp/bare1/
> $ git worktree list
> /private/tmp/bare1  (bare)
>=20
> But if we create a bare repository in a directory named `.git`, `git work=
tree list` displays the parent directory as the worktree, even though `git =
status` doesn't recognize it as a worktree:
>=20
> $ mkdir -p bare2/.git
> $ cd bare2/.git
> $ git init --bare
> Initialized empty Git repository in /private/tmp/bare2/.git/
> $ git worktree list
> /private/tmp/bare2  (bare)
> $ cd /tmp/bare2
> $ git status
> fatal: this operation must be run in a work tree
>=20
> However, Git _will_ recognize the parent directory (/tmp/bare2) as a Git =
repository for the purposes of commands like `git rev-parse --git-dir`. I s=
uspect this can be fixed in `get_main_worktree` by only stripping a `.git` =
suffix from the path if the main worktree is not bare.

The behavior you are seeing is correct and expected (and I use bare
repositories with worktrees like this).

The actual bare repository can be the directory, in a .git directory,
or in any other directory (as long as it has a .git file that points
to the actual bare repository). The directory will still be considered a
bare repository. For example:

    mkdir -p repo/.bare
    cd repo/.bare
    Initialized empty Git repository in /private/tmp/repo/.bare/
    git init --bare
    cd ..
    echo 'gitdir: .bare' >.git
    git worktree list
    git worktree add master
    /private/tmp/repo  (bare)
    /private/tmp/repo/master

Bare repositories by definition do not have a working tree, and therefore i=
t is
expected that `git status` fails (can only be executed in a worktree) while
other commands succeed.

For the purposes of `git worktree list`, the `.git` suffix **should not** b=
e
shown. You should never try to use `git worktree list` to get the actual pa=
th
of the repository, the docs give the following warning:

    See gitrepository-layout[5] for more information. The rule of thumb is =
do
    not make any assumption about whether a path belongs to $GIT_DIR or
    $GIT_COMMON_DIR when you need to directly access something inside $GIT_=
DIR.
    Use git rev-parse --git-path to get the final path.

Best,

--------55279e5849383c0bbe25f91c1d111eaf924b1091cae487334942ebcc868b0eda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnCKDhCRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADdiwgApC+ZS9d+fxSUNk6qdB/ac1IgyY7CAKJP5ZlorXvmwX5QXm+o
xBEUbr3hotvhHI1iQae1h70IUdHSIOD/+n/2NuH+vxLi+VBOwCmwMcwXiu8e
SlFIp6++I882MbC8PV2dag5oAqJZA7oYsV/t0Z7nuvDsCOyHNEy1m+ctPeVJ
40Jq6cOT5FgscOcIRO38ZeRugBI8q5xuaNFoKK/rbCYj2aMXr6WAcC29ioNY
atPeMsAlvRy3HyOiFXXFaFApt1PrLqSTBlZ+yhtH1tJCUaOB35LPZx31T4Fo
uHR0dRQ96kh36wesYM7MV19qZWk3rZl9H/uWylmGTUaATzZPqQ9Yqw==
=EXBW
-----END PGP SIGNATURE-----


--------55279e5849383c0bbe25f91c1d111eaf924b1091cae487334942ebcc868b0eda--

