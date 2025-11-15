Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60530B53E
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763237661; cv=none; b=nCnCqAdTzoKzO1MScVJwMNZyQtWywgRiUltbD/HgRYt/U+kGjaQvnlgbX3O/wltvJC5/BTcfMc1K/cuqilA136P8w27FP6QwRHaHEGSsjktdXEcJ0yXTo24Ye5J9hH8sQ/gwkKpQBbm8UUcIg3ZoGNi69BFu9bjxlwySTeg8eMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763237661; c=relaxed/simple;
	bh=1TpX3hFngl1JigNu6dXAHDdn0cZ9r6V23fCpEvfEqnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNAy+DLJpMunFki0oymagrBMxInWcq3TaroE2qucu51wIH9MLCj6/ZX1epf7rj97X0GWFA8NAnHTNOBGYgMeTkKPXO1TmaD4dtL9Plb6y/ZPEalrtrRIkDKGVMHnTEQmCMzrYqz3LFEmG2rXfBbVx618nwBCjueXA+cL3edhnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=H3d1u7bk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="H3d1u7bk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763237658;
	bh=1TpX3hFngl1JigNu6dXAHDdn0cZ9r6V23fCpEvfEqnk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=H3d1u7bkuwdH6ZFvxa0OCTOGrj5WNKwg7/rkOZQN0PP5Q87jMOi3xtQS0OuEZgBXZ
	 nELnIeSrfq4Kj06EZLivM4jZCKwLU8MxZ5gtnXpX6bWHrzGFBItYj9STQac8ryRuid
	 1OINgbx9wJ9hWoqcQxrBVh4TNZ6X5GjZl5CSwlxzLCceOR01y8e22nbvSPw3vMAmaC
	 fmPFgS3Kaiohz4MrgEarE2iYhZhLUk4BqDVwWossAbxe9L86AoVNsejpq33a+L8Aal
	 1mmnULNPekevUgP6gbmkx2gHDc3OsvqtHlgOW2oYbQGiBA6ve36XuIn5jL5PyD0Lan
	 D6H86xZUZ3qFf04Hgy9IMZ7MuRKPa/vMWnt4gD7kwUDg7DCDnQHuYMQ5y+aVVahBIf
	 6mfbcZGHqJtxuSaAuRo79bhrPYA1oaI63QbaP65HXOlVIEffoiH8+Lt84WRxrVpNpV
	 gBHRjrU/ofEa1+KhHSe2X3KfQqcDzyK5wqD//+xpZHiR7tZ9YzQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d905:f83:f129:9863])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8D95E20065;
	Sat, 15 Nov 2025 20:14:18 +0000 (UTC)
Date: Sat, 15 Nov 2025 20:14:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Martin Wilck <mwilck@suse.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Adrian Schroeter <adrian@suse.com>
Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with
 --depth=1
Message-ID: <aRjfGT_4QT4ANlVx@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Martin Wilck <mwilck@suse.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Adrian Schroeter <adrian@suse.com>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <xmqq7bvvtdoe.fsf@gitster.g>
 <aRUaR6IfH9imrF5A@fruit.crustytoothpaste.net>
 <a1c0440a6eef8f306f53793b2f96636945d4ced4.camel@suse.com>
 <b434bcb1-bf6e-4fe7-af2d-8c33348378fa@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gFUwl60ywFZx/HXk"
Content-Disposition: inline
In-Reply-To: <b434bcb1-bf6e-4fe7-af2d-8c33348378fa@xiplink.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--gFUwl60ywFZx/HXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-14 at 22:55:07, Marc Branchaud wrote:
> Set up SHA256 mirrors of the SHA1 repos you want to track in submodules?
>=20
> I'm assuming that it would be easy to keep such mirrors up to date.  I'm =
not
> familiar enough with Brian's work to know if a SHA256 repo can have
> a SHA1 remote (which would mean that updates would just be a simple "git
> fetch origin"), but even if that's not possible I'm guessing that scripti=
ng
> some kind of regularly-run translation of new commits wouldn't be too har=
d.

You can set up a repository which supports both algorithms (for
instance, a SHA-256 main algorithm and SHA-1 compatibility) and then
interoperate with both algorithms, so yes, this is possible and it
really is as easy as `git fetch origin` once set up.

The current constraint is that the cloned repository must be a full
clone (not shallow or partial) and it must not have any submodules
itself.

Of course, that's what the interoperability work does and it's not
finished or even mostly upstreamed.  As I said, it's mostly functional,
but it's not production ready.  It also fails many tests because we have
many tests in our testsuite that require partial or shallow clones,
whose support is in progress.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--gFUwl60ywFZx/HXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRjfGQAKCRB8DEliiIei
gTGLAQCxrMquk9AsE5t5l3AfU51QBQcB7qFjqkJqoI3+z2zqiQD7BHmrmTGSiXFp
biKpcJxnBPRBcuqf8TuiUPmUk2wAewk=
=utfX
-----END PGP SIGNATURE-----

--gFUwl60ywFZx/HXk--
