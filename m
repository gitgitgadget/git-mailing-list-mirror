Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07CC1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 08:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeICNJh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 09:09:37 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:45752 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeICNJh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 09:09:37 -0400
Received: by mail-oi0-f46.google.com with SMTP id t68-v6so32276150oie.12
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mintlab-nl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JI3Lgw1VTzT6u4m+g/6U5fVofnJLSVJqKVXWB9BRiUU=;
        b=j4EqCzVWdykbfZ1fHqHXCR7bJNwjoSsam3ht+UFU8QgC+60ulQoWAOhp4z8En29gKB
         bFcSguzwpB0qq7rdvIopetlUxTYU2v+gNTsenIwEXE5AHL0Ur28yFymmUWIFA9psvu6m
         RhMf3/38YY7PjHtwPXuG/GsKqB9SuBDCchV/mxvQ5IZkb15yhR7pf7RRvQbWXfh9v6HZ
         rHhwT3qkN5xrijxnlee3LlCWmfgU22w8Bw/AzZsQsfB/FhJb/2U9UK5VzVjWoBf35Bgs
         L/BUULqaaLPJXhUKsaBIR5ZeEwz9eqfoWjiIWz0DJYmfPPv83h+K1j/4DfovwpDcmfpn
         74tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JI3Lgw1VTzT6u4m+g/6U5fVofnJLSVJqKVXWB9BRiUU=;
        b=N8Ht2Dvp/V6lRqXTTee4i1qXUovLdgBbT90mA06xvB0Rm1oMlUI+ZGLnGya7ejCMWQ
         lNOyCTctgE/1iWM/yo+Yxnju23v1vwggCXNq4KWXsO1E++UKBTmhdMKDrV1WWMzv3gte
         RQ7AejhypL+q/6wRu5PrDA86sEvm5CxYOrzSx1zRcvJMZui6lNY98b2UNCCLx0hukdjl
         LM/Z/3u7ni+ZWXqOET7cM1vROgwTcoYlNvRZPX/Zf8UTGL48l6IRwVxjALlphxRmUumO
         PGkrRrta1osXaL6+s5fSuNc/VNcouZSszv7EZmvJK/hiI1QkBF7PtpD3xkldCWZ04val
         Pbzg==
X-Gm-Message-State: APzg51DVmFQMRsdbSWBhbgUwTKYvM+GHprKA8uc5JLr4FKxk0mlnePv0
        2tXlMwX5aiLnmEzhvlWA2c1LmbdCyjXoFllZYAGdUg==
X-Google-Smtp-Source: ANB0VdaYyl9mL/aYzvE0HS27lEyJrDUSK7hVuSfZqUY12cdIUCCe+3lmdoJd2+QZRNfU6z+bRQIVADOPYOwQNhrnByY=
X-Received: by 2002:aca:438a:: with SMTP id q132-v6mr19779445oia.331.1535964628325;
 Mon, 03 Sep 2018 01:50:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b149:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 01:50:27 -0700 (PDT)
In-Reply-To: <CAP8UFD0u2ZULWMDtWMwJCH27o=JLS3xiSmzvH+M4To0EWuX9Vg@mail.gmail.com>
References: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
 <87pnxzdib7.fsf@evledraar.gmail.com> <CAEpdsianZo+_+dunOvF=kK4w_qt_5RjA-o8+ySv70vRALZ3X2g@mail.gmail.com>
 <CAEpdsiZFMphQTdJnqFYH03M80W8CcrCbr2Uewktm0jy4D+Fz1A@mail.gmail.com>
 <874lfad537.fsf@evledraar.gmail.com> <CAEpdsiZSNe6e5JvGF4UHaf5+3zBq61uJAgQ5YDSr1v4er7inhQ@mail.gmail.com>
 <CAP8UFD0u2ZULWMDtWMwJCH27o=JLS3xiSmzvH+M4To0EWuX9Vg@mail.gmail.com>
From:   Wesley Schwengle <wesley@mintlab.nl>
Date:   Mon, 3 Sep 2018 10:50:27 +0200
Message-ID: <CAEpdsiaCMy1vd=x4W7rsFRN+Rj1vuMNLLA64OaF4GLqfjteuPg@mail.gmail.com>
Subject: Re: Feature request: hooks directory
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Christian,

2018-09-03 6:00 GMT+02:00 Christian Couder <christian.couder@gmail.com>:
> Hi Wesley,
>
> On Sun, Sep 2, 2018 at 11:38 PM, Wesley Schwengle <wesley@mintlab.nl> wrote:
>> Hi all,
>>
>> I've made some progress with the hook.d implementation. It isn't
>> finished, as it is my first C project I'm still somewhat rocky with
>> how pointers and such work, but I'm getting somewhere. I haven't
>> broken any tests \o/.
>
> Great! Welcome to the Git community!

