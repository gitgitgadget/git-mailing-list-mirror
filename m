Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817856;
	b=Kb1kGp5xEfMsUlzAdPkx1Ln/mo648o0H0PuFzoiem3DXMknprzlePHynlOe37CIwaJWD
	 hA1Zz2MnN3ELdL7CgHpW4EnvmncJsRVIVOe06ODarl9QGgHGmHR+fQkdIbA/zc6hzhEKw
	 WWEAzlEuqoFcZXOQ0NpVxYRD6Dm4O5w8mTexrdE+opZXAfPqm3cWjXdnw7ZRSX/TsSiHh
	 vrqvM/Zl1RoCpbyacjVbYxxpxsi4f0nqtJsIMVkNe2797dxFOGWAygjZCgxcgJ+SK0TIU
	 9HM4zukukaU4KV28pOV5fLOCMWEzbiJ6y574PKMiM5KoCav1FGavFggxIcNfSWAcgxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817856;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mII2Vx5jZJd4zMQg9NowlHsq+jmFReqtNq1VQWQqzb4=;
	b=kCKY10YT+QQnykRqlx0xJYxIGfPZLbieJbXFCY5ETWZ1D3x7jatUmUteL7H6gzX+ydpt
	 M/JMzpcx+TloTvnxWG4HZFCUJKfau3GUjntLhfKwFgG+wZqzf3p1odnnN9yCZXoo2eYSu
	 5f/jLkdgWiNY7nCngcjUE6G8Id0d3BWrryx26WnXRLmcoudjTVvtqK1XYmg2VE3WazHII
	 y8viW8clpvoLtHyJH6IizjDqqvWQJEbqH1ha3mgMr6NdyFibyXGAwlZFi6pVpiIx/P2bp
	 ahrApVG/yxmj5AM5Ih93cNEEDYHaMumU7MK1lQrTvYq9ylhInvHwFYim448XQHxNUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RMa9IBIX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yU+BVgEn;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3F606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RMa9IBIX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yU+BVgEn
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D09A0EC0CCD
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 17:17:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 27 Nov 2026 17:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795817854;
	 x=1795904254; bh=mII2Vx5jZJd4zMQg9NowlHsq+jmFReqtNq1VQWQqzb4=; b=
	RMa9IBIXUhRkcabcV4ZuiL9uyt3Jn4TSF7TGVFFAOwRUn/lJbPW1XShiUK8nBkz/
	iXOk5owbzKslTZuAa1rAZ0m+PIsxHENHVEGat8c7RI4DRmViK/Qj0bPJc4SpyFNA
	QaWOO8+x7W7WZbL2CECEdeeGlmXruFweTH5D8676BrdDN6sJgzpkAhz9OiLYZyeB
	bDNA/9hL5kecrmQ2RNKqMLfHE37DeZ4qkOtLES0yVsdrHU9kNlsaakwzJfjVuci0
	ShSef4jxqDtmuSDF7m9Zr/KiTpyBaQ2Uaef9Ec9s9WIfVD2eTP9X4fc02badLIXH
	wClkQy3+VeLYcdMdm5c06Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795817854; x=
	1795904254; bh=mII2Vx5jZJd4zMQg9NowlHsq+jmFReqtNq1VQWQqzb4=; b=y
	U+BVgEnwY5ycSiPFWV3/6Ros+v2ODr87wxS3EhwE/WmT3IQbgqSFGuqdtd7yqSay
	1iFBZCYtKWjr8jNusem1L8pk0f/0MumHOdjejTruFN2z6fvvDGHoCtHSTegaMFu/
	5gbhL1ZxO8TZDnUwyvwaYxWCl4Eku4h9+7+2wKa9FD7IM4NP2/Y13mrOB7ShZSfv
	4QKzGEBkQLksFRGI8yX+YiENNsK3NSHCMhkrej/eToF/H0S4TbI3zX8wXZT6s9rE
	Mlac76gkkos8liy6nXhfo4mQgf1ui0agq+J5h7joSkOBIWTuhY+C4qijzzMsmegC
	ih/8AwB8uFyA9Lfzc64Xw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795817854; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Io5teS1NcDA+5d9nKWQ/x9qnMSX1V6MUHDXmQsPBzogJ8yT
	2V+LcPcDQ9aBy7RpCtn/mkNdMgCDpWphLUzfHPufJSsEPqWoWVYTGz/WIvMbWkSa
	chVjIs+Xy7Nd99EmdsaB3ZXlWKygcQeHUd4mFLmntyJnV16utlX+4GO+r6zr/lSO
	ozAtbiAUiJQdmnIAEnP6smKWQM73L2/t7KDW0bOP53tpQBwoYxH739iU+OruDyuT
	wKmntf0S4Z9CNtrRcv737yNwbhkweLUh69itRV0XBvcTKsjFgN2NdNY9w25psDox
	KsV2Z2EuCGzswAbHef2to17H/bnjKiVe9d7vNZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:31Q7ZWhp89gH1+T0sC1wM0aC5zZ7Q2y9/Cy/FmdN3hc=:+ZgqhIPDGztvgs26zkzWWa75mRKoQ4ZrT0nCnqcboVI=;
