Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530246;
	b=OE+SXWD2x3+ukRYrkstbpCkngbYQo9Dto4fqhaNPZhdGupDACCEQ9WkQLpDNm0Dr8Tmm
	 nytykCiq7xD0uBAAFP6Fhv6UlkPhy/AdjVak8+czspJFalUAvpmc2BDaZiCqShiouirgb
	 rUtnTTrg4C93ddJINzUrXr0AV3PdNJwwfP9HTIE8HYGxhSXPnmSSi5e7uTJsoskQF2SIG
	 E/TedW35JElMeRb7GA+BaMLUV+bXdaK4JGXu7WmcgukjjO+CrYmbrTw5VYmEmOmGb5O6d
	 e90vcF/57Tp7Go2X5s1Cb7VtwQHvddUdjBf9l/B0Dl/MTer05ppK513OLrykNRsanYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530246;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dM5cRRRtP1D+CxCjW626hMy1Cg7bAyMbNN6txxs/kzk=;
	b=nV2i8UgFdYx6AMQN1wsdASRTI+hR9yBmjuH1GNgkwCvx0CTDD9sOzwwHdxKqEA9OQujJ
	 mUblaVCv5PhFcQpz77p7lRT004iVOGf5PDhoDyBmre4Op/X2ugghkfGDVtZhL5ns9VpLh
	 GQgHqY7HFlI3m21uSwkITDBmssD4V+vpoyzUu4CnNL5Rkv4gW/z0sNYiWJv6JCVlk1E7d
	 ChU8yRgbQKLXBEYME5IeafCNC4OexAQ9nFrSt3PuvkPov9wHpTzl4068W9Fq/ygpppnrS
	 5M5yubDJGD/H1bemJhdYmAOQFTP48l+G4oW9PWnHQSmg3uwaedhqc89GUp38RO6paiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LMLCywiD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=30LQrPx3;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC93606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC93606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LMLCywiD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=30LQrPx3
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FF3CEC0AF4
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:24:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 09:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795530245; x=1795616645; bh=dM5cRRRtP1
	D+CxCjW626hMy1Cg7bAyMbNN6txxs/kzk=; b=LMLCywiDszDs+LJnQEarpwlIkv
	vMcLz9l18L1e+0fTuJvQHQAKW8fHbAZNrABCgNZ2AQ8Odu4T2ryPQc87CYonLMaZ
	U3+UUocOLrQ5h/ddZ+BzzQIsWDA9z/jf2e/Ay2jC4dJ5J/P6c8urTWfGsO/KFQHh
	m8yOgLj+84h6HncYWVEu+k5bMVzwtjhgHtOh4QHfAoAYm1CUItHCL4qWsXnN67wy
	qkmqgInomYXpxMWOPcfvxlPkcZrGoh2/Kbvo2SiT1UbN+e9cj0gvxl9xg7AmGQLn
	PONq4NtPNmTvAVeqS9HajyqXoj8vsCZrwfOgvMwzkfN4e/aRs5z3I103ZU6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795530245; x=1795616645; bh=dM5cRRRtP1D+CxCjW626hMy1Cg7bAyMbNN6
	txxs/kzk=; b=30LQrPx3sVxag3YCJmVGHiN2t+5sUaXjC0W84zsaUK94HbMmgb0
	a8c2R/Nd7hlUDe7ws2kussGXJjEEVI/YEi1hjlItrj2i9eyZ6AtXmEafOnrtSPGK
	UQQ8EbpqEZUp9ESndfkfTURyZUDYaMGoFNrABDFI7A6F5ipaPzyLcDwdIF5BrjNb
	gLC5b55smsxQY1Q4HTy6t63X8igKW0cUlBVxuZFPAacoQ0Kk86QaL6iG3E0Elx65
	qGxoeAJ0xcvemxiDLZWG00Mab8mWM8/4zhVL+GZQKPJjE3E2qIF78v8Y8YSAPDXb
	874dGTtydfXkwQyNcTDhvslwAP/KoOkCMdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795530245; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aFgY1XseSCP+pqKZB1c0iMVOER/5Ds1MdIM0Mdu03qQBRbh
	Irtq0RAtm/jiPNZK/H1YVl1oL1YmBNlnkZpC2RLWpW/A5jI9wAycr9iItE/+697v
	61gJWVmBc3XzgZSXLdwvubwBRnT0pohQtEBymVW4lLYQe1jMuTSUmYzBBfCcVtC6
	+FavhivUjwTeu5SiOf7bNXylYIOhEQWORXJYCzPiwEtcwaYqyp6N3dCa5nIaDnL/
	lQ6EVVnf+LwAIiheolBYBjfq3TNYF9TWnb7yppqKs0BDihxFFIyEPrW99bXDFwtA
	yeHNE4YmExtxGLhmlA7x6pnPnUcke15/ZfjVR+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oDHd6uYt+A1BFcq73b1AKj+w70tnXKE6BeaGtrKYLHI=:hujp0S01LyJHyWaCeQ05C3ZBgyHnExbyjesrEmFpzRQ=;
X-ME-Sender: <xms:BJ4FazCqSPPyicgJcewixZPPbhcur2EXY8nmYzuTYDfsHCaJxjwmTQ>
    <xme:BJ4Fa4mRgPG9TMfDZ7WVNUhjElw-fRWjhqClccU--s8Zq0Urh4j7TzgYgCSUo0cDZ
    a4Bh11ZdRpyMKN0-Ma0zjk67mK2-lqwVC_PXUabUx68LivM34eU28c>
