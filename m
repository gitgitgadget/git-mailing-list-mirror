Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160B101E1
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbnxkvG/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso23226495e9.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703792192; x=1704396992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vS3LtMndWuzJsPtpvgXXbnqnTk1PvZGEWMTy+HZUGRc=;
        b=BbnxkvG/qDnuUKOpzAOYy0f/mobSrjILSBtPLg4k6wH4Anfw6PS7k79PPgWZAE1yD/
         5n2uVKnisQAeT+Tnk8tTMVxuXuRhktCuUjTKaLarqm1rumuzlppf/PNKXj8h17s78scw
         +en9H8yB3JaP1KQhrsI17Mll75HsCFQ9zeercc7tyGzjkKzu1Jd69fBhS9IjNxXaEeFv
         VwzRZiBQBq+0pnN2D7gdSwqZHt6mxq2SJcLRwOcD4BrEpgAEtMwdy+SHGDQebkUdwraS
         S8/G2tgGwEFGCZBg24f0+f5o4OY5qQmIPpc+W1PkKbPRqDYz/cSSovl0J530kR1uJZhm
         30FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703792192; x=1704396992;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vS3LtMndWuzJsPtpvgXXbnqnTk1PvZGEWMTy+HZUGRc=;
        b=flF8pTnsvFJQxLBilxd724MQLIEpdorAFlr5NYtDgFjUfghsYL1g09dhsB5WAn/MWi
         Ug4EUkMANOWatQ13RYyiknAK9g/IM9D+kO5tlnaEN87UQSxxMzU/KwrQVlobj2fXv6m0
         HWYjPhOu+4WurHHu9N1+MXcPxRxdkncGxfyuBB2wOCVH/cPoWurDI5DGl//L7/mZX3aN
         UhqC9i6HyNYTQR7ROICimZt1AwO+VcDN1NIZGp850qrmR+zlTJigh8WhoQiqL+s41wU4
         JReQvKCIcwm2m2GtRKzL+iVb9bJw/mayoUKy/MgQFklV11k5jp2WvJTIhjy/Q5Gft3xa
         HLkA==
X-Gm-Message-State: AOJu0Yxk/fB/1uqBYIHR7rmtyNWjWI4d8VNXwhMF/SczRcQtaa1AIc3X
	1oGvx4kFa6a66y2H5Z0YaFY=
X-Google-Smtp-Source: AGHT+IGMygqncuOn9uSXvqldeJqLPXCYywZa59OBNW773uWV6dliZGuEEnJx8JYdtFIBPL3zgcnerA==
X-Received: by 2002:a05:600c:21c3:b0:40c:32bf:20f with SMTP id x3-20020a05600c21c300b0040c32bf020fmr5503397wmj.147.1703792191913;
        Thu, 28 Dec 2023 11:36:31 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b0040b360cc65csm29274595wms.0.2023.12.28.11.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 11:36:31 -0800 (PST)
Message-ID: <9bafdbfe-f451-43b1-806d-be3d70e21892@gmail.com>
Date: Thu, 28 Dec 2023 19:36:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] mem-pool: fix big allocations
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Jameson Miller <jamill@microsoft.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Elijah Newren <newren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
 <1c39c0e7-05b2-4726-a90c-f78df4356a41@web.de>
In-Reply-To: <1c39c0e7-05b2-4726-a90c-f78df4356a41@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 28/12/2023 19:19, René Scharfe wrote:
> Interdiff against v1:
>    diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
>    index 2295779b0b..a0d57df761 100644
>    --- a/t/unit-tests/t-mem-pool.c
>    +++ b/t/unit-tests/t-mem-pool.c
>    @@ -1,8 +1,6 @@
>     #include "test-lib.h"
>     #include "mem-pool.h"
> 
>    -#define check_ptr(a, op, b) check_int(((a) op (b)), ==, 1)
>    -
>     static void setup_static(void (*f)(struct mem_pool *), size_t block_alloc)
>     {
>     	struct mem_pool pool = { .block_alloc = block_alloc };
>    @@ -16,11 +14,10 @@ static void t_calloc_100(struct mem_pool *pool)
>     	char *buffer = mem_pool_calloc(pool, 1, size);
>     	for (size_t i = 0; i < size; i++)
>     		check_int(buffer[i], ==, 0);
>    -	if (!check_ptr(pool->mp_block, !=, NULL))
>    +	if (!check(pool->mp_block != NULL))
>     		return;
>    -	check_ptr(pool->mp_block->next_free, <=, pool->mp_block->end);
>    -	check_ptr(pool->mp_block->next_free, !=, NULL);
>    -	check_ptr(pool->mp_block->end, !=, NULL);
>    +	check(pool->mp_block->next_free != NULL);
>    +	check(pool->mp_block->end != NULL);
>     }

The changes to the unit tests look good to me (I haven't really looked 
at the actual bug fix in the mem_pool code).

Best Wishes

Phillip
