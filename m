Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21B11F4B7
	for <e@80x24.org>; Thu, 29 Aug 2019 17:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfH2RZR (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 13:25:17 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41699 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH2RZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 13:25:16 -0400
Received: by mail-vk1-f194.google.com with SMTP id w20so953054vkd.8
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3mXP2FrZywbYhsZauxvFzLSxF6Hj6oTRXptl05HTrs=;
        b=RyB+SjPuY0SFR/WGieD3026ZdeFJtX5kAi0MkN+IGaS99JGgwN93vNnUdGu2I/SjdD
         oUWyMMqXtHw1NG9X6aaq/9BYGjzmrFCoaHunl3WD/StGujVEwtRsLXjJYW62G6Zp9Kqd
         K28PLqFIRf9fI+yizk+F6cVxUDPPQh2fie5H+5Ygxc86dLAjj7FdQfzuFU3GxtwkvE8z
         8M9NrwJwHot8a1fL0Oc/0zSDh08aizGry+EXpUDKrgO/iZK9LeoZEtoJo0AMg36TMoFx
         YFilnMjQhOEKn+dPO0gZNHTug8Ma6zAN3oxN2QXULrQgvYxEGYT8E+EV1KDaEvQTeckS
         eTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3mXP2FrZywbYhsZauxvFzLSxF6Hj6oTRXptl05HTrs=;
        b=iY4/oEPHj1Zl2EUjph3de5EleU+ovrPs1/lQeuIRlRwwllGTgFW4S37lUiEBOwb88L
         M9HiTwJ5EkEESMjXyj3bu30aXrtzRszy4ZiU1ngGMyL+YVl0pQjW/omUEeNmRadMzy+c
         MTUV7oXEamnNxhlmavPplFwQIiv15GejpPhx+TopkemWQOfXEwz8mNKUCRhBHXPNz5Ap
         79Y7lgc8I8TazbGc/LcSY2a4pV4TsnEnowal2wuFZGTxbfJrZfH0vx4s49nQipl21GQH
         KZ7ilWQMJyEhZIfLUOCfzyO3FteCAH/PzfPiiiQBnjYFD/Nvztc/gyvDQPAkE7frpBnQ
         w2vQ==
X-Gm-Message-State: APjAAAWrp98iVaps1nOoqHeZ2IeoP3AHFBlxFr35EAXoRoG3biqnnAB3
        d9EhR6duSwYdqeH9rIW2jY6RhsGrZoNt4lM3P8U=
X-Google-Smtp-Source: APXvYqwTti2eNzr0xQaoUtxHJWWhgDOiKjmunG2mEgrxR3H/83fzwcRcOrAxqI6qKzPe0374Uo1/TF9iQS1u0TgwLNw=
X-Received: by 2002:a1f:b9c6:: with SMTP id j189mr5748166vkf.1.1567099514888;
 Thu, 29 Aug 2019 10:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.325.git.gitgitgadget@gmail.com> <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
In-Reply-To: <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Aug 2019 10:25:03 -0700
Message-ID: <CABPp-BEgEOr8f7TeD-oqN6A0MtZMDoeuy4SLdCXn--unRwGHwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 10:04 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The 'git switch' command was created to separate half of the
> behavior of 'git checkout'. It specifically has the mode to
> do nothing with the index and working directory if the user
> only specifies to create a new branch and change HEAD to that
> branch. This is also the behavior most users expect from
> 'git checkout -b', but for historical reasons it also performs
> an index update by scanning the working directory. This can be
> slow for even moderately-sized repos.
>
> A performance fix for 'git checkout -b' was introduced by
> fa655d8411 (checkout: optimize "git checkout -b <new_branch>"
> 2018-08-16). That change includes details about the config
> setting checkout.optimizeNewBranch when the sparse-checkout
> feature is required. The way this change detected if this
> behavior change is safe was through the skip_merge_working_tree()
> method. This method was complex and needed to be updated
> as new options were introduced.
>
> This behavior was essentially reverted by 65f099b ("switch:
> no worktree status unless real branch switch happens"
> 2019-03-29). Instead, two members of the checkout_opts struct
> were used to distinguish between 'git checkout' and 'git switch':
>
>     * switch_branch_doing_nothing_is_ok
>     * only_merge_on_switching_branches
>
> These settings have opposite values depending on if we start
> in cmd_checkout or cmd_switch.
>
> The message for 64f099b includes "Users of big repos are
> encouraged to move to switch." Making this change while
> 'git switch' is still experimental is too aggressive.
>
> Create a happy medium between these two options by making
> 'git checkout -b <branch>' behave just like 'git switch',
> but only if we read exactly those arguments. This must
> be done in cmd_checkout to avoid the arguments being
> consumed by the option parsing logic.
>
> This differs from the previous change by fa644d8 in that
> the config option checkout.optimizeNewBranch remains
> deleted. This means that 'git checkout -b' will ignore
> the index merge even if we have a sparse-checkout file.
> While this is a behavior change for 'git checkout -b',
> it matches the behavior of 'git switch -c'.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/checkout.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6123f732a2..116200cf90 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1713,6 +1713,15 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         opts.overlay_mode = -1;
>         opts.checkout_index = -2;    /* default on */
>         opts.checkout_worktree = -2; /* default on */
> +
> +       if (argc == 3 && !strcmp(argv[1], "-b")) {
> +               /*
> +                * User ran 'git checkout -b <branch>' and expects
> +                * the same behavior as 'git switch -c <branch>'.
> +                */
> +               opts.switch_branch_doing_nothing_is_ok = 0;
> +               opts.only_merge_on_switching_branches = 1;
> +       }
>
>         options = parse_options_dup(checkout_options);
>         options = add_common_options(&opts, options);
> --
> gitgitgadget

Nice!  Thanks for doing this; a small and localized performance hack
is much nicer than a big and non-localized one.  I also appreciate the
detailed history in the commit message.

Just for fun, I tested on linux (with a relatively fast SSD) using a
simple git-bomb repo with 10M index entries but a sparse checkout of
just one file.  'git switch -c' takes approximately 0.004s before or
after this patch.  'git checkout -b' before this patch:

$ time git checkout -b newbranch1
Switched to a new branch 'newbranch1'

real    0m13.533s
user    0m9.824s
sys    0m2.828s


After this patch:

$ time git checkout -b newbranch2
Switched to a new branch 'newbranch2'

real    0m0.003s
user    0m0.000s
sys    0m0.000s


Anyway, looks good to me.
