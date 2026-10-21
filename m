Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602974;
	b=k9oB4Dd6fWD4ciHu3J4x5/SOPSho2z3Vx8MD2V8l2Jjw1ZsAhMHg+f4zAX0vzvkBhC1x
	 SUAyotvOxPz9DcrGAc7HWdh2jYStvGdYvfGmx+xvLZtUpoVljZAHbLy0QqrqmaHhTDrNw
	 SvulM9sui6uD8/iUc6fMnB3L6TCauUxVZXFVpDrw0wMpSnHpkmhsY2pf0xJiwXfBt2zQP
	 xPpTMt0KSIEhQC4AtaISzr1OoxCZ42mFW737WKB1ghD3ubMD5HYM202hhm8jRYLRwtz6Q
	 C8OGG7IwXKi5maf7VIhcLOvxi21Qf/S69V5jr4xXWVsme+xKsM6cN1tgBKyHhW7BOkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602974;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2ndAB8mFv2RRHKuCbokLrjORJQVvrjfRO5Tnor2sLhM=;
	b=DxTVoF5aIp90OGueztwSYFkn2BtgPHRWQxQeerAeYUCI0BcXO6z+r8MUAFVNoInzHzXj
	 ZRLxT48TA+BIgmSFZrIEv8Hsi94cm+usXtiZIcU9D1piGHZcsIzaw828jqgn3m9JoldM0
	 /YtKp9jRPZ7JcYLpzceldxp3l6+puciwUf1aaQJndA9sDm7yU6/9pqor+sa4jL4TnA/st
	 h/Y9ZschmQgChvG3glds7I+w8Y/jEPL8Dh6n7s1bbqqg+n8xX/vGR5d6ZlcKFKehyi/g4
	 L3GA2tprT7N8cNpDMwwKwYzle6btDLeWI3J6i/TYKBdJsu/kO7d64DtHQhv/DZU+B9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=c8GqNflp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vKNLvHoo;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC6606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2FC6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=c8GqNflp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vKNLvHoo
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A2491D00115
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:16:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 13:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792602972; x=1792689372; bh=2ndAB8mFv2
	RRHKuCbokLrjORJQVvrjfRO5Tnor2sLhM=; b=c8GqNflpsO/qSJf3vIWg3QXsyw
	OxE89jj+rMTjtXYgI8X1PeUY6D4KQE0injefSfrXRyyXp6VRZp0Qqv/vZPMB5DNS
	4b+TOK+r5A94WokjhEMISLE2TMBUYfCqBaqlfg81t0E/A38NfeORVk1z/gtzuenK
	5NP49l7MyqCZEevCJ1j2sSZSktFhC69odHrjIuTiJsZZpryeBiDvn45zp0u9Vc7w
	VCcjdWmg/A/Aei0Fx+e1Hq7Iw3Co7BHtVV72tFFEfRVjmsXTx4gD76qHW365AixE
	f73Pa8XonmKDpJb0+ch6MuCRGO3SWQJybe7TFR6jFolA7DYDGk8Wppm6NnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792602972; x=1792689372; bh=2ndAB8mFv2RRHKuCbokLrjORJQVvrjfRO5T
	nor2sLhM=; b=vKNLvHoo6BKqPSDiAR07LKyYQrbzHZF2I6W0sCvXaL7XfNbi1Zd
	W+tWolDzERmC6vls/K0FtoO0GCM/o0xpVaPrkWPheTNMx8YYVvJ9rTaOrfImRBy6
	KuFZPf1Pg4cEE0I1EY+U+q04xLjR2a/Hk6cg3wgNBT/jcsqZF3ylshCLj13OLfdz
	9ZhO2fU87KmWPjvgLEEq/5Qo7OpHAV4NTExOzCT+ZK6nWAIAkjFld5XP0GgdaqSt
	N0pVEDrvbzHnGylNeFr+iYsTW8vU+QTYQvkcxYXo9gcU6SEOTb7QVTmrzebAJ4n/
	G+NoD1AbotXjWq8HtmtZhSzmLuxge2EyYMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792602972; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:knE5I67ZuzR3BDjE1/ipYCygRU0eb3+IV8iTOZCU4lJJJs9
	KFeLIle//4eRN+uMkTba+N/i0HJqnZuTJ8eBxJ7UL6pJQv4kVUBv3HroHiupBP8O
	tj0VgWykdWpDdvYw97h8x1g6gYpsONR+5jseCkZbH2+Ubt+s3FLMyhUCW8cnUJNL
	AHiLXku3F8bSfSKHfgZ1OjtEXu7/HqL+sxSSZi6Z/KxiWAQYLAfe13LtNOZGYa0X
	v3r/Ud5vcYNb5WbfKPhU6y43CpZ06CdojvDdTpgXYJ8f1eZVdsT7LCEaqyhsvf84
	lyckEkp4i9lekAajFjLjok/6Wz9R/7ysUDg3Yjg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:t3Y2Php0k4swLDSKOZR0xspEoN7XR7bf5FBFPdIzvdU=:ihH2ETRMXRzghqkBm96E8lvX5gf4xhFdrSAVl1+Vrfw=;
