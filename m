Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991543;
	b=y8A28Nh1If/n9IWZ6mBdiEtuZZ22aCNsoXQHv8OOSgtR8g5Og7YgmKEnoDBMwFOFp0rL
	 JrtfQdm7uofdoeNM4FfnY+V9a3e51rxPhqr8wxdyrpunEuf5cIEHyXLa8/SDgZ2T5um2E
	 rEGBtSyEs35PSp+ZacAq/WhbOQZByeYy3YeaZjhfjXhmrShunGF3fgi9pgpv4j8trt5VJ
	 bWc60IVzZimh10xcjc3OeZWPPNRKNoiH6JCBfcZZkQdlHA6m6OTUWM1n607HeuNzEwVQC
	 1wIfju3naM7nOgi2aUOwtMtdy9+Cov8AMhyrWTppofTTduD7XJVOEY8+UmXZSXse2Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991543;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eCodVTBWTUil6djODZJ0BBHRL1iot35Mzhb/wJh2whY=;
	b=0esxjCDrZLbWWp8ZzG+ILYEr9vYck9mD4wWutjt24IJrMXIuIwz/t0qrQFKv2fAAYoLx
	 nHbE2hRfLt7IL9qzbFNRQsBQxMvoQ8xY8FC3aLv8BexGgaHKYQBY3SKCtDzyzELNFOnwc
	 mBAn8jETST2CNsSHYVUDBx2yRHvQ5EQ1fVFCkivrJJBEEt9jp+UVqy1GxlAJBBC0Qg6F2
	 aS9UIczxx2PReBUbRjh7jV7Kk90cnXUxO70vbBRL+Wk9GAyq254woypMLpaunt2A5jxvB
	 dtAOni9epuF6xKngHeV2PgPZIB2DV0aD+3C7QC0tDYsD+9cLzVemWJjXPsMSKv4QeKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="lxx8/GmA";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dbImt4pw;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3B606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC3B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lxx8/GmA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dbImt4pw
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E3906EC0210
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:59:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 13:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793991541; x=1794077941; bh=eCodVTBWTU
	il6djODZJ0BBHRL1iot35Mzhb/wJh2whY=; b=lxx8/GmA/frHJlGzLzSAY/oIng
	oKpfjpe33Hgt7w1+49UO/ZI3kCBhTuatm4cjORvmZSmkHUMFwcnN8MpY33eEDvTP
	2MkAMnU/WtTZyYf1lboD4y/I4+o/130+3kIsEPyKI35u+BbsoR3s1OhcJvML6oF9
	aYGcrecuv9S4OBxatrnBiAHU0nK49FHBYD5wTdzeZ9kUn98rs5RoGnnE4De/lUuM
	K6fS5RFifA51kflU4G8RfIK3jo9ojIqlnOSSQIrYyEdqfkgkXJ7fucauPzxJ8nc4
	b8NafdTYm+MkYOgsZIeOWc9xoX63LTXoU3Xdiw7OP9d6OqiiWuqZiqzrdMpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793991541; x=1794077941; bh=eCodVTBWTUil6djODZJ0BBHRL1iot35Mzhb
	/wJh2whY=; b=dbImt4pwJLktsI8qm6EHTWiiAS7I7gZyx9ZzhovOmwW0YIGC6N2
	JEJlUpzu22ZwWsIs7PhqWsXZbF2FVWNKjGimcKCy+N2aSJyo8pqsCGBvH2bxlTfU
	1EsbhIosOZ7qhqeYSBcW284rSyvEeuCgpm0Z+swq4Jyq9AbhTBBDUHUDAVJai5rF
	UYL3LLAidMSNqT7VxfvBitsLl44T+5bg487XHYlh8AK9PasZPBjvhErzYjdWp+ni
	SKuK3lrZCOTfQsqrjBBtXN7q8gRGn277/+poTPOgXyPkCfDzLJsss8/xq3GEHKuN
	syy7CZV3FR1TcEqe5Iz1PhcpOG35HR+0DAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793991541; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gc9/TPF7lmkvyA8R8RT6fpfR+O/yRUkDDgUzXt/XmB42iOG
	v6Q4m7b9XGRte6VV4mKsQYBE0c/mLJgU5AqQl0uolMubNNPt2KI20uQykPjXbMH1
	1sazqnIo27bbv8phlAducPaURJGgNVxeK4/9vvT03g3FzbVR88dpssnOrXucyTo4
	W0avWq/HU3SjkcpqhZLoa4RcsMCiosGASKsxOFI52jIf/W8bh3L18nbY1xeiRXuk
	GaOodtopInvB7A1xQT0jV8YChro8f5SpfxQfKFY+aD9l9snnRp5CFC4bjSxFbU9z
	ByqNuO1dfd7w6VwanoA3ql6RyuNt5l+V8FB6KmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zLY5kppdv5Znhz1Q/+DFs5G8ALW4jrqr83F0I8q2doc=:bs241Hj7mL2AxSRlD0jW4QqLXYeKybGGUgPGbEAeZ/Q=;
