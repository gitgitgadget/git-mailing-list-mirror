Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004498;
	b=BUywyXMVeHPqxYwMJjHe50dEO4nIkY/nXvEH9hMBALi/dUL0Wb3kqKi4oWkCKXXM2fYZ
	 h9lVcYbBvxia8Y2GqjcSp+mVIYGi0V8+oXxnp48LvCW7pUB62elacnfdgVwrf46+0tllB
	 6UcNaVA9Qy3+FsyHoMrNvHp7jmsKM/fY5XYP1ukS5gp6ctem00aZXkU+XNVLmqUEp7D/V
	 vkSzESzDNMxXIEP9UqKMRfFnZ/lK4OZSnHXRgdOkDGn57DFUHaQNIWvHX9xCkINcVvoNu
	 pTQwoK4SSPKxKDz1y+Zc2tBjcWS7O9Wou69vYpVOpfDfORQdC8K8D+1PbgZkzqCQhmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004498;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=0YbIeI1Lmk99MbMpN9iBmi/v/SdYXIxqyToipLrPOG0=;
	b=rWwk9GEocGIyh/xwETgLgJmuq5sZ4QWjnOpcXBOjs86oZEkwj5GAY6r+gRNS+ALjxUq/
	 UGCvMo3H5rXM98DT/OllDUVO6aQpoYMUege6PJBRyvqfb5My2Lk7hWWVgYINo3yotPCCS
	 kVDeNZEHQ0fqSAana0YyarWu/QxhQw+boBUn6wTn4zSbPqsLWPOE0bl024Um6UFhUBHUi
	 q5OLBScQPEhegHFHYgHsGAvJMk5a9FraORSNDiXst03oBJfQ1RsrHJ5ldlRtjgQjwQQ72
	 WviLyMeZROpU8AGQuzxsoXrxlYN5hKvBXMBY0dg5rymydDLJlrHPhTZyWoyrxw4GC1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=HDRn+4ya;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BQA0sAux;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93992606A31E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93992606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=HDRn+4ya;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BQA0sAux
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDE467A01CB
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:48:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 04:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793004496;
	 x=1793090896; bh=0YbIeI1Lmk99MbMpN9iBmi/v/SdYXIxqyToipLrPOG0=; b=
	HDRn+4yalwzuR4GW+tJhxf3Evy3HwPt+E62xVGSGd6G9bQW1XnYVg4qY+eobFTPP
	RRuyc/6XVN4C9QNEsJFSjr7sbFYoi2zT/+dbLihfjytrVvAIlqfBqCs9rYsnO7Yg
	r4lL2VSLG/wT9Q9ekHyEHJjB8fDD+8YZvU3viI2SMgYyqyCrfwQNs88y2a5qypBs
	H+4dJSd+9k1CVZM5Mx5106RIz1um/mps7GEd4IdWmHf2YFBjJH/WxqraTldpgYQ7
	5YFDJctxmCyqhIB3vXjscXF8YU4yXFGaEg8D3wgeHjOeVcCKKRFNrxE68JgThGdZ
	GcGf64TgtUJYv7Vm42KOwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793004496; x=
	1793090896; bh=0YbIeI1Lmk99MbMpN9iBmi/v/SdYXIxqyToipLrPOG0=; b=B
	QA0sAux/C5dTJ9c6OyJcCNCed9Ob/ZavaIwwUz3/eVag3To4GQJLEwBGYH4jP5iG
	ex6YaGcvD3KyLXr4cd7Gk3uvXygvKJcEQAR52KwFNtshuW+lqNO43bNKwpqESR6x
	q18qVVWhFj496Ve7zgTvzWDljf2afSc2s9VGLIZWdcTigDhTdZNAqbglRpDpj0Ip
	MKMgOQ92UozVCa+WkH7uCfeyGbsKqxyMUrecawXhfFEDnfIQdQSZfx/Uit2aibJ0
	mDYM+5w7V6QM4bqdMHXfD60WHoaKH22iERSA528d7waoInN3NBsYEQS6OTIlngtC
	e4kAex8VXhaRfP9HVkaeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793004496; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ln/wyCuXyBTrHQXzPTh8DIp7hNYMQKWZk8Bkvb/E+KU60my
	epLk0idKrw2IjapsNCBbVf05sFxdBTR46s/Qupz1dnLYHgF1N5S+QhY1gPsTZU5u
	vFZzwCh4NxPTFGPWGmU4Pdy5y+ZUArDizT73zLxsDKycv5JvQi9VXvBuuMXygHYJ
	b6HIHKGIw1U1bboqq2JKWeO+FQCe65r2YeHPZFYg2z8p/lNITbMiV3wZG4NIetK1
	AHC4/d5ACJ0kyQYh8ASNJtHSEHFA2n8DFl7eUMxNtlCG+80lLIlSuWGVNjiSan/f
	fkWckgNnSBYO3edca8AYIMcpv9zlTsu6+Ho1OGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:O8te/PwIzIgk0KqXBSUscumBxVSoRWZaD9oWY8mq5eE=:zpMr1mEw+WFy1X58z7ktJd9SvbKCN9RVUo3UVwUi4EM=;
X-ME-Sender: <xms:0BPfavvV95-brZ3lJCYaXzQssbFucW07CSXdoIh6Cq6D9rz0_LoQvQ>
    <xme:0BPfamc9vYyo49NE-tzO88mFRvBf7gb07YOHy8e0uUhu1vxflIFLAXoE93yGFzt6Z
    C-8IiDbW6RQJr16XiXNvkpNcxFJb5Ejmn-OfcQRI9U5keL4TBg_6A>
