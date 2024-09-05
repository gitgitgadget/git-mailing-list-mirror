Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE02107
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502128; cv=none; b=nx4JTe0PI6JR+Hm1w+vyK8pl6ZoNhtBX6LDZpVvnO5UOAbnvTKAm2MgQoK5E45Y0IF4xRh/30j1jTCfPLHgM/IIYMaupqVH57JEybf8BPK/dvhv9AxpAP9nPtWNvFRgj+pk1G2a5ZRE4CPnq0x3slPC4IpVcX/YwCsRH0wLa8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502128; c=relaxed/simple;
	bh=evRILUxeVDw8Zk51hkvmyQDvm3DEi3T1RYUwoyqPb3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdNsSfm90WwtuN1EUdAky7cuLUAPHSg3v8aM5EHKEI1YTo3Vq9cpPHzF1FGnqNJF77nYbT1Jxb2FJFcjBQbOOBnJI7DQM5kmwLBCi+ldpoj2ffDnveaBap1PKgxdnuXBu5oTyJkxOt3Moh9TzUXQEVG0l3GN9oQbwawC4FI429g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hcr++HD3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcr++HD3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20696938f86so2668885ad.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725502126; x=1726106926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIe18wRDbkxGw+7m+QLNJvCl57RbHj+KAtp5tyxv8Pg=;
        b=Hcr++HD3YusCet2zoQheCeDRSGywubmKITtDUBN5Vjvv4IidN7vfsuXXNQvc+XeKHY
         Lv1X9TO84yfDOy9JIzXfamA9SIeBpwbkV4iFOOdvTkNxfZVJGpa4/Tkd+7SqIWsEx3LL
         CMeJgkvcxJT8K4Pje6Wp02qs3/wU9ZeeiN3PsAfVzMWC9wJgKmG9yszHdb0TE+2lBcAK
         lTF46mqbfAM9i+zyw8xcOuT99o0wRJQiag7xCz/bCxUGQJJ32CagVN8GjOX+4ClRVZDf
         WyQS+00+f20Ms00oYo/n1VG+HcyatqYYvd8G5qfnAhkQWvabhXeP9gIA6gxAXsB/2Li5
         lKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502126; x=1726106926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIe18wRDbkxGw+7m+QLNJvCl57RbHj+KAtp5tyxv8Pg=;
        b=wdLVyAH2Hsk5lt8DQygDQyHLL0gQTBLBuGxTt8MLzuXz1biQ+u5JPCvqjwSnXUWKH/
         Pa00J0q/k7ywE29tSewM1ahzB67zi8E02Cl7CYPB6Xs720fJ5iC4xqFRRWcgZw0VvYpr
         QxexsLujL9E1jA0jPx3XYfzNakeMnMP9fIsFgCI6AGNQA7f+qmbK4ruGcStUWSdsyXlT
         hMVZPbtxesDzekHp7eJ0EvXsmq6H5kc7yvvjuQh24/fj5Vd1egrH9dhkNNuV8Cmq02BN
         CH7fA1svLwA9azlEiXNW5Nr1CP0UiZTM5yXseFWqCcS9Rx4BqqBeUIATAozHcG8jNynU
         34FA==
X-Forwarded-Encrypted: i=1; AJvYcCVKBxNUz1lLzFNUxrpEX29BuBORf0OULZ04X/8f0jYMnTj/LdKmXmhQJtSy6Ft7xdmGiZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOJOlFkCh60qJJooTD6I6ixYsf5/52urFOSKFwlce9HdL7YNR
	5yZNlgFPyJg/r2JkHgN9uyrkFfxBByTtywIbOYuoChKd0LjLNf5Z
X-Google-Smtp-Source: AGHT+IFuBrfpazOd/6Tznk/GTJctLEKjEwppMMYhGCtdvxNC7uYdvGR/3vZ9HKxM2+gUuVnddX0OdQ==
X-Received: by 2002:a17:902:ecca:b0:205:7b1f:cf66 with SMTP id d9443c01a7336-2057b1fd228mr103870465ad.35.1725502125825;
        Wed, 04 Sep 2024 19:08:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95dd98sm19429055ad.107.2024.09.04.19.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 19:08:45 -0700 (PDT)
Message-ID: <52f6da10-e39a-4a2d-bd9a-5739a49235c2@gmail.com>
Date: Wed, 4 Sep 2024 22:08:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remote: prefetch config
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>,
 Shubham Kanodia <shubham.kanodia10@gmail.com>
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
 <e8232cdc-7a5d-485e-84f7-2c05e17f9907@gmail.com> <xmqqfrqf87gb.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqfrqf87gb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 4:55 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:

>>> +		# Run maintenance prefetch task
>>> +		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>>> +
>>> +		# Check that remote1 was not fetched (prefetch=false)
>>> +		test_subcommand ! git fetch remote1 --prefetch --prune --no-tags \
>>> +			--no-write-fetch-head --recurse-submodules=no --quiet \
>>> +			<prefetch.txt &&
>>
>> I'm happy to see this use of test_subcommand to validate the behavior
>> of this patch!
> 
> I found it a bit disturbing that the pattern is overly specific.
> 
> The only thing we are interested in is that we are not fetching from
> remote1, so it _should_ suffice if we could write
> 
> 	test_subcommand ! git fetch remote1 <prefetch.txt &&
> 
> to avoid being tied to how the current version of Git happens to
> pass these command line option flags and the order it does so.
> 
> Looking at the implementation of test_subcommand, it seems that we
> cannot quite do that (it assumes that the pattern it assembles out
> of the parameters are to match the full argument list used in
> invocation, enclosing them in a single [] pair and without giving
> the caller an easy way to sneak wildcards like ".*" in), which is
> sad.
I agree the ergonomics of the test_subcommand helper is a bit poor
(and not this patch author's fault). The trickiest part is the
negative case, as in this highlighted one. It's hard to read from
this if the subcommand wasn't found because the argument list is
too specific and doesn't match the exact arguments.

It helps that the same options are given for the other, positive
tests. But maybe that could be a hint as to how to make this test
a bit cleaner: make a variable describing the "uninteresting"
arguments. Something like...

	args="--prefetch --prune --no-tags \
  	      --no-write-fetch-head --recurse-submodules=no --quiet" &&

	test_subcommand ! git fetch remote1 $args <prefetch.txt &&
	test_subcommand git fetch remote2 $args <prefetch.txt &&
	test_subcommand git fetch remote3 $args <prefetch.txt &&

Thanks,
-Stolee

