Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238921;
	b=N8+hhRIwsnz2/Rknn0KWVPOW4LPw+8lBASfXc4NVYKYjWzFTK+G0JLiI1ruqNrGhumeb
	 U3B2vCflxktecdzOj9kWe6ol3Y14UDAlLgxW7ks/F/jbFxKo72ZvzIXlXV8T5mf4jYN3O
	 FLSqsZTctBeTjE1ssVF4ca7+yPo+zAdd4gms30bfu2hcsLcfr/LlbivRrxa7EKNS5tM3Y
	 5YA/C84WvUfJ2ngpgKJp6bBPOfoaQJweAXKbR9+g0fztUQfczR0yba0p8aV7ThPUNJ2AX
	 2qmjuzjgvKdHMqazkyr3sAvS7vyFSaczKtQYi3n+Dd3t6RlwGYu9xVF8BMj59UTB9qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238921;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/oaEu9w3VQCQMZWbUQ98AeS1p2JFVfn0Q3L6kDvDP2A=;
	b=TQMgH+M7vOT0gfC5T+WqcwjkD0rLtBYBgVpiMPQNV/k2j+DUr6j8LQKKte0ED0wb+Qvn
	 ThYQS0VmGc21prXs0vDsyYlhAro1uXV64WXuM9NPYN4dZv/z7Kz4Ep0YXO8jlE0yG14K7
	 DQHekYg/At1C3N16eaeLL3H6qxzXMtRp/GV1YyQCGqGeDKmLgcryFTc62Ag1jPwkdyC4s
	 9u0oW3hQd3h0c6b4bfjq94ON+sdLU+zWWFgzYpcCYSLaEAu19hKpVtrT4f2ojxWX3fxH+
	 5gxDWDFZznMXBrhPGhJu16eMGZzh7N/7NPHKItvuUtTGMXFVi2yok4Ive3mx8Odprlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GPSaoZIu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mCnkfiLU;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB9606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4FB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GPSaoZIu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mCnkfiLU
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 40D8BEC00BB
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:42:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 10:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794238920; x=1794325320; bh=/oaEu9w3VQ
	CQMZWbUQ98AeS1p2JFVfn0Q3L6kDvDP2A=; b=GPSaoZIus6k1q7oZC3cw/PohYc
	9wlLXnrgGjUJDcxlPmAxN2iuJV9+9q1mWLvofAoPM+XEbXQc/nja0tU2YOEZxCHF
	cmECsfscIWJM2l1WgYFj66HrSHSpbGlR+MCAFIqYxIvh/Q9MfZhby+ulSFp38NYN
	p3yxG0caNUrS7EPGrRrcejXqtnZb08mqf4a3mKHXRqXC/bXCkVXUe7IVmrKS3dtT
	fshj03pBfHHK/TP19cIJf7khzPnmDpncBWGZ+Z/0MuhAeRGWstIRrjNchObQrPem
	Lkh9N+B9mR5/2g+yxb+TMVCh7NS7p/B4eK2/VSogXpeeShnl6km1j18e/wPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794238920; x=1794325320; bh=/oaEu9w3VQCQMZWbUQ98AeS1p2JFVfn0Q3L
	6kDvDP2A=; b=mCnkfiLUDEXoy0jARteC/Vw5/RjnlTjtHdEAJ6b7kEV7QfEd27A
	Ulft81FzCvHeTYyRAwJQm/y2yMctm3xpwRGDm76pxRUup4hlPf3JVcKRw+BcPfgH
	mD/wT1bvlo7h/zaIU0jrOiL4blh2Yk4od/U9t5fzJh4czVmWTdfPEoJDGDy+oUHz
	H3n20Pw4u6gk+bEW6HHWjOXuI6KhUtA8pMtSIp6GdHS10RfFihotU+xrByoP5Kx7
	Tfyuuz5yOHpz0aRYooj++++8gs4Q54lHDQtIN9StoBkvmjZyaSE0TP2U0F4AHGDj
	qELS1mD8iwOjoOdzEWCehGtnJapF356f4vA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794238920; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cOSn5hOD1vCxKL2o/kKCIVnDF+FblU82WjLUJpEOulGkHvq
	MMEGN0xcBREhyKiBUHwjeQP1/fP1wRNInJ8bij5LewwDFybfOnFU9/pISYdk5JGq
	VeQk2MrTt6mK+hu6etz5+c3tS4RXk9oXn0UUPxxKEh3TiRqzUi/y63w264aeCD4T
	1R+3TtiqxKuq9Db+NUTLxZlVY5xHwPfuytZYsCpjVHf/X6XCq8AR1l10lPqy4bb5
	nX2H80DQlVvzot2eGu5GyrDk1nLkz5ST/kvyCpYT3B+NRx/k2nVwNjS8pLSFNJ7a
	VAmRLkSNitOVQ1Twbx7mtQ5LZYHJiVDyp9gkijQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:utv5SDGjB/un444umHlynml655LKF+XcVILbges/K48=:yWK/ZBgJGixqh615DYkqLz86rDBgtboHZaJjBGxl7iU=;
