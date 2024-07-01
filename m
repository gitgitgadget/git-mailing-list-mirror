Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91116C86E
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851269; cv=none; b=IQl21vb5xtu4IttRGs3Q8C+bvws8Ba+QGYX/7cRLsVA3+WAaeqUGRwYo2Lm9y7nfnwrfvKDz8wjF5kX9+ERTY3HhnRZ39EyS/O4Cn7QCFCDlIKbe0z1Eyh1Q6jD6ZP8OIwuv0N0yTH7wu7wRdQBsWFBVJS6ohYxbpGu7A0xWDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851269; c=relaxed/simple;
	bh=HyTR9Wvb/6A4zC3a6gB3cW2Z9ee+CcbXmBLUbD5kZNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADI7H05ey3B49vF8HPK1PYksEpgMq/Zc9nR9U/5eE84tIuasVUOXQmm2G8JRdlcrIdciTaCRsKJ0wj7Md2cmgNdGJgzpr9w5V9sMoHZXeZTsxYZ3ryhV0WUsH86ynZsfNlLOBO30xWI+dKGIjeTbyanQNsk3VpgsKRoDpyNVSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nqUr4Cze; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nqUr4Cze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1719851264;
	bh=HyTR9Wvb/6A4zC3a6gB3cW2Z9ee+CcbXmBLUbD5kZNc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=nqUr4CzeU6/zY32vY2k1snWnhMV01oNKUhGP89zz37zAB98wd+DdvjOfkdSKzO6TM
	 iROUYXL5nXSIVONsk6R+THkgUvRLif2bK8LBNV4OjTrErGJxRq8OfD/VL0YDOsNIZ0
	 CtBm0YTAGEtjAdm7fcgbiWEkkmgdQW2oB6a7padjLFhJcDOFvptDm/AFzdJvP4PniK
	 gZW346GGcedntby2zedpqr9lm5o+YdajmMgb9SIbRBjjS7xqbzDJ3x9YvPPn53I4Mt
	 5yYBWA8SyExTMkcXls9JEoWqOQC00AIqD1Zz23TgY+BHGkEoaEwjbC9pFCbLjpp6Bp
	 Ik4BdonjI93a7rSM2n0iU4Q1FaapXf2jVUrR3WVi1/KESCXjCovunZGHUi6p2z7Z0U
	 YoO5DGuoccCAYDRrzmQD8HHGFdQemXCVL0GUymC45SqJFWo5eUFryZRFgxtE15REuR
	 xJei/F9F1qUc6HHZd1XUczFJ65Vc9sovY2dkRMbzOYb0JV4omKK
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A8B0B20992;
	Mon,  1 Jul 2024 16:27:44 +0000 (UTC)
Date: Mon, 1 Jul 2024 16:27:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: limin <1159309551xcz@gmail.com>, git@vger.kernel.org
Subject: Re: Git remote origin leaks user access token
Message-ID: <ZoLY_yxpQBjmp8O3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	limin <1159309551xcz@gmail.com>, git@vger.kernel.org
References: <CALFtjBBvk+JPmU_GzrnM=ANwaQDdiLtzh4YkZFbcVENyCu9fxA@mail.gmail.com>
 <ZoKW-yDJMsz9JPSI@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hc2e9AQQUlDBa0YJ"
Content-Disposition: inline
In-Reply-To: <ZoKW-yDJMsz9JPSI@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Hc2e9AQQUlDBa0YJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-01 at 11:46:03, Jonathan Nieder wrote:
> (+cc: git@vger.kernel.org, git-security -> bcc)
> Hi!
>=20
> limin wrote:
>=20
> > Hi, I found a potential security issue when running a tool in my private
> > project. I think this exposes my personal access token to danger when u=
sing
> > "git remote get-url origin".
>=20
> I'm moving this conversation to the public Git mailing list, as this
> behavior is well known.
>=20
> I look forward to working together on ways to reduce the impact (for
> example, ways to encourage people to use their system's password
> keychain instead of including credentials in URLs).

I'll point out that we already document this in the Git FAQ (git help
gitfaq):

----
How do I specify my credentials when pushing over HTTP?

The easiest way to do this is to use a credential helper via the
`credential.helper` configuration.  Most systems provide a standard
choice to integrate with the system credential manager.  For example,
Git for Windows provides the `wincred` credential manager, macOS has the
`osxkeychain` credential manager, and Unix systems with a standard
desktop environment can use the `libsecret` credential manager.  All of
these store credentials in an encrypted store to keep your passwords or
tokens secure.

In addition, you can use the `store` credential manager which stores in a f=
ile
in your home directory, or the `cache` credential manager, which does not
permanently store your credentials, but does prevent you from being prompte=
d for
them for a certain period of time.

You can also just enter your password when prompted.  While it is possible =
to
place the password (which must be percent-encoded) in the URL, this is not
particularly secure and can lead to accidental exposure of credentials, so =
it is
not recommended.
----

We also have a FAQ entry about how to read credentials from the
environment as well, since that's a common thing people want to do.

I also recently added support for putting credentials that are not
username and password (e.g., Bearer tokens) in credential helpers
specifically for this purpose, since people were using
`http.extraHeader` for this, which is equally insecure.

I do want to point out that several people, not just me, have worked
together to make using a credential helper as easy and robust as
possible.  I mention this not to contradict Jonathan, who I think is
also trying to help in this regard, but mostly to mention that as a
project we've been trying to gently nudge people into doing the more
secure thing.  If people have further suggestions on how to make this
easier for users in the future, I'm very eager to hear them.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Hc2e9AQQUlDBa0YJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoLY/gAKCRB8DEliiIei
gQxBAQCsMsJsqngvMOqEAGEZUoxjFKcT1fne+owJW0yAA5TnfwD/ZEOXYa78sCs6
BjCXYJ5+joF5MxKPNo2A3D5Fq0w6yQE=
=tECk
-----END PGP SIGNATURE-----

--Hc2e9AQQUlDBa0YJ--
