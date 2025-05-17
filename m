Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536F1C861D
	for <git@vger.kernel.org>; Sat, 17 May 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747502433; cv=none; b=moijbsosdJB9RWjsoz8bL1cDJx1dE/6m8+jY9UNNxYyGsf84B9jminNjyL5SEFDoVcRJRz0R0AUTUSOB1GgMo9ZMLktYJAhm1Z3974N4G2RvOKU9wzVAQdiGAcveutNlJJto+KizpwrPlspqobQ8ciCxyxuUamQSCKDtqdaKrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747502433; c=relaxed/simple;
	bh=dnFhv0racdzH3AIvQ2NJX0zU3bOh14aItlTRl2WRz4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/wnLyqR0wZcCP8qiVLr/0wb2dYCGJTwCh00xFU/MwbB9cZGRNsMJXD7msYY9tG8I/PnRtBBIXJL4thl09JNfRY1kFsufTxaLSSNArOhrKvXoxAfEjQVa9nVaLkxVdQs4IUxwrzZ6YrIRbIGT8ItX4rjdwcchdaP4dAT1WOrST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX88PbcR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX88PbcR"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30c1c4a8224so2492460a91.0
        for <git@vger.kernel.org>; Sat, 17 May 2025 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747502431; x=1748107231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usTi8547CQ6wcVjrcv4qysGK3GL88are/3JUd6KsrHA=;
        b=QX88PbcR0JX3UYXmCLyvjt9SuSFYRVcnv9wDYGXfLoPuIjAy57abThTI+ZbB1Anr3l
         OYgOTgPHebo0pOoObYtqQgOJwqU1qUKWjc6ds9H39aV/68Eaa7xS5gBQi96XFNa+89Lm
         mPksYd8kBZ0eCkNDXgMjFYXH1ES/iCyp71UEKXy4UDSm+LkHwPDMr1YRjbywI1EnFvfo
         ym8xAxS8FByG3USawDHx8Uz8hVpmTk6C4/e4BSneVKz6j6uTty/Az6hPeAvdvZcdAM1k
         ho5Wmy2sFGhnI+4bvxhqAuUytDyHbQA7AFKcCgc5bB2JQh7xrksjahv/ENsZ9X0DOGOW
         4AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747502431; x=1748107231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usTi8547CQ6wcVjrcv4qysGK3GL88are/3JUd6KsrHA=;
        b=exHnOaYJZW8Q4XdFy71a40h7bjhMjr+zrHUulAlFDJUX9zJOYFBoGFqXE3HJdKspHt
         CKVYBmyQ1oXVYsWY3KJUUqi4o1C6qvrzP2kBNNZwMTRkzg/4dy2f2Q8HqLdQVDTuFPi3
         QsBq9i/u3MQJNgFtHppPpMmo1ca/jJ/HhZ7pdMJM3Xqsy3+jgIRtB6hGMV2PpIccuN2N
         VVpEqSRJXaio4YjDPI4aXXDEmWQ9guDvF4GAVWWa3RuMKXmXnWZYDWetjumR9s8kI39B
         9jBa8BjfUmIHUyOPQ9ODxOdfPI8wkua/Tx40RMhSLG1VHCl94bAUL9K4TIiKxMRztGm5
         k0kw==
X-Gm-Message-State: AOJu0YxeLe2PBozHgH74XDOsxD6II44Es+To3BpiGz7HleS50uBchwRi
	H0mJHzud7vOfQ3ycgBygvaDDpUSOe4gv7sUyhCGbP+Yg2C+pbeAQ39AjEG4sTg==
X-Gm-Gg: ASbGncuA3fSslneDdRXs0OgBVEXWG1CMjYo8KrCUkmpIYu4i438QY5vjIzv9O9xVxnp
	t1KBEc+LsqfZNTA3t25E4HaVDcnZxZJi6MU6k1+DlULxO8M+Uuy/prB/tosGcyu+BptxX7wAXln
	T+ND1dNBvdZ2MmBbQPORfOIvL3pfCtRU2C0lJjvulFWgWY2K5sB2lOx2RNrpuDMSoctwRMlwDv0
	gF7GGaOe39B/C/wVIYchTshGXn0Yw/LM/shPra/MsrlG7MQ4vhRGoeM4IRXvMsnSnXE44zSg1ig
	zh9eugag0lp/luDiXKo4GpOTcYto1PbzHCCwx6E2YSFW0XEqrg/C8FNE88DseAadsElLQnZX759
	qvqpHYTUxlDs6kWGe7EBA+g==
