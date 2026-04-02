Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DF3E8C42
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139889; cv=none; b=F4bg5pN2Q5i/3L7lXh/9I+WTQfR3feFqkhwK4mqtX8RnstUU2+tXoUIbWU27CI4Ta/NOYAbrg9HQmf6AFeOsDX5yBMlp+oV+YpaQbi9oYXIARwjw2YBbvmC2uqbxLCMps9n49eMMhpXYWL0fUPT2WpT9KQAVMauEOpu+YJ1wb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139889; c=relaxed/simple;
	bh=z1E1G8rRpkuDySMTPcJEO3HusUAdaptMi6fuROvDeBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRal4EZDg+6CEsKSJ8PvqOvjJKJ13Ql70V4bvx2seHtwDbexasDi7OMlWAChJAaWK4tywzjVYA7I7wR6ytKx4koEnAFafCieYdzyCVsyZ+HmqxmnIezvs1axdmgGU7RGANlQHVsTNcWITGOh8lgdGssXr1zByJOQzP0JnqdDokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfFRD9KX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfFRD9KX"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89e8e352dc1so5810406d6.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775139886; x=1775744686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUQ8oGDCPD3PkURNS3yw7GFAo1v4DtQapPqwStD+qQA=;
        b=FfFRD9KXN3q2iic1RC55ExwMzgwInABQPyeWqHT3VK+xUjzWTAlVDKVgwiFd6qvFLG
         Lu7S7NWqKXvN3QXr+pyAR1ZLFLXGB187OUJWfsSw42mjnaU9UVxTu0Fr7tkKR+/tKJee
         rfsMAmez+uqFKCF9SuXmMSlfzL/J/bd5vYufw3Biwe+PSwiQJ9Nf+Q9nhJ/fKrnCWYVH
         U+o30+p0O7ovnBqoZCMcudweIvNaRVyxRDGXtUXkT6tUay3iImneIfKlLGDwLLjCeEwE
         GmVchS5SNkUaVoN7187lPH9OTPdYM8EjU79qh2FTrbGsAGVkVtIbKsvS0kQ8WnV8GjNH
         Fdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139886; x=1775744686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUQ8oGDCPD3PkURNS3yw7GFAo1v4DtQapPqwStD+qQA=;
        b=pOb8JdxLInyP9vnpBmK+tFLXszxfdji1k/+7w/MRggP4N++nENFSOyo05nyV6IWt/M
         3xhsjqZlBxLROADyYA74NhAgkMdLyLTBA8XoAkPKzObRvgGUf+tuVfNqCCWrKGxGICgq
         VPgkkAiHwNUGOwIYUIqL0AFf6FaEviOW5f2IL3A9KFPHKqWaVWDFSGXovTVxN9Ju0+WP
         mWl62xpFwybxGVNq/cKmkCkJ0wT4MRKZk5KouKk1BjctwusJ7e3qlIPerPqzP4OMROfn
         eUAzbpTmU5c/loS2ol/xOJd3fMdxJk85j1Hj0Pj7eC4U8hz6exsF/OOYpRTZTiJhP0Cj
         wIzw==
X-Gm-Message-State: AOJu0Yz4HS794IC/moo1wtAR8SwBRXWdQBa20DOCb+EyZZaGRwk5lQ0v
	3UtKzof23KunY2563wjx+DR1ilvRb4MHberC6GDGTLJ+K5f1xXZyZDhA
X-Gm-Gg: AeBDies5u8h54hvsPf+cK1YY/LTrHfRJ3yaX9n6t3M9DPNlV2s7y8TO1nImHYIGZSKg
	0xReiWqvS8+zHzCAnXuIxdNPVnljlxD6fnEPuR5IeRo5M62TriYVyhJaSZj8Sgmr+1GV+bfVIje
	taYcmPUVGoXpIGHgE1OjPFeVg4XzHqzyxraw9Ea+oiOfliBTWVFsHBeA25GecSwPnKoXPQzJE2q
	/yccSzAIyISuxD15cwD/ZwcD/GqFZ9c0nH5uohjuWLiQ9TZj+vE7bcWONOf0WKxwSPC0cNGfXtk
	l8ldHXlRFiVUPrLXTdUwXnpmzbarP4uucOP0sVhA/4V0kZfURmr3aBBY+qs/yLODSpEd5q5+qe8
	jBzH7OBL5thEezfpYN2UaEjmxW2uy57SpcpcSsTkITup3OA1TZP+G0Ss4874cUsrWrcM1sR9iB/
	N/gxOi9rJOc4gFGtfGp68+/gchQ0u7atpRK+kFPWU4KhJHFPz6QPisqaG//3yfKBzD9+SCeaxtQ
	yCEQUESllYk98GHxepYrJ5GBGoVFBFiKLwhf6L/R/50arf8
