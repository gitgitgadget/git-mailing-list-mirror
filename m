Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FA1F952
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373420; cv=none; b=FR8pUe/GllOjQHTGuy+vZk9N/S+r41YDLqkQZqajvUzQXsf+45QzMH6D9YPa2Yl7HprG7iD0PEylhsu20DT4AYzl8aUouLD5oUJ5C4aUKbWBoE2S6stbKlr/RYh9EWceK8Jb2ejlzroFZK2EltmXr9kEQN2bwvhGSUM85XSQVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373420; c=relaxed/simple;
	bh=GUSj4uy8dzA6I30xRBulDMj1oHMa6gBK5h2yaGj2lns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKy0ko83NOHNJPrhexgFsNzgmS4RhnfSmRmOz9PD2krjqGlIYXfYDyOCSYAT5vELnxgMZfPTWgFkaX6XhAn1e0osH7pqrEcxjZRxQu9JjB4+26OOI9NJTBFjMSjEECFxDe2S3+rAdgdit2MJEcvvSGh0znIk5uXsktcPaqXGgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zuh8MDVo; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zuh8MDVo"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A37995B31E;
	Mon, 19 Feb 2024 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1708373410;
	bh=GUSj4uy8dzA6I30xRBulDMj1oHMa6gBK5h2yaGj2lns=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zuh8MDVozvSD57iex+E+CIPtcGdUt06EpUXwqVfU1L7NMPiaj9cWFHWhIkESaEOKu
	 320K0NzxG9RR6IxEpKcjxc+HWXPU0RrhEE0jlrnNHZVKMvF5ZbAFLVBEab5/9T9lOp
	 ZF72rIHUzc8Xdq445sLyarcVwo48hhh1lQUKNwYRWBEQ3ZkhIZdfAVIlL9d+LeX48f
	 xKlIeETuj3W1yMiri7vgbZG6wiTkfERZ8T1rufe+ELevrh3o8Vgu0iNuA+eIhwsWZj
	 b0u77NgvUAphCU80HdN5Qn8QQ29W6+7Y3UNOfLGiV6zhp7ihoPLASHps/s+MuOFeMW
	 y/tN2bwCjCCPsRIezHlpDPnly0GUaE6zGygnep4UunsYWNgbHfc8emjhusp+xqsyyy
	 HVpOMrdmnKniwtcExr1W+6WfuFDd5eNFE+sVb4sGn/hXUYvW4ljBFshg208HRrnfHv
	 C13WbAB1H8O4rIWYzr55A3nOS37wRLvyWaR9ifElpKBZaXXB3Tl
Date: Mon, 19 Feb 2024 20:10:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Dominik von Haller <vonhaller@fastec.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why does the includeif woks how it does?
Message-ID: <ZdO1oL73SF5ZKOJT@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dominik von Haller <vonhaller@fastec.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <FR2P281MB1686B7258CFB60A0F33FE108BA522@FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6y3L7fVVOo94eYP4"
Content-Disposition: inline
In-Reply-To: <FR2P281MB1686B7258CFB60A0F33FE108BA522@FR2P281MB1686.DEUP281.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.12 (2023-09-09)


--6y3L7fVVOo94eYP4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-18 at 15:37:29, Dominik von Haller wrote:
> I have been playing around with the includeif from the .gitconfig. It did=
 not work for me at first, but after some help, I did get it to work.
>=20
> If you are curious. My Problem and what else was discussed here: https://=
github.com/git-for-windows/git/issues/4823
>=20
> Anyway. So, I was trying to access the email property which was set throu=
gh an includeif config. It did not work because I was in a non git director=
y. Yes, I do know that the property set in includeif is named gitdir, but i=
t was not obvious to me that you need to be in a git tracked directory for =
it to work.
>=20
> I am trying to understand why it must be this way. Why does it not work i=
n non git tracked directories?

The main reason it works this way is because the goal is to adjust
configuration based on the location of a repository.  Thus, if I have
`~/checkouts/work/` with my work code and `~/checkouts/personal/` with
my personal code, I can set options that are appropriate in each case
(e.g., `user.email`, `user.signingkey`, `credential.helper`, etc.).

Also, except for reading and writing with `git config`, the
configuration is typically not used unless you're in a repository.
There are only a handful of Git commands that don't use a repository at
all, so usually setting configuration outside of a repository isn't very
useful.

Note that if it didn't require a repository, then it would have to work
on the current working directory.  But, it should be noted, the gitdir
option specifically does not operate on the current working directory.
While it is customary to have one's working directory be inside the
repository, you can be elsewhere and use `git -C` to change into the
repository (internally, Git does indeed change the working directory,
but that's an implementation detail).

That's not to say a feature couldn't be added that operated based on the
current working directory (or some related constraint) instead, but no
such feature has been added.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--6y3L7fVVOo94eYP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZdO1nwAKCRB8DEliiIei
gTzIAQCs/ceBg7AeSf/8lIVJX9d8BYMsSXoTLdCsqropUt5c+gEA9P9RNTl68qiH
HEZtxi5qtnlIl7OtoXrnWeIDogqxLQU=
=glci
-----END PGP SIGNATURE-----

--6y3L7fVVOo94eYP4--
