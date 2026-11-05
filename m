Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901422;
	b=ujjMpj699iB1XxKsprK0nTusYT/gmUb8FVERIFve33EWy0N9SzgsCyt63ewfoP41cPC8
	 O/45PhryZ4x5OHvRpIrdQjiWF6DGj7QiOX2MpyfOTcDEEQSIt+XZe06o6kM8f1mzN588h
	 3XYs2nwGoKHf60kqmL1jIBsnSjLC33Pya+C9m4X8eW9M5aC7z6kkkfYSfXNIqZ3wd/jFD
	 OUk7irBF89MaKc4kMWGgX324tCQYZOCKmTm/nI/LhP7fU6R73UZ6BEXSVQs2BsEZz9KH6
	 +7r7hTl7HOxpRN29SqWJJxgh2pEVScbX8iNByJLfgksGUOlmt3KQJxgMEe7Tomd6WMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901422;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ulAcQWEwcU16M0omDbm1qQcDnsFU0QJjt79jpgKoIgo=;
	b=SqFKslrZoqu0pEAJqmwrfYEDwtVsvStM6rxP392/Zc5hLyhovSt2CZl0RRePQWn964mu
	 cP8kTnaGJtJo3zrwV/gjtn8eAF0WjNWWcUAeb0njZKKwoL4e/wuB8RVgJ9Wm1kQA7XtBx
	 mb21Y9GrFQuLSSBu/B6Toa8PTB7SDvtWbylHhmcYqbL7BK3/+6wt43V+jrr3jQ0UYj7W2
	 Y5OE1cWS9zp74lTK4pPsxXB6oGQ/xXYM9gc1zgaKQVV8Ly9De7EfNFd/MPiu88ZOR/Zdb
	 IJTZ2V8xkyOfP5HhN5dm63LJtTy0+TZZ8alk4t1ebijSXIrC5TLgkBe2H/TtpA9Ao5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=euLixcJn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qtPZeRRP;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14D606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C14D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=euLixcJn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qtPZeRRP
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B10FEC01E8
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:57:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 12:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793901420; x=1793987820; bh=ulAcQWEwcU
	16M0omDbm1qQcDnsFU0QJjt79jpgKoIgo=; b=euLixcJn63SWPzOm3CuNRFNlWR
	mpD37Y0c0jyqDRIltvrRSFogpswSbqGxIkKIX+j+3s/39qkPw31DKLgc4jOW4b7k
	jdPOsI5zK/UoH7578kQYMJmqiaL1WEZMdy2KBGHslkxiXRoqOgRWMUafvN1yyvuL
	ySUCNiVhnbVQNuV6jSgudWF7rXvxEJYAA7bcR4EwU9L/NznW5TiHuCVPufXYbnJK
	hZF4a9fdtcC2Vg//GA3oL3DevX6IUjRn+y1AV8jkyFOo6zoDc7rfxxnH7Efw/1XS
	KLpEPtLytSuPTeiiFsnqqwnTZ879UAVqQ52oWCy5hfy4szb02VhAkHNbsySw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793901420; x=1793987820; bh=ulAcQWEwcU16M0omDbm1qQcDnsFU0QJjt79
	jpgKoIgo=; b=qtPZeRRPTfUDVJPn9ikEYAWLqFXea96+jFEEKrfKq3keDqX5yAa
	zTlmGyT4YQ7FbEv5nmdKjG6l9d00JKfIj3i6v91Nc3LOMN3fKHxkTedRQJwRteuR
	iiBPf2ZaaSfuizkJvF1+t7MJKlAn1MV9iUEj8+LWKhlLHeUxAZk364VSAwv1+YAZ
	tXvBuomLo45C2fmLAnQKo9O+NpPDh5COxdpR4m+rBiDet4AQaV6Ru1pBmZ+uQ/Qk
	KPueYnUQWNANq4l8Z+ZILUiKs7UdalQAILKLrCJor+aCRKUy2wswPPxG05npjxUY
	8vEoWFgmirjJm7VuEKHAR81zyKExYnJRQQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793901420; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:E/5mfE0jyZVJJ8xeYDYxQaRPTWKUydm74YNH0y6Na8APR9j
	/eTsQS2hWGJIJKUOm2mildbI2qQHxXf7ssNCj5j+nVFeRDxrGZOjIvTbwgOcU8bf
	sPwsr2/zgCjcG2YfXS5AXfN0WZs9LvnJiBGSocPRIHtHz2RvPDzD2UF9UrjeLplt
	G08PzLSkzxlFRASyeSgFafVRdXnBnPfcJ/VvjomXZQyM7Z2/5tGkQiGLfkYJuJF8
	VOuAh1YkU/sifSH+ojTR40r8nDYRprkDFHrQYBlpdQ2JoicADog6dN5ltfuNTh5R
	JbOh4UWYwSvXptkXRW+2Mj7OeFnVuLChkYqOa3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NaxIfZ7Q9RnGwk/w99+jvG1hbmyHVEWZkMPUDQVTPzY=:ulAcQWEwcU16M0omDbm1qQcDnsFU0QJjt79jpgKoIgo=;
