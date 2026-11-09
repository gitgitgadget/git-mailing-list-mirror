Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211056;
	b=L73RenKP2Zk+SvE0LrVxjIF9MOdV+S0yRqA7FoT7YlKpwI7mgQrPOwkRb60WVkpDFfGZ
	 VcCLwDoeJgROMnHYBSXRbisfTUmNKR27NCMtlXcBpcDoGUC3qZ8kXmvWoHiddBRItew58
	 4DAdqPU8sUQ0+uRem68vl+Hj4IF3+puwYYF99n8T/sM2RthspoOsj+GTfRmHpPVYFeB1e
	 IsyJFGnuK1J5Kipye4ib3S0NFMjSzvLkrjdkw3rTsPlbLLzNNUv4w423aI8txA/p4eSfm
	 jjGubF+aYDpDCll/ovFXyZojGnce8nTPIX8e5y+0dTtUAxB8AypV+ltdMeWGq8uYoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211056;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RIoGhtrNZbeL/MVeib6M3xQI0AOL8VtytKtuuDmkOjI=;
	b=qaL4Gx5q0ppTf9mnWtLP3Xg+z5jNxtB7pkXXBjvAt2UaSIzNjh3yLzO7SeQ3hVUUmm/p
	 +/0dfA+GeCGKKbx8H3al9w6obetcDp5dH6zGFogB5NrK+o987/x+38CdiVfvG988wEUdL
	 iz17FxnkiSVIFhF+7HngPXBTITDjtT4QQYjIJu5hi6KIAGCHYKaatY8va4Jj5CW5lETRE
	 EcxynVik+vmRkBibXFLvhz3MKFWSLZHJmyzl0kwzXD+wRSnldW9/3CD+6zFEyQUj9LzdL
	 19PGNe6oyc1V7OJHSV54+PVa5iIPs9SZwttywJBcn7a4cOb1SWEOgtzcpZ3+eZOcv+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=kLfTClHZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4gcEoSTv;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8E606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=kLfTClHZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4gcEoSTv
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3D2B7A0134
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 02:57:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 02:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794211055; x=1794297455; bh=RIoGhtrNZb
	eL/MVeib6M3xQI0AOL8VtytKtuuDmkOjI=; b=kLfTClHZpHb9lrZgg3cbS1Pe4m
	fDFw4bVYm8N4Iml1blz+NlOJzKYVgmY5slk/KqSu+l9hQ6TxyrooPC/o9jz1sdYy
	AdGA8puTZnOP80w4b45Jf6kzPuMgQhmQVCN3vTF7H7rYJ61Gs2weIMKqK/OPlBS4
	VKcGrKCeg5/V+BDhClvTtxJQZzu+V1qIH60Id9EuZqUCkIqmNFfCnXn/KvG0ePL5
	O7nR002EE30dsAeCQTlMke32hRApHLM986yKR2gQWQ3y2Ds5eYyXMZFswMw7eChD
	/0rGRCMDFBaCOY2AKeb7idRFSdRqjK3BxOlZKVizbhCiGx0dnKm7Jtq2clag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794211055; x=1794297455; bh=RIoGhtrNZbeL/MVeib6M3xQI0AOL8VtytKt
	uuDmkOjI=; b=4gcEoSTvDgqS5FQQJXFCrRBa3WqzsbcaLZjFfdPdheCCiwhdQ9I
	Kt4OC2vb6ccmazJXHaJkDm7emmkqqs0W/0TxLFGNzzh8dw1Tu8Vi/lmlWIMSoOeG
	d9QiTfBEt5r/X4ez7Te8AlfkENJnqpMMwjppbAInJQoMC2WVfQIgMvgEA0HlV4jL
	26jYPn6PaDEM7OucCoS6+XH8UB/8FVV+r/MbjutyQV33gbGLyXsQtR7BgHiDJ20p
	lHTBV8NkpGJ9jDPIyP1kxpGN3kVhKEfc4boS6b8pq7CbvoCdVCflJtvt8G6oKut7
	QMmVqt4KmJJDZTvzv7ks1/PAyFIJWjGDIwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794211055; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Qu/E7o+o59uC3FuFLDdluKMje3amVzrM/6Y1Md9Kk6A0aJd
	qKwyZvcd/QYY8ZqXvBRIkaGO/krZPf4FwaRzLuDZ03j8wwEmaYazQzO4Gn0eZo5h
	yBwE0GS8xazw0eRIA8i/kikmUOiFK+UcQBou8fmqqgGvfvdYc5vFvXiCZh1TD27b
	9uHhZLg/6/hBqTQVAGerIUG4CraVAcc3u6B9RZAQYqXLPepUSFSCMPga407Q0BNs
	6mAGSR4zYL1w/IwVgEB65S2SFlV2sh0EmxuV0ulJYUOewekr5fnMndPdAC0/Khby
	l2zpVdaXWvitJ6+vNY/Gd8oGnSGAY9HGLoQRr+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XoLP/HL6hXEzNMzB2RMFPaPPFI/oi+g9sc4f/tCLF18=:RIoGhtrNZbeL/MVeib6M3xQI0AOL8VtytKtuuDmkOjI=;
