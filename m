Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781532;
	b=NlFKH7Y8I5ogxJyqrgR+3So7p6PB1HYt/WeHlx21Kmz98KK73y0Luia/A4PX9O3d6PjP
	 88ovZwlzLt/PFMbX7NBZOFS7j7YaoDsSytSGO+ORn1rUwi0J3RUJa03p1e66JqS/AbGPs
	 2RlHEX7r9Bb0g6MquSWMt0KaIEg6ueljjom6ftioAsRMgmoGi45jLagbxG4ha62nalZKO
	 7aJ53Dl6qu8J2hAhMrR1/0LxIiKS8fc8P8zS8AJ2AsvG9niEVyBNU5Y/V7X9qRUIlxnCb
	 QcYMmfzvovgG6xvjonIAKE3W3TMlFQe47apLGKnmCY1E0Yp+WCZhC5bVtbhZHppYkQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781532;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4kaps8uuLZlPTHjlAk8CBIcXaYNIQGEOA8HI0l93wls=;
	b=Ct8UUtvSF7DgnQvQWvtiACyKuKPO4HVV8tU3RvSrxA1mOz5Jo8dSjDH/eTClOsHA48Uf
	 KUjoMKx5sQGZTwZXkZ0SUCBkxw0nh9H/FW2qt5C7bUWUkrlDGFkhXtMAL/nqQIJaHxGH6
	 NoTkkCNyRdB6Nov+viXDXqc1mMo4hxmO7r2FRNckJRvCu6WGA9UVrpvdSZDeg+8Vyt6/H
	 6ic8oMwUGqtfSsgK/cOa3XThceJeLjlcTe4hREyyx6z17DVgmtZSqwoLEPuYRtWuOhfHI
	 38LpgFdCJIKvssWhC/YUz7Jev3U3F1nk+2Fw/2XExD2TXaygTFurkAOA9rZO7AzW2xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=B+lcO3sM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CzBgJc7a;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAC606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55FAC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=B+lcO3sM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CzBgJc7a
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A343F7A013E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:52:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 14:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792781531; x=1792867931; bh=4kaps8uuLZ
	lPTHjlAk8CBIcXaYNIQGEOA8HI0l93wls=; b=B+lcO3sMv2IRczRzOGfOhkKB+Q
	nY+9TScYc83suUmLYCN6fuLSDx0badZ1wDnypcLATnuuRu06YOWovmQMPAwhNwh5
	5HSPIY7JXnAZ9MqBjQftKNWQzOm2+2QkafxiU204xgCBcr8Jn7scbqO0rcdDAR3b
	T1gHKPBS/SZA5j46MYXhS0eKgMCsRu3wp51jrRbrjeql98GmEZspZPtmWy8M+E4Y
	3L1c85OJ1ZXi7IxhND9yoD6D4QSEbhsKiuz8nH8Gss9NYXVJXaFVdGgm7kg0YdVK
	HNpuoA4EpJschf7MAB8wF7TwwNDBXXW4b7Lh8Ry+eQc7+zmPzCOeTGZo3YEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792781531; x=1792867931; bh=4kaps8uuLZlPTHjlAk8CBIcXaYNIQGEOA8H
	I0l93wls=; b=CzBgJc7anrLcsJjYGUUNvmFbLOBUPeUVlv1D2Okqtc3OLuBr6zR
	Wt65tZ4rFeB8yK/ZLkTXMO+Vt0FynWkt5WsMVYOD0M1MlTs8pt2VkSR3INTJp5nk
	27xDQhkTETO9tcNk4az6KyQflLqqUssV7DffUlcJslbSyteL5p/DPI1yE/7amt7y
	W3qY/HdbhClhb7Vi/inzcQcy90Xa2DOvmSJvy3WDKrDzGvSn2V7cxWDcW6/ZPhst
	Z+rLUcX9im+ZE+Vh4yheNtL5bz63lD8czuzMKY8GyOIDKB0GHgBg8ZuAPxNAHtF/
	wY/x9kpoflRO6blPBFx/QYtWdL71kFfO8+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792781531; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:e4IE6Se6W//3BE7omCQVZyboGq9tqydQAT46mnW/RlS3oX8
	RP/wMyZ3j2B8vE1oyNI1aqAT/Pvq+iHjyiLSDZPkkG6Blr9y6IJEvtzS9f8fmSz+
	Ma325RMXOW1VWu5uPDtsV3niXsgqlc7ik/4wTIx3H1K5woCUWwk5Y5vrfu+PZlLC
	4vwUhcCNo3cpxh1R/YZb+POzAIPxBIjlUJ42NqE+87Mcz8DXNl0EqUgh/ZooBDAr
	tDzkG/EmPgxEPGZX8qPeOOG+KywdR89kTWGhg0IWt/gZw6n2bRJhlVm8ZhsCtaQy
	pvAos9LP/0enOaFoPYiv28+KMJvsiMgyaRXc/qw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:T7hBG4yh+/M5b9Sa/vkK8smQGaqTZNVDt8aDcyefwgI=:51P2khD14cAbpM1GypYWYRii/xzRXc/6LsKsMTaOmtc=;
