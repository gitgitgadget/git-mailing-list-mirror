Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665151F404
	for <e@80x24.org>; Mon,  3 Sep 2018 04:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbeICIS1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 04:18:27 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34769 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeICIS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 04:18:27 -0400
Received: by mail-io0-f175.google.com with SMTP id c22-v6so14885096iob.1
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4R4D7qhpiKxQuNN7gtu+VvCTiOR2LcdFY5fa7lq/vrs=;
        b=a4Qmou7qV0dWLLWPk8n3YBw7IlxlPiZH2/8Qfmv0cqPIyXnALoOTmMmY40Z6zftfLB
         juryJSPoW5Adoa2sGNfz0TK9Oy+dRLxFTfd7Ze74z00vkMvyc2XzOSd3xuyR2RgCq1Ft
         UZwV6+YMYHZLWk3ZlHr0k700qRJfqFoix55yBG0WqAHtfwf85qmaTtyr7Ah+RPTX1f+g
         LPSmeuNcgzcomStYIroHZPZTULacNGjf8Bna46TuyR5Wds5F0Q5xkQ6fpKdKQ/02hQkk
         24x55UzE1GGSPBi4Cp9POeE5cwSKuG73MPnXVLZXfBiW4gFoBKcb0Y09xjWE+iv2dqXy
         JB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4R4D7qhpiKxQuNN7gtu+VvCTiOR2LcdFY5fa7lq/vrs=;
        b=KRJ77fYfBcD0DEawW+chcl5MXEIa2MfClDOXUWULY6+AN0A+jr2JUMuAPVvJvy6Mpy
         RxX+GQnrKQ4ySm04L3SmZmAP/VolGHIg7kBV1Xs204yvmCIcrGIgOseWgiq1+dNzOurE
         aVopoFDGl8KrYMKdmUJrXvLAjPIfQFtD1yyPIH5bGetIDEVXxO35w1uPi8ej9+f8KgHy
         T+S7lbL6hRvTcHJsqhMeFp/7WNCkmmp6VeTJ56yNkezMJYSTp36B/IM7GAdD/Sm0X/Vx
         k9ufUbBBgz9lRyvfCvQVWy7gjskkDR+q+hxhMwRM6S3gh8nzU1s67oBu+uTCiABQfpwQ
         /x8A==
X-Gm-Message-State: APzg51BRd6itd51Bv8o7emhZDytDLiH2A4Pxp9Jhu/RMelgp/jwAtfpC
        cuo1Cxm3GrYiBJHGtfNntW1+llJ67aF3JU0YKNlkP8kR
X-Google-Smtp-Source: ANB0VdbGNIflI1Tk29Fy5qp+XHxDrLLEyAxq2VF+EuXlWa8uu+EOOcLV0RQ82sTiVI1Kkj9rrPGuBmeKAcsYv2VeokY=
X-Received: by 2002:a5e:9615:: with SMTP id a21-v6mr17888390ioq.53.1535947209456;
 Sun, 02 Sep 2018 21:00:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 21:00:08 -0700 (PDT)
In-Reply-To: <CAEpdsiZSNe6e5JvGF4UHaf5+3zBq61uJAgQ5YDSr1v4er7inhQ@mail.gmail.com>
References: <CAEpdsiYHri8FJ8VohnwxmPwDM4-0J4J9Zb9wTZjYYRnYqsb=nA@mail.gmail.com>
 <87pnxzdib7.fsf@evledraar.gmail.com> <CAEpdsianZo+_+dunOvF=kK4w_qt_5RjA-o8+ySv70vRALZ3X2g@mail.gmail.com>
 <CAEpdsiZFMphQTdJnqFYH03M80W8CcrCbr2Uewktm0jy4D+Fz1A@mail.gmail.com>
 <874lfad537.fsf@evledraar.gmail.com> <CAEpdsiZSNe6e5JvGF4UHaf5+3zBq61uJAgQ5YDSr1v4er7inhQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 3 Sep 2018 06:00:08 +0200
Message-ID: <CAP8UFD0u2ZULWMDtWMwJCH27o=JLS3xiSmzvH+M4To0EWuX9Vg@mail.gmail.com>
Subject: Re: Feature request: hooks directory
To:     Wesley Schwengle <wesley@mintlab.nl>
Cc:     Git mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Wesley,