X-ME-Received: <xmr:BJ4Fa0zLV-K1Nzm3CulvJqOGy0VW8OWPdERiXq_JqnIvjMKDktQVRP7WL4CWHZgbiF-D8FRANdrtzk6xeYR9Py_3QJksLAhSwVmV2UE>
X-ME-Proxy-Cause: dmFkZTEg4/Nwtqp7q9boRe6jcIQkJaZb35s8CqHMkSt3o/jeQF3DFib0+RppaJ1pT2gJvn
    F3DYDqem6TqVoTVO20AHWaomtrYYP0O0zAbammHp1VsALSGhBTXOyLY8q46SVF79pqj4+c
    w90sybDn7/NFsFxyvQVyoc0RQd3FwE8eX6GjBKwMH/Ryve4+2RkSvrLYSjJIUgMJN2yLEE
    4/1ND2PX4VcMINdypLb6EE4JBht4QfSvsSHDYTLi+6cF7bwgMHXa71fk0/39NmdhBRzMua
    /gHIJgDhrNSbWCUH7G4CH7mG9uf03YTi70zO3BFjBBTC4OKZz1QEtQe9IzaDcn/zkbTzDJ
    QoVP60zlIJk7ou04gQ4sPVrPAoeL2PNGusN3sKLPMDJlaXRFkqZfIuOGvW0DoHKJQzpZqz
    FvnXqNwc8h933itV6SbPrtSR7QSe1It1oIS6925QC+SFtQxjesddDL9AMNjL+XLCoaYckz
    NLX/tZsFdLQxdqk+tNsTljI7YTybIi57WVCSlc7OlOgC4TCqRdaahyNklDnbQ39DeXU3VY
    J1oEZV/Wp+83RrSGKUWh174aCAmY4JDSC0tw5/FGTH/Z1SbcY1cyhyFQjhJAGUDvtRPFIm
    MJuthcM9zSEaCQv47YaN2riI9I/8rqtcwIVWu8VwclZbs06bp/58HnpVHX4Q
X-ME-Proxy: <xmx:BJ4FayT1AAcsi8w53Gdp7em_7DTvUzBdXtm1CkPslYMQxHUKDiQNNw>
    <xmx:BJ4Fa89GFTXuu8vhc50LqzSJqFibwCGx_UTsPPGZdSQBu69lVPrNNg>
    <xmx:BJ4FawseOWGFre5Bo8hU9qK8C6TLVnlwNSmM5l1dGSpvcATgOFOs5A>
    <xmx:BJ4Fa0P9NnVyaRRuU9wle33IJLmyqHNBJ7y-5Z7sweHLU18PVrP7NA>
    <xmx:BZ4Fa6ukXfwtUGjGbbfLaATJOIQ2etUYlZu-dxEtsAQFfE21hwZJ5Qm->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 09:24:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Harald Nordgren <haraldnordgren@gmail.com>,
  Simon Richter <Simon.Richter@hogyros.de>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] wrapper: add read_in_full_or_error()
In-Reply-To: <ca30ed613d94ab11348e46ea60bc4f970e2f506c.1795472027.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Mon, 23 Nov 2026
	22:13:45 +0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
	<ca30ed613d94ab11348e46ea60bc4f970e2f506c.1795472027.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 06:24:03 -0800
Message-ID: <xmqqpkvuwbng.fsf@gitster.g>
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

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks.  In this step, I only saw a few minor nits.

> Callers of the `read_in_full()` function want to read all requested
> bytes, or get an error. However, limiting the return value type to
> `ssize_t` is insufficient, as file sizes can easily exceed that type's
> range.
>
> For those callers that do not require the return value to report the
> number of read bytes, add a new function, `read_in_full_or_error()`,
> that returns a Boolean to indicate success or faiure.

It returns an int to indicate success or failure.  It is moral parallel
to returning a Boolean, but the polarity is reversed (0 is success, a
negative is failure, following our usual convention).

> Callers that do need to know that byte count can still call
> `read_in_full()`, but will now error out early if the requested byte
> count exceeds what `ssize_t` can represent.

"error out early" -> "abort to signal a programming error".

read_in_full() aborts with BUG() when the requested byte count exceeds
ssize_t max, instead of erroring out.  We declare that our API contract
is that count passed to read_in_full() must fit in ssize_t, so that any
positive return value from the function reliably means a successful
read, and in such a world, passing overly large count is a programming
error (i.e., the caller must be written to check) and aborting with
BUG() is perfetly fine.  Let's document that design decision here in the
log message.

Looking at the whole working tree after applying this series, all
remaining callers of read_in_full() are small or explicitly bounded
(setup.c, object-file.c, http-backend.c, pkt-line.c, odb/streaming.c).

Except that worktree.c:should_prune_worktree() passes size_t len that is
computed as xsize_t(st.st_size) for a .git gitdir file.  While gitdir
files are tiny in practice, converting it to read_in_full_or_error()
would be consistent with the other st.st_size conversions.

> +/*
> + * Read until count bytes have been read or EOF. On success, store the number
> + * read in out if non-NULL. Return false on an I/O error, with errno set.
> + */
> +static bool read_in_full_1(int fd, void *buf, size_t count, size_t *out)
>  {
>  	char *p = buf;
> -	ssize_t total = 0;
> +	size_t remaining = count;
>  
> -	while (count > 0) {
> -		ssize_t loaded = xread(fd, p, count);
> +	while (remaining) {
> +		ssize_t loaded = xread(fd, p, remaining);
>  		if (loaded < 0)
> -			return -1;
> -		if (loaded == 0)
> -			return total;
> -		count -= loaded;
> +			return false;
> +		if (!loaded)
> +			break;
> +		remaining -= loaded;
>  		p += loaded;
> -		total += loaded;
>  	}
>  
> -	return total;
> +	if (out)
> +		*out = count - remaining;

All two callers of this file-scope static helper passes &total, so this
reporting of the total count can and should be done unconditionally.

> +	return true;
> +}
