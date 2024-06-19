Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7377F10
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837185; cv=none; b=XxDp5isfTuiOEgtJl8/a6q26FqkIbLH3znieobqgCGb7OHEuRG+UkNq1g2ZBl36yQnUJOqT2ke23RjSR1C9ubg+5MGvZtfepmN95wtFp6g1QNxx1kVdboATmNOrtUJtxo1T4iPBZ3E0pdBhs/wcyuw8a/mU5Vq56wV4uPUInwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837185; c=relaxed/simple;
	bh=Ign5TdU6G9M4MdMnZI47VXx3+msbjyd9rvxNtEj9LRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISPtugELQG/hj9CsbIwtV1JzPDrBFZ4pTfhGWDBTqOz+4goSiDFX+uxdCZDZ9w2kxQ/E9YWcVaH+CT9FQlbWsXgkXwVSc0Ug/cpJ0Govta/8maD1BP8JJ43iu0ko9WXPO+0pnVnALdxDAxx2dJssPQbfqejRls+OFGoDMve8tX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=trRZIDGT; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="trRZIDGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1718837175;
	bh=Ign5TdU6G9M4MdMnZI47VXx3+msbjyd9rvxNtEj9LRo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=trRZIDGTON8vi3IlT+AJoP5P2jgWO1qy3d2A+I5P8WLEYaQHmH6EDu0x7cvFSeZGK
	 LYGmxiv4DUO1g/O4NW4IC9oTXxs+bL+zqCpuwvNUA9WpyksaNt84mXPm8DuTtBulxZ
	 PZXuaTtgahuiEqslVGlIOGqC0PCjyVBEKkk5dSg3o2fQ1Qz0i6wmwww71xkWXwZ1z7
	 BPdNfgHDloh7bFJFYkDrtlP/rF4GF8GUCu5U3UQnFjHH2nQuY2VV8JMUKerDyKhviE
	 QPFNQqaA+kAaJF51krnkmGkRDLFdSm/3J4iaWdIyMLSvgfYLBRLPJsCB/AS81rCINO
	 HM/mWIPbtjErfaERw/64HvKZqWgQYqTmRsAfjyWfC3eR1u8SFcyFC6sgStYeu0VCT5
	 cqoPGoxGbFIPdwc4hYsoy9BGKJc7U6aQb4kZuY3/jaCxNpGaQESBAN95bHVtRI+DDN
	 F+60NTDqjUpDtLM5ikXIwHiPtNW+x9tjxSCCGc2EfyrlkJhhVfH
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 931692639E;
	Wed, 19 Jun 2024 22:46:15 +0000 (UTC)
Date: Wed, 19 Jun 2024 22:46:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Christian Couder <christian.couder@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
Message-ID: <ZnNftSO13KlmFbQ3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
 <0448495385b009f25a66b0712afb28f1@manjaro.org>
 <20240619134533.GA943023@coredump.intra.peff.net>
 <04b714d3e949c30bae0e26231e923fc4@manjaro.org>
 <CAP8UFD2k9YBoKf_=fj1UKNK+=J-2vMenwt8QyTXXSaf=uX6Otg@mail.gmail.com>
 <20240619145042.GA957055@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ydtTt/UFbHMqDlzM"
Content-Disposition: inline
In-Reply-To: <20240619145042.GA957055@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ydtTt/UFbHMqDlzM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-19 at 14:50:42, Jeff King wrote:
> On Wed, Jun 19, 2024 at 04:01:57PM +0200, Christian Couder wrote:
>=20
> > One possibility is to send just the `sysname`, described as 'Operating
> > system name (e.g., "Linux")', field of the struct utsname filled out
> > by uname(2) by default.
>=20
> That would be better to me. I still don't love it, but I admit it's
> coming more from a knee-jerk response than from some rational argument
> against people knowing I run Linux.
>=20
> Since HTTP user-agent fields are common, we can look at those for prior
> art. curl sends its own version but nothing else. Most browsers do seem
> to include some OS information. My version of firefox gives its own
> version along with "Linux x86_64". So basically "uname -sm".

If we choose to enable this, this is the right level of detail, yeah.
We could also allow a distributor to set this value at compile time,
much like Debian does for Postfix and OpenSSH.  For Postfix, it's simply
"(Debian)", which doesn't give much information.

To me as a server administrator interested in statistics, it's useful to
me to know OS name and version (as in, how many users are still using an
ancient version of CentOS?), since that tells me about things like
supported TLS versions which is helpful, but as a user I don't think
that's an appropriate level of detail to share.  And I also worry about
fingerprinting and tracking, which is a giant problem with HTTP
user-agents.  This is especially true if you're using something like
FreeBSD RISC-V, which is just not that common.

> > And then there might be a knob to deactivate it completely or to make
> > it more verbose (which might be useful for example in a corporate
> > context).
>=20
> Yes, I think we should definitely have an option to suppress or override
> it, just like we do for the user-agent string.

I definitely think we should have both.  I'm sure we'll have some server
maintainer or repository administrator who tries to reject "bad" OSes
(like someone who doesn't like their employees using WSL, for example).
We've already had people propose to reject access based on the version
number in the name of "security", despite the fact that most Linux
distros just backport security patches and thus the version number is
not usually interesting in that regard.  Again, HTTP user-agents tell us
that people will make access control decisions here even though they
should not.

We'll want to honour people's decisions to remain a mystery or to work
around broken server implementations, or just to make it harder to track
or fingerprint them.

I also think the documentation should state that for the user-agent and
os-version fields that they are merely informative, can be changed, and
MUST NOT be used for access control.  That doesn't mean people will
honour it, but it does mean that we can and should feel free to break
implementations that don't comply.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ydtTt/UFbHMqDlzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZnNftQAKCRB8DEliiIei
gdqtAP9nIUmfaJK4d0fV2VPnRcTTzmjN5Q5obQ9O3FA9/m/y5AEAuXae/CTjQmPE
rO1bRIZtMjgT2LLZIghyjr9FvtC+3wE=
=VEtp
-----END PGP SIGNATURE-----

--ydtTt/UFbHMqDlzM--
