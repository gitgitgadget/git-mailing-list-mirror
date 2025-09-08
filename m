Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3E3054E4
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372434; cv=none; b=C11dgC0cVRX/uAJjoBjXu8vCiOsHxsvXkpvQBjPZmG6E+6CEMany1lv4RDhAxTeReWM7jf+jqHoLqEWxtC0fpQsb5Zp1Pv/CX6IGtmaZFTYRrie+ZKxjfNXMFJkRzkG420btIDER+nVq16FuN3ZnVKJUnWnaN3pkzGTTUDOgWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372434; c=relaxed/simple;
	bh=c4H1YaDc7oNrKU+iZSA3fKCz9JNYwQHXwdHZbWFA6Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJAJVT1FZAkFs5vkL3BMlUf6ORl+vl2R7Ee+H2+N0GSbKkRW5Tf7u//77dT7pBjmvSkNAKBEUWDs28IC73YlrTAXBPlwQT9R3XFnyw4okbDyMrESzmnv5bkoyf+ZEa5EcuesDS3dl9r3GXicj5Pl+eHwBCJ3TasvriSCMAsEkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=z5h5Ds+W; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="z5h5Ds+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757372430;
	bh=c4H1YaDc7oNrKU+iZSA3fKCz9JNYwQHXwdHZbWFA6Yk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=z5h5Ds+WHbdJI5NFRrLyxtgupluOClLTnyMJPN6PWxVaXHfMc3bor8vJCfd725YvM
	 W+AlZPGUp3d+h2Hl8yPyJhYgu+Ekk3lW/yoxBhCIx+CTY4Q4OhtSIAwXIkEwj60ZG6
	 9bf051VaYn6J1K+FugohvSWMfhzWFhxJa4Z+AAqipNz1IRTmketh4aqrW3idi1ZynV
	 FC3zB6IkIOWKRPDMrHjpx6N8/uc5wZO6Z27p2ssWg2XcOy9jZzdiMz/d8a0RXcV2Tz
	 cpmi4gDTulzNFVY1sIR0/Ui7N8BQuBeQ9L0WFoy3Ym+Iin7PdCh43PmP7Xar5Xf/7h
	 LJ0LZmaZA4dvBV0ZWT+SfD2d1j2rBHmlkWHQoFfQ/9PbnqxEMqzkE2lyjPQ/Vc4zdP
	 f1lrKLfqf+aWDyU+I8hckYkeLf/wcN0IXduGvpM9SvnDc9RtWfX4nU85Axuz9dSt4J
	 Iphl5nOPBurBNxkTchl4ZODU5q5tr2EtR0MhWTuQ81HF8EAjE44
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:91aa:86f1:d85a:ac64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4747A200C9;
	Mon,  8 Sep 2025 23:00:30 +0000 (UTC)
Date: Mon, 8 Sep 2025 23:00:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
Message-ID: <aL9gDXNJCGH0eIsY@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
 <aLrzqR2Z9jz5CuJu@pks.im>
 <CABPp-BGpdEP9+CTApknmGNO=b=66bFKVzWL2s3gmgCMtTBTjPA@mail.gmail.com>
 <aL57ONmEKTmqFhIZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UkH3FImVEkaRTpy+"
Content-Disposition: inline
In-Reply-To: <aL57ONmEKTmqFhIZ@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--UkH3FImVEkaRTpy+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-08 at 06:44:08, Patrick Steinhardt wrote:
> > Setting that aside for a moment, the idea of Git 2.55 becoming 3.0
> > seems like a good idea to me, assuming that doesn't rush brian on the
> > sha1/sha256 interop (since I think that's probably the paramount
> > feature of 3.0).
>=20
> Yeah, the interop is definitely an important factor and the last part
> that I think is still missing for Git 3.0 to become viable.

I am definitely working on this at the moment and here's what I have
working:

* Pack index v3
* Fetching and pushing for full (non-shallow, non-partial) clones
  without submodules

And I'm working on these:

* The new binary loose object map (I was debugging round-tripping this
  morning)
* Shallow fetches (which, due to the quarantine usage, need a binary
  loose object map rather than the `loose-object-idx` file, since the
  quarantine can't merge the two `loose-object-idx` files together)

And then I'll get to these:

* Shallow pushes
* Partial clone
* Garbage collecting and repacking binary loose object maps
* Submodule handling in the protocol

I will need to switch soon to writing my presentation for Git Merge,
though, but afterwards I'm going to go back through the testsuite and
see what else is failing.  I expect partial and shallow clones to fix a
lot of the remaining tests, but there are still going to be some
problems to deal with.

Note that shallow and partial clones where the server supports only
one algorithm won't work with interoperability, since those lack full
data and the client side won't be able to map the objects between
algorithms.  There's also the problem that accepting submodule mappings
introduces a security risk, since it's possible for the other side to
send commit A in SHA-1 but commit B in SHA-256 and there's no real way
to detect that unless you have the submodule on your side.

I may end up asking for some assistance in polishing and sending in what
I have.  Most of what I have is reasonably good quality[0] and should be
bisectable, but I'm up to 81 patches before the Rust part of the code
(which so far has 12 patches) and I'm worried I won't be able to both
write it and get it sent in in nice-sized series before 3.0 is likely to
happen.

Alternatively, we could maybe accept that interoperability is a
nice-to-have for Git 3.0 and not an essential.  It's not mentioned in
the BreakingChanges document, so it's perhaps not a requirement.  We
could also have someone work on this as part of their job to get it
handled more quickly[1].

Finally, I am currently interested in working on the interop code (but
have no problem handing it off if that works better for the project),
but I cannot guarantee that I will absolutely have time or inclination
to continue.

[0] There are some patches marked WIP with a reason as to why they need
work, but those are few and far between.
[1] I think it's unlikely that this will be able to be me for reasons
which I cannot share at the moment but hope to be able to later on,
maybe at the Contributor Summit.  I'll keep an eye out in case it
becomes possible, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--UkH3FImVEkaRTpy+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL9gDAAKCRB8DEliiIei
gV7VAP9/roTW5hRQ+rrfL3IKPZ4iJhS3wDf+uplrIQLYMgYerQD9FfNwOez2Rl2o
p11wC51IKwH+qyr8rxTNz1FUOxYl+Qk=
=IHCM
-----END PGP SIGNATURE-----

--UkH3FImVEkaRTpy+--
