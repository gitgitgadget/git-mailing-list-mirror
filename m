Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B0361672
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993595; cv=none; b=bIIp3tTQc6Q5Xntz2z5stx3ctDPhQa3rBJqd2VnlDlvco5lnXlaMsQiA5Ukehe/v7hTDpZp3sOazZGkOWlFQneHqfx3HixEvyXb3pAgyKJRftlzkuYHIzyHXVkVI8Fpo00HWO24xYLaTd0Y9JqlDNs8nc5fCnM+3bp8WpitOFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993595; c=relaxed/simple;
	bh=ZPkDB8g6qpgZMHmfQA8zKprAkzQY5lnCry88GjPB6h0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SjCWg2m8LoRFSfDLzc31uYvTkqNOJd8p2Vh8cw5SEd/9an+lqSQF9Jj8AmPC185RBC+CqFBDB2kp0YbJX8v/sumfA2+mKO6XPnfh4lK/aljl3co4ciG3pqLAqzMNHK4VKDAweqXTjQQsMS2fvQm9KPdQ8q+uwoKDKbmkCp+z/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnRI153k; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnRI153k"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso8271865e9.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770993590; x=1771598390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riy8ejXz8zTA6T2Emsh9AUWrH1pzaqXAgcNJRPlXxWw=;
        b=JnRI153kiFapCsf7Sxg6s8uwapF4hS9TNUoeYejsDhKZps+cVTzXGRk5RZsuzoode2
         fKQDulzsN0KOzlXltq4SOi4kU6EUQuzzLXR93Q8IVIl/kl167GEDgMUVgtEETCTS0a69
         4kH4qCSooGbfNYCr82irn4CKQ6D5OPcadztbzj2rGrtwL2jUL1qS7mRPAxkObSpTkFoB
         HEi06koFSGcM8LMBJJ+vXi50HL0lUECcBynMHnNiRefYrcFnJ7pN6Z+f/bdyzqgL4B4E
         SNMAYPnvbHOLpOSEfAWEXI9/MmlOkKHzq3llRjog0aX3TGtOAQLV163JTIXaFQ01HUlb
         IykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993590; x=1771598390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riy8ejXz8zTA6T2Emsh9AUWrH1pzaqXAgcNJRPlXxWw=;
        b=DVjT5nAaSVfnal1Du4QfJBpW+VeY5/hqlf7AncND/w81qkT1C00lPgcIHWx+E20yY3
         bWkAiT4Ktl4ObNkmBqeqdascj9BQ70RfL49M0OB9EbMD89dXSuv70xHo75z75gsSBL0z
         s1Vw468r+RV3jT3e84WmL/Dm5Ysze2EN7XU9FjZLYtp8C5Qkwr+qXq6p4HSxR75E5+mt
         YU0vqyxrAFESonBvfPvOP7oXKFaAT9aTpm+v2Jg6cOhOb1DhUxusYXyhp3i4oawwvTnY
         DODlPnYO2sEPLNa7+yFQRKye2K4zV2iDsaolqiy3rqUrktG6xXYxqRNC0qUDpSTVp6S1
         mklQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2VIad7xpqCVz/3tc69Wc8W/2pBdIU7iRvp1XI8kGD+1GOTDqmw8TsxA9We+qWk6qRyvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+Tjj4nNSD4JYDuMl4TaQPF2cn2qKzQTzFLPsDndIvhCNGmxw
	ekZYQKaVA72Spcn3OwX8Sq4mysQOCWenMNr8KiKGRwqBw8HnXz13rOXzuRJ8QGsi
X-Gm-Gg: AZuq6aKjP/Q2QbFYvSbL7+dTw1EBzeJI9RkIwCNUJbEBVAaf9EoY/rEGBxdeD+xhkKw
	LPxmG+IU6QYXoQIVzcVvzJHWZbw5pDZwOK3af6sN6LDKv99WRNmwurcwlCdGiAexo6Nq1O6lArv
	//gv1aTKFcJvxynwyu3KjNovGo/18WGPBV9eUkbl2rhI48rZUS64NrtwNBC8kzUNmzi8ZUM1Ur5
	ZQgZMqhka3PpwnjbCGbllT5l7f8kkfV2MpzjXRHvM+/KYEqJhTPI1ejxdF/iY97kZX45oOUUF2h
	Rh5aW5ikLMmf/JqW12iM+XIcMnSqNX9lY6WJy3vO+/AO9GblCCMYymLfi9yjOKLDqIoA78pJ0oz
	/2jAXCAcY9DRZz072f0x0fB7ese+yFQzHWjhsfeQN1yz4cywUFZZtGHNgEJIkdeqbJ407h2ArwO
	Wkyk5JCyx9P0ublBt20HWaYxyOFT6G3vRyWF+O5ago0Bw0ZKVNXWIPuAABoZXk4gyqIHHkBdqC+
	NbS8Q==
