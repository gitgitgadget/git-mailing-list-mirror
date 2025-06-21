Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914B1426C
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750521143; cv=none; b=WltMH/r1EhVU0pJZJbO26lMzlz9OZ4jfJOP+ATAfW/CS109jzgHURNn1SpyS7za9v9hot5HbV39BmV2PEiT8reAShAhgbch41G5qWdBvkHLSQydByjxERmPQqyMa7tgHLcI7pjw3L/B2WD68pF7JRhyhdyHf/IL6rnR5H1veXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750521143; c=relaxed/simple;
	bh=HRnBmMLW9WNCp7tTzy2l4ggEYKXZa2kgBLl7KA7pXcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhGWBsBns+J/LTAeYftuaeNc0WzhXJC9dz5DgP8Z1DQwoGI/VWduozljWs7k8nNLixFcmaMr0cLXLm0ateSZ4483FEVRz5HTioz86xezAfMUncR1KGD0lnUXH2pGXwNLn7yEZQJ10yeJS4hdr0l8TdRLkhHAilE5aEth4cnsW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YXF28iaV; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YXF28iaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750521129;
	bh=HRnBmMLW9WNCp7tTzy2l4ggEYKXZa2kgBLl7KA7pXcA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YXF28iaVKJ0drxoVsKlBsKe5umn1Ttj50w3aqH/eUlc1oGuczqB9p8bseBrZmAAZy
	 9It2y7N/paaw6i0NZ8PTmTB05/X90AznaSf1ybC5zeQVrN0Gr/jxfIFJFWybRlTC9A
	 bqKdD96VtKtLU0YoWB2dAtxfftuxSzAsUCR10K5qGaI47v6NDFJSR3gA5J1y414PfY
	 uUl9Yb/O+lbE+ELuRiNgH0BJokSfZdAqCF/6UGgib8t4b+ZNi/u1c53C5jHfYIQmlT
	 tt4rqXHL/DBczL1YPGx9z+Zg2aVkjimrlSMSZRFPl73UDia+VY4GiyA7aVw1028EGL
	 /TxujRTHCJVUWzlqplJLYMsx3KAcV4jzHx4bmYZKEW4Kw+sV2MqKxiMKkBrP/Va51g
	 rSmevEz0VBV9nnx5sUNQALPYfnNsSBb0mopF181Rd6prOW27VbqDeyztsbFoerANnk
	 rC4frSqF5jmqGbWvUdLWxxJZuszcYVcYtjTdGpYzZsuVMhbH1RM
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:15e3:a7c6:85f5:795])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AE33820069;
	Sat, 21 Jun 2025 15:52:09 +0000 (UTC)
Date: Sat, 21 Jun 2025 15:52:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
Message-ID: <aFbVKEbhunWyljkR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Maxim Cournoyer <maxim@guixotic.coop>, git@vger.kernel.org
References: <20250620041239.27839-1-maxim@guixotic.coop>
 <aFWwez5OEgLt0vRU@fruit.crustytoothpaste.net>
 <87bjqhgr47.fsf@terra.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e693JLPMfRHhr3aw"
Content-Disposition: inline
In-Reply-To: <87bjqhgr47.fsf@terra.mail-host-address-is-not-set>
User-Agent: Mutt/2.2.13 (2024-03-09)


--e693JLPMfRHhr3aw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-21 at 13:29:28, Maxim Cournoyer wrote:
> I'm quite new to the credential-manager of git, so I do not have an
> answer to these excellent questions.  But, as some perhaps useful
> datapoint, at least using Emacs's auth-source library with a
> ~/.authinfo.gpg file (which is in the netrc format), if you use a
> symbolic port name, you have to use it everywhere if you want
> auth-source to match it correctly (it doesn't translate smtps to 465 for
> example). If you put 'port smtps' in the .authinfo.gpg but specify the
> SMTP port in the your Emacs MTA to a integer like 465, it won't match.
>=20
> This could be considered a bug in auth-source.el, and git
> credential-manager can do better by converting all port input values to
> their integer form, as you suggested.  Then mismatched configurations
> (e.g.: smtps in netrc and sendemail.smtpServerPort =3D 465 or vice-versa)
> would be handled correctly.

Yes, I would say that we should be using numeric ports everywhere in the
credential protocol.  If `git send-email` receives "submission" as the
port, then it needs to convert that to "587" before it even requests a
credential.

The git-credential(1) documentation says this for the `host` entry in
the protocol:

    The remote hostname for a network credential. This includes the port
    number if one was specified (e.g., "example.com:8088").

Note that that says "port number", not "symbolic port".

So I think we'd need some answers as to what's going over the protocol
first and how it works for built-in Git functionality (e.g., HTTPS)
before we decide if this is a change we want to make.

> Did I understand correctly with my suggestion/rewording of yours above?
> git-credential-netrc reads its input from the netrc file, which may well
> have a symbolic port, so it should itself convert from symbolic to
> actual port numbers, IIUC.

The netrc format is actually underspecified and libcurl doesn't support
ports at all, so I would not say that using a symbolic port is a good
idea or reliably supported in general.  In fact, I would say that the
netrc credential helper is the only tool I can find that accepts ports
at all.  I've looked at multiple different tools and manual pages online
and the `port` or `protocol` key is not even mentioned.

If we do accept symbolic ports in the netrc file, then we need to
convert them to a numeric port before sending anything over the
protocol, which I don't believe your patch does.  Perl does offer
`getservbyname` for this purpose, so it shouldn't be too difficult to
make this change.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--e693JLPMfRHhr3aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFbVJwAKCRB8DEliiIei
gZnXAP48d/SfM/8BcZQXRrmk+Q1NexCxrw9k7UAIOdN1TDnQYwEA45p7ZrAWYXZ/
fgMCXKpsPvh/IDCcjGW23/pTMm9KNQk=
=URgt
-----END PGP SIGNATURE-----

--e693JLPMfRHhr3aw--
