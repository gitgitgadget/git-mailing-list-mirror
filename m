Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610082;
	b=yW7+7i3ZJ4AYYQj49hzw6riqBX/D9nKrezVMzDcelPqV5ScnCA5Vyez1n00jjrJX6AQK
	 gcW7aMYIjJYH4sMD7iwaCUBihLxCdgLeH53ZkOKNrIUrq7MU8Gofur9eM461RdkhXaEMg
	 341ign5tYk4Kd5qbwfRSygoGGlzSHoeJFYHXiByuY7dwjHZDcca3Xs4GMTtB1f5Jl6Qco
	 08aVse5gDpynPSGztj3PdXrYj2Lt/18jnttyXUn7kk5A/JY6u/raE94Lh3UN8rfd4x2HZ
	 poL3tmyx7E30V5DDAPbcRHtmseI7g8poPy9Ro/kjM3ngDJIPOjcLjHsa7GHR/TyPC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610082;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=o4Ax3APBbILacycnvUP5vlS3CXZc7dWbc0HhSuSl4g8=;
	b=4EE84gYNMvvZ1R65vEm8Yt7U1fYy8j+XCptHYaagc/Gzip3zEcK/GF2XPSiCfEfEQTGb
	 GYzlMRmIdaM2MVsXXYT07kwk7xbg7cslxtztwubJMTh+zzVUDLMxn2z6qeMb5OIMp1Q73
	 JXRi1+Bj6GBkjV+MFlNyHYDvaLJVxRKOq8EiVFwumjhu7YD1ZuUlqTV2bpFLjbg9KB2Sp
	 GQ0bEc3CVWrYASWMaULGTYkIzmHBjHL6LnYk5uD3Csj3kFRxZPj0ePof6nbOCcHHOkVLK
	 NJV/ynD6tY+O9dozcfWVFjtCXCdO05tij3hCN6wCDkpjn3qev6BEXhDYccIziEUSv8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=J1RfPMlX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kpn1p+rc;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7A606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE7A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=J1RfPMlX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kpn1p+rc
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B35327A00C3
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:01:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 04:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793610081; x=1793696481; bh=o4Ax3APBbI
	LacycnvUP5vlS3CXZc7dWbc0HhSuSl4g8=; b=J1RfPMlXdw50EgZClyh2ITGqge
	6vKhsSHieN+fC8AxmXZf/I3m0za28Xqilp9SkUQfL6R4y5EX77eUVFTXB7Fhj44C
	Lgwt2NaAHYA0AAVbLthox/2+J6UWoCREJ7+KDUtg3sFY0QxEjk66nAVmKYYgZyCN
	Gfdk9otI8W7x7XypY1SoolmQbw+4o6J/Jneb0yKylEesmi5wQnSyatWteDIvceOW
	GZu+OiYDgUrcfZdVH1T4y3SZIIsEkZp2N8gZTKVgFG6pwdnVaeSakOwSF9XJJzNm
	pxid1SwUEqiYDsDZlvO87wRPdUN5yDgBQ2gVnq6mCFCWqY224xNiQawuxqiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793610081; x=1793696481; bh=o4Ax3APBbILacycnvUP5vlS3CXZc7dWbc0H
	hSuSl4g8=; b=kpn1p+rcSAnQEPHiiLBbc3YFpM024u/Zl93vEOKUGpizelC+DMG
	NalYlce05cXgsa6Z0ee0bGk0NEUulUahz16jLUqCnBkBFyLYBLGVs+M0qXnKzNdY
	vnMllTdiJ34E9g9wKfM0DSG4BckkyqrU+5mxyadl7BhFOn18HhfHE3G0HyRYhVdV
	+IlStQO6W3EGL2JBk6oPtgia9YedomeDTY6wif4OYo8TGn+xCk/RL5jAx63ysvp5
	/ogSWc72N14i1Qna1xWlV5lF3zEU3LPkTdHoXQBAp56mEuzd6IOBMwEjlTdBKHmJ
	e1sBBef3zdm1yQOLuP/71BuV/jnd2ajC+3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793610081; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IDtZr3wAD44lvu3Wz+ZmwQWJDLqW3nzaP4eVoKzu99ANA/f
	WYaEhp2n+BmYuJkBf7MtD1C0FGts7BsZ1x6uZx4gol6/7cwNNKvEwstxgZrJ5lww
	EK8ps8Y0kPTYTSBra9M0IByNz1rrbSh64oKKOBVjUl8/mc+NWkgb4gAU1NhWwxr2
	Vni4Usg5r67PQsIHLMx65lPjkm/KQB8ZA8AHAU2AkUX2b0oYvof31ANsKXh6KlL5
	XyXdQXx+10qBJUlraGhCvKOFNyQzPo2+Ah1f3eD3wJK8enhNCWgK7UWIbQJN2sZL
	yDNHm9AHCHwUOEm3aekmjCQYYhCeTNzuxrlhcnA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pDOKQpko5VtyEgd67Ye+VdMdgLLbR8i4YFmfow80SlM=:Vte02dvtzl18qYGSr5HrA/aEgUYmj6YpkJXASOWqdog=;
