Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673074;
	b=16QQg+N+u7KmvX8z53/sHhF499MWMXmnrlyNTWcl8woLaHf3fosojvvfJwJBe7y5Xg/c
	 n57X8EC+HnnFRqVsrN1Go7cLt27MppaoJ+bs0HNb00z/v/GU+zKZH9uFBUVbuigY3MtPm
	 LDVS8DHJMGrpXHlN2V9PDijeSyCunWRlSetNo0EarqwpZenCsl7teMMyKHuhOAQ3iITUn
	 5N4xBWOkt7tscBHSE/c9MDcYCHj9sPAOBMWgDHm21WKWnigxCwMKlqBdJdH+JMzG4DIWI
	 dzZ34mzeukgfqkDwHJfaakVtXAp8sm+Z8nSR4qwF1S5jJRU0s4Q2DAbbIcVmvCaSgyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673074;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lPWgxiHx6jkoQ8OqpchTkIGLPW9MVr9pKizd6LzzOl0=;
	b=I7DcC309PWiz6V0/Ihm20GuNKHzFZQw3l1IlWr798njV+oVIX0j3lmCDWPOiBKhBPFj7
	 FCscVb5lAJWdDCKyXeXNM9TO6O+axpVV29tucRGnkajBOUFn6KnC6WqsTgIoWjsKLfFm7
	 Uy3SavHnYVaki8TUG0/Bo/PC1607yKKiOP5S7Pvaup0nokNk52Smc/pS/fxPTSE66KF8H
	 VnhSR7OhDnzE6ScqE7mSmkit1jlIVUFkgcj1SuWbtQM1vM4PR3STgfnnUzyPotzfcVLTP
	 f5sesZGxaaYufM5eVfqY9jVc7cRg8nFsmBGODNKScD9YBdbWa7xGOWJavS04aBcbBVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="b0aaTe/T";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ST17mPZH;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED2606A330
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AED2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=b0aaTe/T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ST17mPZH
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 675B51400128
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 08:44:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Oct 2026 08:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792673073; x=1792759473; bh=lPWgxiHx6j
	koQ8OqpchTkIGLPW9MVr9pKizd6LzzOl0=; b=b0aaTe/TCyw0ZgHAfe1sTH1Gfd
	c8JNZu0ENMkbGBo3ZM5AvHJf+kKD+oNuHEjGPjXMQ2oB3XKzAneo+rJDMRoeCne2
	Gygi48kAEXqitwQ0pY0pgAMDKZY8pdpFk12JcZYzPNPsiNYDoNk+8ltQR2zTt2/F
	mg0mMo9VsZQonElTpt9bOR2+0dkoRhjXWf5T6UEXXnuVGKmV2VOKoqhXolsQE6IT
	DHyHob2ToEENoXh7muUxrB3GDV8bCvnoTeWltf+vIWpOB8WW77mGQzIlKtpQY53q
	gk9elbeX6FhJ/43L9Tu00dw+Z3XW8gCz5Eso4cv0c7ike9zj0qyz5eg6HN0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792673073; x=1792759473; bh=lPWgxiHx6jkoQ8OqpchTkIGLPW9MVr9pKiz
	d6LzzOl0=; b=ST17mPZHSUsF50cIbIG7/c81u3quHmCMSnUeMULoffX50qFKqM7
	GSPfOyR2sRSW/kfJgupWOdIadRSqidPBy9GDZI2YbRIegwFfr8phFo65rxv5pCzk
	0+SkGgJUHzDhhJLsRbM6++xhKzuXjk7ySLS+AnlHivUn6m3cBVdUexUc4ke1sydl
	ygCXWGMRCjDSW0g/xCaZH/AfpVTTknfuQJoCeUdNrYcerfmNHToYIj6f5ZFbty/k
	w/CNRAuQOnTMKeraZq3jvYofOpuqSWr16dFmf+uewyy4dRHXmTVBD2LUlypJgyZX
	HsgvJhAgaHrkT+fK4XTi1YhI8+36jpfLuJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792673073; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fZTuXLEdHcGgOLCeeZdh1ny/Mewf7FPXHftcaNN2Qpdo+c4
	10cJ0wNv/o+LuzevVb1+EACseDfrQ/SQ3gA9sl4t/J01OeIuuhj1Rk6pRyGr6m3Z
	ChARXqW1ie9Rr7eYn09uOkJBCgRVmgSuJQ51ToxpEjMVfTmMGqbvpMmkKMZETKSe
	PkyD1htGJuFSfn/MhpdrkRqE5dVFwXCp6lm9c1Jcd3psAH0m+c5IAqViD8LNPLNx
	sEdD1OtfI0+gzPNiE8Kw/SezjC8DOCEBppkRJ7FXrRjCmdFbbS3Hjt744eB1zXJl
	t+gDWeuPf5oa32cQId4nu1mhYMfwHxNwQrInqhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Mi9Q9KJQzvU5Im5PBnLy6ahR2CWtmDR0XrMdqF1tQaw=:4hN4mJnL/+pquqbY2HodG6hiMkBf77pM5CMFdqYARX8=;
