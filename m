Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E54C433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 22:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhLaWwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 17:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLaWwe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 17:52:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40382C061574
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 14:52:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x15so112894360edv.1
        for <git@vger.kernel.org>; Fri, 31 Dec 2021 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsOf6W8nVf9Ikvog23Dgu1odZK3+VM7n6hB0oyR71mU=;
        b=pwUgr1lJefLoRYT6X1RsWZ5l2lWpG3ehjJDv6Sb9NE+hKLU0kvhhClObHyE/V9cX9w
         2pzf71rOyqyajY4jB1L/W1HlC+7Vx6CtTzQUJCsHAXpFnLYUSVS9Hq0/hvtbztttHV2+
         DXdkW+PWku36m0SkVPvmbMjze9jAA5e7fiAnCMGrRPWaiGSRx6twd0qoLxbwCpQ6+t8n
         IonXS0zdTkYLgZzk57my7BzYRL9m+LxSS416Hey5QEy8/uGrgYVUQxKkSWK6615lMGu1
         lB3GliLsnUOQjHK41qa95LaTl6SruqyUWMQxzPWy2AcZ8RS1q2DG14YFl0wNTVVIJfB0
         435A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsOf6W8nVf9Ikvog23Dgu1odZK3+VM7n6hB0oyR71mU=;
        b=wAXnZQhvzct8qodsVebnl61HC2sANZtaXVAVftGVgs5tzkBXVfSOftuURDTinhsMvx
         47TjbFcO4uPX8tkGcaXQBzISb3faabKQ1jcUcwFsvFD9hnt3N7WV77gtQYycNH44dX8U
         UnYHtq5iQsabrNvdfcV7o0IyiW/bvju6Ca1Nx2fcU0WHHhD0/YGz+HEvaCtEm3NABA+f
         v6RtXxPx6q6btueVI5B1r6V3ixSHv02UJ3BHHZBxU+gwrW1bbZwIhUgwr0HCPMZWWU83
         z+qBsGmYoH9cH1p4vJm9dQnhjvamfvRKkCwQYngvJJRkvwgmcfyDyYfXGH0LYbpGNUqy
         XCrg==
X-Gm-Message-State: AOAM5316nbkAcx5PT0gr0M86IDmsI/s0yz5v+N1dcnWVVGSt1Vqxln7R
        BAlM3mm58eyPH9Zna97+4L2gVpaQ0YYshbrEJWCMvPX5rr+/oQ==
X-Google-Smtp-Source: ABdhPJyGHKYwPB9W015B6ZOdAAxv+xN4EvO7uFQEc30SZG+rHecAs438ohSJAN08Mz0Tmgt9i2AIRfs532cYzJ+m+co=
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr29461219ejc.100.1640991152445;
 Fri, 31 Dec 2021 14:52:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com> <cecf501e07645b7408dc75f276d477b9b712ab17.1640892413.git.gitgitgadget@gmail.com>
In-Reply-To: <cecf501e07645b7408dc75f276d477b9b712ab17.1640892413.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Dec 2021 14:52:20 -0800
Message-ID: <CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sparse-checkout: custom tab completion
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 2:33 AM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Fix custom tab completion for sparse-checkout command. This will ensure:
>
> 1. The full list of subcommands is provided when users enter git
> sparse-checkout <TAB>.
> 2. The --help option is tab-completable.
> 3. Subcommand options are tab-completable.
> 4. A list of directories (but not files) is provided when users enter git
> sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
>
> Failing tests that were added in the previous commit to verify these
> scenarios are now passing with these updates.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
>  t/t9902-completion.sh                  |  8 +++---
>  2 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c82ccaebcc7..7de997ee64e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2986,24 +2986,38 @@ _git_show_branch ()
>         __git_complete_revlist
>  }
>
> +__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
> +
>  _git_sparse_checkout ()
>  {
> -       local subcommands="list init set disable"
> +       local subcommands="list init set disable add reapply"
>         local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +
>         if [ -z "$subcommand" ]; then
> -               __gitcomp "$subcommands"
> -               return
> +               case "$cur" in
> +                       --*)
> +                               __gitcomp "--help"
> +                               ;;
> +                       *)
> +                               __gitcomp "$subcommands"
> +                               ;;
> +               esac
>         fi
>
> -       case "$subcommand,$cur" in
> -       init,--*)
> -               __gitcomp "--cone"
> -               ;;
> -       set,--*)
> -               __gitcomp "--stdin"
> -               ;;
> -       *)
> -               ;;
> +       case "$prev" in

