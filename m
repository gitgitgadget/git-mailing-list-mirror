Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8E168488
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500856; cv=none; b=ZEEKNdVLjTqsywkXQkTNU+BToFN+7tIkVdmifqDMPq2sFGpzFIhzfeogK3iwmmeKwsd/PIRAlySGxU5QXTgxdYVLzxSpXSzDmpZuDuvkPMQljah90BrIiT8mJ1uxLV/U1bXpLeT7Gzi70SKKxvgU82UMWCO5aMXbXT8ByFjoJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500856; c=relaxed/simple;
	bh=NkKck0oTSm6vzc8bLZTFkUByBP4AmDEvJe06TBct7a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2z5UY83c2c+5GnbW073PqdYxdCcfSCbSpiWVo1q4ddG1p5OjzmiNfQ037bdyO/QwK1GwlkYpJn+uYvINhHJRzEq6rEHcuA9L98A9ITlqvhOva3JP6cyfKVqJW8Y3SRXK0OsywIVgdQMDC8ZRf4jHIxlRO5RSWiZACob7p3vRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uXN1/pUv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uXN1/pUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723500852;
	bh=NkKck0oTSm6vzc8bLZTFkUByBP4AmDEvJe06TBct7a4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uXN1/pUv2bsPT9BP1/CiLJqmGu6pwD8bSCuAqKXqQfLPf8fI9l/XiStjMtFgUaWJT
	 z61IlCeIacw9BIdzG1E1I5u8Ahq+S5MKuww5va5ZFtOgS5cisJaMP7/pgFae5pXzqz
	 /RAeFyEIVnMcNw9z9EJC0wEFRJAabEF/FJgiR712nXaFEPjzrjR0wQgXUUId6OHD10
	 faPxCBKJYxW+/Nl+H9RO1o5QXCfe3BjUOl449RGLxjcwAdOh0ANmwxs+3VUwU7IW/2
	 KxDsx6jCRv3xMD3+P52MhKkA8ng54KX1btb63npBy9bgokcy5IVWfDuUCTHYQ1lvmm
	 IfB8dq84Ot20n4P+7vqRzIygdgpQiadQPFfGwfiCML3LoqnXF2eWR77ClDj5aCuIWG
	 gJoUwrPFOydkRXmYBL71iSySwB+iemE3NRVzIjItWW5MOYcDDvN3kZpGMatOwQJxBk
	 2UaKPRxWEbnj7FyfS8/vy8AdMME7VEqQlnaTEVoZFwX0pOa+Zff
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BA8D0209AF;
	Mon, 12 Aug 2024 22:14:12 +0000 (UTC)
Date: Mon, 12 Aug 2024 22:14:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, mh@glandium.org
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
Message-ID: <ZrqJM-vmPaJbdHP2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, mh@glandium.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <xmqq5xs688cz.fsf@gitster.g>
 <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jxjlzv5OVnV+ZOLG"
Content-Disposition: inline
In-Reply-To: <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Jxjlzv5OVnV+ZOLG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-12 at 09:03:57, Eric Sunshine wrote:
> On Mon, Aug 12, 2024 at 4:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com=
> wrote:
> > The original iteration had this:
> >
> >     * bikeshedding on the name (yes, really). There is an active, unrel=
ated
> >       CGit project [4] that we only recently became aware of. We origin=
ally
> >       took the name "cgit" because at $DAYJOB we sometimes refer to git=
=2Egit
> >       as "cgit" to distinguish it from jgit [5].
>=20
> A tangent: Speaking of external/other projects, I don't think we've
> seen an explanation yet as to why this Rust wrapper is proposed as a
> `contrib/` item of Git itself, as opposed to being a separate project.
>=20
> I can only think of two possible reasons why they might want it in the
> Git project itself...
>=20
> (1) Easier access to the library portions of Git ("libgit") since that
> portion of the code is not otherwise published as a standalone
> library. However, a workable alternative would be for the Rust wrapper
> to carry its own "vendored"[1] copy of Git. This would also ensure
> more reliable builds since they wouldn't have to worry about the
> "libgit" API changing from under them, and can adjust for "libgit" API
> changes when they manually pull in a new vendored copy. Hence, I'm not
> convinced that this is a valid reason to carry the Rust wrapper in
> Git.

Please don't vendor packages like this.  This means that every time
there's a security vulnerability in Git, even if we ship a public libgit
and even if the security impact doesn't affect libgit, every security
scanning tool will demand that the crate be updated immediately.  This
wastes colossal amounts of work and it's hostile to distros as well, who
will have to repackage the source to remove the vendoring.

At work, I maintain a codebase using Nokogiri, which is a Ruby gem that
vendors libxml2 (which has an absolutely abysmal security record), and I
cannot tell you how much useless work I perform updating this gem
because of security scanners screaming about the vendored libxml2, even
though it's completely possible to use the system library.

> (2) Perhaps the intention is that this Rust wrapper work will allow
> Rust to be used within Git itself[3]? If that's the case, then
> `contrib/` seems the wrong resting place for this code.

I think contrib is the right place for now.  We may in the future want
to include some Rust code in the codebase in some context, and this is a
good way for us to experiment with it on an interim basis and discover
whether that's a viable approach for us.  Perhaps it is, and perhaps it
is not, but we'll have built the experience to know for certain.

I could imagine (and this is hypothetical and speculative) that we might
allow some sorts of performance optimizations and optional features in
Rust, but require core functionality be in C until Rust is better
supported on some platforms.  That might be a nice way to improve things
like multithreading, which Rust excels at, for example.

As an example, I'd like to write a random-access tree parser[0] in Rust
(such as for "dev:README.md"), since our current approach performs
terribly on large trees (it's linear instead of logarithmic).  However,
I'm not willing to write that code in C because it's a giant landmine of
memory unsafety and I think it's too likely to be buggy in C.

[0] I am aware that due to the structure of trees, this is not _always_
possible to do, but it is possible in _many_ cases, and optimistically
trying and falling back to the old approach may still be faster.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Jxjlzv5OVnV+ZOLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrqJMgAKCRB8DEliiIei
gS7FAP9dqpkJ8GwvascnZ3Z0kTIXJMKeWGiBLEH0pRm2YSoTTwEA/JEQ92MTla0M
lTL/oHW4wSTewH24a4gTkTeMkvmolQk=
=Xs9R
-----END PGP SIGNATURE-----

--Jxjlzv5OVnV+ZOLG--
