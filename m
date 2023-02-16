Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED2AC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 03:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBPDWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPDWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 22:22:13 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582961B54D
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 19:22:12 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-15ff0a1f735so1169553fac.5
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 19:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wuu+FEdKinG7KTFZSpG7t0+Oe6kstcgvJgglpNJYhh4=;
        b=bSpOyDwCV01VpRnv9fK8QYaiRRUuxZHNuuHc3vBLZP5qWC6HVJVMG3/huU5GCrdg48
         N9vsrIeu1QqIgzDYSVSR29AxvEuhTNMzcO5dD5JUS71ynMmubLzqijOpiAdTORJk0uoo
         6k8ibVklIXSKtzkQLsOSrFNzO+8zHj95J/GyScm4FMjlj3ZUnRbCIkPrG5AEKo7UrFpx
         GTqlrIYlMwW/87ptmjUv8Gv+1qAMHHpaR02cMbKNtEouot5dT7G599Pd4w5dgx1ElrRr
         Decv2kHlgDCTqn8D8ABirTCDnttJwsiXIe/Zub8iRuD/S4plWlIju/olcrrLOZfqF2nV
         6p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wuu+FEdKinG7KTFZSpG7t0+Oe6kstcgvJgglpNJYhh4=;
        b=HsgwGzHLJjdYNPnHY64kXk4+TKpgCI5j0rbunAK+eGc0vCVfZwGOcWQnb0RzIioVCG
         DpF3lHgT/wdKHLIhPwbd34l4uR1BKvbe7wzBncUt20OfS1/IYs0RClSNl+WH8d75UJqD
         wMpZT13TK50kc5eNGSQ1j2dnHP+iVkB17WJ6oB9ySTHuVI8Rtfx3MsuC1jhqm38bONmQ
         OwF8aaUAERAxeurBGx3XDTFv4PvrcfA60HcTtBZ4pec1jxXIjtiO+67wbpYs4jDp/ZzC
         Cse0byeHe3O9Fbcz3/kS/BwxAuntmevi1BiiAHl63IP5gW5jC3IyF5e2je+Ho+/OwDgK
         W+iA==
X-Gm-Message-State: AO0yUKWeDmSJU8NAHxW7918Joix7RJ1NuyezZh4695yFJ8jYTMXK2/Qs
        UrosahdzYJy5AtXytYy6ts0lEJFQ7DDtbwqx6L08kve1hXk=
X-Google-Smtp-Source: AK7set/FT/yKPlX9YcZFe3Xxfk3ln2eMiSQNp85XflG5nAPuEQ+sg4oRZgx3H8lOozngIEJmclYeSdnuY4iGbfSeyV0=
X-Received: by 2002:a05:6870:5d06:b0:16e:4b62:df20 with SMTP id
 fv6-20020a0568705d0600b0016e4b62df20mr52663oab.141.1676517731578; Wed, 15 Feb
 2023 19:22:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
In-Reply-To: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 15 Feb 2023 20:22:00 -0700
Message-ID: <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 5, 2023 at 9:41 AM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Tao Klerks <tao@klerks.biz>
>
> When "git pull" is called without a conflict-handling instruction or
> configuration, it displays a hint proposing "pull.rebase" and "pull.ff"
> config options for future handling.
>
> The hint offers three permanent settings, "merge", rebase", and "ff". The
> proposed command for "rebase" is "git config pull.rebase true".
>
> Unfortunately, this rebase configuration can easily lead to non-expert users
> accidentally rebasing not their own commits, instead others' commits, if the
> new commits they have locally before the "pull" include a merge of another
> branch, eg "main".
>
> Since 2018 in git version "2.18", it has supported a new rebase flag
> "--rebase-merges", with corresponding pull.rebase config option "merges".
> This new option is ideal for rebasing local work on "pull", as it will
> not "mangle"/flatten any local merge commits but rather recreate them.
>
> Change the pull conflict hint text to propose "pull.rebase merges" instead
> of "pull.rebase true", and "git pull --rebase=merges" instead of
> "git pull --rebase".
>
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>     pull: conflict hint pull.rebase suggestion should offer "merges" vs
>     "true"
>
>     Hint change as proposed in
>     https://lore.kernel.org/git/xmqqa61uo3q0.fsf@gitster.g/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1474%2FTaoK%2Ftao-fetch-rebase-hint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1474/TaoK/tao-fetch-rebase-hint-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1474
>
>  builtin/pull.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1ab4de0005d..535364fbb07 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -967,13 +967,13 @@ static void show_advice_pull_non_ff(void)
>                  "your next pull:\n"
>                  "\n"
>                  "  git config pull.rebase false  # merge\n"
> -                "  git config pull.rebase true   # rebase\n"
> +                "  git config pull.rebase merges # rebase\n"
>                  "  git config pull.ff only       # fast-forward only\n"
>                  "\n"
>                  "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -                "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -                "or --ff-only on the command line to override the configured default per\n"
> -                "invocation.\n"));
> +                "preference for all repositories. You can also pass --rebase=merges,\n"
> +                "--no-rebase, or --ff-only on the command line to override the configured\n"
> +                "default per invocation.\n"));

Hi Tao, thank you for sharing your experiences with non-experts using
`git pull`. I am always curious to see how people who are learning Git
react to it, and I am very interested in making Git as straightforward
as possible.

I'm afraid I have several objections to this patch...

- The proposed wording is likely to further confuse novices. It's
asking the user to choose between the reconciliation strategies of
merging and rebasing, but then says to use the unintuitive combination
"rebase=merges" which sounds like it's going to make a merge commit at
the end of the branch anyway.

- The proposed wording makes it sound like there's something wrong
with doing a regular rebase, but that's not usually the case because
in practice a regular rebase is almost always equivalent to
rebase=merges. A regular rebase may even be what the user really
wants: For example, the user might choose to merge when pulling and
then change their mind and decide that they really wanted to rebase.
Repeating the pull with the regular -r or --rebase flag fixes the
mistake.

- `git pull -ri` (or its longer form `git pull --rebase=interactive`)
is generally more useful than `git pull --rebase=merges`, but once
rebase=merges has been specified, there's no way to specify
rebase=interactive also. Recommending rebase=merges steers people away
from rebase=interactive, hiding useful functionality from the user.

Now, this is not to say that there's no room for improvement. I like
the rebase=merges option and I wish everyone knew about it because
there are situations where it really is the best option. I suggest
leaving the existing text alone, but adding an additional paragraph,
something like:

Note that --rebase or pull.rebase=true will drop existing merge
commits and rebase all of the commits from all of the merged branches.
If you want to rebase but preserve existing merge commits, use
--rebase=merges or pull.rebase=merges instead.

-Alex
