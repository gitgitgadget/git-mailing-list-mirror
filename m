Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B741F42D
	for <e@80x24.org>; Wed, 16 May 2018 11:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeEPLHl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 07:07:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50625 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeEPLHk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 07:07:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so656978wmt.0
        for <git@vger.kernel.org>; Wed, 16 May 2018 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wFWMeXyI/E6sMDEqneib5ImiXh9TnW0gPRlD7NyErbQ=;
        b=HwkvZSHh0aa4qqeDf5KapzS8kIJy1jRX/Mz69tVt1rkl8fBTzXoEuuhFadlew9N9Eq
         S7uj3zKzcDEJGHR0LBRuAgBmfvwUdvSOmo5+LxQTi19KM2i68D1z8q1qfSJVm8kEorie
         OgpC1OpYiLejjv05kmc1ozGS74VuyjACbxuPXmeQLfpNj6I2/urODz5cA9pGrtoR+vg0
         FYsOCXngy4T7p1zQcnt9A0RvjFonZOKwyLUHBTcMG4EINRYURfq3EMiDTAye62I/Wr5X
         14uHF8HbCmT0AYRyCWogE3ndL/yGNoR2OnK5ukBjuGbEaK7yG/1oQTQ6JCPBHTmtrl6R
         FrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=wFWMeXyI/E6sMDEqneib5ImiXh9TnW0gPRlD7NyErbQ=;
        b=DdLADudyuh88vMSbp8RnRsxQlMHoRP3B+e/AhngrG9fd2iY3ArPRq5iixAPRqvFVY/
         UwkMiaoGLLs1vU/vtCtnF0d9DM2neS6A9792+JNobE1z8HE2VZ3vtCo6Trun75kUciiM
         WH+YgiBRy10OtW1mOauuB+CJmBOkpigaEqDhTuZY9u8W7UCWSSZYjIh+r4kCSlCNlvE3
         uBRUfA1wYxfuv0PiKwvTej08zBdfSmxUtR5FKZ1dE5B5SHzP3WwioJqLDbS+oOh3d+uN
         5H9VUV8a3yqyevBKfz0z7uJ8lZ8brL9Od7w/xx3mG7znHUtwTR6WtNb61/Kmc97eE4dW
         CKJA==
X-Gm-Message-State: ALKqPwf7l7GduDTvBCLb62t5n/liHtA62EIB/+4wj7jiWEjczA/SrNP8
        UN7IiKUivSOZI0XbblS3ICg=
X-Google-Smtp-Source: AB8JxZpnv+qUHeI02R3H4OlKotlNWCO8nRSpDW86X2JZQ/X8sTwsCvrmWd1ohpVsy/B2B2rst+jmDw==
X-Received: by 2002:a50:8085:: with SMTP id 5-v6mr505698edb.257.1526468859264;
        Wed, 16 May 2018 04:07:39 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b47-v6sm1232120ede.70.2018.05.16.04.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 04:07:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <87po1waqyc.fsf@evledraar.gmail.com> <alpine.LFD.2.21.1805160540100.7243@localhost.localdomain>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1805160540100.7243@localhost.localdomain>
Date:   Wed, 16 May 2018 13:07:37 +0200
Message-ID: <87lgcjc0zq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 16 2018, Robert P. J. Day wrote:

> On Wed, 16 May 2018, Ævar Arnfjörð Bjarmason wrote:
>
>>
>> On Wed, May 16 2018, Lars Schneider wrote:
>>
>> > I am looking into different options to cache Git repositories on build
>> > machines. The two most promising ways seem to be git-worktree [1] and
>> > git-alternates [2].
>> >
>> > I wonder if you see an advantage of one over the other?
>> >
>> > My impression is that git-worktree supersedes git-alternates. Would
>> > that be a fair statement? If yes, would it makes sense to deprecate
>> > alternates for simplification?
>> >
>> > [1] https://git-scm.com/docs/git-worktree
>> > [2] https://git-scm.com/docs/gitrepository-layout#gitrepository-layout-objectsinfoalternates
>>
>> It's not correct that worktrees supersede alternates, or the other
>> way around, they're orthagonal features.
>>
>> git-worktree allows you to create a new working directory connected
>> to the same local object store.
>>
>> Alternates allow you to declare in any given local object store,
>> that your set of objects isn't complete, and you can find the rest
>> at some other location, those object stores may or may not have more
>> than one worktree connected to them.
>
>   just to be clear here, there should be nothing about how alternates
> are set up for a repository that should affect the normal behaviour of
> working trees for that repository, correct? i never thought there was,
> i just thought i'd make absolutely sure.

That's correct. The worktree(s) are logically composed of the
index/cache, checked-out files, and the local reference store (and some
auxiliary things, like per-worktree refs like HEAD, and config...).

Whether you have one worktree or many, eventually git needs to look up
objects somewhere. The alternates mechanism is just one more way to
specify where to look, along with some special logic in pack-objects and
the like where we need to be aware of them for the purposes of
maintaining objects in the repository.
