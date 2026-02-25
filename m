Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759D3D903F
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044587; cv=none; b=XCC6GCJL6FY6vtMHZtfY9MJl3qw8ULwh+e4Mgq1/aBjk2Y/Snfs7BGauyhlGUqgdnALBwVz3a6vO0QWZWElx1yn5EweuISRjNcDGDbJMNn/sGUYwyGAR9SlK/8ya8StXn9R8hOCsxN/y36ni1RFh1oU7+7Wm1LkjrTnEpe6XHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044587; c=relaxed/simple;
	bh=/50JskUXRJCD1CB6HagqA+jj52BtprxA59ks/ov2Rkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3OaexBN38vJNGiwowPK1oNy52c2oZWSR9XPWMuXR8jpsyNqI+Tu6FgAiW7Cb0Fbiq4E1Z21kL57mk7EUzSdqJJdIjxCCgpGUhiAJf72T1BVwLyHkt7fTAZzoKPnwj4mrWD/E1AuM61CVFbok1o9rnuM/gR5mlz0bnvpnOl0Fvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moUmRbcJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moUmRbcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9F0C116D0;
	Wed, 25 Feb 2026 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772044587;
	bh=/50JskUXRJCD1CB6HagqA+jj52BtprxA59ks/ov2Rkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moUmRbcJC4PzSciV6TM8ymVHiFO/Ux7rICvZBVdHlzygCCKkghokvxNv5i5gx3nLr
	 QtpEcH0EjrcFSRowqYDC+kVMaC268nWB/6oyKacEZXYmLZPuMzD6wfLZYmVKERzxbN
	 BAnmen6qaq+2YPvjvHZskzgCov75Cis8X0ieX+z6qUG/vIOroPRdOwfmQQ+bJaM+E3
	 zbQQWxIYWmuJGuP0EOeMHF7B6Jifax4BybFoQrrEJtRxddtVO6jZZcyLtVYTjueW1h
	 hT5qtdQl9cQZOJxg3RhDiVIDVe9E7b5TFwSm7dKM4O5LjmVNhlmeKlB+4nww039E8p
	 ATUgRrH25Ozqg==
Date: Wed, 25 Feb 2026 19:36:24 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
Message-ID: <aZ9AuD3dYzCKtI0s@devuan>
References: <aZ81X6ERyx5fcm6L@devuan>
 <xmqq4in4brt3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kc2qjxs2rc4qn3sa"
Content-Disposition: inline
In-Reply-To: <xmqq4in4brt3.fsf@gitster.g>


--kc2qjxs2rc4qn3sa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
Message-ID: <aZ9AuD3dYzCKtI0s@devuan>
References: <aZ81X6ERyx5fcm6L@devuan>
 <xmqq4in4brt3.fsf@gitster.g>
MIME-Version: 1.0
In-Reply-To: <xmqq4in4brt3.fsf@gitster.g>

Hi Junio,

On 2026-02-25T10:29:12-0800, Junio C Hamano wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > Would you mind changing %d to be affected by --decorate=3D?
>=20
> I would imagine everybody would strongly mind as the scripts they
> have already written and have been using for years will be broken by
> such a change.  So changing how %d works is a non-starter.

Makes sense.

>=20
> But that does not mean we cannot add a different placeholder that
> behaves that way.  I wonder if it is the cleanest to extend the
> %(decoreate:<option>,...) notation, perhaps like
>=20
>     $ git log --format=3D"%(decorate:optional=3Dyes)"
>=20
> with and without --decorate/--no-decorate may be a way forward?

That could work for me.

Alternatively, we could add another level to --decorate=3D.  Currently,
there are --decorate[=3D(short|full|auto|no)].  We could add 'never' to
also exclude %d.

What do you think?


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--kc2qjxs2rc4qn3sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmfQSgACgkQ64mZXMKQ
wqlvvQ/9EHLSLJgl/JV4iq2AzrtMnK8k8i4+mFe35vQMcrAgadB/bZf7RCxp6r4j
b5T982bXRsDDukfrdD7zOKVQbEmOS4xTPxNy4PbhFQs/PSuFUD8+ETn4kuhpVfYS
7s70AZnEp7La2SRqtphtzsyJWLQYWNZ35jxY0EDNgEd1Z7Bwo57jaAZ/Jg6Qw7vs
qasMMDtRpSt7HOs+qdwZGwnzkfmkhQjToSqzuTQ606DlZCuhkjT9BbJW8bU3x8Ss
Ze9MEX5dqrd9gN2kkqpv1kUF1mzEc5b8O1T8PfYmAWu0aw72iCI736fVsqdnZPOx
Y5/vTYgdBjmkKHQ7xVJtWmUMb8fj1PPaGM9R0nv3dZXVyUIFZJms8c6VaXG8P0uI
Hq9Wgaiz1qKuhSgkgsTZtixbZvBlJ4F7Q0QcNGH6fuutZ6KtLtCX6X8vYZpI5TfV
HhJK3ualRXWyaw01UJud+exG+uAak1so5Y3a5+oKHHAP3M50Gx2qmR2A6QWbXQ0G
2oGfSpuABEWQeXBGMWM+PnvLuh9xZ+jo+dHoMOYT+sAzTgr/buwIe0hG6q16s3an
UO0fr2LfbgBig4wY64ufh//KXDOAc077TevgJLM9R1sf3KhMt0I23Szv9oduW9Lv
SO2NvSRUhTJ3gyodt0XNRrnSDf3+zTFKLFzaS7E8cjjNJX0GrBs=
=wYe6
-----END PGP SIGNATURE-----

--kc2qjxs2rc4qn3sa--
