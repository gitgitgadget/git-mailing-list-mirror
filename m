Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853792;
	b=xSbobf7Yg8E+6iunUlKhHtxShYATCj/tV0UAYPihUNyjvKYjOn4B5lF6+Y7XbY53cbBk
	 AeliqLqbiSN9uDldaIpljwG7dmhUpfIVClBs9dWw/asdayqCEU5zzFCwVDTNxAbyFvXnk
	 9mcXN+b+fHqFgVOeW1eCCvlaXfPKh7bB/FXgXZ7AAZCzLD6UBVmt63lsvS4vRBHlRXJ32
	 H02zPwe6JHZHho3Ounw7VlsO6lNSoYTqdvYdyyEVEfcai06oPzfvkU1YRnXMisPul3PdJ
	 pVbG8gnGfedW4n0cMaJaF3idZFnVF6+J+cQQH3eeEXID5gubMqXPK6KFjoIyH+/YQfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853792;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Ri4aV0xfJO2Nbo94fR56L+NI5IYLkEN1duRuzip3CA4=;
	b=BsUY/JQ3XoHb5n0m6Xjqn7lcRO79FgWacz9NQpz2Wgb/A6GcOFuunC0cnlRBUOD83w0V
	 lfQLEkpZz7aOwQOaWOr+R5GiGUhM9n7ZJaGvYseLPWm+DVAj6xUxMLnhA+1NcEF3ojYor
	 lhnTxq52LsFTYlNyQt+VT0oEtCnpqzzmrpuZ3NC28tOpNO7gS6ECXPkX7GiXpUbFACQ5N
	 yKwfsWVa4hmgYtfs+r8yIKaYEQrGwaF4BJxZpwjKR65z1XH0A7keDG7PPDChdtPvNhkSx
	 2ZVZdBOgGXdO+sxRSMdxWSAG6hhcOMvlLmCeNK2lnn9QHAz7d/g0ijtA2upX1ddR3gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=jAQsN3H9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iww4tELu;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E469606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 14:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E469606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=jAQsN3H9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iww4tELu
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2975A7A0156
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 10:56:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 24 Oct 2026 10:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792853790; x=1792940190; bh=Ri4aV0xfJO
	2Nbo94fR56L+NI5IYLkEN1duRuzip3CA4=; b=jAQsN3H9trUawkezgklogSq5Dv
	3BPwQKTqaeh+BsRvrQ2KU4dLkFL44EH7xy8h9T9tULzC1V9NldlTWcwL6Sk+I4og
	1hYgoFRSc4rH7acR4nJKHUp9rRwf9X/VrFNe5eFTsuq0SiiGbDEP5gXUmiPBwadX
	cpCOKKEqvafW/HnyW6T1/jkJMEx1tFITVZxy0LeBkpnPFm+Bhs6Fp2ou1hBwYjwf
	7Ond5TisXKgxs+6kyFTw3TJkdao4oD7Omww0/ZXSI+LWYdz93NluoEm4sP9P6qMy
	XhlMecaTA9KypbX0QHdaQ80w1caTXMEzeDZD/FB7Ob5H03JecQ4zaxEPZy4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792853790; x=1792940190; bh=Ri4aV0xfJO2Nbo94fR56L+NI5IYLkEN1duR
	uzip3CA4=; b=iww4tELuKfTM5Wzuxg6Y9iK5OMaNkEPRA4t5gQ5kwd0YDi4mYBg
	tMtX4beJW8dHA9Ql0x4WuXQs9laXqEgkZrp3445UfrcVCmsXbpGTl9NagW0T2uaj
	a3NcoAcFnpnUL5HkSkNrsEN8YcqAuUZsamC4PT4EuBqT7HjJYSx+eMm6lo1KitKI
	yf8yIKF8Y5U2zd7kVXdkL6PWtJpMpyUMeoiYgEWSSccdMRadFTzbTDcedZGDU0jR
	uwvX1HYVNdlJmcbhi7qTNNIWnsy+rL+gAcHAwIcTtLGyt7gzCQysoHUCdx2YR/Nt
	LRjOpoxrZwf5eQXeHePzl4fdHAL1tZV3f+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792853790; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iWbi9vJBE7Tt/MJcH/XtoI+cFS/yJShpj7y7gt5xtPrfEKB
	d0pz62+02qmmCA53KUTzo32rBWcDGt6EeRT246evbzFpnTI9/zSrzEoso/nicWQI
	1bCltFhYsemoXx2/CtfC5cj1Sizl6VBFLw2ptnFBXQDhbAaJw7gW9CkrWoxUi1ym
	Kbmnk0jFEe4VANth5ls/Igj/tsWxQ4O/m2/psAodeYcLEyXuh/G8zK2BXV+hLVnv
	IIlWcJAzFy5WQUI0emL6ZY1SEJQTlMg0rIzF7fvm0JGwuGlYEV8vz3+fOL+2+Rhk
	7Z3C74IBII6ICtCCY7dVea9B1CH/oSOYXCpVNSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ELWrPRXSPNfmpAsb9WkLXa6MX+0W33WT6nVAfj1UcqA=:qA3sqJeS37Sfdf0GlqQlM/KPDvihnYhDv09k/RdX3b4=;
