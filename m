Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793732764;
	b=Jy6A95pEuKGth+IhltpL3diHfsvix6X/3a9ckxaEInzb86HFHUZUZ2EK3r9XtkZUuDo5
	 yWqNrVGK9UcbcLYUrUwoBnqfyb+4AkL1zniCe1WAXmdkFRXYFuT99uO9giCs1lbKRIJFG
	 xtu7BrArYr240NTLyWVLd4htONp9QBdPZ3VTTZf5e7YnNPfzUaHVSd1CAqFGYwW3T5EEx
	 6WFLY1pMJ/TmKaCc3v/PdGae+x7fbmcsnZ6AYkLbkSaeo4ZwHyy2laHNh/u+9UMCtDk3E
	 aIA43zrj1oTRMl6rDiw5QJZALFM8h2P3TO2aYjPEVOu1hjypniSShNXSOUYZkcRWw+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:In-Reply-To:
	 References:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=x4MJOG0iVlyVvQv5WfxlwKJzJ9Lb8uTDltK3E8JX31Q=;
	b=xiEdMtuSSTUuH2WsLwMI/nYDusSTACEeXvJFsMlLrXtmQWvAF/I2K9un3Vi6JPNfDcqE
	 PU6Owr47cLJtuGLFdUHx0pgfg0KwR+z8MBaWcXFKBEdyepRZ0qbteqIMKG54CqP1aDhSo
	 vUwEwAAUnO4sjJMW2PtPIFYUjqCfRQaYvkHkpATYtPXDNkCoJnNf5HsAc/cHRZH/N+/3W
	 WcQm8XoH5gfyGc0+XzTj4ZwL5ea/GZKXwA1tHplhmxjQQcPIFJP2EqZky5lupmH3SjcmA
	 y3qX0SbaB47frSIiBYl0dmUJV6nSK2z1kdmpcuVHTPwHHl1mMLwl8WrWQiMX/SwxC0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=igSWbz6l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A4606A33A
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5A4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=igSWbz6l
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1143a12.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 11:06:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793732762; cv=none;
        d=google.com; s=arc-20260327;
        b=DGGWjVC8lQlsRJom1Y6YraZsnX+TSd7GKqbJMs/oJSvHxsUoctAb1yzUJCqN/QPD8m
         JL7WyTddd/9CLye/O236wUkzwPCijJl25aq4iRJtnMht89w9V9a0MVRf/102Hx1huan0
         JTBQZSU0iLQLn7aQvyDf7z2x+gVVDVsaSEzbhOx1ZCU0Gw6yoKPRMZC4l4go5uWFvvSo
         ozNLavAd31MmDpypITYOeAnq5ZMW6fQmGRn3vvQdkbigjvA/TRaVahGYoMmxyxQeWWcm
         Y4EYXZgniRgrZHKhnUNvZKMwde+99f/3/Mi1pAJcplB0ZRdj9b2dmmEQmxladPB9ZgJX
         g7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=x4MJOG0iVlyVvQv5WfxlwKJzJ9Lb8uTDltK3E8JX31Q=;
        fh=YkC1o8BhKLEX/2gF2JnmcaCV6Pt0EAOAIz81VezVYjw=;
        b=UdcvdqH5NHTDcoxGBFMirRaZMxZQFUyFPaFkF38HIaSiJaLa9a2F+0sEeXzw//xBhC
         m11dGLGGLRpgVgrWGXY9AJxNqKQg9Pufq9EdPC1KK67nidEVm+i20j9Mkkvh2SrKvURF
         3wVDd4frC+SW83qgwkf+xT8c0nj8PAxRVKNTHwMcBXMO+S6aWifxU4RMWGUdyu82aroV
         WaFg3VaRIKTQz6iORSCSrLsOZ+i7Y4gmsUb5NvmbZw6rMQXHrCMNk/kcbB7OGT3bCpVO
         uZCPdGGV3qDvmX0ht3IHkGmP2HEuCpWAeHmHtgL2yyxWihD3XEpmc4kVrWRHxeO35pEi
         PLvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732762; x=1794337562; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4MJOG0iVlyVvQv5WfxlwKJzJ9Lb8uTDltK3E8JX31Q=;
        b=igSWbz6l8gBLeDVqIRzbBfFrKTHTNA0Y1t771DRbwQS+O4Iu6mzCzfwdJQRewZf/1X
         1jQREyJeyDNcrCFr5PgN3fykQpsQRDVcf1Mll6Zbsd6WTiGOozJkYXTikKVgrudBFE7h
         SeLnUwVqvR3J86tng2g/8mekbm5qnQA+iloqoEgQaw3e0PJ950BqasRk7f6PcmYh1r9u
         TViO/L+hHtRGxXMJ8KHH9pd/M5YaV98Zyys4uZUWCdI1otTekEINQKxGc6gh2oSQWhxb
         sp8WuAUx9sgcZTHB7ZcTPc4Io+Wcn8eegLdDCbYuf7sv3p2jFuQHixsA6FJXfB6O1QpO
         POfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732762; x=1794337562;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x4MJOG0iVlyVvQv5WfxlwKJzJ9Lb8uTDltK3E8JX31Q=;
        b=x7qzVQuOB7N6TED+9yrj90X/NIvAEFDYv8Y7abheW5XttIgQYrWY63CIWk8Rpkm6sE
         NXOfOiJkaobSMjRmUXVuZ9meFXiwfEdZUXIKJy4o9bxiNgUOjDbeInyTxpkNGKWvSnW1
         jR2+ka99HCRS0QDJn9WxmULEnRsniW3oOY5d/PCKcggjfABcVNV34xbIdw9PKjp8nubQ
         RU0r49DedYBQAtTU10Da8WCwa6PXr3vamWX7XvHUGnX9Wv4BboZ7e6/ZMbcsYc7NU7RM
         fcIfpJ3zi+ITWqvr+l/H3xxQsStH6Bxkohc5aKCuYNKUiXearoMzJ4usWJmEKgnJR4VL
         n3DQ==
