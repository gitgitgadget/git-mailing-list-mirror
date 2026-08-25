Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9F46F497
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693802; cv=none; b=Bih2KOs7AeMj9PoJs4x5yn4Eh5Y/ehmtgqZ2Yn6c8s/3cIzlNChU6ESdfN7AyrBUTMTyjtX57ZK01AZx1mOnrXu6/W+FZec4vJs5AE0jzxf1BC7ZGnH2tmVLhyV8fIxb+jPzFDSkjFblLYXVtCQAgp5u0w8uc5uc24R1T98qmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693802; c=relaxed/simple;
	bh=NgyFoDkwD+FMDWEucL8RHYgsUojutizdLS4c69k2zcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP7qVg8Ax5/SttLiUzExdtGxMVvOIVkEsEm+qZvW25PHBWURL9lj3Dvk4pqKMp94wAFHx5pc7hw3OzZeMpWWU4cMrWQgitinzAVPRFhulILnZOtLQdl95XaaemhQS1DeQBkE9oIJIqzhLCJT3LqWe+Ql/+OACD7x0QCqjf8Q2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=e3GnCgpK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="e3GnCgpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1787693797;
	bh=NgyFoDkwD+FMDWEucL8RHYgsUojutizdLS4c69k2zcg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=e3GnCgpKOMQXxQUfdC1qudnsPrM986Ms6IrVLx4RKA0LXeEAIndIxHHSMz5Xm7K53
	 0C6+Z9DlSrzM7gymwLYFEuqofG9jc1hFDV1Lp7vfDCzXwIaNhyIlAUtO2HROzPtUQ3
	 itkyPiwZYOgv8t6jDGOZqK3D7zsTEfgzNJ/FTjYxxvojS51L9wpxpjU2RhRRHioGca
	 OhzHg4kqe6sv6VHkL+eZtZb8j6gRDVvkBjYTyENYXXUqoq3Xa6/VgnrYi1avW/4yi/
	 cXXU4lSYgIV6TkrQipXJJAMfUBGYPrH18apoDNw+ItsdGjJFhp+l/ENuKK7AStADrw
	 uBfcRiX8lJMU9Hc78kqyV4geuVas/ltSDdA4eTP4Dd3RjYj9WuJDua2XvJSDhBGxmi
	 fFhtLx0U37fVNL11IWsWz2j5j62V494IuFahsKFnt1J1w4GS7U4KuVlliUXg4Qbvfu
	 iMNAzg9RfLgtvvmdFR06f6uJEDfj4PNlmyxkjVTGE8UtWpD4kC9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:23b3:441d:199e:9561])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 53FAD20101;
	Tue, 25 Aug 2026 21:36:37 +0000 (UTC)
Date: Tue, 25 Aug 2026 21:36:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in breaking
 changes mode
Message-ID: <ao4K44RP66mjnpd7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-7-sandals@crustytoothpaste.net>
 <d6940aa6-9336-481b-8ee5-5e3d9f3d3a50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A3+znuJROQKLlsEi"
Content-Disposition: inline
In-Reply-To: <d6940aa6-9336-481b-8ee5-5e3d9f3d3a50@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--A3+znuJROQKLlsEi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-25 at 09:04:36, Phillip Wood wrote:
> Hi brian
>=20
> On 30/07/2026 00:32, brian m. carlson wrote:
> > Git has historically allowed either lowercase or uppercase hex for
> > object IDs, but it has always emitted only lowercase.  This has caused
> > people to expect only lowercase and not handle uppercase.
> >=20
> > As an example, Git's own example hooks look for "[0-9a-f]" in several
> > places, but there are many other Git-adjacent pieces of software,
> > including Gitolite, which make the assumption that object IDs are always
> > lowercase.  This is not to criticize the authors of these projects, but
> > rather to point out how common this assumption is.  In fact, it's so
> > common that we have only one test in our codebase that fails when we
> > reject uppercase object IDs.
> >=20
> > More critically, it leads people to make security-based assumptions that
> > an object ID either does not contain uppercase characters or that an
> > object ID can be expressed uniquely in hex form, neither of which are
> > currently true.  Git itself normally uses binary object IDs, which
> > avoids many of these problems, but most other projects deal primarily in
> > hex object IDs, so they are more affected.
>=20
> Can you say a bit more about the security problems please - I'm trying to
> understand why ABCDEF is a security risk when abcdef^0 isn't.

There's two cases I've seen.  The first is that people assume an object
ID is unique in hex form.  So if we have some policy to enforce, say,
that we can't allow certain objects, people will check against the
lowercase version when they may get the uppercase version somewhere
(say, user input or a specially crafted protocol message), which
bypasses the check.

The other case is where we try to distinguish between an object ID and a
ref, branch, or tag.  If our regexp has `[0-9a-f]{40}` or `[0-9a-f]{64}`
and we assume that if it matches it's an object ID and if it's not it's
a ref, that's not correct here.  We'd need to match the uppercase
version as well, but experience shows that people overwhelmingly do not
do that.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--A3+znuJROQKLlsEi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqOCuMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+g6CUx0+TI9wLdTYTULeWNFI+W0vS2G5s/RJ5tK8YpJ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAL4wAP9/fvEV2swrtJG7cTwaB1Nhdn43
fHSbZgtaiutY6DSBlgEA2pB0L3h7sVrV75kjvAosAgkwAzLTWoJtrweozMX/4wI=
=kpVj
-----END PGP SIGNATURE-----

--A3+znuJROQKLlsEi--
