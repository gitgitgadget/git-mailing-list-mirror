Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8514D71E
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303938; cv=none; b=RK1FTtBa3+EWY8sDWC36JXrRaQd5IGXOEvjh/FEClhrIIS0au0GnQhCG5IKzVWLay2ocnazgdvyxF5PiX6oo2PWJmTybuv3yTvWzR743OP3FYsL4jgzwHUVciqgWWieT6JC+ooZr4Oy/kxfv1S6cH/i0vEIaVW/X0sggfqcqBPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303938; c=relaxed/simple;
	bh=RYkeLtw/JeyTbQVPJ3ucP2+XeoKuhFYnawXumN4Spoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AePeHYpMRzwr9TiD0GobcqhR38uAdJUCOyJ1ivcyYJckM8TWbz/R936vZ6wvFg5K8VbJrDbCQcDjNu6uCyEAABEU4EU+cXCQDzAkMGkqjxiLQH9XX3qomcz/wmcOQyjgelIrdYUuUp2MHjGKU8cfIXesffOjBdpZKK3nSYqU6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=WKUakrGY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="WKUakrGY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f862f7c7edso1118605ad.3
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1718303936; x=1718908736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sO94JOwrQt3VpotG7aYJt/MhE2m25Gefp+0jaKf6qIo=;
        b=WKUakrGYVkqBNEj5jMLCzgNG83Tc55Tg1uqUADKXem52YAVsYBxpVBE3Qw4Fen3UKG
         IItIqUoOy4sMmsGk/4CItrlBjlPkFsu9a6Ejy2NLKVwrbj/LFInqyTXjMC6IGay58G8b
         P5ugWYKLCJR7A7rST04TE1Va6PvMvN8AkWQBvYO52qTSEHYRrVhihIST1d7IubXJGamE
         /CoL5dxzyW5cM65nyL9f82ECwxaBnXu3eunRKSbZfYJdX8EMS5LJE1HvbOIq8GvFNXnM
         o5Usb7OzyG1ETxFr6d+Eu58cdnFxy+EUQjNv+iwej7q9eCnBceCIL3az+OLY/ZhzuntN
         4x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303936; x=1718908736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sO94JOwrQt3VpotG7aYJt/MhE2m25Gefp+0jaKf6qIo=;
        b=VKXmXKKS5ZES7Oaa+x0fqf3VmZ8bvBGvsdoYEq96GddvojnieXNyh7YPghfsy9ZDIL
         3/JdOSTjbHISPNv9HDx7rGJrAFj8iciMImXNhb+yhzL4mplO14sTWNUYDXUd6B/TM71V
         Ih3Q7j3SOVK8P4np9ej3q3eKIK0p0JWk4elraykpOrdin2nwltNp6QnvvmhiuRhrdxBL
         AWBldAJ3j1zfvbyVULSPqpPyEowB3p/KvMlsDFh7dX1rWtn1JY+XIcWdUI6y5s7ROsvY
         lzSdz9jY2zPBnnyDJgkdAdtNrY6+3vVqndQKFKR32i419l+Iy0NeyBHAeO96FngYPz0y
         FaZQ==
X-Gm-Message-State: AOJu0YzB201G5kJcI7w/2xOBNa2RxZm6aIaHS5ChjzMGIg2qMPP5CSVl
	ozz0YdAyepNlyAmJlqfdUCutwk9W+OF8Z2vH98tIJlKpbIMDn9+/h2rzwZBb
X-Google-Smtp-Source: AGHT+IHE73AINjQipUawdgIb1q4A0J2eAhgL1CfRkOhVXeBFtm7O2PAEQh5eDsSFSpXsDWL+S7iPYg==
X-Received: by 2002:a17:902:d486:b0:1f7:648:e742 with SMTP id d9443c01a7336-1f8627c7694mr5207905ad.37.1718303935977;
        Thu, 13 Jun 2024 11:38:55 -0700 (PDT)
