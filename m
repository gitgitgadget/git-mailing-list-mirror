Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395993;
	b=jym1PUmd/9D3qQ7j6GUm+8rzQa+C7yRkiHesJE/zxCGSX92R3CMyDDqpJWJHALAMIsfS
	 QdDzBoNrl5ZxuXHfQJ5Kg2pptZXETOLQ4tLvRdZBhBIwLI4kzMcN74hO+rtSpDL8HL0Nw
	 4e0F68Zc+bbSu1K7b2IQrkSXm9arRwFrJ6NNG68hBv+Ib6UEIw99Z1D3sZnxA6s6ACe3e
	 VTvPiq7XM/nWqwIP6gqPjiBtsSLtcz/oMljiJIXr/7QHECLadPv3Vt3vTHzHJLe1SyF7E
	 WA7Bu3KtfAxEgjZiu1ks+5dxDQaxXMDDyfw2TmcDXp6RutRu7CiltRqL6OYFb82D2hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XoEvjigjRTGfUMWnUZfAHJD9p1M3O4kUL5j7Sa2lBnc=;
	b=rW6Vy4ez//ZC4OIJPcy3lky4QfzOllYRMDHGNJcYzG3rjwbphz6WSNiRcMAOdchD9Naq
	 4HIRRdTd1cTziwdBYuY86Ad9BPF944EhGnmUL1C9IswlcdOXBSGkVj9s8jBVSCTPmiQ+9
	 ZJOxU9NlAibN3TzSEMWGc57jImjyMvbUWsZ0u4dg+xaKJjdrBEoOPA5hfmKMoKqzuOlU1
	 74rMUpX91hT7ZgvvYB+fpSUGPxsAZsEB73IUIlwIBjjDmWPQZg3f1aCz4K4JU+IKuCgoo
	 VVft7pvsZBvgGW+YiHKwl//KamlktF7YsQ+rCOIT1nbY9zd1+nvKAOANn1b5f3WTmSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sE4SFqkG;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19560A2628
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 21:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF19560A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sE4SFqkG
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a2551d7b5so2904179eec.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395992; x=1794000792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoEvjigjRTGfUMWnUZfAHJD9p1M3O4kUL5j7Sa2lBnc=;
        b=sE4SFqkGSKVzWvAuAzJ+l9cqv/HOe8RDBLTmRjkqbvtsv5JCK3xLwvS4IX8EZ8/SjV
         6Q7IHn05wLgrmc/arEErDk8RwG6jHa9XDMbpa9WICq5MmUtvUX0PVFkZzalTL1melKs9
         4tuaClDrlwT5l2ktTzOYxWKNUXPvUqr7mvkO6cHZ5M1CEyWtbNiQzp9ZUcz1BR4o7a41
         bn9d8ztRmGxI70XDhpV8xwChrUztL9t0QPRsCaKHSmC4Zt84hBs5K5Gb15Uh/xkryPPM
         ZFlQeH49toOb9dLytEpIU8Av8C+rjHe+VlqZ0Ga0aoSoFXfFffyzEHtNdcAxdyzp3OCM
         +vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395992; x=1794000792;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoEvjigjRTGfUMWnUZfAHJD9p1M3O4kUL5j7Sa2lBnc=;
        b=hSBB4CQtJiL/CESGsKkGmlhY6we8xYpqaGYgQWVHne4PWTxZRSB0FClGeJ9m+RU/RS
         WjGC/ZYYYe7Txf6UOG12dcsuunXtr3n1cCBlDabBfhtfJWWCPl35k6rtdzxm14HPawhk
         y0bBDpa9lp0wMmjpUWI1t/EyhtN/mjt9JsECVuwhdqKXgtd8X+5WpLaRnq46LLbUeJ6j
         Akwn0ckJWnyl7UpLG0Uq6m/CAJGEwMpriAFRmRx3XLbBIiQqcCV9XO1MxeahPQJndf3V
         53+L0zY95hXZBX6aNelQU5x3xXFmW7AaXWFzJ1tkrdDT/+c4ljLdRavBfndIMOgS98kW
         jMQw==
