Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287728F1
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030835; cv=none; b=UCFzMfRn4S5VB9wqY4jjfpOBbR+0CFLW4FYan8z7Uyd2oRL5B0gHvmfJY3wmun3JR4sIO1MsHBeHo2OpdaROmIzUW1shMTfSGU+7qBKWoKtqFY1Ojqfs6eSAikXdHvmf5Ro9HLhlEhtziBEUmf2Rp92zMB8JdRNK9RK0OFGKQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030835; c=relaxed/simple;
	bh=To8iFFmttzLbswQ+lzdQ2N/3kZzQTdixe0zx3RrCS98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EW12ZG8zI+w8jV1yEcKVxw678UYiqS0LQN9G2703Br6CXgaQYbh0PMA8MqGXjg678wRs6cMLS+Cj3YG79IdWwekrMfHU4tgBWx6mzeBJO+qtA0f8pz7BXxh66HaRs3ddPCG9gDlxZ5t13zELKX96l3XCR9fiNy+W9IWit8j8fxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=easfqzFl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="easfqzFl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so10340395e9.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757030832; x=1757635632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9OCslP5+to20RbmwCtSj5+ONdge+NSERx+4RjqKB+E=;
        b=easfqzFl9KXVgHZ40TWO5PkXQSSN8W7Pc6G93XBZbMNESnJzbHZAe0kOFqBkexZsNj
         fbYFgR74qdPFT84BBtdH2fVMEkKRLfIvbgX41y5/zehOX7Yvo9yva423mzL2yWNt/XkJ
         16WV9Y+R6Z7bZRfqd6l9bbAxfQ+uwxp3/GbXfni13zkEOgWWUIhxD1/bNx1jN5kbz3Ue
         ftwdKf8CzZTAbrp93+VksNShMXYUJCvgUReSe4kLk1YWno1ptkMoPX1AL4llqrWkuzyf
         e5IO4Su+Knd91+uyDAdQr2GlQNvUQD2YFOL+Z2zHgY+IbS16SjgseX2cBWm+uLJXVaYQ
         N4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757030832; x=1757635632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9OCslP5+to20RbmwCtSj5+ONdge+NSERx+4RjqKB+E=;
        b=FVP7ewW2If0Xx/hO/0OnMLFy1+s1E5bVwjBkquceK+R+lJpGv2soO6x2tiD5JqjM41
         v6d26PDkkUtufVP2armZSKmzjnaO2HxhqwZ3iGSbXSrV+DGjt1Mq3Pbe6WaqLms3Hr0j
         KbAhy7yiR6frP9XK0rFYyJs0UEhYjxx04Hv0FJ7+aut/14vAuXerxZCgdE5bwULa7/Y5
         hQTySsIUPzIiljfuLEJUMOwQJAnATCRz9lwZ5D6+ca6cIH8YA34FkD/TvpebjPYeFp81
         rYCg4vFJRTocipopvaW7oFZqJy1PjFTT6J3vnhM7V109jJj1s7AVQP/5aiuH5KTOdVbq
         +bwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYmIj9r4SjFpt6WCIwGQTS7kXVfYnkaM4r4kpQCZA/8XR10ayGeQpNWuvgLz5IQ7tx0sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JtoWEexnq461KKUw/ENZcJkrabBMHXtONsMxpDF+tnF3cuh8
	1jVT9ccHcl2YEQZ5FBwLpKTkCS8LNa6HN4g2FuYONmzl5Q8j7fbQHq+F
