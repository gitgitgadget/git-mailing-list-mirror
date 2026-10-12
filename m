Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06900479864
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798654; cv=none; b=t3/cV77TvX2by6XtoaKx/Je92aVgAMdmvI5J+tzhRW0OsIm+zpR1dg2tWEunjQeXwVHLRsJcJIQOELjzo3/fa1kGr9r6Rnu3ny+qcmHzF8wVJMDu/AnXU7dP1cFCbw9P2HhT5hEPNO6M85tbP0QypBZXjHW/DHoxs+dUOGnn9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798654; c=relaxed/simple;
	bh=eZB3Qz53zzJVigjnkfSfxSm3xdWncR8e4XAhD36q3BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOuN6Vr64DZ8H1QHF7B+TFXnvUG0WSJSoLXB/quUxLMdNgDYcU2UnmCIXBUOrZjByvJswKWJbIhgGvZFHkIpKcUbOtNZICFp64FSn757WZnG2PSr+nOJ5cw/YsL9izA4GFVe2TKhr9MxAi5inSxEmxWbTuLpqhQdnkL3sjrqW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+cGDbW/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+cGDbW/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so13680355e9.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791798646; x=1792403446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=deaIfYD12DzpnyURffXfU8hPlhmHlEduTsGsxMtLZIg=;
        b=P+cGDbW/k6+4cp8/QvT6nBctoewbK/KWqEPJFnUzMQZM+vsda2OmOO2adbw8N84QpA
         5gtuZKH9YxFB6rmpDMBismY1Z77S3YCgWyX3pCTEChAyEja24whZhLTrZm4tObCLyIbR
         g4oTM+5S7Jrr0tknFHRcqlMOCeoPhuZ2vq2bQv9V9K16v5ZbRYDqIqkmzf+memdUPvQr
         wgC44DeKwD/BvX1a2gb44h3XJdAoHCKxInRZcGgpoYEIQlrUi93Hm6es9Gbp5/gCt38V
         VdmT1qmgL4XmCtt7lNYugPiK+WLdm8ae/jtjoxbpts1UkOC3VWMnqFz4/rv2wI/dYmzr
         6Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791798646; x=1792403446;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=deaIfYD12DzpnyURffXfU8hPlhmHlEduTsGsxMtLZIg=;
        b=TwcBosc+eg78QlGnDYaHogljcmm9MHyMiN7bASffjJvxoVLO5qnXYWBzD0r2yE/eBi
         QVCRp0L/5jJb+TWeTCFu2/JKoi4upFKOXqkT/OWqEid3FJXBkjp8OTDowr7CvavSIc7q
         GUVHcwwncgrfqWz7JWjoTEGIUVJX+VAsl9u+V5aV2OxmK9gE8Edt5G2qw+xYkneUvdr5
         Pb0MHdgcsUe5Z2/d9r1W0i0XV4tPOsYC1WswuMpWJ9ZqNkGHZXm+pY4Q8LkFlPZfB6Js
         VbY8C3Pn4lEwzyO9i5/AdVgx3eoO3BUZsGM77/ZwjPlmAI4hLZz9qpfY9Drt4Y4+5vhx
         iUQg==
X-Gm-Message-State: AFq9FYKDDmB9asbgQqP2tOVQ3edQceHiviSYeQzSTXVUVxaDBO9HXUpp
	P1WeqipEoRNlgcS14GwqV9MTS+Wt+l7NTSKE3RPFszPDVoW6Gq/o/cl4Imsu/w==