X-Received: by 2002:a05:600c:a085:b0:480:6941:d38b with SMTP id 5b1f17b1804b1-48373a7460fmr31183225e9.30.1770993590357;
        Fri, 13 Feb 2026 06:39:50 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm336987775e9.9.2026.02.13.06.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 06:39:49 -0800 (PST)
Message-ID: <1dd09e04-dbdb-4a6c-933a-e4dc451878f9@gmail.com>
Date: Fri, 13 Feb 2026 14:39:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] Run hooks in parallel
To: Adrian Ratiu <adrian.ratiu@collabora.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <eedde9c3-2aff-433b-9dc3-f8593d53dec0@gmail.com>
 <87jywiox9f.fsf@collabora.com>
Content-Language: en-US
In-Reply-To: <87jywiox9f.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/02/2026 14:24, Adrian Ratiu wrote:
> On Thu, 12 Feb 2026, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> Hi Adrian
>>
>> On 04/02/2026 17:33, Adrian Ratiu wrote:
>>> Hello everyone,
>>>
>>> This enables running hook commands in parallel and is based on the patch
>>> series enabling config hooks [1], which added the ability to run a list
>>> of hooks for each hook event.
>>>
>>> For context, hooks used to run sequentially due to hardcoded .jobs == 1
>>> in hook.c, leading to .processes == 1 in run-command.c. We're removing
>>> that restriction for hooks known to be safe to parallelize.
>>>
>>> The parallelism enabled here is to run multiple hook commands/scripts
>>> in parallel for a single event, for example the pre-push event might
>>> trigger linters / spell checkers / unit tests to run at the same time.
>>>
>>> Another kind of parallelism is to split the hook input to multiple
>>> child processes, running the same command in parallel on subsets of
>>> the hook input. This series does not do that. It might be a future
>>> addition on top of this, since it's kind of a lower-level parallelism.
>>
>> There's quite a lot of prior-art on parallelization from the various
>> hook managers - is there anything we can learn from them? For example I
>> know some of them serialize the pre-commit hook by default as it may
>> update the index but allow the user to configure a subset of scripts
>> that can be parallelized. They also allow for parallelization where
>> different scripts update different files (e.g. code formatters for
>> python and C can run in parallel). We don't need to implement all that
>> now but we should design our config so that we can support it in the future.
> 
> Yes, all the prior-art is very useful and it is possible to do
> finer-grained (or lower-level? :-) ) parallelism further with the
> new run-command parallelization design, APIs and config.
> 
> Obviously that will require more work and doing careful analysis on each
> hook-by-hook case. I'm just adding the basic buliding blocks and
> enabling the "highest-level" (most... independent?... level between
> tasks) of parallelism here.
> 
> My approach to this big problem was to simplify and break it down into
> smaller / easier-to-manage chunks. I'm still splitting up commits and
> untangling logic to ensure each part is done properly (also easier to
> review) and can work independently (no regresions etc) before building
> on top of it.

That sounds sensible and should make it easier to review, so long as we 
design the configuration in a way that it can be extended as we add more 
features.

> Thank you, and everyone else, so much for all the help and patience.
> 
>>> The pre-push hook is special because it is the only known hook to break
>>> backward compatibility when running in parallel, due to run-command
>>> collating its outputs via a pipe, so I added an extension for it.
>>> Users can opt-in to this extension with a runtime config.
>>
>> In the past we had a regression report [1] when the pre-commit hook
>> stopped having access to the terminal. I've not been following the hook
>> changes, is this series (or any of your preparatory series) in danger of
>> reintroducing that regression?
> 
> Thank you for raising this, it is a very valuable data point!
> 
> The preparatory series 100% will not reintroduce it.
> 
> This series might reintroduce it, depending how we set the defaults.
> 
> By that I mean:
>      -j1 will keep all hooks connected to the tty, just like before.
>      -jN with N>1 will disconnect the hooks from the tty and their
>          outputs will get buffered through run-command's pipes.
> 
> The design I followed (which to be transparent is Peff's design, I just
> implemented his ideas :), is the keep the original, serialized behavior
> exactly how it was before, to not introduce any regressions and to also
> keep identical "real-time" performance.
> 
> Taking this into account, together with Patrick's feedback on this
> series, I do intend keep the jobs == 1 default for all hooks in v2.

I think that would be safer. If we could opt-in to parallel execution on 
a per-hook basis would that be a solution for the "pre-push" hook? Users 
who want to keep the current behavior would avoid configuring parallel 
execution for that hook.

Thanks

Phillip

>>
>> Thanks for working on this - both config based hooks and parallel
>> execution are really nice improvements.
> 
> Thank you for the kind words. :)

