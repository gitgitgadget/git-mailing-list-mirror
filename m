Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118362;
	b=knEFlqfNpCrnD+I0yp3jlHJ51a5IQ84aoyPSVEovS4fvd34rcEUTxVYQzef8y2qMSDP6
	 VsTGsy4V4RjT1GKbj/potm1x87K9SjVGwuq4x0tTHbK1bjTFV1lnEJFtuTY9Tx+SRRzl2
	 GfTOIsSBVNTkNDKjVH2Xy1jq8SMR26WfFLcgq4rv23TNlaVDHSGXDKwMTC56TBb2K8cwn
	 fDNvFskR+Zs+1XlMqhIhdiUZJkIi8cO1Y6QcURxgiezGaFNdlCkm+kiedUlyGq6OyvOur
	 fvEfqc2NiVSWfXlU0BgLnx/bikg6Rgsaagh26H/3mZUarfLG1xqibxuS+SfA36Ec5aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118362;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:X-Gnus-Delayed:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=YbeJtJ6mAyK/gQzd5ioKvWueLq4BvaFzA+H59roT+0o=;
	b=GJxdUiUEFfhi14vhRVztbICkGPowfKWHzEnHizcy1Y6XhfatP8nK5T0ODrYnEStKJvW1
	 sd1sAsJdrgiG2rITz02Lz+YWR8QJts1LZbzPAdfcROCuC3X3hiR7tXVUuj/x8J85J+7dr
	 rKUAOBopBvyQCc5vVIUwPDnGs9uNPbWxRVgpuq8QBLuoTsX5DxINUx41WdxcRevB+nJDW
	 nYL0LiLSCV8PFkdoanr6zsVSlWKtEMKYqY8ErUe/pYa1+BFfP2HZVW4nO8skUpbgQ822n
	 9u/f58qai05Dh1dXpZ5D/kpzAC9pT15eWKZSxhV97rkhJtNL5Ej35zsOMo6Atr/ecqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Bc4e9lxP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vbm+7n3j;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59621606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59621606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Bc4e9lxP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Vbm+7n3j
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7B7B7A034A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 14:59:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 19 Nov 2026 14:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795118361; x=1795204761; bh=YbeJtJ6mAy
	K/gQzd5ioKvWueLq4BvaFzA+H59roT+0o=; b=Bc4e9lxPOJ1D365E8l1slFTJWd
	ypTCwb1Ow+JfvuKM7vKSNvBRG0Zbh9texTN5B0b9NiRZKAXYEnscHVu208mfQvHe
	sTbqQNA95bvVHmY7DVOFRNihvUyd2d2b99folnZ4IFmV+BpMGBpPShdA4wqXeCam
	++xEs5Jx/NNVdcSWl4u6ig0dsshVflDbmmM4LFukHWHy1OxPLybTNJxlK25/QGnA
	Vmy66Hvxr4+TvJuo/FlyVzthhm87FcSpBWIhXa3N3t8XcG6spGht24A5dAKMP0g3
	m5WRX865HkcTtnoj5B3mC6kIwyGM8DOSR5wA6C6qZHFW9nAfCAQAKPsoLAyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795118361; x=1795204761; bh=YbeJtJ6mAyK/gQzd5ioKvWueLq4BvaFzA+H
	59roT+0o=; b=Vbm+7n3jCmH4PYbpYo4CPKqRCqmCb94Z8smeMbjBZiq0q9SDuO0
	UoCSh/8khGGL8dsYrI8fqNM3UOnwaDMsFD37tlEpRPNFy2EFAmd5omM55+4RaEp/
	fPknV+MfqlrM2pVyHCyhXHdilDC78wRbp15RsqlS5Hd4phYNYDR1CcJWGDl3BAKz
	KYjGVxUNXKA37pu32uWmaWr51K598sdr7hU17m71UJ0Gb5mJ+9PBGfHL8qcN69eS
	duDqlNjg4yWLWWhf+nHsmr0PzjknlZknftxQYBK4nPdlrwuToxOPJ9W91KmMyAkc
	/oKlcfmUWDmjkAvWoFxAu6mJBWvmBXrc6Hg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795118361; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dTcVzcnyVd+lG7hPtC0/CB1LiKeqDob0wpiIwTlEVsAJOtc
	/pSyaiz8exZRzVmOWiqIj5MDZYwzMsRIxotLY9qlzEtLT24BcQOvrKZb3R3ZuXGh
	ucDZSo6WfYmvfYQXLHh9xk8zFQlt3DWE7riBKrtjir8jhj1SaOidgIDQe2bopZB5
	FItJs1MbpGQaWF/8xhdyRQ/6i7gDIU1r4PeEkx0DIcr1isfZm7ziIDbKEhe2t+Ld
	mNwfas540/EgrA0sraXO3nNQNScAKLscb356yM6tikv0Is2PXnBAleekHEJRWtkH
	y/37B6i41tiAJgIvRUCcyfO6tIjO/RejcBp6QHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:o11TJGunLf2r0uFZkmFO9m/GrTwL1YDMeXGMDb2QlBE=:0vqHhUNQE9cQYcoD00GmTmdNqXYcXDM4AEtYZ3f1mcM=;
