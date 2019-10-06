Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738641F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 04:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfJFEWp (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 00:22:45 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41144 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfJFEWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 00:22:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so6732283vsr.8
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 21:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7jjD/Ysu+PgiBOlpCosEoZopCF1ZKMKCB+7FUdYl0E=;
        b=tK0w1+8gFYF7t1hc5ziv5qiht6vlJZ26h3gpizIvqFfnMXDnGb8Na+f/QxyG2mxfBv
         aQPU46YR2sXhfoLoS1BQz3MV8LaIa7PuUtg3Fc0WO63ejVbopnjMazhuF9Aa2+SiKOC7
         kh9wKtbjf/0J8FyCAZ4boKHmVywEpEI+uba5yy6/cuUGkFqidy0WMTAhK2PSUMdQ5vpg
         0sCBuqvQ/6C52ApBjByiYfWrhsIsZ/UbLhpKO5sUJdE7BYOY5NKUCFw/By7mwKrjXCbS
         39NiYrWsZ8HqYXBlBJDW1TsUiRg0ZE4wHzj7WXYYSd2uazBamESMu/iSW2sr7JTmCJFm
         SGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7jjD/Ysu+PgiBOlpCosEoZopCF1ZKMKCB+7FUdYl0E=;
        b=BduXUeo17EUlZ51zttGw7Syh9/BRD9tyA3DIXaxP0INqhRZ7GqkfNpNI2QheyDRs4v
         QU7SnVkk11jiBJcKCVRXu/+RWpqJI+teABzQJJV+ZyJmyWB2BNkkWayVRCqSy40CmJFH
         17HYjHo0qTCuZN2AOfLPbILJ+JidmUPIIAhIYhDRo4QjQuycJDrc/myVxwpXwLRJeFc5
         J+y84ukNx3WoJrOVQPbIiZl8oMTVuZSBTTYmCRoGSKSbfcwU6u+PxWnsP5j9x6wjkunY
         SC/N+FzJ2F/g5GRmDfMDuMrSCDGamdwwppwuv5iVLERAWlnf16Wu1EQGHAdWHKEsbHcs
         2Weg==
X-Gm-Message-State: APjAAAUGb2rDa1oLO4oeXsIi0ne7TboG3MGAti767P6Zxn0ukaWojbbd
        uSzi3rkhMQktaibEwSeES2sj3CVPQ7RVqwfjESofGcy1
X-Google-Smtp-Source: APXvYqxAWh+Kd6kJv7KuTAh9P+c/QCyQj2weytmj3684vwjcUfmgWIQdiQvxGU347dFOlFG0PGZTqhVaS3Ta3FGZnbo=
X-Received: by 2002:a67:f502:: with SMTP id u2mr11959266vsn.117.1570335763675;
 Sat, 05 Oct 2019 21:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <84511255d1f28e1bdcec3de6096d2d9ac2a9f483.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <84511255d1f28e1bdcec3de6096d2d9ac2a9f483.1568904188.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 21:22:32 -0700
Message-ID: <CABPp-BE9HrMyskiMhQ7VxeMvZX_CCurUM_20M6md2UXZG13XEA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] sparse-checkout: add 'cone' mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 1:45 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse-checkout feature can have quadratic performance as
> the number of patterns and number of entries in the index grow.
> If there are 1,000 patterns and 1,000,000 entries, this time can
> be very significant.
>
> Create a new Boolean config option, core.sparseCheckoutCone, to
> indicate that we expect the sparse-checkout file to contain a
> more limited set of patterns. This is a separate config setting
> from core.sparseCheckout to avoid breaking older clients by
> introcuding a tri-state option.

s/introcuding/introducing/

> The config option does nothing right now, but will be expanded
> upon in a later commit.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/core.txt         |  7 ++--
>  Documentation/git-sparse-checkout.txt | 50 +++++++++++++++++++++++++++
>  cache.h                               |  4 ++-
>  config.c                              |  5 +++
>  environment.c                         |  1 +
>  t/t1091-sparse-checkout-builtin.sh    | 14 ++++++++
>  6 files changed, 78 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 75538d27e7..9b8ab2a6d4 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -591,8 +591,11 @@ core.multiPackIndex::
>         multi-pack-index design document].
>
>  core.sparseCheckout::
> -       Enable "sparse checkout" feature. See section "Sparse checkout" in
> -       linkgit:git-read-tree[1] for more information.
> +       Enable "sparse checkout" feature. If "false", then sparse-checkout
> +       is disabled. If "true", then sparse-checkout is enabled with the full
> +       .gitignore pattern set. If "cone", then sparse-checkout is enabled with
> +       a restricted pattern set. See linkgit:git-sparse-checkout[1] for more
> +       information.