On Sun, Sep 2, 2018 at 11:38 PM, Wesley Schwengle <wesley@mintlab.nl> wrote:
> Hi all,
>
> I've made some progress with the hook.d implementation. It isn't
> finished, as it is my first C project I'm still somewhat rocky with
> how pointers and such work, but I'm getting somewhere. I haven't
> broken any tests \o/.

Great! Welcome to the Git community!

>  You have a nice testsuite btw. Feel free to comment on the code.
>
> I've moved some of the hooks-code found in run-command.c to hooks.c
>
> You can see the progress on gitlab: https://gitlab.com/waterkip/git
> or on github: https://github.com/waterkip/git
> The output of format-patch is down below.

It would be nicer if you could give links that let us see more
directly the commits you made, for example:
https://gitlab.com/waterkip/git/commits/multi-hooks

> I have some questions regarding the following two functions in run-command.c:
> * run_hook_le
> * run_hook_ve
>
> What do the postfixes le and ve mean?

It's about the arguments the function accepts, in a similar way to
exec*() functions, see `man execve` and `man execle`.
In short 'l' means list, 'v' means array of pointer to strings and 'e'
means environment.

> format-patch:
>
> From 129d8aff8257b22210beadc155cdbcae99b0fc4b Mon Sep 17 00:00:00 2001
> From: Wesley Schwengle <wesley@schwengle.net>
> Date: Sun, 2 Sep 2018 02:40:04 +0200
> Subject: [PATCH] WIP: Add hook.d support in git

This is not the best way to embed a patch in an email. There is
Documentation/SubmittingPatches in the code base, that should explain
better ways to send patches to the mailing list.

> Add a generic mechanism to find and execute one or multiple hooks found
> in $GIT_DIR/hooks/<hook> and/or $GIT_DIR/hooks/<hooks>.d/*
>
> The API is as follows:
>
> #include "hooks.h"
>
> array hooks   = find_hooks('pre-receive');
> int hooks_ran = run_hooks(hooks);
>
> The implemented behaviour is:
>
> * If we find a hooks/<hook>.d directory and the hooks.multiHook flag isn't
>   set we make use of that directory.
>
> * If we find a hooks/<hook>.d and we also have hooks/<hook> and the
>   hooks.multiHook isn't set or set to false we don't use the hook.d
>   directory. If the hook isn't set we issue a warning to the user
>   telling him/her that we support multiple hooks via the .d directory
>   structure
>
> * If the hooks.multiHook is set to true we use the hooks/<hook> and all
>   the entries found in hooks/<hook>.d
>
> * All the scripts are executed and fail on the first error

Maybe the above documentation should be fully embedded as comments in
"hooks.h" (or perhaps added to a new file in
"Documentation/technical/", though it looks like we prefer to embed
doc in header files these days).

> diff --git a/hooks.h b/hooks.h
> new file mode 100644
> index 000000000..278d63344
> --- /dev/null
> +++ b/hooks.h
> @@ -0,0 +1,35 @@
> +#ifndef HOOKS_H
> +#define HOOKS_H
> +
> +#ifndef NO_PTHREADS
> +#include <pthread.h>
> +#endif
> +/*
> + * Returns all the hooks found in either
> + * $GIT_DIR/hooks/$hook and/or $GIT_DIR/hooks/$hook.d/
> + *
> + * Note that this points to static storage that will be
> + * overwritten by further calls to find_hooks and run_hook_*.
> + */
> +//extern const struct string_list *find_hooks(const char *name);

The above comment is using "//" which we forbid and should probably be
removed anyway.

> +extern const char *find_hooks(const char *name);
> +
> +/* Unsure what this does/is/etc */
> +//LAST_ARG_MUST_BE_NULL

This is to make it easier for tools like compilers to check that a
function is used correctly. You should not remove such macros.

> +/*
> + * Run all the runnable hooks found in
> + * $GIT_DIR/hooks/$hook and/or $GIT_DIR/hooks/$hook.d/
> + *
> + */
> +//extern int run_hooks_le(const char *const *env, const char *name, ...);
> +//extern int run_hooks_ve(const char *const *env, const char *name,
> va_list args);

Strange that these functions are commented out.

> +#endif
> +
> +/* Workings of hooks
> + *
> + * array_of_hooks      = find_hooks(name);
> + * number_of_hooks_ran = run_hooks(array_of_hooks);
> + *
> + */

This kind of documentation should probably be at the beginning of the
file, see strbuf.h for example.

Thanks,
Christian.
