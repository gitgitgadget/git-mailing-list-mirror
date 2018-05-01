Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E723A21847
	for <e@80x24.org>; Tue,  1 May 2018 23:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeEAXLu (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 19:11:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53106 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeEAXLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 19:11:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id m70so19379719wma.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6sWrXQHHpYIVbTe3LgGGbPvOLO7eHBs7BxZOAIktnkM=;
        b=JLFSFNN//piuovNETlWONauykOkdB7v4WSsal5bEuwkbtuPKfe2zfb4doH5NWUwLSI
         Lw9W+lFiXIiHkg/Md8B3WN3zb/2cNACr05P3W35vJ9lxKTtrJOTQAC0RBuko5Y6lVgBP
         YlAUInhlfKdwUeBWRD9EcGaBfpP9grPvHyHgTu+/N6HsBDwfX8nebpOZsN1CpaSs3bDw
         yKoF/3riiJ0t7RfkhlvFABfL+xBVo/B9V6F97pvgOrvv3/w4nxJDiEK7nSJvIQ655juv
         YEFu9ROLxLkdBrjXsOlwO48TxyWVJPDfZNc/2pcR+es0i1LkBn08fGsvGaG/mDX87zOU
         Vz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6sWrXQHHpYIVbTe3LgGGbPvOLO7eHBs7BxZOAIktnkM=;
        b=qEjDTrgONQmXTPMUFFcYq+oQhY5uRdmoHAF5QXYu65dt93SQK0SsqQtrS7zKXngf/p
         RlYGx9eoC5CFcPp5mPo41atix9/s2F47gzt/qmsZorfWWpaNhsaxYKjUL6O369taKLQV
         snW8Kr2UWGhxU+ey2N26G8yoW2nKL3H/Fm6ZDmsRzuLLPQ1c1n+6WiisIqJXo7MBDh4p
         lA4iQ9xN9lIt6y1RqBF38X/LO1uDGavcSZiwZ0t0lK+38TV+Yvg9Zq7JU1lVMttbwHol
         6857elkUdaRitepr8ER7akLgXKEZ85EeGnXFxVJcwC+cBftp2qFi1VWBAcJ9lym//lVT
         0mtg==
X-Gm-Message-State: ALQs6tCK4GM9/QrFRUhV7ZWxGK7zU4YlYS3KmMfLkCpAMq8v5kmP7MzE
        lsdjfJ/zz4TEh1Lc+Xw/ZwQ=
X-Google-Smtp-Source: AB8JxZrfmdrTiL6oKyRp1HKyO4+jKsFkCdumqTF0q5y4ZQEDmUeVvp1+OvVliTZQ/l98Y9HjM+Q3zg==
X-Received: by 10.28.142.149 with SMTP id q143mr10478353wmd.161.1525216308028;
        Tue, 01 May 2018 16:11:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j76sm25151049wmf.33.2018.05.01.16.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 16:11:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Eckhard =?utf-8?Q?Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from init_diff_ui_defaults
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
        <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
        <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
        <20180501114316.GB13919@esm>
        <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
        <CABPp-BFbVP3iwAbaa2cEPw9Sr+ANJoHHYHOCQ4oAZoVdyX164A@mail.gmail.com>
Date:   Wed, 02 May 2018 08:11:45 +0900
In-Reply-To: <CABPp-BFbVP3iwAbaa2cEPw9Sr+ANJoHHYHOCQ4oAZoVdyX164A@mail.gmail.com>
        (Elijah Newren's message of "Tue, 1 May 2018 08:52:30 -0700")
Message-ID: <xmqqlgd3x972.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm not certain what the default should be, but I do believe that it
> should be consistent between these commands.  I lean towards
> considering break detection being on by default a good thing, but
> there are some interesting issues to address:
>   - there is no knob to adjust break detection for status, only for
> diff/log/show/etc.
>   - folks have a knob to turn break detection on (for diff/log/show),
> but not one to turn it off
>   - for status, break detection makes no sense if rename detection is off.
>   - for diff/log/show, break detection provides almost no value if
> rename detection is off (only a dissimilarity index), suggesting that
> if user turns rename detection off and doesn't explicitly ask for
> break detection, then it's a waste of time to have it be on
>   - merge-recursive would break horribly right now if someone turned
> break detection on for it.  Turning it on might be a good long term
> goal, but it's not an easy change.

Many of the issues in the above list are surmountable.  A new option
could be added to "status" to enable break or "diff" family to
disable it if we really wanted to.  A new "rewritten" state can be
added alongside with "modified" to "status" output.

A more serious issue around "-B" is this one:

    https://public-inbox.org/git/xmqqegqaahnh.fsf@gitster.dls.corp.google.com/

Even though the message is back from 2015 and asks users not to use
-B/-M together for anything critical "for now", the issue has not
been resolved and the same bug remains with us in the current code.

In the longer term, I suspect that it might make sense to have an
option to let users choose among "I do not want to have anything to
do with -B", "I always want -B when I ask for -M" and "I always want
-B whether I ask for -M".  But unfortunately the latter two with the
current codebase is an unacceptably risky/broken choice.

>
> So, where does that leave us?  My opinion is
>   - these commands should be consistent.  Eckhard's patch makes them so.
>   - we might want to move towards break detection being on as the
> default.  That's a couple patch series (one for everything but
> merge-recursive, and a separate much bigger series for
> merge-recursive).
>
> But I can see others saying we should leave things inconsistent until
> we can fix the other commands to use break detection as the default.
> So...thoughts?
>
> Elijah
