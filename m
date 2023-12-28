Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A5101C1
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpSnENlh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5ae89c7bso17663085e9.2
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703782092; x=1704386892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n+cSrG4CfTUqK6NTFoOLXOD9SwBpcvXK1nm3cQ2t6NU=;
        b=NpSnENlhzVnhUnEInBXgvEh2PKw+xCk11gLAVzBw/UQiSJKwrcz0YfTbPPO0T/lx8r
         cJoVKo3i7iloDPHjrzygHk+Ye7cAmNKcEiOR0d0iwjFNPB8TaO+XLgsm0LsIVk2uybuv
         RTB3fJ/sfg2Myh30MYjkdfmMvuFy/ilZqqJcT+bFkXwxjazMKvy7Wt6RTZAM2ABZyE+l
         FbzP/yIAR3+6EFmt9e93w/idvKf17zdt9UqCfG/BNqAHD1wTFJZ33E6Bj4LfA6+3mfoU
         tKrN0PsDUS6R96ToDgo90GrtxgRi2zqpN81Z0saK41KQwuQNT6N0mhZEbxnHy+60HrKB
         x3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703782092; x=1704386892;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+cSrG4CfTUqK6NTFoOLXOD9SwBpcvXK1nm3cQ2t6NU=;
        b=ZfZBbyQjo5WblQA62VUMOO+FL8NeHZLYwmRkSwJ01fqtpN22apPyT+8PDM4cng2mPe
         PyXX20iJGz4ZfD9+3qsGqwCpIlNX7VSSwJ1lL8iQxy/Yv0EVzGhfg8b7GAm/ncr5GFtd
         N6ty7Qna0a6JNc2KvNIIUB1RWyLZBrsyvO5VGh0qWTpuOzmmxonG1INKkzirKRGIdPwS
         Lk0klcVg0J0NAvHEYGLokabrCeDKNqWaSpmPWMBCuSuyfw3AsfHwa4R/G3hsaqYqiEgN
         C8AxnRMwNBbP5Jwf4fzfPUUdFYY0Mm/WJwmFu3Z6VCkJfsesvAsjLxYxkiSVH/OdNDjm
         FkCQ==
X-Gm-Message-State: AOJu0YyWPNE6IVviTfOTYbNa55lja7PNDZjhiYhfXQZXnysUsQrsZf1B
	MJXe5wrO+sbjk+cJF7gX2TY=
X-Google-Smtp-Source: AGHT+IEXUyywv0NoUi8Jhp0fHNVt03CABMZDHDu6rwSTZY4tEGLCjnhzPjxwwq//YZcU5yxC/Lu+Kg==
X-Received: by 2002:adf:ea86:0:b0:336:c403:56e0 with SMTP id s6-20020adfea86000000b00336c40356e0mr3653119wrm.130.1703782092093;
        Thu, 28 Dec 2023 08:48:12 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4d04000000b00336a1f6ce7csm12936099wrt.19.2023.12.28.08.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 08:48:11 -0800 (PST)
Message-ID: <e1e43a6c-3e06-4453-88a3-f00476132bcd@gmail.com>
Date: Thu, 28 Dec 2023 16:48:11 +0000
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
In-Reply-To: <c5d35735-10e2-4b71-8fc7-6218e7002549@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/12/2023 16:05, René Scharfe wrote:
> Am 28.12.23 um 16:10 schrieb Phillip Wood:
>> The diff at the end of
>> this email shows a possible implementation of a check_ptr() macro for
>> the unit test library. I'm wary of adding it though because I'm not sure
>> printing the pointer values is actually very useful most of the
>> time. I'm also concerned that the rules around pointer arithmetic and
>> comparisons mean that many pointer tests such as
>>
>>      check_ptr(pool->mp_block->next_free, <=, pool->mp_block->end);
>>
>> will be undefined if they fail.
> 
> True, the compiler could legally emit mush when it finds out that the
> pointers are for different objects.  And the error being fixed produces
> such unrelated pointer pairs -- oops.
> 
> This check is not important here, we can just drop it.
> 
> mem_pool_contains() has the same problem, by the way.
> 
> Restricting ourselves to only equality comparisons for pointers prevents
> some interesting sanity checks, though.  Casting to intptr_t or
> uintptr_t would allow arbitrary comparisons without risk of undefined
> behavior, though.  Perhaps that would make a check_ptr() macro viable
> and useful.

That certainly helps and the check_ptr() macro in my previous email 
casts the pointers to uintptr_t before comparing them. Maybe I'm 
worrying too much, but my concern is that in a failing comparison it is 
likely one of the pointers is invalid (for example it is the result of 
some undefined pointer arithmetic) and the program is undefined from the 
point the invalid pointer is created. The documentation for check_ptr() 
in my previous mail contains the following example

     For example if `start` and `end` are pointers to the beginning and
     end of an allocation and `offset` is an integer then

         check_ptr(start + offset, <=, end)

     is undefined when `offset` is larger than `end - start`. Rewriting
     the comparison as

         check_uint(offset, <=, end - start)

     avoids undefined behavior when offset is too large, but is still
     undefined if there is a bug that means `start` and `end` do not
     point to the same allocation.

I agree it would be nice to allow arbitrary pointer comparisons but it 
would be good to do it in a way that does not expose us to undefined 
behavior. I'm not sure what the right balance is here.

Best Wishes

Phillip
