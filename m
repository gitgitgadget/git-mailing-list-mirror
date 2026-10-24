Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807332;
	b=PxuSgueswJ4CewPWYagpI6t4rgE7dtsdPujKnGfZUQm51Xh+BNHWF52aYJdekzsrMAbu
	 /xpDvtEbnV/AGfKSFgHrRML5L20sNWy+ifoaiFynAKQ40muvmw5cj3h6IoIKjKqUUHnTz
	 /P/bjpsDkL9KlUTopjjxkrO3XR+i+mY+zACAF/N6rflcxKyt5mAD9NYTvr8QsZ0qiu4nM
	 2/tXidWdqtu5FCe3B/+hl9NpDOPr7yJDzPix1a33661dYVxB0qiC3UGkAYC9wQ35RxIKc
	 EavNyak7qmzY9JZfdIS/6I49RwVFtTLRt759AKoxbrMRWyQcdMyd5LMiZvBJ2TLvElw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807332;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=W6fG5JTxgyo5gGp3NJXL+teHqO2AakXtO4Zc6ozjIDY=;
	b=MMiyNfNEqkvANgQuJ3e3Y2S4R36u4JhWxZVDy8RuhQP0fnxmTTTJspo4eueZHUMACtkz
	 Br9M7oU1oSHSPgQ3JNQDgb/SMf0Cdk8PMRLADStsVlFkolYS/aK+gVDhtDuiTnAgcNdtX
	 L15uiyAzTPh1bl/Ta7ElqisO4xp0iwIdmUMKXFhaCubHrRc1r7REVOhM1hHRDduCORpn0
	 dq09MFR6YK7ZKsQLbMZ4kJlqgVf3gSbaxTxDZhwPqClKCuOntg9BFgsC9mfpPQzI3PYlq
	 CgGI6p3406hOyBOJ2NYxx15AJfLXYrr3TWbvU1s28oK8VKBKEkq4fUZfVsJf5bEqSlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=D60K2sZo;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=P1VMW88x;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EDE606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 02:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74EDE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=D60K2sZo;
	dkim=temperror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=P1VMW88x
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DBAE140009C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:02:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 23 Oct 2026 22:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792807330; x=1792893730; bh=W6fG5JTxgy
	o5gGp3NJXL+teHqO2AakXtO4Zc6ozjIDY=; b=D60K2sZocLDmK5qpjcEEX/UT/E
	aEsgDEYCtVKyki8OYmu4wqWQ8DCBevDnN348i2roHbmdfPcoOoNGgeNHehbNmf4W
	z2ZM+/wVZUFEFIaXieV7t1nI88GZ+Uo4Hlr7AXOciOcT98eViFSPs3Mozo/pkhcD
	+080smWwFRGhBD1ZH9qjZzKqrFX+ODJdh6ueITGfECVMeKILid6honagwYRKjOLe
	3U5QH4meGK88GRHgJwEXgMHMmKoZL/qhLyzBlwm8XCaa/GAPsr6NbtkwaKbgoG64
	1hW8N0HQ8TyXBDxXKk6sbrer8N2+OMQ3sgOw5RVjL7lim90rMqrwBT7q9Bxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792807330; x=1792893730; bh=W6fG5JTxgyo5gGp3NJXL+teHqO2AakXtO4Z
	c6ozjIDY=; b=P1VMW88xPtI1YZQxvalgq3aNIiTBMcRQLPeISXfen68ESDtz/54
	peAw/TU09roHAsuM14IPEE/Rc79AnfJo0kWBQ686rnkOeKyMnTAEofxedCWQxt2h
	6KZ6ZieUZTUjNX6LUsNnBYPfwfyPGwEowzLMXgNdGdzU7+itMnC/S87wmzuzKQJh
	k1jkTP98RF/xI3OyLQIbyvmq0HW9l9auDms8IUEXzyGp6wu1Mz5V9YYZVSDE7sMk
	ARLREUS9Z3+98EL2mpzLpyqFGLXIkZZ6WUFHRDDUMiOxvP/zKKKU1zU+t2y4HcfE
	5qxtq42ncBi0nroN+7aOkGkoGRzMnJvu8YA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792807330; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TvoMk/mikUOjgfe1fLwEALwmucHweeM3HO0GnFTbHIVT6aa
	HYIkJ3G/QoV2RmHo6ye7oEIJjoIWRHaXvtAaEpuKRgVLTwR+Z1taT/yEXXhEA0VL
	+wnOaEZShtmF92PhK/z++P21CsZTFH4LXW51hPbKFueGRxwlRkaFiXDT9MaoeUlo
	5s3dxQa8pknsQO4tX+fWT1PJNmySQObQ/FZ+TFOWkew92lw3+1jWPOddCQskhkoh
	zbezjsl9vCyRjobvaPNOhKUOioj6+j84Jn4PeFgifI9VJpEKmJfKcaN4tMAsG42a
	sYKyhbzS1P0g38AZRKgQUp3FxaHHmddy8RK6fEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:H8LIE2d+/fSll1ZxV/Seo4GbVFHINDrMRU9zo6Ch3tk=:ndB1dtr2LHVkh2o8SYHL1rZDkBpdDOLJ3wxuiUKRJXU=;
X-ME-Sender: <xms:ohHcaosEgmYyEsxmppv4xeasucnlpmzYgn1ftvKSqF-rlsX7cthKZw>
    <xme:ohHcas7IZuHuBfh-KFnr3yLsaft3QsGCH1Qibio5_l3dRnTFT1JUZQOcTP7gj1imG
    m_tA4tJfy66tGWo4ayXvCLjdpukqgp7QpLfhxxEsvvyKzuV1UQguw>
