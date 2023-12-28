Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF1101E3
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbDZf/La"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d60ad5f0bso15595605e9.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 11:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703792049; x=1704396849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VvuRxon/MoNQNoEe+UmYYH03WOpAIsmrHH5CWLSH6q0=;
        b=QbDZf/LanwnK42DllwYOAJqjVlX3A0Mq7iA5Ea3halHT3rU2c4ywzmBtJ0etqxgAIR
         TUxgoT6cbBAw/fGcCqFlXugeXpOljlPwD9gCqCzk3OekF6qZhGaRwLgQaxuBwPaTYCNg
         2GEzYxt3A91TmDPbHhyfgEKhcSOZyCxIiOI6kXKyWtog9uEtmEzbhIGva8MSmP5fEne2
         TTt19cvEJ1tp/t1h4TiNt7wNx+5i/bXAWydK7TL6CiDtZmxFKX/mn+oQInvnioZsfDVe
         MMHKCiroi0749zbl6qCfp5x6fEbLLPJbqfi9FJ0JYcR+lt4hIXghE05wx40m6ZgEeR2v
         SYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703792049; x=1704396849;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvuRxon/MoNQNoEe+UmYYH03WOpAIsmrHH5CWLSH6q0=;
        b=i6eozcMTsuBQXDkOAyn/Iv7CFFodgxWqgk0cdcOriQJwC4RcJnksx9l4Sqi4FuBorL
         40f70eFUsp1tDVb/NZxR6j+EJTTKSUDZdGUQPKmsJeTD2E2jM5HG4e/ECaNbxjnEo120
         hpHAK4ZwBsH6niItAlCFzAMIy8/OdQiLCMbegnhEaScOlSPm1mS5iLrAxkldVLQcf9uo
         +mmORCeNp9DjTZ3CTd05NlK5KKr9H8UN+aUjk/o1vpDKwXWYozSBIcp+380gRvda/fp/
         VNo9pJoy90OXqAmj3fzwjvVwgpXBTCoC51zQE+LqY/HalwLiofouw1/u0OycnOOR4KLn
         nxbw==
X-Gm-Message-State: AOJu0YzgWtK9HQBCMk4VBc0FwOpuueNqmKenijEdXd4VLOqLpLfuOZfU
	7IKLIqv1W8JTnujoiv3H2fU=
X-Google-Smtp-Source: AGHT+IF4QY4y2js+Je5rGYEYLDICLmq8q8lEbmcUSTawPq59Oagdh0rS54m7lyI3imBJwpVVNwi3Lg==
X-Received: by 2002:a05:600c:1385:b0:40d:6493:5238 with SMTP id u5-20020a05600c138500b0040d64935238mr914610wmf.19.1703792048866;
        Thu, 28 Dec 2023 11:34:08 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id jg7-20020a05600ca00700b0040c46719966sm35953002wmb.25.2023.12.28.11.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 11:34:08 -0800 (PST)
Message-ID: <48821d3f-2e30-4bce-b9e8-e4199c24e251@gmail.com>
Date: Thu, 28 Dec 2023 19:34:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] mem-pool: fix big allocations
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 Git List <git@vger.kernel.org>
Cc: Jameson Miller <jamill@microsoft.com>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
 <9aad15c8-8d3b-475b-bd44-5d24121cb793@gmail.com>
 <c5d35735-10e2-4b71-8fc7-6218e7002549@web.de>
 <e1e43a6c-3e06-4453-88a3-f00476132bcd@gmail.com>
 <34f5913f-b187-43c3-99b7-3d57065dba12@web.de>
In-Reply-To: <34f5913f-b187-43c3-99b7-3d57065dba12@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/12/2023 18:56, René Scharfe wrote:
> Am 28.12.23 um 17:48 schrieb phillip.wood123@gmail.com:
>> On 28/12/2023 16:05, René Scharfe wrote:
>>> Am 28.12.23 um 16:10 schrieb Phillip Wood:
>>>> The diff at the end of
>>>> this email shows a possible implementation of a check_ptr() macro for
>>>> the unit test library. I'm wary of adding it though because I'm not sure
>>>> printing the pointer values is actually very useful most of the
>>>> time. I'm also concerned that the rules around pointer arithmetic and
>>>> comparisons mean that many pointer tests such as
>>>>
>>>>       check_ptr(pool->mp_block->next_free, <=, pool->mp_block->end);
>>>>
>>>> will be undefined if they fail.
>>>
>>> True, the compiler could legally emit mush when it finds out that the
>>> pointers are for different objects.  And the error being fixed produces
>>> such unrelated pointer pairs -- oops.
>>>
>>> This check is not important here, we can just drop it.
>>>
>>> mem_pool_contains() has the same problem, by the way.
>>>
>>> Restricting ourselves to only equality comparisons for pointers prevents
>>> some interesting sanity checks, though.  Casting to intptr_t or
>>> uintptr_t would allow arbitrary comparisons without risk of undefined
>>> behavior, though.  Perhaps that would make a check_ptr() macro viable
>>> and useful.
>>
>> That certainly helps and the check_ptr() macro in my previous email
>> casts the pointers to uintptr_t before comparing them. Maybe I'm
>> worrying too much, but my concern is that in a failing comparison it
>> is likely one of the pointers is invalid (for example it is the
>> result of some undefined pointer arithmetic) and the program is
>> undefined from the point the invalid pointer is created.
> 
> There are no restrictions on integer comparisons.  So comparing after
> casting to uintptr_t should not invoke undefined behavior.  If undefined
> behavior was involved in calculating the pointers in the first place
> then the compiler might still legally go crazy, but not due to the
> comparison.  Right?

Exactly, my worry is that if the comparison fails it is likely that 
there will have been undefined behavior involved in calculating the 
pointer before we get to the comparison in which case so casting to 
uintptr_t in the comparison does not help.

> Whether the result of a uintptr_t-cast comparison of pointers to
> different objects is meaningful is a different question.  Hopefully
> range checks are possible.
> 
>> The
>> documentation for check_ptr() in my previous mail contains the
>> following example
>>
>>      For example if `start` and `end` are pointers to the beginning and
>>      end of an allocation and `offset` is an integer then
>>
>>          check_ptr(start + offset, <=, end)
>>
>>      is undefined when `offset` is larger than `end - start`. Rewriting
>>      the comparison as
>>
>>          check_uint(offset, <=, end - start)
>>
>>      avoids undefined behavior when offset is too large, but is still
>>      undefined if there is a bug that means `start` and `end` do not
>>      point to the same allocation.
> 
> True, but in such a unit test we'd need additional checks verifying
> that start and end belong to the same object.  Or perhaps use a
> numerical size instead of an end pointer.

Agreed, but I think the implication is that there will be cases we 
should be using check_uint() as in the second comparison above rather 
than check_ptr() as in the first comparison above. I'm not opposed to 
adding check_ptr() if we think it will be useful but I am worried it is 
easy to misuse it. If we do add check_ptr() we should have some 
guidelines about when it makes sense to use it.

Best Wishes

Phillip
