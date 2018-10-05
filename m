Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3CB1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJFCMT (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:12:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43325 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeJFCMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:12:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so5894061eds.10
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 12:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=51sOsoanjSNq1KpRXbSfOBDvPSgUhNpLDQpNMM03ObM=;
        b=QziTvzqElpd7IXCZJhClT4QFl93qCEZNmO/3Ip3njfdlUPXl222/VGnwgoR+4biOaV
         SoVXD72z1+KqtuQKx6zO1kIws5l3wRL6AfuRduuDHSA4yGt66AjBlGvSBstgPP72Nn44
         +xhPujf2zzz+XN9Y9iOquOHE3Hm4R1r6zMMUpi3WUeCTAzkUgNKjTusEcOZPRf//4WC5
         KyVygIb2sb8t3cpu49+41RCmMCFRvbw+IcDvv8r+v3mC+dV6nQG1UFHK08rxDwfObc7y
         8hQ3gpKZeAQimP7nurNgxFz3R5vICIkCHX1B1m+KqAE+wLKnAmpnXPMxMly4mBavs+oZ
         iIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=51sOsoanjSNq1KpRXbSfOBDvPSgUhNpLDQpNMM03ObM=;
        b=IHy0oY+f4NCHtxsOPX4fdpark9I8e8daGy8v4w7sOzDieHjhss2+H5c7KuhpJBFAOU
         We9F85nuhPRDBn0xdxxOcT17yPKiH9h9LvzYe1v6aSS6a7D8npQn7XAs6tHumdKFJvab
         Sm4lFjg5x5uvBNyMNAOzCSdBCEEA0uOxWZjnWgvqVoP+17eaIAw7V6Q7zL/sOOMsY3mG
         A+etgsaP9c9MlM85f5w8aA5rDjLvqc+ta106xZ31Mnutm3cM/0Trn2PRFqAAco3rY4/g
         Tmc/IksVk5z7iWmplDMP6CbUZ+k3E+yAFtVdL5xlkHqARcoGIW4EMutH0DyT7wFI9E3p
         3Xeg==
X-Gm-Message-State: ABuFfojjD/fbrl/197B37eDtI9h32Lzr0y3GtyJ+xRkw6iHCeHB/4s6M
        /DDtc5RNuQVur4vbSDR4KPA=
X-Google-Smtp-Source: ACcGV63AKdxlo3w9qKQ4xxtgLw1q6DFJ54rzHKDokyLZEYQBEdztbW9AEqnL0dhpelKBIfxsz7v3mw==
X-Received: by 2002:a50:fb8a:: with SMTP id e10-v6mr2516578edq.153.1538766733071;
        Fri, 05 Oct 2018 12:12:13 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id f21-v6sm884852ejc.2.2018.10.05.12.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 12:12:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
References: <pull.10.git.gitgitgadget@gmail.com>
        <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
        <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
        <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
        <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
        <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
        <20181005165157.GC11254@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181005165157.GC11254@sigill.intra.peff.net>
Date:   Fri, 05 Oct 2018 21:12:09 +0200
Message-ID: <878t3cgqd2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 05 2018, Jeff King wrote:

> On Fri, Oct 05, 2018 at 12:59:02AM +0200, René Scharfe wrote:
>
>> We could also do something like this to reduce the amount of manual
>> casting, but do we want to?  (Macro at the bottom, three semi-random
>> examples at the top.)
>> [...]
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5f2e90932f..f9e78d69a2 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -1066,6 +1066,18 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
>>  		qsort(base, nmemb, size, compar);
>>  }
>>
>> +#define DEFINE_SORT(name, elemtype, one, two, code)			\
>> +static int name##_compare(const void *one##_v_, const void *two##_v_)	\
>> +{									\
>> +	elemtype const *one = one##_v_;					\
>> +	elemtype const *two = two##_v_;					\
>> +	code;								\
>> +}									\
>> +static void name(elemtype *array, size_t n)				\
>> +{									\
>> +	QSORT(array, n, name##_compare);				\
>> +}
>
> Interesting. When I saw the callers of this macro, I first thought you
> were just removing the casts from the comparison function, but the real
> value here is the matching QSORT() wrapper which provides the type
> safety.
>
> I'm not wild about declaring functions inside macros, just because it
> makes tools like ctags like useful (but I have certainly been guilty of
> it myself). I'd also worry that taking "code" as a macro parameter might
> not scale (what happens if the code has a comma in it?)

There's always the option of generating the C code as part of some build
step and carrying around a big C file with various type-safe functions
that only differ in the types they operate on. It can even be committed
to source control.

That sucks in some ways for sure, but is a lot friendlier for grepping,
ctags etc.

I've just barely resisted the urge to include that thread where we were
discussing making the code C++-compiler compatible in the References
header :)