X-ME-Sender: <xms:73zxahCFl2pyHqteZ_K0wpUOCOkjVciCD7g227XC0R5aFhhO8K1L-A>
    <xme:73zxamjI_nFH0DULnZYk79pt2xRIqo7NKDcfvkLG07CCf0Wo9N_-_0pGnQLr3EPIP
    B0cEO9wLX2YVE6zSC9mkMsU3hrvVK52ZoqgVj84aTmFd6p3oC8YrQ>
X-ME-Received: <xmr:73zxahnSUs-4cMuWosOMyMJTFu2UKiV9FmIkmlArcWYq8DZU7beUuT1sJHFAv1KGy8nECkE>
X-ME-Proxy-Cause: dmFkZTEN6xpZgmw5Dg9elCTt/nFhlH8K6wzvfxKo0mu1nhN6XJh9wVU1+nkT4p/UlqcLKw
    mtD0aVpNIMtI1tJPLVJf3CBmZdocaPyUnZo4+9s6hqSPUAGr3D/UJZz1eBj/wt4INFNVqI
    3/JV5zvdY4GQoZDkTS+QblC1QHDXu2LQXM6Jq17nTZ9+Ji4I/1FEjGHg9iOl6x2D1wrFv9
    EG2RjjUTQuqsCvbnUkH748BdEmt0YoVFFhe+PouYpII8yAsGYxBpW/RJ2av+U1G+7pn+ta
    esiEbWFtsPJAzh50OIWiab3hU1vTqvQylStLkrgrGpq8h0tgtHfyQYQu+lk7WrUToMzbEU
    js+E/l/E3OVvGxtGo9Ls6gKtKrHUeRjownUk48u7BXaRJPDhsujTZjdc86UXzqKcQL1vuA
    v9l/GMs3FBgdX3x8zayHsm2oXn7lNmLKPKGg9J2oGTourYQg/Om+nT5uj3zogNL3BC4eVW
    7vXNGR2295EU18O2/5h4H1OFgRW/85rHcvF+E8RO2QO46c37wO25BQLgLQ4MfJF2azywMx
    VTHYr5SG6kiMpuCg3RHXi3iKoh1ixwrKS8JGLwxNHcixYKFBBcM7p4G5gkTLiGHB5xLQl3
    0iaSCTUfQ3si8fD633IYnsOoihe7zOnyW4tgu1Wpqeq5/V1sC+OyWgMj86FA
X-ME-Proxy: <xmx:73zxaqr4MeUhWCJns50wpsMfphykxUWy7nzry-BQcVTf0DDCTjsv2g>
    <xmx:73zxaiHSqNEet5rsnVu2zKE4WeBEZvA-PkCCjyjIuEgEPFnyY8BTew>
    <xmx:73zxauxrrZRqFK3HGhaaKGBq4QR7MaZI4DSCplZ3f1j-bmGnb_Ge1A>
    <xmx:73zxavoOSMphfXniZjUq5V9XYYG-58Hhi1TdQf-TW6O9HryDpWHdEg>
    <xmx:73zxapExL8uZgYXTaBD3aMbpTcz_2nFigHtt6U6rZCDWNwzAfJ-2OKCK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 02:57:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a68e8605 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 07:57:33 +0000 (UTC)
Date: Mon, 9 Nov 2026 08:57:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Hannes =?utf-8?B?QnJhbmRzdMOkdHRlci1Nw7xsbGVy?= <hannes.mueller@gmail.com>,
	git@vger.kernel.org
Subject: Re: [BUG] git apply: pure rename followed by edit fails with
 core.fileMode=false
Message-ID: <avF86vESF26lpNv2@pks.im>
References: <xmqqfqxd9pru.fsf@gitster.g>
 <20261107054701.298961-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107054701.298961-1-aniketgupta3001@gmail.com>

Hi Aniket,

On Sat, Nov 07, 2026 at 05:47:01AM +0000, Aniket Gupta wrote:
> Hey Junio. Yup. Two commits. Hannes feeds the whole format-patch output
> to a single git apply and separate invocations and git am work for him.
> Though applying several patches that touch the same path in one
> invocation is something git apply does on purpose. A pure rename
> followed by an edit worked that way before 0482c32c33 and still does
> with core.fileMode=true. It only breaks with =false.

one ask from my side for mailing list etiquette: could you please keep
the relevant parts of the mail that you're replying to? Otherwise it
becomes very hard to follow the discussion as one has no idea what parts
of the mail you reply to specifically.

Thanks!

Patrick
