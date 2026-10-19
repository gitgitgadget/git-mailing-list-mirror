Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445067;
	b=SCuofgKbwEP1zHcuPYbk4LctlIIgoSb26Ldvn0v10TjxdZe+Fcl26e4TqFJN5aiftk/r
	 P0WRGEYuJY0c8gEMNaf/LdQk73BPZnaw9V9lOVIqfJNpPtUvr/rnj2R6YyNIo9plY45oW
	 +Ch2A4cZ3QKYFv5QxeGxqTZ4AlOI9bXls//tIkZZAozxh+PFOf416+LovIJlcq1VdtRGO
	 l8pphnJ9FzyGhzyByA682eOud6p6UHMGFd1p67NbyQRY6QO0O8g22lAKFbGtjXuhlAebq
	 P+h4XoFp4WQ7Qkbkcax0CXgxrqFjQtd93WKrjtVDVU9aFA2NijN3cNLJZO8yJmISEmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445067;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RpYiB+h+YaoV0OCaIom1O74VOEtWRMonmSZjpzD+aeo=;
	b=0YhFiQ4P7vPYUTiZ/SZQ3wlpH/DHWhFZ5M3hRR4jP7hLhsHcDas9Uz2/jDFs2DRXlRUq
	 0VixYiAbYiVtc87YQgyqKpe36VXzRz7q27as0fwSlxMbYgfaemXBD25hmFcdaTdjRyhac
	 nDMq7zSIuP5+KUNnwL04CMiAWYMVP6yR7LsBBSXeMCEhRe/Iu4yHpygTLNRGUA0MJU8b0
	 nXT6LzToiC3u7LelK9qxyDEIHUsbCJFPrD50TcUfK48gDGm/UrMZ/fPk+3hiafAtoey9i
	 3l92OwMxqKH7Pe5CuE2fNJu+OdChW70/2pqJFt18mQQMAT1OsOBXp+15k0dWgELzRHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nvmlgy9O;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=X6CCKcsd;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A7606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22A7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nvmlgy9O;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=X6CCKcsd
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E27F014000E9
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:24:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 17:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792445065;
	 x=1792531465; bh=RpYiB+h+YaoV0OCaIom1O74VOEtWRMonmSZjpzD+aeo=; b=
	nvmlgy9Of2F68JybfId+4a1IiT9p2TCpSR3ryC8HMCx9rQI9qbhQBMeSO2/BtH7P
	IVb2ZNogkxlRfAT5CeViHe4aKc2JO00Xzk+i7/5mfQoP9kt0s2SW062eTtke/hlV
	10KthQepHKZ9QdGPXijtNB9s9lyWrpaDc+QVyM3gCRg+fl1mkBD9dq5Ly2BCfeD9
	R5esl+Lju4gvZxv3UPMOtaKrn0ujnesTgANpHiRJz8LAAphPrG1Y7YVp/4aGXxH6
	NKLdxII4WnKxLK4Q7lO53IwZkMPKlPUGVVmYndo2mtBIE6k08hVHR5XcXN/8SrHT
	7mYh2xuBoWpbFr+8wpOjSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792445065; x=
	1792531465; bh=RpYiB+h+YaoV0OCaIom1O74VOEtWRMonmSZjpzD+aeo=; b=X
	6CCKcsddlZbGDCsEwKMIzLSRswh2RYfHeoj58/OpJFciU0u9OV0MHn6XzFTplFpJ
	houbANbMYNXQG8Ws4Vh5VsLOQ7jCJwS7Rtv3eVo2LLZyLMyhyzVG/fI/hEw7aKVa
	pnCZZVzSWEDOnPTubJV7Yr00rUTYAk7VK6bYMumsv9ZAvJ+5JTbNuKQjSCN0b6VW
	6YClSUx4nhYm0+5sHWVfmHUBVnkRO1V2BpGzJpSDzAXeQa2wI+XaJk8KXXyzadzs
	q7MFzjjd6WbEOKXYb9Hg3e2XJRnRj8KzVmZo+zpiA/6+mVJhYsh8pCb052268B8G
	9Rii0jRNN3ixh9uqf1myw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792445065; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:D7mq3ViWPSyZv+v82UyKM+rojz/NC/KxKIclEPFtHFSBPCa
	8gI9q9gvOQoxefpHa1woo/rAsu8bGLzYLPhKcNrqhjUWq1E2YABFdLncEx3QOSjy
	8IPQHKOn1e91Ax0Kqt+z9HURvyveNlQy06T3c379myy6c4xEYfhvqIoiKlYhKcaZ
	w/Tr2R3CrxlVhKo7yfBzWsbgZwHouyCHsOaaQs2Vl5FRAEsvqg6+PzvHQ6aY/X9V
	V2pCPh+qkN20WTPrs/TOeJoMm5ZQSEba0nuYCKoNNo0/4vp/r41eKJQahzjek7Ln
	bGl2MWycX/+RFA8tMjsaOB++Gem2qh4Eir8nzAg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:m8aGjXLiGaD49u3XWbrtEt0wkzkPZdS3I++rJIbpO5M=:t6Mcw2I7JEgcPQnhbm9MHRS7VhYB9rStWfFpyxg9da8=;
