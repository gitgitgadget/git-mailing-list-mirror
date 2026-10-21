Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606485;
	b=usLRD7epo1TVc5mRNtrxQtG2a/ZRdrqHcOTkMfSvby2U9YK5P6IiPN+Eaunw+mjeDZQk
	 wdM8ufniV+12bURK/x1tXWax/WBf+lphBdNn+nu4w2hcXf1/aKH4BqWzaz7tWG4r8E5yG
	 qAt6bd62Rjc4v/cqRpgUuNjVDR1tLnLiGxp8lw8X8hG2qc67TBCbgnQ9uly4sk4JXs4xN
	 zUo5oOWhn7KEtqgYd6S0WTgektvy9vnDa4aq3l5U70XxpdK4VhWGgd0aXPHpWmCrfWcna
	 mQzVutnQFvVIWlWqCY+rfMSoCGGTIW14gqoCyxNeJHoWY8SHyeOesIntwO+FsnGBz4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606485;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b79Rd6q5hr882LpuVCLUHvnmZfaVg2LKH8Gc2C2syUY=;
	b=PSDk8zqvoZyVlbQHdSbm2vy0nX5XQT3aLEfMajttzcvTWZD+tshXcX1oycWw0uQewiAP
	 yTVA3QnfDlSTcawODcdWn0ZwxQV8yCb4mB1ucxnC0jtZ8L3SkzV8lm9juIkaW8fvMly+o
	 sJe6KtQKHBpHQEWwNSzOR2Rs1n34NcJqHfL1H2iZ+SRdDx48jGRaYUk9IF4J0MR2Q48Li
	 qV1GAEg6n3MptDzAMNl2AiIlC4ZoKhWo6s26tUZ8zD5/OZQ53tGA1mHk3nZTs+zGQJwCv
	 pEOZmJnMl4yYR/j4CLM2AGPnNN8v4Inqr+mUzFGA1jWwB64YbTbXaD/HE2n7FwLnFWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aQTgQlqw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nFIfQcmm;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86302606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86302606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aQTgQlqw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nFIfQcmm
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A9FF41D00089
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:14:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 14:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792606484;
	 x=1792692884; bh=b79Rd6q5hr882LpuVCLUHvnmZfaVg2LKH8Gc2C2syUY=; b=
	aQTgQlqwjwGRSTsaDC/mKJOJF3ybirWjfTcdUW/wGpgonw7zDE3SkPydL9KDGcry
	fb/lcoyzM8s+QjpIDRc4qNHo1iUkvtI0kAvZfIQlZHMUzCVQSIputKKFlBfgRN+C
	eS3SkTrjs+C/dFFugxMtGok4+m8bUzxP+wohvpMs9P8IXNYntEhKVy0WPrbSSHnO
	9Jvk2CYHjGiTHYvVjjJcYQFTs6OPqBkPyKILqGGWIUOK8sUZC7esHEb3towSInTP
	oAolFmEUGi1hkjUuJlmz+E7hjz1XP1ydz3Kev/DK0mDKBZ414przRa/wCT0PVv6U
	x/kkNmOR4R3dZwJpn42fYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792606484; x=
	1792692884; bh=b79Rd6q5hr882LpuVCLUHvnmZfaVg2LKH8Gc2C2syUY=; b=n
	FIfQcmmxC6B+H7OdZbkXFaSAjnO0VhfMSVU5p85fJq5y6Pl3JEOD3FXcJiHnuIra
	sT/KE5xRqzzNt/sVHzUXHBaR0LNLIhtJneaUGztunw5LhWb9jhRYzBhMJNHRj2qR
	GTtu7yZQmSRUmHv9bVuth5oOMaKYmBhhPgvUiaI5ug+igo5K5QG7jWAfJinAtSdV
	aFQFacYFSKyzBDoQTqQN+gqJRAh2uQp3L9XF5R9UhqlzF96csBOPd39SEhUAPTIA
	QhNm2I2lIs7Y6gvyFaUMIZASCy18gRkkkzK4pnJogMigw4tx3gcMBNSyDSHS+2/x
	xzVmZI9035DZ81k2Sm75Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792606484; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Wu7hiAaCM0reNuHiv5ChnrHvxhkL/GV3hk2Kyft9zyXX4eF
	EBHMPkGAiG9SHvote4dfyEJw4H2VaAGEmTGI1C7WA5xOwZ58cuOHkDzww3L5/hre
	G8favZSdxYLGcY4jPrQ5Xx2n/8WqmL2gacBl33JWpyv40IEoJbIWRSwIc6sn+vYF
	uPNfUZXinf8eB2H2OWLZREmeBldcXz0LzWcGoRf3XIb11i48pe03XzKsfzlFs4K+
	AV9mkoQrpX/EMB+cJnzXb6y3P8FR29rOYxRVP4eaV9fzpMPO7FbbmzT33QTZyziS
	idlpNkBpbpJmsA7xDwCo8OLmXa/uk9h10sL6yMQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:iGF/bvwyGT59+OiYwQRQEpCBGRWKcoF8VC7R7OVdpRQ=:mlG+fydQ4T5WJzvCAYag38JxFFRbvkS3n5cd9rJ0vek=;
