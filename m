Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35513ACF
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ap2NgqU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AY+MES6Y"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1373FA
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 01:17:36 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 6963D5C0105;
	Fri, 27 Oct 2023 04:17:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 27 Oct 2023 04:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698394656; x=1698481056; bh=Zu
	xoMtuYeAE1Vu4Ewk8E8mAZbT/M/h1BcD9Vxn3aljw=; b=Ap2NgqU6RN3sflUoTC
	/y1G/mxaieTzZADCxBUk0ClyO3pl3fddeo6/tgCmgfJNeqVDrDBCRkU2rAdATPLa
	3GgcMsmfPtTrUNDMsX5pg5kryANhVl1ndJ4xsa0GdoznyYjU3+CwbmYK4xHAAL8C
	SisORYztIwtfyBf3yEjOj/8VsZAUEuwkWBKsbBzMbgieAbqSy2gFfeRkBPmNBF7X
	q0e15aDXKjw5WIsNj5/rGBm1chIsAcQgASJfFzeaZl6CE1zmnaAqUUOKE6bAiX/Q
	PFSlBBFUjOgqiCLhEQaXixzSvOhkHyAsOX8QnjiU+1Ju7Lls4i+ciGLZlPLwj5OG
	BYDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698394656; x=1698481056; bh=ZuxoMtuYeAE1V
	u4Ewk8E8mAZbT/M/h1BcD9Vxn3aljw=; b=AY+MES6Y28VChrWjSV2dMKFPeyZa6
	7rGmC83vYgO8jr7O6G9LaU75MapxzdkOvmtgl6LXP0Qxa7SBq7xLQEwcIltxMo4y
	xJXBo9exXQal74jHM1yoswiFG4sT8GxyK1tW1/cSw/5CHlleYtO513yD/2LghTMl
	m2vRwCbOfhyYafuiCFauJxJlXww3Vc7tEAjKRtTXR4IcIIGbtvyoui5487f1ZFOp
	EfaKyO+qQKBkxa8zbTEIQbU18YKxoUsVEoRRG9EzJG67srWlfK8CYI3T+TseRsEu
	OMbgUyUq/RafYhijdY+VuWCb8NosgkS05ER8Sh3a4HrCkdAHwGSDvIXBA==
X-ME-Sender: <xms:IHI7ZZwVMI4ZqkBPwMcV6R1kAzLiY5ipZSnj7K6RT7DM_PyxfRFMSA>
    <xme:IHI7ZZR3qTlUSTYVXLPuycBKJZ8EJ3ni4vZgzuAkw6ILn7hLsjfawdlKIyfwPWhbq
    IbwQKJ-mqL9_x9awA>
X-ME-Received: <xmr:IHI7ZTU6Z1rlLnTK67K5CzYVdJ0xcd49qWZDxtzTBjiLJoussZaIhYMmYfQqNjWYRcCvoYvqDWa_0uueV82cHsGoSv1jTN_NBNx_Xcdcw5Bjsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:IHI7ZbjS_h_h78h-ZjpzPjl764yFnZZIqCChsf74EcB5omYXIUwOFA>
    <xmx:IHI7ZbDMtJ66SadfsxIZ94QDMivYI0aMEv6fGf05OWAJn59NJxNoFA>
    <xmx:IHI7ZULjB9asn5cGPVn2eg38ASanyNeBPWeVBRSCojOs9MmsDSoKEQ>
    <xmx:IHI7ZeqIa0H_zFi4k2Dx9hGOM7-5Y5j_4BVaz2smDpMA0jY_vgMQ0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 04:17:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f41c3c16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 08:17:25 +0000 (UTC)
Date: Fri, 27 Oct 2023 10:17:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Message-ID: <ZTtyHScKkMg4qnMH@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H8XEopxtE8PDkBib"
Content-Disposition: inline
In-Reply-To: <ZTosPCkpx/FMTDH5@ugly>