Thank you!

>>  You have a nice testsuite btw. Feel free to comment on the code.
>>
>> I've moved some of the hooks-code found in run-command.c to hooks.c
>>
>> You can see the progress on gitlab: https://gitlab.com/waterkip/git
>> or on github: https://github.com/waterkip/git
>> The output of format-patch is down below.
>
> It would be nicer if you could give links that let us see more
> directly the commits you made, for example:
> https://gitlab.com/waterkip/git/commits/multi-hooks

Yeah.. sorry about that. Let's just say I was excited to send my
progress to the list.

>> I have some questions regarding the following two functions in run-command.c:
>> * run_hook_le
>> * run_hook_ve
>>
>> What do the postfixes le and ve mean?
>
> It's about the arguments the function accepts, in a similar way to
> exec*() functions, see `man execve` and `man execle`.
> In short 'l' means list, 'v' means array of pointer to strings and 'e'
> means environment.

Thanks, I'll have a look at these functions later today.

>> format-patch:
>>
>> From 129d8aff8257b22210beadc155cdbcae99b0fc4b Mon Sep 17 00:00:00 2001
>> From: Wesley Schwengle <wesley@schwengle.net>
>> Date: Sun, 2 Sep 2018 02:40:04 +0200
>> Subject: [PATCH] WIP: Add hook.d support in git
>
> This is not the best way to embed a patch in an email. There is
> Documentation/SubmittingPatches in the code base, that should explain
> better ways to send patches to the mailing list.

I saw that as well, after I've submitted the e-mail and was looking at
the travis documentation. I'll promise I'll do better for my next
patch submission. Sorry about this..

>> Add a generic mechanism to find and execute one or multiple hooks found
>> in $GIT_DIR/hooks/<hook> and/or $GIT_DIR/hooks/<hooks>.d/*
>>
>> [snip]
>>
>> * All the scripts are executed and fail on the first error
>
> Maybe the above documentation should be fully embedded as comments in
> "hooks.h" (or perhaps added to a new file in
> "Documentation/technical/", though it looks like we prefer to embed
> doc in header files these days).

I've added this to "hooks.h". If you guys want some documentation in
"Documentation/technical", I'm ok with adding a new file there as
well.

>> diff --git a/hooks.h b/hooks.h
>> new file mode 100644
>> index 000000000..278d63344
>> --- /dev/null
>> +++ b/hooks.h
>> @@ -0,0 +1,35 @@
>> +#ifndef HOOKS_H
>> +#define HOOKS_H
>> +
>> +#ifndef NO_PTHREADS
>> +#include <pthread.h>
>> +#endif
>> +/*
>> + * Returns all the hooks found in either
>> + * $GIT_DIR/hooks/$hook and/or $GIT_DIR/hooks/$hook.d/
>> + *
>> + * Note that this points to static storage that will be
>> + * overwritten by further calls to find_hooks and run_hook_*.
>> + */
>> +//extern const struct string_list *find_hooks(const char *name);
>
> The above comment is using "//" which we forbid and should probably be
> removed anyway.

Thanks, I have a "//" comment elsewhere, I'll change/remove it.

>> +extern const char *find_hooks(const char *name);
>> +
>> +/* Unsure what this does/is/etc */
>> +//LAST_ARG_MUST_BE_NULL
>
> This is to make it easier for tools like compilers to check that a
> function is used correctly. You should not remove such macros.

Check.

>> +/*
>> + * Run all the runnable hooks found in
>> + * $GIT_DIR/hooks/$hook and/or $GIT_DIR/hooks/$hook.d/
>> + *
>> + */
>> +//extern int run_hooks_le(const char *const *env, const char *name, ...);
>> +//extern int run_hooks_ve(const char *const *env, const char *name,
>> va_list args);
>
> Strange that these functions are commented out.

These two functions are still in "run-command.h" and I want to move
them to "hooks.h" and friends. But I first wanted to make sure
"find_hooks" worked as intended. This is still on my TODO for this
week.

>> +#endif
>> +
>> +/* Workings of hooks
>> + *
>> + * array_of_hooks      = find_hooks(name);
>> + * number_of_hooks_ran = run_hooks(array_of_hooks);
>> + *
>> + */
>
> This kind of documentation should probably be at the beginning of the
> file, see strbuf.h for example.

Since I added the better part of the commit message in "hooks.h" I
removed this bit.

An additional question:

In my patch I've added "hooks.multiHook", which I think I should
rename to "hooks.hooksd". It is wanted to change "core.hooksPath" to
the "hooks" namespace? Or should I rename my new config item to
"core.hooksd"?

Cheers,
Wesley

-- 
Wesley Schwengle, Developer
Mintlab B.V., https://www.zaaksysteem.nl
E: wesley@mintlab.nl
T:  +31 20 737 00 05
