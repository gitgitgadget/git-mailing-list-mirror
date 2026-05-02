Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F383128B8
	for <git@vger.kernel.org>; Sat,  2 May 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716008; cv=none; b=TKDDU1vi89ZC1utT5a7/kLMOE5a/gzj+KRGEYem7m4up9nkFuQOD3EiNvmNgUdroyowOiquMTAobYXfH2wO7QTym2dvk/pefQQ1+WmJr18Q3QTOVBqw89KT8SMA4D+CxdVw6pJvo25NJLAgQT9L7W+4cEKOq23Ah4BJ77ZiiR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716008; c=relaxed/simple;
	bh=udRy7sqdIr59YoNjLpOpUC6BKZw7b8IFAMoPvktu47s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMefLh/ilqKt9LK1C/QK9z9ySnI9N/WO+jOdGpK1JC3Xkg4FS+eJ6MlGYcHpLDyiMDUYdB9cANoASyPsReZrpq16N9rd4+IeEYmKrO45UHrdxWZeoMy+jNHfAx2h7SuUqGe4tZsxnf6wHATus+1jPEsbSbKxxeN9IWvCYu5dWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGjtwQgC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGjtwQgC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so28711735e9.3
        for <git@vger.kernel.org>; Sat, 02 May 2026 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777716005; x=1778320805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rk9iSMuMSM9G/tVpI6VUsQ0NloZaHlzzmWCgFJxUDKU=;
        b=SGjtwQgC3flt5oTGOAoX/tASlIopxzjsDEFfmxieYtKz3kWbw2F2uyqWaJd4cU5oW4
         lN3fHvPX6eVyHEpEVttX96KEsoTqJOkEi3pDIlTXIPhcve7HVS2tsDsKvhrGlVwLr52E
         8VF2cMSQcNhzI6u+Hah3VVx5LV9+jc1BxLAeE5MnJRleE8E7kVcKvXDNhAYIh1wQJrmj
         /K2NYeJerrZVJnaY/fE7bgFi9OSB7gw5oBSgDu4s1Nzx2W0lo6tJfYiVWR4KMDg8Biui
         3a/p5W5G5zObcJIYeesaHA3faTMwGZPl+UzEliYpM0o94b9P7uuKcJijephnbJt5RHBK
         KMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777716005; x=1778320805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk9iSMuMSM9G/tVpI6VUsQ0NloZaHlzzmWCgFJxUDKU=;
        b=WD0h2yN4lNFJoYSSjuTehqmm628Xssce1a5sZW8BoZTIEaMrZT483ea7KqxOhSus0D
         uFip0GYVYjYehnuho5Vb3sHIiW1hVL7nxvgu8CajuO24FBk75MRqOIOVNu2E4o5so4Cg
         39OS95/UQmarElerW4S8QyE5AFyIjit/5njkdiqDQs1bss+XTg7VTu7XGSMZPgYu20A5
         Hxd8jeVWOamsHByIaEFC1lRuWDK8AsuFznMSDTQWPnmJUec/RjLziUVb6KcAO1D8MGmF
         72PS0dOKoN2Fgkm/ZdF9UJzeY05g2XQrHBrh/AAAvecpFHYZ28eUUmeNc+dUMsCqo5Kk
         L5vw==
X-Forwarded-Encrypted: i=1; AFNElJ9BmEgOLeFhXRAnaHHsaocLU5htqhvpLcQjYaEdz7x0zIApGW1IlAxPDGwGpXANlD5FfQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbgtk4EdLg0h535Y2XvVM1sYrb/cDwWo3h8fuGZ+d8hrF+kROu
	z3sj2qj0vNCQbWELVLj20OkcnCuz5+Sweh7qebjtM6g+jwLlN1UbnZ2W15exjQ==
