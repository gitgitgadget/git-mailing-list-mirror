Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 268411F453
	for <e@80x24.org>; Fri,  2 Nov 2018 09:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeKBSgm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 14:36:42 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43284 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBSgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 14:36:42 -0400
Received: by mail-wr1-f49.google.com with SMTP id y3-v6so956485wrh.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pDgeV0XC8X5o5Hvt+bsf81s4jJpHhYAbvQ/HuLzTS4s=;
        b=f4kxokAz2N5o394xctiVUbY8hoOP73KYHbmZXpR4V7pDdsZp/L4DbP/YX0Em+LRGt4
         WqUi10zuJiXdpW/Y6YpEq/2IM1rvDJNsCre7YN9lI6K1knaY9wlV5+7STHEZKPcoizlF
         28dIWd/KyZF53qOU29HUNf6uKqycJeQiL3CMzDsojKsqxM1mQiu2+NMiU4I/8JWNUS3O
         HIlIMDrx3fgel5mg1KRF59uSBaWYki6IQ8M6C7b5pgUEVR07n+C5l6kvtD8iIpEVk45z
         uE09grbKf1gP7yVM0msjBt9wS7NlAUx1C8OQ7lC0ReTLMy10/7ktd0jOFOxhKeG+A+0q
         WaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=pDgeV0XC8X5o5Hvt+bsf81s4jJpHhYAbvQ/HuLzTS4s=;
        b=BaymGWS2sno5ydACWtw2U8VHvvUnbSQTkS59fP7WLO5cb3Y+QhtOeJVpCvTzm76G/e
         DpLzJuvNMYykZl2K/87ZEWPgW5tV1PRjHqbMYlGsj/Sz1AdfcNJ4GqQhc9KwSc/9OzsO
         ggaHqiqFSDX3Euk1fgVJXOhosdYeF/ohhn8GXbj6CW67NAyWM7nLFLTkvtQShe1ygQN2
         326K0ZKFOpOJcIbDV53pVF5OGq/uBaIB6Twlj72oXeMjneWPCwc+vPW/yXR6pdJblZAd
         9Gt4ahXzBJu0KKum8+vx/AzfPmz/NIGjuz7IXYJC5M803dQwcGlf3Ei19RfWHmBwxs+2
         HDBQ==
X-Gm-Message-State: AGRZ1gITwXxZdO067khjjxpE+uNWrqAVcaA7DFBFp5vEtWCt9jzT2q1Q
        IQUxmTj/2nZ9B5N9L0YIt5Shh4hs
X-Google-Smtp-Source: AJdET5fravkEW/0wo6FVFbjMP6+Y8HSK47191o5UZjcjGoGhVXgnkKcDvvlhHJaOCsZ44x6Ap0ncwQ==
X-Received: by 2002:adf:edcf:: with SMTP id v15-v6mr8978706wro.182.1541151007208;
        Fri, 02 Nov 2018 02:30:07 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn166.neoplus.adsl.tpnet.pl. [83.21.181.166])
        by smtp.gmail.com with ESMTPSA id r129-v6sm1704806wmg.25.2018.11.02.02.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 02:30:06 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
        <CAGZ79ka-FTqaXdrMixjUp2THJ3L0YvEnkKxs3XFgB3WEEy2-Tg@mail.gmail.com>
        <86tvl0zhos.fsf@gmail.com>
Date:   Fri, 02 Nov 2018 10:30:02 +0100
In-Reply-To: <86tvl0zhos.fsf@gmail.com> (Jakub Narebski's message of "Thu, 01
        Nov 2018 21:06:11 +0100")
Message-ID: <86ftwjzv1h.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:
> Stefan Beller <sbeller@google.com> writes:
[...]
>> How would this impact creation of a commit?
>>
>> The current generation numbers can be lazily updated or not
>> updated at all. In my understanding of the maximum generation
>> numbers, a new commit would make these maximum generation
>> numbers invalid (i.e. they have to be recomputed).
[...]
>> For the V2 maximum generation numbers, would we need to
>> rewrite the numbers for all commits once we recompute them?
>> Assuming that is true, it sounds like the benchmark doesn't
>> cover the whole costs associated with V2, which is why the
>> exceptional performance can be explained.
>
> Let's check it using a simple example
>
> First, (minimum) parent-based generation numbers before and after
> extending the commit graph:
>
>   1   2     3   4     5   6   7    new
>   1   2     3   4     5   -   -    old
>   .---.-----.---.-----.---*---*
>        \
>         \   3   4     5   6        new
>          \  3   4     5   6        old
>           \-.---.-----.---.
>                  \
>                   \   5            new
>                    \  -            old
>                     \-*

Let me check yet another idea, using (minimum) parent-based V0 generation
numbers (counting distance from the sink / root) as a starting number
for source / heads commits.

    1   2     3   4     5   6   7    new
    1   2     3   4     5   -   -    old
    .---.-----.---.-----.---*---*
         \
          \   3   4     5   6        new
           \  3   4     5   6        old
            \-.---.-----.---.
                   \
                    \   5            new
                     \  -            old
                      \-*


Well, on this example it looks like this variant of maximum generation
numbers can be done incrementally, but let's check another example

   1   2     3   4   5   6     7   8   9       new
   1   2     3   4   5   6     7   8   -       old
   .---.-----.---.---.---.-----.---.---*
        \                     /
         \   3   4           / 5   6   7   8   new
          \  5   6          /  -   -   -   -   old
           \-.---.---------/---*---*---*---*

It looks like it doesn; give as good results as I thought.  Less values
are changed, but you would still need to recalculate them, unless it can
be proven that they do not need it.

>
> Next, maximum generation numbers.  We start with 9 commits, and we end
> up with 12 commits after the change
>
>   6   7     8   9     10  11  12   new
>   4   5     7   8     9   -   -    old
>   .---.-----.---.-----.---*---*
>        \
>         \   9   10    11  12       new
>          \  6   7     8   9        old
>           \-.---.-----.---.
>                  \
>                   \   12           new
>                    \  -            old
>                     \-*
>
>
> As you can see all maximum generation numbers got rewritten.
>
> Though if instead using the number of commits, we use the maximum
> generation number, or in other words the length of the longest path, we
> get the following:
>
>   1   2     3   4     5   6   7    new
>   1   2     4   5     6   -   -    old
>   .---.-----.---.-----.---*---*
>        \
>         \   4   5     6   7        new
>          \  3   4     5   6        old
>           \-.---.-----.---.
>                  \
>                   \   7            new
>                    \  -            old
>                     \-*
>
> A bit better, but still much change in numbers.

--=20
Jakub Nar=C4=99bski
