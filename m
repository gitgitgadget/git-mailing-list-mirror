Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140516;
	b=yW6txVNgtOVxxzriTDf8nGyCnDgH3XSyYQ2xOUGsYWKwsi2SfQHFXpFnpPsFb8Imefm+
	 +OJ53S09oqGlxl5xHNQAntjxDqd+Pdv8Nj4LCLzX67Hmo1Xv8wX9RZ+19bLpooP/hl9qb
	 zO9KTEM0uZ/XmqRsJPw9qDwGUvt+OTOKlJCgbw8CNM63ZLM3QrQcjDKSOkBNqlsgWFCT8
	 /DI1e9nnb4KKHUE/QGWT5rqBdWtMQ7XSKsh8uaquJTv5ZL/1v8TaYQa8NBg8rrjLJ6gvL
	 USe7s25viMUDhmwgTK1tENT9RzGdOM8x/cmgki11OItM7kJLEtx3EYwLhG/5Y4KmoYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140516;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=gS54ZrUe3+6cTMcuuXfG+OAu3HWdArfuPKsZ5zQC9k4=;
	b=g9XkdxwUUlgNvojdwfxDr7eM/EowGbqPdtIatEqbggk6F5SmzG1Nxg3iNMEvpWr3IJRC
	 3UgjvX+mbzbSewkDTOSakiygXQmBkSkWTzbtF0kQ008AoqXSFmuSCCdODhV6zHQrxoJk9
	 eWmSGZ+TVcsh29yDTSPP4bsE8N1pf3eaeZ37BNOPWcXOGjz2FREfpsGom1rPAZjdLSrPw
	 biu1C0azv50lIQIiTbL7ztRSW0aGtrFtar2CEJVYIgVYjdmDhFkv6VUUupbxvTxk8E9sl
	 3u+6OBkmGwAuSAWHIyJIpEp1yYHc4/6dFlz+zps6aRCyVkKlZd+d1ftl4YWGPdDD9lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=diGVk8w4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Zfv0VzNC;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E44606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 22:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E44606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=diGVk8w4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Zfv0VzNC
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEA911400096
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:35:14 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 18:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793140514;
	 x=1793226914; bh=gS54ZrUe3+6cTMcuuXfG+OAu3HWdArfuPKsZ5zQC9k4=; b=
	diGVk8w4ea7cPqUh7i8TF/8cGpv6RW634OfP8iYdQafnwSbKr4byjsieANtWeVQJ
	V2EJWTvrwYIqCiQLH+CYqOmW997s+d8V+GVLGxB+PLrjGrg9K5VtKjGXY6smjjKU
	cVuZhSXmrVGxepVQF4HxOevjGivKb9WL2n40rHsqPphwLWysroRam3cXRRMI+68+
	EobjGWuyiGWHnZ0aQTryYxSWiInSlvO4rwFCNhjckDJw+XA+08LyhU87WlaA+Gvs
	Qa3m+qflsDpvzAFS7AjtWkes+8mBVsM7YbxzoAjr3sCg2CiQByB9cGoVJ6M8PgFK
	HCC5DIrD8ciq0A6GF9ZfGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793140514; x=
	1793226914; bh=gS54ZrUe3+6cTMcuuXfG+OAu3HWdArfuPKsZ5zQC9k4=; b=Z
	fv0VzNCuMZHdU7rji6Gboy0JqZ3yx6T+gx6bEjlDWx309UQ+06MBcieOQk8O5XKt
	lCF8nQpV72alz7LjAGAI2TIk8inJic0xnrJ6lHn0phIwjp3DR8mKt1HNGZbdQiMN
	pozSsfaNhBaXiv4QYTt1b14qeARpIlD3Ug89DX6AY+VX1x3gK3Jgjyuc6TO6tn/E
	+U9UpJM316XB8T3N2fsbktcTQuJrVOS/dgf73BqfUdqO5K63mGDT4G87zvPxPaml
	zS1JdGQ0kL7AgDCRIJm7SxGX90bxIIKIZxVxTfKyYAsquvZqVp6itsWnkxAChfpc
	KOu0vlFiswB7z1jJxwgTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793140514; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Coul6SNxkotB6nsLmMr85PRMtIxH5BPRd6LsWhPDnGsx3QX
	r3ZD3HD2+n2RgYhNN+lrc6n0NQL+IdPp5hUA0AO1GTdjmzOyInQZywrNCoW+uDGI
	DoJ3YU2wAH5k1zaKv1QyJCNcChZcrIbfMRPAbWkL0tMQhbeA/8lYQhtD/PlT3Ecj
	rVp5Uqluo7JqQ96BahMMJiOr7+8Vaxu5q+YlOVyOgRAYEZKLT/YEV0DaHRxyGelh
	GnMuoNsA+hddzf1SvrTJ9XthMHEV+GeKZk867H5MghI5EqoiKO1m42Q7SrLcNbLq
	6KRWCQwUcMBdUyo9BCvAoqB+yqB02OAK5+sgxHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:j6cHss00JrGg7nTfKm8ROQH2gG8cnpQBbXU27DDpGPY=:aFSdjcs71XLP5BbmoyuFwZars1+V5DsxU19bkGsriW8=;
