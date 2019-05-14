Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19311F4B7
	for <e@80x24.org>; Tue, 14 May 2019 13:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfENNUi (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 09:20:38 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53030 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 09:20:38 -0400
Received: by mail-it1-f194.google.com with SMTP id q65so4889316itg.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQS9eBwgFWETSJrN8o98igr9WE+Mtvl7/4FRYG1JucM=;
        b=bW7/nVSUsba/KL9O/Qsj27cSQ2wPR8hplKYIVwYh6Mr2LYbQx/T/x/hflthBtz0Z4H
         5jSo/WFfHgRy0Azg9/MQt+g1XMFuma0Khukt+P8O0VFqGTw81Lsa2CEo6Scce6wFUrTi
         zb+RxkaB8ZRJLxpNTVxOZt3d5X5wt2m1khWMPEZXhh7wO6Sgz5KfBrOqUL2BXNG+6hrY
         HNgD/UFjAIHABBDLh9oNxbRkyPBae+Y0rGrVTD/2cFzefLHM+u4x9rcLtC8F2mOyvtyH
         fG5qMR2+fbqc/1kLHGFidi+GMij3jsst1ad0dLfK7NEKOrKCnrTlfOYjmn9vNO+b7Wnh
         uNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQS9eBwgFWETSJrN8o98igr9WE+Mtvl7/4FRYG1JucM=;
        b=oYuYV+xXRozkSjepIFOVZlNK9fQypmT71alVm3seKqzAhMrlL4PVQ40KmQ2nx2BD19
         8JCQSEYbYk7mH3wVjEGWsNNUKnUeZoHKRiC4jTmdlMIKWc7BTwE1s5jnYtBOfEUuk/Gk
         N0cfUSyZsDqghQS8cQdSIEXVkUlArJsqj2ITemZ5tnp2O3jWXlyAzAEJyS0DJJQ/y19c
         WmeKXtnwG6Q6UP8MsvINDEZk8EFES8q/J7otSBShChF+QGnGxCegzgtvRPKf5ScS/1UA
         yJlnrWbkq5nP92YbcTxoGVqKHx6gcKj1FJADt8sBs4tEbVuKNwXgF1zOmUOcCU54dBvG
         eqIw==
X-Gm-Message-State: APjAAAVOxEjBWyZFLy5NROTGubqaSImF/Vfl+xc/cIbBkfN9p3tOD6EH
        gC1CJLXbZwvfV3aWVNfal3RZ/0mW251DPWowmgczI9v8
X-Google-Smtp-Source: APXvYqwogJ1G16jDSxsrpPxHfh6QFAnRIZxEhmepYfk/MDVN2jVu1oPBiD7LrF3Pe3dXRWhryfJLpjx2uoZ6fiFsDXc=
X-Received: by 2002:a05:660c:34e:: with SMTP id b14mr3052825itl.10.1557840036916;
 Tue, 14 May 2019 06:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190514002332.121089-1-sandals@crustytoothpaste.net> <20190514002332.121089-8-sandals@crustytoothpaste.net>
In-Reply-To: <20190514002332.121089-8-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 20:20:10 +0700
Message-ID: <CACsJy8BN32Jm62MQPLsRwKST8DDNZ7NxnJbsqBO3PJ0K2qU-Ng@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] config: allow configuration of multiple hook error behavior
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 7:24 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> There are a variety of situations in which a user may want an error
> behavior for multiple hooks other than the default. Add a config option,
> hook.<name>.errorBehavior to allow users to customize this behavior on a

An alternative name is onError, probably more often used for event
callbacks. But I don't know, maybe errorBehavior is actually better.

