Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419878;
	b=ez9BxoRO8GAZLOrCw76a1BBFSOkpYIqEktlcXWZ89h/HdWOBPi3H+kZjSdYtOvWR568y
	 cEd7dxe2RKGjeC1gqdzEWYyasTnLtD/0R+LEGxvi439krseKWgWA6fHtC5UJeUFAi9jIl
	 zGulq0GXuqQNthh0ZrUL2CeWSxW/+Pyf2Hw0V4bfIBFNzr73aNDwAks/SbOo9n+KYVTwJ
	 35SPmIq8WFd1sEcLxYhxsetcprY0Q8wfONYGkLN0EhaNI3Vw7+EeQ66Z3SCPO1p0dNGfp
	 cqb10KgIRhArmbvRrhgzM4PlSASEJEyRHrOZ47zGwnJqLbt4UNZxHGTPFUgw31jdgSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419878;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=BQUEnoWxtYG3jy5JDAzNTUzicig3CYatDguRvpjv1w4=;
	b=XSpHcNQDjlZmp4v6PCigOaL5++S00XjNRQradzRqEFAXCYmie15R4vBVlu0vbVgm7YoI
	 FpDOAjXlhYTFiSo91CZuQn9d5qB9IXYc7uYCsMbIqDyiVKiERh5HJiZDYGsEH663hmKLy
	 Ravf782u/XcbQ34y5HE8rTqiM+k2sNTAByZriaxX9eWogH2JeWmDg4ZZG23Ek54eDMD8b
	 zHAey4p9CHqOjN1lsO/3vOBiXEtU7oVqqP/hEj31iTmOoAlwbkNtZl1jAlV1L3APnLTV+
	 Alb7dYsSF394KDgKOAdKJ2BMmu9Rtd1n8zwyw4yGatWct/4vPKNYtHD7J5MNPV8jFpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FP3ZTgut;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s1KdkN17;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5BE60A3835
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 17:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F5BE60A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=FP3ZTgut;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=s1KdkN17
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C760C140012A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:57:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 12:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794419876; x=1794506276; bh=BQUEnoWxtY
	G3jy5JDAzNTUzicig3CYatDguRvpjv1w4=; b=FP3ZTgutItH80Sro8N0JMs4Uxh
	j00q56PpuQGxtKFbns5EDYM1CGdJXGOki90LgR2p5etCdiXejyNAw2PNL+tTLBj5
	Ks5EMwn2ZWHwz0Y9KtvIdh+jw7cNyH6RZ8sNCo6jW+DGxKIM45dPJIRlH5ZVPwSn
	y0DCN563Wqh2Pf8TMiwffy6IzjLOtgRZvte0GWpn41BZIJVThFLUScNPaw7fY3kM
	l9PzfnfgI6ELwOgDZFJHsOkf+eAA5miBAUNYjn/rrjeF/t3Zm8FUIej6dtIVMUyx
	bXmgvuzJBkIHhBm8dIhJbvd9qzfw+BDF+xhwyD4D5n58U5DCbWRPM6wvnr6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794419876; x=1794506276; bh=BQUEnoWxtYG3jy5JDAzNTUzicig3CYatDgu
	Rvpjv1w4=; b=s1KdkN17mnBgpZRWfcMN6yJ29+rUI40tUh8KSgVjIm44vCT3HqX
	qDSAaToc1mAS1JdahvivmhAFVJfPEgzsnoGNvt+Rue+JM9r0Cpv4y5ijPzexI3Fl
	IXeBF/DoN3PuZmkHNUPOZGmKVzsy5SdLXQC2AZPFIwmktzJWR7t6FezR5LMMxs4d
	qTH3LS/Jq1JC3umbBtT9D2M1ude1T35589BstC4WZPm3xjMb/CkRifj82FNwJwXj
	p+P4V/O47pAHObDa1h7ByME8dzGicWhlzNDiKIUCZACDp0exy2e3wDdBRz2s8epO
	GlfnlGmL40I/HFELGqRrW7lhy/0lo+ezGzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794419876; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Dg/384K+7jK+TKTGj+Zr99Q6IRpR69S7OKHpjqKLyaApwaj
	zyg+dIw/bfkAsCz7DSlut0WIxG1SoQqlDZ80AJ+iHphDglXk3FMjo/wu010RIM97
	9OJGGf6BcJrH8+xaTgJFtj3VF7VOwPN+Idm577Z3sOrFY2znBoqcM5sV/NMlXXAa
	6NVGYy8H12l2fATQf3XVNu/vGeM1fY//0AcNrLBoKpGpRb3IEcU1bXvyk86NsJT2
	mGGy7DchlDAHrjTMKeDVKUIBqfpNiQOTWfh0AGdpbgPjaSLKEmwu8e6w2BBkbMGu
	S8zZ/gG9rQlEhTtYahcljoXfq+Es0fl8vqv3PaA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rvNlf6kPmbZwRTIWXXONmAZqseISs+4sGi48Vazh3tg=:E5hnKGHC+psNlkNSpj4ITb3sPb0anTXubLLa6bQZ3Lg=;
