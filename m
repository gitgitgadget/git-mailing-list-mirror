Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B29420372
	for <e@80x24.org>; Fri,  6 Oct 2017 21:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdJFV4G (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 17:56:06 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37174 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdJFV4F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 17:56:05 -0400
Received: by mail-qk0-f194.google.com with SMTP id a12so10065373qka.4
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OGSuW8lxiGjz4UztEUXdAMOa6P0PBuQiwDELuKLJP8M=;
        b=egbaRA/chwWFxjiADdLzL/rUXRfMvNiImquKspRc6pNDa2VNf4qxwa4STFbeHwWXld
         Eav2Vbs3I9Q4oZ10khjRfcyvhrzhZtHbe3E44ebTlWB+3BpVTI1K40xxB5Z9V3VN//Ql
         g3Q41g7p5gkDMaL/VeWcgTibay/SY8MtH0apj2s4sn2bTcgYeZ9Qiznj7TrnJhfjzY9e
         iBESiOtViaj3QhV03Mwh3pTrHiIz7VBDo+4mkr5BMs9qLkjcTPWALtIt810Dns/dVzhE
         prD6+BdDYrGDI27rt/rAqXPx6sI+myE8nZDh3rfXDEeqcW9/2uDxQOlg/1BeihWXRtCp
         KSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OGSuW8lxiGjz4UztEUXdAMOa6P0PBuQiwDELuKLJP8M=;
        b=h/xBcl+Ci8boA08rJ0fUcXCl6KiKalqdFyCWUrRLxcIh0cfXZyHLGV25ZjP8IQGOde
         ni4UzD9we8YPu936xWq7YDaQkYpFkIQVavS51aQzGLgHz+MVmgjGyndMWkar2zWPMxsA
         3qEnn9JyiEc/OVnPpxaf8SlfT7P3IL7uiHiXOR+Hu4tjzyJYmitNUJqIiq/0SmD7gHWu
         AkvVGagTIJRUY6d6sDhAgJFmmU40SpJ+LPo4wl9Gmi1Yn7wpXI88Z0nf8W+P3woIP+aE
         yH4MnJVrUVzXr7XzcFn6h9t76DpePyROS2oE/h69mXp8rywN4JKhNY9368mxJXrJSRvY
         aMQw==
X-Gm-Message-State: AMCzsaVExtWmoNHCkl1hm4Q8nMwMs1GvfLKQDHdAD6hD3kFSuLcHTnmo
        AdemckdLm8gV6jvBlR3dqzIFSMWuPpv8rHo/OTHLRQ==
X-Google-Smtp-Source: AOwi7QB4fqHzdwHv7LbIvJEM27nT3//7AmmnuO/gBUP/j4tg3vk5/m0hILBjKNAXYn9PT6GVRgyg4xVe7b1LeacLBDY=
X-Received: by 10.55.151.196 with SMTP id z187mr325026qkd.135.1507326964753;
 Fri, 06 Oct 2017 14:56:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Fri, 6 Oct 2017 14:56:04 -0700 (PDT)
In-Reply-To: <20171006132415.2876-3-pc44800@gmail.com>
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com> <20171006132415.2876-1-pc44800@gmail.com>
 <20171006132415.2876-3-pc44800@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Oct 2017 17:56:04 -0400
X-Google-Sender-Auth: oD1AvdhSCD2TijY8l2rA1gxkfZ8
Message-ID: <CAPig+cT31XM9nW7sytukbQQ_O_15np6oepazKJaoNuHey+kiBA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] submodule--helper: introduce for_each_listed_submodule()
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, hanwen@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Same disclaimer as in my review of patch 1/3: I didn't see a URL in
the cover letter pointing at discussions of earlier iterations, so
below comments may be at odds with what went on previously...