X-ME-Received: <xmr:0BPfagal-hJ1KeXW9rWOUooGchxSgmKHZXM574e93SKJQgFmQlN1Hw>
X-ME-Proxy-Cause: dmFkZTGtnzalGtTyVUWvI21Lph30b5rAxr4PqRMfpI/8psJJ9u4WXryEAEYf5aOg+JDosK
    kZ9AhvOCGoKKRA3UttwXSAtwi7RjEUlLit8Nr/POKfh+Sr++1zLfkY4VY1zsvdn4GA10qz
    wbf6W41THUkgUnsCW+w3CeHt7TZ5ctVVeTQvZ8+UgqlRvDu/qkPyZv27PRci/yIdpyiOV+
    37M9T+lbw8bNebA90BoUg5NNhWJlrgYhv3ONYg8L/lDn5nPMibkwlt2JLC4nmk78qmZ9ff
    Bd4Ch+EbeNVhCDcdzzox74oBbKEf+oykTuIAWWmAxnnJ6skfvFG8MkWFYszmxOImUirsG9
    /5e8DEANDwm7ZSDAokhoF9Hv1YbhRDRV2/TWJIT/k7hlaiCdeZbjY5OvhS0V1zDEBY8M3R
    fz0qt7i/KmRayIqmK3qJ/SOjBPEYoTvm4yUE0y2xwH2xTKej/c9P4I867AUuCHCnmJ8WA0
    SFkVFvUInSGEvQDUQ49DTqFDQWTwEnsbz8IBQCPW6S8+0DQchzSE5nkk9OxjYjh/Mkuh3I
    m3AiqMAf6r5T407DErRezLAp2cvcDyIzIkF2yWFRpQ8EURQmv+nYecR36UeP/JB7jOzEcw
    hXF1yQFN50WH8rUvfcpi23A8rlQYFpUZl+LmZLKjz97eND0WoR6yy2aa5fBA
X-ME-Proxy: <xmx:0BPfapXwXcI9np0HL_Cs9mnzAygEL_X_0P2oT6T5XvjXgjLDDEC9NQ>
    <xmx:0BPfaijLRxFW0Q4mEEqdqlFu1fN3wzBYeOSQyxMBQEb006RbNFY0kg>
    <xmx:0BPfanVbj3KipESbjkYMGLOoSk2Q_9rjXur1VGtidKgIyBNWg1VGRw>
    <xmx:0BPfapPBpTS6hq3B29Ih0m888uq_lSdxV1Y7is4U_VG0fmAkmQ6eXg>
    <xmx:0BPfaqd4csmH4VyMgVQLmFm3Blpsep8rapetR1gtR3l8sSG5NtoaN6dv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:48:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e41c2ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:48:14 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:48:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] stash completion miscellany
Message-ID: <at8TywNz2WcDc-0c@pks.im>
References: <cover.1791827304.git.ben.knoble@gmail.com>
 <cover.1792761643.git.ben.knoble@gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1792761643.git.ben.knoble@gmail.com>

On Fri, Oct 23, 2026 at 09:20:50AM -0400, D. Ben Knoble wrote:
> Diff-intervalle contre v1 :
> 1:  d0e461a14a ! 1:  90d36b6445 completion: simplify stash subcommand completion
>     @@ Commit message
>          The stash completion helper contains a hard-coded list of commands, but
>          git-stash provides a mechanism to list such commands
>          (--git-completion-helper). The pattern for using it is wrapped by
>     -    __git_resolve_builtins, so use it, bring _git_stash closer in line with
>     -    other completion helpers.
>     +    __git_resolve_builtins, so use it, bringing _git_stash closer in line
>     +    with other completion helpers. As a nice side-benefit, this also adds
>     +    "store" subcommand completion, which is missing from the explicit list
>     +    of subcommands.

Yup.

>     -    Note that we maintain the "save" special case, since it was removed from
>     +    Note that we maintain the "save" special case†, since it was removed from
>          default completion in 0eb5a4f911 (completion: stop showing 'save' for
>     -    stash by default, 2018-04-20). We don't have to do anything special with
>     -    the exclude (3rd) argument to __git_resolve_builtins, though, because
>     -    save is already marked PARSE_OPT_NOCOMPLETE.
>     +    stash by default, 2018-04-20). One might think we need to give "save" to
>     +    __git_resolve_builtins' 3rd exclude argument to prevent it from
>     +    showing up, but we don't: "save" is already marked PARSE_OPT_NOCOMPLETE.
>     +
>     +    †We don't complete the "save" subcommand unless at least "sa" has been
>     +    typed, but we do complete its options if explicitly typed. With this
>     +    change, we will complete "save" if GIT_COMPLETION_SHOW_ALL=1.

Good.

> 5:  d1d0bf2d9a ! 5:  0266646fb4 completion: drop "stash save" completion altogether
>     @@ Commit message
>          further documentation suggesting to use it.
>      
>          Since we recommend push instead, stop completing for "save" and remove a
>     -    special case in completion code.
>     +    special case in completion code. It still appears for "git stash <tab>"
>     +    when GIT_COMPLETION_SHOW_ALL=1, and when typed explicitly we still
>     +    complete options for
>     +
>     +        git stash save --<tab>
>     +
>     +    which is helpful for folks with finger-memory for save.

Agreed, documenting the status quo feels reasonable to me.

So overall I'm happy with this v2, thanks!

Patrick