X-ME-Sender: <xms:EwHZakiqZoSMdDWvXOaohZFbjz_EGhsMHNFeDvHVe-QuXwSDX_RM2g>
    <xme:EwHZauhatIzX05ed34Ko9vOIBnHNzhBnaim2buIsT32cOK6OYlTWfSJXZSle2vpkD
    4ENeAAH94O-4HPpGeTjCVjd7PGBkbspbkr1hFDjXpc7u7Ib6jpsIYI>
X-ME-Received: <xmr:EwHZasLhbCVo8fH-eDBk1FCzCK5cLl1n1emL2VfiE_LPwJnhPMYZaVtqN7VIFhe-Zw0zUAgJdkTkkghg_A07YloAAeOptlIJvJ2y>
X-ME-Proxy-Cause: dmFkZTGubv8b+mP79L7X66rHE5Uf6fPijuldIhS1imzD6UTminM37uY8Ru3mG0bmMToWj0
    LX3by4noEFTT/czOx2SxBchE2Kzf6sS4/vkYLPjEdO0dMbWBqKRRhRggZQFIFEnREQm/DZ
    erkXi8+6iXA0pLiGs8h/eOmiRMEi5lvvXwt3UA/ZXn3XLis9U2PzrjqQUhh/192rz12sRM
    ii8llSyLzagHOJQQHFno0VkVLW07emJNoD3EbJCbBmBXslLAqr0NQIh8OrC9L/FUcEEQqb
    +RGPXRbbzPcJJlOIyVomFlhKSjGuEnHFEU+EUgCjVsQv3tLK2KzEvWNQfGGVRaaGIyLMSo
    R/2oUU1wQUMY/guI9fKo8kq1x1EI9K1qaoaSZzqoC48FI4NU+5Ry9Jk4zJiSshJsXJxhbD
    A2IwUTP0llf3thAbuNpe/9evHWTZ6TMG87A1H3XE7ESQn+3XTerbrELTfitcMVMDCHDyg5
    5i3o7N5i6U0elcTglsmcWYVAFRmz1MbKliJqJGVFcqlhh2sg3YJR1wdeHXYNSkewAAxoWN
    4d04PRSTsMz2U6NF6HcQlc3OZhxtH+q3Bx5d/rYyx+ZE6DY+XUr8LG0+HCpAMHC9hWVV8P
    ODuiOFvW+l3yM706+IIV7ase7OeDVq5AKNaIUOFXMZribmXODr02smqPBkHw
X-ME-Proxy: <xmx:EwHZalHFBCFoqcq4UTkvVdjvy5z39LkAMNdebhze_OzpOeGsH0zjaA>
    <xmx:EwHZaoQRNNPSAOiI6Y3ZDaXWLKVREvrx89Pyb8xyoilvr5YY75XuVg>
    <xmx:EwHZapdOCUr5XnpCVKBTWeHWvzj2qR2_cDlO-7HaODCGr79NhLym_w>
    <xmx:EwHZavp6iZBIlxkPucGSq5bJQzMb2_svL0mmqoAe4nwEG8--YyXsSw>
    <xmx:FAHZan14Q7-fc8PhH0kVNFuDMbfghYcF0N64QxWD8glmDKJ1k45Kgyjz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 14:14:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian =?utf-8?Q?No=C3=A9?= Ramos =?utf-8?Q?L=C3=B3pez?=
 <chris@nortesoftware.dev>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] doc: gpg: say which date SSH key lifetimes are checked
 against
In-Reply-To: <20261021030347.565306-1-chris@nortesoftware.dev> ("Christian
 =?utf-8?Q?No=C3=A9?=
	Ramos =?utf-8?Q?L=C3=B3pez=22's?= message of "Tue, 20 Oct 2026 23:03:47
 -0400")
References: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
	<20261021030347.565306-1-chris@nortesoftware.dev>
Date: Wed, 21 Oct 2026 11:14:42 -0700
Message-ID: <xmqqqzhior8t.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Noé Ramos López <chris@nortesoftware.dev> writes:

> -Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
> -valid-before options. Git will mark signatures as valid if the signing key was
> -valid at the time of the signature's creation. This allows users to change a
> -signing key without invalidating all previously made signatures.
> +Since OpenSSH 8.8 this file allows specifying a key lifetime using valid-after &
> +valid-before options. When verifying a commit or a tag, Git checks that lifetime
> +against the committer or tagger date recorded in the commit or tag. This allows
> +users to change a signing key without invalidating all previously made
> +signatures. That date is chosen by whoever creates the commit or tag, so it is
> +not evidence of when the signature was made; the same is true of the creation
> +time in a GPG signature, which is set by the signer's clock. Relying on a key
> +lifetime is therefore only safe as long as the signing key has never leaked;
> +once it has, valid-after and valid-before guarantee nothing.

Saying what we compare against may be valuable, but everything else
sounds more like an empty fluff to me.  Isn't it self evident that
validity time range is a useless concept unless you cannot tell when
the signature was made?  In other words, instead of the long
discussion of how useless the validity checks are, something
succinct like

    Since OpensSSH 8.8 this file allows specifying a key lifetime using
    valid-after & valid-before options. Git validates the signature by
    checking the committer or tagger timestamp is within the validity
    time range.  This allows users to change a signing key without
    invalidating all previously made signatures.

should be sufficient, I would have to say.  Or am I missing
something?
