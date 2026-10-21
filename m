Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620763;
	b=xcDVTUkfmnhbIkRlUrgXHU4wyLDNOP7gNsHDZWdQG4785iybI/V4/+hlt6ukmHXDwjQJ
	 Ptld3fPxnoVRNbmk18u1ffTu4miN5Rq0FD00xslIMiARHX3k5kyBCWzd7M0y8US1vm4yQ
	 ZI3Wu5ymrCRW6eo96tBw/t5cfsXWqcwX0zRcz17ndCO0cnIwmpUweh+3Xcx+3sPK3vhcl
	 tLKB3251UIU406EzzB2CXSXkCV2AqC1zhZY/1CMLkMaorOiA1dVwa3bBOEpnuDnovR0yx
	 ZkcYx4u0DVNOKxguA4hF/gOGfJi5HpvzipjSLIwwfSwyfi2DfMtn73W6POR/hhT/OAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620763;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=TfS3oxzwx5IsDBe1LrYRS/k7Og3GFxmM6u4BAFYxT0Q=;
	b=I3ndKuiJiHhMjC4RV51uWx9swC++uCWbp4M6hg95Rt+IrX/u2qFeW7mIWbippvAw6f+e
	 6DwxJwYxhxTQQvm9WQdCZvWyE/D9O04mGQq6ZdjBoGqQ9RmS47ZPvEM9o9FO68ROecQxQ
	 8REyTX5IDVhtqNdmt8cxZ0YGTpOehLI0cCylywq7ujSIlUEo9+Y5l3qe1zrGzI7sxFiWe
	 wWpZmU0ngM9kM6cwFipE1YIACq4b20WLMZP1y+z5/NT/w0IUG/LkPqLhg+Mp8+1DUKkh8
	 l1cMrgKZsEXqfw0GDv0XsjuNrQ+BZn9CqSR/0bPnA0msur3pKCqZNiC5u5kCvVpsJDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XL6DINQz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SFKaXPMP;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81053606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81053606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XL6DINQz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SFKaXPMP
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFFFA7A0081
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:12:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 18:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792620761; x=1792707161; bh=TfS3oxzwx5
	IsDBe1LrYRS/k7Og3GFxmM6u4BAFYxT0Q=; b=XL6DINQz1rZYjiyplaanPh4Lre
	9RBX88M0cffk6p8nFNMfzHutSILdIaYBpAOnsv6cXt9O0aaG5sbMFwgW2sNBSuVg
	TqQXXaToSfep5C4JWPDkRhr1l7cZCXFm9ao4N/Snb45g5lQNZYOn2jTIRB+KAWds
	3jEFTgNJk8SnZbM7VfO/jb2J3ezaOEJI+4YYxTKAI3NU950E0lMTtcuIJBkaRWDf
	p4u3rxOqgkRnAAzD/Xu9McQXM8pAlhCb/KAJXAMXT1L3nnKkJkAcObR/UlsDECNB
	axWJge/PO7c+BzezeCHdt8tYKBo9+4TmHPfDa0VUUGSjVinIqgHEhj1najjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792620761; x=1792707161; bh=TfS3oxzwx5IsDBe1LrYRS/k7Og3GFxmM6u4
	BAFYxT0Q=; b=SFKaXPMP1aTC0+1xSWHGealZCc0u7pGYsiQYQ4qZAoE1f8Q6GkE
	dQDCKeYiIEgQKCiuWUCHc26h5lDH3sOEyWiEYtBpUU01qsg6SFUoQ5vmoCD1XFxf
	ml2n6aGRatr/wiJyPLxJi567vFZf05Fmm1WxLf/bZFA2yUwzK9UoVf9aamNEivHh
	MyrT1vQQuOpXk6BLBiKsb6nN7M5wgjymUbdO7SXW6mZCa6oJgdIBZNserH6JyfOX
	1fxYFf5Ds1N9i3FONtilJkPHCEMD3vWbEcQaBjTvhQizQ2xnPfANGjbKST2wqyeh
	zPz+Jp9DMU2xH3DIsq/Nm7HK+wTlZKIK0Bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792620761; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mNjdnpJvwHPxUgM1v20rnXsbNjqosrSb2vWPKZfjEeWClyE
	AEPZEeBt4CA3hhMeb+nvOIZD5mv2sFz4qlUhw7/gUMlsO8qoMPULHbaEtrv6+gKJ
	k9LOyjHlgL5bYJef0MWUN6AT9Zh5Ph8cdFqbMyXjeeHmbyVDPj0X8fL0iQFkNDCN
	tOKmtSEEBFsriLdPKBJyUKD1bebl43nz5ztIA5mAXaB3u5yLP+JBLU9jjtM0s7dW
	lQM5ODso9Mwa2N9nS8WMfjDDKupQaTTi5DdII7bAWyOW72nR7zuP9GFXzJ8EKeIJ
	P9P+L+Wwk61MdiUnkMsYwRlgEE6EfeCGGcnggmg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:N3OWlmaKVHeLN/aWCPaXPI0JOQmx2G1SLYfZIvj343A=:lmBjbJxzQadD7xOfO4yrXpYuVuSGVvZmipmPBuNv+tM=;
