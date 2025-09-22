Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE50D8F49
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579322; cv=none; b=ppbQMsUhISXCyImy9HkE+HhB3A4YqC1M5it8w+eAfA1lc345tLlQx8MxJJ8PrElDhriyalCzfLXgsAsNAmCUAuM0JjEW14dJOY0r1uQJWiWtsUylSl1giV2fBpoQBymuZclCLv+A2LZ08WxNmcEyXlWqMUYn8ToBzS1hBuCtWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579322; c=relaxed/simple;
	bh=6vL6NtDY0/EmURMhniCTBq7sM21BCX7yIiqE7oB83jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pso1lKVYO9KkW2xdsHwE66VItqUjKA6rhYkjUn2I6zKdXvgI+Gp7DQ+ICFGT3puBuuFW+TIWAuaqLddxjIWJYaXGSI4K6HcUm3ACUbqxw0NN7swxklZMkNgp00pGQTlFl7WvKy1pmOM5KWQrlNNqoBa/xTLxLNfY8QlcTOCHj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=okarxZ+H; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="okarxZ+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758579318;
	bh=6vL6NtDY0/EmURMhniCTBq7sM21BCX7yIiqE7oB83jU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=okarxZ+HoiHHdiCNv6LPDKMUoIrWVNVbSv/wyx52fIIONcM+ArTxhxtvGUaxREses
	 8Gb8WaInHHgngdyb9IvrJnLWwZyI0UmXSCtgoyjAqb78qk/Fnu7jZoc/vEzOU/3RZH
	 t2o1kOq+wbZgVbV/hOb+BaB94XAfgZljTSqEMb0UIoyqF+pAo/pii2H89AoVUiPQWv
	 CmAFx069KqQ9kW9bo5EaxyXBKi8jBnwsGUGbcDaGfLhNmXwyR9Zwf+hVL67HH3Lc4l
	 TNrsBwC8ftSwizh/Ri1VWbQ8Y2hJA23NdX/ncdO2r3UkRcqvaxEZjpD/4Ejd9bRbDE
	 nPSEx9XXjAuZMCFUQ2O5CdsVkrZrej8iPSq/ihcTkaz7hp3l6YS/vzcPsSMjjrjT6c
	 +0c48YqfWp6EkkzZSa0VDXJIqrgAN4fdN+iQtILhsBz5npQoEZvK1Z7vgy6B4LkEsT
	 snwrDbTzjwe14LQ1uVz844D68mnlBHoLxmUYWgbrYw2IcOdpZrp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7cc9:7232:f513:ebf7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1C62D20105;
	Mon, 22 Sep 2025 22:15:18 +0000 (UTC)
Date: Mon, 22 Sep 2025 22:15:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
Message-ID: <aNHKdFkiGLPcLEjP@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
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
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <aMsxhp6ZO2Cdz7+k@szeder.dev>
 <aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
 <aNGkt/DdnbjNu3s8@szeder.dev>
 <xmqq348etd9n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVuZV8a8o8GxiWl5"
Content-Disposition: inline
In-Reply-To: <xmqq348etd9n.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--EVuZV8a8o8GxiWl5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-22 at 20:59:00, Junio C Hamano wrote:
> The version of the document in this thread talks about 2.52 (opt-in)
> and 2.53 (opt-out) before jumping to 3.0 (no way to opt-out) but it
> does not say anything about how far out that big version bump is.
> But the numbers I remember hearing was in the orders of 18 monts or
> so if I am not mistaken?

I think the plan was 4 release cycles, or about a year.  Git 3.0 was
going to replace 2.55.

> As I already said a few times (e.g. <xmqq8qipzhg3.fsf@gitster.g>), I
> feel that the timeline hinted by any of these documents that were
> proposed is way too aggressive for affected people to practically
> prepare for.

I don't think it's substantially more aggressive than the
interoperability code.  Both are aggressive timelines, but getting LLVM
ported to some of the affected targets isn't out of the question
(especially since older versions of it supported some of those targets)
and once that's done, I'm pretty sure Rust upstream would be on board
with supporting those systems.

> By the way, I was hoping that the hash compatibility work can be
> done as an opt-in item available only for those with Rust, while
> Rustless folks are forever stuck in a single hash algorithm world,
> and be released well before Git 3.0 that makes Rust mandatory.  That
> does not change the fact that nothing will work wrt hash transition
> for Rustless folks, though ;-).

I would love to have the interoperability work in sooner, but I don't
think it's realistic.  I have about 100 patches and I expect a total of
200 to 400 for the entire work.  That means someone has to send in 50 to
100 patches every one of the four release cycles before 3.0 and get
them sufficiently polished to get accepted, including any necessary
re-rolls.  I don't think you actually want me to send all of those
patches for one cycle at once, either.

Even with time to work on it at work, that's a lot of time and effort
for one person, and I also have personal responsibilities to family and
friends (someone has to cook dinner, for instance).  We'll see if
additional assistance is forthcoming, in which case timelines could
possibly be more aggressive.

Otherwise, if we want Git 3.0 to contain the interoperability work and
are unwilling to ship without it, then we may have a longer timeframe
for Git 3.0, and it may be more like replacing Git 2.57 or 2.58 instead.

> [Footnote]
>=20
> * By the way, I _think_ I never saw that policy document until
>   Ezekiel started his topic and sent it out as one of the component
>   patches; how did it get there from brian to Ezekiel's topic?

I had it in a branch of mine that I was going to submit at some point
and I mentioned it to Ezekiel, who modified it and incorporated it.  The
original branch should be `rust` on my remote for those who are
interested.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--EVuZV8a8o8GxiWl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNHKdAAKCRB8DEliiIei
gYkbAP99O3IxF960pleNaqEsCsda+D3xO8PCiuKehI/L0/QugAD+NzIPXM48Es21
wXwuBL1b70SZDByss8BRL4WCp+hnfQc=
=IIN6
-----END PGP SIGNATURE-----

--EVuZV8a8o8GxiWl5--
