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
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B601F461
	for <e@80x24.org>; Fri, 23 Aug 2019 23:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHWXRU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 19:17:20 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42519 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfHWXRU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 19:17:20 -0400
Received: by mail-ua1-f67.google.com with SMTP id n13so3811593uap.9
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHPV1SnaYSEaImB8bYDoek8zQe6NEYxZYGZTPiL9/YY=;
        b=h0C5yzSNG7D6Ll+kpDGE8O1aQgVVyvDY6IKFDY5ORYXe+FhSQVoYt10jhHLkJKUmFC
         8hYPmIsCg6dHopAfnkYaeJe8pho+Rz5WgMe3HzBg31Bo/RsXbiB1KgjYaXubRuksOVRR
         xQ6ytOvnKTPPuOahCEjdVZyKkJMKYN/CI1NEzlLUJevyp9JGUc/wP6lk0Rg/fNj064GC
         jCy/BGKORtd563XpZ86qCOHukP4qPlHNX0dzmTrhx8fuhzUkUxs0f8X6OS1Bfe504zBd
         lEu2yhQ+o95UOJ/jYbBhq/KbYlqh4YvlQBFc0nJ+cqSF6A3GxLEFnqsuSmYCgPcxduJg
         tmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHPV1SnaYSEaImB8bYDoek8zQe6NEYxZYGZTPiL9/YY=;
        b=bLrDskhbDgVsVPWsfsq+1ptDIzbTEYGtLNhULDsCI1cuC0LBvBWU3tlTlZPt1rOO5a
         s+k9wLXJzfrplYcHwoWiVvNcRcwtlsd9BqR9Va1HEpxCR5g0wbYXGg7S1PTwZsLcYiJh
         /8YQXlEQANQA/lca8mEGoHOPuqYxfInqwv2ISBMduGjV13Wiz0Cv2r/4YBeRGp0+bhH4
         bZ7aT4FEXwG01js+whTI5EmqkxYWZocK0+jqR1XT2JClV1GM8ewEY2p3o+qmc+H3sYvg
         wLgRGytgRaOkoCDNRKX/WXbBuOm+RUUmlcuURmlo+/3d+jxzkvgfTs8jUUTikM0NhRiH
         Pnxg==
X-Gm-Message-State: APjAAAXKcrpFwAc/Dh3R1cU2qWMxWP8A9gOPJWqQ0evE7RA6II41BD2h
        RowUSZVQlU83kHfcdKXuRZMNbqBE6k/S2KtjVSs=
X-Google-Smtp-Source: APXvYqzsDOT8VeITJf74Sxr6jKpAC0H5/BUEVy5UnQQGBYwlC7kLeqjTgL9mah8vePZz73YAVcMATQV3PihzlZP77A4=
X-Received: by 2002:ab0:20d8:: with SMTP id z24mr3674342ual.1.1566602239040;
 Fri, 23 Aug 2019 16:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <4ccd36b3966b62934cfbb0ec65e2851b50dfa1e3.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <4ccd36b3966b62934cfbb0ec65e2851b50dfa1e3.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 16:17:06 -0700
Message-ID: <CABPp-BGyDwgTRx3A4OPJT=5rMM-onkPtg9m58M=rDMHiJQxQ6Q@mail.gmail.com>
Subject: Re: [PATCH 3/9] clone: add --sparse mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When someone wants to clone a large repository, but plans to work
> using a sparse-checkout file, they either need to do a full
> checkout first and then reduce the patterns they included, or
> clone with --no-checkout, set up their patterns, and then run
> a checkout manually. This requires knowing a lot about the repo
> shape and how sparse-checkout works.
>
> Add a new '--sparse' option to 'git clone' that initializes the
> sparse-checkout file to include the following patterns:
>
>         /*
>         !/*/*
>
> These patterns include every file in the root directory, but
> no directories. This allows a repo to include files like a
> README or a bootstrapping script to grow enlistments from that
> point.

Nice.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-clone.txt        |  8 +++++++-
>  builtin/clone.c                    | 27 +++++++++++++++++++++++++++
>  t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 34011c2940..0fe91d2f04 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -15,7 +15,7 @@ SYNOPSIS
>           [--dissociate] [--separate-git-dir <git dir>]
>           [--depth <depth>] [--[no-]single-branch] [--no-tags]
>           [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
> -         [--[no-]remote-submodules] [--jobs <n>] [--] <repository>
> +         [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
>           [<directory>]
>
>  DESCRIPTION
> @@ -156,6 +156,12 @@ objects from the source repository into a pack in the cloned repository.
>         used, neither remote-tracking branches nor the related
>         configuration variables are created.
>
> +--sparse::
> +       Initialize the sparse-checkout file so the working
> +       directory starts with only the files in the root
> +       of the repository. The sparse-checkout file can be
> +       modified to grow the working directory as needed.
> +
>  --mirror::
>         Set up a mirror of the source repository.  This implies `--bare`.
>         Compared to `--bare`, `--mirror` not only maps local branches of the
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f665b28ccc..d6d49a73ff 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -60,6 +60,7 @@ static const char *real_git_dir;
>  static char *option_upload_pack = "git-upload-pack";
>  static int option_verbosity;
>  static int option_progress = -1;
> +static int option_sparse_checkout;
>  static enum transport_family family;
>  static struct string_list option_config = STRING_LIST_INIT_NODUP;
>  static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
> @@ -147,6 +148,8 @@ static struct option builtin_clone_options[] = {
>         OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>         OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
>                     N_("any cloned submodules will use their remote-tracking branch")),
> +       OPT_BOOL(0, "sparse", &option_sparse_checkout,
> +                   N_("initialize sparse-checkout file to include only files at root")),
>         OPT_END()
>  };
>
> @@ -734,6 +737,27 @@ static void update_head(const struct ref *our, const struct ref *remote,
>         }
>  }
>
> +static int git_sparse_checkout_init(const char *repo)
> +{
> +       struct argv_array argv = ARGV_ARRAY_INIT;
> +       int result = 0;
> +       argv_array_pushl(&argv, "-C", repo, "sparse-checkout", "init", NULL);
> +
> +       /*
> +        * We must apply the setting in the current process
> +        * for the later checkout to use the sparse-checkout file.
> +        */
> +       core_apply_sparse_checkout = 1;
> +
> +       if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +               error(_("failed to initialize sparse-checkout"));
> +               result = 1;
> +       }

Sigh...so much forking of additional processes.  I'd really rather
that we were reducing how much of this we are doing in the codebase
instead of adding more.  Every fork makes following stuff in a
debugger harder.

> +
> +       argv_array_clear(&argv);
> +       return result;
> +}
> +
>  static int checkout(int submodule_progress)
>  {
>         struct object_id oid;
> @@ -1107,6 +1131,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>         if (option_required_reference.nr || option_optional_reference.nr)
>                 setup_reference();
>
> +       if (option_sparse_checkout && git_sparse_checkout_init(repo))
> +               return 1;
> +
>         remote = remote_get(option_origin);
>
>         strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 35ab84aabd..b7d5f15830 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -87,4 +87,17 @@ test_expect_success 'init with existing sparse-checkout' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'clone --sparse' '
> +       git clone --sparse repo clone &&
> +       git -C clone sparse-checkout list >actual &&
> +       cat >expect <<-EOF &&
> +               /*
> +               !/*/*
> +       EOF
> +       test_cmp expect actual &&
> +       ls clone >dir &&
> +       echo a >expect &&
> +       test_cmp expect dir

Checking that a toplevel entry is present, but not checking that an
entry from a subdir is missing as expected?