X-ME-Sender: <xms:pKz0ak67ZcvZlBNKmx5g8dzIsdPy7pctTln0PeuQP9pFE0SYNqYgKA>
    <xme:pKz0aoLYTk8iBqQije7R3oCmh32HD8b1-ZP_5pPq9DQKDWtq2AqMrcSUkwOGJ0q2b
    Np-t6oqVFGAMJ5jSPQosvxGZVQJgjVw8ZUjWdmMijKf0uYWc0ESRt8>
X-ME-Received: <xmr:pKz0alvXMtqfeB1INKMF9AXc0G1dhonuPpwix7_3FSWUdl-yVeIeBRKBoRiHFebt0o64bhoviaWvmjxSUm0EeSyT89CQnGVHuyX0>
X-ME-Proxy-Cause: dmFkZTEnb0qVVMlZu7A5pUE0e5R0sLMHEmm8oFxrDbK0YwOamSFbQV0L6TDEQmqsI4l/CS
    8UT8NVM0wXvlXmrxtjMBQcUSB8aoI2zVlXQJPzV8iVKrKJShj9inp7zE6bukiNCZObL9QU
    /3HbmImrM1Qaxdioanw5C0sm47yXsc4C/XMgj6Eo8ljBzuv6fRF3tOaAH4FJHThurOi8dB
    0zWzJdL4dvhPl7917uZfZbYm4qLCz0HmSmzF6PtRC8j+7g8B7kqBTjD+CtJ+qjPvYZXlQD
    CAZqY/um/t2I/qdrLefCLMQsMYwGtEXOWU5eAq4TG3zzqAvP/L3t+iO1Ls0fAeCyilTxFk
    77y1KZW9VXzj2os7LgXVWTY2nPWhVD/Iy0njIKq6Q81h5scZW+T+bz2qoVH4P/aKqVET0i
    ofGh2gJsEgrYQnoUrYq/h4x2oQg9X516LuYVOwAYNrIizwIN1i8C2BuYZgLqcz33GSWXRk
    o3RfmSmkjnWVWWj0kgrdLPwOAwxvlTsttJeSI1Y3DRnYJ+HoSkEriDwDRothzgw5trWdSV
    FvVCAvyN2jR2C0AQXQOF4fvRM/XJMP8Aq07U1bgCQlgxL3hhe8FaHBYeT52+yMP6JurLM1
    eFOoOpD8lOPKWyy4LfzstGMsphUwwTTrOPgHvFUYo5rxoAeH51Jrv0uH0ELQ
X-ME-Proxy: <xmx:pKz0avLhtJV7IOfWHdLkvRPpC2o8nZb2PqWM41RtQ1aRkzF6WYOGUg>
    <xmx:pKz0am900K9IgaFX4ZszAHFQT8Ci95lci3fcF1eickzdOmdiaW5Dag>
    <xmx:pKz0agyt_g6NNjOBC_FmVrvj9bzpyfWMJqsvE-UI8EDfpcWfkkFG0A>
    <xmx:pKz0ar7R0pSCKyofz6p0muCWzVaDh4n2X1IPK0EKpwrmT_q8oXpzYw>
    <xmx:pKz0ahsn6F2N4AL5KgWIgvfPLBqVkop9SCL8ebot3Xk5N68QAoJoVogD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 12:57:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes Sixt
 <j6t@kdbg.org>,  Collin Funk <collin.funk1@gmail.com>
Subject: Re: [PATCH v3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
In-Reply-To: <CAL71e4N2T0XLZgnUVPEk1q8JjRiWbRo5B47DN_hfs1CreYH6Jg@mail.gmail.com>
	(Kristofer Karlsson's message of "Wed, 11 Nov 2026 16:47:41 +0100")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>
	<xmqqse17nztl.fsf@gitster.g>
	<CAL71e4N2T0XLZgnUVPEk1q8JjRiWbRo5B47DN_hfs1CreYH6Jg@mail.gmail.com>
Date: Wed, 11 Nov 2026 09:57:54 -0800
Message-ID: <xmqq4idnntct.fsf@gitster.g>
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

> On Wed, 11 Nov 2026 at 16:38, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > From: Kristofer Karlsson <krka@spotify.com>
>> >
>> > Several tests create fixture data consisting of a single repeated
>> > character with "test-tool genzeros <count> | tr '\000' <char>".  This
>> > works well on platforms where tr(1) is implemented efficiently.
>>
>> This looks good as-is, but once we merge this down, we will find
>> that there is a new use of the pattern that pipes test-tool genzeros
>> into tr in t/t1600-index.sh recently merged as part of the Git
>> 2.50.2 update.
>>
>> Perhaps we should rebase to catch that callsite?
>>
>> Thanks.
>>
>
> Oh that was unlucky timing, but easy to fix.  Not only is this
> new test using tr, it's also using very large values.
> I'll submit a v4 rebased on latest master, which should fix it.

Thanks for a prompt response.