Shouldn't this be "$subcommand" rather than "$prev"?  I think with
prev, it will only correctly complete the first path after "set",
"add", etc.

> +               set)
> +                       __gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
> +                       ;;
> +               add)
> +                       __gitcomp "--stdin"
> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"

I was going to make a simple suggestion for making it just complete
one additional level at a time and leaving out the -r, and then tried
it out and found out it wasn't simple.  I got something working,
eventually, but it's slightly ugly...so it probably belongs in a
separate patch anyway.  If you're curious, it's basically replacing
the second __gitcomp... call for each of set and add with
`__gitcomp_directories`, after first defining:

__gitcomp_directories ()
{
    local _tmp_dir _tmp_completions

    # Get the directory of the current token; this differs from dirname
    # in that it keeps up to the final trailing slash.  If no slash found
    # that's fine too.
    [[ "$cur" =~ .*/ ]]
    _tmp_dir=$BASH_REMATCH

    # Find possible directory completions, adding trailing '/' characters
    _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
        sed -e s%$%/%)"

    if [[ -n "$_tmp_completions" ]]; then
        # There were some directory completions, so find ones that
        # start with "$cur", the current token, and put those in COMPREPLY
        local i=0 c IFS=$' \t\n'
        for c in $_tmp_completions; do
            if [[ $c == "$cur"* ]]; then
                COMPREPLY+=("$c")
            fi
        done
    elif [[ "$cur" =~ /$ ]]; then
        # No possible further completions any deeper, so assume we're at
        # a leaf directory and just consider it complete
        __gitcomp_direct_append "$cur "
    fi
}

But I don't think that needs to be part of this series; I can submit
it later and hopefully get a completion expert to point out
better/cleaner ways of what I've done above.

> +                       ;;
> +               init|reapply)
> +                       __gitcomp "$__git_sparse_checkout_subcommand_opts"
> +                       ;;
> +               *)
> +                       ;;
>         esac
>  }
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 51d0f2d93a1..4dc93ee0595 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1447,7 +1447,7 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>         EOF
>  '
>
> -test_expect_failure 'sparse-checkout completes subcommands' '
> +test_expect_success 'sparse-checkout completes subcommands' '
>         test_completion "git sparse-checkout " <<-\EOF
>         list Z
>         init Z
> @@ -1458,13 +1458,13 @@ test_expect_failure 'sparse-checkout completes subcommands' '
>         EOF
>  '
>
> -test_expect_failure 'sparse-checkout completes options' '
> +test_expect_success 'sparse-checkout completes options' '
>         test_completion "git sparse-checkout --" <<-\EOF
>         --help Z
>         EOF
>  '
>
> -test_expect_failure 'sparse-checkout completes subcommand options' '
> +test_expect_success 'sparse-checkout completes subcommand options' '
>         test_completion "git sparse-checkout init --" <<-\EOF &&
>         --cone Z
>         --no-cone Z
> @@ -1492,7 +1492,7 @@ test_expect_failure 'sparse-checkout completes subcommand options' '
>         EOF
>  '
>
> -test_expect_failure 'sparse-checkout completes directory names' '
> +test_expect_success 'sparse-checkout completes directory names' '
>         # set up sparse-checkout repo
>         git init sparse-checkout &&
>         (
> --
> gitgitgadget

Patch looks good to me, other than the $prev vs. $subcommand thing.
