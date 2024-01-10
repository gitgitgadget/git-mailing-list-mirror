Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3463B187
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O7HcMn4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RuWBZ5uI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9CC1B3200A89;
	Wed, 10 Jan 2024 04:01:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 10 Jan 2024 04:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704877300; x=1704963700; bh=erUUR4Zp+F
	gGiTo1q1gKymGoi0eG/1QpFY+F7wdTTHw=; b=O7HcMn4PQrTgAfpbn4QhDLvc5R
	Hbr5U2H8xuI5hova50BEni5vZ2Q1nwIVEM8SQIlQp1ckOjGhx/LswvxrqExYdpom
	LF/Y+MuUrKQ1gSP3/n2v/HZyiQ6tkEPS2Zx+v0cytPVpduE1U0MwcIL6UI1zE7yu
	YI84pUgoNdNuUPgqkqwOexwwHPyB/dnxwlO33QBz8MGelz7Qm6Fr3nDC4caAH3q6
	jMNrVtbOVox2AzHGgQOQWUjDzQj0fHklXWOZ9ckj6hUHzlvjcnWVwKalC3Pk6EGV
	9wdr5JRzZj+EhpiKcN9y8ORMYoBv+hfo3JmPwZUb5XsO1oaWp/hN6qAXPjUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704877300; x=1704963700; bh=erUUR4Zp+FgGiTo1q1gKymGoi0eG
	/1QpFY+F7wdTTHw=; b=RuWBZ5uIPxDIZ9hIISibmKZ7xVLF7i4XRgSymjqR2xIj
	hiLGUfXGg7hA8rW5ag7aLeoFrQRu9hY6MvJ3hbIwKwXbwmjUdXUvd4NXE7/TL6rV
	cbZ7v35375mMBqojos2SmHVQilNekmLGO1Vd8/+avST2M/zkLxMJMS4S6j8S64hW
	WugowRaZy7qJ2EcnG+5fGl9F4ZLzwgAUklh69pfWx3JzhFBUBgzsHJfpeEiJJZhz
	PWWl5TyUJk45htzR6mknAosdzTmyvJAEveWmzOUwsUDr4M52V6SLJzWY8vyIRLd5
	+iQpr5+yZvaROJMBMEQoahpw/qiWgU1WuA5tmnyjzA==
X-ME-Sender: <xms:81yeZTnU02grjxS3y1QSjVZW5vfzzGDwuZQRL96ekoYcfoWMY6AtjQ>
    <xme:81yeZW2uXk1IKbPrR5n0BDmVODMOBVib5tmSjiMnG69o1KAgnv6PizueRFvW3kKQ6
    c-AJeD5MSw4iuvQUA>
X-ME-Received: <xmr:81yeZZqK4ktrBiFNjyqSaRUafKVbvMTxkpsJgyEzV6wNH_k5fkRemjncP9ppnOOS2mosr3FX5Uq9jKq3BWEa6ypmuPe4B0M3tYyQDGPTsyhQ5mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:81yeZbnL1m7wROcoK7PI4pzsgfTyJWERltc8_MoeE8nX57VL5QXeMQ>
    <xmx:81yeZR24TKXJ7IuP_YGz4rsnVk59WummZpesYXsJKPPN82pLnOpdlw>
    <xmx:81yeZasOt7BuDvh8YfL4bD-QF2y5xVjud2kfOx8PdKtECw2YogCBew>
    <xmx:9FyeZS81TCa568F7s52mv9pPieyMm3QZDGGVjBkammRkij2rJgHwqA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 04:01:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b44c7369 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 08:58:56 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:01:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/6] t: mark "files"-backend specific tests
Message-ID: <cover.1704877233.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J+TigO0EYxxVJUoR"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--J+TigO0EYxxVJUoR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that addresses tests which
are specific to the "files" backend. Changes compared to v1:

  - I've rewritten the patch addressing t1300 to not mark tests as
    repository format specific anymoreg. Instead, we now create separate
    repos for relevant tests where we are more careful to not discard
    extensions.

  - I've made the casing of config options more consistent.

  - I've extended some commit messages to hopefully explain better why
    I'm doing things the way I do them and fixed some typos.

Thanks for your feedback!

Patrick

Patrick Steinhardt (6):
  t1300: make tests more robust with non-default ref backends
  t1301: mark test for `core.sharedRepository` as reffiles specific
  t1302: make tests more robust with new extensions
  t1419: mark test suite as files-backend specific
  t5526: break test submodule differently
  t: mark tests regarding git-pack-refs(1) to be backend specific

 t/t1300-config.sh             | 74 +++++++++++++++++++++++------------
 t/t1301-shared-repo.sh        |  2 +-
 t/t1302-repo-version.sh       | 19 +++++++--
 t/t1409-avoid-packing-refs.sh |  6 +++
 t/t1419-exclude-refs.sh       |  6 +++
 t/t3210-pack-refs.sh          |  6 +++
 t/t5526-fetch-submodules.sh   |  2 +-
 7 files changed, 83 insertions(+), 32 deletions(-)