X-ME-Sender: <xms:GFX_aqPOyaWpehHA_EU0yj1FIH86j4R81VARNvfPP9Vzz8L26ux0VA>
    <xme:GFX_agZlqXDzhgjp-sG7RR4Fx4eWqGBQTMybs3axUhxtysv0WESOwzEreFwRizEDL
    Lgc9NK33vdffDTNQ86UUJazJKA_bev10x2sjJw8CODh8kqbsDYEWyk>
X-ME-Received: <xmr:GFX_aupv6bIzFmm19V7On5qxPCJtwtS-2vcdBA7u38L1958B5je3Sip6MoCgVwhdixb-4quoZaNYlhPaSrU-Mdb8rS7x2eeRgo_8>
X-ME-Proxy-Cause: dmFkZTGgAA8AXuA1HwQ3Ezv2SKZi3Axcxat+B2hC3rOUDuj4HG1r5zCpXeOmVLgShLuei9
    x4IfTBCrmwhRjSJqFM2HSU1KiA5y8FFsinO0J6TRya8zAewsLH8syyf5I4PiJ3IAXcIIkW
    G0ESdErYB9pENgVZFuQtFg9sBUFqbOuYar/E4z+yNfRwC7cucF3x2yVGrqB9DdqsR4chZ1
    5PHlPAtZFZiHPZN22sgg3JBqa9rkgotgEI1vppzPHu4axdMcW74t1RbhQuErohfqMB4Vq5
    SfsdwLBzq6wpXdbr+S/Cx6F7Y3AcqkU6wDO2BwTBNVX41rGYwbbYJuGpyxdflX5SAxihft
    M43dUDo6OTFTVKO/77uS5YoZ2sthR9Fm73siroamePaoy7Wq4D89oB1hA3LjyYQDBBo0sl
    XgLxG1N5UJuLrH5Pp57iIujKdqOtnA0Y8m2C2IW7/vyxoDEcswgD9+PbyJe2VGfzQXKHRq
    2/P7M4vhkzW0gyHa6AMIEJZAJb+mBHosfYl+fNwi2eHfSzTikexcnxIPsxNiqtYkioMJHj
    fzc+xBCGlWYjpINVKLR3tLqOqJAUIuDxxltUy1IJ7yW43G3+mbH+s9EhTUuOZDYEJbq1Xh
    Xpj7wbMfF2jGEXEpCkHy2ZhN5FzbPa30WcXyXFPXWomHZNIrNbV3H8NpMnDw
X-ME-Proxy: <xmx:GFX_akZmc-hbWJpxlqwckms4DOFBr6ca-XtSDlbj4SLUYf1JlnuDHg>
    <xmx:GFX_amTr7g3iP8Q536OpqsTC3zXRC2IdlC2vQmO_Yl9qKZNq2gJAow>
    <xmx:GFX_ar6S91jwNHRET6hx_Msmb-OD9_gCFn6awC8QrT1nP6ANp7HLMQ>
    <xmx:GFX_arw4O8iM-v-2lxUz4-RoVacI54FiKAfg_7mvDjFeNE-V6ExmtQ>
    <xmx:GVX_agCn4tZvTNT7UiEKa5SQgZp4h-HIbwsKP8JappxGutaTsmiojPfW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 14:59:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <20261118-master-v2-1-3f2aaec15d31@gouders.net> (Dirk Gouders's
	message of "Wed, 18 Nov 2026 22:08:50 +0100")
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-1-3f2aaec15d31@gouders.net>
X-Gnus-Delayed: Thu, 19 Nov 2026 12:28:31 -0800
Date: Thu, 19 Nov 2026 11:59:19 -0800
Message-ID: <xmqqik1swq20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Dirk Gouders <dirk@gouders.net> writes:

> diff --git a/t/meson.build b/t/meson.build
> index 1cf1d95f70..e224df58c8 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -27,6 +27,7 @@ clar_test_suites = [
>    'unit-tests/u-trailer.c',
>    'unit-tests/u-urlmatch-normalization.c',
>    'unit-tests/u-utf8-width.c',
> +  'unit-tests/u-utf8-ansi.c',
>  ]

Should this list be reordered?  "make -C t check-meson" complains.

