Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261380;
	b=lqqOLr9r+oGG+jzfhiPx/OOLT9jxPJsr54KysV2Rq0QRDbe+Do6LzgU+WEwWs7lv7imc
	 xT6ieKkWpKsgfXRt9ZeF28Zv1XbT/d6r9Yjx6HVN36oTdkhSpBBG2BReMZOV/VWXDVE+C
	 nPxY0c/YxW2NFwCp3pGmMeaKpVpIJiPNJYTeEL6ECwInQ9JIbqn0y6ZeMFwy5y29P7NFR
	 CCY0Uuy+qOWL8cRvp+xygOtI/ART7Fbc7MkQFrHE+k3AysuYjjOOobqSiRWYT3EswTw4/
	 frtsNA1ld0wefh/5x2rwgKH5osESF+m18gsWNYZxC1VYXz8iT0mFFoPMeQG6Ol0rAdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rNyaCke0sAyAU3ULtsufGKh7zCPGpurv8uYCtMofRKw=;
	b=kgMdRF1GTH1j/FaVSfwNSEy2VUpkMHvB0iSiQueeu8g0uje91lex/jqIzXexGSlOQaUk
	 C7WlBPzm5pcjvYliRcRDsbbhUKCEpwHMKJlWP4TDu040foPltCpT8f46N75B+fqkKXHlG
	 1FGVuTiiyr/AOB6eX2mvcpEZ30pFnzC1ZdxyciqXUCGmoM0buDrZOdCImOxX5Vn7bBQgj
	 dva4FIs9yYaKaL7Yk1bexoKHJBf2ctxZ65vM2uKI+rcx+xoBohM0eXKoQwxU7kEuPfNJV
	 8Yln+gNrGSh3c+ptPTiDKV+VvFgocltbGwiAzECTKTQVZxO8+AOG1UJ6UX1ovGfZXgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kOaYG7QO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qgq15Mwo;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C751606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 21:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C751606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kOaYG7QO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qgq15Mwo
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A0A1EC05BD
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:56:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 09 Nov 2026 16:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794261379; x=1794347779; bh=rNyaCke0sA
	yAU3ULtsufGKh7zCPGpurv8uYCtMofRKw=; b=kOaYG7QONsWynpcIVQ2AFPfxDH
	FrKr1Z0b76HyMFUBns3FFp7/dg8ARKVdhmGB/sspD/sfFhTg30Kgv0eTgiR4r7ng
	fjLn0hbWWGlkn7wjzA7B0NpY56mnDibnpGv0Df2SQ84AnCkqbtH7ETYlxBzCS9IZ
	sSvQuJmXV44v9Jxbg7AaEn9XDGAI1zWJO3jJCnE+HzJzLD6PBiIrY4ValGADTuDH
	dJB78UEHSISwDTO/vEOBfsDD8U1RPmLA3tx0GFUxTwCHAo8ehVonIChgOVd4LvQn
	4NrJ7d2sGPXdb0Zc/ZXSqeEAZA6jlzO7YYJgxNPkBy9nH0K2mqQ2Rm9gn8Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794261379; x=1794347779; bh=rNyaCke0sAyAU3ULtsufGKh7zCPGpurv8uY
	CtMofRKw=; b=qgq15MwocGUjbF9cGbge609jb/0ekaZtmdVIny00xVgRbqXwS+D
	kfFLurqz0HepLsuY4PhWMzwo3sGvsrtt3j6BwvyHMPxs/wqw4CLTmWq+YCfAw9Th
	wUtJBpoDGIrbFZVQ86W+ynjkYdlPyLdJmM56gg+LKqmPSADvttTA5c9cjM4Pmq5O
	6t6Qi7jHesjGa8dWoJl0uJheopHjW1np4nZBYqQaELxBkTGGUXujwaUVDi3ac/nD
	wm3g0MGAu8C/49CcqLGPS3gYl8qRGJAppnkOufvgKyheh2EO9AfjOON9MxdjtqqU
	uHkwWEYRoxLn4M29buR8kRSRTpBAT/Rl1Jg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794261379; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cIFGgKfqe4B6dIqwwk7CP53zHIlSwkmv+QuiebvPN0o8wBz
	5kByE5bnuXoREZm/IEALdI2xXPXdlARsaAhbPUfQIF5Fq3cMKRpJDvxguuUlEN+c
	bH8rONt7cp43vSiqqv9VBFgfUiso5gX3ngGM3SAZokPxQEaw8SCnPcA6RBI3IMmc
	Foci2bpQGEPrl+pvXyUfpRt6qBKi9zYqVKsreGlXwszVnLUTDqdoKWRsM2WUYW7G
	H9vhATy8c0UtfbBWHUzUCe/TZ8a7NWbRPA3SuUqunf2jyt9CWbA9SAqqikrLrSwv
	vR8R1cQ2o+m583itD2H3loEdhJj4d8i0p80aZQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4KYTtwGys0eGOKeMqqpaojuwS+pfvl7aD9kvliQoBCE=:qV/ZrCOAGaxZ/85MjExy6DIYxi8smSPVl9JKAPqxScI=;