> per-hook basis. Provide options for the default behavior (exiting

should we fall back to hook.errorBehavior? That allows people to set
global policy, then customize just a small set of weird hooks.

> early), executing all hooks and succeeding if all hooks succeed, or
> executing all hooks and succeeding if any hook succeeds.
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  config.c       |  27 +++++++++++++
>  run-command.c  |  42 +++++++++++++++++---
>  run-command.h  |   5 +++
>  t/lib-hooks.sh | 106 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 173 insertions(+), 7 deletions(-)
>
> diff --git a/config.c b/config.c
> index c2846df3f1..9cba4061a9 100644
> --- a/config.c
> +++ b/config.c
> @@ -19,6 +19,7 @@
>  #include "utf8.h"
>  #include "dir.h"
>  #include "color.h"
> +#include "run-command.h"
>
>  struct config_source {
>         struct config_source *prev;
> @@ -1093,6 +1094,29 @@ int git_config_color(char *dest, const char *var, const char *value)
>         return 0;
>  }
>
> +static int git_default_hook_config(const char *key, const char *value)
> +{
> +       const char *hook;
> +       size_t key_len;
> +       uintptr_t behavior;
> +
> +       key += strlen("hook.");
> +       if (strip_suffix(key, ".errorbehavior", &key_len)) {
> +               hook = xmemdupz(key, key_len);
> +               if (!strcmp(value, "stop-on-first"))

maybe stop-on-first-error (or if you go with the "onError" name, I
think "stop" is enough). I know "stop on/after first hook" does not
really make any sense when you think about it. Maybe stop-on-first is
sufficient.

I was going to suggest strcasecmp. But core.whitespace (also has
multiple-word-values) already sets a precedent on strcmp. I think
we're good. Or mostly good, I don't know, we still accept False, false
and FALSE.

> +                       behavior = HOOK_ERROR_STOP_ON_FIRST;

This is basically the logical "and" behavior in a C expression. Which
makes me think if anybody's crazy enough to need the "or" counterpart
(i.e. run hooks, expect failure, keep going until the first success).

I guess it's a crazy mode. We should not care about until a real use
case shows up.

> +               else if (!strcmp(value, "report-any-error"))

I couldn't guess based on this name alone, whether we continue or stop
after the reporting part. The 7/7 document makes it clear though. So
all good.

> diff --git a/run-command.c b/run-command.c
> index 191d6f6f7e..70fb19a55b 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1308,6 +1308,8 @@ int async_with_fork(void)
>  #endif
>  }
>
> +struct string_list hook_error_behavior = STRING_LIST_INIT_NODUP;

Maybe stick this in 'struct repository'. I know most config variables
are still global. But I think we have to move/reorganize them at some
point. Most may end up in 'struct repository'.

> @@ -1401,18 +1403,48 @@ int for_each_hook(const char *name,
>                   void *data)
>  {
>         struct string_list paths = STRING_LIST_INIT_DUP;
> -       int i, ret = 0;
> +       int i, hret = 0;
> +       uintptr_t behavior = HOOK_ERROR_STOP_ON_FIRST;
> +       struct string_list_item *item;
> +       /* Use -2 as sentinel because failure to exec is -1. */
> +       int ret = -2;
> +
> +       item = string_list_lookup(&hook_error_behavior, name);
> +       if (item)
> +               behavior = (uintptr_t)item->util;
>
>         find_hooks(name, &paths);
>         for (i = 0; i < paths.nr; i++) {
>                 const char *p = paths.items[i].string;
>
> -               ret = handler(name, p, data);
> -               if (ret)
> -                       break;
> +               hret = handler(name, p, data);
> +               switch (behavior) {
> +                       case HOOK_ERROR_STOP_ON_FIRST:
> +                               if (hret) {
> +                                       ret = hret;
> +                                       goto out;
> +                               }
> +                               break;
> +                       case HOOK_ERROR_REPORT_ANY_SUCCESS:
> +                               if (ret == -2)
> +                                       ret = 1;
> +                               if (!hret)
> +                                       ret = 0;
> +                               break;
> +                       case HOOK_ERROR_REPORT_ANY_ERROR:
> +                               if (ret == -2)
> +                                       ret = 0;
> +                               if (hret)
> +                                       ret = hret;
> +                               break;
> +                       default:
> +                               BUG("unknown hook error behavior");

maybe BUG(".. behavior %d", behavior);

> +               }
>         }
> -
> +out:
>         string_list_clear(&paths, 0);
> +       if (ret == -2)
> +               return 0;
>         return ret;
>  }
>
-- 
Duy