X-ME-Sender: <xms:MQXaagjq0CM6S5FoIrA6odYkWVp4ysaTbfjbSSL04N78fymrbBqqCA>
    <xme:MQXaagfNaFM9shK2kJWbC0unyPumNinrv0_fU5FSSfzuNosJJVWAKe9WTGL90Z-41
    LFI_ux-dn6Tk7H7fkHrJFx0BoR92nMnC-Ucu342znNDldNY8HBAui0>
X-ME-Received: <xmr:MQXaaleexfQOe735tQp2bOZbH77fzSnp8yRs5BF7_fkghQt1ydplu_260aA4y9x2Q6UldQ>
X-ME-Proxy-Cause: dmFkZTFXWuPDR0wYwnVtbNvukBv7L02dp1eZ0ETYOmPShUWLIu5pWsphkIjsyGxW5haHlW
    MkjUjhxfUYgaLMbAuCkuHTKNigcAbHcAJG3t8bIBQn/dJnL3t8NjGAxJmelHrBFdb7aoq+
    fbcjfJ3zDFk45a6P1DBllnr7GYJwr9AriGh0R4ElNr2Ir8ipErkYl3PNmsbFawSVr6mAct
    XkfI9RiQSGZ4bWcE8ZmzCLEENXy++SEpJmrt+vuYivCWUcHuLeUYSK+S22cEmQGAd7mfJA
    Lo3469qts8xoGh16y2SIPHT0Znfo+InzHPwxsvwTwd523sH7UxRbIeVmKiCT+Icub6STro
    LXIS+xBkskYiT7Hl50dM4bGWOu70LcR3j2zeI8jhNyOyIyoq/bb19cXrM5tM9jkoqv7MV9
    3D/oTSP8RV3w65X6PqerFbPX5vgdsPWTlpJRcBgD9N4iZPPPUl5nakdUJoktY2eR1skFVS
    Z3UsinZQsr65R31EPxnLO3ydtviPsHlQ/JC1cJepd1Z481BDOIN6N2X2nS9IOpybEZfI2N
    CjgReqEERE7YTVnjbL5f1gh/lKKqUb9JIsLvdmtDrSDrf9ZOWFvsxN8o5VlELUzsSOOT83
    n3x0LpCCcU1UNATl5SeqTxaPLuXFp0XHomtGJgSH9eGUGb6QQOJQRyG3hE5A
X-ME-Proxy: <xmx:MQXaaq8YZReQVUrx51te2l650yQYAueNJVQsPRoehH7oOt9zsBewlQ>
    <xmx:MQXaahk47reK0ENjGtejMw5XVTX3XyEWd32I-ui7wtXBtSk72br7iQ>
    <xmx:MQXaas_Zccaw3geoqtK2058X1tesj8v36Pw17stI4wRDzK8tvIDypQ>
    <xmx:MQXaavnA0IJM1OjHC_H_AOQw8DuZ3HY4EiwZNvPmdgrM6DrDA3AAHQ>
    <xmx:MQXaagrgw0YDzwDc1zPxm9iLAwmRdHqvja6HmAN-yfjUCwEROjPqeudZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 08:44:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0e6eee6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 12:44:29 +0000 (UTC)
Date: Thu, 22 Oct 2026 14:44:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <atoFKhUaM3b38n-b@pks.im>
References: <20261021200341.378978-1-emilyshaffer@google.com>
 <3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com>
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
In-Reply-To: <3fe1dc57-5bb2-4e12-8876-a4969e5201cb@app.fastmail.com>

On Thu, Oct 22, 2026 at 09:29:26AM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 21, 2026, at 22:03, Emily Shaffer wrote:
[snip]
> > As we discussed in the Contributor Summit this past September[1], there's
> > interest in taking a formal community vote to decide whether and how to accept
> > AI contributions. The topic is of course a very contentious one, and I don't
> > think that we're going to come to general consensus the way we have on most
> > other concerns in the past.
> 
> The vote will pass. Those who work on Git at least once a month work for
> tech companies. Those tech companies are now AI companies. The votes
> will happen to drift towards agreement with their management.

That's not exactly what I observe myself -- I work for one of these
companies, but I still am highly sceptical of the technology, and I know
others are, as well.

But I agree with the sentiment. It's part of the reason why I strongly
feel like the vote needs to be secret, so that voters feel free to voice
their honest opinion even if it was different to their employer's
stance. I don't want anyone to fear any kind of retribution.

Patrick
