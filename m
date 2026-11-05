Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905648;
	b=X58frYDrtvmFaFtiQoBkKg1TNSuBwzW12zqdv2J1Ec09rw10cJOusJRmiCIryiVoqYN/
	 emr806jpqemDnM0FzHNplfv8sAbRMfBh88pMxP0fZ5tYdYza8LNVY9eIkQwx8xuOpBovt
	 H0ZBco/M07lQ+ouOVtvtQHAqG/nAWMJ8n1dtkcPEnnI8Uj8mhrefH/whfICPkFeg1uFoc
	 6CnX53ENMgyz/vX9E1qyfqTc/2st02PqCk+HOubDT1qxSPVewB9GMHbPERFFH5nNHsQA+
	 nXSN4ve+KvX1ywDyUwj++IkxdusvL29JTPjdhRmXlPq0OJmEucymN4AVjp8SjFl4Zmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905648;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=hXP0vHqtWlrArm4NY1cBS9g33Rnx2wfFGS5QGaCfxiI=;
	b=rwYbP2ZrloovS5Qoo2KUjPAhOlrVb0dyk9H4vetiAmkiCu/ROfzDLfG/qHQ8qgC9/02m
	 RKIlbZDWam7RiQDycWRBEqKy0dE7k/iTZVGYdq2uszmTN7Tcp2vbO4LmZbp5T/1d6GSMC
	 5wdUFOsVCTqhxPfBnLnEna6kouuoAWmMemWTRZ/LVbbnf2mXIZqISEZtCNB3YAPWqO2FC
	 p7v6z8eLr54ufw2Hi0525ElWH0Y2QGEceQ8wPTrXFd1Iw4lFrItWGf6xi9fDyR2tU700C
	 VfOqavkjKbmL8qVNtrUXXhBNkvzkIkpqWSnNVmsLVsbCdNCyCKoQROGMNRVG2F1EmCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VvyBHiN6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Nm3NCWja;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C8606A329
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A1C8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VvyBHiN6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Nm3NCWja
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5231AEC01A2
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:07:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 14:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793905647; x=1793992047; bh=hXP0vHqtWl
	rArm4NY1cBS9g33Rnx2wfFGS5QGaCfxiI=; b=VvyBHiN6bZNKtMGIueZxKcqws8
	dScM4ItLDlE7/G44ckUWJs3zJrDH9nDRf31EKvPMXVP/G8uaAL+TWQ8CdZIntoRB
	bFh+Hm9YQ6wbpO0aKVWBTD/a/73bgQG+hTeemCSCxJfPTEwS+U/11T9VWIxcLB6k
	pnwXtN4KadbtHJypEcXyPyY7xdLzPUYs6iNqyhLU4d31cQPK2RHT74j+5YIbfSjB
	aB1S42yFS1kQHFVF3oTrU7883UbQB8fSZps89N5Qou22fWQoTxSulSVd+IZfW/KS
	S/k7QREN4PY72dk3Dlvwc8hTI7o8cdox6X3XEfG2KGBfoEo+6XsvjsuKHvxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793905647; x=1793992047; bh=hXP0vHqtWlrArm4NY1cBS9g33Rnx2wfFGS5
	QGaCfxiI=; b=Nm3NCWjaNA9C2DIz5RG4ye8RSCqABTBM5Hs/O3czFBtMxb16K7c
	m/Sxox4sYoV/pk6/3SjeoLgQdXAe+XusWOn2uJLicCMNIY7gO81Q78IV6pDy13Ak
	L3Ma/0ni96OPWD9Df9uaDeP3AghlGziwIhLCLgf3HvBb0pn/xmwMkxBv06w7B5Hw
	qw/M4jQwUVgE312FxJEi4msLzdrExUyrT0p7koSgrtmyeETWRUdUyywqxOe0elzi
	0Xydy38+F5P+VoxexdiAaKwJiRaIGybhz0xX/cGVA5sMd0kGo95PYLyd+hgsREYJ
	83ifGYZaflcrdYTu9K2ZAQcMddZCTjsgEow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793905647; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DHZyHdtJWpEtVT3V/Lt313+ziYPbnC58fsrj6flddEkkduD
	FM2K+M5ZjgX1fbKz0EA4bhm0Pg7jXKeJW6bHyXTvjK4b/j5i+Ds3dFmtMEdNIYw9
	pt5PbOhThstBuPMRncyzPmvFBQ30hZqON89PW9LYPmwi7zhsinMipLuNef9BunyF
	Q90MVwv2oSZULCmHmGuQPRcLpqqGgK23pM+artZtWmziBDCvr08uu3zAf5W4hH9O
	QPM8qUQQIt1O3K9pJpiqy499v923oKXYJjanshuRmxNawZk9Thn5Y44CKXwsdwfO
	EUQcpbUP3pCv5KoUZQj9nORMhNAecgkbVM7lFbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hXhVh5Rkvohv2VzFyHEaqquEuUtgH9xS426Cb2a2gYA=:cANdjNOxqYgy6NhTXPIqvorsH4VYK1Asc/eJcB9uUl4=;