Received: from [192.168.50.41] (syn-172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1b13bsm17129615ad.245.2024.06.13.11.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:38:55 -0700 (PDT)
Message-ID: <da036540-531f-4ad8-8be8-93c104930976@github.com>
Date: Thu, 13 Jun 2024 11:38:54 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] mktree: use iterator struct to add tree entries to
 index
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <94d6615d634c4f78c88d3e01abbb27f13f85828c.1718130288.git.gitgitgadget@gmail.com>
 <ZmltI7HA7O4w2E-6@tanuki>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZmltI7HA7O4w2E-6@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Tue, Jun 11, 2024 at 06:24:44PM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Create 'struct tree_entry_iterator' to manage iteration through a 'struct
>> tree_entry_array'. Using an iterator allows for conditional iteration; this
>> functionality will be necessary in later commits when performing parallel
>> iteration through multiple sets of tree entries.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/mktree.c | 40 +++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/mktree.c b/builtin/mktree.c
>> index 12f68187221..bee359e9978 100644
>> --- a/builtin/mktree.c
>> +++ b/builtin/mktree.c
>> @@ -137,6 +137,38 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
>>  	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
>>  }
>>  
>> +struct tree_entry_iterator {
>> +	struct tree_entry *current;
>> +
>> +	/* private */
>> +	struct {
>> +		struct tree_entry_array *arr;
>> +		size_t idx;
>> +	} priv;
>> +};
>> +
>> +static void init_tree_entry_iterator(struct tree_entry_iterator *iter,
>> +				     struct tree_entry_array *arr)
>> +{
>> +	iter->priv.arr = arr;
>> +	iter->priv.idx = 0;
>> +	iter->current = 0 < arr->nr ? arr->entries[0] : NULL;
>> +}
> 
> Nit: Same comment as before, I think these should rather be named
> `tree_entry_iterator_init()` and `tree_entry_iterator_advance()`.

That works for me. I'm not attached to the naming convention I used and your
justification for changing it in [1] is reasonable.

[1] https://lore.kernel.org/git/ZmltDQ5SlVvrEDGP@tanuki/

>> +/*
>> + * Advance the tree entry iterator to the next entry in the array. If no entries
>> + * remain, 'current' is set to NULL. Returns the previous 'current' value of the
>> + * iterator.
>> + */
>> +static struct tree_entry *advance_tree_entry_iterator(struct tree_entry_iterator *iter)
>> +{
>> +	struct tree_entry *prev = iter->current;
>> +	iter->current = (iter->priv.idx + 1) < iter->priv.arr->nr
>> +			? iter->priv.arr->entries[++iter->priv.idx]
>> +			: NULL;
>> +	return prev;
>> +}
> 
> I think it's somewhat confusing to have this return a different value
> than `current`. When I call `next()`, then I expect the iterator to
> return the next item. And after having called `next()`, I expect that
> the current value is the one that the previous call to `next()` has
> returned.

I do see how it's confusing. I was attempting to mimic the various
array/stack "pop" methods throughout the codebase (which return the "popped"
value while moving the stack pointer), but that doesn't really work here
with an iterator. 

The only real benefit of this was that it simplified a loop somewhere later
on, but not by a ton. I'll drop the 'tree_entry *' return value from the
method and access 'iter->current' directly where it's needed.

> To avoid confusion, I'd propose to get rid of the `current` member
> altogether. It's not needed as we already save the current index and
> avoids the confusion.

The idea of the iterator is to have callers only ever reference the
'current' value to avoid needing to deal with the array & current index
directly; I find that it majorly simplifies the parallel iteration through
the base tree and entry array in [2]. IOW, in a language with support for
it, 'idx' would be private & 'current' would be public. So I would like to
keep the 'current' value as the publicly-accessible way of interacting with
the iterator (although, as mentioned above, I'm happy to drop it from the
'advance' method return value).

[2] https://lore.kernel.org/git/df0c50dfea3cb77e0070246efdf7a3f070b2ad97.1718130288.git.gitgitgadget@gmail.com/

> 
> Patrick