X-ME-Sender: <xms:2TjZapXImfV8BnViJtf9cvXRDTBuMY1iB42hp0RN-TIUjL70LYAAtQ>
    <xme:2TjZatSGfdOBDsgvh2KfkyW-mr21WskNHpRIGmC-rL31S_bgwfGdZ1hMO3DIWTAtC
    aMg3szLWEWekyko8GIA5e8PrD9Qu0phi_0A39vrlM7w8uJhrWjl0w>
X-ME-Received: <xmr:2TjZavM6yD92UZg4d_8BNvZBEZ48heY9JmMP9l7VlNYJvdB1rVBSAfbrI4Xp_zxPHmlA6uNePYopxKXoQhsFo6fC-Wg8BhJLN_2b>
X-ME-Proxy-Cause: dmFkZTFgRITw2eoUTgQdWn4LxUmKCwGbDtMAnfuCJz7FowV9CRciy01lVZy/Q62hrDsQ6b
    i50yaiXafYh6m3Aar3uzQ3pXaaHOxOKR3JDi8XdxEHPanRo1wGdAViUJSr4qEwfux9nxIN
    DVzoTOxbdGPJi3n2cRx7wK6yiOmZF/xIfvc7hOwbJ34wkHAndgqyYTjMH+RmoKJQ5UyDzU
    hjWRLhLKF+76C+K26QK9PThcNyr1YNGttB5BV3M55LtfAGt84Y9/vKkhg1qOinOyhwPBRQ
    3cVacDV39AVHg7moVsKDebyHOb7/SngaJaYXRIA7oR/sVGwTQJnuq/ysw5T46btZ3cwILE
    cSPvUgikcij1NzHfx0B69By6JYdT2l5wPiiL/6KNgr6QQjKJTK7Doa3TO7LudCPR6qteps
    Cem0Qu1PbJJva4zeoaa3s9IIDGf8K53KBv9lsXQYaxJaoCzwOKOSt9OsgkABVAkB9v8hP9
    UJCkOUzdtc3iD+sjMn1oz59/0FZnbqylsTx6kofGiTGE/TeLvL3HfIJeGoD3rARt5S/YFZ
    /YpQbJzjrpd16wlp1KSeHbZCqOLKNxNFWHmnUBf9at0lGNH+uN56oq29z9pMDeH6+RE/29
    705btHHp0QRdLbilPUBpDB3DjWdx7g4jqZuHSFgeVaNz50femDEjKZ5V67Yg
X-ME-Proxy: <xmx:2TjZajTbKAPXYATKMNg_MRyRH3hpwxSGk9S0pXxL8jL06A8HaG5Ifw>
    <xmx:2TjZaljcu58GKbsmvqBRzPu4mi7r3MN6wEcwIOu8BmcfUuKI9xCdbg>
    <xmx:2TjZak8ARMtDpgVn8NfHU9J_NXhCRdU7Y6RMaZGe-W_sYag4uG3gYQ>
    <xmx:2TjZakGSF33Cz9vU9EFi8vHZpUMv8bldwhum3Nb97McNk4aJXW-AAg>
    <xmx:2TjZan1LSbzUIZBqhxnfL7o7KiMFYDS07pZ3S3PrApPwdZqafzA7DKOU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 18:12:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Jasper Mayone <me@jaspermayone.com>,  git@vger.kernel.org,
  sunshine@sunshineco.com,  ben.knoble@gmail.com
Subject: Re: [RFC PATCH 0/1] worktree list: add --merged and --no-merged
In-Reply-To: <CAHwyqnXC6--wTx0Mkj9r-9oj4R6ndubjzcucym8y3Hs9CKYfVw@mail.gmail.com>
	(Harald Nordgren's message of "Wed, 21 Oct 2026 23:36:25 +0200")
References: <20261021173350.67854-1-me@jaspermayone.com>
	<CAHwyqnXC6--wTx0Mkj9r-9oj4R6ndubjzcucym8y3Hs9CKYfVw@mail.gmail.com>
Date: Wed, 21 Oct 2026 15:12:39 -0700
Message-ID: <xmqqbj8mln3c.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I wonder if we should relax (or allow relaxing) the requirements on
> worktree branches overall?
>
> I noticed that I can't check out a branch that is checked out in
> another worktree. Which seems a bit ridiculous because two regular
> repos of the same upstream would never enforce that.

Because your repository updating what commit your 'main' points at
would not affect my repository if they track the same upstream.

Worktrees are different.  If you allow your two worktrees to check
out the same 'main', and one of them makes a commit on top, you know
what happens, right?

> AI loves worktress, so I suspect we'll see more of these discussions
> in the future.

I think that was asked and answered already.  "worktree add -d" is
your friend.