Range-diff against v1:
1:  ec1b5bdd17 < -:  ---------- t1300: mark tests to require default repo f=
ormat
-:  ---------- > 1:  0552123fa3 t1300: make tests more robust with non-defa=
ult ref backends
2:  68e308c200 =3D 2:  384250fec2 t1301: mark test for `core.sharedReposito=
ry` as reffiles specific
3:  9af1e418d4 ! 3:  1284b70fab t1302: make tests more robust with new exte=
nsions
    @@ t/t1302-repo-version.sh: allow 1 noop-v1
     =20
      test_expect_success 'precious-objects allowed' '
     -	mkconfig 1 preciousObjects >.git/config &&
    -+	git config core.repositoryformatversion 1 &&
    ++	git config core.repositoryFormatVersion 1 &&
     +	git config extensions.preciousObjects 1 &&
      	check_allow
      '
4:  d7c6b8b2a7 ! 4:  c6062b612c t1419: mark test suite as files-backend spe=
cific
    @@ Commit message
         excluded pattern(s), 2023-07-10) we have implemented logic to hand=
le
         excluded refs more efficiently in the "packed" ref backend. This l=
ogic
         allows us to skip emitting refs completely which we know to not be=
 of
    -    any interest to the caller, which can avoid quite some allocaitons=
 and
    +    any interest to the caller, which can avoid quite some allocations=
 and
         object lookups.
    =20
         This was wired up via a new `exclude_patterns` parameter passed to=
 the
         backend's ref iterator. The backend only needs to handle them on a=
 best
         effort basis though, and in fact we only handle it for the "packed=
-refs"
    -    file, but not for loose references. Consequentially, all callers m=
ust
    -    still filter emitted refs with those exclude patterns.
    +    file, but not for loose references. Consequently, all callers must=
 still
    +    filter emitted refs with those exclude patterns.
    =20
         The result is that handling exclude patterns is completely optiona=
l in
         the ref backend, and any future backends may or may not implement =
it.
         Let's thus mark the test for t1419 to depend on the REFFILES prere=
q.
    =20
    +    An alternative would be to introduce a new prereq that tells us wh=
ether
    +    the backend under test supports exclude patterns or not. But this =
does
    +    feel a bit overblown:
    +
    +      - It would either map to the REFFILES prereq, in which case it f=
eels
    +        overengineered because the prereq is only ever relevant to t14=
19.
    +
    +      - Otherwise, it could auto-detect whether the backend supports e=
xclude
    +        patterns. But this could lead to silent failures in case the s=
upport
    +        for this feature breaks at any point in time.
    +
    +    It should thus be good enough to just use the REFFILES prereq for =
now.
    +    If future backends ever grow support for exclude patterns we can e=
asily
    +    add their respective prereq as another condition for this test sui=
te to
    +    execute.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## t/t1419-exclude-refs.sh ##
5:  51e494a50e ! 5:  ae08afc459 t5526: break test submodule differently
    @@ Commit message
         delete the `HEAD` reference will stop working.
    =20
         Adapt the code to instead delete the objects database. Going back =
with
    -    this new way to cuase breakage confirms that it triggers the infin=
ite
    +    this new way to cause breakage confirms that it triggers the infin=
ite
         recursion just the same, and there are no equivalent ongoing effor=
ts to
         replace the object database with an alternate backend.
    =20
6:  a9620f329d =3D 6:  df648be535 t: mark tests regarding git-pack-refs(1) =
to be backend specific
--=20
2.43.GIT


--J+TigO0EYxxVJUoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeXO4ACgkQVbJhu7ck
PpSu4BAAjtEImB9jAxzHKXIZOvuT2YYlgRFfsMndnecT/b1KSNwpApxrOS1VJg4J
cUYwlYZccKhQb076++sj6nhYL0O2yzRTa5ip+/wI2s5ViionB2owI4ouNK9zTOJ2
29D9854G0OJl5OE7kBcDNF8JN9pqZ+J/suhxpY5GDK6AtSZV8Eh0R6/4944m7IDt
VV7VQiMFLa5BwJGUS+AYPl2ffz+hp3clIcHmILaJtEZ1bY2aZXpFe5ja9+TE/3bU
WnRtriW55sqWwkf3HQklvrLSqC1v8QRMcqM6ZkkS9zHUUM96QG8k/1WpKcNiTn55
LBmOpcuVWc5Xi5Q32gOAA3sowGEZE6QOc9Dh5pHvg/EsMXGrCLNVZsL/sm/HBSyP
wlg1SHV03Q7QqW7HDvscGXC2N7H+4Lxe1JQdChrfAMKZ/flQ/TXQSA5Cie2YwjX7
dzq5+04YYCU8VnFxKTY3FJHS/QxDH6Ody38V4CXS2CCFq3i02IqxLSkA0G0nreSR
IsRBD91Lmoyaf+1RNp1HCOx3abnDEAcAlRJlpQxpYpbnmSCYNK1TC+Radmzwpx86
QXx4ZQHzrb1fJgirIB+rl04BV6AMoa9UVueHvFm24GmNurDvRVRj0USoiIHQsS2z
KSs5thusS9bt5l38PGpHN7E+KH/zYqlYAATaRE7UjzKeyONexxM=
=XbUq
-----END PGP SIGNATURE-----

--J+TigO0EYxxVJUoR--
