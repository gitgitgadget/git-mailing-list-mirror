Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284954739
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774226113; cv=none; b=pNII3eGl5i+Elg3sN4Lqd4owDYWk7nbSHc7tLheSjVvuMes7cA9QjahiTvM+hcYvvFNqhXr2Mt9pBKZpewf69o86i+CcawQkmoCI80oYZkj6eeT1Tryergd98lEB9qntPz5hiQAjFjGaFuy3EUlSN9JccYHsYul9r/+fbl04foU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774226113; c=relaxed/simple;
	bh=y+1zg6VVZVbzXPNNDysNBiyqdxJ+bxw4C/K7cWJ6QNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL1yFc9qsKFnP9WObsdmdYZn8GkEmrP3OxCZ6AHtuALGjHUrob8Tbl9R7wyfIHQYd4C+Wvp3UKf0hbriXj2TyczJQNCl+NpdKvnOatt7z8W4VqZvKDl1OEsHRdItTB5Q8ZvIuzZuuAACpg7E0RuOaSKt2jAhVaDi3LMyynh2ugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiDYt5r7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiDYt5r7"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfbbf35354so324989385a.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 17:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774226111; x=1774830911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZNcS5X94607JwmNJMnqLJKc4CmJBmXT0IFWRlAn3q8=;
        b=iiDYt5r7Ll0JCQBi6ti3So+ZmDKsyfFcHMFTr44DWID4ry53oLjUIbwg7L26uHpk/0
         N42yNxLifoNYiPBAXkEo4FxBOjP90FFkCoOwyoC8uQ8V5uuP+0v779QrsdaTLB1XG1vG
         RWpCXdWEC7sIieNPSqZayXg2h1ExSVZjDehTDcJhAQZqYJQWVWKOFaJYi+1sqLeLii7g
         4V2XR4ET06k2XuUpzZ8e3BCU2nIWufR4/IH1BP5vSwb0U3KDQ7a9PMIVpEoZtXR1UtJ8
         DQHmllvno9q39pEYHg6T0FZfvxSHP2ayJ3bg0QwXaEUgYqVCN7uXQqOD4ucjvUqu544Z
         M68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774226111; x=1774830911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZNcS5X94607JwmNJMnqLJKc4CmJBmXT0IFWRlAn3q8=;
        b=SY5bhshPEvnQqaTnQjwqrgh+ktTu4gvgXvd14UdoVpf2A16ec3E4pna8m0QdyMbHSI
         /Y+xdDb3M03+NFn7Pz43rmQ5uhQxSOqLBEg3oJmwT1kZwhLPctDv3fvr0EcBT+JxAxOx
         /nzoOnFiQcQ1gWuQfU0SxA7pC0OUrx0MMjgbTTbhvM9Vs+HtoqAGS29MAm3OmqTn7/e4
         kvFQj7CVbU3eIUUTcp6GLkwRb79RfzF+0uKGjbUjoBIlPfpauHq6hf3czt9o6LYcZON5
         cklP0NsPxPU4yKsFN/9HsInxRbnx2sw7Fap7Ibv/uOr2iT50AoRG8VLUDVgvzuNPs0SE
         p6OA==
X-Gm-Message-State: AOJu0Yz+mU08t+bP3d0TZPxh8vMISV2IaBh4VWdxKqGZvJ1EE6Y7JHgs
	AjzEsITZ8Ke9MghyUzWhyyTnkgeUlxs1//8V4KmIArUX/9arUYCDzgsk
