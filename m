Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41A30EF91
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309730; cv=none; b=r+I0X9RI/Jf5sb8qpb45ihznZlqQCPpiPR1Er2+EdrG4xqcFPYkN4G/fjjOkvokB1ikMjtrCfTCgZd9UJuWZrQMBa6JUMW3lCQ2dvIaVisXon+h/bovX4CnKBlT1BSY2jxzL36K+wWgQD+YflfRyZFtgTL/cVnHZLkJhys//L5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309730; c=relaxed/simple;
	bh=ygWT7WBhoP7Tff0Otn56WA7ShUgr2vbnUZfxWt1msw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQG8e3lfDjp9IgOc1rS5rZOepofzjjAlY7+W8Y6e/xHYCduLPSuScYasRq0mty7OALWiMeEjhuUmrpVariMOh0CDX8X54/OKZwYNy/Jql4W3v2DswPWs7ZjqT74KJ6uVT4R+UK6mCxDJNVwRl847/9ZE4TPPlbWoPPShyM20pj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMjlUM0r; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMjlUM0r"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5ad583dc38eso1045699e87.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309727; x=1782914527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k77KEMKd+ad4S4drWgePsurwYyYPz8ohqikWjMwl8cU=;
        b=GMjlUM0r7heNGCPb9XeGmHN3wNssTB+20dUM098h7PV2IJtm7ghRaJEIsI6iWQkgnm
         35HBDWvf8CnClrfwMgs3/phYWtErtR8z2iyQRmcM9MabM86yz5/CPQNMjAB2brPM2Bvv
         St0KFW0gAyjfLkOFIHTN1oq2oCgGw/IRB0dDhGzelv65fx4yVcpqTpDZna74K0lchj0C
         Mmu+IBusb2I+i/TjDcwG/P7NR4P3X/SntQz3O2W/CXXBobDT3CnzgXGn5qEyuMh5IkCK
         PB2WiZpFTMG3mbBQ0Bx3Trv8vMyIrY4L9kTUQJyY692Hzidd0JX86h+Ypp8Xau2Q959a
         h7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309727; x=1782914527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k77KEMKd+ad4S4drWgePsurwYyYPz8ohqikWjMwl8cU=;
        b=L7bQIAfC7QZrW8M+UyZfOvu6x7UIONYAKJ4mbXv7niq6inHQTMHhv33caBM69IZCwZ
         Udr1PylDNbUIxI/mRsoUEGzRCM6amnqESxwUino16FbhIp000ruXxMm9Rg2HBysbTkYu
         Gax+iiN4V9lvO0vulsoVF7N78XOb3+59Qn5/ZH9eUo9Sjc1HkD+lpkRrLgO6q2qt5my9
         w5CnWgppMy/MdcZMiHcy66EGBHXgpZ82+v/8k0li+NCWPaDWd+5hVj0HB3OZWhhw9nbi
         sKTbNxQJRcR/h0Jrwon487gwjpH1je5esqf7PgbPrX4EQOKTVJ7Os2eDNr6sXbQALVJB
         eBuQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/O6eZOFKW41IL+IidpVMDv4Xc50/z/WyqEUpFTiwinId5oJqgbl76Vmhz1HJsEUKmdgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjxhVaJ1SAp2OeADlZ3EY0gkB4tiPU9IZe3G/lrE2+mZEvLMJ7
	jaSxDfBwXEUv6ut3i/LJjfuu10tEmGx8sLsY6H6KmqRmkImmRvR2/kkS
X-Gm-Gg: AfdE7clq/UATGA4GyO4DA3jHcS4ZMAbueZ5BQoP21GO5kHFSQtyfxF2Y1HYgOwT+dqu
	taf12aGkjdvB/XjTEgUAuCyw7SCe8wBdn9J/cw8n4me8/Cmy3FMdEEWMiRWBf7Fmvz653HWjYAL
	aNy/p9uU8zsJ0WmdYFwwxeVqyN25Jq+u9fwBd0GZbuCXGgu6zDCC2tmegDkugb8FOCQ/NfQaVnI
	INjloF6OMyUHKtt7KwWKvzhILX2HHBOtk6/CejJrazQZndpI6gYMo1SxrJjzC87elcnLtwikSUc
	7W3hlKA9iD/T7/ea0OzwI+/KvEvEhqWaxrwsNeB0lB3e1M3EDvl3gyKh/scaikev5wM02ISNLUu
	7Lo5VVNim0RwxOw6Um8iB9ED5a7B5mW3fsxPEll7J7SPkdCG77qqlev2Jh2aPSyL1LBaqcRbKhG
	wsrREpgtENCTpsT3xKxws/MjJwdw1UQITTpOeKBM0CFyoDD6acWk4IcPaJjQ==
X-Received: by 2002:a05:6512:a344:b0:5a8:6d58:b29 with SMTP id 2adb3069b0e04-5ae9d54c3d8mr785026e87.22.1782309726134;
        Wed, 24 Jun 2026 07:02:06 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69580f64sm1787162e87.65.2026.06.24.07.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 07:02:05 -0700 (PDT)
