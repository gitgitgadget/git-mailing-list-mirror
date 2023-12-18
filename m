Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789764FF61
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD4FRRQu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3365f1326e4so2081230f8f.1
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702916319; x=1703521119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tnaQVSOnoyQe3rdzJElblW7IAIYuPeaPDwqloB7lCak=;
        b=lD4FRRQuk6Gqk8lX9yBsP4hqo5gjb5ihL+1p+BZ+GE7DAeAftZ6s1kJWzFc+EN54K8
         ZhkbjQTWejknOxXfcrbj3UP4NMU9g+tzSTMEkR300X45RDaVv5Bb7Jk5lpSU6tTZZTWS
         zO7LNvuLglxs2nl8+nx1ySgwBmLutpko6JYcp0TK61ZYsqwQQPrCPBMYUXIzsN9onefz
         Tjin3eHXqsbbyXN9PQ9YGP6MOFH61HJyn0nT6iiDoL1f9zJec7jlEtEnZkowp/NyOZcM
         3jVCnjathyBNeqZ2W9FPBmzsNTLtvz+Jz/cy1GQYCL3uS4I53ib+1UfjkyPmKx3KvDkw
         yqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916319; x=1703521119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnaQVSOnoyQe3rdzJElblW7IAIYuPeaPDwqloB7lCak=;
        b=hpeIEgL+ykUvx9f8m04NBvxW+v5tE3KQOtfhuxNBu8qFysXUfwTUibwNCXiSdb1c9R
         Y+gW3VfUFL1wbdDt33L4Bl797/Dr9zhv3QsYCpXM4EpvoiIhRLtuRfkmz1e/gLZUMyRp
         8hHhtqVzFCUIo9oqNB/uxYIAnPSgze2WKewqE0723MZ/mSO/cGVx3fI+Si1pkWvSh25I
         +sBPfx3e/zhRtY2Rb1Be4L7o0RUcDkSSPlaKMlJ8W7i7Y5vch2ugeIJSAhIfep4n9mwD
         g9S1kywlgAqERGoNPEANyJXPAieChOB9VUCivX/cle79mBnKC/x/VxmuzdQvOJNVt4bj
         qeEw==
X-Gm-Message-State: AOJu0Yzif5jUgvJQ30jH8DB96hvnOQomCpPGMXDTJUSimcHcOY7PLkNT
	+MIQ3kWYpygsUNbwaCVtJz73fTTaPkk=
X-Google-Smtp-Source: AGHT+IG/gCbGYefvK72dEzaXU4IZrWgg++EwgKKC/EQFcJG1c/IGrLnoogu5DDQJ5aUzKZKDfz45VA==
X-Received: by 2002:a5d:6c6e:0:b0:336:66fc:6791 with SMTP id r14-20020a5d6c6e000000b0033666fc6791mr1792708wrz.107.1702916318374;
        Mon, 18 Dec 2023 08:18:38 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id m12-20020adffe4c000000b003366827c9c6sm3234797wrs.2.2023.12.18.08.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:18:37 -0800 (PST)
Message-ID: <ff4a6abc-8abf-4dbf-a787-e4895a78b048@gmail.com>
Date: Mon, 18 Dec 2023 16:18:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 AtariDreams via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Seija Kijin <doremylover123@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com> <xmqqo7erl7er.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqo7erl7er.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio

On 15/12/2023 17:09, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Even if it unlikely that we would directly compare a boolean variable
>> to "true" or "false" it is certainly conceivable that we'd compare two
>> boolean variables directly. For the integer fallback to be safe we'd
>> need to write
>>
>> 	if (!cond_a == !cond_b)
>>
>> rather than
>>
>> 	if (cond_a == cond_b)
> 
> Eek, it defeats the benefit of using true Boolean type if we had to
> train ourselves to write the former, doesn't it?

Yes, it's horrible - if for some reason it turns out that we cannot use 
"#include <stdbool.h>" everywhere I think we should drop it rather than 
providing a subtly incompatible fallback

>> A weather-balloon seems like the safest route forward. We have been
>> requiring C99 for two years now [1], hopefully there aren't any
>> compilers out that claim to support C99 but don't provide
>> "<stdbool.h>" (I did check online and the compiler on NonStop does
>> support _Bool).
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1] 7bc341e21b (git-compat-util: add a test balloon for C99 support,
>> 2021-12-01)
> 
> Nice to be reminded of this one.
> 
> The cited commit does not start to use any specific feature from
> C99, other than that we now require that the compiler claims C99
> conformance by __STDC_VERSION__ set appropriately.  The commit log
> message says C99 "provides a variety of useful features, including
> ..., many of which we already use.", which implies that our wish was
> to officially allow any and all features in C99 to be used in our
> codebase after a successful flight of this test balloon.
> 
> Now, I think we saw a successful flight of this test balloon by now.
> Is allowing all the C99 the next step we really want to take?
 >
> I still personally have an aversion against decl-after-statement and
> //-comments, not due to portability reasons at all, but because I
> find that the code is easier to read without it. But in principle,
> it is powerful to be able to say "OK, as long as the feature is in
> C99 you can use it", instead of having to decide on individual
> features, and I am not fundamentally against going that route if it
> is where people want to go.

I'm not sure we necessarily want to say "use anything that is in C99" 
for several reasons.

  - Some features such as C99's variable length arrays are known to be
    problematic.

  - As you say above there maybe features that we think harm the
    readability of our code.

  - As René points out not all compilers necessarily support all
    features.

I think using _Bool could be useful for the reasons Peff outlined. As 
for other features I've written code that I think would have benefited 
from compound literals, but off the top of my head I can't think of any 
other C99 features that I personally wish we were using. I think that 
decl-after-statement is occasionally useful to declare a variable near 
where it is used in a long function body but it is much simpler just to 
ban it altogether and encourage people to break up long functions to 
make them more readable.

Best Wishes

Phillip

> Thanks.
> 
> 