--H8XEopxtE8PDkBib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 11:07:08AM +0200, Oswald Buddenhagen wrote:
> On Thu, Oct 26, 2023 at 10:00:20AM +0200, Patrick Steinhardt wrote:
> > project has. More esoteric jobs like "linux-TEST-vars" that also sets a
> 								     ^ 								     -s
>=20
> > couple of environment variables do not exist in GitLab's custom CI
> > setup, and maintaining them to keep up with what Git does feels like
> > wasted time. The result is that we regularly send patch series upstream
> > that would otherwise fail to compile or pass tests in GitHub Workflows.
>       ^^^^^^^^^^^^^^^
>       that inverts the meaning
>=20
> > [...]
> > project to help us ensure to send better patch series upstream and thus
> 			   ^^
> 			   "we"
> > reduce overhead for the maintainer.
>=20
> > --- a/ci/install-docker-dependencies.sh
> > +++ b/ci/install-docker-dependencies.sh
> > @@ -16,9 +19,13 @@ linux32)
> > 	'
> > 	;;
> > linux-musl)
> > -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> > +	apk add --update git shadow sudo build-base curl-dev openssl-dev expa=
t-dev gettext \
> > 		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
> > 	;;
> > +linux-*)
> >=20
> you should probably choose a less generic name for the jobs, at least
> debian-*.

The names are all preexisting, so I cannot change them. And the CI infra
does indeed rely on the exact names to choose what to do.

> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 33005854520..102e9d04a1f 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -15,6 +15,42 @@ then
> > 		echo '::endgroup::' >&2
> > 	}
> >=20
> > +	group () {
> > [...]
> > +	}
> >=20
> this counter-intutive patch structure reveals that the function is
> duplicated between github and gitlab. you may want to factor it out and
> alias it. or change the structure entirely (circling back to patch 1/5).

I don't quite know what you mean by counter-intuitive patch structure.
But regarding the duplication for the `group ()` function I agree, it's
a bit unfortunate. My first version did de-duplicate it indeed, but it
resulted in some weirdness in the stubbed case.

I'll revisit this.

> > +	CI_BRANCH=3D"$CI_COMMIT_REF_NAME"
> > +	CI_COMMIT=3D"$CI_COMMIT_SHA"
> >=20
> assignments need no quoting to prevent word splitting.
> repeats below.
>=20
> > +	case "$CI_JOB_IMAGE" in
> >=20
> ... as does the selector in case statements.

True, but I'm simply matching the coding style in this script.

> > --- a/ci/print-test-failures.sh
> > +++ b/ci/print-test-failures.sh
> > @@ -51,6 +51,12 @@ do
> > 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
> > 			continue
> > 			;;
> > +		gitlab-ci)
> > +			mkdir -p failed-test-artifacts
> > +			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
> > +			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
> >=20
> you're just following the precedent, but imo it's more legible to quote t=
he
> entire string, not just the variable expansion. the code doesn't even agr=
ee
> with itself, as the line directly above apparently agrees with me.
>=20
> regards

Yeah, as you say, this is another case where I follow precedent. I
honestly don't quite care which way we go in this case.

Patrick

--H8XEopxtE8PDkBib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7chwACgkQVbJhu7ck
PpTLwhAAm/IJUoX7LeiupO+FpY6bdUkHx4BLnbkYoWwOshAsZXgD+Uuba/O/3Jvs
f5gRKwpa6r+AVvDbKrEwpavYwI5MalCmnTdsQNtji/o2y8tnP4056GxJ0fKeXOgf
8XWpbeToJEbNyuW9Q7Wk5GEMHbleXxsPTxMv5nLRNxgZ4sXBgAtr5m2DgZeaTBW9
4x7SxdHIK4K10hqTIkbWQCj5Ph6bUxoHeCX3OD8xulCQa/H5ceR9lwF9/GTpvW+9
MZaLnJFARmLlPr1SwAy4Wfz8bUzt+Tq3t4Oq+kwMKlMQRtPDRl0BIod9gror5+we
s4Blqrlq9xZoLNW6D9/Juq6p+7NeIMTpp/f7LgXwvAK91Jcdq2eA5tYd5+3qOgt8
tWBnmpOizqQ3nnYx+oA6DGwPa/ubI/YUkeuWkJMEATOYuIBN1ph7L7LD2SNnVgA/
rpHVjFdg+Z8SUa8GORpjz+55RvqRwDKMyGU/un9tt/oIlw9ttyprJmGRXNVmH9Od
w8cOfxHF/YTmz7yh7xFf37PVgggTxB9Ne2wbWYJHXM8eFZGQjbj5jh8wj3UH3vDm
0NaJjs+WS4ZeB6Xpv/88+OQGY+F9FPt7xG7A7FcWTRUas1v9XcByk4AoDMrzatEs
iniaTP9T0wwMd8IbpBqNLfQ6M2abimiKsgMO91nruPwKJjD4/i0=
=fdiQ
-----END PGP SIGNATURE-----

--H8XEopxtE8PDkBib--
