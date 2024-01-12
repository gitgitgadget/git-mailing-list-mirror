Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF95FEF1
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s9mq65rP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IxFyCw2/"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 506323200A12;
	Fri, 12 Jan 2024 05:50:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 12 Jan 2024 05:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705056623; x=1705143023; bh=urDlIITn/F
	DyKx2lADAap5bRJmOwPm+ndUmYtdnLts0=; b=s9mq65rPpGcFbcZCj1B3aGaYaB
	kg4vgbZYjm4Q5ZF17zUa4amX3AciqDZegR0tYLfo6v5TlpQ9IkrdP9ds3bOwf0OX
	RelNFMTYUcaTsu7s16tM29NDPpGhQ7URN6hfv9PIj3AmMyrbm6hNntkgl3f3XA9i
	nYDVDaTF3ip7YVMG+aeTZaeuu6za6pF0fslur47J1DFxFgYtz9cCkn/5s2r7yPkg
	vkSb514O35lgq6I8cDkPqtaAWiz71g7Pb4fVg22LXYVr+sF7iijsaL8ZgiY/ymtH
	fBUNJDxwftMkOWVXFkOxdbaax6LC8vDcETHJSn3Q+8mUfzTGjb01zqPv69eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705056623; x=1705143023; bh=urDlIITn/FDyKx2lADAap5bRJmOw
	Pm+ndUmYtdnLts0=; b=IxFyCw2/4ejSfAP605cJi6CY83/YG7taDRNqAqKVByPJ
	xl7xqB6hmvv3qZq3k4z3n6ctJTEWmP2R6AOxJJpyWCwON589wk8TaP0pHZdEyJVi
	xUPM32f18WxukoA1tGh6bTfLv688oyzKm3dlmpdQwPLUtH/pXvFsAjOo0Hg6/BSb
	AQU/gMf+OUq6nGY45VP5lgduxxt1CJN08kUeNUpUa9rQFVY+9vfq6AgSIS3CzzTy
	PlsbbWkJfi41ph95ijQf3tcf5d7SOK/lE7VZx0YgDB8ooEmgWoVaKsfrOTgUuHQk
	2xgsEydhFLwivwO+2Dfm4oKjmTV8Ms+t0++f+T48iQ==
X-ME-Sender: <xms:bxmhZV8n_jyB8rkp7NkhOa6PVB9FVO0E9kLxjzRDrYpfKLDSKsRcoA>
    <xme:bxmhZZs5IEUVU-UivFzyLBZ_HQ1UlHkuIUK-nON5K4jYD2a-sUwdxmm1YD2nmUuco
    NCzRz0bfa0kSOtnOw>
X-ME-Received: <xmr:bxmhZTAhvt4veUPt2dz2dhTvbIoux9nJovlAlcXbTPidmK2E8DKgQ8NH96I_RoLzC35dxrlm-bQhKKkcS4GWd7_s_33Ej7cc3sk72j6MxT2_VzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bxmhZZet6CUQD4_Y5PaVXsVCjv1X45oGOBEoQJ8K4nXby7ILh3N7yA>
    <xmx:bxmhZaNXf2UQATVjxYjHCMewPuvxpolw-kVvSrHAAa_ZbcMDH_4pBQ>
    <xmx:bxmhZbleH0WCLYAQbQbaRnbnxlmK8oEPxs1WBtWKHl1cfONSYYIyLA>
    <xmx:bxmhZc00-WGTdyUaB2cTUHZJisbX5pP8qH5A0LYvBK0q1jiHFek5xA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 05:50:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29d37608 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jan 2024 10:47:36 +0000 (UTC)
Date: Fri, 12 Jan 2024 11:50:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 1/2] t9902: verify that completion does not print anything
Message-ID: <ZaEZar9OTVgfkD9r@framework>
References: <cover.1704969119.git.ps@pks.im>
 <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
 <d978494d-6c48-5923-4745-c42a39e1187a@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1lV0xHEmDRiJQcOz"
Content-Disposition: inline
In-Reply-To: <d978494d-6c48-5923-4745-c42a39e1187a@gmx.de>