X-ME-Sender: <xms:79PsalAjlfw5HdSz6LkxldF9CeXTh4bzU4g0lVfTyY162ARoh7mFzw>
    <xme:79Psalztx3V1JVmxJcWF6ZwkPtfXGJHn5CvsG7dtl3EWryzB9tjUYzbZAf5LulwLu
    T22UhDfUgz5Aky3IVQcV4oiguEUei2TI3LZEt_1eDLyheiWJWFGyg>
X-ME-Received: <xmr:79Psai2UdEmLuUXttWSrAIMIjWV0SssX18qZmzB2XuMAZo_W3KuI3QbFwxMlQQCTV-gxgn3NheCSBAq2d1MKK8lTaj73OKX7Ti1C>
X-ME-Proxy-Cause: dmFkZTE537+nV66edM3xUykiZCF42r7b/sQiq2AZG64Q1N9cD5cbBEaPxLOoKCuvka40n/
    aLN2Gegm/CNORu6IhkO9L9pfTvoxO37hm98jGzdZU8XJ8/JTmgXZU9ARN6RTK18Efbe8Iy
    SHWwVwJOhBv+2dACsBKt1XRjcBAOsr6pzwLhHSZc3ZLdYgyauD6wmUG86N+f6P3TN+cRi2
    J4dBlgHV8elL8H4Lvu0mBAZz52Im14t+XYc297Zp8XHHEC8vWlEVL6XFgCuZ7Z8j1zaY4y
    mnnFkR1KQf6Q6PxzqU9cm9DBdVh+B+VqK682VUuIYc9SNVXghSoOS0u+NteoY2B6LA0Le6
    w0usJZiXRtJJ52iPI6tc+w27NlW7cOmtH/LsPE1i39ouMvmWkSvVr+ZCIMFezOLBgZi4kM
    zsi6DMRy6YvU8Sb55Q0dAnUAbzBIQSc7w6maRxn4FGomfKyTp/TTlsfFXX2Dfe60kNmIwQ
    FqlkWxwDrc/3oeXxcCoJOk0n6HayT9X/KNklC91lpOhOTn6VZNh/oZFq8IohR/Pur9PE8J
    LmCqnkwwmwFlkpwJKiBYW77RY6m235jp1/5rpOozQUHYiJf14/wTaQ/mXxHPSNpihLZC3Y
    1WxPQmoQYeB3Gukz7TlpEEEYdnKTDYJaxyes6wafoxKABqeHYWncKn3FdzYA
X-ME-Proxy: <xmx:79Psalzz7jGm_5yDhIezZnXM7Mdxx9mOKuZh_wzy5LW8M-R4MCcNTw>
    <xmx:79PsapEa51nvGWKTNyil8psQQyvH_i89H3XCTjn5uNZe1Uc6WIjMhA>
    <xmx:79Psaob1PXdD2ihUuX2HD0csWhCKbl0mh9mEIcvmh4Kh40XOplJGlA>
    <xmx:79PsarBJWm_25UteGjljji9Tv-_T1kzfRRLwD6X8zpNKD8jjr1draw>
    <xmx:79PsakzdFRfpLNOINUTeEjQBYY08k-mleYJ_sjxHG7YeN86J0xOWonqz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:07:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>,  Kristofer Karlsson
 <krka@spotify.com>
Subject: Re: [PATCH v3] odb: do not list our own refs as alternate refs
In-Reply-To: <pull.2285.v3.git.1793864602482.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Thu, 05 Nov 2026
	07:43:22 +0000")
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
	<pull.2285.v3.git.1793864602482.gitgitgadget@gmail.com>
Date: Thu, 05 Nov 2026 11:07:25 -0800
Message-ID: <xmqqy0b7t7v6.fsf@gitster.g>
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

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     Changes since v2:
>     
>      * Went back to the approach of v1, as Peff suggested: skip our own
>        repository in the alternate refs code itself, with no special
>        handling of the quarantine. The "borrowed" flag and the check for the
>        parent of GIT_QUARANTINE_PATH are gone.
>     
>      * The commit message now describes this as a tightening of what
>        --alternate-refs means, in line with how loading alternates already
>        ignores the object directory itself.
>     
>      * Kept the documentation note and the tests from v2, except the one for
>        a quarantine outside of the commondir.

Thanks.  Will replace.
