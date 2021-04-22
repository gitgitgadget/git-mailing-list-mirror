Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A57C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 03:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D08606A5
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 03:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDVDmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 23:42:17 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36756 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDVDmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 23:42:11 -0400
Received: by mail-ed1-f47.google.com with SMTP id j12so26696221edy.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 20:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgVrZYbS6s7jjtBNBfQH1oIxbmtYSMOREE/iopoudsE=;
        b=lWr5iYlmvo8uCtHSskdfVT8tLDM1SkibLEbMztYDXWGUkSILLCYLkl1h9ZuvhsAeRZ
         8U7ZJyjUAHW4za5jLRYfCONEcuD9dpcUSIz37qNxHotoGRVIcKDQQfuF2SsrwxlyEiel
         wxv/BrT/V+7eLKskqgk0XNHjlxeT1HaKVQgxgX7akm8erPii1llJ5L8O8tbuq84hwiPk
         rzvngXNmBWWsf0FuosmbOt8eZsWJ5TxsO6r9kNWX6faqTDvdfvLdetzxQzAUAHTtI3+/
         uoGQ/wxWb0NXo/10POCD289BD/HoYxnhI8ootlu4BJMV9m/42Cx3+wlHm1Xe2RXYNnYI
         NCaA==
X-Gm-Message-State: AOAM533Myuu+ssXJSFSnOQ65/r0SBcmM+yQzktb8E5lJVaCd11d4bHFL
        agtfEUS60hH8Er5tyrkUxKeBXvxYBU8xJsHgDi6F7AUzslULNA==
X-Google-Smtp-Source: ABdhPJxKWbw34hyQQfHWKedOdPmMyOhTKKQ/6KJE+Dx4xtcSiu0W/mD+cXxXy8jIgFv1HroaDa2uxn521nXopkzmug4=
X-Received: by 2002:a05:6402:488:: with SMTP id k8mr1189373edv.233.1619062886443;
 Wed, 21 Apr 2021 20:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com> <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
In-Reply-To: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Apr 2021 23:41:15 -0400
Message-ID: <CAPig+cTZRM1d07Nd0WBtWm5AO1mfh9M8jvYAXcoPm9cJ1MpDnA@mail.gmail.com>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
To:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Josh Soref <jsoref@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:55 PM Josh Soref via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Usually, it is easier to read a message if it makes its primary
> point first, before giving a parenthetical note.
> [...]
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>     Changes since v2:
>
>      * finish_up_to_date now figures out the answer on its own to address
>        feedback from Eric Sunshine
>
>     -- Yes, I'm well aware of localization rules. But as Eric Sunshine
>     noted, the code was already making a mess of things. I didn't want to
>     make invasive changes. I actually wrote roughly what Eric proposed as an
>     earlier implementation, but the various complexities, including trying
>     to figure out what the yeah was for and who cared about it, made me
>     really wary of proposing such a significant change.

Understandable. I also was curious as to whether "Yeeah!" had any
significance, thus checked the project history before responding to
your v2. As far as I can tell, "Yeeah!" has no particular
significance. It materialized out of thin air with 1c7b76be7d (Build
in merge, 2008-07-07) and simply hasn't been touched since then (in
any meaningful way). Delving into the list archive doesn't shed any
additional light on "Yeeah!"; none of the reviews mentioned it at all.
So, it doesn't seem to serve any genuine purpose, and I don't mind
seeing it go away, especially since its removal simplifies things for
translators.

> diff --git a/builtin/merge.c b/builtin/merge.c
> @@ -380,10 +380,14 @@ static void restore_state(const struct object_id *head,
>  /* This is called when no merge was necessary. */
> -static void finish_up_to_date(const char *msg)
> +static void finish_up_to_date(void)
>  {
> -       if (verbosity >= 0)
> -               printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
> +       if (verbosity >= 0) {
> +               if (squash)
> +                       puts(_("Already up to date (nothing to squash)."));
> +               else
> +                       puts(_("Already up to date."));
> +       }
>         remove_merge_branch_state(the_repository);
>  }
> @@ -1482,7 +1486,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> -               finish_up_to_date(_("Already up to date."));
> +               finish_up_to_date();
> @@ -1566,7 +1570,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> -                       finish_up_to_date(_("Already up to date. Yeeah!"));
> +                       finish_up_to_date();

Perhaps not surprisingly, I find this version of the patch much easier
to understand.

Thanks for re-rolling.