This isn't consistent with the commit message that suggests it's a new
option rather than a new possible value for an old option.

>  core.abbrev::
>         Set the length object names are abbreviated to.  If
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index da95b28b1c..757326618d 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -87,6 +87,56 @@ using negative patterns. For example, to remove the file `unwanted`:
>  ----------------
>
>
> +## CONE PATTERN SET
> +
> +The full pattern set allows for arbitrary pattern matches and complicated
> +inclusion/exclusion rules. These can result in O(N*M) pattern matches when
> +updating the index, where N is the number of patterns and M is the number
> +of paths in the index. To combat this performance issue, a more restricted
> +pattern set is allowed when `core.spareCheckoutCone` is enabled.
> +
> +The accepted patterns in the cone pattern set are:
> +
> +1. *Recursive:* All paths inside a directory are included.
> +
> +2. *Parent:* All files immediately inside a directory are included.
> +
> +In addition to the above two patterns, we also expect that all files in the
> +root directory are included. If a recursive pattern is added, then all
> +leading directories are added as parent patterns.
> +
> +By default, when running `git sparse-checkout init`, the root directory is
> +added as a parent pattern. At this point, the sparse-checkout file contains
> +the following patterns:
> +
> +```
> +/*
> +!/*/
> +```
> +
> +This says "include everything in root, but nothing two levels below root."
> +If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
> +`A/B` are added as parent patterns. The resulting sparse-checkout file is
> +now
> +
> +```
> +/*
> +!/*/
> +/A/
> +!/A/*/
> +/A/B/
> +!/A/B/*/
> +/A/B/C/
> +```
> +
> +Here, order matters, so the negative patterns are overridden by the positive
> +patterns that appear lower in the file.
> +
> +If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
> +expecting patterns of these types. Git will warn if the patterns do not match.
> +If the patterns do match the expected format, then Git will use faster hash-
> +based algorithms to compute inclusion in the sparse-checkout.
> +
>  SEE ALSO
>  --------
>
> diff --git a/cache.h b/cache.h
> index cf5d70c196..8e8ea67efa 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -911,12 +911,14 @@ extern char *git_replace_ref_base;
>
>  extern int fsync_object_files;
>  extern int core_preload_index;
> -extern int core_apply_sparse_checkout;
>  extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;
>  extern const char *core_fsmonitor;
>
> +int core_apply_sparse_checkout;
> +int core_sparse_checkout_cone;
> +
>  /*
>   * Include broken refs in all ref iterations, which will
>   * generally choke dangerous operations rather than letting
> diff --git a/config.c b/config.c
> index 296a6d9cc4..f65c74f5b7 100644
> --- a/config.c
> +++ b/config.c
> @@ -1329,6 +1329,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>                 return 0;
>         }
>
> +       if (!strcmp(var, "core.sparsecheckoutcone")) {
> +               core_sparse_checkout_cone = git_config_bool(var, value);
> +               return 0;
> +       }
> +
>         if (!strcmp(var, "core.precomposeunicode")) {
>                 precomposed_unicode = git_config_bool(var, value);
>                 return 0;
> diff --git a/environment.c b/environment.c
> index 89af47cb85..670d92bcc0 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -69,6 +69,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>  char *notes_ref_name;
>  int grafts_replace_parents = 1;
>  int core_apply_sparse_checkout;
> +int core_sparse_checkout_cone;
>  int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 22fa032d6d..9b089c98c4 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -140,6 +140,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'cone mode: match patterns' '
> +       git -C repo config --worktree core.sparseCheckoutCone true &&
> +       rm -rf repo/a repo/folder1 repo/folder2 &&
> +       git -C repo read-tree -mu HEAD &&
> +       git -C repo reset --hard &&
> +       ls repo >dir  &&
> +       cat >expect <<-EOF &&
> +               a
> +               folder1
> +               folder2
> +       EOF
> +       test_cmp expect dir
> +'
> +
>  test_expect_success 'sparse-checkout disable' '
>         git -C repo sparse-checkout disable &&
>         test_path_is_missing repo/.git/info/sparse-checkout &&
> --
> gitgitgadget

What if core.sparseCheckoutCone is true but core.sparseCheckout is
false?  Is that an error case we warn the user about, or do we make
sense of it somehow?
