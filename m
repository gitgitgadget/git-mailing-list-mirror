Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825575;
	b=At1zNXX7+peSJM11NA/1Jfql/+Xa+ZvrPIyRmY8eOw8z2KW1f2bbSzs2sV9+gfWVT0jS
	 VI0+jbZ18Bh3QYG1EruzCJXQotwIO41YpCenvneiQUofHwfPyAu/r6kZiUTeRam9oAQCY
	 YXZT3TuHobRuC/qnplCxxC++ZlEJOXxUFPaNvBaW9+RyCU2TyanEWbxVmtDzu9tqnHgZu
	 peAJ0PYImb+0uz1EEfZ2w8XDFDPzNXX2mHTqJosa4ZUceREJBgaJqjlkpJoF/lIXMjgCm
	 W70J3i/VO3gGxD14Mbge79/YCyhTY6eFwBxbZKwgvsRd/stVSIiHMafhHBgC9aelsBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825575;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=C+BeUVgh+8IrXFfIaMHtUy/xcV4XUJedXAOyXHUAlvM=;
	b=D+xuSyVtHKtaJF99EZ5txiVyEm2Ra1QIJQwdzaXcblYn7XI2E2HPesK3anbHm9gZ6Jmd
	 tlkCLniZqmyZrr9toYCUIe0D/jzVcQSVrIQ/JcmJ9CRziqRBGdfhrjIYVvjlYcPfCBGxN
	 TWGg+9dPHAFrJ/0pZa2YbaY3ByhxI0z9/Ru8vMPiS9zRIfG2gE3ujovDlMtVT/+0HbBe0
	 gv3Q9/pBvD3xvogCpfRjxrb5UQrudUpSsUNsbGzsRbLX5/AzYTk8BBbhu7679qWPik4Nv
	 3I5oRyTGoBKvxVBUVoPdAGoSEh61Fznginkxeu8+VjW9DcHTku5UjbkB1OxdqRys6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BnAvkPjd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cWLrX0I3;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0F606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 00:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BnAvkPjd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cWLrX0I3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2EC47A04D0
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 19:26:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 27 Nov 2026 19:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795825574; x=1795911974; bh=C+BeUVgh+8
	IrXFfIaMHtUy/xcV4XUJedXAOyXHUAlvM=; b=BnAvkPjdVZm9H2OZFFljEndaB5
	VIVZx0u6VqnCJV54V2xBHeQHlkrN0x9Q+90XVQJVoFjIIHUteichp7P3tIkqLern
	iYniYr2VeTRWL6/E3p2sQy7WqOtTnsB3V378fTWfxWRgeHyTXBS5OS1Cpvi3yF9g
	jnRAG9W3HqFylLy+Mo9LFYsaYdvWXjEooB3NDJvGt6De0PZTk5oeZYnTYA/lOUn1
	bgHzRfajvaBxypQoEnQJQBK3JRwXt9nvQzenVQKTisOQYYYNTs3s8T/zW6KMs1nH
	n4FGYPIIFCILyf76pS9pAmDtGbkOSJnI7eWVu1OXyaCjO4/hfPN7GEQLy6AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795825574; x=1795911974; bh=C+BeUVgh+8IrXFfIaMHtUy/xcV4XUJedXAO
	yXHUAlvM=; b=cWLrX0I3hrWqGBfLeIqnb3C/YRVDIyJ2FFv5exw6y0D6cOVek+Z
	IvKNwaLclivauYEdpZN+lKH7/6TmGfdNGpdHq5SdSChMoqndfTce9u++WuvlksQK
	5Gi2leIKwOLTSZpluNm9rfPG6F4e7lJ8qqSEpSQfsPt7byOW0QJYV4vjKqVav5Pf
	bmDlOOEnfbl9sR6ppjrjlAAA92H1jO8HfASthw5pBufTsCxxnA0ywRskJxJykpiU
	VsF7FMol4LuGpcilIhSS8I4xo74dXmWcy/BuVgX3SRgxCbwrs75mIpB3jfd+mrkU
	kZOfzCsHEOwBAYg7u4tZnYw/qDH2PPjrK2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795825574; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SdwuzW2i55oRUGiyYrbpw4OWk083B1hcWAU5Anog+4fLmbZ
	ddP4AIjNGowBwgz6K4lbt5AYhAn+T9uCuROebmB2msQX2K+AtVk9WpfJYF6wx5vz
	0a1qUCbffwMXncgnv5gr5j2UUimtQ+yz8P59A5FL/Vos1v2UcXjNTO8lr2RcBk9H
	Allzn4rf40CKEgi1YUCQhOH4qVPyReCiFIm3NPm3IKK+T5R4yJHTD88qskrLD7qj
	DmB5ZqBWBGXBTVVVW8e5sADY4Afa/WGuk0Pubftp2ac66ZitiOtcq8Ri2Bj/bKAY
	/CPhEp8rvSU02CZrrygPrrLKwRE5hh8IYC86wJQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:MHfbz/l0YQ3lMmE+MyGTuX5vQDzISgKLdjjWDbc/xOk=:saq3gWckM4mjVEmfvjKK75GaAEtVMqye+8vy5+V030U=;
X-ME-Sender: <xms:ph8Ka3bII6tLTXfRIPVv1SGRAGjHP-kcc0b-bPBK1gf-Gr44-Hg2RQ>
    <xme:ph8Ka6GfjxxW7fI7-Vl4bMyhZKbl1RPx_whYKylGmkEp8NZGKcoSaVHCkBwcOC33_
    mjPriXCNOgPVxMr2LQdcj9fOUhku5ZWeoYz2949nQUkBhtdUTS92a4>