X-Forwarded-Encrypted: i=1; AKwUvBy2vDJQ0qVambN6U+MzyiOe/awTGVU12Tsx7MZ4jm165k8ZZcpxmr6rrSRKTAMrn7ZueAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIg86Ulj0CeZEL3J6nij75i/noAuCnZ77KcZhqrjV0KLHu640Zz
	LOnnxRhTGz10n+pcKqqzgJSogatoW6/uArPW/yasAPY0TBy+BobwXpQI
X-Gm-Gg: AYBFou3DzJT1ODIMRJLlpSPeAjhl4BWqElbpnUp9Cs5DpxJQj8tiWm/FfOO+mjyvyKc
	UHK0N32mMrx9VCewkzFx5dQd+UJHirnL2xxQkBZeuhF66Euzu7q3zGMuxHh+0Fo/kFEbiMV/yRL
	T3KX8nZHBbUUzjtNwnSKOird8sWBcRCSfk1qIS3WrHyFbWuBHPFNaDoSHILfxX52M4v3mxXQnVR
	f6U9EUtJkw7nSK1w03+8pfJ7s7sUo9BrpJro4l+rmrcaosXsvzBjskXzTUwS510OID2iBZRBosM
	FeiqqINxHT31HIM5Yd8Y447zTfQLa0IuYyfw2S4d4xBfoib2CdV5yFIkFKogPWqeUxISQ9Svfy/
	0HHL+S2xqCiFoEYTUBZQkmsHpyxeGgDl3f6uOIeXyihl0n//ElZJDy/ENz1VOqDCXMuRDkuUAIf
	IXIBPyOQGLS52284U5qR9yIpBwswk+6CTw90dKYuZ65C7phXH4QX3XTt4qJqn4Fas1RodPwhAEl
	onEjxVaIMj8YpuAhrPM6zROfdyfxdJFuoG/2WecybXs+ICQ5v6swUE62d6ffsCuzzXrxTKd9G0S
	g/Wx89s+3xWR2NMwWGUNIiv+dbMZygEZOtK2/Qwh
X-Received: by 2002:a05:701b:4549:20b0:143:1bb1:3305 with SMTP id a92af1059eb24-1a94abded94mr8484373c88.22.1793395991666;
        Fri, 30 Oct 2026 14:33:11 -0700 (PDT)
Received: from [192.168.0.11] ([106.51.26.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1d4dsm8832444c88.3.2026.10.30.14.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:33:10 -0700 (PDT)
Message-ID: <1e194ea7-2e28-4142-b678-d8cb8bca8e35@gmail.com>
Date: Sat, 31 Oct 2026 03:03:05 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Standardize early option scanning
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Justin Tobler <jltobler@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261012074413.337183-1-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 13:14, Christian Couder wrote:
> 
> Changes since v2
> ================
> 
> Thanks a lot to Junio and Kaartic who reviewed previous versions.
> 
> Rebased on top of a018953688 (Git 2.56, 2026-09-27) to start from a
> stable base.
> 
> There are a number of important changes since v2:
> 
>   - In patch 1/4, parse_options_takes_argument() now considers
>     PARSE_OPT_LASTARG_DEFAULT options as taking a value. This allows us
>     to remove a limitation that was in v2 as these options now consume
>     the next argument when there is one, like in parse_options().
> 
>   - Patch 2/4 is new, see above.
> 
>   - In patch 3/4, we reuse the new lookup_long_opt() function extracted
>     by patch 2/4. This removes a number of limitations (around negated
>     forms, unambiguous abbreviations and aliases) that were in v2, as
>     the early scan now behaves in a similar way as parse_options()
>     regarding long options. A number of tests have been added to ensure
>     that.
> 
>   - In patch 3/4, the scan now stops at short options, unknown options,
>     ambiguous or disallowed abbreviations, options with a low-level
>     callback, and value-taking options given as the last argument,
>     instead of skipping over them, as it could otherwise take an
>     option's value for an option.
> 
>   - In patch 3/4, early_scan_fn() has a new `unset` argument for
>     negated options, and early_scan_options() now returns the index of
>     the first argument not consumed also when the callback stops the
>     scan.
> 
>   - In patch 4/4, the commit message and documentation are updated to
>     account for the better behavior of the early scan. A related
>     NEEDSWORK comment is also removed, and some tests added.
>

The v3 seems to be in a much better state to me. Just left a few minor 
comments.

Thank you for working on this!

-- 
Sivaraam

