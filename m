Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45BE10E7
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cfxAf6g/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vSSRG8EE"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A8DD
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 23:42:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A04F45C0268;
	Tue, 24 Oct 2023 02:42:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 02:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698129758; x=1698216158; bh=eL
	po96Id85n61nWwHM5aVX3KqMB/QXml4xxeSKHt/4A=; b=cfxAf6g/Uo0dqBiNG2
	iIcBdcw9PgI5MG1t4c9bjyJnEvmspAdrYtn0JrAmUqoPOHhOh4WPBjPVDudAINxm
	oAFUOG+ehYHjyapoZAlD7cRYAWDtx9f4iexamgT7wqw74uCe8EuWAfRefIvcd1HR
	jq7SwBXLPN6b6TXonCCE2Yc3Df9Gx1niIP/s2Sk8Hc8EPm23AuUbCGi2dpZHq1QY
	UszT8btg5oOKKpcRKstGMkqZ1m/Q93YlnZE3r/FLRcB55UWEYdnvKf+mRm3T4dhh
	LW2v9yt/feuhexkFdFsmRTF5cEXUB1qOPFPGtT0dQ0NEXhes+0LofeTSim1+cNMU
	OqZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698129758; x=1698216158; bh=eLpo96Id85n61
	nWwHM5aVX3KqMB/QXml4xxeSKHt/4A=; b=vSSRG8EELc6fVeyb2TWMJz6aKNzM0
	rzChJ4XoP3wnTMO3VVzrnDJzngRafBczpxmbwMgWoFdKQQIkHtKsxQZCgMrvdqWx
	CxJEc1o9Xh4bgrz3njcjCZgPrC9didTYQWQtHjN+tbrjahw3v1nfcTW9MEKZDgWQ
	yyxi6LJCAn94/AfyHAi/tCgz4RXUPMA7jKqA1DYHPM6HTbj8vmwOLnfdCdYsSt8X
	o84iFOL9+kgbDDcQCxgwZ9IDmWLT5Qzw6hDAsMoZVIa+b4juoapTl4elL89mEk93
	4ST5x6ctP3bPu+8E2Z+YNUYdkHPCqnG5tSJDq8md+E3Cg0OVPlcmfraPw==
X-ME-Sender: <xms:Xmc3ZcbOvNBqG1A7rdMdQv7r3PAcBihn9VI0b4CIa1zqC-DglT6Zpw>
    <xme:Xmc3ZXYKqBwmZR7DlDaLVpNJLTV_plQR0En5OARUDFNNnb671nNohn5XFcuS_qZeE
    47mBqDPcFhhJzLz4w>
X-ME-Received: <xmr:Xmc3ZW_QGh0b34Yr0DQoxhhgoAt-Wa5oWvb0IDS4sSfXUjQWsGO3uui1a9hsEy95NGczSjHE_nIosG1Bi0ZJaGlu4FalwTDtPH05zygiwvZafkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeejgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Xmc3ZWrl5SiPHNv4tYEcBkvTihFDSyO4HUrCa1Nt1MzmW2cjjw6Hmw>
    <xmx:Xmc3ZXqu-5vrSB-IAv-vNuvrhlV_shNX8v03ilBFnLbo7wr1EpQolw>
    <xmx:Xmc3ZUSCSa5438oOxtWqd7RbvO6yjE7oEqAY52ZcXT3YVh_aw-B2eQ>
    <xmx:Xmc3ZQB0yCgme3vMe4hpvQU_rTX-xXEii5b_5gV3DTE8ElFyKPRJ4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 02:42:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01c21433 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 06:42:31 +0000 (UTC)
Date: Tue, 24 Oct 2023 08:42:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 08/11] t4207: delete replace references via
 git-update-ref(1)
Message-ID: <ZTdnWoTaAMuVMc7v@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <c4d09e3e5dbd11221cc4d229b815434d441cdb4d.1697607222.git.ps@pks.im>
 <ZTaiYEyhKT/yZwHZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xn1CFjUXbCAoY3SX"
Content-Disposition: inline
In-Reply-To: <ZTaiYEyhKT/yZwHZ@nand.local>


