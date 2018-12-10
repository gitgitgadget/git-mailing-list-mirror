Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C0120A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeLJQnC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:43:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40410 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeLJQnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:43:02 -0500
Received: by mail-io1-f68.google.com with SMTP id n9so9248911ioh.7
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7UB1F+QUERmloCaNlmQ8/B/D6BkU264urrr7YnoYNI=;
        b=pr5wfe3cc9gfW+tWa6H49M5BpIyBBNG+4dwR86KRzzLZcN4WyGDsWhs9wvgJQgYEgu
         piDmeg2hRWaZ1Jles8ZpR3+Vd07ZTYqPNIbkFICrsxr9/spOTNos1EdNIULeiWOADDzI
         /sjm7rwspDJVpmyKRW65ECK1PXdMrYmdrUhyMV4vWDX59quhesG+n8jjrCHmY1KBzT2X
         UM35rZmRrxEEh8byQVMshJmS41y8vyKXBzZYeKcE+cqHaiLA+3YBokmbsGR0Qu1XO3xG
         6dGB0TSDIzH+/UgNf0wACSy6cQsWZBvDVSB2tJZWUxTia6wYQahWOcaMM3L8E0JMxFzY
         rxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7UB1F+QUERmloCaNlmQ8/B/D6BkU264urrr7YnoYNI=;
        b=Cc7Xv0Rs2BnDKZ6Efxx1FjLIZNvpiM1n9w6D/82175mnyhYAPiX6EENrVByI1HCCTY
         anxMqsuD01BzDJe5tPiVlnfZs2fXTyGWYC/9keQiqtVWXwJURvt0mSZirkPxdOVRvaS/
         B1N0qJUPyqG3Wqgn1WmJ/fbjpFFfTZUTH9EmI6/c/LQNmaBTgLSBMT5kF3P9wDphOUaW
         bRUPy2ui3kD5joKFvTjaSmsJ4XbgCArR6w6fb+YaL+dSbXvei2YErjHctlbf7iJ0rLyq
         myWy8cDTZ9Zm2jJ40ShovTkAyNq3UXZc8qeMeRzitqsramqw/8muuLnOA7ctW6L8AbuI
         YiPw==
X-Gm-Message-State: AA+aEWZBKEyA7lYn45/a3RLe8qW2yLHKNfMC85jqZlkn8FRrSF13S5ZM
        tq/GyreKmdb3rXdsWkOk28RMIruXTuseSsEO/JQ=
X-Google-Smtp-Source: AFSGD/XIpISfH9f+yH0lgn/Wke1ZQe2pmhLfMh+JKlQz9b8WHpKu4Awc8Kl3bGwi5WC8V/EjVwNu5U2qII0EFgBj5/c=
X-Received: by 2002:a6b:242:: with SMTP id 63mr10441223ioc.118.1544460181163;
 Mon, 10 Dec 2018 08:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-6-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-6-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 17:42:34 +0100
Message-ID: <CACsJy8BWZyFWZ70y4beCEYvjbc2+X-2K+gOiY+=toK0y3xYzKw@mail.gmail.com>
Subject: Re: [PATCH 5/8] checkout: introduce --{,no-}overlay option
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -302,15 +310,29 @@ static int checkout_paths(const struct checkout_opts *opts,
>                 ce->ce_flags &= ~CE_MATCHED;
>                 if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
>                         continue;
> -               if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
> -                       /*
> -                        * "git checkout tree-ish -- path", but this entry
> -                        * is in the original index; it will not be checked
> -                        * out to the working tree and it does not matter
> -                        * if pathspec matched this entry.  We will not do
> -                        * anything to this entry at all.
> -                        */
> -                       continue;
> +               if (opts->source_tree && !(ce->ce_flags & CE_UPDATE)) {
> +                       if (!opts->overlay_mode &&
> +                           ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
> +                               /*
> +                                * "git checkout --no-overlay <tree-ish> -- path",
> +                                * and the path is not in tree-ish, but is in
> +                                * the current index, which means that it should
> +                                * be removed.
> +                                */
> +                               ce->ce_flags |= CE_MATCHED | CE_REMOVE | CE_WT_REMOVE;
> +                               continue;
> +                       } else {

In non-overlay mode but when pathspec does not match, we come here too.

> +                               /*
> +                                * "git checkout tree-ish -- path", but this
> +                                * entry is in the original index; it will not

I think the missing key point in this comment block is "..is in the
original index _and it's not in tree-ish_". In non-overlay mode, if
pathspec does not match then it's safe to ignore too. But this logic
starts too get to complex and hurt my brain.

> +                                * be checked out to the working tree and it
> +                                * does not matter if pathspec matched this
> +                                * entry.  We will not do anything to this entry
> +                                * at all.
> +                                */
> +                               continue;
> +                       }
> +               }
>                 /*
>                  * Either this entry came from the tree-ish we are
>                  * checking the paths out of, or we are checking out

> @@ -1266,6 +1299,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>                             "checkout", "control recursive updating of submodules",
>                             PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
>                 OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
> +               OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),

maybe add " (default)" to the help string.

>                 OPT_END(),
>         };
>
-- 
Duy
