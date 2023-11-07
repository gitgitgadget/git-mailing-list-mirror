Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19828FD
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xAoMtLgP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjZ658gX"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C1A3
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:49:43 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4C3D232009D1;
	Tue,  7 Nov 2023 05:49:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 07 Nov 2023 05:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699354179; x=1699440579; bh=Jy
	JfXtLnCCp0p5DB2ogSbJaYJmjiYXNLr+Hx1+e7sSk=; b=xAoMtLgPDRuCra9X4z
	NbWQLT/au0wPsHCcek36FQsS86HyU9ZWKoMigcsOBJ1k/Z7TEXvCoXNPUOaN6QvR
	yY/BMGtl3JVicND8fQk6dm372T3h9zkJmRdalk4Y7w+z2HLxK+EA3SjpPUxFos0l
	/nsvkSMtK/Dq+R08nQfKZsKzT7Wa6phAiirQn4Gg2fyKlDoHMDcnK+J1Ni7iXgpf
	xVe3KAJopZ/9X8fKRGQpnYCnrJLyhuKlI4pkhnNCFOYLucXBIllLrxiac4hCfHSI
	wDThD3lMMg9d49O3Mk3wJR0fDD/EuB5VgOV9f5Yt9iAJoOylxiAdT1efGF0hOF0m
	+i4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699354179; x=1699440579; bh=JyJfXtLnCCp0p
	5DB2ogSbJaYJmjiYXNLr+Hx1+e7sSk=; b=GjZ658gXYlkFvxVSrxnyzYbwdn/CN
	/Mx3uYSHN8bd5Rtj6b5fl1kry0nCXnBCF5zwqeptMCjw7zuoyrP9D+Ea+ZOTHZv6
	z2NluuOfa4NTrUkmyJ0ZGRU6cIGKfquZSvwhfwR1Blbq1x9pIWlkW0kP65+J/s0w
	puZI67QxrvsfmlJiHpdbo+3CDDwIWvE05Ky27Zb1qiH1WkVbarHYh0KUrQRKMWgf
	mH8yhJjE7+xS4y4BHgvIKpRQRKZSi5Rx6RK2VPivSnnjbn6MDtexO4YzRvkFNKlK
	r7eLlnUzcqwh/Oaw55wKmSHtEZA4nvIPXXC//EHkHvPnaM0pg0kHhsNnQ==
X-ME-Sender: <xms:QxZKZX4DPBtmOfWH6FtqP5ew8IfEXXZ3zQN0-xJABCFQyYkEc7QC9Q>
    <xme:QxZKZc7MzkdLW6PC8SEsfsmYVxjd6hG8rrUDmwLl0RmoNAFPqc1UAsKzXPoS5Oyn-
    4TuyrbzlWBhO8_wTg>
X-ME-Received: <xmr:QxZKZeefVsgbBWHewu4NnymfLXeaYo23mVwbCNkPlOGnX4p7krzz94WGVdtRltZ2v4y9kawaZfP_yqklnR1CRPGsyUq1tCSbnSPWD66yMsY82DADUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QxZKZYILYyDGDxV9ZORTHyf5uXPj_p-vFVrzzWqeHDqBpj7bGnASMQ>
    <xmx:QxZKZbJ2nloxTxIoYLvOsBQ7VLmDdsCgcwJcGKcYHTXMORvn8g_F0w>
    <xmx:QxZKZRwSGz29MLoRudGG6CAzc73AuMG_PPlNqdXHoXZIPqkEba8ZZQ>
    <xmx:QxZKZSXoqowKAd1E2OOl4qe5pYQ6NzWj8QMcZ-MhqOqS3jh_gnKjbQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 05:49:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01e73b1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Nov 2023 10:49:13 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:49:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye <vdye@github.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/9] for-each-ref optimizations & usability improvements
Message-ID: <ZUoWPpFHEi-PZjoD@tanuki>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <xmqqo7g69tmf.fsf@gitster.g>
 <dbcbcf0e-aeee-4bb9-9e39-e2e85194d083@github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R65H2tkznvsVCZEi"
Content-Disposition: inline
In-Reply-To: <dbcbcf0e-aeee-4bb9-9e39-e2e85194d083@github.com>


--R65H2tkznvsVCZEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 06:48:29PM -0800, Victoria Dye wrote:
> Junio C Hamano wrote:
> > "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
[snip]
> >>  * I'm not attached to '--full-deref' as a name - if someone has an id=
ea for
> >>    a more descriptive name, please suggest it!
> >=20
> > Another candidate verb may be "to peel", and I have no strong
> > opinion between it and "to dereference".  But I have a mild aversion
> > to an abbreviation that is not strongly established.
> >=20
>=20
> Makes sense. I got the "deref" abbreviation for 'update-ref --no-deref', =
but
> 'show-ref' has a "--dereference" option and protocol v2's "ls-refs" inclu=
des
> a "peel" arg. "Dereference" is the term already used in the 'for-each-ref'
> documentation, though, so if no one comes in with an especially strong
> opinion on this I'll change the option to '--full-dereference'. Thanks!

But doesn't dereferencing in the context of git-update-ref(1) refer to
something different? It's not about tags, but it is about symbolic
references and whether we want to update the symref or the pointee. But
true enough, in git-show-ref(1) "dereference" actually means that we
should peel the tag.

To me it feels like preexisting commands are confused already. In my
mind model:

    - "peel" means that an object gets resolved to one of its pointees.
      This also includes the case here, where a tag gets peeled to its
      pointee.

    - "dereference" means that a symbolic reference gets resolved to its
      pointee. This matches what we do in `git update-ref --no-deref`.

But after reading through the code I don't think we distinguish those
terms cleanly throughout our codebase. Still, "peeling" feels like a
better match in my opinion.

Patrick

--R65H2tkznvsVCZEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVKFj4ACgkQVbJhu7ck
PpRrABAArRXNkk4UfH9PlukJArcp9PNELRZ8raDow7tS+5SjXah1OMpM1ArIoWMw
qLvFiKex5EFG9Lx20s/97WqxnREpiGWree/PBCHon/XNtiTYFnT7ousebfIP6nqf
NnrCFN54di8Njv3LfydkWDDAIslDodCxadBW6v5hG1IR+LhbLWDWMz25k5SXdY7a
DE0S5KHlwULWMn6h6t6b9ijGi04hOigesHkLAfLdO6K0A0yoVHbgZZNTdsSRiVdz
5Ep1/UMmQHAiVNj+CO2sJiBWCDs/eOgOmdoCmMeovBWMh6Cvtupq5aQg9ZMkd/LC
wPVYvSSCdZP1RETH5dOTs2RVtVfbXuYsr+3auwK1aZ6cN6C4nSbbRMg5UEaCTvCg
hS/9E+AFaHP5PcYfT4VQK5CgdQiVVIIDAKB2JNwkj/c6iHuYmkszPxI/4tuUHPXd
vOZjYQHPbG3sEyRBtiUDhGCc+glcmT28uF7qcBAsdBZKTSSQp8AruLzSsF+w1GmU
oBZFSiYP6c/2qcDJVN5l1q0jNF82l5WURqk3mWXFDBPAv05aDbCEnyn21l0fzrIU
x+fuaAFf4cZmYIJqDISpms+3OCdB1Dkn4McoY4j47VLcvhOBldmxy9SME/HD9mrb
5NTzSTRDU6uGTI5BWHJ0vjTFG+XJjR4b2HiLZ/Nc9sAioIhRuwQ=
=k1hY
-----END PGP SIGNATURE-----

--R65H2tkznvsVCZEi--