--1lV0xHEmDRiJQcOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 11:08:21AM +0100, Johannes Schindelin wrote:
> Hi Patrick,
>=20
> On Thu, 11 Jan 2024, Patrick Steinhardt wrote:
>=20
> > The Bash completion script must not print anything to either stdout or
> > stderr. Instead, it is only expected to populate certain variables.
> > Tighten our `test_completion ()` test helper to verify this requirement.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t9902-completion.sh | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index aa9a614de3..78cb93bea7 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -87,9 +87,11 @@ test_completion ()
> >  	else
> >  		sed -e 's/Z$//' |sort >expected
> >  	fi &&
> > -	run_completion "$1" &&
> > +	run_completion "$1" >"$TRASH_DIRECTORY"/output 2>&1 &&
> >  	sort out >out_sorted &&
> > -	test_cmp expected out_sorted
> > +	test_cmp expected out_sorted &&
> > +	test_must_be_empty "$TRASH_DIRECTORY"/output &&
>=20
> It seems that this fails CI on macOS, most likely because we're running
> with `set -x` and that output somehow ends up in `output`, see e.g. here:
> https://github.com/git/git/actions/runs/7496790359/job/20409405194#step:4=
:1880
>=20
>   [...]
>   ++ test_completion 'git switch '
>   ++ test 1 -gt 1
>   ++ sed -e 's/Z$//'
>   ++ sort
>   ++ run_completion 'git switch '
>   ++ sort out
>   ++ test_cmp expected out_sorted
>   ++ test 2 -ne 2
>   ++ eval 'diff -u' '"$@"'
>   +++ diff -u expected out_sorted
>   ++ test_must_be_empty '/Users/runner/work/git/git/t/trash directory.t99=
02-completion/output'
>   ++ test 1 -ne 1
>   ++ test_path_is_file '/Users/runner/work/git/git/t/trash directory.t990=
2-completion/output'
>   ++ test 1 -ne 1
>   ++ test -f '/Users/runner/work/git/git/t/trash directory.t9902-completi=
on/output'
>   ++ test -s '/Users/runner/work/git/git/t/trash directory.t9902-completi=
on/output'
>   ++ echo ''\''/Users/runner/work/git/git/t/trash directory.t9902-complet=
ion/output'\'' is not empty, it contains:'
>   '/Users/runner/work/git/git/t/trash directory.t9902-completion/output' =
is not empty, it contains:
>   ++ cat '/Users/runner/work/git/git/t/trash directory.t9902-completion/o=
utput'
>   ++ local -a COMPREPLY _words
>   ++ local _cword
>   [...]
>=20
> Maybe this is running in Dash and therefore `BASH_XTRACEFD=3D4` in
> `test-lib.sh` has not the intended effect?

Meh, thanks for the heads up. Another test gap in GitLab CI which I'm
going to address soon via a new macOS job.

In any case, Dash indeed does not honor the above envvar. I also could
not find any alternate solutions to redirect the tracing output. So for
all I can see there are a few ways to handle this:

  - `set -x` and then restore the previous value after having called
    `run_completion`.

  - Filter the output so that any line starting with "${PS4}" gets
    removed.=20

  - Don't test for this bug.

Not sure which way to go, but the first alternative feels a bit more
sensible to me. It does remove the ability to see what's going on in the
completion script though in case one wants to debug it.

I'll reroll this patch series early next week.

Patrick

--1lV0xHEmDRiJQcOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWhGWUACgkQVbJhu7ck
PpQRrhAAhxxF8kukTeC1+f7527TyeQdB9eCOERPFtlUXbdeTQeamO2UNdIm0EEx+
LRgP2ynZmUaKL04wKSEeqNNkF2TajC8+FSwqits3eqImLSrxF7kkroD/6OqPmPFj
gfLqvSgnW1cLT5goBm/dB+h1GeaC6WCjx1PcxV8aqVWA4fjZaLJbaHepKVvav745
Z31U6YBuz4tPuTwsMy4IFT/v8bh1pIzmsmWVA26VM1+hGhtw0oPUxOZv1jUJPGOX
je/LLptKz3IVFbCUtuLTyNSz3FkMtLaqN2CQCdqFC/P5kmnx7Zu9o7K6wsDmXEAv
4mbtkSm/wigcaXDpuWJ7qDV+9ph3qb3awDnWkVKcw/zr70aSXVPQiJUW2Q+xPECV
h61VihN6tHUNDZhdoPajoghDV4TTPUUkMp4dcQauYHvixsdPbn7EXGOYm02DTcdl
Pp0jBBg3NxBt8O7rsYc4HsAUggNKEh+RhNhnwos3CnOwSoEdfKHfb5k33mjTmfLa
lvirs/Bd94Df59dRf795wNYdwv5JplK2o4pacbzu/C/Yb2YoBYFSSU/Im6Dx1bpn
JRO7bKxsacbyffVAComUM+jfjNCdeA0tKSfNk/zW7r1cCGYJp0uZsYavCT5QSbZs
d67Ci2jG/AUhxDjuzruSHJtAG2LXhYL4LZycPMgG3QCsKSXtKto=
=FrJ+
-----END PGP SIGNATURE-----

--1lV0xHEmDRiJQcOz--
