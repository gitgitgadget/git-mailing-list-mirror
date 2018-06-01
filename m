Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0C51F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 00:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeFAALJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 20:11:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50623 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeFAALI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 20:11:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id t11-v6so57006240wmt.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 17:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1KbdmzZWYoumILfhCvcHMbj2chii3ZFjrVBmlLCMqLc=;
        b=EokqAFMBKZ2tlAxWxcFbV6EyKDBRHRLQbP886uDH8Sg/BllOTctAWdFDTzFpHZUtVp
         3N+0f4Oe5WcWy1W5aLouOP58LkeRN80roS1YP156fBaV/mkTZsL3uk5mzOGMdv7X6wet
         PL7PrO4WrFkDgLgTO03/WxIEBdEBsbNSjwSAqEjpglkz/LKZIICrF0G1bswmgCQjMr5h
         195RbikK7vgbS0cIy1niqVMcxXXmO1d7D1Bs1pFVpvVyEydoMdmJG23TFXf/1tPD8K5Y
         lbBDwYzaqB28xlYfJODZWMVeHNVnkL4NxwCTE4Du7bYKACm2hqQaYzHl++Ny5krD/cLL
         qw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1KbdmzZWYoumILfhCvcHMbj2chii3ZFjrVBmlLCMqLc=;
        b=ubrk9piDjKkThFVT2Xex9ioljbQc4cRM/Dz9lTih1ivwE3JJOYFDbKnLkgwsro5iJk
         xDgDnBU0ivXUODnvZShaNlWQYnDt6tqE0rukh6x0Lur/5yOO15z8jVIVvQFpMOxGxcyn
         hoQbY7bbyq65TBz3Lx32SbVi1eIUgzd5bIyaqgdfrBjwtbEb28VT9SMQC7d8fhNSX6cd
         LI5+7ssw4tNl7V0YO7F0EGTF8nrci2VQWRh/beSW2gNgAkgxCZNIZvFBFgjTXC7gdEhW
         G1j8BFVl6HkRKW0n4rIc/hI6b3Br1ofvo9NgU8hGp/CDnVlRmvSeFzKIJJUYDp9wULsU
         8fEQ==
X-Gm-Message-State: ALKqPwfKdGfiOjuSOngbfS9/orlCq52gVNaXsBwI+Eu+stMZ8xCPSkjS
        pU82ywm4RhFIzgtOcHovpvw=
X-Google-Smtp-Source: ADUXVKLIqGV+5eR2pI8MlW77xnwCJtscj3D2Ii1gRxQu9rcJ0KhzDA7Qd0FBmXetSnNE3GPSnRRjXQ==
X-Received: by 2002:a1c:e906:: with SMTP id q6-v6mr1113645wmc.23.1527811867286;
        Thu, 31 May 2018 17:11:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t46-v6sm49142825wrc.95.2018.05.31.17.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 17:11:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] config doc: unify the description of fsck.* and receive.fsck.*
References: <20180524193516.28713-1-avarab@gmail.com>
        <20180525192811.25680-1-avarab@gmail.com>
        <20180525192811.25680-3-avarab@gmail.com>
        <CAPig+cT=i0XYOrMymNjsBJqcLfJ38Ft_=MZPZD3N-AMo8raAHQ@mail.gmail.com>
        <xmqqa7skjep9.fsf@gitster-ct.c.googlers.com>
        <CACBZZX5mSj2=JXtVPrPZ8Y1gCyu9p+EMYoSPeFZtuvm3FsdLNg@mail.gmail.com>
        <xmqqr2ltetcy.fsf@gitster-ct.c.googlers.com>
        <87fu289tph.fsf@evledraar.gmail.com>
Date:   Fri, 01 Jun 2018 09:11:05 +0900
In-Reply-To: <87fu289tph.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 31 May 2018 09:20:58 +0200")
Message-ID: <xmqq4lincqna.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It's our documentation that should be clearly stating those reasons. If
> we're not saying anything about these being historical bugs, then e.g. I
> (not knowing the implementation) wouldn't have turned this on globally
> on my site knowing that because I have none of these now I'm *very*
> unlikely to have them in the future.
>
> That's different from something that just happens rarely, because a rare
> non-historical event can be expected to happen in the future.

Interesting.  If I did not know Git at all, I would decide
completely opposite---because I have none of these now, I'm very
unlikely to have them in the future, so I would leave fsck.<msg-id>
alone to the generally recommended state (i.e. not customizing
without understanding what I am doing).  That way, (1) if that
unlikely thing happens, I would notice and have a chance to deal
with it, and (2) otherwise, I wouldn't have to worry about that
unlikely event at all.

And that decision would not change even if I _knew_ these knobs'
categories were invented to align with bugs and anomalies in older
implementations of Git.

>
>> Between "fsck.<msg-id> makes sense only when you use these rare and
>> you-probably-never-heard-of tools ongoing basis" and "when you
>> already have (slightly)broken objects, naming each of them in
>> skiplist, rather than covering the class, is better because you want
>> *new* instances of the same breakage", I'd imagine the latter would be
>> more helpful.
>>
>> In any case, let's see if there are more input to this topic and
>> then wrap it up in v3 ;-)
>>
>> Thanks.