X-ME-Sender: <xms:Iifhanu69AJaXVCNAvyrLdfqU9mAgHYcFylNIorKy4RGrhpZDsWY0Q>
    <xme:IifhajS8sJC3PZ526DHUjyxftkJKzdLAUjBu8-1yG42R_S8pNN5hKnYEdkmYlmLIx
    5kdqo6-SDq4CHtPcpneC-vEfqu2pjjX649MzyR4x04m-fmN-d6kOtJE>
X-ME-Proxy-Cause: dmFkZTE5umLco4eGDVLCqRNu7uIkTbvsX3cX7xz3nZUn4ujbUXV1dMzFe9LmFPbRXv79t9
    hGclPW5CU/4UDO7w9y3rpxYIIO9vPJCAnO+Pa5e4Gj2rB+weosSSeYNrK+72csJ3yCRjEV
    tQGzoP7s2USKG4G5ptHcTm7zT7y/g8+yyYGgp3pu1j8OZwcrTxZ9SnUWRdSkKJhsDkL21H
    6wAlXIoKT4oczYh1hpbayxLf5Nuz/rsngIcnXylxzXGR/HxMW4ZM/uiq4zTYNwIJ0wy/Ko
    aVucOhF2HN8/VF/ZHlwK5wUx/vq36tUgsBpNTAHSNcp9k0VbHyPGlHRiQ1gEIwBBK9Pal0
    wH+2pVR8wUORO68zFH5lyoRPeahFjUmY8jUI+bgCl/wZp8tmTpD8URQqDr5CAjvozqFun+
    uijDyt33m6vtxgZi9WThjJxphKfRL4+1cwA9fLhD/x/0/M/b/0XSqCLXGL9W8gyZhPSBjB
    Wh95X5fMUQUquAIePNqS6J8dimcucbAaAb3xWa9XeXnidsAYA1hTbAQ3aqypDqd9Ae60At
    kGIct4Irh5fIkktRbJY4U0sST+ETslH+DFwel8aOaOYQrX27zCkPrpHHFSbkHiqWsDswWa
    Q2N2VN0xnPhnQ+AqrvbJ3NfHXvccQ8cAnehSR2tk37TFIwB5O7zojp4Ng2zg
X-ME-Proxy: <xmx:IifhakT8FidTqjAYgDaVXu1m0B2VWVm8cBiQc8oCGmvRLexj3HUi1Q>
    <xmx:IifhajSrv1fc7FsGYe_ASYtw_olgW3Zpr1B10NtdNUj9gj3xwpu7oA>
    <xmx:Iifhah5acrGK5aieN6Omp8XCNIN_h2H5Q6wyhKPHePEB5_26VeqxyQ>
    <xmx:Iifhan2sS2Z2hrYujRuDWSUr1lerX6n2xEDeOVyamcvEMtduglZpDg>
    <xmx:IifhaplcCXbBPBBldXTWPv9g6xlnYANSe_bk32Ri0Azwi66cA2-vXkRc>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A59E4782738; Tue, 27 Oct 2026 18:35:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A-mM4CllUbeJ
Date: Tue, 27 Oct 2026 18:34:54 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>
Message-Id: <fbe5442b-6f01-4a23-8282-6a940b89da43@app.fastmail.com>
In-Reply-To: <xmqqh5i7j6km.fsf@gitster.g>
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
 <E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com> <xmqqh5i7kpc0.fsf@gitster.g>
 <CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
 <xmqqh5i7j6km.fsf@gitster.g>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 27, 2026, at 3:18 PM, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>> I can't speak for Julia, but I read her attempt here to clarify things
>> in line with the ways folks usually use "ID" vs. "name." Of course we
>> don't always want to let what other people say dictate our
>> terminology, but in cases where we can make things easier for folks to
>> understand by using vocabulary in line with their expectations rather
>> than subverting it, I think that's a worthy goal.
>
> That goes both ways.  You can tell that to those who are subverting
> terminology that have clearly been documented for the past 20 years
> in our official glossary ;-).

I'll only say that I genuinely thought this might be a fairly
uncontroversial change. Obviously I was wrong about that :)

I'll drop this.

- Julia
