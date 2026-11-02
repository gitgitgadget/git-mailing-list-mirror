Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611279;
	b=jgUkLnSEZ2q7ivjI6zuO3QbMYgKsoUj5i5Vf73MkpcyV+gJHdJc8j22SevjVb8oASEhF
	 sru0ihnfdG+EzB4N1Buxg6hYjWPVc8wR57QBWgAxORq5t6UWUVGE7HmE2umnS6gTYyKAD
	 K7bS8FGi7M6OihozKuJulz1u8bPfLVj2uIC33OHMt2A46TMVaZzvdPnXP+2k/6W1Uh11Q
	 40h/jGCjA6EH4jEkfWntAGevbeQy3lyWjvqVOY3sgfeQlPWthgQKRzqVL5t2ZA78B+9Ec
	 3qE7MsocA5Q1BFwpsMOcWJBlroFqk+F8eMpChE0YF/lgKWN6Jcl+J7dIJPBDbFT6+Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611279;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Yl+QFnM27kmrJxvEanjVoajoMATq+EiYoA4V55wihHU=;
	b=XkGsAVmpDPiMHTXuKQpqw9Ak/sKOh/VhSg6MOCuHNLG/CCTTF73ao8X0L3wTO4K7bPEh
	 p29mW1SGINesWXw4lUmukkLz8GbUy73xppKwQAqvtwDN34RHNUF9ujDJmXE5D7mPHYppp
	 6kAsliEciMIPuZ7N/pQAOMh2t9EsrH1hSNIAayG1NrtwnJJTRTaWIRJh3mcJsCW0dTjcg
	 v30DWoNWeunUqDit3BPq/ncr+eNG7HDCQtvebhX96K33049/C9Du1Pcjka5VsCBA1P1B5
	 QK4ZJYn0NppyNQdYtkTnw8nGhbLvNr7OPCWT9z7NAIrkKeazoDipYQKPhahSYbpHITA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gBtCC3T3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ghktzPPr;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E4606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 623E4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gBtCC3T3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ghktzPPr
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id AF3FF1D0006D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:21:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 04:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793611278; x=1793697678; bh=Yl+QFnM27k
	mrJxvEanjVoajoMATq+EiYoA4V55wihHU=; b=gBtCC3T3W0XxP6ykg2JQMAttTQ
	CP5+Y/IYEv0zg6toCw2SziatBADLSXf1p4PNRzcWgxFXqo154Bp2Hdz9ZSKhN8EZ
	TO65LC6D92HEsVtMrJ5zeZqI1xvuoFyUdXhyMtCSjgh7WZRDI66IVUwfYulfFz6Z
	I2KFRH2gyXDR4LVNyoPZPNiNHnxPWItVNqe33HLSa6308YUnPuC8i+lX04Ol/M9l
	LRnBvWzd3nGfPs4lJAhO10c6CEPTKYKuQzp+mWfFRSd7Z9U5CBy2XQyZkZVh7Az6
	hPphHTRW+6daXfyBJV8G2+T83cB8e+oTQydxxy5UVb++18pTnTz1MbtFnj6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793611278; x=1793697678; bh=Yl+QFnM27kmrJxvEanjVoajoMATq+EiYoA4
	V55wihHU=; b=ghktzPPrxye890RbrHdSRTaIlM359hQJgY0DKB6jkuUDMzyDZsk
	aW5/yxqxxnDue8lu3EssUAkP6u0URFRWsbkKF1Xiw7g4VK7ZcyD4NvVN3baV21y1
	0Z14B0xss99knd1/ymPk1PLyIUTL0xkoVlEETIfSYqOCWetjEXHGL2gruIbeRuSK
	In8QD3cry4FIidFetmgBoQ44O+qXQ//7L2IT2JAKrsE3/hAoq9X5Rx02DWjxCyb9
	5a3T6Jcqfh/CTg8mZgCtgEsWzwfcIXZ+QWYI9974Ojg7F0Sgw5XFLIO28bNZS16f
	suTEaV/6GOu6ASGSVT8QiuLujF2QWmA5PPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793611278; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dSguRVmgIqsbdxrKwC8nRFOZVtrGspKWBoth3rYxdMf+Eh9
	q71WVa5G5yyYJK9Vv+XpDqGv2bQsPndUYa6x/5C0y/+Ivqu/I86ZszK+7ioV19zV
	BGHJ7zS6jU9uu1tAFnswJ3rrgFTZj0/0tuadw43jSzrZ5rqBIQ3Z57U6DPLJmmgx
	NnkMjH567Vwly15si5AzlQUuHHV4wJA3iS7KZfKornlnbfJiSWuxwd7iNhJzWwIW
	mwuFlsOnM3BEXug3EYM1l166Rz4AAQEASS+Q6NAkwJVtpXvjUJJDZ5s7hDzFPqNc
	ucoMFC8XLnaesUp04JCtZQgJwXNretSOpkel08A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6PouK/mDRwYaPymZu10NPsBk6iJtzUqeYDbK7fxUo04=:Us/od5PlslHhl8giKx5j76xcgWfAeNEdpv9YbRDerZU=;
