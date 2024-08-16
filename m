Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE711C57A2
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845306; cv=none; b=imgXnVgZF4gYLmadlQBZ2CkBbNzIgqpCcvZ89SHa/EYi4rRHtXqzuGv64WlhBOY3ILirja7aq3vO7ts84RgaAL6HBxpfytw9dL6pz9AyqBEp+Z09C3W6v6PqQVODggkFku6f8A7yefyUbq64elAPhrmj9EH8s10ASKhkttcuEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845306; c=relaxed/simple;
	bh=i6UiiD5dOvEiIQtPXCj9rVDE60iZLtoZnI2zsbByHbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnykpQPcT64sRz8f+4szovl9xDMf50YfVO34Jh89K2n0JuQYTAzskXm2PNiTrnMJwIVw4jqbO2CJZpQmCNt2YCouWjGAgk23yhbN0MCgJPO94zKIWM2lQicNjp/20ahTO7Z2V26NbzZF6+1N62z5Qn0fiSmE9bAYBlmpbz1N9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=toKphUan; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="toKphUan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723845301;
	bh=i6UiiD5dOvEiIQtPXCj9rVDE60iZLtoZnI2zsbByHbM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=toKphUan6KeDo3DnwhhLtBKRcxOKg6Gh4aSPQjdJYLmW2k6sdnF6u2w+rKxMNsQ4L
	 mS0GpwkX1wbACT4nFUNaj9UFoFSYvvLXsQby2uhh/+KG5ma5a9k5rNOFLnxI7wW8cl
	 czl1HHYjG1BudVgAOuOHW8dSrMKZYKU2WULuPSJiiiTw4YkJNCeelKZINYcIAQKkeb
	 UEVs6jBZiSdi78JEWSs2Eaclko04HeXAozeOd30WoZHNlNvVPoeTi4xg7KqihwDOt9
	 1rK0xEoA3w5IprjTLAMchmM2/m/udI7MShGQM5ZmG2yRRw/vM6NdkEwEWp5q9Il5y8
	 zZmhBeYqinp09Zw1qmUHr4TN+vqpEYHlbjevG2KbT4TdGMINfi41xtvd6KCYD9kH7X
	 i3p4HMW2d3MMkLvaS3RBQw0ZHml30JzleivPCrMiwtu30ZkSv+k+DEAb2qh42j2rBi
	 CZp81OXEVonvfTvcL+R2/nnWDeJ4LppmcPN0igXOMTf8KnxW3UN
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EB37E209C8;
	Fri, 16 Aug 2024 21:55:01 +0000 (UTC)
Date: Fri, 16 Aug 2024 21:55:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org
Subject: Re: feature request: set remote/HEAD with fetch
Message-ID: <Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
References: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnRfKk364fqsL34d"
Content-Disposition: inline
In-Reply-To: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jnRfKk364fqsL34d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-16 at 11:53:31, Bence Ferdinandy wrote:
> Hi,
>=20
> this comes after a bit of discussion on #git. The current behaviour of gi=
t is
> that when cloning, `refs/remotes/[remote]/HEAD` is set, but if you use `g=
it
> init` and `git remote add`, then you must manually run `git remote set-he=
ad -a`
> to arrive at the same state. Having origin/HEAD set is pretty useful for
> scripting and aliases, because you don't need to remember what the current
> project uses (origin/[master|main|trunk|etc]).
>=20
> I would propose that running `git fetch` should also update remote/HEAD. =
In
> case there is a possibility that it is useful in some cases that remote/H=
EAD is
> actually different from whatever is set in the remote repository as the d=
efault
> branch, I think a setting for opt-out would be better, and the default
> behaviour should be essentially always running `set-head -a`.
>=20
> My current workaround is an alias:
>     fetchall =3D !git fetch --all && git remote | xargs -i git remote set=
-head -a {}
>=20
> which works for me, but I think it would be more elegant not to have to d=
o this.

I believe this would be a valuable change.  I know a lot of other users
want this features as well.  However, I think it needs to be opt-in,
since there are some cases where you want `git fetch` to specifically
fetch only certain objects or don't want to modify the refs. For
example, I know some server-side implementations use `git fetch`
internally and require refs to be updated in a special way, and they
would not appreciate extra refs appearing.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--jnRfKk364fqsL34d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZr/KswAKCRB8DEliiIei
gVDFAQCUc9v+H4TmItlxnvJ7444kK5KqiKtOH5A6crRylk3ZCgD9GuzAIH7uy0iI
vJITJ1KQHz6tXJpVrItXvqgNdnuPSQs=
=pLmK
-----END PGP SIGNATURE-----

--jnRfKk364fqsL34d--