X-ME-Sender: <xms:XPPYaneo1ag3nhqRP5LquYbbzXkbUHkJcYHUw6c0cfoHhZbA9rWFuA>
    <xme:XPPYakNlNrukdnyRa5Wd4lAYTJbwRZhwcMeyWysiq1I9onEAFLQK_Li_-Ii7h4IMv
    9haM_OCq2A4hlhoLGPfkGBX_dZ76ThB977mZuDCnHgYWuC4ZCNi15c>
X-ME-Received: <xmr:XPPYalhd0XbfdOibnK8-FVK-kgIldP3y7ppLJZpA4Pl29oed5ng4bZOVZt5dLUr3OHKws8RIRw1R4RvJXzDfRNtGukOQRFJ9Xgs_>
X-ME-Proxy-Cause: dmFkZTEFPrE6gYOLu9uGSeZ9IrqA/7ZdbRsZ8znAQwQIf2e1JCJl4kq0NfIEvnqEFa6onn
    Ni4KXzBT7ISyIVu91jdCcbfJAr1wkhu2bTIQIqD84KfW64kq9TPImJ7d4gzwY2fGF92rEi
    ThLsG8ZXkD1teDdIctjAtEKQKWXELfbgI0mGKybiEhr+sBMdWohU6fSXYSiL/N4V7M4dti
    aiwFFPPYMvNq6hT3Xuj4s87+c06TJ8IGeq3gt5y0bYB5JHf42vvJRVzU91rf7zfNiISnjV
    i7xG1HDUeCDdQbJSzgAcKyXK3FCRDe1rJ0eNGdu1uCzvSus/BxRGNGQ9EHe8KFeUcv9dbx
    D9OFShhBDPuwkwQ2OpqmfX7cUbaBspSlTrN7DeK1cDaD8UwHDaKPV5HsyrzJhaepAF+nve
    VK8Idja4prqvWmpV4QjEEw0B7jY9qwh4HsBryT7Ph+s8B3rdZ9zksIqS2F8iaBUQQlP9km
    oD02OJqUQ59Q4mNkgFlfbtCI+crCB7ORQnA2F1Y6Dszw9ahffCG4UutIqyvy4DA86AEeJ2
    uxzb8b5Sj9rQ30swp6Gn3n3/kcsHD2cfh3OJw5FDXli4UFP9mIWKWze1+rXaEHe3DP/vFU
    ByGpiFxXmFvJGl6gDmCVNGDkAhq5NRV+zEkiq5tpJROmdy/W6xXgXPHIBCSQ
X-ME-Proxy: <xmx:XPPYan3cQedUOzaF0IMV31evs7TMXKOIcL4b-xb3vlLj02xDB74mxA>
    <xmx:XPPYavhkoPk36E3GAyuMCy75hJJjLm5pHLTdk9Jk1fMlXVhJ1rK5BA>
    <xmx:XPPYancbONeNhOP-ZL4dECemNvKACOAyACeM2Ap2EvR223khTNcieg>
    <xmx:XPPYaimvLxeqYb6bIcm0XFSfxKSN1PUVSgU5J_QMz2UA6FI3YyJzYQ>
    <xmx:XPPYapChdZ1RGXkQB7ABMZdVWpKmgvypX541AAYOLDceALo-n9LXnaez>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 13:16:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <xmqqjyncuqwk.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	20 Oct 2026 12:13:15 -0700")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca>
	<xmqqh5igw7l2.fsf@gitster.g> <xmqq1p9kw6qu.fsf@gitster.g>
	<xmqqjyncuqwk.fsf@gitster.g>
Date: Wed, 21 Oct 2026 10:16:10 -0700
Message-ID: <xmqqwlrbotyd.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> ... indeed, that is how I caught a handful of mistakes over the
> course of this project that I suspect I otherwise wouldn't have
> found.  Once found, however, such a mistake is easier to
> correct.

Sorry, but re-reading my previous message, I realize my preference
was not very clear.  The last sentence there should have ended
with "easier to correct with the ATX-style prefix format."

I do not have a strong preference either way myself.  However, this
is practically a brand-new document.  If you think it would be
easier to adopt and stay consistent with the prefix format, I am
happy to go with that direction.

Thanks.
