Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98221DFDE
	for <git@vger.kernel.org>; Fri, 16 May 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400054; cv=none; b=G1mYYSFLhpK3AefU2KM+ZV+Qn1E7++OdVjtdXcsMH+r4e+Lw/4tBE/h5mfNAQ4VqhrvqC1EdbHAdNWWkT12pwnvPK798++WhiTrflSo0x+TW+M5/1DYgxB90TD2hZBbVSfeNuRPCGWHLRkVcH6CDXWLwjNk8E2On2MZNHF8f3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400054; c=relaxed/simple;
	bh=6FqVJfvD2bszvNNJIHO5FLBcoEFXHOCZA1Y0ubksjFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbRr51gU/MQQbLc2cAX59M+vwjdJ6F9a48FocNwO2gh+D6+TrzUKMh+6RMyKZyjDyJcPabHph7MJpQmqMyCC/L2KFNNIDfS67ELEeo9fStFm1x/MXcZGS5AOgAZPqyOVzEPjj9mlhLTfNlGHfEzxLJnAXseUbjOZ3moPAd4Hxwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfCqab4T; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfCqab4T"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e740a09eb00so1846261276.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747400052; x=1748004852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XdShncm4AknNO43f/v60+I0aTY2b7/QkYP8rUV4YZw=;
        b=PfCqab4TEKPRYGs1dSvJQG06KR9/BHKCCRJY/3Hmf4TNaCOTIamdpT71Fc7cpUDfK9
         31UB6BX+HyZZflZijc9RNlvIZfsOobUtgPITKcHzKNbcQmSMQXfUb6umlQi3hmpc3nCk
         +Po+4aT+myEBuGY5XpPixwWQcaWm/AU9c6ON1bPXxRm7qbxLeBYIODh7GIOqHKvjKMvM
         a7nR3PMTyt964jlKGNAJHg85u+X3Wv38zonPAJcPeF6Oe3epsb4b2krIxj2uX28NB4Il
         DpIlAJTGhV/vpwPsmfKKHaFKgL2GKAZaZ081EeyoXUljgOHvoIsNi+Z6MZ0T2g1Hm+e+
         +UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747400052; x=1748004852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XdShncm4AknNO43f/v60+I0aTY2b7/QkYP8rUV4YZw=;
        b=cSqcbyBPe+CShzwJ3vA1whLxODNxOg/TeEZ71M+ztlfFIt5h1moY3NGY9PlRjA3YT/
         769SpK0f7FkzZRkUzc5OqmC6LrVbyL94iNrItNY0k0iYfWA802dftNg128/OdkOZu6vQ
         KfHZEWp3WQGxRKflQdXqkMj9SxfaKgwWDkjuN0YLhti5pXtJrUsmlrPqbZTJmSjMZS0+
         OAildpjZK4nUHNgXP/yTc4gl0yRyGl6DomulC5XdNJtR5mDx53DTyrBWrhxZKdR8OSnQ
         bVP704SJQ8Mc0HMwa31tPnHIUB9+hXoVWsE1F3bf8aN1dZZ/nbyN3DqJXh3gAdHBwvW3
         QJ3g==
X-Gm-Message-State: AOJu0Yxa3G8dm0JFa/OwBYGjuSVhSeYmDWSCM28D7ydnC8R1oaHEEuuv
	o1J3U02DLHfV8zqty3MKddK7xNpR78KSDBYXqdLRTE3rByveJssp0g0CT5dCaQ==
