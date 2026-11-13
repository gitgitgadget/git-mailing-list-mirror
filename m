Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590018;
	b=bmJC9XxjqRefKDJlK88++EE1+OOVjVMydTmsf6zF0qWmOKc69AfP4ld7+kR3ZM6AqNtR
	 xCPPsJK+dUBM8IQGGl4A2kOXagrZov60QiNpkx4pbLzjc2TLlNtnBCfHxlFSWHvwLZ4XW
	 FpT2l8mzWnrZ3XSMNco7sasySVzK+mmv7NQycUfcjQc07L+JXbpKIjoKQ5b4quK8aZr2C
	 pGe3tr82ZG14n3n71iXWvrj3qWXMoJNAerPFooiQOlfOsWlHXeBP4664ICc3uRPqR7KZ5
	 dNDX77o7d8hjnmBVf+oZ15YrOn1xl/9MwrcG8Evjiqa0Mkb2OO3J3RqsLDTpoL9VyKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590018;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tJjgOtZoFPUmEGXrt3rr4hUONUdsopsVhdIQ5xCR+Hc=;
	b=auwdiCRC6O36frge5JXDeiU9rRp3xI62oXvCSbv8I08kF/NkA3S2/84axLp+NwpTCqZg
	 WO9F64pbWj2khljZHemrQB6NlisVVoH+GhmnQsrQhxJN89+t4QjyGSOZY91FWZAG7pAut
	 1sWH8NhzjGjTB07QYvV0XLFQEjtNuqg11DyQDoA4aTcrIilbo22jx4b6psNKcxQzJy8fV
	 RFeuID+JBNEnRh1Fs6Swamh+H91/rbz+3jmr6b+UJXQ5Pid40gokHJB+wKcjScKwF13N6
	 qrDUfOt2GmkbdpDBxxWzlj4MpdyTsvKJwFaxvD21cavrbnXfFvSrH3QgGU8ndbG33yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fpRap97Q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="Rf63Gu/2";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E902606A886
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E902606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fpRap97Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Rf63Gu/2
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A7D7140008E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 12:13:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 12:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794590017; x=1794676417; bh=tJjgOtZoFP
	UmEGXrt3rr4hUONUdsopsVhdIQ5xCR+Hc=; b=fpRap97Qe0DYqNMbt+gojiXmYe
	GhuMCnBpwayp33dR3E2mCkypcuKccdzkoQm3/d+rFydoYyWKfuq5HssS5XPeIWHn
	Ae/I3/RjlyEmzPhPYx8h9ukmpHTjG7huvJ0mQj/WAimquq61buicCv4xrCmB2VZh
	WYgYOWSgG5bjcs+DIfztOhxRMppARlDuwSUNlrWTlO04WfGJqWBhVh/o4A8L9Mv+
	yEIWgP7NG7mSHs7JfzHY1ux546pHf5+jbAmXjuSOsaoeSUnn+mxrqrOvGt9BDUb0
	T9KZ3frL5qcrA6domlvbT82d+TGQ6ZmbT3SRgIpqn1vt9UYjHJrgNDZ2LmcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794590017; x=1794676417; bh=tJjgOtZoFPUmEGXrt3rr4hUONUdsopsVhdI
	Q5xCR+Hc=; b=Rf63Gu/2qNUuxoGJwosunUEkPzBblYobU3rwT3ke1Wlnko+6OGE
	A8DQqx4RMCLlaaYrLJe3jqtjYumcfyJ/YIl6bgdq5tWSAgo0v6S0w5NF7lZFyJf9
	CWMCilUdUxf7StoZVzAeikion18iIIwwCHf4doe1NRBuQm4Vx6yH5WeTKEmYT/rK
	ZaqLj0gGcEpS4Y1iylzfsI2hJa/LvFyRqtNLwIGVV4bsOCFbrzTHggVX3lSlMnZ7
	wCGsmF14OMaPwcEhc+g/LDUcTtzNX7V8g2tXeGXLC7Y+Wbmha2QuI45+HnyB736W
	wxaKEOsK0oaMiniZmhEk1ssbiq6V3P1GjgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794590017; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MMdEdWRw6aX+AX6IM9yK3a6Z6UjroXW16tMzd9brbemJwA8
	EdgzqdQLJjwUytfZXR/QZv6DmjHRZ8u9UiFXAKUAbUfEhWeVCJJKDYYC6eP4B+qX
	k/PR9sno32caCsly56p8Q3EDO7E9ri0MCVdozjA09rp63HfzAyo+E5j+LLQnMA6a
	0xzZ6X/w4dWMf6WukCpRN/ogoIP/b+l8IrNum8dVNlV5R6WV5J/7xnYCnP1xmOH0
	jFcf+QGMdF0wneBiDfgSZiC/wvWT7BDrLep2dhrLrpkHnCx5C/Tuncfz73T1o1XG
	oCDR6Y4sTZOdtBxGy0q8FezYwAOkD8s46ks1EYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:PbtCP/x8/9x7dRF2NpYmNMYbm2IEr4uopa+rPpgNX28=:/MY2eMfP9bf8kCqOG2ZSvkRz4MGGVeh61wCjv4+Fn+4=;
