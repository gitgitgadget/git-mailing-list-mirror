Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201463451AB
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834035; cv=none; b=Pa39JpYMXmt4iCCIhXxaA+0Hu+D3whLrWwFS9cR5EOT0OIIV1Kc9nM6zek1EXUAgAGT7QMwlxHvyktIqpmmp6Yyp/ua4Z2tR65d7EHHYuKFAr0ZtZ0sDguAQdmKqIicEn//OsObnYVW2RJGRP3svQW0ktNg3H0zzyD6ERHzWqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834035; c=relaxed/simple;
	bh=TtnbMRQIhKA/RYgGQKZy/te2wEZRhoc+WneG2uHkYsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVoJzHrMQ/4wl3eliONUhyksM3GWcIhToUIViXjlBj3ObIroFIHDHBXj9XEWAhQypxupO5qTtM0whXuzoFTAYStyZeLTQlIbtS7pbLLz9bO3clm8bsI0eEAFFOYV6z2J6u38dh5zxk4lFnTWCJ0QXgXTNcTxRHjOZ+5AZ87ctDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DnAHoEbs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DnAHoEbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756834031;
	bh=TtnbMRQIhKA/RYgGQKZy/te2wEZRhoc+WneG2uHkYsg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DnAHoEbsc91LIfNZWXswchf0xnK9uT4dlkYzf45ZMYIUxxLFpkHBLz62CaINaEBVC
	 DOnuRaTefjDPMOwbxfec2qWNedwOrhmWL9c740RZH1Cg/NbvBbHffXzWPqIFE41C00
	 V4a85g0VyI76nhImYm/LWn0Xu3Jj5qOIkLbUEsTNuGndHIAnpvZC9leWhxEAlWmUzs
	 juX1E5FLCmkhPmi1Yl+b4OQdYt9jmbRhdSn3l8jn5pgPaBB1vvU/il6TP+QFvrxA8G
	 gY7A6inGYM3Iwivlgx8MfdoXQO5P1hwtSQYJB8SzAvzQAw3I3qeIoP2IKFiSiUY4+C
	 GsyhitpgOiF1fllchYIDATMDb67kvrjeC7f/tj1PB2/2FBrPR6oeiNHCH/2/qkyLCN
	 I0MOMK+4I02ffQ9EWIVvcNwmOkrxj3jzwX5DUEx3/r0jzVE2sqcf3n9w21v4Cjhrad
	 aBbBCLadq3AzNqFhQYoLpT8nMcjhXYY+hY14D69auo6OV/+maqO
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d044:75ae:17c6:f240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 95688200BE;
	Tue,  2 Sep 2025 17:27:11 +0000 (UTC)
Date: Tue, 2 Sep 2025 17:27:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	rsbecker@nexbridge.com, 'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
	'Elijah Newren' <newren@gmail.com>,
	'Kristoffer Haugsbakk' <kristofferhaugsbakk@fastmail.com>,
	'Josh Soref' <gitgitgadget@gmail.com>, git@vger.kernel.org,
	'Christian Brabandt' <cb@256bit.org>,
	'Phillip Wood' <phillip.wood123@gmail.com>,
	'Eli Schwartz' <eschwartz@gentoo.org>,
	"'Haelwenn (lanodan) Monnier'" <contact@hacktivis.me>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Matthias =?utf-8?B?QcOfaGF1ZXIn?= <mha1993@live.de>,
	'Sam James' <sam@gentoo.org>,
	'Collin Funk' <collin.funk1@gmail.com>,
	'Mike Hommey' <mh@glandium.org>,
	'Pierre-Emmanuel Patry' <pierre-emmanuel.patry@embecosm.com>,
	"'D. Ben Knoble'" <ben.knoble@gmail.com>,
	'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
	'Ezekiel Newren' <ezekielnewren@gmail.com>,
	'Josh Steadmon' <steadmon@google.com>,
	'Calvin Wan' <calvinwan@google.com>
References: <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com>
 <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
 <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local>
 <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g>
 <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jVEYVeO/eTo5daWA"
Content-Disposition: inline
In-Reply-To: <aLbSA5KsBdD4wW_B@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jVEYVeO/eTo5daWA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-02 at 11:16:19, Patrick Steinhardt wrote:
> As Pierre-Emmanuel menitoned in [1], the backend is likely to stabilize
> next year. One or two years of backports for that particular LTS version
> doesn't feel too bad. And if it does become more involved we can maybe
> also distribute the load and rely on maintainers of impacted platforms
> without Rust to help out with the backporting.

I'm very much in favour of supporting gccrs when it's available, but I
also want to say that it currently is targeting 1.49, which is much
older than we want.  It's also not necessarily going to be fully usable
or bug free in that amount of time.

I also want to point out that it's important that the maintainers of
affected platforms build the tooling necessary for their platforms to be
supported.  I'm not seeing ports of LLVM to those architectures or
contributions to gccrs that would make those platforms easier to
support.

> Also, all of this feels like a significant shift. I'm strongly in favor
> of adopting Rust in our codebase, but I think we should do so carefully.
> So we might take it extra carefully and say that Rust will become a
> mandatory dependency in Git 3.0, where the last release before Git 3.0
> will become an LTS release.

I'd prefer we not wait that long.  I'm doing some work in building the
new loose object mapping using Rust and it's much more efficient than
writing it in C because we don't have to sort the data when we use a
BTreeMap.  The code is much simpler, shorter, and easier to write.

Nobody else is currently working on the interoperability code and we
expressed that we ideally wanted it for Git 3.0.  Being able to use Rust
means I can write that code faster, with fewer errors (and hence less
debugging time), and better tests.  Otherwise, I'm afraid that it will
take longer and we might not have it fully upstream for Git 3.0.

We also have this series right now, which we'd have to abandon if we're
not going to support Rust right away.  I'd like to retain Ezekiel as a
contributor and incorporate Rust, and I think the best time to adopt
Rust is now, not at Git 3.0.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--jVEYVeO/eTo5daWA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLco7QAKCRB8DEliiIei
gaV2AQCBdd3kz9cL8mDRIQDPJej1O2+kOYlJLGZp3qNVk0C5cQD9FkV+TNTeVdJu
1i4w3/iG9iw1JYtqp2mpsDRrOKWvGQc=
=hKe1
-----END PGP SIGNATURE-----

--jVEYVeO/eTo5daWA--
