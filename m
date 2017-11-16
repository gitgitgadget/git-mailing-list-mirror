Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B15E2036C
	for <e@80x24.org>; Thu, 16 Nov 2017 00:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933926AbdKPAiS (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 19:38:18 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:55833 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdKPAh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 19:37:59 -0500
Received: by mail-qt0-f174.google.com with SMTP id v41so38707007qtv.12
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 16:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IQ8OPXPdsSu+lDHy5sWbVhgtx0yzRczPrkHpRNZGSVc=;
        b=aQHsdXd0Bh+/vY0D0nRqpLwwf0cs8GvzxGE1VpMLjPbcu3y7gbPx2MOJsLQHoexVgR
         JNBf4D6LyPkre9Trmhzco+sI+P46vvqZ4QKj99wb3V4W+1+EqYxTEvRWnznl2ltJFthy
         IK+APZg2J8tOffZPSkBLWX5l2sWENFPcv/k2LyaC20PY8UXIlxWP9AV3h+wqhlutBqYr
         PNQeE5xZPpq9CJFJ8D3LybCmG0eOU60jo/ZA3wT2Af7b8mw1QkeMvSncNWGp5keNtAhM
         RGFeP0OOqyV6hMIA074eWsdrBmaVOdUW3KfFv0xNv1OvSkSu+6U3Iy1YQPz5abDJwkyB
         otlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IQ8OPXPdsSu+lDHy5sWbVhgtx0yzRczPrkHpRNZGSVc=;
        b=JB2+oa55+LKyecinAPTsCMrC3Pv/v2K7I2Il6wLN1t2MKD4oxQU0Ia1tAbjcPuq8QC
         4HxEjOTbim4ys2rVtiEvSGCuqXqd87nyl1pNCFNoxq60/UY/uquOEvIqW7nurwp13c6Q
         yUsLNmP1h+I3Pf16d2PVymad1aF1QO5K9okhngI70u3eSWzomhdpNsMZp7oN7hcD9ldx
         uBIsIqFWrxDS4bIpt4QgVpgdGDNumGSfHv1igeZafc4tqlgDXXbhb3kr07c/QUjEKJw9
         ZcAiudsX3U9482t8Um0hxvIV3qjMpblGNAnmwLpdxvcLB+Lmr2vWDnb0Ln1BaUfXxcMK
         B1dg==
X-Gm-Message-State: AJaThX4eSLyWnAHn6sU//m0kDpFez66GAaTosVr5tVHOgWsjTq0SXGxr
        Wa0+V338jt74dtoO0FfhgcI60rJq6EiIhGwn79r0HYvW
X-Google-Smtp-Source: AGs4zMZHp1zFhS5qP9tHVPkjAFZNZSNMavslEHuNZWNz3gGj3Vpgld4pknN1GVEEYkwD4iEugzIR6TM2HLAfO0rstOY=
X-Received: by 10.55.125.196 with SMTP id y187mr29438588qkc.180.1510792678246;
 Wed, 15 Nov 2017 16:37:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 16:37:57 -0800 (PST)
In-Reply-To: <xmqqpo8jxdto.fsf@gitster.mtv.corp.google.com>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
 <xmqq8tf7yxzn.fsf@gitster.mtv.corp.google.com> <CAGZ79kZbm8SGY4rXKZHV82E-HX9qbQ4iyCbMgJEBFQf4fj3u=Q@mail.gmail.com>
 <xmqqpo8jxdto.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 16:37:57 -0800
Message-ID: <CAGZ79kavG+gND_2oqMsB0HgZHbaCx2tRvB++8y7KvLc38mnUiQ@mail.gmail.com>
Subject: Re: [RFC] Indicate that Git waits for user input via editor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I wonder if we can do something like
>>>
>>>         git_spawn_editor()
>>>         {
>>>                 const char *EL = "\033[K"; /* Erase in Line */
>>>
>>>                 /* notice the lack of terminating LF */
>>>                 fprintf(stderr, "Launching your editor...");
>>
>> "It takes quite some time to launch this special Git Editor"
>>
>> As Lars pointed out, the editor may be launched in the background,
>> that the user would not know, but they might expect a thing to
>> pop up as a modal dialog as is always with UIs.
>>
>> So despite it being technically wrong at this point in time,
>> I would phrase it in past tense or in a way that indicates that the
>> user needs to take action already.
>>
>> The "Launching..." sounds as if I need to wait for an event to occur.
>
> Heh, I wasn't expecting phrasing nitpicks when I was trying to help
> the thread by trying to come up with a way to avoid vertical space
> wastage.

I know you weren't, but maybe it is helpful for the author of the patch
(I presume you may not be the author, after all).

But you are right, I should have started with a more fundamental
answer stating this is a good idea, and I cannot think of a negative
side effect currently.