X-ME-Sender: <xms:QUX3arSniVyq66_eCSuSat0pLFAFwMAqjUMDZKFDhRS9jKmzfuZ4GQ>
    <xme:QUX3ajoGZeBzyepXEtNFW-qKE-R36fVWDHZZ6ym_UvzWaxSGDNLzNK7nw7fNDXYQ8
    Dw9EFNcTACuHuuUQHbTb63ppDbdQ7zH40K4YcMjcgKG8BEjNPkSrQ>
X-ME-Received: <xmr:QUX3apJVJvtQAivQr7fC70ngMN0u8J93eDp4TKZmQDJDEVZPRSie5Fxr1I7UMwVAQSJY9SVLW9uw1UdCHhGoZ6LMMJmWIOP67dC3>
X-ME-Proxy-Cause: dmFkZTEiKMjwL/goO8FPloTvZAmjL1Pz/oS78wQZ/JMbCfIp1RR2UxS2K+la7+vC9xtsP7
    UdkcWYIMPFj4ZfCS6IGp0hvlF+QMyUjwyhuehbMqMXETKcQned0zohZXPaaIT2eeHumR8c
    dQV73l4f9VgXJYYf7it0t2N6utD0eOBmKXP3bqWmiXDLVNn2WAqszzIduDmVKNdRBqNujm
    LRqF3NUA9MCZJtpuCciP2VytPF/h8oGnQ6jtUuZ94/leHQOWkKqjtr+7EeyclvTdOqdydj
    O1uzJQACyMsEDFOwMHpJ9MoBkP18Bd86/0yIK1sMbcNtWSCX2YjUPiDWwc1TKOWTdNcVNR
    5d4kEfE2a/yDaif6ongMWdpQbBbvh0Bv49H+kdWc17trlEBYNx6dTBdogUGFAIcpvWNTqm
    Ut+maid/AHp7aExa8oxJZDwzemaHZZ+M0BIX+buRvyX5peIc7Xxyq4TOPuOpemEvvfuy6y
    l9CnskDbP4k1GJ/QC/faeQrnAwQGk5sJMOTl6nzSzd6Ods/qqOCJf3qWxJAlUmTh47U43r
    jn20plcPyxelkiUbLrCgjtUrjGQyExa0bnICm/EugVFl9Py+uQzOxUimc3dE15cfMpjYDV
    /tdkRrc/nazLU05zLGPekyrmWtLuJVbm+RBS8j6NpbKgCxdsdwd+4Vie+xpA
X-ME-Proxy: <xmx:QUX3amrFbGRixJyVDwt1DOJfF05XYUsWix5LW_2KqnMO6r9XsDue9A>
    <xmx:QUX3ahwHe5pDpZB7NogeSjnzFG6z3v6FFRsh_GBVA2cbbOIMqTKTUw>
    <xmx:QUX3aqOIkShb7qPkMLjOEGcBV242BedntbaYdkpYZ4NHn2TjAXSzRA>
    <xmx:QUX3am7nNq2gfQ8iaoWT8m-W6hqMM1wIcSRuyhnv793Lzau2OqsmjQ>
    <xmx:QUX3agqwEmZ_hDE4MUwSRdfkvFaAsH2QDiOcLUedBlXNQ-r0CVIxo7LC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 12:13:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2] commit: remove padding from struct commit
In-Reply-To: <pull.2309.v2.git.1794576606249.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Fri, 13 Nov 2026
	13:30:06 +0000")
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
	<pull.2309.v2.git.1794576606249.gitgitgadget@gmail.com>
Date: Fri, 13 Nov 2026 09:13:35 -0800
Message-ID: <xmqq7bigfydc.fsf@gitster.g>
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

> Since the order of the members no longer reflects their importance,

Micronit: "no longer reflects logical grouping or impotance" or
something, just like you already have in the comment in the header
file.

> diff --git a/commit.h b/commit.h
> index 1061ed791b..d43cb1e46d 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -23,10 +23,30 @@ struct commit_list {
>   * The size of this struct matters in full repo walk operations like
>   * 'git clone' or 'git gc'. Consider using commit-slab to attach data
>   * to a commit instead of adding new fields here.
> + *
> + * The order of the members is partly chosen to keep the memory layout
> + * compact (avoiding alignment padding), and does not necessarily
> + * reflect their importance or grouping.
>   */
>  struct commit {
> +	/*
> +	 * Must be the first member, so that a "struct object *" can be
> +	 * cast to a "struct commit *".
> +	 */

Either append "... when we know it is a commit", swap the order, or
do both.  My preference is the second one which would leave the
shortest result.

>  	struct object object;
> +
> +	/*
> +	 * Index into the commit-slab arrays: unique per in-core commit,
> +	 * and only meaningful within the current process.
> +	 */
> +	unsigned int index;

Nice.  It is on a rather longer side and "and only meaningful..."
may be redundant after saying "in-core", but nothing is wrong.

Thanks.  Will queue.
