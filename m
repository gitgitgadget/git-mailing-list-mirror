Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA02C218ACC
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000664; cv=none; b=CLclzFEiM3fD6hqBKIQ1610oDz98HqAstbdIYRQq6sdN9XqMhX+EHi5/w0xcXZT/4xHxK8xygpMe7gfqaiqhflt7H2KGgecyewAbiYLqyEta5RtXaMUhCkIwvdBNnLEk6QHWTyiHPMbrkgHtm12N9ySi9BUmKYwtaCPid88zYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000664; c=relaxed/simple;
	bh=E8vwzcnIln6lG3/15bUP7cfEJjfoCCF027OEN1aF5IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hP2iNcCotwhTTusAB8yV6Bwiy2YqQSUBU/vl3rCWckzJLsfA9MXAOrTDFiN2VwZSnRlojjUSrU6C1mLvrbyGCQphsTE+kLa0xbD5nHfDgRlbmjEsTp5CdschpWf2b/MXueSH/JCm+ulCKy+GKcY0o/tzW0yi/Js9dlS1UoPen5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdEDGfuQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdEDGfuQ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3562c7e2945so157152a91.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000663; x=1771605463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSXQeHmqX6ZHjIHt1FrRVyInBBe/9aMNkC8wO5R05tM=;
        b=MdEDGfuQvrcZacXSDO4zW8RjE/FjYDZEyCx9bUogdAsN1TjUSFsvfmISiyHSSabbQ+
         erf9AFRs8FCIboCHLK1f5J08tugIv4EcSgXTMn8n/XZ6stazsL2WCRr0cGf2H7o/Lp9n
         GhxtQI24dYzSMrjbKrRK0J7WuowJKcViGz8rqLQS7qsDvCVz9cI88rBTE1LumOyrK+Sh
         od1m3tcFTHY6ulpI8D4rj1sbm3JNKTlVyHwH2ylavCy+kTzcN7QD2bLwkIyVlTovDQcT
         vAbwwu2jbM5xF7d9aDWu8g5tCGGm2GgxVYul/953zMYZIjotz/8PvPPBadqXW2hBONCi
         JakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000663; x=1771605463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSXQeHmqX6ZHjIHt1FrRVyInBBe/9aMNkC8wO5R05tM=;
        b=SrYdtxQoQp/4j8Ey4/Gla89JEov0YpXpA+f00cYZxypHtJZ79dagHy9V4e+qgCfShW
         paNjzwy4e2gGgYOAX0dulEYiI00njP+t5f7l8g7Trr1UvSquBZcExH/FjKS/pWS/+yrT
         RSo1OgzRg1ofIcpSnpuSocjVjqLjBKzyXolqNvoEZXe5rEspthhG9l60ZW+U7fjHLsdu
         +sSkXGpFlfAFCStPEZ8bfXx/L4208gUdn87GLhW/nYOjRQvvwYuijN1QDzvufMVww2PI
         zs98NctguWFK9ZqqZPrUdydvaNmbuMexDQSqZkr8OoyAbstJV1gqTgRaHXz+twI+NJks
         C27w==
X-Gm-Message-State: AOJu0YzH3iR6Ashz09cIm7BoqSOUfWD0wJy6wn8nha0ebPw+fiLYDpkl
	kisvVxEJIWW5rJxE554AFWchRgoGvyaH6i3FKQfTMwJkQ9TA8XHF6AUwcIJcsOzl
X-Gm-Gg: AZuq6aLUcesXrfIRj0vrEz6Qd8TMMGFPjaogCYiUjIel7wZBFWY8qMWxObnwvkhOUVm
	TiUAQJmKhjb1/ElqWcAvuGULo3ixJP0AxdEs6On77e+zyU5SA+LKRmOLIsepKCtsx7VR25z8m/1
	eVb24atiZyOvdJOoYoTvVKMNHm34zu30tm4l+dSQnC6Z+4L49iWxv2Mca2xiMeITXf8K8Pm4mBh
	zs3juHzxjnrBM0+av1XxSMKUivwI9kFfFYff/eL5tuFPc6zU/qJKx76ePEgi0B9bCLd0BX4TUtR
	9y/yKoIhLmyz0tdpzsvBwWapMbhhXB8vXnwqTjDER36FuRKMaw7c8FstHm8tzIIOJFzMoy8aksT
	6+R9uI+5NDBwjBhsia8zKVCuTjNTLeW1gICZ9xikJVa9uF1VVx0qXWV+azACx39DBsQpGljMyy/
	8+ICgJLsMLIO8VewqAo2UKzTlKgtzMglqfOgssLA==
X-Received: by 2002:a17:90b:3ccf:b0:354:bfb7:db05 with SMTP id 98e67ed59e1d1-356a7ac4ee5mr2369885a91.4.1771000662886;
        Fri, 13 Feb 2026 08:37:42 -0800 (PST)
Received: from [192.168.0.101] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a6b7d227sm1244657a91.3.2026.02.13.08.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 08:37:42 -0800 (PST)
Message-ID: <0892ee4c-c274-4ed3-9b4e-6ea1e910407a@gmail.com>
Date: Sat, 14 Feb 2026 00:37:38 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] setup: fail if .git is not a file or directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20260211182122.35352-1-a3205153416@gmail.com>
 <20260212172405.48614-1-a3205153416@gmail.com> <xmqqtsvln0ev.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqtsvln0ev.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/26 04:59, Junio C Hamano wrote:

> Why this indentation change?
> 
>> -				/* NEEDSWORK: fail if .git is not file nor dir */
>> -				if (is_git_directory(dir->buf)) {
>> +				if (is_git_directory(dir->buf)){
> 
> Why this change (which is style violation that lack necessary SP
> between "){")?

Sorry for the typo. I will fix it in the next patch :(

> Stepping back a bit, even though the NEEDSWORK comment is placed
> here, I am not sure if this is the bast place to do much of the
> necessary work.
> 
> When gitdirenv is NULL and die_on_error is set, we would have died
> on any error other than STAT_FAILED (most often, this is because
> there wasn't .git at the path in the first place) or NOT_A_FILE
> (again, a happy case is that .git existed and it was a directory).
> We would have already died in read_gitfile_error_die() in all other
> cases.  But these two error cases are not necessarily entirely happy
> and that is what the NEEDSWORK comment is about.
> 
> So, if we wanted to tighten the error checking to help users
> diagnose problems in their filesystem, I wonder if it is a better
> approach to refine the set of READ_GITFILE_ERR_* error codes:
> 
>   - STAT_ENOENT (new) is returned when stat failed and we got ENOENT,
>     and it is not a fatal error.
> 
>   - STAT_FAILED becomes a fatal error in read_gitfile_error_die().
> 
>   - IS_A_DIR (new) is returned when stat succeeded and it is a
>     directory.  It is not a fatal error.
> 
>   - NOT_A_FILE becomes a fatal error in read_gitfile_error_die().

This approach makes sense to me. I will work on v3 patch that:

1. Refines 'read_gitfile_error' with 'STAT_ENOENT' and 'IS_A_DIR'.

2. Makes 'STAT_FAILED' and 'NOT_A_FILE' fatal by default in 
'read_gitfile_error_die()'

3. Adjusts existing callers to handle these new codes.

This will be a larger refactor, so it might take a bit of time to ensure 
I don't break other call sites.

> Existing callers of the two functions, read_gitfile_gently() and
> read_gitfile_error_die(), must be audited and adjusted
> appropriately, but once it is done, it would become much simpler,
> wouldn't it?
Yes indeed.

Thanks for guiding me toward a cleaner architecture.


Buon san valentino,

Yuchen
