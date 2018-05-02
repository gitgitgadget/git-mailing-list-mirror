Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82DA21847
	for <e@80x24.org>; Wed,  2 May 2018 00:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeEBAIb (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:08:31 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:39393 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeEBAI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 20:08:29 -0400
Received: by mail-vk0-f46.google.com with SMTP id g83-v6so7930311vkc.6
        for <git@vger.kernel.org>; Tue, 01 May 2018 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d6YVP+URG1JP12cyoAN89VwBR/MabD2He+ZsTYx9UA0=;
        b=e7vkHS3Ii1b4CPdX+j0zyl7qn2YrpVqSZc9tg6SIm0HxU2YQhtPcFZ/SBZS+lfhgFS
         0l6fzuGb+h/QsY5LKM39DMGt50RPziM9nmipYIwZNsuVf0CUno9Lm1h8BLYZVpnx96um
         viPGBmaTCy3R6Xl70/HnTmmqO88lIQbfsPgXqoi5h93swwcbwRFAwgIoUXJZyd90TxwA
         A+Jf5OTuWj0c7UcmYbYXdBbCuVB1asRhbbMZkWo88Mcq5w8Lhj17gfqjXPGNclptBr2Y
         gdd3ltqmxo6FkDSyc61vFZwogJHltdrqFBna0pUA3gx1cCUNoHEkNmmR1oZkTajb4vJV
         3s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d6YVP+URG1JP12cyoAN89VwBR/MabD2He+ZsTYx9UA0=;
        b=HrvfVLjxus5sl2aZVYDx9LpKos9DBVOTc3ZQ5XNcH6izwPFOtUQO8UaDsira+BwQ6Z
         +5qjGpghv0SgA9AHMkhcNxDmqY15HtEc8tgzxakxX6XI7//id5/VgiSB3vwWln8DtcFc
         h8CRPIG59wXQd2YuonY1m4+Zw3CGmdZZkZk+oOa+rAOoYHuVmxkUJ2HMoeXFqoAo8be9
         SunyA8T3symvHr05MIalu8Ef8jtlDCjBZR5I75xkjLM7BCZs6Kwdlx6hCX5JOFJMC/iI
         2tgR45VtQNHOveh+WZsgJ1nK33xPPRrI0cyQ7EXYyx3GLS6z8OVcHVErUkwuqmn0qejO
         maBg==
X-Gm-Message-State: ALQs6tCq6XVG63KIN5bt+wup7FNnPLRj6eo5mG2NdGzxJVIHVSS2FfYM
        y1UAj7gHM4WAIJwKF+W+Ch4Djd2xvpl753YHSJD2Yw==
X-Google-Smtp-Source: AB8JxZrDKfQYS8wjh9oBR9vq/VU0XMjivcB9ReLIqgpZtjZmCDmp/yNRldWeGmafBBbgoINQx02FkI0vCZSGHujB7lo=
X-Received: by 2002:a1f:370a:: with SMTP id e10-v6mr15835497vka.106.1525219708053;
 Tue, 01 May 2018 17:08:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Tue, 1 May 2018 17:08:27 -0700 (PDT)
In-Reply-To: <xmqqlgd3x972.fsf@gitster-ct.c.googlers.com>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
 <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
 <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
 <20180501114316.GB13919@esm> <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
 <CABPp-BFbVP3iwAbaa2cEPw9Sr+ANJoHHYHOCQ4oAZoVdyX164A@mail.gmail.com> <xmqqlgd3x972.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 May 2018 17:08:27 -0700
Message-ID: <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from init_diff_ui_defaults
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> I'm not certain what the default should be, but I do believe that it
>> should be consistent between these commands.  I lean towards
>> considering break detection being on by default a good thing, but
>> there are some interesting issues to address:
>>   - there is no knob to adjust break detection for status, only for
>> diff/log/show/etc.
>>   - folks have a knob to turn break detection on (for diff/log/show),
>> but not one to turn it off
>>   - for status, break detection makes no sense if rename detection is off.
>>   - for diff/log/show, break detection provides almost no value if
>> rename detection is off (only a dissimilarity index), suggesting that
>> if user turns rename detection off and doesn't explicitly ask for
>> break detection, then it's a waste of time to have it be on
>>   - merge-recursive would break horribly right now if someone turned
>> break detection on for it.  Turning it on might be a good long term
>> goal, but it's not an easy change.
>
> Many of the issues in the above list are surmountable.  A new option
> could be added to "status" to enable break or "diff" family to
> disable it if we really wanted to.  A new "rewritten" state can be
> added alongside with "modified" to "status" output.
>
> A more serious issue around "-B" is this one:
>
>     https://public-inbox.org/git/xmqqegqaahnh.fsf@gitster.dls.corp.google.com/
>
> Even though the message is back from 2015 and asks users not to use
> -B/-M together for anything critical "for now", the issue has not
> been resolved and the same bug remains with us in the current code.
>
> In the longer term, I suspect that it might make sense to have an
> option to let users choose among "I do not want to have anything to
> do with -B", "I always want -B when I ask for -M" and "I always want
> -B whether I ask for -M".  But unfortunately the latter two with the
> current codebase is an unacceptably risky/broken choice.

Very interesting; I didn't know that break detection and rename
detection were unsafe to use together.

I also just realized that in addition to status being inconsistent
with diff/log/show, it was also inconsistent with itself -- it handles
staged and unstaged changes differently.
(wt_status_collect_changes_worktree() had different settings for break
detection than wt_status_collect_changes_index().)

Eckhard, can you add some comments to your commit message mentioning
the email pointed to by Junio about break detection and rename
detection being unsafe to use together, as well as the inconsistencies
in break detection between different commands?  That may help future
readers understand why break detection was turned off for
wt_status_collect_changes_index().
