Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFC4C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 02:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3CA610CE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 02:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhJFCCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 22:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhJFCCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 22:02:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11E0C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 19:00:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p11so3640368edy.10
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4+sn9r5zjbQ9meyOwtHHDuOk6QZ/SW5QHRDQ/qyn2s=;
        b=ntnj9WarfpnYB7J+2Z0AbzvzRKOToWG1mpuzcenHIIG0kPn9QLdo7H6fd86UlVd86l
         cqK/WWmDk8jPtWP+0npdDjBMoH2Bk2SiRySABa5ngaQtj3tzoUwc73tehjHZJZEzT3aN
         rnZUQYF1T83/ZfLdm7bAnKYZ/xbygHaYpDh9bKFPIDO9n6O8O14aFL5J0aVwefObX3IQ
         M54gWFr9iwHIrJSGbVUpstQ+2dwuvUFyrYMTa5/tDEv4B1Z+zgVRGmzpz0g3qMw0CExp
         yJc3ohLwkfPbtC1ZXR835CuK+Fyiv/EdWxtJBz/Ir8RMzpjQKWQEvKLZfozFqCimJfXs
         tgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4+sn9r5zjbQ9meyOwtHHDuOk6QZ/SW5QHRDQ/qyn2s=;
        b=DrkZfhvn9lLVSkWjPAripNkJvbYjfUwotRX5hHHE7Ot39LeJDm92zFpZ7lPjogWitx
         eYGcDCw9eZx9zthPGukyFRGEMPIcta5sXx/zTYnMv6ZzDZSGZA262tVkhWQUwF/bf3Mf
         vA1PhPclcNJM4edOlqWF9UMzwuFshwYJXdXBMoAIG1mkb4E9FNyOR/LVxT8JNBnTzUf7
         4MneiqXqG3tQxAbjwnPMvPlYQ9tRSKtN8jzPiF34dBeucZxoWM6uBhkWc5KAdmJGxUwo
         ONElGkLHeUqTkSxRWJ8Lqm+u8AXn6/7D+40E2NxX83r1NYHlihMoILDbFKV0cYgBJZ7l
         YS8Q==
X-Gm-Message-State: AOAM531zMBN43SUrh3zuOCM0Lj+mYMZ7Qn3BUw5zzXqmKIF/lg4KsYrm
        8PRf5xLRfzpl1tAXSNtkev4h//nlXAgcjzWHtGT2+ptIWY0=
X-Google-Smtp-Source: ABdhPJxntWBr0n6QFphwuZR+MSahQcC2erSTLv/3GNt4/HKNooY328WLw/ut8ybl/UzJhWIgipqw1Y6tOHzowL9gMgk=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr29350052ejp.520.1633485627203;
 Tue, 05 Oct 2021 19:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com> <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 19:00:16 -0700
Message-ID: <CABPp-BHD3khX+q7crk4JnNbGd9fN-vJW0L1x=5JdzkFL6X1BBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] update-index: add --force-full-index option for
 expand/collapse test
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 5, 2021 at 6:20 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Add a new `--force-full-index` option to `git update-index`, which skips
> explicitly setting `command_requires_full_index`. This lets `git
> update-index --force-full-index` run as a command without sparse index
> compatibility implemented, even after it receives sparse index compatibility
> updates.
>
> By using `git update-index --force-full-index` in the `t1092` test
> `sparse-index is expanded and converted back`, commands can continue to
> integrate with the sparse index without the need to keep modifying the
> command used in the test.

So...we're adding a permanent user-facing command line flag, whose
purpose is just to help us with the transition work of implementing
sparse indexes everywhere?  Am I reading that right, or is that just
the reason for t1092 and there are more reasons for it elsewhere?

Also, I'm curious if update-index is the right place to add this.  If
you don't want a sparse index anymore, wouldn't a user want to run
   git sparse-checkout disable
?  Or is the point that you do want to keep the sparse checkout, but
you just don't want the index to also be sparse?  Still, even in that
case, it seems like adding a subcommand or flag to an existing
sparse-checkout subcommand would feel more natural, since
sparse-checkout is the command the user uses to request to get into a
sparse-checkout and sparse index.


> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  Documentation/git-update-index.txt       |  5 +++++
>  builtin/update-index.c                   | 11 +++++++++++
>  t/t1092-sparse-checkout-compatibility.sh |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 2853f168d97..06255e321a3 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -24,6 +24,7 @@ SYNOPSIS
>              [--[no-]fsmonitor]
>              [--really-refresh] [--unresolve] [--again | -g]
>              [--info-only] [--index-info]
> +            [--force-full-index]
>              [-z] [--stdin] [--index-version <n>]
>              [--verbose]
>              [--] [<file>...]
> @@ -170,6 +171,10 @@ time. Version 4 is relatively young (first released in 1.8.0 in
>  October 2012). Other Git implementations such as JGit and libgit2
>  may not support it yet.
>
> +--force-full-index::
> +       Force the command to operate on a full index, expanding a sparse
> +       index if necessary.
> +
>  -z::
>         Only meaningful with `--stdin` or `--index-info`; paths are
>         separated with NUL character instead of LF.
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 187203e8bb5..32ada3ead77 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -964,6 +964,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>         int split_index = -1;
>         int force_write = 0;
>         int fsmonitor = -1;
> +       int use_default_full_index = 0;
>         struct lock_file lock_file = LOCK_INIT;
>         struct parse_opt_ctx_t ctx;
>         strbuf_getline_fn getline_fn;
> @@ -1069,6 +1070,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                 {OPTION_SET_INT, 0, "no-fsmonitor-valid", &mark_fsmonitor_only, NULL,
>                         N_("clear fsmonitor valid bit"),
>                         PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
> +               OPT_SET_INT(0, "force-full-index", &use_default_full_index,
> +                       N_("run with full index explicitly required"), 1),
>                 OPT_END()
>         };
>
> @@ -1082,6 +1085,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>         if (newfd < 0)
>                 lock_error = errno;
>
> +       /*
> +        * If --force-full-index is set, the command should skip manually
> +        * setting `command_requires_full_index`.
> +        */
> +       prepare_repo_settings(r);
> +       if (!use_default_full_index)
> +               r->settings.command_requires_full_index = 1;
> +
>         entries = read_cache();
>         if (entries < 0)
>                 die("cache corrupted");
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index c5977152661..b3c0d3b98ee 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -642,7 +642,7 @@ test_expect_success 'sparse-index is expanded and converted back' '
>         init_repos &&
>
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -               git -C sparse-index -c core.fsmonitor="" reset --hard &&
> +               git -C sparse-index -c core.fsmonitor="" update-index --force-full-index &&
>         test_region index convert_to_sparse trace2.txt &&
>         test_region index ensure_full_index trace2.txt
>  '
> --
> gitgitgadget
