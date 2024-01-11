Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AA15491
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PbmSYlM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDwDsqqA"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 8D6B13200A61;
	Thu, 11 Jan 2024 06:08:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 11 Jan 2024 06:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704971329; x=1705057729; bh=eSNiwf2N50
	JHaeis8omTUXYFjSx6desH0AApBbfPX4Q=; b=PbmSYlM6D54o2dNDwO+H/qK0bU
	Zvr2VWUeyhF6Un1Jk8nTkJvnxOUZPyvr+ABeJ8h5uTdDzUJm6GXnDGdIauDLUInd
	jeu+zs9Qd7umx/7DpoiatIejkwt//1tU1nBFqdMLey05c2v/utondk4/LtgsjHZg
	z1jOGKpi4aUtC3zeVLjwO8u+88JCuPRQsRd0aczGwq35+4ATc2ZvtB4i21UNIdhd
	yafi3FRf08sglhU3HvBZyvyO4c6Wj7giRycGxdSpIdNmVkYi6j3TG7YPYv9OQQ/q
	E3Yyea5Koe6fJfYZPih6y3SbvRmiimko7anvezVL7VnTbxfynQQM8QhsRRdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704971329; x=1705057729; bh=eSNiwf2N50JHaeis8omTUXYFjSx6
	desH0AApBbfPX4Q=; b=ZDwDsqqAu+YzmOLK1s9yBSHNbAVxXjSzBl9W7/+utAk1
	aRDaSjVI7NMqWDfPbmSioWV2hvASvDtYH1YULuW7vbVVyC2qGnKoIE8ZzeVrHRLY
	/8TJu/xLxs8XK6HWjLXAUCsG6JY0cVk/lelkGcCzQyAt14fc5GaIJkP7tEUESN1X
	/TiBY1ZNC5Y8e2xfJyPNCdCLdiOH3qLoiGBgJvQOgDzfBYwMzMVeawcGEowmDpRt
	USQSONE0FG0vghe69R6GmqnPlPW7PypGN/XhsGkkyvF/iyUNDlswdB0qUAv/lWHl
	o7rhkOCQ5Yw7YgGh59SiHXmPRskSqBnnpS9AjPwyRw==
X-ME-Sender: <xms:QMyfZS0HUu_Cpy2b3Bv34n-tRF5eNW0wJ0d_Tehy53BcNiHC7P6Sdg>
    <xme:QMyfZVGY0YMeGkwTyOPcnr_O1362ICwJ4InQCt2yw3QwYfjNtPIUiq4OkS7zxKm4R
    f7Mtb-EetGbrbT_sw>
X-ME-Received: <xmr:QMyfZa74Ig_Td22UZG6gGAp5dGSmcONSJierhekeqtI96SY5SVLLG5-BXyW8dOQeqHpXLs7Enj2glKlfVISLGDro1zs8LwsSfCNKCbQKdBUxLHL1Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QMyfZT2im0ayOqzRjZnBLy86iZwt30MjAiM8s5ERD3doK2AR95MfqA>
    <xmx:QMyfZVGmhpa6vbBYZVpNlsy_IIL5pOJo0uDVgJQk7bs7ujk2KQtq9g>
    <xmx:QMyfZc8yVCI3VyZHaNujb-mC5bmk2a-4aG7CxrYA_lcMb_lB_fp8Nw>
    <xmx:QcyfZaTMJx6yE72uV9sFPOV9OSMD9L3_Wx_fvDjcCL1N9wc4MGYzvg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 06:08:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67f039d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 11:06:04 +0000 (UTC)
Date: Thu, 11 Jan 2024 12:08:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 1/2] t1401: generalize reference locking
Message-ID: <ZZ_MPK2huH2j6CGd@tanuki>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>
 <20240111071329.GC48154@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtVld9bw5eCPQ0jG"
Content-Disposition: inline
In-Reply-To: <20240111071329.GC48154@coredump.intra.peff.net>