X-ME-Sender: <xms:g0Hyantd_sXGEP5mDIrLhZt5SGGQMT3OFhGzKuiSEsto5u1KXI_AaQ>
    <xme:g0HyasKQH6Tt_DO0tXIvAsPdYeKY0yLApfBpWh70hOTYJ6YVuQITeGRNxSAF8uT6J
    Zhqg73catXgYKPZqGvCQ9dys3NPyy163k99hSri-o7si6kdYTJdJO86>
X-ME-Received: <xmr:g0HyaklJGjWgSuM_tIRZhrxciRRvqvzy9fXRWB4qkZ2Mt9Kos22648lgE42boQqMcLaUGRiyiQF3m6xS5Fe54uGSm-XE-aUXA1fK>
X-ME-Proxy-Cause: dmFkZTGGYzvGCXIhcDtJZCfxAb+nuZbB1YRGRC+X7Ncf7IAF0hKlZ0YX6ugIvY/8mT52p0
    +ovRcta2A7i1ar9LKR3Zem1xibPN8TOG/QcqqiaKqlNaoD23h3Wp+0oHh5B0cyVtXWeTLA
    mqZnApBEeDMFjoLbh0/fkwW2hWT8OhVW2sH7/msqYp4NJuclrUZXG4FXPyWhrdeW7us63J
    ZQtcwusd42SPrFNep+GALF/0lzFKGUbXFE3Tek91Ri035mqw946PjMwCqTAyiOUpT78IBb
    jod/XC4MSlkd1z5Vqh9pI2yfp1q4r/jZ5r3GclWHnlsZTjoyv6/gaQCGIcyfmPLy3NP8YR
    8W5WclkXVYRuzDWp8JhHGpAKsoRj0ib9YkUjIhL1lBpuhqa7dSoKqWTA01qrtS5cF3qNoG
    YgR+CLrSey2R715VulVfxyYv/V5fZyTTKN7H+MGf/cyy2QAqcqNciCDT9/hp3Je2EehfHk
    LdQi2E2pba0Ts2W9b+m7SJMokSyCXkLnp1SQgZ2gbhCc9tIlnJh7g9MUTzw53c/EnKwZTs
    gp/+8GDZBQJHawA0kaFaiIkLUHEC3nmr7n1nTewr5EfY7EeEeweM7Vt6pJAhHScmw4ax4L
    W6xNfdyeGD0zy8XHLEn0m7TVjyCNFraOyAaJczBx0y+LSKC5Tz9Limdi2d6A
X-ME-Proxy: <xmx:g0HyatI5QvvDFhquEK-UIPofuJo-wYvzWbSC6VNBFXPHJHhwbgAFhw>
    <xmx:g0Hyap4ZM0vilM5eyrSHL26kCJa59oMj8_chZU2Nk2cQ2kbm2M5Myw>
    <xmx:g0Hyah37nR59faSZkMpkLKNNFkXYxSB_bcRciYgRoBFMGhNEj2aHmg>
    <xmx:g0HyavdvpKujG62Nj1Ro-c4QcCyiZ0fdFCyWMLrxGh0JIr5Ou9BUaQ>
    <xmx:g0HyakSv4zzksdxcCqURqvOP4YfqeNRXdRjgC1Gx094V_a0fXb2DmNM4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 16:56:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
In-Reply-To: <pull.2307.git.1794259990263.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 09 Nov 2026 21:33:10 +0000")
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
Date: Mon, 09 Nov 2026 13:56:17 -0800
Message-ID: <xmqqo6bxwtxa.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Because Git's branches are so flexible and the meaning of a branch is
> only what people assign to it, it's important to talk about some of the
> social context about branches. Do this in two ways:

A meta-comment, not limited to this patch.

We are currently reviewer-bandwidth-limited.  Having many topics
in-flight under review would not help these topics go any faster
with greater parallelism.  In fact, it slows everything down by
wearing available reviewers down due to forced context switching.

I wonder what incentives, carrots and sticks we have on those who
have in-flight topics that are so close to the finish line to
concentrate on completing these topics before sending new ones.

Ideas?