X-ME-Sender: <xms:dSPuanZdwlPu8Bv8dLpZv_ANXnXX8VJuI42iMwptU6ErKHpP2vsQ9g>
    <xme:dSPuat3GU3hGxaABI6Dh_y60fPko0kxDLMStEYHtwqtjnCfe-J0TBwwiYjFOeMHHX
    EgIwXyav-IQ8Waj46ytdgX8LHDZCuQBOLiCWbwoet4k8KyZGivTTQ>
X-ME-Received: <xmr:dSPuanVCkK4_q_6CS88vJ_9xvy7rTA2OOYdgQwAxxzC_Yelnyzja9UtKQmWllV_DKN6J_iQsGTxeX2OXSu5d6fpPuoH1rel_qb2x>
X-ME-Proxy-Cause: dmFkZTGM50yJa4I+aWMP/595N9SePcAi2nQeiVxDRKaDKTs1OeEjHAboUauZ5M8HoSQYYU
    Wvu7ZdkB8+LLrYuWFZj9WEm8qIo/o/rjgcWFQW6JklsWCKKZG/4ytEVyZncekTuC8Kj4Hy
    zym2VO3+D4eerZ7LU/rjB3lg2zVVtElJ8eHKfaibBKVLl1C9wcadN0pTjomSNzFVvfNNiJ
    xUy+gCmu7THLJuvqqXqgK3bfbzivM7ji9VVtXYKWaXojXiQirW/aHod2oNHStYokLk2M/W
    UcYim8SQZu2eZedmavQHGnI76dQiPjS4wk/zuXQ024bEhVMsuFHtkW90ocTL6Z1zTL6nfG
    2Kjhj9s1M1yFZq65MR3hVSGAgiF6BfC2hmRHPdPmZCbzWzX3Q/Yw8Qg0nNHV5W5WvwLaot
    2TW8KsVzZEQZ0NBTJr1+chQ05Cs4PVqh0xt/5oQSiyxhEuipvkFcWGQ30r5ZcTU7/fxOYF
    goJJT+w9GuzO+SIyf2CHJ68ky5o1VaqKAG75xht4Pb3UU1VtSZQL2n552M+VPkc0r7Iv+6
    q8jd1wXOGpSmpxquqt6jxREPSD7Kd8nor3uFcOJNjnVbbvMzvSHE7R/SbFRYaEIlsuEVvM
    PBDQ+l+8l/k0gcAgS9Z5RxtOISG7wDViotrow2tDT8VW+Y0IKiM+2sxMJ/LQ
X-ME-Proxy: <xmx:dSPuanXtx5Gl4CGkNNcp6LV5YcTXLo9QaIHH9jJgo-eXquTrZX-jOw>
    <xmx:dSPuame0tHlg4zYgFNhL4_58RpV_VHB9Ekr9VNbKbx2mCMGVPeyLYQ>
    <xmx:dSPuagXbitcbSp_AwOGMmFVDIFyNGtoT5eCsMxcRilGbTZRtT3uzdQ>
    <xmx:dSPuavfIVDMlfi2g6RfeIELe7no9Kj6q8f6u-XPjziPLpFZhslbPIQ>
    <xmx:dSPual_nlE6w1xw3f0As_YrITxeXp1Qtdwpn6h29I5uyfkEuQ5FDSIrg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 13:59:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] t: allow testing with a non-default object storage
 foramt
In-Reply-To: <20261105-pks-storage-format-improvements-v1-5-870bb4212518@pks.im>
	(Patrick Steinhardt's message of "Thu, 05 Nov 2026 16:02:06 +0100")
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
	<20261105-pks-storage-format-improvements-v1-5-870bb4212518@pks.im>
Date: Fri, 06 Nov 2026 10:59:00 -0800
Message-ID: <xmqqzevliy6j.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> Subject: Re: [PATCH 5/5] t: allow testing with a non-default object storage foramt

"foramt" -> "format".

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a893963f86c..7fdd8272162 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -576,9 +576,13 @@ export EDITOR
>  GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
>  GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
>  export GIT_DEFAULT_HASH
> +
>  GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
>  export GIT_DEFAULT_REF_STORAGE_FORMAT

This unrelated change created unnecessary conflicts.

No need to resend.

>  
> +GIT_DEFAULT_OBJECT_STORAGE_FORMAT="${GIT_TEST_DEFAULT_OBJECT_STORAGE_FORMAT:-files}"
> +export GIT_DEFAULT_OBJECT_STORAGE_FORMAT
> +
>  # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
>  GIT_TRACE_BARE=1
>  export GIT_TRACE_BARE
