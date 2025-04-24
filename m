Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9519DF4A
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533956; cv=none; b=R2PGhdD3Fm9bTwO6wXKp5ZIh4RTyy2FGN9TE/ngrpLvv+e4XEcQvd5aQ2ZssDF9OHhKf5FhU7Ec8P7nSyaAnDbg0IZ7Ik17J03pbSmh7B91n1elGRO1vZOmEJfqQnGE6rw0c6xZt4V/IQdh9ajIdy1yi/klY2YiLJHuwTD1+0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533956; c=relaxed/simple;
	bh=XuR1SSXn/+Ou3cywxOEEHeyUnbHA4aaK5AX9Nas7a8U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bvAnNV+KVJRcLh6kahj+kEXHKpgWLlZfAZ77PaJ/8a5Hj4J8upCoOby71BprKyXVl05rYA8WhgzhgIy5tPhr3DXP0Cx5/KSpUA1TNhJr36BDpWrARAWV4Jpp0e2IiQ1791xrmfePXQ+D0kV4VyLlFZDwAzGbyHwvKJ5qbRQuT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lRXFyd2i; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lRXFyd2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1745533952;
	bh=XuR1SSXn/+Ou3cywxOEEHeyUnbHA4aaK5AX9Nas7a8U=;
	h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=lRXFyd2iBiY2ztTUxcNQ7Nmo3izC4Ixi5Aidmfbv8gw/Bx7Wao7IFT+oBgQMtV2HF
	 W7XvQGZ+7OX3sZ29MXu7az3Tz2yHPbE6gHBS0LMzWQmmBrehrcp/vNfZNUWOLiNN4+
	 JrORLHmWKnR+8/UwtD41lOr+tb3P3P8mOO/WFxI6rG3736DjsT03F52P2En6pflTqv
	 vhvrleaXjVu9QfvyfZZ4HY07B1TTm1fXSireic6DFwyBisE/3EwjJ/K0c3zq5IrsGo
	 tqXSjPSzELWmjvfBok14Sjpec98e1g+a1FyPGoLf7PkSNKAw70HgrEuwNTOyP540Og
	 VnVUuBRgnh8OGAL+sKeNAb7gg1nYnC52QqQeR6/8kbNx9r7ttMp5Rg2bPvrM30nVwF
	 TIZ69mOjjeYWo5Zp3ySPxP9rxEdGbKdc20t0USujvjmMJFFJHttgHTDlay42/dV71k
	 4r8sO2nERFuUGvy+atTGiB/0cSYuw3hPxCImJmpulXN84ZIkJZL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CF29F20107
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 22:32:32 +0000 (UTC)
Date: Thu, 24 Apr 2025 22:32:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Acceptability of replacing .git internals with symlinks
Message-ID: <aAq7_7pFTToMPX48@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OhfusFqUiGoj/qOl"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--OhfusFqUiGoj/qOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Git LFS has gotten a couple of bug reports[0][1] about it failing when
some of the innards of the `.git` directory are replaced with symlinks.
This happens because the Android `repo` tool creates repositories this
way; why that is, I don't know.

I know _part_ of the problem for Git LFS is due to the fact that some
operations are run under, say, `.git/objects`, and if that's a symlink
then the path canonicalization puts the directory elsewhere and the
`.git` directory detection fails.  I don't know if that's all of the
problem, or just part of it.

My inquiry here is whether we consider it acceptable for tools to create
symlinks from Git internals in this way and whether this is a thing that
should be fixed or not.  I haven't tested with alternate Git
implementations, such as JGit, Game of Trees, dulwich, libgit2, or
others, so I don't know how gracefully they handle this.  I will assume
for the sake of discussion that the symlinks can be created successfully
without elevated permissions and the OS and file system are fully
functional in this regard.

I know symlinking the `hooks` directory is common and semi-suppported,
but I don't know how we feel about other directories, such as `objects`.

If we _do_ want to support this, then we should probably add some tests
for it, and if we don't, then we may want to add advice or diagnostics
to discourage this behaviour.

[0] https://github.com/git-lfs/git-lfs/issues/5426
[1] https://github.com/git-lfs/git-lfs/issues/603
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--OhfusFqUiGoj/qOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgKu/8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ55eWqHLmQicyrgH1dN1mi93xztSne2cAl4KEbkF78c9
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAU3AP9TcIowzje4kVGeILWC9ni8TQj5
eGv9IDGYnNSJS2qUqgEAtYLbt0qLSbY2knG9STIx4yV93dxBWCnCZNwZbWl9IQ8=
=G4J1
-----END PGP SIGNATURE-----

--OhfusFqUiGoj/qOl--