On Fri, Oct 6, 2017 at 9:24 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Introduce function for_each_listed_submodule() and replace a loop
> in module_init() with a call to it.
>
> The new function will also be used in other parts of the
> system in later patches.
>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -14,6 +14,11 @@
>  #include "refs.h"
>  #include "connect.h"
>
> +#define OPT_QUIET (1 << 0)
> +
> +typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
> +                                 void *cb_data);

What is the reason for having the definition of 'each_submodule_fn' so
far removed textually from its first reference by
for_each_listed_submodule() below?

>  static char *get_default_remote(void)
>  {
>         char *dest = NULL, *ret;
> @@ -348,7 +353,23 @@ static int module_list(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> -static void init_submodule(const char *path, const char *prefix, int quiet)
> +static void for_each_listed_submodule(const struct module_list *list,
> +                                     each_submodule_fn fn, void *cb_data)
> +{
> +       int i;
> +       for (i = 0; i < list->nr; i++)
> +               fn(list->entries[i], cb_data);
> +}

I'm very curious about the justification for introducing a for-each
function for what amounts to the simplest sort of loop possible: a
canonical for-loop with a one-line body. I could easily understand the
desire for such a function if either the loop conditions or the body
of the loop, or both, were complex, but this does not seem to be the
case. Even the callers of this new function, in this patch and in 3/3,
are as simple as possible: one-liners (simple function calls).

Although this sort of for-each function can, at times, be helpful,
there are costs: extra boilerplate and increased complexity for
clients since it requires callback functions and (optionally) callback
data. The separation of logic into a callback function can make code
more difficult to reason about than when it is simply the body of a
for-loop.

So, unless the plan for the future is that this for-each function will
have considerable additional functionality baked into it, I'm having a
difficult time understanding why this change is desirable.

> +struct init_cb {
> +       const char *prefix;
> +       unsigned int flags;
> +};
> +
> +#define INIT_CB_INIT { NULL, 0 }

Why are these definitions so far removed from init_submodule_cb() below?

> +static void init_submodule(const char *path, const char *prefix,
> +                          unsigned int flags)
>  {
>         const struct submodule *sub;
>         struct strbuf sb = STRBUF_INIT;
> @@ -410,7 +431,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>                 if (git_config_set_gently(sb.buf, url))
>                         die(_("Failed to register url for submodule path '%s'"),
>                             displaypath);
> -               if (!quiet)
> +               if (!(flags & OPT_QUIET))

This change of having init_submodule() accept a 'flags' argument,
rather than a single boolean, increases reviewer burden, since the
reviewer is forced to puzzle out how this change relates to the stated
intention of the patch since it is not mentioned at all by the commit
message.

It's also conceptually unrelated to the introduction of a for-each
function, thus should be instead be done by a separate preparatory
patch.

>                         fprintf(stderr,
>                                 _("Submodule '%s' (%s) registered for path '%s'\n"),
>                                 sub->name, url, displaypath);
> @@ -437,12 +458,18 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>         free(upd);
>  }
>
> +static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
> +{
> +       struct init_cb *info = cb_data;
> +       init_submodule(list_item->name, info->prefix, info->flags);
> +}
> +
>  static int module_init(int argc, const char **argv, const char *prefix)
>  {
> +       struct init_cb info = INIT_CB_INIT;
>         struct pathspec pathspec;
>         struct module_list list = MODULE_LIST_INIT;
>         int quiet = 0;
> -       int i;
>
>         struct option module_init_options[] = {
>                 OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
> @@ -467,8 +494,11 @@ static int module_init(int argc, const char **argv, const char *prefix)
>         if (!argc && git_config_get_value_multi("submodule.active"))
>                 module_list_active(&list);
>
> -       for (i = 0; i < list.nr; i++)
> -               init_submodule(list.entries[i]->name, prefix, quiet);
> +       info.prefix = prefix;
> +       if (quiet)
> +               info.flags |= OPT_QUIET;
> +
> +       for_each_listed_submodule(&list, init_submodule_cb, &info);
>
>         return 0;
>  }
> --
> 2.14.2