X-Gm-Gg: ATEYQzy0gASO5s2jaySZE/6GtbngE2FqYljuA89JMkvsUNOOPuPjMtxZOVvVQxbZhpj
	v9yU0pJRbY5ACHek9hvLb9OyrvEzkxbNDZWNzMSm8uPyKGlESVvIGblzls4Eq6v8dAwJDo5J0Eq
	UsRBpLgvO7/eZTUGxpGA3kQS6lzTOvYmnad8XiNoHI8LlKB9IfSUd7VwqsHwVIZadPl2mYxCnKj
	+XlYctKVpt/IXbz9Ubnp0I97bAvrTkdv2d/iZkwZebiGfqKEU9IUa3gYAARDbBPj4PvpvWFTY5p
	JOzOpUPG257RWr9ZzatWtuvr98GmF4yE5cSa1l3SGZEbCeBorFJySKFJuqEmzNDuYEibWNDyUQG
	UvZFLnVr6legeCi4tPLXueN6l7nKLijlmR/YaXC0KhfSBHifMlW7fNg8PSP+zuhu/8z8Cobl2nr
	spfT+fHlIR7C2PxptjAvZ4YItTTXPz7fRXVU3BAUIPz4+ez7LFidUfXFdswF3vbX6O0MX3/6+wM
	3Jd6/MEXah5JM0339xQb6FXJGIrEAkoIUlNmlpEvb/PpSnaRZI=
X-Received: by 2002:a05:620a:4543:b0:8ca:4545:aeee with SMTP id af79cd13be357-8cfc7f33e3fmr1487731285a.37.1774226111285;
        Sun, 22 Mar 2026 17:35:11 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c? ([2605:a601:a6b4:9c00:dca6:e357:abdd:ee2c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f93489sm638012585a.15.2026.03.22.17.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 17:35:10 -0700 (PDT)
Message-ID: <89d1cc54-f2db-4177-ba5a-4d20a2cbd9c2@gmail.com>
Date: Sun, 22 Mar 2026 20:35:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] backfill: accept revision arguments
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
 <abvH6LUu953rrQzS@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <abvH6LUu953rrQzS@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/26 5:54 AM, Patrick Steinhardt wrote:
> On Tue, Mar 17, 2026 at 12:29:19AM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The existing implementation of 'git backfill' only includes downloading
>> missing blobs reachable from HEAD. Advanced uses may desire more general
>> commit limiting options, such as '--all' for all references, specifying a
>> commit range via negative references, or specifying a recency of use such as
>> with '--since=<date>'.
>>
>> All of these options are available if we use setup_revisions() to parse the
>> unknown arguments with the revision machinery. This opens up a large number
>> of possibilities, only a small set of which are tested here.
>>
>> For documentation, we avoid duplicating the option documentation and instead
>> link to the documentation of 'git rev-list'.
>>
>> Note that these arguments currently allow specifying a pathspec, which
>> modifies the commit history checks but does not limit the paths used in the
>> backfill logic. This will be updated in a future change.
> 
> Makes me wonder whether reversing the order would have avoided this
> slight awkwardness. But let's just stick with the current order, the end
> result would be the same anyway.
True, we could have added the pathspec logic first, but we wouldn't be able
to test it right away because the parsing comes through the rev-list.

>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
>>   Documentation/git-backfill.adoc |   3 +
>>   builtin/backfill.c              |  19 ++--
>>   t/t5620-backfill.sh             | 156 ++++++++++++++++++++++++++++++++
>>   3 files changed, 172 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/backfill.c b/builtin/backfill.c
>> index e80fc1b694..1b5595b27c 100644
>> --- a/builtin/backfill.c
>> +++ b/builtin/backfill.c
>> @@ -92,13 +92,14 @@ static int do_backfill(struct backfill_context *ctx)
>>   		}
>>   	}
>>   
>> -	repo_init_revisions(ctx->repo, &revs, "");
>> -	handle_revision_arg("HEAD", &revs, 0, 0);
>> +	/* Walk from HEAD if otherwise unspecified. */
>> +	if (!ctx->revs.pending.nr)
>> +		handle_revision_arg("HEAD", &ctx->revs, 0, 0);
> 
> Can we use `add_head_to_pending(&ctx->revs)` instead?

Nice. We absolutely can and should.

Thanks,
-Stolee


