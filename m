Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A618DF62
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380730; cv=none; b=M0eyU8I+/AfHaF389RW4VHtgHY0FsxC9qY+kzYvfWpLiOY373WUxJT/oTLz2tGO96pIsF1SFZ87Jd1g+zsflng0EHB6axbhxCEMurPfDmWmbQxn6C2xFhKpGw3+rt2PJwFWSi0v8BclWECIhSNpU3sO/LsfLPoHV5LCwyrVp7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380730; c=relaxed/simple;
	bh=mp1IIfxZ6lp7uPJwwFLSuceFNNrM1dn0MqKrdcnYc5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWL62JVrEJ+KwLvx74HHnicHzBLzsKubY4Kaoy2P/eWdfdlnxy0PUReuvwTXlOssCpaz9kzauS69E8cvH/JBa6zDEM22OG1f+EUERIOgvwzvJaK1CeaAZ8TzI4PxHGElcnx4hUKPvYZGn7bxyO71iYXCNh76EEBWc6T7PtACto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Y51VKUBn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Y51VKUBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722380726;
	bh=mp1IIfxZ6lp7uPJwwFLSuceFNNrM1dn0MqKrdcnYc5w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Y51VKUBniAiyZ4Nf1ELw+PrYRzg4IS4NOcO9wIcywRlqjqmivEF+ZKuBvzFaeybTV
	 u8IMXoYFqeVFk1CDr3LJT0CZY1/MiOQGTqza9hOGkLKBMB5TLvoEvyIokT/5kHD2+F
	 uKdgiwFrmiAtjtC6edI+RQwbCL6UdzzxQ/yNxIQvuxkkJZ8KMb4lvIfuVkoczQRkMe
	 a4BDBaZsHkQioOHZ+hhMcGUylN+DvkxumPeOS8zpx7L/su6XLQ598/QZN0fTXNs7g/
	 l7/dW2JvNOZwZSgYXDDl5193PUCfaOrWzBAf3aUFZPJkkpFZp3qJUSEyGkxL9+JqnB
	 r6oI67DOUJNtTS6k9VN0p5sQnvR35h5kN6S1n+GE7lNHA+IUodN0LbTsOnTuPPffdl
	 q5h/dilKanu8kNAMn7w8w75nois8Lo/ld+b18o6HQ6uUII9lVvseb/bVHJ/nRsxaq1
	 P5YOTlw3Aez/uOS6KzFmlR+oo82dFa7jFOz4MbrTJeM7X3EUCQL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 70153209B9;
	Tue, 30 Jul 2024 23:05:26 +0000 (UTC)
Date: Tue, 30 Jul 2024 23:05:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "W. Michael Petullo" <mike@flyn.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	"W. Michael Petullo" <mike@flyn.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
 <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
 <xmqqv80m8pha.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcvbZCCJ8neKCFUK"
Content-Disposition: inline
In-Reply-To: <xmqqv80m8pha.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--pcvbZCCJ8neKCFUK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-30 at 22:49:37, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I think if we're using --no-local (that is, if we're using upload-pack
> > instead of creating symlinks), then we should not complain about the
> > repository ownership.  It's supposed to always be safe to clone or fetch
> > from an untrusted repository, and we shouldn't complain about that.
>=20
> The safety is promised by "git fetch" when you fetch from some other
> machine because the only thing you will be seeing from that
> untrusted source is a bytestream that is the packfile, plus the tips
> of their histories---nothing runs as yourself in this exchange other
> than what you control, i.e. "git fetch", locally defined hooks and
> filters defined by your configuration..  They cannot affect your
> configuration file and hooks that may name extra programs that may
> run as you while fetching or cloning.
>=20
> When you are using "--no-local" on the same machine, I do not think
> there is any guarantee that "upload-pack" side is safe.  And that is
> where the safe.directory thing needs to kick in.
>=20
> Stepping into an untrusted repository and running git operations
> opens up the user the Git process runs as to attacks by the
> untrusted repository, i.e. you may invoke hooks on the upload-pack
> side, defined in the source repository that is controlled by others,
> and that is where the safe.directory thing kicks in.  You need to
> declare that you trust that source repository.

I don't believe git-upload-pack invokes hooks.  At least, I don't see
any documented to do so, and I'm not aware of any from my experience
hosting repositories.  Certainly git-receive-pack does so, which I can
understand as a problem, but upload-pack should not.

And the manual page does say this:

  Most Git commands should not be run in an untrusted `.git` directory
  (see the section `SECURITY` in git(1)). `upload-pack` tries to
  avoid any dangerous configuration options or hooks from the repository
  it's serving, making it safe to clone an untrusted directory and run
  commands on the resulting clone.

The git(1) manual page also says this:

  If you have an untrusted `.git` directory, you should first clone it
  with `git clone --no-local` to obtain a clean copy. Git does restrict
  the set of options and hooks that will be run by `upload-pack`, which
  handles the server side of a clone or fetch, but beware that the
  surface area for attack against `upload-pack` is large, so this does
  carry some risk. The safest thing is to serve the repository as an
  unprivileged user (either via git-daemon(1), ssh, or using
  other tools to change user ids). See the discussion in the `SECURITY`
  section of git-upload-pack(1).

I think that has been traditionally the policy that we've had here, and
given that we document that it is safe to do so, I think it should be
fine.  This documentation apparently came from Peff, who I think should
be reasonably well informed on such matters.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--pcvbZCCJ8neKCFUK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqlxtAAKCRB8DEliiIei
geCZAP41KUqMAmI91LYupInP/rOaXaHuftr5FFjvGm1Uz7SaIwD/ds06o73Y6C47
79y9gGE7SQKJ69iNcK4Q6OWrTAYFmQw=
=FZa3
-----END PGP SIGNATURE-----

--pcvbZCCJ8neKCFUK--