Message-ID: <6b0d81e7-7617-4fb4-9e39-cdf8bc778837@gmail.com>
Date: Wed, 24 Jun 2026 10:02:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <d84b932e5b078edc8255b6944ecb67fc1aa086b0.1782303254.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <d84b932e5b078edc8255b6944ecb67fc1aa086b0.1782303254.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 8:14 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Add an early termination check to paint_down_to_common() using the
> per-side counters introduced earlier. Once the walk enters the
> finite-generation region, terminate early when one side's exclusive
> count drops to zero -- no new merge-base can form without both paint
> sides meeting.

Having this as the last patch is truly a nice climax moment for the
patch series!

> @@ -94,6 +94,9 @@ ends when one of the following conditions holds:
>  
>    1. The queue is empty.
>    2. The queue contains only stale entries.
> +  3. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
> +     remain in the queue, no pending merge-base candidates exist,
> +     and the walk has entered the finite-generation region.
...> +Side-exhaustion condition
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +A new merge-base requires commits from both sides to meet. When one
> +side's exclusive counter reaches zero and there are no pending
> +merge-base candidates, no future traversal step can produce a new
> +candidate.
> +
> +This optimization only activates in the finite-generation region
> +where topological ordering holds. In that region, children are
> +always visited before parents, so paint flags are final at visit
> +time and an exhausted side cannot reappear. In the INFINITY region,
> +commit-date ordering can violate this guarantee, so the check is
> +skipped.
> +

And these doc updates inline make me happy.

>  Related documentation
>  ---------------------
>  
> diff --git a/commit-reach.c b/commit-reach.c
> index e0d9874f99..f79d0b64d6 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -133,17 +133,30 @@ static void paint_queue_put(struct paint_state *state,
>  
>  static struct commit *paint_queue_get(struct paint_state *state)
>  {
> -	struct commit *commit;
> +	struct commit *commit = prio_queue_get(&state->queue);
>  
> -	if (!state->p1_count && !state->p2_count &&
> -	    !state->pending_merge_bases)
> +	if (!commit)
>  		return NULL;
I see how the previous implementation has a termination condition
before calling prio_queue_get(), which is technically more
efficient. It does make this initial diff a bit more complicated
because we are moving the prio_queue_get() line.

If the introduction of the method in patch 5/7 looked like this:

+static struct commit *paint_queue_get(struct paint_state *state)
+{
+	struct commit *commit = prio_queue_get(&state->queue);
+
+	if (!commit)
+		return NULL;
+
+	if (!state->p1_count && !state->p2_count &&
+	    !state->pending_merge_bases)
+		return NULL;
+
+	commit->object.flags &= ~ENQUEUED;
+	paint_count_update(state, commit->object.flags, -1);
+	return commit;
+}

Then this diff would look cleaner.

(This is the nittiest of nitpicks so feel free to ignore if this
doesn't bother you at all.)

> -	commit = prio_queue_get(&state->queue);
> -	if (commit) {
> -		commit->object.flags &= ~ENQUEUED;
> -		paint_count_update(state, commit->object.flags, -1);
> +	commit->object.flags &= ~ENQUEUED;
> +
> +	if (!state->pending_merge_bases) {
> +		if (!state->p1_count && !state->p2_count)
> +			return NULL;
> +		/*
> +		 * Side exhaustion: a new merge-base can only form
> +		 * when both PARENT1-only and PARENT2-only commits
> +		 * remain in the queue. In the finite-generation
> +		 * region the queue is ordered topologically, so
> +		 * no future step can add paint to visited commits
> +		 * and an exhausted side cannot reappear.
> +		 */
> +		if ((!state->p1_count || !state->p2_count) &&
> +		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
> +			return NULL;
>  	}
> +
> +	paint_count_update(state, commit->object.flags, -1);
>  	return commit;
>  }

I like how the crux of this implementation is entirely within
paint_queue_get() now.

> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index c1109fb42f..03175befb3 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -332,12 +332,12 @@ test_expect_success 'merge-base --all commit-walk steps' '
>  	cp commit-graph-full .git/objects/info/commit-graph &&
>  	GIT_TRACE2_EVENT="$(pwd)/trace-full.txt" \
>  		git merge-base --all commit-9-9 commit-9-1 >actual &&
> -	test_trace2_data paint_down_to_common steps 80 <trace-full.txt &&
> +	test_trace2_data paint_down_to_common steps 9 <trace-full.txt &&
>  
>  	cp commit-graph-half .git/objects/info/commit-graph &&
>  	GIT_TRACE2_EVENT="$(pwd)/trace-half.txt" \
>  		git merge-base --all commit-9-9 commit-9-1 >actual &&
> -	test_trace2_data paint_down_to_common steps 81 <trace-half.txt
> +	test_trace2_data paint_down_to_common steps 57 <trace-half.txt
>  '
I love to see these steps change. If you take my suggestion to
update more tests with these checks, then this diff will get bigger
(but in a deserved way).

Also, when I suggested that 'test_all_modes' creates the trace
files on our behalf, I forgot to mention that this specific test
that you added in patch 4/7 simplifies by running the merge-base
check under 'test_all_modes' and then checking the trace2 data
on the three well-known files afterwards.

Thanks,
-Stolee

