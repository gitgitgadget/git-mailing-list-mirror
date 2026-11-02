Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641946;
	b=NBupkukLRLmPatTYc1bWcq2SJGBVJWQQkAOIdmh9gctSRlkPhKheQImwuGoQd6ch4YhD
	 n5fhQvSwWTpAjfyeZArh39IKooomdnheOnZLjZL6ADEQ3LJ/eq3mjVjbE1DZzezi8TwA3
	 +GTDY/zJXjGS5FdvK+nofRZFS/SWmMYvUCicRnyFlO+gsDjjdoHB45gYUCQof8fEiUNQx
	 gHje//GX04PTjFNfIq3VwNc2JnOQYjHH81PjTzS1Nakn2tu60YHMYDxuDGJIGfV4E+JFJ
	 1Fs6rzEYQhVJjWgtUCMnrSTq76g9N9xnH10mZzBh2jt/yAMiXzqmo6gdq0mmkxcnELg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=v42zZgz8uknIn6Xp1Asx1VeFCvYGUHKEjk42ELEWTfY=;
	b=xYKmY0dVSBQ2xr3Uqww6eo/EfkGk5lHnCJa3Ud9IhbjoyHtfNF2sUTPwnYL0+1+j7dHy
	 +qcuFydySWpAC4Dl5/Y6tEwCAEHNWUeTIFvkWvmWZMWl3TorKlHh+orzJbpGiJ41qtzuA
	 ZUWNlUFKhZl+NnGJCn39DLBExrickALuZZV5gj7cq2NGX6PY0PEfJCt1Ap4KXC3G7pN6m
	 Evlp3WnQLVPnBlhwmfyflXl4/1Rh6F79WE5tP8WOFGXLjxrOdMHwIqldvngIvxCwR4cVZ
	 3mJJyWa8UaVj363J1DyFFnfi1jWCSKIfQ2WcF4ACWPnYsUYU+zBWQg6ekpa4dHG/2hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yU5WDANF;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56EC606AE9F
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 17:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A56EC606AE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yU5WDANF
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e64d52949so293462785a.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641944; x=1794246744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v42zZgz8uknIn6Xp1Asx1VeFCvYGUHKEjk42ELEWTfY=;
        b=yU5WDANFAd6vwdgEAUcbaQniacPvsPdB+3fBqxdARePYKTbI3lFMk8OxGJZV4KDbye
         FVs/yWLUrQ+OsyQoJFmYnCpEsduIK0Zc96jUjfiEc0nnB7MHHTHZ7KdzSVAmI0S4PqZV
         UjIaffy66ySm6wg1Fip8fknhPMvW0BszeVZHr9OrFywTh7J4wlqcWGLFKn+vv31+aNbl
         9eivFyMfC8MsdSpO1oDvchD8svZ8wK3cYtoKDljguQXKL343Xgcqy79IJzdqLEoP1P02
         OqDAiGpleD+uGzg4go8irx9s+kcRxlU9A2EItUoHa4Grtmvt0QhFA8lxDhX89IMhsBZb
         6PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641944; x=1794246744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v42zZgz8uknIn6Xp1Asx1VeFCvYGUHKEjk42ELEWTfY=;
        b=Kv5KzDlVplVmrt974yFCsXb2tMmmdzQngCy7DkILj6oMCTcjuPpa/1i6oxmUDwbDkP
         cQ/WC/LjtkVHUR6QtinlOB7ASbiT6r+tpNZvMJ7U34rYoCQl6O3n9nxhmhO/6aVuI5oU
         VvrJmYTrqspAJN+u6tpu6V2uxlmduLGM/KUZCTxG7CPLF1KGXl3f0PQtlLxQbFtiZR77
         tRzzDDMrrdoaSPc5mFNzXTo/9p7yd03yhfidb3tQeFp5cayLrd51MdA1cHCpRC4LaCjK
         YIUej9+RwZrKgaIqL015jGslTnqAHhoC+kiPAQRsQlVG/TvDilV1YZE/HXbzEOUWZMqA
         q7Eg==
X-Gm-Message-State: AFq9FYLYVFfm6r6P5sENWOYHWlchvLvr4Gm0QgCBD1ca9coqbsTm8Uaf
	IjLUekH97ceD11g3rveY/iUr5YbaHXXkJHZ3YVFY4BsmOOfhEz1Ene9r
