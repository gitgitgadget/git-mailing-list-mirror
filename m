Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523599;
	b=HOy9nT3rwvp+bVOGA7ZTAHGJiTh8E/SUItSbHUZ1l4bH6lrbN8oj0Q6WxeUvWNZRs8DN
	 xJLCgRou/CBm5d3d4S2iLvkkHE+sWOjTtosCLIP1gR/K+Kdm+48e6IMMMsccuNXGOPK+A
	 94yAG9kqKJStVCR7/cEyHCMqNl2izgENkgNVqf8pw+VG6BYanK6c5e4Ule3uwYlBCzN0v
	 ueBvw2fcKUolgw5nrl8OqdNoxrD0RWorQLmtDB5IFBWhXWEgALNene353bdc1kIoChKSS
	 KAdi7LUuYcT8gQG8wDfnAssmGWufOPSIvxpwMY0iTPuG7S8dJKdFpKLiKvkJCSg2sdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523599;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=z7zVMtLmQiXJUjg+jb/Xp7C86SAIgc/r/BE1Q+A8vTA=;
	b=lPYGund6+pAjeYVUEq1FcndNjQgepFEv9opFvFR5IL2Or38aNKFH/8l2tHYlcd2Fp5NL
	 nm8ybnbAcKOt+Q72sGcrlSK3K3nmKnu6CZrxCTMoIdc53wMOrRKbefs14zTrxDs9Xv45f
	 NRfSo8kVg5ZgHvZ/z4rayeMA8VPEyLRg9FpLdbG9/kP67NVeQOjSxy7DZKyu12jITgImm
	 NuU0aVzfMInQeW3W0rXMgJDuPBgXFbjXKzbz6jXYDF0pOoVLVfUuWCRWxavXathoc9jos
	 FOPh5R9twwFG5iiBj6BwmxSD6ogDFdTQmh6zxZ1eQSzHVMlCBQXSooKfIpESQVEdvAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="m7N6YGt/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wwMO52Ef;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A625606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A625606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=m7N6YGt/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wwMO52Ef
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A21B140014F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:13:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 20 Oct 2026 15:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792523597; x=1792609997; bh=z7zVMtLmQi
	XJUjg+jb/Xp7C86SAIgc/r/BE1Q+A8vTA=; b=m7N6YGt/QPGh9APR0cnHBZGZXZ
	endU9M44sPVKh+hAvkSya/E15RdYSAj6nL2TnKfflkdJalUqYFnOiPOseoIUviM8
	tqhB1tDWVXb1GwQbLmSugxzygucq1uI0gX5IXA+oRW2g6DIlExoJZAltdpjLk2pA
	ruqV04UmTRmoA9U3/x/sQAeWOglARUAwbxaYfl/vUCau5MsgjCLCUC4k0k1PDYG6
	ElTFqetxRDaiHL1RhJDaPjqi+wXMSAJYAzdPwWYOgQA2G9AiwcGsGozWpG5TlFbo
	atFOZb1iH3dY/SzPCKaP1TO24cZ1O+45XUqw91n52CdyatzeJBmnoT/mbNvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792523597; x=1792609997; bh=z7zVMtLmQiXJUjg+jb/Xp7C86SAIgc/r/BE
	1Q+A8vTA=; b=wwMO52EfGvadIEHcjZQ6TdL8LN8rGZ3cQnO3JknkKEovg0W3uf6
	GPSYUkyDmv4JCzphpi6y6XIIU+cdBULHrI7bpZP4nNN5faWbDt0o4kXe4Zsv3TKS
	/vFurHWFvp9qb6JjAMC8ztDocdGkJVsZ+u47MjYHOb3Bi90LW2jhoZNW5MbnrGdP
	mCfoPimtwcqocU15nAe0iwWbq4nNyaXvoDUDix69ynZ6KFAbG0KXk1sL/B0ZXBdV
	cGvu1yW1RyAVr4S3/0iQDYGeQo4FzUFg2WHbu3bSt9dlq0MaiuBSnJWFbTZTDriY
	rYIczDiSVqQaibY6swNoPEGa5pHYos8X/Zg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792523597; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZzvlvDVwKNrw5JaIxP7dCrLdurTTz8GxlD/psh2LIxb7lv1
	kwiSttH+B23+HWjYMLq6/4682DSdIRl9pB/YTNKJT7R1jahqdHiMTYjAsDP1afsZ
	3jDH3AEIaGmqq0vxhELBQ/OBSfr8C4LJPIFY2VeuFkVK8PEalaCViO46K9eiWmXt
	cPBx9nHF9COBMYdWmiLj3ED52Yjwma6U//H8onBVPQRTRj15uI0m5hgyCCruiPuG
	K5daVHYPGpTY6BtWcBHywmT+Ki+zLH+xvtBTLw/M39BgqRTRlB9eSZPIdfkOwVer
	dcy7bly0+r3nCqNQhs+ui3NbJek7cwXkN3BcNvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZbttFRyKC6Wrj4KAoUaIG+9UNRhNaFhI23rS10anp8k=:zDS3n95xVKSAzp72Cjbx06pwxtfCanrgTK7ld8t7WhM=;
