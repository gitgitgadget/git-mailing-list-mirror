Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896855E7F
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038777; cv=none; b=TI2kZRZ7+U+hJLtjjLwkogMCVgrP6yXBiYzudqfO1HpfzB0YtDk12NW9zEJmmQgYRpL7BZN/Fq3H6iHzngYX4uGb85jAnA6oL9L8FyOBfAtipKpi2EFtm6wrZmIPWIZ/WjSJ5twfgHSD1hEvyfbBkeFV3s+NnCvD81UnSR617HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038777; c=relaxed/simple;
	bh=7gAZGSxb9DiYKlDJ33fT54TVrjW3K/YLHybT5WqCm00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEmsdKQm/yFqrAiQxNaAEJQ8umgprw0Yas0aVsat2nWp94mWtSsQ77vSmho0Mf6QWW40rOImXiIMVc/EYFRVfh+3fBbehCqwAAy+JjfEY/wRJmiQBpG6pMgXN92MU0dHNVgZN7EXM8NdWXDkKNB7olCoUHL4+uHCKiYw2GMMtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xquTFZsc; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xquTFZsc"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D71FA5B2EF;
	Thu, 15 Feb 2024 23:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1708038766;
	bh=7gAZGSxb9DiYKlDJ33fT54TVrjW3K/YLHybT5WqCm00=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xquTFZscYcDN/PmfHel+3+ILMdhUI9x7/Nbix5LpQVZtkUF378d+0aJH+sXEQeH6c
	 OzYlrF3US7x7HzNpFqxwk2S1QMxNLujkweQvMB1k5v/TD95AfvKlJ0mMKzkbQP+upC
	 dDNHF00k38JY3LOpjeluJXZrp477wZRobdrPTmHXBkBKOvazN9A1jKMW3lZlbRc9pF
	 L5bAoHOSR8Kd00kTPSMo1kHPD2Yzha//xRP1wTQ05mY2YZ+4GaILNjIG5Wgzqe8Yj7
	 LRl7g8OIP/y/IxMiTLPKR5PJnt0JuVlb5HO0G6QLdUyyKvysth6/J7gXrvxCLGq2Ig
	 Gw/N9+pEB3Mdn4lVyk23XpATFLJ9zz5lyU5Uy3O+oZA6DbrZ46QzeQvOWUd2AynFdC
	 WRLlzirQsqTHwuHeFQKNSqWsIyTb/xKrRuV6WHbvCju2G5iU6dA1j0ge1XZnQnrKIq
	 a8AkMVVCx2tmwDGX6CrLmZB4KOxou4TSQGhqmSs+Npvmy2YHIK5
Date: Thu, 15 Feb 2024 23:12:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] use C99 declaration of variable in for() loop
Message-ID: <Zc6abO6RV9RwpABR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20240215094243.147057-1-gitter.spiros@gmail.com>
 <xmqqcysxskd9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ZO4ymscPUPJVDQZ"
Content-Disposition: inline
In-Reply-To: <xmqqcysxskd9.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--1ZO4ymscPUPJVDQZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-15 at 17:33:22, Junio C Hamano wrote:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>=20
> > With the exception of cbtree.c, which would need initial
> > reworking to remove the usage of goto, it expands the
> > use of variable scope reduction in for loops as
> > permitted by the C99 standard, which was first introduced
> > in the git codebase with commit 44ba10d6.
>=20
> Thanks, but ...
>=20
> Our test balloon may have proven that nobody will be inconvenienced,
> and it does mean we can be liberal using it when we add new code or
> update existing loops "while at it", but I personally do not think
> such a code churn is very welcome.

I will also say that sending one giant patch for this may be a bit hard
to review.  While I will defer to Junio's opinion as the maintainer, I
would be more inclined to review this kind of series if it came in in
smaller patches, a few at a time, in which case I would find it a
welcome improvement.

Since my time to work on Git is relatively limited, having, say, a
five-patch series where we each update a single file would let me review
these changes in a relatively short amount of time, which I would be
more likely to be able to find time for.  Looking at the large patch,
I'd be worried that I wouldn't be able to get through the entire thing
in one sitting.

Of course, if you bring in a nice Coccinelle patch for it, then that may
make a longer (but still one-file-per-commit) series more viable, since
it will help reviewers have more confidence in your change.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--1ZO4ymscPUPJVDQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZc6aawAKCRB8DEliiIei
gX7zAP98K4pyej8jQZMmiih65w8Z3IbTvH1JUF5EIHkWuCyCnQD/aKSzVRBfuq0h
bzwbpEn9+HWzEgIFxGxnXtvLDe5ynAo=
=QVtL
-----END PGP SIGNATURE-----

--1ZO4ymscPUPJVDQZ--