X-ME-Sender: <xms:yOnxarAlW9-T5NuZ5x_NZKvZm_-ftpwVoXp7YSTMMjkRVh_ty-WaJQ>
    <xme:yOnxalNtXFOjb_QuC_fQH9SA-ZfAVofEHAb0_qqbdYAHTtBAqYQmh2jjLD7CMPePq
    LdrCmXXLoC2-yyrHOKfI0IQnj2Cvnj_ENIF_DOz_S630d5Ogu7WBIw>
X-ME-Received: <xmr:yOnxagZ52pPOm3Jea8Cw4A1J3YWR67tJnw7SQxqeahNn9ZfeqHkENOOJByU6_Kn8rSU-Iqt58_O5uAI3PhAs4NWh-ggcXK537xyh>
X-ME-Proxy-Cause: dmFkZTGOXpnhcrrQauw1g5/pFIAEF9hVxhYjk3dl7BnIlWbOhhWrq270CIWu4j346oZXAM
    7rbPSO5CbcOxmhTNC4HpXI3rCwi11mEjD8vSn8txsW0HY2R5rdPBFbTrY7LkC3ECcl+L4M
    87IWY9BAKDgeNx2QwzWpr8kfpaY8yrZDRjAfpSMCgiS3g3ie+PaATX2MHaXR2nFsZ3dRrQ
    N72bXP/u/m1CrRCsk2HtkvRVAIO3L018I3+hX6BJHV5fqxGbH7KktwIhWwRiFULerEbSro
    BuZqxU2V4ou3IUHHlISH54pnZRrwPoPqJBSCb8TuXxQBNGOb4wDMriG/10xnFhDWx86kmI
    CQT0K3l3Cyvsb0mDueB7Po/bsgYIPK8h8rMB2tqpo0U6Jnt45K865zM9abBlODaxeOi6Eb
    vqP9z4USM7/X6BqB7w12cUeG5UwEqoEEVbltIih56hY6/waKNYBLa47AUYUhcTz3ixz/VU
    FSRtJRICnvE/amtWmr9aAyKX4mmnqlSHe1PLZ/G1+ClWQf2P2DgHaDQ429wx9LPahO1x0E
    C6qWhH39uM7eMV5C1wUrfQ+CAoYu183ikq5e320Jw/ChMnHoJfEXnOcxDXPf/wSCwZ4GjH
    HXoS5ciPGT3Nfhir36PHsYUBm8FWqv8OO/zGC3a6rTbfNFguOBgv8GoTMDfQ
X-ME-Proxy: <xmx:yOnxaktbNua3QY8pozzkQz6CNYG3f2AvoCUhuzA4sg-CIJlom25i9A>
    <xmx:yOnxaiMQxHT10xQNEOQ5Qk-yPRGeJnEprFxs17eOmmhKF5OQFiauJA>
    <xmx:yOnxar5vbqe8ia9JzeCfjlh2AqaXeZ2vqQCg1AC4AfnHX-3AkbW-Zg>
    <xmx:yOnxaoS-mle8EREJzGptvUlNmOStmu-cT2U9ILuzqmchcrcJaBXTwQ>
    <xmx:yOnxavXlBx5SYyIeFoQh8GAZf7CXzEQy6yhWcMwwiIOFBGdU9gw2VjN9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 10:41:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/2] t: add "test-tool genbytes" to avoid slow tr(1)
 on macOS
In-Reply-To: <CAL71e4PkS0dRvqSkL81hSPO3M3K2n5ZTumFNvCx9MsBsFKbnmw@mail.gmail.com>
	(Kristofer Karlsson's message of "Mon, 9 Nov 2026 08:10:45 +0100")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
	<54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>
	<xmqqeccu3hqq.fsf@gitster.g>
	<CAL71e4PkS0dRvqSkL81hSPO3M3K2n5ZTumFNvCx9MsBsFKbnmw@mail.gmail.com>
Date: Mon, 09 Nov 2026 07:41:58 -0800
Message-ID: <xmqqh5hq106x.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

>   2. remove static and keep the size.  Since the stack is not
>      complex or deep here it should be safe.  It would break
>      on platforms with a very small stack, but since it's only
>      use by CI and developers any breakage would be immediately
>      obvious and easy to fix.
>
>   3. remove static and shrink the buffer size.  From my (limited)
>      local experiment, it seems the buffer is larger than needed.
>      We could shrink it without losing performance.
>
> I don't have a strong opinion here; I went with (2) because it
> seemed like the smallest change but I'd be happy to change it.
>
> If we go with static, I'd prefer to have a small comment
> above the function definition:
>
>   /* not thread-safe (due to the mutable static 'buf') */

I do not think such a comment is not warranted in this case, though.
After all this is more or less throw-away code used only by CI and
developers ;-)