--gtVld9bw5eCPQ0jG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 02:13:29AM -0500, Jeff King wrote:
> On Wed, Jan 10, 2024 at 06:52:29PM +0000, Justin Tobler via GitGitGadget =
wrote:
>=20
> > From: Justin Tobler <jltobler@gmail.com>
> >=20
> > Some tests set up reference locks by directly creating the lockfile.
> > While this works for the files reference backend, reftable reference
> > locks operate differently and are incompatible with this approach.
> > Refactor the test to use git-update-ref(1) to lock refs instead so that
> > the test does not need to be aware of how the ref backend locks refs.
>=20
> It looks like you re-create this situation in a backend-agnostic way by
> having two simultaneous updates that conflict on the lock (but don't
> care how that lock is implemented).
>=20
> That works, but I think we could keep it simple. This test doesn't care
> about the exact error condition we create. The point was just to die in
> create_symref() and make sure the exit code was propagated. So something
> like this would work:
>=20
>   $ git symbolic-ref refs/heads refs/heads/foo
>   error: unable to write symref for refs/heads: Is a directory
>=20
> (note that you get a different error message if the refs are packed,
> since there we can notice the d/f conflict manually).

If all we care for is the exit code then this would work for the
reftable backend, too:

```
$ git init --ref-format=3Dreftable repo
Initialized empty Git repository in /tmp/repo/.git/
$ cd repo/
$ git commit --allow-empty --message message
[main (root-commit) c2512d3] x
$ git symbolic-ref refs/heads refs/heads/foo
$ echo $?
1
```

A bit unfortunate that there is no proper error message in that case,
but that is a different topic.

Patrick

> There may be other ways to stimulate a failure. I thought "symbolic-ref
> HEAD refs/heads/.invalid" might work, but sadly the refname format check
> happens earlier.
>=20
> I think it is worth avoiding the fifo magic if we can. It's complicated,
> and it means that not all platforms run the test.
>=20
> -Peff
>=20

--gtVld9bw5eCPQ0jG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfzDsACgkQVbJhu7ck
PpRVYQ//W0XZTT6+YBEqwxeQGCk0zRYVxL4CE8O9vRmYT3z2lx7xlAD+TcemVfk2
hP76lrYLx4NJgQaq8ew3Sc10pzMG7ayqvWyWynpVYDQIc1iQLz9PMEI1jJ7yvwt1
M9gxZj6M7yFXED+osC9ZLFGl1yoNuZm2HioIIXaHZPYDyeGPDCvTdez5g52lvLIZ
730/c/FNVa9KZ8NbqwZKSgBicqhV+9JrDioXFqezN8XXRCaSzG3umtSoRlq/6juu
PCP/uc7hDnL7CR7DRY79JbChl9AkNfnN2FnnZhsXN/k0RHZSdKOphCTFyV9DKudW
+PoJN+K0yZ5AFqOs3ZD9gI9LzlcqUj/qJZJ1G8lbCEcxSxQHKA21HkwlOloLNaMV
UpUcLAyBSie6593vsPnpeCAW5XyUqwnIeFuvgvzOlgnry4Fm688c54+DwjU104fy
/ABxmSkzsbIhpvWg6nEt32ksJR1HXcfIqVmnuYk9WeTABcuzLtXb5s9jJFzideRl
Rhx8NPD9qWUYwskqtL2LtEnrvprXAJspWRG+YjnuU5K+cTsWzqafVSKsMCNPe2qU
UN8zWTC64WNwwK/TX905/kf2YBaSFaRDAvzpy6JEJjxDZsQ3x6aXkV6+JdiYcJOo
7vbsUCfp5yicUbUdKbfQrmY/7WvybeIhfqazxUbbg+FN1sXUrl0=
=I1hd
-----END PGP SIGNATURE-----

--gtVld9bw5eCPQ0jG--
