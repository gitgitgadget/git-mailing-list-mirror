Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C90395272
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619339; cv=none; b=gp7YsbQrK6y7kvI/LV2l27IOuzrdrxxrLzQP635TWgHidvk3ONBcJLuOJ71Wm6C5v9rojaB1Zh7QuAL49snPD9f9ABzuc9eFVjwvgnsPx8xuw5481GrvOXn/9+oNsR6ceENc1EuoOagUpAs4hQiV56BRD3ZorZADSRczJCqQJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619339; c=relaxed/simple;
	bh=EX0KKho+ad4kJ9H17atVPTbnDl5pC6a3GVHOeumMJdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8+FtHTkGqCmMeTKK5QJTmw2D+vGtb7dWcC5gI4ae2FDTzd9c+azMymvxW1wJD7epLP95HkZkvMXuy2X/BfjObmWruM1kFl8Gw0B8VxhBfIejxz44c+7NurQ7YqOn9e6zc9WVBXi9OcBOQS76Sq3GbFf3gyqIXivpy/ZmnwEk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm/JCCks; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm/JCCks"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3bae8d3eso219763085a.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774619337; x=1775224137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoC0niUUh0mxR3abo3X5Q5yMFGWwsAYHcwQW3R6cZBI=;
        b=Jm/JCCksilTI9IqQ0eU/zufeYPlF34v2cOUIv+tNSHEWt9yIO74JUpnL6JuZgUTDCx
         oRi2mt26hGlz2vjqpf97yOl5dr1bH5sBrkZXxAhimZVims/16qOpF3RO3KEzhpHk5iZM
         Ey4TSEhABc2JqNW6+v7YDWiX9CL0IWSzelqSXA2tTzB5wrN61J3t9SneHMMvwBec8BXt
         BXlgjWhUwlBQBzuhsX+POwu1WyFkui+vd2YJdYZ7KGd4OG7ZkxjRlUD3rWM0UPwgwLOE
         CbM9t0S2gpreprELzfPq63Xfq4v28pPpm7JoxTjN1j7Tw1zE/TCTKKFoz0u7Ecpe2hdE
         f20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774619337; x=1775224137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoC0niUUh0mxR3abo3X5Q5yMFGWwsAYHcwQW3R6cZBI=;
        b=eLwGg9dWrfcPQKajwwXIwY+aHqUpeMSs5W96+rjLjXbEi86J43BGknqYcjUw99QP72
         Ew17gR/QLHXYSPfEowvUmdvnK+GZSluG2ZhVamUZM0t8dwo6tX/AWLF8l6YgxsS2Iua4
         t6XRPu0rRq4pxk3qioxQmX1ZhPKp+Ou+n1I6yvCDtmqabLuPGDrDUrXYEIc45Ugh01rF
         ADgK2Yrto4RJAIDJe75Stjsdf8xPYgloly/se5BwUZ1NeH4L5/sJA8HjYMjZr4VhRLhn
         LR64dK7Vn/ZEi6jAqAYWFiXFB9aM5l/P8ZXh+pQqWBC935f3x7inX7jL9S8d2noyw5OG
         aaCg==
X-Forwarded-Encrypted: i=1; AJvYcCWzgTkro4+UKQ+DVnJdfdi7RRhnhLdHxmd9Wii7gFKeROlY0zatqlGsQ490CFG6tYbDOkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeQox8WyUH9rAl8vieNZcJU3btXZ2Diu7cRVJcs7TIMDy4Jvm
	j9KJ671UpxmtCy9rhq5L4kW7zhXjlxPLcjkkm3FIPn5T/YBqRyRrkviK
X-Gm-Gg: ATEYQzwGRUwz2bQQNILYvSHLvyaktvM+QiYQ4iHte99wujaENH0CGTvseUviaNNTwNh
	8bXvAljXZl3yH5SsycX+IcEknZU4cj0KyVHVARbXrB5X+CeVPVn2AAWTXOOfVkBKPcFbxF/kpKt
	NAU7MTlaGUJk+dlAC/V5YpD299wirGItwprwRpCkOrvUye+wycWVjupCnsBp0r0iHdRsmsyJvVl
	Ow7HtyA/Uh+Ir5cxQpNDwafiVpI6FANUdZfV8y0VKK1ujAzSzSYr0nYrlrVbYZVxk5tJXn+rwwi
	oIdrZbzlxiRYsY99XJV3BsQ2owacVFuKgpHLLwjCYbJTU5cp0c4IBdachwxNGNgWsKLxNgugJjf
	dHC8tISlHt0qT/BmLQjOM9DobtCgTtBz/qpPFA3kwqFh/NKjCCmDJN0GyeCBbXmrhSsCIj979GH
	t/63zDyQ8dh8q5jWJhyMHZXKMERXP5RpuEEuKGd6wTOxlndTrM1ckdW+bYtKv4uHTfPMbczjoxJ
	NmFeKkB
X-Received: by 2002:a05:620a:404b:b0:8cd:8f94:258e with SMTP id af79cd13be357-8d01c7fac01mr313929585a.59.1774619336861;
        Fri, 27 Mar 2026 06:48:56 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4fba2fsm507379385a.34.2026.03.27.06.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 06:48:56 -0700 (PDT)
Message-ID: <770465fe-c38f-45a9-b1b0-0ad682a35fab@gmail.com>
Date: Fri, 27 Mar 2026 09:48:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] read-cache: use index state repository for trace2 logging
To: Jayesh Daga via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Jayesh Daga <jayeshdaga99@gmail.com>
References: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2253.git.git.1774606086325.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/2026 6:08 AM, Jayesh Daga via GitGitGadget wrote:

>     Robustness: The ternary fallback ensures we avoid potential NULL pointer
>     dereferences while maintaining existing logging behavior in edge cases.

> +	r = istate->repo ? istate->repo : the_repository;

If I understand correctly, it is a bug if istate->repo is NULL.

Did you try running the test suite with istate->repo as a replacement for
the_repository in these tracing calls? Is there a legitimate scenario
where this would be NULL?

> +	trace2_data_intmax("index", r, "read/version",
>  			   istate->version);
> -	trace2_data_intmax("index", the_repository, "read/cache_nr",
> +	trace2_data_intmax("index", r, "read/cache_nr",
>  			   istate->cache_nr);

Other than that, this is a minor improvement in the right direction. I'd
rather that it be more complete if you are working in this file.

There are several places where we use the_repository and there is an
'istate' right there. If this change works, then why not apply that same
transformation in the other places?

There are TODO comments for many of these, including the hunk you are
editing (be sure to remove these!).

There are other cases that I see in this file:

* refresh_index() uses the_repository for progress.

* tweak_untracked_cache() has a local pointer 'r' that could
  be set to istate->repo

* tweak_split_index() passes the_repository to
  repo_config_get_split_index().

* do_read_index() uses the_repository when it could use
  istate->repo.

* read_index_from() uses the_repository for tracing.

* verify_index_from() uses the_repository->hash_algo but
  has an istate->repo that could be used.

* do_write_index() has several instances.

(At this point, I stopped taking inventory.)

There are other uses of the_repository that will be harder to remove as
there isn't a local istate at the time, so those aren't worth combining
with this kind of effort.

If you are already working in this space, then I recommend figuring out
how much we can rely on istate->repo and then apply that knowledge to
these cases as separate commits:

1. Replace the uses in the trace2 calls with istate->repo
   and delete the TODO comments.

2. Replace the other uses of the_repository when an istate
   exists already.

Thanks, -Stolee