X-ME-Received: <xmr:ohHcahKckkfX8FAt-hcqQudlrKdvr4vpWDzuokd8DDIuwPxdwrtL7NRfYT0aBSrknAPxxK-N2ljYg6-IZap0CDXUhUtf0S6AqpIL>
X-ME-Proxy-Cause: dmFkZTEeXhpkEE9kTJff+hNbzUAjUswsfaTbkiXlXNC4kW3DbkHYcDzoy2NUflPeuZtuMs
    TZ3mCabX4LHtlmEM8SsSVA4tRe9MXeOHjply/gwTG3osV00GYCHxKPx3p6MxcnNp8YAbbI
    KcM7extPtrx/hMk5bpXOs0OW8Zi56z9VotFeHs7xQ2iOKd4gO8gjcxIg/GEMypPwIhvpJu
    hgMRu31Uw8SJdOZjlnCrI6LXOUQU9L+MU7+BnOy03DZwuWgMkXbCYiX6rqZc3oMa+a8XY1
    MYH2+3IkTAY0W2IIAyacfzTA+TtXmmpXt0wSTgAglXNhE7VnPdN6YEbtfVZGFwmydvurJs
    Xl/G4DXUd7Xhn2qj0Zddv1AJO6JC5BR6bTDk6ijrAnI7SWVHtCadA3ifyW1aLR1czKcT/Y
    cc4roT1FYipDDdT4knpWGzsZGPrjGYk3i23hkc1bNB4IQ4nAmg5nPTJkjNn16onMP4zWa4
    vWRkcM+oZeOg39SeU5tsFgAuTepPTqpPoMhuwJjUXxo5eWChhcmprF0ymZJYCIzUcZp5jl
    4kBBJyvmIHf+99OYvixXWlyAkvVp4s69njpp53buPQRBpWf1C4nQsvMx5IE6Yqk8UzMLLj
    5JIauHxWA8WtlArvyXg3sk7NCCWsTH/qy76p2h8CBT1wmh3EIUFSulKw2bng
X-ME-Proxy: <xmx:ohHcak4jB5cjTG-7FIT_sULpZNVqmZcMo2FcAtDgR9jmdQ5_aWewyw>
    <xmx:ohHcasyXC1Kuo5xM2FxuY07JW86zu3K4jcIUWU6UXbg70KNo5ZsgyQ>
    <xmx:ohHcagZr8juMt906JGqCSGdvh4Et6zI-LLJ2Qi9nBJkW1C5-e0vJPA>
    <xmx:ohHcamT_uZ3Jqr47k-tX_gm5qdCe0qK1Ny6kjU2udlIQFR9ptc3OTw>
    <xmx:ohHcao5ADMcf73F9IJaLFShwthwULIul04eLquDtcpPz2MHo_BJjWOlI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 22:02:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] object-name: use Q_() for the reflog entry count
In-Reply-To: <xmqq4ieb3mnu.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	23 Oct 2026 18:36:05 -0700")
References: <20261023133118.456-1-aniketgupta3001@gmail.com>
	<xmqq4ieb3mnu.fsf@gitster.g>
Date: Fri, 23 Oct 2026 19:02:08 -0700
Message-ID: <xmqqv76r26vz.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> not ok 13 - invalid @{n} reference
> #	
> #		test_must_fail git rev-parse main@{99999} >output 2>error &&
> #		test_must_be_empty output &&
> #		test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
> #		test_must_fail git rev-parse --verify main@{99999} >output 2>error &&
> #		test_must_be_empty output &&
> #		test_grep "log for [^ ]* only has [0-9][0-9]* entries" error
> #	
> 1..13
>
> It could be that t1506 is the only one that needs adjusting.
>
> $ git grep -n -e 'only has.*entries' -- :/t
> t/t1400-update-ref.sh:471:	echo "fatal: log for ${SQ}main${SQ} only has 2 entries" >expect &&
> t/t1506-rev-parse-diagnosis.sh:145:	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
> t/t1506-rev-parse-diagnosis.sh:148:	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error

The fix may look like this.  With the extra commit disabled, the
reflog has only 1 entry and "entries" no longer match (hence the
pattern truncated to "entr"), and if you remove the leading ':'
colon, the extra commit will grow the reflog by one entry, so the
message will use the "entries" form.  As you have added a new test
to cover both singular and plural elsewhere, we may not have to make
this test so thorough, so if you are going to take it, I'd recommend
removing the extra commit.

 t/t1506-rev-parse-diagnosis.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git c/t/t1506-rev-parse-diagnosis.sh w/t/t1506-rev-parse-diagnosis.sh
index 722884e65f..e4dade392e 100755
--- c/t/t1506-rev-parse-diagnosis.sh
+++ w/t/t1506-rev-parse-diagnosis.sh
@@ -140,12 +140,13 @@ test_expect_success 'incorrect file in :path and :N:path' '
 '
 
 test_expect_success 'invalid @{n} reference' '
+	: git commit --allow-empty -m 'void' &&
 	test_must_fail git rev-parse main@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
+	test_grep "log for [^ ]* only has [1-9][0-9]* entr" error &&
 	test_must_fail git rev-parse --verify main@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error
+	test_grep "log for [^ ]* only has [1-9][0-9]* entr" error
 '
 
 test_expect_success 'relative path not found' '
