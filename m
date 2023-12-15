Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9358471
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oPeX9DQi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2XaSEVq8"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2E3215C01AF;
	Fri, 15 Dec 2023 01:29:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Dec 2023 01:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702621748; x=1702708148; bh=L3BR8UQpa3
	7xBgEigxlly/Pv1G8Hfn9QkpLx0Ni9qOc=; b=oPeX9DQiMOn0mPdlP4mvrIO9Md
	Gd0eC4HrLOJ0/ggtdO27HaOsVS0+jdTuYc28m5zuvk2bO5WQTIwik+EW5iDx7xUE
	95nqkXf0XvL+Zkqt4toYZhhZbBHPqOCVTLTgbPJPeVLlX2PyFa3wNzyUWRyhDfWf
	Lr3iJGd4GS4I9C6Rr9EJpZvRjJqGsRFq7LFgkebBJR2+mvfONVzmdB6uuZdc9qX+
	hu0DhWI8ZuQbKKcDUJKBZWcM0dus9wE8NDhi+uAL5Id/wekm8iC/adYKT6F18slc
	A0kn/MGMJIwpkfoApNqDSM+TgsajyR8y4s89MQQUL3jgiZeOWHGK5Aw4Kh2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702621748; x=1702708148; bh=L3BR8UQpa37xBgEigxlly/Pv1G8H
	fn9QkpLx0Ni9qOc=; b=2XaSEVq84CTr/Lg8r+zr3EDH7Uk8gTjKlf8pXTOKPwkW
	MXgp7Tz47Bl7F4QFuWkgzlAoB0uXBLyMQk01QGB/OjH3we0ec00H8HarT9vejwFV
	zsieMcRyqrksiRIloMZIjOm2a35tuuD8PcwQpuOxNGnqMKB9zGic25UXwWF1orIA
	ZWB2AJkgTNUz1z7vUdCpAv0g2LIP8B1V4GFQNFRM8MEo7z2lUclYRgwdwmUfaS7z
	5dEWZg+tDI4jM5lsXOadepa6kiGfxPPUtziuh/R0y4JsC0tLOfXLXEmmWQh5Ntxq
	BtLeispJH4bbEK2HaZhWEFzFBGuwP0HHPv5a8sPOBA==
X-ME-Sender: <xms:M_J7ZebNJcNXefsSgeX0BvPHQXA-EmKFfU4GC5u9vtqGbZWR1D1fWA>
    <xme:M_J7ZRZrE5pPGuuxYvPI2UcQubLxs13K36Cg6yStw9KxZvUG-mK4FTnV0KEHmbGZu
    gsYTEVXKQcbMi058g>
X-ME-Received: <xmr:M_J7ZY-0ItCgKp8E2aCb8-U9gySojVYXOQqTgPb8ZLxI8IU8CviftAdsEvcRRqPD7aozAa6aJUQfJREvlBX8VDgXIm1yqiuX82PoeyA59YMJkQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NPJ7ZQrHtodqkqLeL_KSmxK9DE0ilmFEH5qz688DecFY62RivlW3Hg>
    <xmx:NPJ7ZZp_IWXc525g3Q_dcQiiUltrm2a8MpA0BvBB_xy4fD_c0XY2XA>
    <xmx:NPJ7ZeRMxtarLmTUJNXQDnOM3CHh5G7WbpWRoWjuboh5HZE6rMIGGA>
    <xmx:NPJ7ZaDp9xnLA7IV30ADiG3UNV1tGNfhyZ8uT6oY0OscfsF7HIJK3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 01:29:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e952dbee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 06:27:20 +0000 (UTC)
Date: Fri, 15 Dec 2023 07:29:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] tests: adjust whitespace in chainlint expectations
Message-ID: <ZXvyL2wtoTIt6OVc@tanuki>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <8c3e1cb5eae13210070cc14f5f2a3f8c0dfc39c3.1702620230.git.ps@pks.im>
 <CAPig+cQozi+aiTc5Bve4OHrfuSRGUCSkKmhoYtkGTmn64Ps-rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LHO8QUawvHQsevqd"
Content-Disposition: inline
In-Reply-To: <CAPig+cQozi+aiTc5Bve4OHrfuSRGUCSkKmhoYtkGTmn64Ps-rw@mail.gmail.com>