X-Google-Smtp-Source: AGHT+IHPjEVqWv0zsyEGGPPp0mnD8cL1fDJ0LiXVLebVoyrepc3KR0KH/UJbkVwRHvRtfuLOatwMZQ==
X-Received: by 2002:a17:90b:1d4f:b0:308:6d7a:5d30 with SMTP id 98e67ed59e1d1-30e7d5458dcmr13967489a91.18.1747502430438;
        Sat, 17 May 2025 10:20:30 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334e24d8sm7311301a91.37.2025.05.17.10.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 10:20:30 -0700 (PDT)
Message-ID: <49226f81-08df-4d35-861d-eca76fffa449@gmail.com>
Date: Sat, 17 May 2025 10:20:29 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re Question About Sorting the Index
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
References: <1008ijb$6j0$1@ciao.gmane.io>
 <20250517034625.9100-1-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <20250517034625.9100-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

First of all, thanks for the very thoughtful response.

On 5/16/25 8:46 PM, K Jayatheerth wrote:

> Correct the index maintains `struct cache_entry` entries in sorted
> order by the file name. This is essential for fast lookup, diffing, and
> pathspec-based operations.

Somehow I hadn't realized that the index was also stored in
memory. However, my concerns about index lookups where each
entry in the index, in memory or on disk, isn't the same size
still apply. How can you do a binary search if you don't know
where the middle of the index is? Maybe I'd understand if I
had studied the source code in more detail.

> Not exactly. Git keeps the index in memory as a sorted array, so adding
> a new entry doesn't require a full resort just a binary search to find
> the right insertion point. Only when the index is written to disk does
> it serialize the in-memory array, which is already sorted.

I see. However, my comment above still applies.

>> If so, this seems like a lot of
>> work, especially since not all the entries
>> are the same size.
> 
> That's true in principle, but in practice, the memory layout of
> `cache_entry` objects and memory mapping makes it quite efficient,
> especially since typical index sizes are modest.

I guess you're right since the Git universe isn't clamoring
about poor performance when accessing the index.

> you're describing a secondary structure
> like a sparse index or log-structured merge pattern. It has its appeal,
> particularly for large repositories with high-churn working trees.

Right. I would think it would also add some degree of safety since
the index file would only be rewritten when garbage collection is
done. The "index index" would be much more volatile but since it
could be easily and quickly recreated any time, there would be no added
danger.

> many Git operations rely on the index being sorted. Reads would
> have to scan or use your "index index", which introduces more I/O and
> complexity.

I'm not convinced it would result in more I/O. The "index index" file
would be written more often, true, but each entry in it is much smaller
than the in the regular index.

Maybe a better approach would only keep the "index index" in memory.
This would result in less memory being used, with access to entries
in the regular index being fast since the "index index" entries
contain enough data to do random access to the desired entry
in the on-disk index.

On the third hand, all this might be unnecessary since the way
Git currently works is good enough for most (maybe all) people
most (maybe all) of the time.

> This assumes laziness in cleanup, which is reasonable for append-only
> systems. But Git today avoids keeping dead entries around for clarity
> and correctness (especially under concurrent access).

If Postgres can do it, so could Git.

> Agreed but it's worth noting that sorting a relatively small
> in-memory structure (as Git does now) is often cheaper than
> maintaining two files in sync (your full index and index index).

With my in memory "index index", this would become easier.

> You’re not missing much in fact, Git has features like the "split index",
> "untracked cache", and "index v4" that address similar performance issues
> through other means. Your idea would likely help in edge cases (very large
> repos, massive parallelism), but the added complexity and I/O overhead of
> maintaining multiple files likely outweighs the benefits for the common case.

That is indeed the question. I admittedly have no data either about how
large a repo would have to be for a change like this to have any effect,
or how many such repos exist. I notice that the currrent Git repo has
4638 entries, which I suppose really isn't all that large.

Thanks again,
Jon



