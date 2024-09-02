Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3913C9C4
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283129; cv=none; b=ouFCXVO3ypbf2SCS+g6jFdEKbeBg1fH+6w6NRXhdaWc6sEomJ0h8/4ByDzso/B9Kk2QomCJ7qMSHoasZHSsau+TmtqfK6fhNm20yyqJ+i/7ePiMzdPNff0b6dXUkoaa9F60aJ3+y6M7IViQIjUYTy8AU0doKG8fF2rgIYU9uMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283129; c=relaxed/simple;
	bh=zesRnF43ygYI6VyaVtTRj+Hm70Ctviy7qMnBZQcDWCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7WxAx7UQSPMKPcuwuugCHipxWZYEPSLI7+mSiskfUhcfWgVi7PmHCLaoqbqpOS5DpOcIBFRlI3s5EgEbQNRRehLab+E9ACa7Kj9G9y4+U2eOulBM1c+mCoXbCfavFEvDKXI9jZ1dcWhVhjhaKZiVoTk7JCzw5q2prBO6Po+h6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=L+mJ3yJZ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L+mJ3yJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725283119;
	bh=zesRnF43ygYI6VyaVtTRj+Hm70Ctviy7qMnBZQcDWCk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=L+mJ3yJZ7eOrDkulQPberoCp47kY9drT8e7gVCY2q1MfQKJmnUCgdk4JCK3TRuWE5
	 wQ5HFJda38mjGqGOY9YXSYTzNDoxKu5r9iVaKLj/GRwWNTedPYtwlePr7KSyYqA2KE
	 CQBEbWq5PowHT1ttUoGA0c1ReWPJ8/9tfR5vSE/WfIszSpdgZ5LlG7ysg2pAU8a1DC
	 ESWjaljIm43vYKPNRxEyYocwRN+44SCgBdf4bCwPZdRKfsOnaUxYMaNHYnnXqXZ2JX
	 iFVx1ROHqEKdP/Ybn0kcYiT5xqhUGr4IACfLtgFr4CLO0jOSJNd5YS7eKCV+0rbca+
	 6qsTuDIzlYUSee7I/kuLW301U90e8IxOL78BCJtyxwp4iSjm6+inAtvK8KFDFqjZDv
	 19U5uVZsvMWEI1NGD6Is2pMBrE6tz64kpsWlb2eKWb/ijiWCTp7T2zjf5LpI8AJ6gQ
	 hnwgn98AzxYsyl7gDd6G3scPw8AAf9ftjVZRZqdbIkDuX35GMcG
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9DEBB24454;
	Mon,  2 Sep 2024 13:18:39 +0000 (UTC)
Date: Mon, 2 Sep 2024 13:18:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Ilya K <me@0upti.me>,
	git@vger.kernel.org
Subject: Re: git 2.46.0 crashes when trying to verify-pack outside of a repo
Message-ID: <ZtW7LtQEobPpVB99@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Ilya K <me@0upti.me>, git@vger.kernel.org
References: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me>
 <xmqq7cbvpf8v.fsf@gitster.g>
 <ZtT8p06fdTwXO7iX@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8z+JOZjSGelV4lyT"
Content-Disposition: inline
In-Reply-To: <ZtT8p06fdTwXO7iX@tanuki>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8z+JOZjSGelV4lyT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-01 at 23:45:43, Patrick Steinhardt wrote:
> Unfortunately, this once again uncovers a deeper issue: neither the
> packfile nor their index encode the object format they use. So while
> falling back to SHA1 papers over the issue, it means that we misparse
> SHA256 indices. Also, we misparse SHA1 indices if we happen to be in a
> SHA256 repository. E.g. when parsing a SHA256 file in a SHA1 repo:
>=20
>     $ git index-pack --verify '/tmp/git-tests/trash directory.t5300-pack-=
object/repo/.git/objects/pack/pack-aa45f7f08f043c9f0388f1844a2a797587254e24=
9919b35ac9dc2b52c1aada29.pack'
>     error: wrong index v2 file size in /tmp/git-tests/trash directory.t53=
00-pack-object/repo/.git/objects/pack/pack-aa45f7f08f043c9f0388f1844a2a7975=
87254e249919b35ac9dc2b52c1aada29.idx
>     fatal: Cannot open existing pack idx file for '/tmp/git-tests/trash d=
irectory.t5300-pack-object/repo/.git/objects/pack/pack-aa45f7f08f043c9f0388=
f1844a2a797587254e249919b35ac9dc2b52c1aada29.idx'
>=20
> The error message isn't even properly indicating what the actual issue
> is.

Yes, this is also true of other formats like the index as well, but
there we know it must be of the same format as the rest of the
repository.

I noticed this during writing the SHA-256 series, and it's inconvenient.
If you blame some of the tests that add the `--object-format` entry,
I wrote them.

> One potential solution would be to try and derive the object format from
> the hash that the packfile index name has. But that is quite roundabout
> and rather ugly, and packfiles may not necessarily have that hash in the
> first place. It would also become potentially ambiguous in the future if
> we were to ever adopt another hash that has the same length as either
> SHA1 or SHA256.

Yes, we've decided not to derive things by their length except in the
dumb HTTP protocol for this reason.

> So we basically have three different options:
>=20
>   - Accept that we just don't handle this case correctly and let the
>     code error out. This pessimizes all hashes but SHA256.
>=20
>   - Bail out when outside of a repository when `--object-format=3D` wasn't
>     given. This pessimizes all hashes, but gives a clear indicator to
>     the user why things don't work.

This is what I would recommend.

>   - Introduce packfiles v3 and encode the object format into the header.
>     Then do either (1) or (2) on top.

I think we have pack v3 already (which is the same as v2), and v4 was
for an experimental format that never landed fully.  Maybe v5?

If you wanted to do this, you could add support for arbitrary chunks,
like with multi-pack indexes, that would allow for extensibility in the
future.  However, you'd also need some protocol capabilities if you
want to send pack v5 or certain chunks over the protocol.

> The last option is of course the cleanest, but also the most involved.

I'd personally recommend just requiring the `--object-format=3D` option,
but of course if you want to write pack v5, don't let me stop you.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--8z+JOZjSGelV4lyT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtW7LQAKCRB8DEliiIei
gU9AAP4tV3MyxLFCJSp/nsugD4UVdcobUVGlfMN/9D21jo19WwD9FwC610df8nkI
rDb+T1xPZLDlAZoz4QGg1A5uVdVNHAI=
=92Up
-----END PGP SIGNATURE-----

--8z+JOZjSGelV4lyT--
