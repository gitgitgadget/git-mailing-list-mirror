Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BDCA64
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I6LsyDK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwrW2dTx"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E66FD3200ACB;
	Fri, 15 Dec 2023 00:33:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 15 Dec 2023 00:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702618393; x=1702704793; bh=PNxU/vpr3n
	F2XaUC3NjzKi2M+JImX+CVHPPgdXjXnJY=; b=I6LsyDK+YThx4w+3NaR54MmagD
	rJpXq8ZdcO4MbLj9o+yXNNoH3bqqjWyirTPWfSIj3V2bPFDNFseaphhldG793pLL
	5ypGVh4rcOvLThruPhmq3pA7ssamhreOiANyNV4Phq3jgEzTCmlK2ZCJCTBn6w54
	BdB5dlYGNVH4pKlSqt4QPDCmvFSdnz1naQB+OgJ+Xxi94tWAmxH2eDDe5WuXJ30L
	slQoqFdMXOez49RjaoxCtLwAupbpomJ/ptEcWklT5MEQw6C7MIYUt73es/Xok0CR
	dmepM7fhGdUotUWTzcaw6XGgMxJkp5SGB7lI46M0Hsp41KBi2CeGu6RUlf+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702618393; x=1702704793; bh=PNxU/vpr3nF2XaUC3NjzKi2M+JIm
	X+CVHPPgdXjXnJY=; b=NwrW2dTxWcG1ZNBWZ2u99z93T5pX5nmW/3aA4dAqJzmF
	kbvDnHMrizKvVYY63i/+1+PhgH5s6MLVxqixBsTzeY0kXlx66NaNjbkQ/TNnbiVz
	9jAjuA7qj+USpTArsCSkhUcsXBsJa7MfbSYc/DJyPiLpRyciAgYFL+93X5prT22+
	QxRFOKEKBE0uv5DboPkhBnC6c+9hZ1mIr6OPvgWv4wzjkUwfg0jpdelxR1GOQzyA
	Zl5eJHZAqmqG7oHCDaHMlWfUIzbxPSXTn5eYndQHvXoR81Thi8NODyzU0jqDll+k
	Fc/xsMI5mYcC0F+mA3v5ZviSiuXG4UHCNyI5sS9QCQ==
X-ME-Sender: <xms:GeV7ZR-TfI4lFgKXjyUPFaHNwMnMv7NUCWWQ0350T_e7JVX_b_udaw>
    <xme:GeV7ZVuawmHTAmgs8_cG-B5wjQlDK0Dcx1H7Y6p0glFbZ2dZpCCQT6HP5Hv2AkUo0
    Tzf24tsLbopyUqP6w>
X-ME-Received: <xmr:GeV7ZfDSzaMxBoIcF5wztqYZEc11nuEP_dniGp8TxjVDES-LEy7xYo-IogTVCuKFMLbieAFuA8VCCXELuyAKtIbJE-pXLy7O53khr_x5wQ3IB1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GeV7ZVfcSYRu8HaxrvbE-_1Jwwu4X4F_jEC-44-fYt3SkRPEkjv9fQ>
    <xmx:GeV7ZWO_4H2ht0ZWS7rb-yBw1gdowg6oSrWScY6jug1Ud4Ej4A_TRg>
    <xmx:GeV7ZXkLz054VLhhO3SqwX9mENuwaBc7jwB0ix6EfHUNGEz9VIIoMA>
    <xmx:GeV7ZY17Seq2_ePa8Zmxa8fQL9iBHkbjIUzWNjWDhdCqRxnhNAgPlQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 00:33:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f3cbf90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 05:31:24 +0000 (UTC)
