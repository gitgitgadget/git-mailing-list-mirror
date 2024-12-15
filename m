Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24F1E502
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302381; cv=none; b=ILM68VzNqOi4Fuc91/Hk77lym0f+od0c9iOJaOYGDa9ez+PK/0OZ1VNRcHZr3WBa7ef+uF+Ny7WJWKeJstyUlYmgs7bJMBugg/y+LuIYWCK0jHpBpK5fcot6FmkJNFOBwG9hu1FJsDRKuos7XyVxJJQQQLqRugKatqgWBtQeKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302381; c=relaxed/simple;
	bh=oaRW6TLOVdu0saY1rnGjNabAyMaiOBXRh2b+dodHs6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa+RM8lBrlvpn/crAAu6rkJ5ll2uIcqtjloNbGRplR8PssRlfgXr7qEVKra9jHzUupqRcp6wyar0XBR+zbYp4ottgQuZHihFRm4v3AKWqXpF9O2ErjSNm7HDX/GCATxPvp7tFXrLIV1z6b+BfwwEzjOSnobikRljidYjlUDYpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=h/5n708s; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h/5n708s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1734301862;
	bh=oaRW6TLOVdu0saY1rnGjNabAyMaiOBXRh2b+dodHs6k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=h/5n708s3cZxHAUfr+2q6Nae3MpaoWQRE9IxzagtgHQeqLKzlYBNiX1NNTfTg7Zf7
	 fXDRflNDyekg4PIe6Dzd8A69NBAL+K7BecJjdWyT+2hEDRsmgfrMIrJJSlBQTEZR4E
	 sNaOHmRHhvBGuR2ZvUr/q8JbzBjpHX5FDvQtqF6JyVfkwa3NsJ4UzPQQbM9ib1/p8j
	 DVvUT/yRmU16WWFBBOqyQKfc5w3XQ2MJg8UPJ6KbfU/DnyCFHfHHZDetUC8uYMRxIG
	 Yy51/GueExhxPhhRRiMjluHJEPtMFCmdKu7nJDdAIulBPDpzyAybUImTp+srK58kyj
	 IKAwkpSIk3OCzRsc5rsG8zoISK3KRjCmWVtuZ4dwHor6Y+XPCH2UcDxc+/5ViA+X/k
	 VPBJ8pqO7issXZjFSM9gSCfBr+7tDzilKiIUGKKeMmipS+PsUvMwml/csGJ4BlV/Zf
	 yqxBIlJ7hZy+ofo5QXzMRusiP/K5C5c997Wr9UGNuy4D4zCtckZ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 03AB6209AD;
	Sun, 15 Dec 2024 22:31:00 +0000 (UTC)
Date: Sun, 15 Dec 2024 22:30:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
Cc: git@vger.kernel.org
Subject: Re: chmod failure on GVFS mounted CIFS share
Message-ID: <Z19Ymnnvt9jOixPB@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>, git@vger.kernel.org
References: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
 <Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
 <c22a7d5e-cbfe-48a9-bdf5-e73f21ac648f@psi.ch>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7RySQswtyfFzzUDQ"
Content-Disposition: inline
In-Reply-To: <c22a7d5e-cbfe-48a9-bdf5-e73f21ac648f@psi.ch>
User-Agent: Mutt/2.2.13 (2024-03-09)


--7RySQswtyfFzzUDQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-12-13 at 10:32:22, Konrad Bucheli (PSI) wrote:
> My suggestion is not to silently ignore all chmod errors, only ENOTSUP for
> config.lock which basically tells that it is not a suitable location for
> that operation and thus also not required.
> Would that be acceptable?

That solves your particular problem, but the WSL situation gets
EPERM[0], so it would not solve the general problem.  We definitely
don't want to blindly ignore EPERM in general for `config.lock` because
it could indicate a real permissions problem or a race condition with
other software.

[0] https://askubuntu.com/questions/1115564/wsl-ubuntu-distro-how-to-solve-=
operation-not-permitted-on-cloning-repository
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--7RySQswtyfFzzUDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ19YmQAKCRB8DEliiIei
gSrEAQD1tye5E8YsvH3U8Zeawxb1zO8MFsYKvrE4oStdySs+RQD/Z0qGZkUAtYp4
VDD91x+pyJlmBVZrEOfI8wBS+KQyOwo=
=k/an
-----END PGP SIGNATURE-----

--7RySQswtyfFzzUDQ--