X-Gm-Message-State: APuU4Z9A1Ng6I/MozMaqXhijpT71bLBVcj/53Rl/tqrUrmHLoXXCvaRB
	2N2m3SvuG9q3B9DDDa5mIbirt1Bx5FEZ2HNPZCpb0VKQQbVVsz/XcyWnIuQFzPfKdsh9hot9ABx
	JIwW2+y2OsI5w1opOc1yGAxw7w86Jepe894QWSFoM
X-Gm-Gg: AYBFou20yqbyBH2jDOr4kLpYaYIcSBBZloL1UBOD8ih/lTk8iaJQxXAyWepBs8Q+bFD
	xI8TVPStUifwWXwfOsuQHi9WRDtTiGre41hwsll36Md88kXELH7iMkkGeQIgoAE0EHTNxzC/mO/
	l+3W/Aba/8B+Tsm43ketkMgVUQALa/Ube+6ozPuPrTX6AfzAyLoqumWILmQq2i2Emw81zchL1sE
	tXOghlsa0NhHKRYc+aLZUKz7yUhXvkUkWEYDs0JEUhaqg5jsV9aZAWqudfg+BkBoLBOqGM/aUju
	3kGiZTU8b7DnvnX3Gy0SgNR5MGw2BvDF3LZl+KC32IrRkyDBlpVb/BxkDTo3dqZn6y26cWgonmT
	3+6/5/GtYP/pt2ma2UGuMsEzZxsUfVbYttY6Xv905RCy30cx6VS7eP5iifZ1wO8lvGBWug3ytwt
	btN2DWKucpjA==
X-Received: by 2002:a05:6402:1801:b0:6b5:5074:bb26 with SMTP id
 4fb4d7f45d1cf-6b5561ef5c0mr5048a12.3.1793732761205; Tue, 03 Nov 2026 11:06:01
 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 11:06:00 -0800
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 11:06:00 -0800
In-Reply-To: <xmqqld7aav7p.fsf@gitster.g>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <f56ab2afaaecfbd64c4460be5d95637054623e4a.1793462224.git.gitgitgadget@gmail.com>
 <xmqqld7aav7p.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Tue, 3 Nov 2026 11:06:00 -0800
X-Gm-Features: AclHuK-XYQReqebGQf7P4XXsyAxxgMpDuaw8PXqajKnBjMHtNou4P_LWVSZpzUg
Message-ID: <CAF+mdiebXKufLYYubtMvxqA53Ovwig9o0ZZM6=30L58yAz9TJw@mail.gmail.com>
Subject: Re: [PATCH 3/4] http: add http.retryStatusCodes config option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

>  - "Too Many Requests", which is a helpful comment to highlight what
>    429 is, is lost, and
>
>  - What we want to say is that there is a customizable set of HTTP
>    response codes that we treat as "the other side invites us to
>    retry if we want to", and that HTTP 429 is the ONLY member of
>    that set by default.  But "HTTP 429 by default" alone in the
>    above description does not quite say so.

Makes sense. In v2 I restored "Too Many Requests" and stated explicitly
in all three entries that the set of retryable status codes is
configured by http.retryStatusCodes, which includes only HTTP 429 by
default.

> Also 400 <= code < 600 is a constant throughout the function and it
> is a tad strange to see it in the loop control part of a for()
> statement.

I moved the 400 <= code < 600 check to an early return at the top of
is_retryable_http_code() in v2.

Thanks!
