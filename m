Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23D19149E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378503; cv=none; b=doQtwkpMSGqT6NKdmpjubVZ6pY453vwhKh8oeCDvPyKPuQb90AMT665Z8qkoc1Ln7T3STdqhl+NDAy9wBAVCizjPDtVZnq+trABdtoNqQexVl0utNMs4rkp+7E9AlmY1grRXDBAR6tJwHDDOGSEc9HlGRytZaJszRiM6JsIlfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378503; c=relaxed/simple;
	bh=l87G/zHdJt/1hW1sUCHczxj277B6qe0sNVyHmpHMFsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPIjWFQTVvUzVzHcu64dG+Ux/9Ox4FT/9L636/YzyTqzGYdsNkdvikF4W9BJ38MC9FOyXX2+zvkUTaqmJSC+/pGe+r/ULRWc8TLJ7gtFrB1eNBHbMm01U67XIlihkrxfnV4+/dF6aWJFcdH+h4ArxkOsk4lv632AL0ygWwuYkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KyDx6CE4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KyDx6CE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722378492;
	bh=l87G/zHdJt/1hW1sUCHczxj277B6qe0sNVyHmpHMFsk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KyDx6CE4R4FgVp85AWrFCWy+oSDFTFOfqzmiq6SlGEo8g56HXKjaTYWzALxCqejXq
	 BhegJmN/SUIxbpiJgmZBPbusOJ8mmNVJyb3ZfpJLcmOQAp/cp1FgnSHSSJpzqCjDCj
	 d5oZSK2RnzIk1H2nvhgtmW0QMmga3x2xmX7470MKuOFZtFKMSpiOJTYVSJhBadQQ4K
	 M4BWZXo+rvb5M3AD5UrIi93JQU9QwY58g5onhVsPSYvUqQqXvgoAlYPlro2KNLjSXR
	 49CRA66IA5jwmE2KPEJAU0Ezu4Bw+DK+jnMSaBsR2TViCo8KUmvsYEPud8ipSqCVI6
	 DPDtTXwvqbR5NOCJvZPLaneoiBnQnAHIG6v1TsrLGtR/6i9W8Q00XvEzWamKIY5UzJ
	 8QXVIX/568M6VGItvSpSaLTBtary9pKQxCpPT81+zH7Q2/gu4461TfdkrgT8k3bQ5W
	 s6ITWhmv67ZK7wAB9pnYAEsDblTLlCYrOi2pxnNIStv/fpicMOH
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7DC5F209B9;
	Tue, 30 Jul 2024 22:28:12 +0000 (UTC)
Date: Tue, 30 Jul 2024 22:28:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "W. Michael Petullo" <mike@flyn.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"W. Michael Petullo" <mike@flyn.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
 <20240727215845.GA1263246@coredump.intra.peff.net>
 <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rP6QJFE2UQjNv2QD"
Content-Disposition: inline
In-Reply-To: <ZqjQi6i2kiY4gcc1@imp.flyn.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--rP6QJFE2UQjNv2QD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-30 at 11:37:47, W. Michael Petullo wrote:
> Perhaps a compromise would be to tie safe.directory to the type
> of source directory given to clone. Would a remote URL be enough to
> turn off the safe.directory checks on a clone, similar to the effect of
> a remote URL on --local/--no-local?

I think if we're using --no-local (that is, if we're using upload-pack
instead of creating symlinks), then we should not complain about the
repository ownership.  It's supposed to always be safe to clone or fetch
=66rom an untrusted repository, and we shouldn't complain about that.

Both of these commands should work correctly and do not, and that's a
bug (assuming tr1 is owned by a different user):

  git clone --no-local --no-hardlinks $PWD/tr1 tr2
  git clone --no-local --no-hardlinks ssh://localhost$PWD/tr1 tr2

git-upload-pack should not complain about safe.directory at all. If it's
not secure to clone or fetch from an untrusted repository with
git-upload-pack, then we have a bigger security problem that needs to be
addressed.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--rP6QJFE2UQjNv2QD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqlo+QAKCRB8DEliiIei
gV5VAP9wwTaoxE5GsxueIYo+iQ+OrWWO2kGzxuIohaoXX7vhJAD+L7fZqErOo78o
C6Pv3dHBLNEULGRB4Z5SDgYJ+x88hwE=
=FMt4
-----END PGP SIGNATURE-----

--rP6QJFE2UQjNv2QD--