--xn1CFjUXbCAoY3SX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:42:08PM -0400, Taylor Blau wrote:
> On Wed, Oct 18, 2023 at 07:35:37AM +0200, Patrick Steinhardt wrote:
> > In t4207 we set up a set of replace objects via git-replace(1). Because
> > these references should not be impacting subsequent tests we also set up
> > some cleanup logic that deletes the replacement references via a call to
> > `rm -rf`. This reaches into the internal implementation details of the
> > reference backend and will thus break when we grow an alternative refdb
> > implementation.
> >
> > Refactor the tests to delete the replacement refs via Git commands so
> > that we become independent of the actual refdb that's in use. As we
> > don't have a nice way to delete all replacements or all references in a
> > certain namespace, we opt for a combination of git-for-each-ref(1) and
> > git-update-ref(1)'s `--stdin` mode.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t4207-log-decoration-colors.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-=
colors.sh
> > index 21986a866df..d138e513a04 100755
> > --- a/t/t4207-log-decoration-colors.sh
> > +++ b/t/t4207-log-decoration-colors.sh
> > @@ -71,7 +71,7 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit}=
)${c_reset} A
> >  '
> >
> >  test_expect_success 'test coloring with replace-objects' '
> > -	test_when_finished rm -rf .git/refs/replace* &&
> > +	test_when_finished "git for-each-ref refs/replace*/** --format=3D${SQ=
}delete %(refname)${SQ} | git update-ref --stdin" &&
>=20
> Here and below, should we avoid the for-each-ref showing up on the
> left-hand side of the pipe? I'd think we want something closer to:
>=20
>     test_when_finished "git for-each-ref refs/replace*/** --format=3D${SQ=
}delete %(refname)${SQ} >in && git update-ref --stdin <in" &&
>=20
> But having to quote the --format argument with "${SQ}"s makes the whole
> thing a little awkward to read and parse.
>=20
> Do you think that something like the below would be a readability
> improvement?

Yes, this certainly looks like a good improvement to me, thanks!

Patrick

> diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-co=
lors.sh
> index d138e513a0..de8f6638cb 100755
> --- a/t/t4207-log-decoration-colors.sh
> +++ b/t/t4207-log-decoration-colors.sh
> @@ -70,8 +70,13 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})=
${c_reset} A
>  	cmp_filtered_decorations
>  '
>=20
> --- >8 ---
> +remove_replace_refs () {
> +	git for-each-ref 'refs/replace*/**' --format=3D'delete %(refname)' >in =
&&
> +	git update-ref --stdin <in
> +}
> +
>  test_expect_success 'test coloring with replace-objects' '
> -	test_when_finished "git for-each-ref refs/replace*/** --format=3D${SQ}d=
elete %(refname)${SQ} | git update-ref --stdin" &&
> +	test_when_finished remove_replace_refs &&
>  	test_commit C &&
>  	test_commit D &&
>=20
> @@ -99,7 +104,7 @@ EOF
>  '
>=20
>  test_expect_success 'test coloring with grafted commit' '
> -	test_when_finished "git for-each-ref refs/replace*/** --format=3D${SQ}d=
elete %(refname)${SQ} | git update-ref --stdin" &&
> +	test_when_finished remove_replace_refs &&
>=20
>  	git replace --graft HEAD HEAD~2 &&
> --- 8< ---
>=20
> Thanks,
> Taylor

--xn1CFjUXbCAoY3SX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3Z1kACgkQVbJhu7ck
PpRRqw//QtesJ+Nz4LsV353Wq8119V/fS4n4ZsM/rNz1LQCI1ic0+Uk4PHCYChqA
lQbsQwga2S53nJlZ8X+t7bAYg3MJaSIao61BtzLRgrPisrtohfrQ5l7n+4H5TLCd
7cTZEbQDIvcE/ReqTmcypJ/GjuXrdZY8l0DWJkfEsWCyNEKD1hBs7N2FeMwSo7Jj
MoLB4lpcxjlSZtyFr0Ofg0Tng/AlXw/ax2IfCzH4QC/RL7SUXqsILPDaAyDA6Bt3
I/bjVdtI3oliv1QG72clT94bwqB+ewDxdSIZ7MQTtLnTFA5L11yI47nI+Z0xk25l
6X+HR/cZaOkWfkkDguL3XvU5XhVHxwOVhAFy1SOZo/5etm4jz4DzkTNIEXLA7NFH
eG8YTxrK2AJ02dOilzcVrhgjC+jok2VNYUSneFQYss7VcQefj7tnSY03Y6iOJq4H
3KRriYN5Rg4DRzGCu32ZDC8OXvb6aBaNAN1I9Jdhd3AjQjZLivM5YzilN/9qLu7F
njKSClR0fL22/prReao+3P3QmD/uF/f+E1/P2do0NJBYUTHk2OX9bdFrhim+D5Bt
ch7ton7NSNW486CFNsx2SlQesmnWx+vx5zGntPmWrLCb699IKz9PHIenbLEnDClF
r4zNCOTvNlcrOPg+Ma8a8Bsne0cCzdJsRxTnXAhmBRK3/WtJrP0=
=ynEq
-----END PGP SIGNATURE-----

--xn1CFjUXbCAoY3SX--