X-Gm-Gg: AYBFou2VpUWz/kt/rNnkJRH1C7v53GMRSaaeamoj4DCz4q16TTfUVSRhyMMRHzGsK0F
	DfnlQju076tAzsDw0u77b1Ei9UlTQ4aTguuUYRtvzljmU4IBp8hsMJPhb5mMQhpCHHwYQJ3vEF4
	YK29rjnA+ESSIiYCioOFnRRXaWoiJeuVvL/7k6crIOgc9iwjSzuFf5u2xeyhySqOVRQxwVHtX4N
	y3s7GhlAetJd+uCfAd/9K8NF8Q5CXeIacd2sleJk3s82aDGwkIZ6bdB+xyBw4TV/Yl7r2j3otVG
	U8Q95vsbYUSmyJLQITB6o8czKSh9mva7AmMA+mlu5OzWLQ9B2axdZNHp2uE9b0uu9xdbEWosoeh
	hifq2jnQasyOlcr3emr1jEtU+s8k3f8jaJ4COMGWevPdbWry2Tpfu3+Ecxcs9vr1OYCjcDzCUlb
	X1NMhurJ5lk0fjsWhxlRHhhW7lOf7ooocHhAsQnySx7kORrFrhdXSVKfP+K8CEnC9Jnp4kuWVY/
	vRC4ysqOLVHXMqqNkqlJDLZTjIPOWuNwl4dhSM2jNxxuD2b1o7LCB9wys0u/G+OfsMipm1CfBd7
	CTIWY7PPddMepVkGmbGT5MfKoqdvm/2h7Jkh9M5vmdmif0r24HrvZv1lMF6LpDyToM5z3K2kUI+
	ooEGCm4Vti7fa2vo+fUQKQXM9Pt0tciB83oJnmej0OywW/UqRpzA00TROUreHchbuzv+xanryAz
	61V6snGPE0Hbx08mgyJO+eGYrmZYIKPznhO8J00smK0876+GxjjpPwWg==
X-Received: by 2002:a05:620a:1a22:b0:93f:2d10:ea44 with SMTP id af79cd13be357-944217ef451mr1777408485a.52.1793641944504;
        Mon, 02 Nov 2026 09:52:24 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e2749asm96173026d6.1.2026.11.02.09.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:52:23 -0800 (PST)
Message-ID: <fd7da4e6-ed30-4d83-8c8e-233a778f9a19@gmail.com>
Date: Mon, 2 Nov 2026 12:52:23 -0500
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
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20261031065525.19883-2-torvalds@kernel.org>
 <auiGP4XhObUzC9vD@pks.im> <8fa4010d-d39f-4e78-ab01-be3e9d20a148@gmail.com>
 <xmqqqzh3jhcy.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqqzh3jhcy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/2026 12:03 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>>>>  	struct commit_name *n;
>>>>  	struct possible_tag all_matches[MAX_TAGS];
>>>>  	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
>>>
>>> ... I wonder whether we should also call `ensure_generations_valid()`
>>> here. That function is very expensive in cases where we don't have a
>>> commit graph as it backfills generation numbers, and it may have to walk
>>> the complete commit graph to do so. But isn't that better compared to
>>> silently yielding a potentially-wrong result?
>> I came here to say exactly that. Even when a commit-graph exists, it can
>> be slightly behind the object database and so we need to fix up the
>> newest commits with generation number details.
>>
>> The biggest downside is that it becomes very slow when a commit-graph
>> doesn't exist (it walks all reachable commits from the starting points)
>> but that's typically better than giving an incorrect answer.
> 
> When we ended up spending the huge cost by doing this in a
> repository without existing commit-graph or with an out of date
> commit-graph, I wonder if it is possible to recoup the cost by
> amortizing it over time by writing a commit-graph out?

I do like this idea, as we could take the structure that was
computed and write it out with relatively small overhead at
that point. We are expecting the commit-graph to exist in
more places, and it has been baking for several years now.
Maybe it's time to make that expectation more explicit and
have it become an opt-out instead of opt-in feature.

It does lead to some concerns that commands that are "read
only" become mutators of disk state. This is something that
could be rectified with appropriate guardrails.

Thanks,
-Stolee