X-ME-Sender: <xms:YVHoajp2-xkpN2fhTtxqGH7jLuZ2lW8q56wEFmPhjXeXcaSu3vcCQw>
    <xme:YVHoasttKtQ8sVpli456lhXVdELQE7eHdaOzwiWFBMXQRR1BBJyHIOQqmgjKBQTRy
    P-MrqtO9IEnjTvC1CPRcRRZUFPn5CADTH3pW9xHukR5v6cd4vLxgQ>
X-ME-Received: <xmr:YVHoambfZUnmgMjozM9HSuEpUAL9PIHhybMf2LU0AgDj6fsGm_7ekMJLuM4dZRNEV-c70T7ANogdUb3itYImsbPiN9RnQdYusTrB>
X-ME-Proxy-Cause: dmFkZTEEv6o00CX+sTpLyqcbZj86yNnbgENebd1opVaGxn1GYRXLIHyVzfvAn7UJZyTri3
    subxadP/nGZC5sT7CJgfWwMuZe415SSbljEX0O9uTOLvrEPJ2wplibaCbI0m4KYXV9NuWO
    FNCLhcYaXCu6rgPke20CZpkP5CYj4C5jmktT4rumBiLn/GNYW9nI78LXwhHl3f+QSeNHnM
    3rLMpM6/wMViSNh9Bkh+3jl1awZCG2M4NjE83jEjgXp+BLcORHOD9tr1QpJnN7xyE/lZsz
    Lpr94klkTqBAeTqsMDJqHG1wa+hyx96gZFhsFpTNWqFIRFgY9A4tMdZVf/1KU/SbKnK9g+
    rY+lInGzvGYx4hTlMFmfOXIDhQ0B+Fh687yBaXWBPtfwwca7WUfSj/FQEVm9qtGoVsMN0a
    HO4Kn+5qYK36GHS2b+MwYnmKxHufR/lzyzPV3SPTvMKo8BMSLOi6XPPy11PPg/XBirGyKU
    h8XB78Sqyat3Sx9f5dKoPDSQQsNLYPVJSaUT4hEJ58PwZhPYJkmZxlPDupV4FK6uYrbl8M
    e5ofi6ZENzoTHt4BZOWGU3doohiqhs2h+36JGXW95KE2Rrl8AgFZ4Ow7SQPrsVEUgKG0gP
    9xyHQ9nFMf6CtY+qQo5bsMfzChj1nej/Y6kXkohj/e9qb+2pC7hVXdG5KtuA
X-ME-Proxy: <xmx:YVHoajbgBqLvblguCez-VqnfvCZ4P930yrwl1SZWe2uAe4ZWhJxNMA>
    <xmx:YVHoanmJZNgE3u_Zc9aibA9kCM5czpelude_bhv-niGjAho3M76tHw>
    <xmx:YVHoam08lQA-FBkSeyLRChT1GTjFJbNhDrHWm10k_u96xTpBmGzLOw>
    <xmx:YVHoav34ExFX3iUW_IaN5nobCtwIq9mEm3OG75V4R-rkECsctnEewg>
    <xmx:YVHoah2TD_ln2cY-KT6GSfAvWO-EW-t-5Nd9mVwqDcnokZcS2UWDAwq6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:01:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Volodymyr Vriukalo <0@zitro.id>,  Atharva Raykar <raykar.ath@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,  Olamide Caleb Bello
 <belkid98@gmail.com>,  Glen Choo <glencbz@gmail.com>,  Jonathan Tan
 <jonathantanmy@fastmail.com>
Subject: Re: [PATCH 0/2] branch: fix --recurse-submodules with a nameless
 start point
In-Reply-To: <20260822-vv-branch-recurse-no-start-ref-v1-0-46dc140acaa8@zitro.id>
	(Volodymyr Vriukalo's message of "Sat, 22 Aug 2026 01:01:40 +0200")
References: <20260822-vv-branch-recurse-no-start-ref-v1-0-46dc140acaa8@zitro.id>
Date: Mon, 02 Nov 2026 01:01:20 -0800
Message-ID: <xmqqbj87mwtb.fsf@gitster.g>
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

Volodymyr Vriukalo <0@zitro.id> writes:

> vv/branch-recurse-no-start-ref
>
> "git branch" with submodule.propagateBranches enabled mishandled a
> start point that names no ref, such as a raw object id.  In a
> repository with no submodules it aborted with a BUG after having
> already moved the branch; with submodules it failed earlier, when the
> helper it invokes rejected a truncated argument list.  Both are the
> same missing tracking name, which has been corrected.

This has seen no reactions let alone reviews.  Nobody is interested?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

Thanks.