X-Received: by 2002:a05:6214:8088:b0:8a4:8b2c:428e with SMTP id 6a1803df08f44-8a48b3bad5amr87396466d6.6.1775139886160;
        Thu, 02 Apr 2026 07:24:46 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:4872:ad35:e6d:aa17? ([2605:a601:a6b4:9c00:4872:ad35:e6d:aa17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977e00b4sm23788046d6.47.2026.04.02.07.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 07:24:45 -0700 (PDT)
Message-ID: <b7164e46-0521-4c0c-984e-35fc1891e4bd@gmail.com>
Date: Thu, 2 Apr 2026 10:24:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] backfill: auto-detect sparse-checkout from config
To: Trieu Huynh <vikingtc4@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260331112516.772635-1-vikingtc4@gmail.com>
 <xmqqo6k40wbl.fsf@gitster.g>
 <buisigjsw3zrcy6bqaic2zefypq37kimju32eufquppsvkgkvx@cqd3cwj6an6t>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <buisigjsw3zrcy6bqaic2zefypq37kimju32eufquppsvkgkvx@cqd3cwj6an6t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/26 3:31 PM, Trieu Huynh wrote:
> On Tue, Mar 31, 2026 at 09:59:10AM -0700, Junio C Hamano wrote:

>>> diff --git a/builtin/backfill.c b/builtin/backfill.c
>>> index 4b2db94173..0f31844ce7 100644
>>> --- a/builtin/backfill.c
>>> +++ b/builtin/backfill.c
>>> @@ -124,7 +124,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>>>   		.repo = repo,
>>>   		.current_batch = OID_ARRAY_INIT,
>>>   		.min_batch_size = 50000,
>>> -		.sparse = 0,
>>> +		.sparse = -1,
>>>   		.show_progress = -1,
>>>   	};
>>>   	struct option options[] = {
>>
>> I am a bit confused by this change.  What's the difference between
>> using -1 (which you picked) and 1 as the initial value for this
>> member?  From the proposed log message, I would have expected a new
>> code that says "ah, we notice, from this member being -1, that the
>> user did not specify --no-sparse or --sparse, so let's figure out if
>> our working tree is sparsely checked out ourselves and set it either
>> to 0 or to 1", but there is nothing like that in the code.  It seems
>> that the updated code relies on the fact that this part of
>> do_backfill() only cares if .sparse is zero or not, and ...
>>
>> 	if (ctx->sparse) {
>> 		CALLOC_ARRAY(info.pl, 1);
>> 		if (get_sparse_checkout_patterns(info.pl)) {
>> 			path_walk_info_clear(&info);
>> 			return error(_("problem loading sparse-checkout"));
>> 		}
>> 	}
>>
>> ... relies on get_sparse_checkout_patterns() not to do any harm when
>> the working tree is not sparsely checked out.
>>
>> I am not sure if we want to call it "auto-detction".  It looks more
>> like "default to --sparse, relying that --sparse is a no-op in a
>> non-sparse working tree" at least to me.  Not that it is necessarily
>> wrong, and when people do "backfill" knowing that the working tree
>> is sparse, I am sympathetic if they prefer to keep the sparseness,
>> so such a change of default may be beneficial.
>>
> actually, the logic IIUC here is:
> - first, ctx.sprase originally is set to 0.
> - then, it check user's options. Assume, there is no option passed,
> still 0.
> - then, it check repo's config (core.sparseCheckout (default to 0 in
> enviroment.c) but it doesn't since the guard:
> 	if (ctx.sparse < 0)
> 		ctx.sparse = cfg->apply_sparse_checkout;
> - evenly. ctx.sparse still 0 eventhough in case the
> core.sparseCheckout = 1 (git config core.sparseCheckout true)
> 
> IMHO, this change set the default value to -1, then it can fallback to
> repo's config value if user has no-op passing (default to 0 (full
> backfill if user doesnt intent to config previously either).
>> Derrick, what do you think?

Indeed, I thought this was how it already worked, as 85127bcdea
(backfill: assume --sparse when sparse-checkout is enabled,
2025-02-03) (introduced in [1]) should have covered.

[1] 
https://lore.kernel.org/git/f22cf8b34851a3ba4cd6ab1d31f0835579143c40.1738602667.git.gitgitgadget@gmail.com/

However, that change did not include this test:

>>> +test_expect_success 'backfill auto-detects sparse-checkout from config' '
>>> +	git clone --sparse --filter=blob:none \
>>> +		--single-branch --branch=main \
>>> +		"file://$(pwd)/srv.bare" backfill-auto-sparse &&
>>> +
>>> +	git -C backfill-auto-sparse rev-list --quiet --objects --missing=print HEAD >missing &&
>>> +	test_line_count = 44 missing &&
>>> +
>>> +	GIT_TRACE2_EVENT="$(pwd)/auto-sparse-trace" git \
>>> +		-C backfill-auto-sparse backfill &&
>>> +
>>> +	test_trace2_data promisor fetch_count 4 <auto-sparse-trace &&
>>> +	test_trace2_data path-walk paths 5 <auto-sparse-trace
>>> +'

This actually demonstrates the behavior that I was intending
to introduce in that change, but made an error in (1) not testing
it like I thought I had, and (2) not doing exactly what this change
does by having the .sparse option initialized as -1 (unset).

The code and commit message do a good job of identifying this bug
and difference in behavior. The only suggestion I have is to update
the commit message to point to my original commit that failed to
implement this behavior in the expected way.

Thanks,
-Stolee