X-ME-Sender: <xms:iYrWalPFRxcSABDGNDtym1tyCYy_uEgZL4CoejhJwcocTOrZ-m_7oA>
    <xme:iYrWau9WiqpZkEvLyjPaOF5JVVYpF1fYG2WPu0wNt30s_NK58ZlvG4TiQwNFbsiBO
    HUug56Bd3IOnJKa6eXVEax9crevplvVIkF9vL36M2O0jPAeMSQg>
X-ME-Received: <xmr:iYrWapTLP7sSDfmwJ38Gpb0-1qWhS2Aw5RmQn94UGXh0d5vWyX5TTO2BmuSwBmz17zuTtRbtdnK1lUGwc4YuqtVL15_7YsrROiGO>
X-ME-Proxy-Cause: dmFkZTGKtRP8fXbihdqAoqjPZhAAdx6sd/CcOh/jDgdfKVrSIFjVx7SgryntP6jAGcdpHn
    LanoMy+TvFRotOSkjuQJ2m9Deth2qdzCh8WuJNAupX9fGHOw/T4RlwABEe+5ACr8+XB9Pu
    A9LvqlngC5jalhvsQlYOqElt+qBuBjEMJnES9vzE4ESXDNcvzcyhzDKKp3bZxLALpGNo9r
    Y00dZpNXjmFXGUVlELr0OXbgbNzlnVita10KxGxRtGTz9GRGFbROfXc9RgIJkEPXKUKx0P
    Fzz9q3xCab9r4gvLCRro/hTbq5jeAl/Pfb5u7kz4xlUGzLHQyKkQUlaXv6O2xwqujJD5o3
    +HOfzPxixafbAvVOwawXvpyricrSdbDaCv6jHhuQmFQDwl0XVaNT0MTgBmrd4IhFGGOlkf
    gCV1BNLaI/IoogU+YudFvELYH3IYMrDkQSoJ30RXM9pjKQNDI5lc4jZBb4kspFovY82OdW
    cYNJrNqQdRpm1jaRhZDhTxgYK0zuJq0Kzu+3cVO3YOvG5r0HdADmaL5jZwbOWlhiP6Spp5
    Dig/nCGzj2olwhcOAeqbeogo14ep8Y23VD8lcAkcfgj9W8CxCh9vckyxZQmaVcNjFO6I3Q
    V7aEdPrt1fRc+8Ay0AzoStpnMCj2GK8utKqhYWhd/nA6WpmMmmEup0yui2WA
X-ME-Proxy: <xmx:iYrWagm0oOj0gRBJQYVeN8RFynhGXLm3J__e6Z36Gg-l97tbDHbBhA>
    <xmx:iYrWapTzueGmkAKxujZCWJaBrFJ7Wa6dtdyy_k0jOpWOSubImlZ7aw>
    <xmx:iYrWauP7CWC83PEqIHJNoC57eqJ50xM2mvd9HFDg0usRqyN0-RuCFQ>
    <xmx:iYrWaiVFvXPU0j5nR2o7bC9Ky__vyUEyJiZppC1IQGnLccfOA_x66A>
    <xmx:iYrWasyyKQc6nIlxIhTyxeht7DGZBUDQUvmrBgjMyhO33rfiSInNeRvX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 17:24:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <9c15d34e-406d-4702-b606-da102a340e71@app.fastmail.com> (Julia
	Evans's message of "Mon, 19 Oct 2026 10:05:58 -0400")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<xmqqik3da2bs.fsf@gitster.g>
	<9c15d34e-406d-4702-b606-da102a340e71@app.fastmail.com>
Date: Mon, 19 Oct 2026 14:24:24 -0700
Message-ID: <xmqqcxt52xkn.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

> Let me know if this is a helpful way for you to bring some user perspectives
> into the conversation. Like I said earlier I don't really think it's possible to
> discuss how to explain HEAD in a vacuum so maybe these quotes will help!

It surely is more helpful than "I think it is not better" that is
not backed by anything.

> Also if you could give me any ideas for how to reply in a "shorter" way than
> "I don't think this is clearer" let me know, I can't bring you quotes from user
> research to justify every single wording choice :)

IOW, "Trust me" ;-)

It is often good enough among those who have worked together for
some time, and you certainly do qualify.

> -  "HEAD is a mysterious thing I never need to know about unless something has
> g-one wrong, eg. merge conflicts."

Somebody may have said so, but how does bringing it (together with
many other examples) up in _this_ discussion help us find a better
way to explain it to users?

Somebody is clueless about HEAD and does not feel the need to
understand it until they really need to.  This fact alone, that they
can get going with such a sketchy understanding and make use of Git
sufficiently well may be a great thing by itself.  It may support an
argument that we do not really have to explain what HEAD is to our
readers.  Is that the argument you are making?

I won't comment on each and every one of them, but is your point
that many potential readers do not understand HEAD and doing fine?

Of course there are a handful of examples that they do get it, like
this one.

> - "HEAD is a reference to a commit, either directly or indirectly. A direct
> commit is just in detached state, where HEAD is looking at the commit itself.
> An indirect reference would be the case you’ve shown above, where HEAD is a
> reference to a reference."

But what did you want to illustrate again?  I am little bit fuzzy on
what you wanted to achieve by dumping these at me.

Thanks.
