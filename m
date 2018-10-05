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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D26A1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJFCnF (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:43:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38518 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeJFCnF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:43:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so12616525ede.5
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CN8pbcuN2FBDfZjyod5HUqAZUYUiFWL8uHT/nNYehEU=;
        b=ghWymUQi/8UQI7xmoX52FmRzM5blidgvANScAS+WMjm7w8431N6jKkkAl8CwK0sW3s
         KBVmKLY8UU5JjRpaSWD/Mz6RF0kZa1l1ZHAWSG6ovVKU5gOcx9qakJlKFHxl1iwGVuqa
         Q1QtMePJk6DymPxB5+/hpTKgBnYwi8b9gzY2KQvMlu4O3/EMsQSECSLiA6Bx9GoMY/ig
         LL9oWuUsu6XQR5QJjkxZsu4/daucXpgal01GoiE0fh5oK3Atr7/w8qWrdMIvrVfW1ALZ
         /H7Q8Dua4O8KEjjXArwBTsfrIkzPtjLHE4QXc3g12rc+X91JbkSB8rgTnMp0bnuyrLO3
         TxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CN8pbcuN2FBDfZjyod5HUqAZUYUiFWL8uHT/nNYehEU=;
        b=iFmwSjyvfUvecUo4c6glb/kaPMeHPv7HdEcL9hTjfqnfqxSUB4O+6bhNZvnSTt/7cQ
         DgnRbWZWAlOYf4lpwSTp2FHVm9QWtA6mZrH+tJ9AjwSWGuTCVIaTl99JkNb+ZiCSDBA/
         YtiXR5FzXzQ1SlUs+FkrVjLAHp/EJ0K+05SStPxVTlJ4lMOVFRcm74COwkqSI5Lq1iJk
         JDpCJ8cKc8LeX/Xa6kkCLVoKSCTkG7roFGiD2V0yiUSzdaNjNbC7UdsIDJhEb2HaYT8W
         3Z2gePFD09HfnWvRwLJcRkC7Q67NLHEmBgQQvJ4UGM5R/OZZOFFT1qKA34aBBcQy5E4B
         GgMA==
X-Gm-Message-State: ABuFfojqLICDO2uJpcmqFkvX7By50YowHivb3ernHtIDRTcjg/IYOKzo
        WCwP/0qZkCgvHjAsyXxnMs0=
X-Google-Smtp-Source: ACcGV608OI1EVmsl7p21xNhwelSH4rOTUl80wjx+qqj0j3PaxRso1F7/4H5XmlaqyRQUYBL2vo5z0w==
X-Received: by 2002:a50:b203:: with SMTP id o3-v6mr16676072edd.11.1538768571519;
        Fri, 05 Oct 2018 12:42:51 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id l25-v6sm1552514eja.5.2018.10.05.12.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 12:42:50 -0700 (PDT)
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
        <878t3cgqd2.fsf@evledraar.gmail.com>
        <20181005192816.GE17482@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181005192816.GE17482@sigill.intra.peff.net>
Date:   Fri, 05 Oct 2018 21:42:49 +0200
Message-ID: <877eiwgoxy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 05 2018, Jeff King wrote:

> On Fri, Oct 05, 2018 at 09:12:09PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > I'm not wild about declaring functions inside macros, just because it
>> > makes tools like ctags like useful (but I have certainly been guilty of
>> > it myself). I'd also worry that taking "code" as a macro parameter might
>> > not scale (what happens if the code has a comma in it?)
>>
>> There's always the option of generating the C code as part of some build
>> step and carrying around a big C file with various type-safe functions
>> that only differ in the types they operate on. It can even be committed
>> to source control.
>>
>> That sucks in some ways for sure, but is a lot friendlier for grepping,
>> ctags etc.
>
> Yeah, in a lot of ways the C preprocessor is not great for larger-scale
> code generation. I was hoping we could get away without having the
> bodies of these functions as part of the generated bit, though.
>
> I think what René showed later in the thread is not too bad in that
> respect.
>
>> I've just barely resisted the urge to include that thread where we were
>> discussing making the code C++-compiler compatible in the References
>> header :)
>
> Yes. The main thing I would want out of using C++ is type-safe,
> efficient data structures. IIRC, early versions of C++ were implemented
> via code generation, and we're basically walking down that same road.
>
> I'm not sure where the right cutoff is, though. It's nice to pick up
> the solution somebody else produced, but requiring a C++ compiler to
> build Git is a pretty big step[...]

No comment on whether git should use C++...

>  that I imagine will create a lot of new problems. (We're just now
> allowing C99 -- I don't even want to think about what kind of compiler
> issues we'll run into on antique systems trying to use C++).

...But just on this point: I was under the impression that this problem
was way easier with C++. I.e. reason we're just now using C99 for
portable C projects is because Microsoft for years refused to put any
effort into updating their compiler to support newer C versions, while
keeping up-to-date with C++, and that this has only recently started
changing: https://en.wikipedia.org/wiki/C99#Implementations

Maybe there was some other popular vendor of C/C++ compilers that had
the inverse of that story, but I'm not aware of any.
