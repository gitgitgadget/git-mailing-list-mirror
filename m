Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33401291E
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731636138; cv=none; b=uciy4aLxxpy8GgTsyQghAS2k/lQ21ZCE84rPwaCLriHphWnS06shBfH2+n8naoFMej9mhTjPgu7u6641V1q6XLAm906jscRXBpdxjsfvjl3LGgTMueouvL7y65vMJuspn8R3OclCQM0CpLqn8jX1fqNRA3mJpJd8BfElamXX/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731636138; c=relaxed/simple;
	bh=540YEqTLgGPzDpiNyvSY5NXZEBGskYfgeycqh0DheyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z31Jvr6VmE75NCUs1sjZ9WPT79I2BBUSC5CsxyFLTRVisxEf3tP/sktZjsANXjL/4cca/7tgVeR/lnLeOV9vUsFNknKji6ta+7W3OETkUAMkplRDMFtKO/RBYjMuat23CtiXszQOp50wZIY5YbsVyc/Wyi2HwWrmV5YfpyB8tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DmuTGaWR; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DmuTGaWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731636134;
	bh=540YEqTLgGPzDpiNyvSY5NXZEBGskYfgeycqh0DheyI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DmuTGaWRrNUjKOyPKOLu1cjtkNMPKcdlgh2MVctp5hVDjvqbF32sb8RLgqgWPAzhr
	 1DobDNenZ56n3iausw0ziSGUogdexAw4e4MdMrGMsd8wSVOKPR8G44uTzf3snGVL0K
	 UwztU37MdpOou15iBWNZmgmCm59ArKoi1jVuC3K6mIo+pAWM+v0zM8JoRKGCSefpib
	 g7Ya9zea6injSX2IvLhiiXc5i1He4dM1IhdMmwEeLBRE1gjXh0dvuXIhE5uLsdL9t1
	 UqUyYzGsSnqGwp/SmTWA4955ELG4gNeh+NySv3AKUMWs+ns8prlJ/FOAbA3EDYW4By
	 zEUFr1hRvjUUC/fsNne8yD0UXbroIx3VzhX9VE+0LfnAdrrFKo/txxjsit3hpuZR0V
	 KvWp+vgsJTgA3KBKK90fJrQp5apQiB9wJEWG5sIbUEMb9wnge7UvS4CxYtxX1SVxSe
	 WsceXsEQEnPpwRPSsIg7NVGDghHGEIzhxy2eghVMQo3N6gJHQKd
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B510F200C4;
	Fri, 15 Nov 2024 02:02:14 +0000 (UTC)
Date: Fri, 15 Nov 2024 02:02:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/1] Restore the ability to clone repositories owned by
 another user
Message-ID: <ZzarpTaoooBOBohZ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
References: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
 <xmqqr07d47sn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UQJUrndZy8xHiQCy"
Content-Disposition: inline
In-Reply-To: <xmqqr07d47sn.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--UQJUrndZy8xHiQCy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-15 at 01:14:48, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > For a long time, we've told users that the only safe way to operate on
> > an untrusted repository is to clone or fetch from it.  We've even
> > mentioned this policy in a variety of places in our documentation.
> >
> > However, f4aa8c8bb1 ("fetch/clone: detect dubious ownership of local
> > repositories", 2024-04-10), this changed in an attempt to make things
> > more secure.  That broke a lot of user use cases, which have been
> > reported to the list.
> >
> > Because our security model hasn't changed and it's still safe to clone
> > or fetch from an untrusted repository, let's revert a portion of that
> > change to allow us to clone and fetch from repositories owned by a
> > different user.  If a malicious repository were a problem for
> > upload-pack, that would probably also be exploitable on major forges,
> > and if it were a problem on the client side, then we'd also have a
> > problem with untrusted HTTPS remotes, so we're not really adding any
> > security risk here.
>=20
> Nice.  Better late than never.

Yeah, I had intended to get to this sooner, but I got busy with other
things, and nobody got to it before me.  I had some time so I thought
I'd send this out now so we can minimize the number of affected versions.

I really appreciate you writing up the original patch for this; it was
very helpful and a great start.

> > Note that I haven't signed off on this patch because it's based on one
> > from Junio and I haven't gotten his sign-off yet.  It's fine to add mine
> > once he's added his.
>=20
> You can forge my sign-off on the old patch ;-)

Great.  I suspect you'll probably pick this up as-is, but I've added
both our sign-offs in case we need a v2.  Let me know if you'd prefer me
to send out the unmodified v2, and I can do that.

> The proposed commit log of the patch makes me wonder what should
> happen when neither of the two bits is set.  Not strict, but we do
> not allow ourselves to enter a random repo owned by a stranger.  It
> turns out that "strict" has nothing to do with this lifting of
> excess ownership check, but the dwimming done by suffixing .git,
> etc. to the given pathnames, so there is nothing strange going on.

Exactly.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--UQJUrndZy8xHiQCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZzarpAAKCRB8DEliiIei
gQ8sAQCwbpYzOFLMWpWBWMPF15kp03QqqFrlfB9WXe6YuOmhkQEAr2jlrVgL5j18
Z+IhryvmOhApeLb1ZsO4BHbdlog5vQ4=
=0HYT
-----END PGP SIGNATURE-----

--UQJUrndZy8xHiQCy--