X-ME-Sender: <xms:Dlboaj_zE7jpL7zKkjk8U1rzGfzlJpQG2W_QXmj0TXmjvvwKhdm10Q>
    <xme:DlboarO-L9CQ32Tz6JqLYqLTbCi49lNNCCjTa_3y6033AD6bcR3TsKhcbcwaElbwc
    1nU6FdPgf95v5mzKT2VGvBKBLd6Rp0Dp_JUzKiXvxN-_27OrqumhQ>
X-ME-Received: <xmr:DlboancuThbqbYzUTluF1PNSc-YOz75gSbRwVe3ZIDyZ_PjyHb3jle38x8elCk0WQL_jdYVDvrvYh180r0cdXcrpqQiZ_BjXKS0W>
X-ME-Proxy-Cause: dmFkZTF0u7bLd7NJnGCYwik/9GaGrALIMglmtLMIgi7yfYHqxabNgE5lXjnQ2mFMSKJtlE
    niQg65E+WK4OP+O130FdA8gM5dYe/wFsJ0XYkxGXMElMW8SVtOrl4uJ1iK7DgP7JrDhBnw
    KKaRhcrDQFXaTNheGs4jftAhZL41QBbIDO9Oqw8hrUDt65nGx1CzutU17A5uYz5zppKHAw
    puyLYjYfUlVkQA91jEB6ZVpSzS7DLlVxvSOJc3lHffD88OTY7ibNVIjLFIg1txvtWuyg0+
    Z59seMFHKus11YG/qjmBnvdgKHa77P4llD7V/7RnHhrDAizYPkSBMOBkLdCGn78r/mndgf
    QGJ4Y0Vqj29ozIx1rybWrOAHh4lakHcijSfRuor1nEv64JXZz9vEWRTH6PBCQgFER06+6J
    1pkNb69ULd0C2XNIh5xSZRSG1XM5B3ZNX2yh2bmqgG+QyA9AfXKYC2SaToTwoo+PEsD15i
    jG/OFpNCUfjfuTCaLqrQ6cg3Mu6I++lkVCT+ABY7fw3km5mTHXUvei/MQSN/U//kgr2RTE
    ncBl52UgCSzjxXyF8k5NcSL4HUiqJOZiaNmiIrC08XR2HmFe9Y3Hj4WxHTnFHOeXcPuIR3
    2rXOIpO3syIUUdb6rW1KvOJwThPyzIYtcRIOoB1c+PtISouQ9IEHqZrcHFVg
X-ME-Proxy: <xmx:DlboaqVv0vmgWBKXHww5kG9EoUQRFuYI3r6z13Lh2EuRzKE591fA8A>
    <xmx:DlboavggAHW-7V7WovZxGavI1KswzeE6xaIxt0sOspvoYelGBUG56Q>
    <xmx:Dlboap8hhrmQjKJ-Cdfyta85fI5eqeJUaLVUTuRTquZFTYcvCjjc8g>
    <xmx:DlboahZsVljlMpUx3TMBdRTDwACcHiX9NAZvy1ctXM0_tcIX0Z_c9A>
    <xmx:DlboanOB_rt6bRT4hyeDsTwzkRRbas5pODsCoyBOWFn_gdEiPKi2SVZp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:21:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
In-Reply-To: <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 23 Sep 2026
	18:55:59 +0000")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
	<pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 01:21:17 -0800
Message-ID: <xmqqtslzlhbm.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Asking for a commit's ancestor with <rev>~N in a shallow clone that
> does not have N commits of history locally fails with a bare "is not
> a commit" error, with no indication that the repository being shallow
> is the reason, or what to do about it.
> ...
>     Changes in v3:
>     
>      * Drop the git log -<n>/--since extension entirely, per feedback that
>        last commit shown is an unreliable signal for a shallow boundary.
>      * Fix a bug for chained <rev>^^^ where it would print the hint twice.

We unfortunately haven't seen many folks interested in this change.
Is anybody interested in reviewing the patch to give it a push?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

