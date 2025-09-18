Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF7E573
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158371; cv=none; b=o1MFKICqjyg43xd4I8DKUEUGy6POqxYVdMUAkzAezAUf1gdQTb6mZjI8RYrqnGyugSMnu2VAgdFl1JhnJ8Kn7TUsdSKtfFa/KfNqkHV5fyi6wPyS5PkfbL04dPnkJMdwqE73tkt3ba9F58k2Y5mmGH0etscOwvCdE5aJO+3kypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158371; c=relaxed/simple;
	bh=iIGiMUfa8bPI6N22uYp0DyhDEYN1jNBveu83ZFvce2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz//6duRP8cXpnjUDG8+Lc/mrEJHUjiIw7OqQc17M3cd06jNABnKvDvLS5GbiJMabAOpE9l9bwpYpqkLWHXO9CT1PDfKA6st9poHGDkhjChZCKYzs9xVSeypwpmHpmYag4WY98aIxKhs/jinDP4McfwqtZ3+fCxijUR8xoDCye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=K1OAXug+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K1OAXug+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758158361;
	bh=iIGiMUfa8bPI6N22uYp0DyhDEYN1jNBveu83ZFvce2Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=K1OAXug+9hLWeac5BV7jFGZxx3GW9NOb6nkgmLij+j6OXDWKZ6UnS3BpfIXWtgE2d
	 qmr00UYV7sXFWCBZCf8htISRCg6xQdjj1JL+nGPNv5TF7ET8mkHnM8gQaqoiYXs5NH
	 Uv4AgDd+Gq02L/N9F2h9V84hhbfW2n/d8LmHFo6sUmOuC2cYgw8iuwH0hL/WGs58HH
	 ZYdqGlDErrNwp/g1iwt9XqsVsShbL/cwpIeK9KcPodlZvr+JXAqwYw1ZgOIPbV6jNO
	 hILZHXViy25aw026EWSSaG6HEawAmADjc5KgNrVpNM/VYw80DrXN+O0TEeR2CYl71v
	 LM9nc45m8nQfYejJpa5l9VgO2M2jTAn3jUtUEtyCDlBJUZ3MwTsC3gHeesUMj/HKV+
	 avwWF1WhQh7MNJYd4JEgMx84sLHaDcZ+L0CbJoJzmYJzIH03dYCYphMv0GmANeA5yM
	 nXaSeb+FZDJXwLI+fTSllGa9GxkbJF6Pc+6ZydzfQWMqa31PPQu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cc20:46b1:6e9f:44d1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4A10120105;
	Thu, 18 Sep 2025 01:19:21 +0000 (UTC)
Date: Thu, 18 Sep 2025 01:19:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <aMsxhp6ZO2Cdz7+k@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6WwLnipjlyfiqa5E"
Content-Disposition: inline
In-Reply-To: <aMsxhp6ZO2Cdz7+k@szeder.dev>
User-Agent: Mutt/2.2.13 (2024-03-09)


--6WwLnipjlyfiqa5E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-17 at 22:09:10, SZEDER G=C3=A1bor wrote:
> Providing an LTS release for those platforms that can't jump on the
> Rust bandwagon is great, but...
>=20
> Git 3.0 will switch the default hash algorithm for newly initialized
> repositories to SHA-256, which, presumably, will also encourage SHA-1
> -> SHA-256 migrations in existing repositories.  Alas, it appears that
> the SHA-1/SHA-256 interop feature will only be available in Rust.
>=20
> How will this affect those platforms without Rust?  What will and
> won't work on such platforms?

On Git 3.0, nothing will work without Rust because it will be mandatory.
However, people who want to perform the conversion can do that by
booting a Linux VM[0] and converting the repository there, then pushing
it somewhere.  The only inconvenience is that you'll have to have a flag
day for working with the repository on older Git: you won't be able to
dynamically pull from or push to a repository with a different main
algorithm than you.

One of my first patches is that setting extensions.compatObjectFormat
without Rust will simply die and say that's not supported.  If that
config value is unset, then Git up to 3.0 will simply function as
normal, so full single-hash compatibility is assured.  We already have
that: SHA-256 repositories work just fine with SHA-256 remotes and SHA-1
repositories work just fine with SHA-1 remotes, but they're currently
not interoperable.

> I think it should be called out explicitly in the justification that
> whatever limitations this imposes on those platforms with respect to
> hash function transition, the project has duly considered that and is
> OK with it.

I am fine with this and I don't think this is a problem.

I will mention that I have also already written the code in Rust and it
is elegant and tidy and more efficient, better tested, and shorter than
the equivalent C code.  Writing the code also took much less time than
the equivalent C code would have.  I am not planning to rewrite it in C,
since I already have a substantial amount of other interoperability work
to do, so unless someone else is planning on doing so, the project has
two choices: use the Rust code and accept that, or decide that they
don't want the interoperability work for Git 3.0.

I want to point out that so far, all of the SHA-256 work, including the
interoperability work, has been on my own time.  I understand that my
contributions to the project have to be acceptable to the project, but I
also am not willing to rewrite a bunch of work because we already
decided that we were going to do something and then changed our mind.
If the project wants to be fickle on this matter, then other
contributors can do the interoperability work on those terms.

I realize the decision to incorporate Rust was made recently, but the
binary loose object maps are a blocker for some of the protocol work I'm
doing, and if we want the interoperability functionality in Git 3.0 in a
year, then I can't afford to wait here, since this kind of discussion
tends to drag on extensively.

[0] Debian actually offers multiarch support, so as long as Debian has
support for the architecture you're running on, you can boot a Debian VM
of your native architecture, install amd64 or arm64 packages and QEMU,
and then run those binaries in emulation.  It will be slow, but it works
for virtually all architectures.  I've done something similar with
risc64 containers on my amd64 laptop.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--6WwLnipjlyfiqa5E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMteFwAKCRB8DEliiIei
geqKAP9QLJLRU1BGJmhhefJBppggLOPJDATJP+7taEilmR5IEAEA+M49R/HtTXQf
duq3Ly8C/0DXLzW5ZdGD5x15NVguJA4=
=kKpm
-----END PGP SIGNATURE-----

--6WwLnipjlyfiqa5E--
