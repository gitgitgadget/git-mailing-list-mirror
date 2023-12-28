Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817B63AA
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G9hRoB7j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QEepdr6E"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 209DA5C010F;
	Thu, 28 Dec 2023 03:56:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 28 Dec 2023 03:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703753782; x=1703840182; bh=mx1HyRG7JT
	K+sGdUATCLPU92R8hoUieLII4W8gHjDiI=; b=G9hRoB7jSOQrB2iAS5lp/uBidQ
	mu2vyniECt1/YuN7otPbfQqNOVh/fzpudXhbTwNYYNSqI8FvNll+g/jj+DRU82jf
	1Fl3vViXx+KAPZsrcqDV1exYJxfSwDKI6y6sxQiaM5mQnPN6qMZPSIDbVyVmFPiL
	JTvNbFyaryC/NQ0h854UAa9761G6ZhPSs3HcfjdP43Uzhz6YdQx0Wt5tQDkQn4nK
	x/85U7M4G3188mZrrdijU1+X/XoMqF5zr9XNvw1K2pli/bvoryeKH3gy4j4XHATU
	qZwaYrO5I3Jwx2Ag5miYKcSql+/W/YZRxzN27Cdlfg3M9WqsaB03m5pXBO0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703753782; x=1703840182; bh=mx1HyRG7JTK+sGdUATCLPU92R8ho
	UieLII4W8gHjDiI=; b=QEepdr6EjB82SoMdrS+KZF+QfGHz6YZZjnzQ97Lzgc+d
	0nbndWQ1c3aLj4g5EjZtULdkO6nMub3F21UkF2HGw71wMulZcVolEAW7fnS+M2sZ
	0WLtdxx5z3AaUcr4xNWQM0w0BvRsSUKSlFQJRzlFn2Mjq35hBFZ4FGAurlxQgCTJ
	3zCT4hGHe5nt+bwu+1p/kgr3ey6iZv+5ojZgAv94yHV6KPSc41dcM5t7wpe0hgLN
	mbGdCSQmTT3IH6VZUaxFyHZ1tmu1OaaMHHnKJ7f2OaBYtJQxCHlQ72eesz49jD7/
	9fIgiGsafnu9Bhz87vW9KDrYd7kYZ1ujJmAI2JkKyA==
X-ME-Sender: <xms:NTiNZZtX-qQn94uOUXWQVMMKMBcUZXytBE0tpmO8IKhfa6xqQMt4Bg>
    <xme:NTiNZSerJp5Cl6-6FpkyWsFitGeLwlntc9vgqiqatonSCxB34eliHNokC9I1iKtdw
    bVsQcR8xIObRm4cgA>
X-ME-Received: <xmr:NTiNZcxBkKXUK-AdVGX4ZRYIrf_vOZLcX_icxHNuhJfJaFLY6OW_JJBwZc3R5c6kQFfo5iixldu45Cl_pSG6IkzuCfC4VkqV5CikCMYQV53Hmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NjiNZQO4fO65FIZbOS4RCc4C5kbTEASUgI23YYUuJySMr6H2elC3Tg>
    <xmx:NjiNZZ_PdBFSICepfLAnqO2Vq-dHHz6Z340AWBi9fEjPx4Xi7BkgCA>
    <xmx:NjiNZQXdvyoAmsMr1u9vyzrQXhhIoJ_cEBbTaq7S2oAUu-0ZU7wDsg>
    <xmx:NjiNZWFMP09FfXFGamx8soLG4__x4iUUGI2E-zXv1AwyiF-JP3QUWQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 03:56:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed496446 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 08:54:06 +0000 (UTC)
Date: Thu, 28 Dec 2023 09:56:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] setup: start tracking ref storage format when
Message-ID: <ZY04MuIQtuxNFwIw@tanuki>
References: <cover.1703067989.git.ps@pks.im>
 <6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
 <CAOLa=ZQLLqj=78dJN0y51EFf3_XsHnTBYNjkB0cAAGf3dXJ9KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/mQMlUgVL4OVDD3R"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQLLqj=78dJN0y51EFf3_XsHnTBYNjkB0cAAGf3dXJ9KA@mail.gmail.com>


--/mQMlUgVL4OVDD3R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 05:09:37AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs.c b/refs.c
> > index e87c85897d..d289a5e175 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2045,12 +2045,12 @@ static struct ref_store *ref_store_init(struct =
repository *repo,
> >  					const char *gitdir,
> >  					unsigned int flags)
> >  {
> > -	int format =3D REF_STORAGE_FORMAT_FILES;
> > -	const struct ref_storage_be *be =3D find_ref_storage_backend(format);
> > +	const struct ref_storage_be *be;
> >  	struct ref_store *refs;
> >
> > +	be =3D find_ref_storage_backend(repo->ref_storage_format);
> >  	if (!be)
> > -		BUG("reference backend %s is unknown", ref_storage_format_to_name(fo=
rmat));
> > +		BUG("reference backend is unknown");
> >
> >  	refs =3D be->init(repo, gitdir, flags);
> >  	return refs;
> > diff --git a/refs.h b/refs.h
> > index c6571bcf6c..944a67ac1b 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -11,6 +11,7 @@ struct string_list;
> >  struct string_list_item;
> >  struct worktree;
> >
> > +int default_ref_storage_format(void);
> >
>=20
> Is this used/defined somewhere?

No, it's a leftover from a previous iteration. Will drop.

Patrick

--/mQMlUgVL4OVDD3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNODEACgkQVbJhu7ck
PpSCvw//YOUJ6+L4upi8vN/eOBBxavy+FEs7opVG4g+ID6PFaJozKdsc/9Pqt+Iv
TF/vPDIbtb4HSM4V2S+xIx1te2P8AxeH8IspDmdEHFEIdoM718yCB45Fn0Mub244
pY/D/1WTqF/3OGFgIOJZeOTuGYSBXbwneylwI9jKbQgAH6xwExglCtKXtIy87bzP
jBP9OpSYysQTTQA873Z5fJXIv1XY2Oc8XU/CpCQuo8xZyCeY2EVG0wiVZR00ZB3s
c/p/YW1fpsB4mOfnLZXuxJzB02Gwi44mGmPB3ALlJhtRTsPhBzwpubyh25HQonXx
PZFCwZHOPEa8Zr7u+snFCo9e1hShHhyV9ZIVsKaHGMKoMiU5FAHYmq7As9pghzC5
j7eH/FIWhai4XpF1WgtnfXAQ8qDpivROaP9RxYs1SP4ZweCIEm3vTRBK7ykm+JxH
N1KuqMbOtd9gUP+8jKhcJMcVNqTuCYCNbqU/ucXixlZGFY+ZubJXYJqoSei2563Q
LZdn4elMYZ4q9kEpTk6V3NsiB6sBYdy+loinzLJrl+g0rUAAil/bP1VmfEi9gaUj
kZcLA6UxosYN3Yft0E4DfkPSuT0zpRN/pSi9T0eTbDcXksKxKbYszak0zASUMKu6
16z+MSNp83o6EL+OcXXo59WiDne/P88oH1ht0U7HDLmwoUlPpps=
=jroZ
-----END PGP SIGNATURE-----

--/mQMlUgVL4OVDD3R--
