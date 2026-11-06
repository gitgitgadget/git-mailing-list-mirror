Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976313;
	b=YiDc2a5vfzvFIJ///GFXljM/Gkj/t3fUIr7w2ROV9O0dF35493jECkrOdcHYzIvhUTll
	 YSIy5d4Wm9MyncVtS831DH4rbkCSUseyhyxZOsGXYCJ+IKdrFN8LNVZZFHfNAxzoALwoV
	 XUMe51gBkViQmkO3/DIcPSY1PetfSrZPA5cNx2aMHbTVU/TGdmvIQ1WrFCIEJJxTimOZB
	 YnjZrNTxXDH2pPbwQ/tJ8SB3FICBfYvFVbwqR/qUKlb4c0tCGyVUR6AEdkZLwTGk2yvaI
	 rjqafFe/TfqnG5Oro1xdWG0ZapZ6PovCro7nk7iRo2WjfoLl1xt/SbB407q4FlwRJuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976313;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0j3qjE9VcGmvXaV4s+zbubl2dAsuejKfsvLEpGePtBw=;
	b=Z1/cP9KG581WlvCLLUzNxtpzdCdBj8Vu8DXNE5Dm4LSJzT5PTlsDHRMw5JIFRQGJoE6s
	 o0ti/aqZJNuRKzNmej1FfhfyBe2qeZ+XcAjVB/TSLY6yaJ+tAdZTX41H0EsNrZMvktBkY
	 1LdzRyb9AmkLgBdk0MEloy2Mfaq/PGAAG1fk26bIt+t0stz/xODFexTkSlpTGE/yYQdcE
	 09QH+ZdoFsRAvfz58dvJe/lUCftPGSiw2rz0cI2cD0V3STZRYf21t3hna8cHp6HCfCcDY
	 mlQJYifwBsblDNvjJonaVv/iYNxUrBuHxjr2YYBymKRw9Mc8/31xGcW24Yj4uQC1udQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhvymPyL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F65606D805
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhvymPyL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3229E1F0089F;
	Fri,  6 Nov 2026 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976312;
	bh=0j3qjE9VcGmvXaV4s+zbubl2dAsuejKfsvLEpGePtBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DhvymPyLMGZRsAC8DZ+9H3cTLJgwEevD1QviESFHv94mpUigD2xo3CRg5CfP5w8wr
	 bRPDlHmblWt9+4PqogdbZkTcOezLxdsaaUhfvbUkHI5RpHcAY0ZPoKbrQfgXg3icbF
	 cMvWJwVeCiMTI+rshd/DR9Rqutx6njCErHTJlVpDD6M2BGI9R7D3RQBY5fQiJQ6S4x
	 rlni5BTN7+1KceHg1MfOrLtSXazMGIEBXiDEHqS9fmzL1iIT+uHz63KG/jmQOZ6YLt
	 kHzYiHDbh+vU2JXWbWaJJvCbaI0oi9HuMHpsd3VoG9L1u/stEFGeUQqWLRODa9f2Nz
	 xLecCVH4Q8Bgw==
Date: Fri, 6 Nov 2026 15:45:08 +0100
From: Alejandro Colomar <alx+git@kernel.org>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: git-ls-files(1) avoiding symlinks
Message-ID: <au3lu4jYwZ5hBZSy@devuan>
References: <au3Tyaz_LoYDuskn@devuan>
 <CALnO6CB-b2XuvwkQ9pJp5ENuc12oGMdgbcwz1VKD_i3KWfKuHA@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="laphslwwjce62gru"
Content-Disposition: inline
In-Reply-To: <CALnO6CB-b2XuvwkQ9pJp5ENuc12oGMdgbcwz1VKD_i3KWfKuHA@mail.gmail.com>


--laphslwwjce62gru
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+git@kernel.org>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: git-ls-files(1) avoiding symlinks
Message-ID: <au3lu4jYwZ5hBZSy@devuan>
References: <au3Tyaz_LoYDuskn@devuan>
 <CALnO6CB-b2XuvwkQ9pJp5ENuc12oGMdgbcwz1VKD_i3KWfKuHA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALnO6CB-b2XuvwkQ9pJp5ENuc12oGMdgbcwz1VKD_i3KWfKuHA@mail.gmail.com>

Hi Ben,

> Date: 2026-11-06 09:15:22-0500
> From: "D. Ben Knoble" <ben.knoble@gmail.com>
>
[...]
> > A problem with git-ls-files(1) is that it doesn't have a way to filter
> > files by type.  That is, it will list symlinks, which will affect the
> > search.  With find(1), I can control that with '-type f', which makes
> > sure I only search in regular files.  I'd like to have some feature in
> > git-ls-files(1) that allows me to print files of the specified type.
> > Since git(1) knows the type of the files, this should be doable without
> > much overhead, right?
>=20
> Perhaps something with "git ls-files --format=3D'%(objectmode) %(path)'
> -z"? Of course, your examples already omit -z, so if you can assume
> that it might be simpler.

Hmmm, that could work.  Thanks!

	$ git ls-files --format=3D'%(objectmode) %(path)' \
	| grep -v ^120000 \
	| sed 's/^.* //' \
	| grep '\.[ch]$' \
	| xargs grepc creat;

With -z it becomes a bit tedious:

	$ git ls-files -z --format=3D'%(objectmode) %(path)' \
	| grep -zv ^120000 \
	| sed -z 's/^.* //' \
	| grep -z '\.[ch]$' \
	| xargs -0 grepc creat;

But, indeed, I don't care about files with spaces often, because I don't
create them in my stuff.

I expect git-ls-files(1) could make this much simpler, though:

	$ git ls-files --type f \
	| grep '\.[ch]$' \
	| xargs grepc creat;


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--laphslwwjce62gru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrt5+oACgkQ64mZXMKQ
wqnMFhAAviRiAIYgNWavnKkIHllRqEmYQ72tiJhjx71KI5UEuLquzCZms7TqJ9UW
M1IlZSpNtKZU4hlOP08EiwWNe7fFty7VZk9pvkfKG3pmQtL1ZEI3gXLN7cJjr5i4
MnIAxM3cl4j5V7NTstfvj1PeiQCCgs9aF8z0ixWeWqetpeL+xhrLX73sBv65PERp
mLVRZlnQ1SQczZg0lWV264opxyZwNlTayEZV4ALXPLTGDbmL7RunRW4nq4TY4je6
ZNdqVTsxv4BKbtUfT65PXnAA9HoyzcfAD2XQOc4h1poR/CMkVy6a/AxOD/hJ48go
qMq1FPOfu0DTUZQsB+BCmtI4P7IPpIAGyKselAdMZ2QzPEsRP9wBVipCwUPDCKQP
6FxK2+EI7bssAjofrrhUAziATpgY67Wglg87hjsIDKXZH32OHLw8nB7xlIARQr/s
O33eNfXe8Mif8k6vzIErOobB9yB0r3j3T1/O+OX9kik7OF53BcgD90da5SrFvx1t
ICUYJfy6vHprIOMSo7sXeB9WxJPC8/Il3DV+7F/IXIuHRRWLaCZNzp+U4PM0XAao
b9hNECzNnwR9RrLP/SXHQZxBsobCFh3hacFVD2LyuYqOOAdSmaQIzwnl3YIPdCQf
rRW24EqIK+CqXl+693wOm3yZKgfi8G/wt13QTHLFNnn1iJaCiqc=
=C42d
-----END PGP SIGNATURE-----

--laphslwwjce62gru--