X-ME-Sender: <xms:fgEKa6j9yhqNwYqAarHAMKkKHanFO17XtNW2VDN1yOq3G4qJuKS0Eg>
    <xme:fgEKax7XX2pB4DXTOnK7fhuTFiHkBbjcliBEB9fcJImiZnDPH_D6mGe9Jbm7HsnOE
    ONKip_iNYrEMNXimXl8jJuhlcxC5keUZ-2n3JdCwyJSBA7ZigRgew>
X-ME-Received: <xmr:fgEKa6YezlzcXVoKcMlnyRAcuc57ro0YnL5eyz40Kpvhc8a0YbUDU5CHLYVMS8h0eUGpiU93IaARWsVbOoB3Cfxzepi5JbrKNaMfr1A>
X-ME-Proxy-Cause: dmFkZTGkbWadq8GHW47Qv3JVTMxCZkjX867A7+5g2fEd+gqrx9Uq9IMiXCvjTuKbUiJ3Gy
    Kw6SUBaOjDDOEQ6sIhxIofGTrZZyaB4XeNA0IwG8PzImIU2IyrfMF3tvXgjI4IFl546LKI
    Hy7foMtJEUGeecO4wavnR8Yp4rgA1lP6J9r4jfKWMcKrVloIHNPBJTLK2mQ2zc/vs5qcx8
    t65aaZx0lk3sUFDrN5WOLXVwzJtq26CufV/hnJjXfC3eKhkaN8BSJ0+RHd+LnQhYEaWIS+
    HxyqmuVYPzms0l7FwWbxPZmox1LYbs9VrmckL7n1ZEuKqd+OBA2t1/E/XiL1aF51J8NdtA
    m5/8mu/dYwWFN+MdN5vUQODanTPBmVF/s+3Hgw27qPdJh1PoivDVimU3cPFWP+0uu7uBu6
    kNzL0VORSCkZ6tO3TRR8CDiSgNraHgETanouUDE1XoGSprg1axX9jaoHk7O0hqoD2Lnbnv
    8UG0KYZOiYcHbcGsEyFSoebL54LltE+UrDoF6laHHSLrKElC8igRaNFePhK/aMmMrIuW4t
    6nACWidkyaWEqwky1w8jWF7/xeCe21z4qP5WDb7CmTmDQH6TPVVO+8i2qb6t96KgR61iuS
    Nz81UnH6GJoYj1a56I7ysMUi/bShjR7tQ88KC2lfqiXLuQjXwUy3QY2irlSA
X-ME-Proxy: <xmx:fgEKa-5a9W3fbJWmSDShOavRsRzndZstxtlm_pUSrOqJqdKdOJUQRA>
    <xmx:fgEKa1BIp62Mbblof--M6x3Mb9906-bI8jyBX4zKIf_7bGcqM80-Kg>
    <xmx:fgEKa8cD7kghEyh-sILSiUJHv2q4Je_B0X4bcDvxEYCupPBkcszrhw>
    <xmx:fgEKa8KtaUiwaIeGA4PPAfe7QatKN-Q49Ebl96Hg0m-c6y95rI8a7A>
    <xmx:fgEKa6Jyi-OfIaXF8XfV0yZ_YXo3ZGb9L79y7tW4eCFFHXrjYkA2YFC1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 17:17:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Thomas Bachem" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Julia
 Evans" <julia@jvns.ca>
Subject: Re: [PATCH] doc: mention the tutorial in 'man git'
In-Reply-To: <0db2d28c-0f8e-46b9-9e2e-b1a08213d64b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 27 Nov 2026 22:42:11 +0100")
References: <pull.2334.git.1795636878793.gitgitgadget@gmail.com>
	<0db2d28c-0f8e-46b9-9e2e-b1a08213d64b@app.fastmail.com>
Date: Fri, 27 Nov 2026 14:17:33 -0800
Message-ID: <xmqqy0ad6hs2.fsf@gitster.g>
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

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Does this patch/commit “logically” belong to the commit that you mention
> here?
>
> In other words, was it a small oversight and that is the reason
> why it is coming now? I ask because I know that you have long-term goals
> and are working by building on previous series that you’ve sent here.

Very good point.  There are certain "sequencing" requirements for these
patches.  Even without talking about Julia's long term goals, forking a
topic to hold this patch as if it is independent from these two commits
mentioned can make things inconsistent.

Thanks for raising it.