X-ME-Sender: <xms:HsfcahdNssRsGKHLm-Nk3eMf6e_ZULrdXRM7_4McCk8Z-kBwT0EPnw>
    <xme:HsfcaheBL_Muyq5eEVZlKxHtOQGbmh-ee2fgZGgGoQYJ_Lqie_RbSKgfEsv6jGcaH
    WIbnw8YuKzOE_pfrEtwpGfAS5weLa7dq5zBJlCfFv1ure1cn8l2xEA>
X-ME-Received: <xmr:Hsfcasx8rBfEI7_E4iB4lYlba2zkbXpionSPQkG0A2rI0cxNiRNkBOnwM0Ygpwy4zPxbsnd1AaFUbY8CprLbNP0yBI32Ke6HdUen>
X-ME-Proxy-Cause: dmFkZTEFhiKkQnoifBW4aL1gLAT/rafAnO80hB01c4bsrGBxnzHJsOtDq/VNAnnSbYhYAC
    PF//bIrtco/xai3szDwaeG3zxUKVexMqaLsS5Lhc3XPiVWxaQT82VmVXJL8JDVM6YPrNVr
    yjB7c5rycI2qkCgxr4wNZbdkkO4U83hcXzsveK1Gf2g4ValVoRhjqFsO2R0umvCzkBJsEp
    Dx4oPM40YuyaDHxVEQaKlq6k0pNSbdxAo/aODVp34GAyKQgv1lr++QdKmoyceW/ETfuR+1
    bzSzzId5qXpUYoH5p+uwOl08Oof3tRhsj8eZBx4LpwyFokJB94Q1NOLnnbQWLbZtrBgOrE
    8tvuiD7cQ8NoO+Yd5NE/W+6ZVGHvlorQISwH41R/hpTVj7Lsel/G/IOFq0AM3Xgei+QtbC
    hPjjl16uaRnh0Sq64BvK2g4nztIQI5g/T0WyAkZ6vaUE2kd1TF9WfKC6BOKVJFKLgQa1m/
    5YTGgUk7qLNKhE4/CUlK3QgluAF2dr7vkJkIIC+2bVGi2bOygMr7anzVzd4iZu409KEeMC
    osXHHsqNRQeqd++H2dxAbECqI14VaowUrEpNGY1ytnInIVITXO1ZL+akw/jSTFwJUOv1C7
    2eKmd15aaIlyhl50HQn5YL40j+VpeP2JTXtsLN9dmIIwPYWhxm+VV1iTUmfQ
X-ME-Proxy: <xmx:Hsfcag_ZT48wAgInT5euiXouR2iYliqnPQg5_7YCenSLflcbv4UaKg>
    <xmx:Hsfcasi5iyWQKFBzoAd4YDJQaS0BAS4bR2QFM8SfURZMuGMgPLnDjw>
    <xmx:HsfcavEpFYxc4uZgQzfAWH5slPjQsaI7Z7FznXuTBQ_VVHdUxwHbNg>
    <xmx:Hsfcaj-9t8QUHi16wLzb7CG5ArOHuB7G6QmcIiKWo8qx6Ib4tFyy8w>
    <xmx:HsfcagzOIsH6HhtR-KTWMSq5791HPzvvnQMw1WMKZdWaSHtOyNBTkLmE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 10:56:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Emily Shaffer
 <nasamuffin@google.com>,  <git@vger.kernel.org>,  Justin Tobler
 <jltobler@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <20261024111856.8s8qu%taahol@utu.fi> (Tuomas Ahola's message of
	"Sat, 24 Oct 2026 14:18:56 +0300")
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
	<20261021200341.378978-1-emilyshaffer@google.com>
	<CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
	<b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
	<xmqq4iedc99a.fsf@gitster.g> <20261024111856.8s8qu%taahol@utu.fi>
Date: Sat, 24 Oct 2026 07:56:27 -0700
Message-ID: <xmqqjyn7171g.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> [...]
>> I previously mentioned "topic count", but commits are far easier to
>> count.  So instead of requiring two topics in released versions,
>> perhaps requiring five commits would be easier to implement and
>> explain.
>> 
>
> Quoting the summit notes:
>
> } * Emily: Have we used a voting process for something like this before?
> } 
> } * Patrick: We need proposals and a vote. Who would be allowed to vote?
> } 
> } * Peff: Active developers with a track record; perhaps a threshold such
> }   as 50 merged patches.
> } 
>
> So it seems that Peff's proposed threshold was substantially higher
> than what has been put forth in this thread.  Any comments on that?

I do not know which between 50 or 200 is more appropriate, but I
think these are more realistic threshold.  FWIW, I made the first
review comment that pointed out that the bar set by Emily's document
was too low to cross.  The "2 vs 5" you are reacting to was merely
to point out that commit count would be higher than equivalent topic
count and without bringing "2 is too low" topic again, which I
already gave an input to.