X-Gm-Gg: AeBDieuMZszHh+tWXwZsj+kz3ZQyKDBMxUWpnNIULKufmU6hUEDtyfTeRlEXRIepFPv
	dKk9jHTv+pcPBnBhIRDloWt1QQJMNEYM4pWKF9OayUbgqxdkglXlc6xGDa57CNmkw0hUI/KIC1A
	5viH2Am4G9B/6B7b6JJGwxSQImbodGkMdC5GT2nNBJUshY6/nhVmRcOMrOBVQFA95KqTc1tFZi+
	+HBkwxnlHYpUK5DU/s3ril3eQnNU+gqGPlfuo25fVWu7YMR3rOkI6HenGparvhPEeHFWkULU/rt
	+TD1fKZPr9oyu8N6NMZj0PvCKWxOULfuUCZR6oxHqqi4SBeUhgQgcyKTQwnUf1llJcnjr8McALh
	yd1qL8q0dwECdGPZ6G6oyV4ze7cdd+ONu9Ty6cXOMtgNsNmQx61guYwXWJSCwtCeRg9dNLT6r1e
	Ay7sjEW+AiJt8M4LM+mWuyqrwbfm0smDJiXUCOCycKv7gd7S6ZoCOGNwV0PXjBUgzbcM9sG2I01
	Fb9wSxXjj8NHzJn+xunBriU
X-Received: by 2002:a05:600c:859a:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48a9865e671mr24614765e9.15.1777716005022;
        Sat, 02 May 2026 03:00:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:2df2:6378:5a72:d2d2? ([2a0a:ef40:1706:1a01:2df2:6378:5a72:d2d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fea6eeasm31580935e9.10.2026.05.02.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 03:00:03 -0700 (PDT)
Message-ID: <0f57e309-62a0-438e-a1d8-7c367379ef01@gmail.com>
Date: Sat, 2 May 2026 11:00:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
To: kristofferhaugsbakk@fastmail.com
Cc: ben.knoble@gmail.com, git@vger.kernel.org
References: <e8bb57a2-8eff-4f72-96ca-72d8880901e0@gmail.com>
 <20260501182718.27853-2-kristofferhaugsbakk@fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260501182718.27853-2-kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 01/05/2026 19:27, kristofferhaugsbakk@fastmail.com wrote:
> On Fri, May 1, 2026, at 12:16, Phillip Wood wrote:
>>> [snip]
>>> • You can’t feed commits piecemeal to these commands, one input
>>>     for one output; they block until standard in is closed
>>
>> So you can feed them piecemeal but you don't get any output until you
>> close stdin. That can be helpful as it means the calling process can
>> write to "git log --stdin" and then read the output without worrying
>> about getting deadlocked.
> 
> Okay. I don’t have much experience with concurrent programming.
> 
>> The Implementation below works fine if there
>> are separate processes or threads writing to and reading from "git
>> format-rev", but if we want a single process to be able to read from and
>> write to "git format-rev --stdin-mode=text" there will need to be a way
>> to delimit message boundaries so that git knows where the input message
>> ends and the caller knows where the response ends.
> 
> Okay, so I guess a null-terminator mode for output.

I think that's a good idea

>> We'll also need to be
>> careful about flushing the output at the end of a processed message.
> 
> I don’t get why this takes special care. I’ll think about it.

Because the output from printf() is buffered, unless you explicitly 
flush it you can get into a state where git thinks it has printed the 
output and is waiting for the caller to write more input, but the caller 
is still waiting to read git's output and so they are deadlocked. 
Calling maybe_flush_or_die() is the usual way to handle this I think - 
see 344a107b55 (merge-tree --stdin: flush stdout to avoid deadlock, 
2025-02-18)

>> For "--stdin-mode=revs" the caller cannot know how many lines the output
>> will span because formats like %(trailers) will produce a variable
>> number of lines depending on which trailers are present. It is also
>> possible for a rev name to span more than one line. The following
>> example finds the most recent commit that mentions 'cherry-pick' in the
>> subject line
>>
>> :/^[^
>> ]cherry-pick
>>
>> so we need a way to delimit the input and output records there as well.
> 
> Okay, so a null-terminator mode for input as well?

Yes I think "-z" should mean NUL terminated input and output.

>> I think the functionality implemented here is useful (transforming the
>> output of 'git blame' or 'git-last-modified' are convicing examples) and
>> it is probably better to do it as a command rather than adding a
>> "--format" option to name-rev.
>>
>>> • You can’t feed a list of possibly duplicate commits, like the output
>>>     of git-last-modified(1); they effectively deduplicate the output
>>
>> That is definitely a problem
> 
> Great, thanks.
> 
>>> Beyond these two points there’s also the input massage problem: you
>>
>> s/massagge/message/?
> 
> No. I meant massaging the input so that it can be processed by whatever
> tool you have. :) In this case splitting the object name column and file
> column because tools like git-log(1) can only deal with revision input.

Oh I see

Thanks

Phillip

> Thanks for reviewing the usability design.
> 