X-Gm-Gg: ASbGncvTRL5ssgKuBwch/u2jrKV8PX0O8v9URGjnqskjGzhY35+/HQf16/p5levOlr9
	LhN+3xbYRAr7uNke66L2LFSSBtIPdpDS68CTNh2bj/2dznwz852bmLSFeVTKXf2cF9DIX4343XT
	4ugefLuDmiuo4YQzlwyCcLhb3rZWu9qLNDn3glB+mdFZfwnE/WpxaTpOsU5+6hK3H4UFDNI5+aB
	AlK5oADNdWbdeVfHPNw3ExIgzke4wjGcf9/ZyutlmMwWBdB+EIgOEvJhXi4YsXBuWgbAQhIgUsI
	Y1TArcqohdE4z7BLmcJK4v6Td9LjzAZbXMr8XoCZ5aBzosV67uCr9RVMdBiXGng6qBZMWmQtqi2
	c0SqAvzxZA5qE64oUqJ6cHzNFk1clnWZc0pltCos=
X-Google-Smtp-Source: AGHT+IG79Ri1n0+ANoxoYJAZHdTsK8SFvNa3Leftv5/Ik6LG9K0LO8/Z2PqeBUfpk0g3ijsUPgxhbQ==
X-Received: by 2002:a05:6902:1808:b0:e7b:7dd5:3863 with SMTP id 3f1490d57ef6-e7b7dd539c8mr1160393276.41.1747400051659;
        Fri, 16 May 2025 05:54:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6ac673fesm538218276.5.2025.05.16.05.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:54:11 -0700 (PDT)
Message-ID: <bee620e4-1f45-4fff-a7d4-ecb5f99f4e0a@gmail.com>
Date: Fri, 16 May 2025 08:54:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] git add: make -p/-i aware of sparse index
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
 <63caae876343faa9609516b0797fd9ff19f7a881.1746579321.git.gitgitgadget@gmail.com>
 <CABPp-BEmMaFQxE9NQgM8M=cgfBHY1p56vnBt7R4CfuiXnq++4Q@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEmMaFQxE9NQgM8M=cgfBHY1p56vnBt7R4CfuiXnq++4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/25 12:38 AM, Elijah Newren wrote:
> On Tue, May 6, 2025 at 5:55 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> It is slow to expand a sparse index in-memory due to parsing of trees.
>> We aim to minimize that performance cost when possible. 'git add -p'
>> uses 'git apply' child processes to modify the index, but still there
>> are some expansions that occur.
> 
> still there are some expansions that occur...outside of those child
> processes?  Is that what you're trying to say, or was it something
> else?
> 
>> It turns out that control flows out of cmd_add() in the interactive
>> cases before the lines that confirm that the builtin is integrated with
>> the sparse index. We need to move that earlier to ensure it prevents a
>> full index expansion on read.
>>
>> Add more test cases that confirm that these interactive add options work
>> with the sparse index. One interesting aspect here is that the '-i'
>> option avoids expanding the sparse index when a sparse directory exists
>> on disk while the '-p' option does hit the ensure_full_index() method.
>> This leaves some room for improvement, but this case should be atypical
>> as users should remain within their sparse-checkout.
> 
> It's not clear whether this paragraph is talking about existing state
> (before the patch) or desired state (after the patch).  I think based
> on the context it's the former, but the last sentence sounds more like
> a future work direction that makes it very unclear, to me at least.

I'll try to rewrite to make this clearer.

>> +       # -p does expand when edits are outside sparse checkout.
>> +       test_write_lines y n y >in &&
>> +       ensure_expanded add -p <in &&
>> +
>> +       # but -i does not expand.
>> +       git -C sparse-index reset &&
>> +       test_write_lines u 2 3 "" q >in &&
>> +       ensure_not_expanded add -i <in
> 
> This has the same error as patch 1, in that you assume your reset
> above (which wasn't even a reset --hard) will re-sparsify the index.
> Since it doesn't, your test is misleading and only shows that when
> already expanded to include the files of interest it doesn't expand
> any further.  To re-sparsify your index before the `add -i` call,
> you'll need to do a `git reset --hard && git sparse-checkout reapply`
> and then recreate folder1/a with "new content" again...and then run
> your 'add -i' command.
Thanks. I didn't like that this was different. I appreciate your
expertise helping to clarify this issue.

Thanks,
-Stolee