X-Gm-Gg: ASbGncuTW8ckRnO4kMz3oEabczxCpLFNH7Jwfb5YikZ9P9OM1OXW2WGZzGdz7KLinPk
	rIAnqcLL7AIMKc1ny7FgNIsZddM1ZcmvybLAT1z/LZX6yMlENUeDcafFPC+cgV61v8zYYcfqi3a
	XVm8PxMf0zzLVqhewDrTdlwZV/pcw7tVQRV7GwmhmioNKEGcmuicIDrn/uL9FGdfyxDvOfzfnOk
	8peAm1YPcWCK1NgAHp3M7WIGUdwcEPkejoPg6zYBXjC2NjF0oq1hRgmCJMqSckBFCwI6YBrH6MP
	bfzxknQOO2LLSN86g93z3+hGVuq4qTCuWxbHOGJHSF/fwuRrcH3Ljj5mE0JhVYodyFmrv2d8sXq
	ChE0ZJiqeALgkdjt6IyplomQOhOWZwkfs0Dfg1ZHpw/xSqCTmFeH4HGrQben/5o/BV0cD1YFBYP
	ftJA==
X-Google-Smtp-Source: AGHT+IFdfrBTxLRQQG8fxMhwQhSfzy7obs0BVoIT0TzkCYwPZ4DtC7rU0MiwznAMb2t+vkDQmonLjw==
X-Received: by 2002:a05:600c:1546:b0:45d:d5fb:185b with SMTP id 5b1f17b1804b1-45dd5fb2307mr7758455e9.20.1757030831617;
        Thu, 04 Sep 2025 17:07:11 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-192-26.dyn.orange.be. [178.51.192.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm23816805e9.1.2025.09.04.17.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 17:07:11 -0700 (PDT)
Message-ID: <52fb3fea-4842-4532-8572-df41537da5f9@gmail.com>
Date: Fri, 5 Sep 2025 02:07:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmUgdmlhIEdpdEdpdEdhZGdldA==?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net> <xmqqjz2d7t2q.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmU=?= <nouraellm@gmail.com>
In-Reply-To: <xmqqjz2d7t2q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

No. I am confused here.

 > It is a programming error, period.  Do not silently return. That's
 > not being defensive.  That is sweeping a problem under the rug.

Yet

 > +    if (!s) return;

However, I agree with Peff. After calling alloc_state_free_and_null(&foo)
Having foo == NULL is an expected behavior, especially since the function
Is designed to free the memory and null out the caller’s pointer using
A double pointer ensuring the helper is idempotent

So, calling it again on the same pointer is safe because it simply
no-ops if the memory is already freed

Regarding the sanity check, it should be:

+ if (!*s) return;

The reasoning is the following:

=> s is the double pointer (the address of the caller’s pointer)
=> *s is the actual pointer to the memory we want to free

Thus, we check !*s to allow the function to safely handle already-NULL 
pointers
But if we instead checked !s then we would be testing whether the caller 
passed
A NULL double pointer which is a programmer error
So silently returning on !s would hide a bug

Finally, I'd appreciate more explicit instructions.

On 05/09/2025 00:26, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> It's probably not worth going back and forth on this too much, but I
>> thought the happy medium was:
>>
>>    if (!s)
>> 	return;
>>
>> That is, it is perfectly reasonable and friendly for it to be a noop to
>> free-and-null a NULL value (either never initialized, or already freed).
>> The overkill was worrying about whether somebody passed in a NULL
>> double-pointer. I.e., doing:
>>
>>    alloc_state_free_and_null(&foo);
>>
>> is reasonable and should be idempotent
> ... when foo == NULL, e.g., after alloc_state_free_and_null(&foo)
> has just successfully returned?
>
> I can by that argument with the reasoning in the updated log message
> below.  Does it good to everybody?
>
> Thanks.
>
> --- >8 ---
> From: ノウラ | Flare <nouraellm@gmail.com>
> Subject: [PATCH] alloc: fix dangling pointer in alloc_state cleanup
>
> All callers of clear_alloc_state() immediately free what they
> cleared, so currently it does not hurt anybody that the
> alloc_state is left in an unreusable state, but it is an
> error-prone API. Replace it with a new function that clears but
> in addition frees the structure, as well as NULLing the pointer
> that points at it and adjust existing callers.
>
> As it is a moral equivalent of FREE_AND_NULL(), except that what it
> frees has internal structure that needs to be cleaned, allow the
> helper to be called twice in a row, by making a call with a pointer
> to a pointer variable that already is NULLed.
>
> While at it, rename allocate_alloc_state() and name the new
> function alloc_state_free_and_null(), to follow more closely the
> function naming convention specified in the CodingGuidelines
> (namely, functions about S are named with S_ prefix and then
> verb).
>
> Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   alloc.c  | 10 ++++++++--
>   alloc.h  |  4 ++--
>   object.c | 26 ++++++++++----------------
>   3 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/alloc.c b/alloc.c
> index 377e80f5dd..533a045c2a 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -36,19 +36,25 @@ struct alloc_state {
>   	int slab_nr, slab_alloc;
>   };
>   
> -struct alloc_state *allocate_alloc_state(void)
> +struct alloc_state *alloc_state_alloc(void)
>   {
>   	return xcalloc(1, sizeof(struct alloc_state));
>   }
>   
> -void clear_alloc_state(struct alloc_state *s)
> +void alloc_state_free_and_null(struct alloc_state **s_)
>   {
> +	struct alloc_state *s = *s_;
> +
> +	if (!s)
> +		return;
> +
>   	while (s->slab_nr > 0) {
>   		s->slab_nr--;
>   		free(s->slabs[s->slab_nr]);
>   	}
>   
>   	FREE_AND_NULL(s->slabs);
> +	FREE_AND_NULL(*s_);
>   }
>   
>   static inline void *alloc_node(struct alloc_state *s, size_t node_size)
> diff --git a/alloc.h b/alloc.h
> index 3f4a0ad310..87a47a9709 100644
> --- a/alloc.h
> +++ b/alloc.h
> @@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
>   void *alloc_tag_node(struct repository *r);
>   void *alloc_object_node(struct repository *r);
>   
> -struct alloc_state *allocate_alloc_state(void);
> -void clear_alloc_state(struct alloc_state *s);
> +struct alloc_state *alloc_state_alloc(void);
> +void alloc_state_free_and_null(struct alloc_state **s_);
>   
>   #endif
> diff --git a/object.c b/object.c
> index c1553ee433..986114a6db 100644
> --- a/object.c
> +++ b/object.c
> @@ -517,12 +517,11 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
>   	memset(o, 0, sizeof(*o));
>   
>   	o->repo = repo;
> -	o->blob_state = allocate_alloc_state();
> -	o->tree_state = allocate_alloc_state();
> -	o->commit_state = allocate_alloc_state();
> -	o->tag_state = allocate_alloc_state();
> -	o->object_state = allocate_alloc_state();
> -
> +	o->blob_state = alloc_state_alloc();
> +	o->tree_state = alloc_state_alloc();
> +	o->commit_state = alloc_state_alloc();
> +	o->tag_state = alloc_state_alloc();
> +	o->object_state = alloc_state_alloc();
>   	o->is_shallow = -1;
>   	CALLOC_ARRAY(o->shallow_stat, 1);
>   
> @@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
>   	o->buffer_slab = NULL;
>   
>   	parsed_object_pool_reset_commit_grafts(o);
> -	clear_alloc_state(o->blob_state);
> -	clear_alloc_state(o->tree_state);
> -	clear_alloc_state(o->commit_state);
> -	clear_alloc_state(o->tag_state);
> -	clear_alloc_state(o->object_state);
> +	alloc_state_free_and_null(&o->blob_state);
> +	alloc_state_free_and_null(&o->tree_state);
> +	alloc_state_free_and_null(&o->commit_state);
> +	alloc_state_free_and_null(&o->tag_state);
> +	alloc_state_free_and_null(&o->object_state);
>   	stat_validity_clear(o->shallow_stat);
> -	FREE_AND_NULL(o->blob_state);
> -	FREE_AND_NULL(o->tree_state);
> -	FREE_AND_NULL(o->commit_state);
> -	FREE_AND_NULL(o->tag_state);
> -	FREE_AND_NULL(o->object_state);
>   	FREE_AND_NULL(o->shallow_stat);
>   }
