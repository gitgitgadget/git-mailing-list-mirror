Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664963;
	b=oHj9EyEnelGXa1JlVOvAB/L9Q7gBun8YL9BKBOntkcqMnJ5p8xu6jeUAU0WgYIBhGoaD
	 LA/DyMmmmML6AOj41+njTo3KGlTRuWDgK9wavzZ3zwo5FX2vWPBDiq8d23t5hIHGmQ7ye
	 lmLpqV+OIqfrrmyd3YLzRxzQec2WwBtgdsvhb4jDEFJdK2aS/evMgOc55s3bbYhxoFvsy
	 A8z4TPghCR20MYaKZftA/yyzBv1uyfdtu+HtJBm39Utp5PEM7H1kqn5FFYSn9VrwteUUk
	 p8s0IGX218lvEmSTGNlSQPTZTwAJ/rXZUU32dLQiwhNpBEYrPohptjT+X3DEb2ijf0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664963;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dCCFOxIijS+Z9ChXFPxo8lucoJVr8JCSTn2f2X2jPyE=;
	b=ihAAzLa6La4p71N8cKdZ1r6oepibHHoYjVUzorWO5kw0kggBEbKxE/7DwW530rlONMl9
	 jDyz8gzMfZUSFJ9OKxxo4IirqJ7EQtYeMQ065VTnU+fWGfoKjxbvMVl6vDe0IWKBXdDAu
	 p/M+9DlCPNYucM09KE7f4KAk9GSdNSf5tI30VmxofwvQSIrdxiia2DB2iaA0rIBKodPbN
	 6HsMJuj7xwno3fY9CDIdAkOcBLR1QsvqXdZRPQc9txzj25zueXkEP7Cf7CSXQLDDHSElM
	 1j3vmJmLEli5NNygBnXhUwNR7/UDfA4W6MvwxeCijfBKRTRc3zrKO5XkxaKWmw1gOSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EgAsmKCW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VQ15+6BZ;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14512606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 00:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14512606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EgAsmKCW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VQ15+6BZ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 461B01400042
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:16:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 19:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793664962; x=1793751362; bh=dCCFOxIijS
	+Z9ChXFPxo8lucoJVr8JCSTn2f2X2jPyE=; b=EgAsmKCWN4SIjrWipp2t/H/cZF
	R+Y3Ln9Q3yfyiFJ40zH2ZLpwklUo7bUIenut3y2T/pS7cZzdcOmm9Q1CQiaFrMER
	fESRoMH1Ur1CaH4ERD0GqwetMsc4RPz6O6k0PHu9I8ablpGV5D5aF2F/b7kpkuAD
	IaBN1eDh6miQk99Skz0ylnqzG7A2mR4atutdEDeKnRxIvsUOOmdit1m9new6JmI6
	86+ckngMWrOsPaIJLXwb6LRpxGFhFgdgZ9Ly4fI2yiqzGnj2D40zV27dqUjCdMSU
	BD4LnbLW1YanUumy8guUWQqpSA+WBToIiAH18THIGX4Bcipqe9xDMBeSXbEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793664962; x=1793751362; bh=dCCFOxIijS+Z9ChXFPxo8lucoJVr8JCSTn2
	f2X2jPyE=; b=VQ15+6BZEDrKlN+KwUAqP18Wgf6GStXDj2kTzC1ZR/hz6A78ksT
	IwBczdZZL4hHC87P5gr/r5cftUtC6NuoRFGTYZRUvutuMkczddRGYFDx3+uNXmbT
	nPR35JPtgBw9GUnTviw00BIVheObrrJM12EwH+bC2YvNgPZIA7NTQN9vAPM84Ox7
	PVXrhpxiB20a3Z+jomPn7LqT/WhY5XtoJX6C1kovz67jCUcMo+UWb4GpW9CNu1FK
	19vwYQwnvyWPCXzxOSiyr+aHoOgWf9pyM3la7kda0RV5c8VAYdMCj0eeV32QP5iM
	RMun7+u4h2KUqlWVsuk4N7jdI2tgYznfF4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793664962; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hACjRnoI28pTe4qQtSIunWu8TkU0TSJuLNMnJ8GcyPWjpGW
	3SGeIxGluXy34sdTpxqfWZiWcDzViyjhjh2DfMqSRps+2C1LWmk49nRoUhIiCbe4
	F/KEvnln47mUtxwTjFbpT8S617RRqGa7Qgj53iY+sl2iyRWtUzO4cO4jor0pKk4G
	AggmCxP3p4dTp+7lkH6glPV+Tfkft7H90RlfyUhx+QHonqjOcVXCBc4T+7/p3FQv
	MtWvDwCHoOvgHObca/W5ItXH3hy+3itHOhqvEfQH/Aoyh41fBhL6MIyfkdhrl2jC
	A8rFaC9gHp/6aCMwbTrihGBuu5rdIuTDrG5Y6yw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WNyHIgcVUPIEgNybiO2IxL3cAzBK0nXCTwbBa21yPsQ=:XqckYigGbzVs43loZPV7MuWhrdevidvJ81xhEpXaNAw=;