--LHO8QUawvHQsevqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 01:24:20AM -0500, Eric Sunshine wrote:
> On Fri, Dec 15, 2023 at 1:04=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > [...]
> > Instead of improving the detection logic, fix our ".expect" files so
> > that we do not need any post-processing at all anymore. This allows us
> > to drop the `-w` flag when diffing so that we can always use diff(1)
> > now.
> >
> > Note that we leave the post-processing of `chainlint.pl` output intact.
> > All we do here is to strip leading line numbers that it would otherwise
> > generate.
>=20
> Hmm, okay, but... (see below)
>=20
> > Having these would cause a rippling effect whenever we add a
> > new test that sorts into the middle of existing tests and would require
> > us to renumerate all subsequent lines, which seems rather pointless.
>=20
> Just an aside, not strictly relevant at this time: =C3=86var has proposed
> that check-chainlint should not be creating conglomerate "test",
> "expect", and "actual" files, but should instead let `make` run
> chainlint.pl separately on each chainlint self-test file, thus
> benefiting from `make`'s innate parallelism rather than baking
> parallelism into chainlint.pl itself. More importantly, `make`'s
> dependency tracking would ensure that a chainlint self-test file only
> gets rechecked if its timestamp changes. That differs from the current
> situation in which _all_ of the chainlint self-test files are checked
> on _every_ `make test` which is wasteful if none of them have changed.
> Anyhow, with his proposed approach, there wouldn't be cascading line
> number changes just because a new self-test file was added.

I was indeed also thinking along this way and would tend to agree. I
punted on it as I honestly only really care for fixing the immediate
issue that the post-processing causes for me.

Are you fine with deferring this bigger refactoring?

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/Makefile b/t/Makefile
> > @@ -103,20 +103,12 @@ check-chainlint:
> >         $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
> >                 sed -e 's/^[1-9][0-9]* //;/^[   ]*$$/d' >'$(CHAINLINTTM=
P_SQ)'/actual && \
>=20
> The commit message claims that this is only stripping the line numbers
> which prefix each emitted line, but the `/^[   ]*$$/d` bit is also
> deleting blank lines from the output of chainlint.pl. Thus, this ought
> to be:
>=20
>     sed -e 's/^[1-9][0-9]* //' >'$(CHAINLINTTMP_SQ)'/actual && \

Gah, you're right, I missed the second part. Will fix in another round.

Patrick

--LHO8QUawvHQsevqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV78i4ACgkQVbJhu7ck
PpRkdA//XvbD4r20EsrXmvefO0PGZyD32IbqY8G+u7NxMHU10eQcJKEfmJWxVGIk
4DmdSPELma7khhlkdXgwO046fmgUwxE26qv3wtsWQx23rSrHz2CADk7MtyHkOq5X
6MV7O/Tv8BPXAM7rPw/rZAwH148lruoksYjYW4QyQuFgQIaDMR+M2Lg8lnrlLyBx
s7ZZjyU4TBVpmpkrXuPFDuH2nSnur6vl/GooGwCShHbnYooYAqk288dUmf8OsISR
ttlWsVMolOHKvVjSD94Iaaw9MAfGqner4xlfwQdmHVtakSPSgBEpdYFWLy8ERGon
kLfy0halgUVYeji3FIwraisRPdGpTmH/247vQsuHHAcP5WNmM3LAXuy65LP1m+cO
iVgysF1zekkFNd9JauMp52Rc0N9tQ9iVNwpr1Cu1vEsDBXpRz5tXAQ/JiDWFyJUq
nGBKtSlRnQRTwc35d+/OjkOGA+sBvDE+i/KAhu8kuwuf05ho7NKJjbf+or+mHu5r
3oJh+voF2SshlfBfYsO9HfvJqpCxrHDZNNvIxqBK9Vu+wgjUUaLgVr+2ny9YMstP
0qChzfrordcGLzmHQJ6HIkeNwFKTSCAEAmqnACZeE/ZhCue6ZeoNZ4IfwFtD+nPq
jlUPCKkaT3Fm5zKf7GCBeKQzng4QaqQTU1AlSrawv2HMJRyG0RA=
=wFVP
-----END PGP SIGNATURE-----

--LHO8QUawvHQsevqd--
