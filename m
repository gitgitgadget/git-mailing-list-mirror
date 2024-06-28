Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD74A2F
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539348; cv=none; b=iRJimGnRYgehcn8QL7tYxmJwNs11BzL2n+ZD5xEaYiI7xCBtRIfaK7VDZAZi/SxFyDW/YDIpYd25CrYM0y3g6+70nrR0j1Yx7JXRF1GBZ8GIT61xJBmZQccqqwKr7mu1rDz3MLWQybM0hg4zQdnaZj+McIdCDnWNarPnLaG+kuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539348; c=relaxed/simple;
	bh=jzZkzC2ZazuzvjpDvDGTRsr78XNAXBmPnWm684Ry8IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFVFk12ZFrCDVfZmlrcOSjZ9MhvTQZ3ZSVJBkgSWHRfYmHjv8uLn71p7N3FADa/l9lqAOcgzk1WRNouwbCXJ0rxZiDl4q1CQBIcIGSXZaQNhikuQCx5iX4XVFlK+buCYvEfmInvWWNXyotugs3GVlEeNEBm1639ekc/iMHtR1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gF8URDl7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF8URDl7"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64af39fbc57so938827b3.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719539346; x=1720144146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+7/PgdT8IdVricQX/hf896HHW8BnB+ZI3YY3NganzY=;
        b=gF8URDl7yuZEkdj9Nn+t8JcWbp3idJ5/yDDEa1o4QzFaXy1o2TP0gaAevU2R0Kr1Ib
         D3E5erIwls8S9IGJ8YItv99eonPlOrBpge/PnWtuhI/vjM8dr/G7kZAwaxgi6i7qWd5h
         R2lGBAja6p7u7gY54uWAMYsbBJcUiz2OC5stXUGhnmCXM1c/BUPz+qVMUPVXp93u8R5o
         XARHmSZ0jpnNlSOuTjqQ14M5/IJunMuS0xMT7rUkTF1vfqs+fLd2/e+eP/UqQgzY5dzx
         aBsozH8YgJpE4wr1W6nX7wxk8ogRwrZdXSkBiV6SNC+MI3y2Uj0CUXa0HDf2xTq0D9fd
         WHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719539346; x=1720144146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+7/PgdT8IdVricQX/hf896HHW8BnB+ZI3YY3NganzY=;
        b=KwGKmG+ci3DjfJdyucZzTpS5GufiucKR92D/l6FTAtTmp6FF9hI97f2iYjVRO7TPrS
         1fgslHSXTUpmhbu+a+7DRmtqi9giGnUkUPzzstDOJ7Cq1Rf9EKETmO/Ayxh1AxLXlUJT
         kW+DlwC1PXjQ4AiiPBkz2CVl/PYggI1C2bojAKUXQYYmmUrOyi7EXxiolZ4wNDT+fjbR
         d0dKRlzplTpu+MsTg6DeqvIazmlmMz+aqalD3+tCzuqOGo8/r368waI+Jkr4NnfLEUle
         bZx2LfKZ8dXuT5tIs93lgiLi/8SnoyzgCGbpu0rk3iyEKFjClLZeG+Sql617d3PkBk34
         toqA==
X-Forwarded-Encrypted: i=1; AJvYcCWlgO39iCwhWicE5LsZZJu7GCqGVcrygbeuT/deBnV7+15t/kekLlHDKdKyw5t5heUUwUhHtXn/7nnf0OljE5aE7b62
X-Gm-Message-State: AOJu0YzYTnr6WrNZptIEEMBSj/ZAZdLdifOsWxfwT7jQTdAFnpZK3/Z8
	z8mLKp2ycIJM+Z4Zo/1LcmzeB72j6CFiUW0iT59BJ8H+MweaIAEQ
X-Google-Smtp-Source: AGHT+IENMRD3XUYRA7qLwc7UBNSBv9KevSU/GBwMeaoNwGltjpJEV2VOmztY12zjHe812fGVaYqnbg==
X-Received: by 2002:a81:7b54:0:b0:627:d23a:44ff with SMTP id 00721157ae682-6433d3d9900mr162181037b3.3.1719539345885;
        Thu, 27 Jun 2024 18:49:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5a8a6sm1684457b3.97.2024.06.27.18.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 18:49:05 -0700 (PDT)
Message-ID: <724057c1-568b-4e41-ae4d-192dc0cf0869@gmail.com>
Date: Thu, 27 Jun 2024 21:49:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] sparse-checkout: refactor skip worktree retry
 logic
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
 <93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
 <xmqq7ceat83v.fsf@gitster.g>
 <CABPp-BExeTYSpg0d-5F5cdwM8UZzU625A+6uaDhpWgBRjVrd7A@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BExeTYSpg0d-5F5cdwM8UZzU625A+6uaDhpWgBRjVrd7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 8:51 PM, Elijah Newren wrote:
> On Thu, Jun 27, 2024 at 1:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Both original and the rewritten code shares one trait, which is that
>> it goes from the beginning to check all paths that are marked with
>> SKIP_WORKTREE bit to clear CE_SKIP_WORKTREE bits from them, until
>> they find a S_ISSPARSEDIR entry and lazily call ensure_full_index(),
>> but then when retrying after calling ensure_full_index(), it
>> restarts from the beginning.  I wonder if it would help, especially
>> if the S_ISSPARSEDIR entry comes very late in the index (e.g., by
> 
> "the S_ISSPARSEDIR entry"?  Are you assuming there is only one?

In fact, the situation is more drastic when there are many sparse
directories and this is one late in the list. The ensure_full_index()
call could cause many new entries that should be no-ops earlier in
the lex order.

>> returning "here is where we have already checked during the first
>> run, until we realized that we first need to do ensure_full_index()"
>> to the caller from here, and then the caller tells the second phase
>> to restart from there), to reduce the number of calls to path_found()?
> 
> My first assumption about how to "restart from there", was to pass the
> current index, i, to the more involved check.  That might fail to be
> the correct index when there are multiple S_ISSPARSEDIR entries and
> the first one (or more) are actually missing from the working copy as
> expected.  However, if "restart from there" is just passing the
> name of the relevant directory and we do some kind of binary search to
> find where the earliest entry under that directory would exist in the
> expanded index, then that seems like a reasonable additional
> optimization.

Yes, you're on the right track. Requires replacing the response from
the sparse loop to be the existing cache entry position or path
instead of only a boolean "should restart" indicator.

Another option would be to explore the whole index for the sparse
directories that exist, then expand the index only to those paths.
That should be fastest, but would require using the partially-
expanded state that has so far only happened inside of the
sparse-checkout builtin.

All this to say: there are some interesting directions to go from
here. I'm willing to take some time to explore the options. Should
we consider merging this improvement now and then consider further
improvements in a follow-up series (if they are fruitful)?

Thanks,
-Stolee