X-ME-Received: <xmr:ph8Kazz4wEENjecyBZmCxr7kmoPrahPcRviisEl9xgaOfwaZl1sGaWr3cRWdZS3Byw8_1Q5mwaHGpMzCvzlKlHqQ5VgBzgtymxlJiRs>
X-ME-Proxy-Cause: dmFkZTGhBq3Vd2JYYm+mvPiE56KCNwLUHwxCFgdJoPaToPxg1r6QrIyo66FrkEMKI1KhX2
    XrnnGS+j9CXVn7yRWs6FrkF1kjb8v65Um07CM1O9+3hd39j0UXwPuesg9WufGV1LwyknmT
    Pq9A33445Swdkv7IPjQ41m5a8GgVpmxiHQ20nKQylYIv6WJsjoIzH/pTtCMLlPFhTIc9gu
    iQ4bKrTi46CjUr6o84ryvoPoJCxYf+b3gvwUHYn0Y3BgGUfkeEXEQVnHMCAUtFyAXOvAr0
    zw8h3qkNIoXnkNJHqZidBfkhP0R9o5V1UK3o7BMFcq5HeI1Db0Cx8lSq1Z6MHQoKv01SP/
    hWcEVB1qDu+9HwwexE3o4yLJhjFq9nqeeZO7oQmSIb6ykslJ6MFdu1KfLhguu4zUUe2X0F
    3gvj7F36H4uFFaEAgOfD/vY4inD6KClEcrehZZLiziUPmkJiETSPfYidlVYzpUd0lGEAYU
    kPYiPa3iAHt6xYpuGaJQlj1KiUA34aedw00kM0kOVWdZAVPt/8VsgsgZkl56E7o+Ed/RxG
    46E9/E5to05NALnCTs9r3WenVe3GUBXAFBnxyzO7SSps2ON79V7oZSMMpTZn4nnuYit1GU
    /7M3frjFC+lKhgl9l7cfint6CNIQi0wIms6WtsXE/+EMLyAX4W6EBiepaFaQ
X-ME-Proxy: <xmx:ph8Ka0kJbSHxUmqlPY9QpuEszlBjD-4MQae34eMSkyRXUwXMey9DsQ>
    <xmx:ph8Ka0lZhnWDNj6Yf4Byx-sHW1H2GB2YlBgaGU_q3HubfoeT-yWwvA>
    <xmx:ph8Ka-y45-qHTlUjtBqsivt5ogSdoJ3hZtut6jCX5oqX9wRebG7ioA>
    <xmx:ph8Kaxo7ZmR_PmGLTsjmCgSiEzAhJbxuj-I94g5hjlL4aOpwSMerCA>
    <xmx:ph8KaxqMgOF-LQ8JsGIlkCC5ReHsEucK1Oa3RyL3AGOx_vLbgLn3hlRK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 19:26:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>,  MD Nahid Hasan Sagor
 <nahidhasan141400@gmail.com>
Subject: Re: [RFC PATCH] quote: make sq_quote_buf_pretty() prettier
In-Reply-To: <ee7de58093c69fbbab686a68b5b781bc60d90a2b.1795798429.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 27 Nov 2026 16:54:27 +0000")
References: <ee7de58093c69fbbab686a68b5b781bc60d90a2b.1795798429.git.phillip.wood@dunelm.org.uk>
Date: Fri, 27 Nov 2026 16:26:12 -0800
Message-ID: <xmqqmrqt3ior.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

I forgot to mention a couple of things.

> ... It also adds unnecessary pairs
> of empty quotes when a string starts or ends with a single quote.

"a single quote or an exclamation point."  We can see the example in the
table you have below, for the entry for 'danger!'.

> +	for (q = p; *q; q++) {
> +		if (need_bs_quote(*q)) {
> +			if (brace)
> +				quote_it = true;
> +			if (quote_it)
> +				strbuf_addch(dst, '\'');
> +			strbuf_add(dst, p, q - p);
> +			p = q + 1;
> +			if (quote_it)
> +				strbuf_addch(dst, '\'');
> +			strbuf_addch(dst, '\\');
> +			strbuf_addch(dst, *q);
> +			if (!brace)
> +				quote_it = false;

When brace > 0, quote_it stays true after emitting the backslash-escaped
character.

If the next character also needs backslash quoting (such as "{a'!b}"),
or if the string ends right there with an unclosed brace (such as "{!",
p == q (i.e., an empty segment) but we emit it in a pair of single
quotes.

> +		} else if (*q == '{') {
> +			brace++;
> +		} else if (*q == '}' && brace) {
> +			brace--;
> +		} else if (!quote_it && needs_sq_quote(*q, brace)) {
> +			quote_it = true;
> +		}
> +	}
> +	if (brace && !quote_it)
> +		quote_it = true; /* Quote unpaired '{' */
> +	if (quote_it)
> +		strbuf_addch(dst, '\'');
> +	strbuf_add(dst, p, q - p);
> +	if (quote_it)
> +		strbuf_addch(dst, '\'');

After the loop, here also is an instance of single quote pair around
potentially an empty segment.  Perhaps a short helper or macro that does
an equivalent of

	if (p < q) {
		if (quote_it)
			strbuf_addch(dst, '\'');
		strbuf_add(dst, p, q - p);
		if (quote_it)
			strbuf_addch(dst, '\'');
	}		

and use it twice (the bs-quote code path needs to be slightly rewritten
if we wanted to share this piece of code that way)?

>  }
>  
>  void sq_quotef(struct strbuf *dst, const char *fmt, ...)