X-ME-Sender: <xms:Tb3Xat8zQiXZaaJux1PCIbri4l2rFGUUKgm-7bXVjN5GF2Q-6JBvcQ>
    <xme:Tb3Xaoswje5ge-zvkic_hw-hBjA4y4coFCvuuJDWd9LsCITCiaDP6Q3gANnhH-Pbg
    Hzs6SflbeK1lbQj73IBOWxzppuR3n-n_bIgKX003z4fWfYqzCZMr2Tm>
X-ME-Received: <xmr:Tb3XagCbyCPo_OsiddzoscIiQEcLLLw8sr7WydaEQwaWqWUSGzOSLM-LUu1aJfkwF62SfVi9-8V028XcEWU7touVyCMol79kb6Mp>
X-ME-Proxy-Cause: dmFkZTGOB2D/7As1gRor1xJRDe3rrjteH+yJI3Fyh7ROE4+klw3mblShrb0XBwFVPq2pVI
    cdhJy+4MI9ROZgP1T7XRmJqpsMk0cZgxswK+/KyFVdY2hQrb5I56pP4zy802O6EHLcQdYZ
    MbTLdMhPFjjdvC7zIX+L6rcJi07Vl9b6iiFWqAuepiYnCDq1fZR87ewEOLOj76DG6uYj3y
    C+DUy1+kzCY/uyiN8XOdJFtsnzqwsmbC1sHa0eGPr12JRmyV7P/ewULGQU2PzJ4dSZ72uu
    DZMvmnq+AvOq8gP9jctLIwFnWmzWmf27WK/b6nvzPLJv86T/5L7OM0oIYcuTqsHyCnAXot
    /vCSjUFunUjxaaHmDMoBPT1AT0FxBkVOW8s5ukidvD/6LGc4RhVbgmyS3dbz712sOcM4a3
    7SabCJ/O+4renWFDmd2cqLeaAXK5fdWZj4GsCpwbUf+oWwTOWIdrYYB5WTzu5S4xKawOBY
    1GeydWgdyANe8Zfj5e1uaaL/mfloGVLnz5jS6OuTvrNvObVdcMipBtIgA2x03uKXz1SjIH
    Guo8FxvV63fDlZind9u9xHOUReqCjyDTiY2TmURfUrj54Do3NHJrmJEHDEXs0oCkOwxc38
    fkfNlYJI2MRn3pK/IMK1IJEJmxyiQKWOUisK/nbnNyK89d9xLLGFlGPSqlzA
X-ME-Proxy: <xmx:Tb3XagUNzDTbl5lQSj9qvXiR6Wvbvmw8ZR2XN0UGWUzfXCRLCFIj6Q>
    <xmx:Tb3XauA-cdKcPCOEsCOVSnmrxRfI21kMlOQXJk3gQRXbDzNenI0FlQ>
    <xmx:Tb3Xaj9Ty90XaaYeTkUSRURLm-nfY3zfwsggROJ0nZz-o1uajwOYvQ>
    <xmx:Tb3XalEfXARULzh8Xo8ekb1zrGrHZA-Wga4PZxUihT2s6UgfNWCWOw>
    <xmx:Tb3XajiBG1ryldRRUzsBGyXYwm5V-XnDYW5ysS4T8fTC5iFTt0V8sTHJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 15:13:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <xmqq1p9kw6qu.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	20 Oct 2026 11:45:45 -0700")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca>
	<xmqqh5igw7l2.fsf@gitster.g> <xmqq1p9kw6qu.fsf@gitster.g>
Date: Tue, 20 Oct 2026 12:13:15 -0700
Message-ID: <xmqqjyncuqwk.fsf@gitster.g>
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

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Julia Evans <julia@jvns.ca> writes:
>>
>>>> The goal is well described, and overall the tutorial is well-paced
>>>> and avoids common beginner traps.  Since Ben has covered the text
>>>> fairly well, the remainder of this message has just some leftover
>>>> nitpicks.
>>
>> My local build of 'seen' just saw these:
>>
>> gittutorial.adoc:124: section delimiter not preceded by an empty line
>> gittutorial.adoc:487: section delimiter not preceded by an empty line
>>
>> I haven't checked what these two lines contain yet.
>
> Now I have.  It was the underline-hyphen thing.  The earlier one is
> for Step 3. I missed, and the later one is what I pointed out in the
> nitpick.

Regarding the topic in your other message, this discussion helps us
contrast the two styles offered by AsciiDoc.

The Atx-style headers, e.g.,

 = This is a first level header
 == this is a second level header

free us from the need to count characters for Setext-style
headers, e.g.,

 This is a first level header
 ============================
 This is a second level header
 -----------------------------

Besides, counting characters becomes tricky once we step outside
US-ASCII anyway, which is another reason to prefer the modern
Atx-style prefix format.

I find it somewhat harder to notice when a section is at the
wrong level in a document using Atx-style headers.  With
Setext-style, the long underline makes mismatches stand out;
indeed, that is how I caught a handful of mistakes over the
course of this project that I suspect I otherwise wouldn't have
found.  Once found, however, such a mistake is easier to
correct.

