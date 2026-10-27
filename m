Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134425;
	b=AYeHUPw4Sh/TDIyVAfGTpDTxYsMJ2VUqyxVTeCa1BcExLFD37M5Xx/Gh07XfbQREm29F
	 WzyvfvXQS/KMDNQMWNB4mv+qeRkOPCR9NvJx8qI7uhuZEtT81mexl1kI2WB0vpXkVjH61
	 cYhV5XuI/L7F7CYZBdfvejy6pRNjHhnkUf6uvFNGO3Q6E4rtyOcIlOJ6ZpjA6vetbdrBL
	 tfSf2zo7eowZS2JJKKTYCHXcSE9qI34af91gSzZOPdKSTeZJ0GrdDRE+zJHPqoC1eHtzH
	 Sj9FUqKXsGKxZteTNLA3WCiCdbReQiTHW2ps559N6AN78nNdAAFjZlE8GaJld8q/9AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134425;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=JjWwIsLsF+YKKBB7w1QZ1TyeXqCC/fe5TiEAbbC9x18=;
	b=kGF83ywBA0wb2j7gj+I0TQhv+6EONmupNAqD+M5OCeQZIqkOnZUaAdYOfmOHAGdboCV5
	 pu9bKWcQ0GGNAzQ6RZokErvNtY2mlw2XH98s1qOQLrTGhh/p0P52gOQFi9sAKEpFPz+ej
	 Mw3DAkeFPOzDIz+VFXf38XZ8dBXyVzw/Q/wnMIzRez2d039gfXf6XvNiYNhUVKO8MoDTs
	 jVfb90jsz7kTqDQVmotV63VoteBHd3261xuqS+ovsampzIhQc8fl4sR/Ez9EVpS2D7KrZ
	 yYvCTrIFMKQPgKgEuvz06dIwfm5JgFQCD6yeu8pO3LL/oJ8aZPk4QsA8siQn/YYmYRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="VIe/pFbu";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZciAAJpN;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB5606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAB5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=VIe/pFbu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZciAAJpN
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FE7F7A00F5
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:53:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 16:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793134424; x=1793220824; bh=JjWwIsLsF+
	YKKBB7w1QZ1TyeXqCC/fe5TiEAbbC9x18=; b=VIe/pFbueZynbcvHFSKbKWtbkq
	Efi5BUmoVAotWZH98XnRExhSdM6xXa+94y6yEmHsppGf9yeqHDsuboedvrumhUef
	4WeShru0qA9XyW5nnvSXvzMtQy+bkSgCxmMsyPvh3RK/8tCDa89vp4eRcUMRZ97f
	oRVwYd8/1qiOMeoLuiOrfYIP2NIG0ScEgZMrwHuvg2aFuIj6UHzTrSbUTNwX6Hoc
	xdhAKP1e9qjXdV9IRgqYcs7SLnmFSf/US6JQ80zhGkIhPC+pmNRt+Sv7dQlxwpLK
	mwFfjn8CjQCZDB3VyX4pn4KeaXyr1bcVIXHTOpSVbnV1MrM4CFJQzzMW9d9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793134424; x=1793220824; bh=JjWwIsLsF+YKKBB7w1QZ1TyeXqCC/fe5TiE
	AbbC9x18=; b=ZciAAJpNYQrkuwUAwLG0RKP3rLB+CKIxJ2wM+LtJTEeGxlj+sOQ
	g4LD1rQsips4fnbQrABQb+4iiSSEL2uJ+lW2rDp4Aj0p2yJCAoqv9wJmZULacp8p
	rm4YTIqMcPgGoO8IIbLgLKrVqvbooud72WTeLrgUpTDjBALVAGpgtilDxNF5Jq8g
	wsl51rzo9zG+sYpaJvA9JAQ056Rw1TtsA58bviCRJoS5B1+Z1dAGNo74kgP6HSZE
	d9synm20NoeXvcf9s1cAwhvnEqbm0gHQWdatbAZ4huDPNulMbL6oHOpzK88jThPp
	EUfwFKk+hB8XZd8b6G5JGGrQUyqWNpXASQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793134424; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RK/ELBzFnWSqpKswCrkH16+ZbmO2bDIMdIrn/e0c+xzkX2T
	Ee08YBL+fuJVfTYy277vF1GgSd/Y2129Fa/bGYf1dccpsR1ImIkrNvLO2TiX4+v/
	/ncqj/+mVEqpNMcZfYTLoa5yUky8bj/UOD2y0uUO4M/UlKCTkmqlVWwPj7fIl6TH
	I8Y6YGcjTp6153PRwJzSVZfAuIi+GbL1vqyjlxXM5pm7jhnI3I3eMZB9a+5qfpCw
	rHbKcjNnAg79KYCv2/pxty8FR8OstNmfvbE7vdA8xPZ28O4n1dW4sK7388WNXGBO
	5sINHxOlK6eOu5z5rb5zkCK+KVzb+HxnihnzWyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:08FFldVonVNqMtpqbnc0Wh2o9o9vay3njSqHOSH6N2s=:OBpR8HfJzUd8lTT2OMigJW0mlgvwTXqrpxbM/KBLVNc=;