X-ME-Sender: <xms:bMPsavvtD6HbG3Rz5O1JC_6SScM1d-PuyIM71kZDlHQD2y8AadlT8A>
    <xme:bMPsajC2ryMYgcFpWaTI_O-ogt3XjygDGXwR_T7M767ayg_gb9iv52zdJ1bk3jjr7
    PniuwqYPJSnctd1oR1D64CflYtT-IrrcrqAAFvd8nMTRKdh_t7vV4c>
X-ME-Received: <xmr:bMPsamaH3SqpUZ6_dEpdSiEO_L0LZNm_XOHrpBR4ZN1LPZVQ7fMXseZ1ezpxGZqiaL6EM7WdZYLtjUL5ATbVn8SrWw75eZbKGuL4>
X-ME-Proxy-Cause: dmFkZTEHTVh6QxKImtAIHHQoZsJX3uvKpKqRfXEfHr23KynxHtAABJ2PFZq5dcUdUE2V5v
    jjox+8LavD5h3LEMhNAnu9FfMqe0S/gDaed1x0Lj65f7P9mdWbtnmrJz7b/pdCdrx/o+qK
    bah1ya5eE8kQnpWQlt9llQA4F9bvMTY9v7TdEmq5n6cbjPRcE3aILSb4O0IJtGQAuONXy8
    LYJj5busGJSvs31EcieeqxeYeOFyM4yJIyNyC24SiJA5kB9g4yymFJamsZpNxfnEExiED6
    84J3RRMbKLEPp18j93xFO40EF3ysjKwrD49xG6iWA1bgUEggb8wWJ5M55eY+XsFE/MJpUb
    GZndruH8FKhbldHmEpkAs4G2ed+pkt+TiIxghN3Eug58bXSjW9HmtRLiYGtGMULossKDAi
    jpL3fgVY/a18DR6b5jwmPL+TFYgpAI2Z/02RfRUzhrma8+ftiiz8+e3np5vKoiDPbthtFw
    hh5DXQL5RUTQCB5XhyMzdJbgh6rS1CJLnIQFZj4U+nzkzegvMXy7dYHO/N9vj1uelnhKp2
    7rLRI1PyoDM97IADaeQxen8ZQw+sMhmlWaaS3xhgr3yNsKSxs/u+2dvbQUMcY4OGiD9x32
    vHPiYNvMb8rvZ/uJiIsq7OwxubnlRaXx+rWsbZil/d3RaLll/g36sGcmKb3A
X-ME-Proxy: <xmx:bMPsauX_jJsYooTf-m8-xoSmHvLBFabBTJ_GtTz4KBHNw0DuPN0-Jw>
    <xmx:bMPsalPijOeaYFAhotiskz1GA9ropQxqIlEj2vQe56UZkibeIze3BA>
    <xmx:bMPsaoaleNocNUiRWyPBK5y3LCMFhTCWCtNCo4g4TB66H-usSNOz9A>
    <xmx:bMPsak_ao_6YdXeAi6ljqsmdNCzGzQlgGrCNkAitdvQx2KUnh6e43g>
    <xmx:bMPsakJ0ldPZ4rKCCViYGusgPGRo3B6umATiRk41Dx0m7bxDdSEdpAQO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 12:57:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH] notes-utils: hide functions that still need
 the_repository
In-Reply-To: <auyRGpaHb5rdVP0d@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Nov 2026 15:22:18 +0100")
References: <xmqqjymt94l3.fsf@gitster.g>
	<20261105074333.16756-1-okhuomonajayi54@gmail.com>
	<auyRGpaHb5rdVP0d@pks.im>
Date: Thu, 05 Nov 2026 09:56:59 -0800
Message-ID: <xmqq1p8zw49g.fsf@gitster.g>
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

> Hmm. Wouldn't the better course of actions be to instead fix "notes.c"?
> It feels a bit weird to me to just make the whole header a pointless
> include, and we don't do that for other headers, either. We have tons of
> subsystems that still depend on `the_repository`, so what makes
> "notes-utils.h" so special that we need to drop all of its functions?

Because it invites people into removing the_repository from
notes-utils.c and think they are done, when they call helpers from
notes.c liberally if we do not.

> What we indeed do sometimes is to mark some very small subset of
> functions in a header as depending on `the_repository` in case the blast
> radius of fixing all users is simply too big to do it in a single patch
> series.

Absolutely, in the ideal world.

In this case, however, I initialy thought there was only just one or
two functions that depend on the_repository, but it turns out that
everything calls things that only work with the_repository from
notes.c and that is how this patch ended up covering almost all of
this header X-<.

So...