X-ME-Sender: <xms:26zbagOUdKtMPVm7NehlSA-d2YhemcNzr-7NNkRHIqF5uNo1yyt1hw>
    <xme:26zbat93kC3NgL5hIBFV55dGlzEfCto80eWsR3_cqcUGYH9qr84ivLadzWfc6TCCh
    6lZnxZRtQW6AMU3nXM3gXeWTDi_KcovpHX7-QrHfsWJ2MFqgEGJ-ew>
X-ME-Received: <xmr:26zbasRxs4Pk2Jx7tN-KLSBPO3y6o0cdG4PUU8m2fofyR3eUoYQDUlB-F3DbuLcFjtlGUS7DpGx6j2cUZO32UwlIo6ED_nrZUWpy>
X-ME-Proxy-Cause: dmFkZTGqNBoEWP8Ibbe1fuNnlnr26HM4Rr0MSQF93piW0zUKyj7uSNi/vrZy7NcvurLiuU
    LlbQYumzcK7RyTTvbr+h6ZmL2N96gf5KO6TI862g2GF0MokKc3z6+rAdT3l1c3hFwxVG+i
    l0eYqGPtGi0CKGnfvBElPPRlkoKUwLgHPShSNKBV45AGhlpJACxp5vUOrw7uzrM59gqUnL
    GPRmc2LBr1jMDfZzQr2v+JUlDFczAVkMMboadO3+0NrII9/Tije9Pbt5zGpGiaeCY0UMNO
    0XyybpokqLy6DdnaC3BOtogpQntAva2R94NOmDrG9IVKVQWo2Cwci2qAwHPJ0SMbTQO3NL
    ZteVSbfDoUq/RU3nKDkzz8crf9u0EuDqcrFHhleugux/vbdLszqXatXaO6kyU7FKYAS1Bc
    1ZXWCWvUabMI/Vd2m5Gwt+1zEbyk8pI+TRLtWo8Q8FptS6XqFU7xlSCIcUjPTWqIXbg3pn
    yUyq4now7m8vradawN2gL8gC/KWah9SuT0Lh0xN7jsc5lTmx22dEYIEFGVeNBQnRpMOm19
    KoeK+PlAiD3NtDkIi0R0g8C3woY/oE51FNlnIx9/JurAnNv33AGKMhPaBKLYHUjSYe936X
    pJEz++zaWL8lLiiZsy010BaihzI+gvQ419ksBRMkJ8rOl818TTecRmePyHKg
X-ME-Proxy: <xmx:26zbanmWbf0Vfip3yqhKa4K0-Z2R5menm0VbuBP_e5xNngX-yhJBgA>
    <xmx:26zbakT9pq8aR6wyulcM6JXht7eweojAcWzkO2b5Jlyp8R24jQaSGg>
    <xmx:26zbatM765KyYHA3pHzrwkvCVVSm4PxAVwP1QQVUNvMTBVD6t09-jA>
    <xmx:26zbalUeV472KNBiZwdtXZbVC0YN2sFiaKyZ-UqQO7UJHHX_zX2D7A>
    <xmx:26zbauaLXyHeDXjT3p_1lO9I9hGpHsWbyJkBekRU6UmrEgxD-EXZmhQy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 14:52:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v5 0/6] connected: add incremental connectivity check
In-Reply-To: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Fri, 23 Oct 2026 13:11:53
	+0000")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 11:52:09 -0700
Message-ID: <xmqq4iec5jxi.fsf@gitster.g>
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

> Next steps
> ==========
>
> This series only addresses tree verification; the other significant cost is
> finding the commit boundary, especially for repos with many refs. I already
> have some prototypes for optimizing that too, and if this ends up landing,
> that would be something I would start polishing up.
>
>
> Changes since v4
> ================
>
>  * The series no longer touches repo->fetch_if_missing, which Junio pointed
>    out was a trap when cleared only for some modes. The incremental verifier
>    instead reads blobs and trees with odb_read_object_info_extended() and
>    OBJECT_INFO_SKIP_FETCH_OBJECT, so it never lazily fetches on its own;
>    commit parsing already never fetches. The BUG() guard on the flag is
>    gone, and parse_connectivity_check() no longer takes a repository. The
>    full check is unchanged: in a partial clone check_connected() passes
>    --exclude-promisor-objects as before.
>  * A tree that cannot be read because it is corrupt is now reported as an
>    error, like a corrupt blob, instead of dying.

Thanks, these incremental changes look good.

Will replace.