X-ME-Sender: <xms:WA_halzX0M7Sj9HQIW8f-pxRXOIEz8Ee1FXXVfoesaFoX9KCziMybw>
    <xme:WA_hastRCrOEg90LZgBHCIYh80cYXxc_0drrHwQUfdwUrrLpE9qkxXGiYiIbBsfsc
    0WfScuUNJsBCZMiUafTKL9vdWC7juqsha-fXmgEPROlRzSqy1_7X1Ns>
X-ME-Received: <xmr:WA_hass9gya95fDJSS3g2Hu-JWuArPoFpDXwUpwxIg80mtwZlbBYs5k1_NF_jLv454dtCKeZUAAb6awB0nNlX_NFYcWRtwk6TWNX>
X-ME-Proxy-Cause: dmFkZTEBG3st0yF4rot0qGGfKh0dgnOJXdiqd+EAagqK07DatI89n0WvmcJYCgt7TEZrAx
    Vg1mfknile0OeA6KHiYzLPxmCTMqgS2D2aWsvo/4yrjEUjMOhIZdkDiF5aYbUBRUnlV7NG
    lb/skh6o5p5Z6h5tc7XFJAlcpdCbss5VPcjPJXOKNj1SOJdrpOexZ8EHfCHs9fY5QszNBf
    wpYz2r/6jIOZEOR8LpMbROdA7CnlG21tDEjBrXsXO4YZkJ4T2nxqdaD4c8T9Jr8qYIIltY
    nHJo5FggmCJMERsub+i01FLCQssOtNkr8sbz7akFrNz8oeA8lwnpzgz7mTXFek5ALmdHO4
    /PAHs5eZqqVTaW47eclbaiHlvoe8/Ple9xY5wJL15EmXZekCuCkQMBxC0FNz6HXuyVcp7H
    2FgaVkSIxyQ8/inA3s94bZcCa6QvVXlLuhfJbvUcZbqw7w21Zi2qMAxOOzEK4U16AkYg+K
    qRpHQTrJ+P9j0In25b0sJ4XgPLdCJFDpAgcaE5B+/MbM/ePgBLlh8qYT3xqfpuKmHvsLMT
    hl3MI8LeO7fZ89ySFYdUg+DSYQvkIFMpDL7hDNvtkItqG6b7CtRKD8Wwq0/+FW4XWuy2wd
    ja8ubL7o0coe5MbKos5T5mZyU150qHpRmKBPg3fAtUnHcTzwH27j3vSaOvtA
X-ME-Proxy: <xmx:WA_hahM1VDm_huarJ1dZi6ftd_iwRJp6GbbSVSjrkRb-6C0kjMhLnA>
    <xmx:WA_haq0mb-JWWM67srmubdzQ0Ncj4teLSpUTf-nkPgywtvCyW4romw>
    <xmx:WA_hatNmIP425HeYb2oCcgXYMDOe-uJAP8L7NmFV_wFqc3V97C5n-Q>
    <xmx:WA_haq1jhIKt2U08OQlGYT-b7GJOoMu6J36hbRlQBwDfxFk3lHeDyQ>
    <xmx:WA_hassH-bOMgaQHVySJ1chb2NqEtQheBEi08C9z7Qn7lwLBMHwneLXh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 16:53:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] cat-file: make remote-object-info request in
 batches
In-Reply-To: <DMFWYZSCTM1C.ZM3OE2DGCMPC@gmail.com> (Pablo Sabater's message of
	"Tue, 27 Oct 2026 20:47:32 +0000")
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
	<xmqqld7jj6u5.fsf@gitster.g> <DMFWYZSCTM1C.ZM3OE2DGCMPC@gmail.com>
Date: Tue, 27 Oct 2026 13:53:42 -0700
Message-ID: <xmqq8q3ij25l.fsf@gitster.g>
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

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> Sorry for the brainstorm but I just realised that any client could
> modify the size and that a cap on the server side could be important.

No need to be sorry.  A major role of review comments is to help us
think how we can improve the system, including but not necessarily
limited to the changes proposed by the reviewed topic.