X-Gm-Gg: AYBFou0W3BXeCO1SOi6TLc4Z+iaGFkngj/5Ldryo+3/PJTJNpnb2Lr9L+MqcsTdIq+c
	f1J/DvxJkaHUtHo8cGVHW/ukFXAGPT2jr8DDfOUfLX5UaX3VVNFhiQ+SfKdP2N9myG0Fn6E89wo
	V0UajlrI5EE1SU24EVm7Rtu9Ree1Z640JeivzKd5uN3hA0q5KxJMYyYSyOo/uNS9qNSukVPuUMF
	OUUZw02rKcIIs7dtP/Kmizg2RG3nhjma9gw4wYQi9VUJSKTfCsh+14KIHseYMSJmTKquubCwWQC
	e0OFYMV7jJxL1K81RtgGgJmSjBMWh1mG7gSLoo0nWwjaysmlMZblJix7Z/CZNd7wt8HrFUS6CAG
	CoHkqLkSy/ZfHn7svq2BcW05OvHnnN4Vi14DpbEXYsGhhqg5XN1ZPoXOr+ioz+xlZUtFLhxsuK4
	zdJs2tqRbzo6AXfPHYH5YEOgFnIJ4db/B+tevL+HkzdsmW6Zvy9kQdv8hpWwd3JL0HUHOiKYb8p
	SWxrg0dTJBzvlRv0nJQ3QzX1GrGYAX+2A1EnYmYDg9C/pYsv7fmr8NSQ1TbGMs=
X-Received: by 2002:a05:600c:3c89:b0:4a1:7703:e52a with SMTP id 5b1f17b1804b1-4a18e493039mr152902275e9.9.1791798645722;
        Mon, 12 Oct 2026 02:50:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19c71a1d7sm98467965e9.5.2026.10.12.02.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:50:44 -0700 (PDT)
Message-ID: <03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com>
Date: Mon, 12 Oct 2026 10:50:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged
 branches
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
 <xmqq1p9vdalz.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1p9vdalz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2026 01:30, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Branches merged on GitHub with "Squash and merge" or "Rebase and merge" are
>> never deleted by git branch --delete-merged, because their tips are not
>> reachable from the upstream. This treats such a branch as merged when some
>> upstream commit contains all of its changes, and names that commit in the
>> output:
>>
>> Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).
> 
> Interesting.
> 
> After rebasing, you probably can (re)use the same algorithm as used
> in range-diff to match the commits and their rewritten counterparts,
> but I wonder how "squash" would go.  Presumably you can locally make
> a trial squash merge and probe for a similar commit on the upstream
> commit.
> 
> On the other hand, unlike deliberate rebasing done during a patch
> iteration, rebase done on the upstream to integrate your changes
> would not rewrite the log messages, so matching the commits based on
> the log message may work better than a range-diff between iteration
> vN and v(N+1) in the submitted patches.

I think it would be helpful if the cover letter explained in more detail 
what this series actually does to detect squashed merges and compared 
that to other approaches such as using patch ids or test merges. As far 
as I can see the approach here is, to a first approximation, checking

	$(git merge-tree B C) == C^{tree}

to see if C is a squashed merge of B, only without using merge-ort but 
by calling merge_ll() on each path instead. That means we're not 
checking if C is the same as merging B into C^, C may contain additional 
changes as well. I think it also means we're missing out on rename 
detection. It would be good to get a clear idea of what the tradeoffs of 
the various approaches are before any more code is written.

Thanks

Phillip

>>   * Diff each upstream commit once and share the result between all branches,
>>     faster than v1.
>>   * Fix a branch merged with a merge commit being reported as "landed as" the
>>     merge when another branch was searched first, and add a test for it. Show
>>     the topic commit itself in "landed as" for work that arrived through a
>>     merge.
>>   * Use git merge --squash as the example in the commit message and mention
>>     GitHub's squash and rebase buttons.
>>   * Add --no-squashed to skip the squash search.
>>
>> Harald Nordgren (2):
>>    branch: let --delete-merged find squash merged branches
>>    branch: add --no-squashed to skip the squash search
> 
> This a bit unexpected two-patch organization; I would have expected
> that the cases where our side and upstream side should correspond
> one-to-one (i.e., what you call rebase-and-merge) and other cases
> (i.e., squash merge) to require very different matching algorithm,
> which would lead to two-patch organization where one adds support
> for rebase and the other adds support for squash.

