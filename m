Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 692F020A17
	for <e@80x24.org>; Mon, 23 Jan 2017 15:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750742AbdAWPzl (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 10:55:41 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35001 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdAWPzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 10:55:40 -0500
Received: by mail-lf0-f65.google.com with SMTP id v186so14427930lfa.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ibK9zHcZc84G2u+b3bo5yW5mpntWwDSxtjQBugBPQqw=;
        b=jxt4wu72AQG0+8K75pVxPPwoqZl3CWrV219HHc7akSWSWoOW5YKItnDv1qhcOclCz9
         7f7dLFCkQK8eTaIzxwZmxUN9NDkDZMe8LJ6afU5PUTRdVK4MFSYRbZqqF2LUSMjzXmA5
         30ax+a7duHk9MQGtq/qVyRg8P1YuUFUnl2kh3n7Q0uwyTbW5LNzw8D9CG18lteWJVxyh
         iYQ5Q/wr0fRoHeo96FPjnjLmyMTsKsPE6JcQh7Dug6XmazXuWtFTt1zYnFNrrLmIxsQv
         /2HR/U9NjOcbeB0DnqHqzTOz5Z9wXt0yhSi0HuLvHO03g4Vz1SRpC5cjMAaOiy83q6Xa
         48cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ibK9zHcZc84G2u+b3bo5yW5mpntWwDSxtjQBugBPQqw=;
        b=Lsof+hPMnN7FP354AormHUEodViOpez8gGhJ/i+2D4ZyADu+w/KEy9H6BAnYIFIoyl
         507Rt/bGff8oU2Y9pvHyPE13kYA41/jkQg9apmMQQhtr/RUm/h2uu15fcGyMHIqNXKV7
         77j7jgJlGVATj8T9PPy4AzLB6zK38LdVGub+D99DdXciAo6lOJGrnFFweotJQQ+g+7sm
         lVGn7G5g0tu4AVeRSE/57vr0cK+78ZrddMHiKLUM0o3xjuvPiCprhq8Zu+j3Hd3OTzs/
         z1JtKsm9X6vIf2uoFtKNmcf/3kXKjlihEc230JrAwFbRlpMqPb6EtYVTpgMzORqpIwbO
         fEQQ==
X-Gm-Message-State: AIkVDXIRaol+y+2I9fOvwkWh94eQr1aEbuen/81uZ+pUOxEHjJiKDkrlye/s2StsQUCT2RxKlb0SbWMPyCW84Q==
X-Received: by 10.46.69.139 with SMTP id s133mr12291706lja.56.1485186938828;
 Mon, 23 Jan 2017 07:55:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Mon, 23 Jan 2017 07:55:38 -0800 (PST)
In-Reply-To: <CACsJy8D1Pf6zTS8gqv5Gq6xMxNNbDrTpKHGADRMKNqW1FAzZvA@mail.gmail.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-9-chriscool@tuxfamily.org> <xmqqpokd9ocw.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD06mxGiZmr4Lwv3M8CedBZaamswzz-Q+mOxuuUFet8KNQ@mail.gmail.com>
 <xmqqshou35zr.fsf@gitster.mtv.corp.google.com> <CACsJy8D1Pf6zTS8gqv5Gq6xMxNNbDrTpKHGADRMKNqW1FAzZvA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Jan 2017 16:55:38 +0100
Message-ID: <CAP8UFD2aQJ92KjzTQTGLyYeEuVk9TK51mn05OSWCZu5c4c6WuQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] Documentation/git-update-index: talk about
 core.splitIndex config var
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2017 at 12:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jan 8, 2017 at 4:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> It feels strange that when I do things one way, you suggest another
>>> way, and the next time in a similar situation when I do things the way
>>> you suggested previously, then you suggest the way I did it initially
>>> the first time...
>>
>> Perhaps because neither is quite satisfactory and I am being forced
>> to choose between the two unsatifactory designs?  In any case, I
>> mostly am and was pointing out the issues and not saying the other
>> one is the most preferred solution in these threads.
>>
>> I think there should just be one authoritative source of the truth,
>
> Either that, or we make sure all sources of truth are consistent. In
> this case, 'update --split-index' could update core.splitIndex if it
> finds that the config tells a different story. As a plumbing though, I
> rather leave update-index do simple things, even if it means the user
> has to clean up after it (or before it) with "git config -unset
> core.splitIndex". Another option is refuse to execute --split-index in
> the presence of (conflicting) core.splitIndex. We kind of force the
> user to keep all sources of truth consistent this way while leaving a
> back door ("git -c core.splitIndex= update-index") for those who need
> tools to recover from a bad case.
>
>> and I have always thought it should be the bit set in the index file
>> when the command line option is used, because that was the way the
>> feature was introduced first and I am superstitious about end-user
>> inertia.  And from that point of view, no matter how you make this
>> new "config" thing interact with it, it would always give a strange
>> and unsatifactory end-user experience, at least to me.
>>
>> Perhaps we should declare that config will be the one and only way
>> in the future and start deprecating the command line option way.
>> That will remove the need for two to interact with each other.

That would be my preferred solution as I think it is the simplest in
the end for users.
Also, as Duy wrote above, one can always use something like "git -c
core.splitIndex= ...", which by the way can work for any command, not
just "update-index".

Anyway we would have to introduce core.splitIndex first, and it
wouldn't make sense to have a different behavior between
--[no-]split-index and --[no-]untracked-cache in the meantime before
they are deprecated and eventually removed.

So let's just go with the implementation in this series, which is
similar to --[no-]untracked-cache, and let's plan to deprecate
--[no-]split-index and --[no-]untracked-cache in a later patch series.
