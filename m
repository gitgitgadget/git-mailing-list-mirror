Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C956B72
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193367; cv=none; b=s2NMqxuBEcIOpb/9QGOiHudxMXFAuvjfHbBQvMgyjCvFQacR6zy1fwRIvQpApzJISvXAgOaVeD8i1FnV1I7hWVcFIPjCHh3+9s7o14VNK0kHw1PemEJEEJ5LaEriknIPx+/zG+kluMzr9xKupZoFA7whbANvnGWzeF9hJ1XuecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193367; c=relaxed/simple;
	bh=aSDc+DEzvB1rN7c47YEuLqu9nJpvgCVvahFVNN+Y5h0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Md7Ckgk1owQniI5P13AsoFuqaPiS4ScUTsO7r6GFi03Jwz110WQUsg+nrKChuOyp/WTgF7NVzEFKMdNuxIhnt/kxxQkzLKlyyz6GzxCzKWNpTSnzKnTKKyou2tMHqoYbPoNf+eZwSxEZzpT4Yr7H9H9sTpKsQqElDkgJudfM+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: "Sam James via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
In-Reply-To: <pull.1606.git.1699010701704.gitgitgadget@gmail.com> (Sam James
	via GitGitGadget's message of "Fri, 03 Nov 2023 11:25:01 +0000")
Organization: Gentoo
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
User-Agent: mu4e 1.12.0; emacs 30.0.50
Date: Mon, 11 Mar 2024 21:42:40 +0000
Message-ID: <87frwwmomn.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Sam James via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sam James <sam@gentoo.org>
>
> This patch adds a config value for 'diff.renames' called 'copies-harder'
> which make it so '-C -C' is in effect always passed for 'git log -p',
> 'git diff', etc.
>
> This allows specifying that 'git log -p', 'git diff', etc should always a=
ct
> as if '-C --find-copies-harder' was passed.
>
> I've found this especially useful for certain types of repository (like
> Gentoo's ebuild repositories) because files are often copies of a previous
> version.
>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>     diff: implement config.diff.renames=3Dcopies-harder
>=20=20=20=20=20
>     This patch adds a config value for 'diff.renames' called 'copies-hard=
er'
>     which make it so '-C -C' is in effect always passed for 'git log -p',
>     'git diff', etc.
>=20=20=20=20=20
>     This allows specifying that 'git log -p', 'git diff', etc should alwa=
ys
>     act as if '-C --find-copies-harder' was passed.
>=20=20=20=20=20
>     I've found this especially useful for certain types of repository (li=
ke
>     Gentoo's ebuild repositories) because files are often copies of a
>     previous version.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1606%2F=
thesamesam%2Fconfig-copies-harder-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1606/thesa=
mesam/config-copies-harder-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1606
>

v2: https://lore.kernel.org/git/20231226202102.3392518-1-sam@gentoo.org/
v3: https://lore.kernel.org/git/20240311213928.1872437-1-sam@gentoo.org/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZe960V8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZAUAwEAqguyh1f34AiHHIAzwN8OBvW82TJRoSx5NITS
oOk9m0gA/RWyBnA0OtIHKbGWYYiO6wj7/ksW0U7YQH6IsmEo1zII
=aq1v
-----END PGP SIGNATURE-----
--=-=-=--