Date: Fri, 15 Dec 2023 06:33:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
Message-ID: <ZXvlExouF3a29wch@tanuki>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <xmqq8r5zrzg1.fsf@gitster.g>
 <ZXlbNlG28e1sAYPU@tanuki>
 <xmqqr0jqnnmn.fsf@gitster.g>
 <CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>
 <ZXq5GL723v4E3_IH@tanuki>
 <CAPig+cQ2-PB24n0xfcoSy_1UT-VbEZUXXJ9QbA8FBA8Vfyd6Ng@mail.gmail.com>
 <xmqqbkaspxn6.fsf@gitster.g>
 <CAPig+cQvcSeSKVE=0kDyNiSztNAgVwhfAzoL5K7uYHEKe=0f_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N94nVa3B//f9Fy0+"
Content-Disposition: inline
In-Reply-To: <CAPig+cQvcSeSKVE=0kDyNiSztNAgVwhfAzoL5K7uYHEKe=0f_A@mail.gmail.com>


--N94nVa3B//f9Fy0+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 01:10:48PM -0500, Eric Sunshine wrote:
> On Thu, Dec 14, 2023 at 11:16=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > I sent a reply[1] in the other thread explaining why I'm still leaning
> > > toward `sed` to smooth over these minor differences rather than
> > > churning the "expect" files, especially since the minor differences
> > > are not significant to what is actually being tested.
> >
> > If it is just one time bulk conversion under t/chainlint/ to match
> > what the chainlint.pl script produces, with the possibility of
> > similar bulk updates in the future when the script gets updated, I
> > tend to agree with Patrick that getting rid of the fuzzy comparison
> > will be the best way forward.
>=20
> Okay, that's fine. If we take this approach, though, then it would
> make sense to eliminate _all_ gratuitous postprocessing of the
> "expect" files[1] so that we really are comparing the direct output of
> chainlint.pl with the "expect" files, rather than merely munging the
> inline whitespace of the "expect" files slightly as Patrick's proposed
> patch does[2].
>=20
> (The only postprocessing of "expect" files which needs to stay is the
> bit which removes the "# LINT:" comments which litter the "expect"
> files explaining to human readers why the linter should insert a
> "???FOO???" annotation at that particular point.)

Okay. I'll send a v3 to also drop the other post-processing steps then.

Patrick

--N94nVa3B//f9Fy0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV75Q4ACgkQVbJhu7ck
PpSP/w/9FkexlFEZS3vtfsjZ8ivk97d5TIqxXFTl+PZaPZrQfNbVflQXzZULpywf
6sX/zehJn7pnujw35A5RbHbWmh6RS3rdYrBzZ/u8Q29ljDULZhiaP+pGoViTK2oW
EFx2VfDmIiNHSmAyKua8HUT1L6H4YApTjPY/dDSiiFmdyZ9/ISclABchD85K9F1O
iMYsRjYUwfgzSCsdODomfOTu9+SD+HXRdFHQW7aGWMyuhrG90uqnaxLrKYrhXoCj
ReycFSfQ8GYuKx/pJTmYAXIgho95qrmaqmZaAaWW5saiqQIRAKKqOy+wDhWFrH5L
LUmRDTQ390R7KReC4uHYsC/T9vzc6bb0UD99lDYeSPZAfo7lIEHoac1rO+EIvF+Y
/mqDjUVIGLCqpdK87VkOLRuOeT3+7ufANmxBragc7RfyHUb/GjadAkuAq9cu55Ir
5bClGS9Fg6ojP85GyhqnwVXGep+m38pUDugJuZGE9HwIBvo7fZs0cfa71/ZVOcl0
VgUA64BNRHabWvyGsKNbz/Fsy0gP3FIaRd8a4Dno9wMCxFrbj8IUguZcR/jnPMsC
PtecdkANkkFTRxkCCgsffQmA3YhuHhv4zJbYzTDUr5lI23/rmr9V8wqhNQHQyvQd
Q6CM8cPmAqEaTu1lpj6N4sQacSVRDHXZGWIXH+oKGLFADD8wI6k=
=QHZh
-----END PGP SIGNATURE-----

--N94nVa3B//f9Fy0+--