X-ME-Sender: <xms:wifpar-VoqsFB8mqvzl0zuDNeDQ71UC5r5H74hcAU-nAhoncoGSAEA>
    <xme:wifparadSMyq1HzlA1KU8Fvz1XSOqTwdVZHMlsNY6zG3YHq6WHcI-wfVm8tvRATvd
    c9jHeFVHUjJDFwFC3koX3tw-FqM1C6YhRfBILJSJ88879HxabU2>
X-ME-Received: <xmr:wifpai0FKLmZnTb_5fvPQy0KEyTenEiWWC8L26JXkT5onMI1mP3oxP6GZC5dl9RPmcHtwR67mW2enljAGUxLzOI2K04t3Q_nZfcR>
X-ME-Proxy-Cause: dmFkZTGRfCDcwtbPtLP4tUHZZblj3QMvxVGLwQPl8AFBrAq/HGl825qgbztEfpN4YWOULe
    r91TnBWlmT8DShZVSpMkNQlAh9FXuFw1lCU9ck8/QE09MHEo+MEPXNhI9cRXdanLXxE8do
    sPehdkkQWqG9H3qkJ3zTFJG4Nc30osW9otJoEG5PIB0rfL0fW9R5k402KirR+nOTBdfZrB
    kLDkVLYYmLAseYVsmpAtCYzYzGo28R+/mV2vsPL0Q8eSX2CictKkPx42Y2kMtVLndFn2Y4
    WwL5LAnO2kGVLihA6dD+m0+MFjienKZ0EYqTjEfeboS7diFdLuxEV2GQMkdasjWLxbcBeY
    2H6gfqgHu+CkcgRxbuXPj/25rv9tp0pd2ZJgEjhky1+sP7t27ojQxSlLmrmldq/zzhE8jl
    VORyduyNGnTrrvfLl/0I4TigEgiMvj9ImTZLNTDACcc9Yo9TByS8aLJIt8z3DrA+30RH+O
    kcvtz80JOstjVcPXzljx9cbSCkSA86P/barlQW9UFBhu8ELLPfCc/Y6MhMZXU4LshzfeF6
    THW9slnB3SI1jS1lmhmq7oYvpjJPgRcuTGdUTSe2BOH1WHW4J8qRJkhXemrR0eqzP3rUuu
    zQAd5qCv54QftRjD892RXMWPUoFbFXOkT62mtoRLqOIK5/RSz4HBFBD7RMiQ
X-ME-Proxy: <xmx:wifpauYRGnoKk4L0xJk_OxxFqSmJA2REdz_uZ8O_RPwZrLI7VW7j-Q>
    <xmx:wifpaiISrMODR_19ue1d-y6c8BoSfZo7X5I5MhO-NAsh4yB_enw4Jg>
    <xmx:wifpalFjFqv9zR35wXb0kcOyiXkwfbE4PkTcKqi1TZLbSUzpllTzdw>
    <xmx:wifpahuGd9CD_GTfl8rTH0l4l_qNhrJcDT4hbjl9beLaHLvrFm9e-Q>
    <xmx:wifpakoixblF87ukKUW4mhxNf9Z8xeZNRRhxsgSt6MmuYvTeEQNDgJ-f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 19:16:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>,  "Ben Knoble"
 <ben.knoble@gmail.com>,  <git@vger.kernel.org>,  "Harald Nordgren via
 GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided
 commits
In-Reply-To: <DML4UIOWA70L.2102KB7HQNX3O@lfurio.us> (Matt Hunter's message of
	"Mon, 02 Nov 2026 19:01:10 -0500")
References: <CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com>
	<73E9A266-5224-43CC-ABC4-83FBC6B77F13@gmail.com>
	<CAHwyqnVbgHOvCbXjWAuV7CkXranyBAocfobH8Jerf_96iWzYkA@mail.gmail.com>
	<CAHwyqnWPhgT54M2LL7SxSm0qufSaYDD-gGAJVTdOqaKy-CTA-A@mail.gmail.com>
	<DML4UIOWA70L.2102KB7HQNX3O@lfurio.us>
Date: Mon, 02 Nov 2026 16:16:00 -0800
Message-ID: <xmqqcxsmg473.fsf@gitster.g>
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

"Matt Hunter" <m@lfurio.us> writes:

> Wouldn't invoking as
>
>     git range-diff origin/master
>         pr-git-2401/HaraldNordgren/range-diff-matched-only-v3
>         range-diff-matched-only
>
> address this case?

Three-rev form where <base> and two evolutions <rev1> and <rev2> are
given, and <base>..<rev1> and <base>..<rev2> are compared?  

I thought Harald's case was to take the patches from the previous
round of the topic and rebase them on top of a different base (e.g.,
updated origin/master), so there is no suitable single <base> for
the three-rev form, but I may have misunderstood his example.
