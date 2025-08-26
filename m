Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CA30CD82
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245728; cv=none; b=i4OOGFBjovmyuzv719dmBYnPNiZ71KLQNi9OKg1oWhMarGnEN8hZEyi4QyvZ9Fu3w249Q/PTPrTbsrRdPyWPdxbZ1ZIpBoKHys8FI3XaUZeQYaHCaT+m5Xw0V/VrJ5EG1Q/ATFGVsn12WB2wkoau9PerBnGt+DgZ06m3lgQ3fAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245728; c=relaxed/simple;
	bh=lQ6Mp3k5oR/8Qv4qw5xhsydtTTuw2py/TABAy/4tWHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TggLjItOaXxLYSukne9/Pl05kO52CfNpwPVJYQadiiFrby3a8uT3hictphFSGv67kpLsALf0twLo/vs6pJ4Jatb/Ddn/c0gV/TeaZAhFY1RLH5BHNLSIL2L+CpzacAkFU+MQGrgBRUoD8SFCT/alycvE2lJXtDy6RMUtSP17cVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HDyDrMXW; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HDyDrMXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756245718;
	bh=lQ6Mp3k5oR/8Qv4qw5xhsydtTTuw2py/TABAy/4tWHA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HDyDrMXWJRsQW9jT452ojtM1e7MoFqkMI7D7hhaQSQatwLkP4GdiKjfxG/9aZTK7P
	 8ymfj2Alu+2dW/IG/NvnD4cEYP9//5tNly0x912acJkgLOg67wmkdylNPnjeXad4Fa
	 T0RgrGgieVUiY16GWgaCqSKOPQFnH4TV+6GUK364N99jUsLcgkst1nlT0jOUd/LGg+
	 G7pB8OECv7MHv1aUYq4s+58WZADyqulAwfymClGL8K0QEG85VCZHnu6Qgez3u47Wb7
	 afMw+QO0pkYv+AWwpxyuXeThPYr8KcUQNj9ktytTqpLThG77Zppl36fAWi8CW9Eelb
	 KdEZ0lCKA2bnc+6XBFtN7sgptG10CmSUnsh3nTRKabi7WrbDoE28qPtQCxjYMm9DUp
	 5M618OcvGAA1sz0HIrUH7X6cOXz0GU/oKPbxZ64w4oCUPkSnkDmIT9pwgHDeNaZW9K
	 eLhwl2YUT59pExxuBSrlnBz9+dV/QTjO3J8kBNgWLQnHacLsjhH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6208:a4d:7e2:3785])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B8E62200C3;
	Tue, 26 Aug 2025 22:01:58 +0000 (UTC)
Date: Tue, 26 Aug 2025 22:01:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
	Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is
 interoperable between C and Rust
Message-ID: <aK4u1RktHxkQtlWR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
	Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <71B2DFE6-77E5-47FE-9FAC-AFC1B85DA0E2@gmail.com>
 <CAH=ZcbA=-iEFnJ-TecAZL_EX-f3pAShDhdq=S2XWkQHYgRZV7Q@mail.gmail.com>
 <CALnO6CASgMQ=cbQ_ijWXV0RMMSZgvS47r8ucTro7Wc4pgZ9_jQ@mail.gmail.com>
 <CAH=ZcbD_pX1YdZbt9b-xMmcu2806twhjECez4HhCyE9iBf-9=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e8WD/zsdTftWj5bn"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbD_pX1YdZbt9b-xMmcu2806twhjECez4HhCyE9iBf-9=Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--e8WD/zsdTftWj5bn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-26 at 18:47:06, Ezekiel Newren wrote:
> I'm curious if the community has more design feedback, or suggestions
> for an alternative to my ivec type.

I think this is a fine approach.  We used a similar Vec<u8>-like
structure when porting a service from C to Rust at $DAYJOB, but we've
also used the boxing approach to good success.

Ultimately, I think boxing is the right choice when we don't need access
=66rom C.  For instance, if I were to convert the loose object mapping
code to Rust, I would store the data as a pair of Box<HashMap<_, _>> and
then attach them to struct repository as `void *`.

But it's less definitive when you need access from C.  Because of the
way we intimately mess with the internals of our data structures in this
codebase, the ivec is probably the right choice here, so I'd keep that.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--e8WD/zsdTftWj5bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaK4u1AAKCRB8DEliiIei
gTe0AP4zFZmIMN4PPxrqkT6RVDUCfvkrc09cGnefn8xW9lzDXAEA1cZzQA10SIhQ
KFIEu81tgfODgVT0QUfe8WXBUKfX/go=
=y6fx
-----END PGP SIGNATURE-----

--e8WD/zsdTftWj5bn--
