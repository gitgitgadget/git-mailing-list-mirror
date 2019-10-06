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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5AF1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 04:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfJFEKm (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 00:10:42 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39428 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfJFEKm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 00:10:42 -0400
Received: by mail-vs1-f67.google.com with SMTP id y129so6748250vsc.6
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 21:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EX+EtNtnwOt7hXZY35sItEV3fFWq5lf5bpTWGOyXpyw=;
        b=PsiMGHCkeaZum34XAK7E5Ixjse9v34eICHg/MRDcXZ6t2yefhwHDDEWBaj/JaZ+/5Z
         vHLpjeOu2iLvZNRg+sloKbi0FTeYQ0W164LOVUaoNvsqBDpgNuwajyB/DXcZyhOMZzZH
         k/hYndPWQOtuBrbDvzeKe+p+275UsIHDOWn5rIK6kSAMBi7DP3dFH7CkTASdiLDvaECZ
         lvqtVjZ/rZ+SjFMQsBD4rnLDEJlmfGKhqdTRsPjnKoauXW7gDPFQgbJYAs80ICgQ3zhs
         6QeT+t7qaDN+0NsuhweDMQIUS7ImNZizefQV1itsAdidMWUxhjCJhWQ7gbh/o3pCu6bK
         pYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX+EtNtnwOt7hXZY35sItEV3fFWq5lf5bpTWGOyXpyw=;
        b=lkMqP1sYVtkl5zWGpwcwYoMwJthQiE9pLuRtAemzSvFDXflvsXAGKbFpez8diH3VUP
         5RLHRVUF3zYaSWl0yikXFPGrac52zsVRHllKCVnJhdukN3c0U4gICMhJSPfNycZUk4cc
         aMEKYJs0g2DzkgdO/f1rFX4PmrAUW50SDKMMHRg2pIATZoh8nh73+LkVW5BuuyvI586o
         E1cdj2ccRmUSQHF5uuNJKANtrTd6Gu7cfU2Uor5AqztH4YxGupQP6CHvmYn2V2wfoHG/
         bE0e11fZ73BsMlDNTymD2PuVgfenCClpqZz5B1b8atnUiYFcRinMqYpYo4XV/58y5m1n
         XMXg==
X-Gm-Message-State: APjAAAVI0M5uLwPiVKKDlw86l3rQvlbqzqfqTLHqsPCV3T6oBPeXo/xE
        n47MH/N5VU+vtEhvwyNSmrGZa5Mme5yEodILPHI=
X-Google-Smtp-Source: APXvYqxtJRnNIziW1U2Bnd+ELe8gPV4DC/GMKpehxr4gC0yFhEYJ5ZMAd07p10+NNhIO5OvCRsuUgjrQTFACYy7k2YI=
X-Received: by 2002:a67:c11b:: with SMTP id d27mr12326163vsj.175.1570335040750;
 Sat, 05 Oct 2019 21:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <pull.316.v2.git.gitgitgadget@gmail.com>
 <b62b76013f98e57089c9b0c03209e28757977dd7.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <b62b76013f98e57089c9b0c03209e28757977dd7.1568904188.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 21:10:29 -0700
Message-ID: <CABPp-BHYCCD+Vx5fq35jH82eHc1-P53Lz_aGNpHJNcx9kg2K-A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] sparse-checkout: create 'disable' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 1:46 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The instructions for disabling a sparse-checkout to a full
> working directory are complicated and non-intuitive. Add a
> subcommand, 'git sparse-checkout disable', to perform those
> steps for the user.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt | 26 ++++++++-----------
>  builtin/sparse-checkout.c             | 37 ++++++++++++++++++++++++---
>  t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++++
>  3 files changed, 59 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 87813e5797..da95b28b1c 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -39,6 +39,10 @@ COMMANDS
>         a list of arguments following the 'set' subcommand. Update the
>         working directory to match the new patterns.
>
> +'disable'::
> +       Remove the sparse-checkout file, set `core.sparseCheckout` to
> +       `false`, and restore the working directory to include all files.

Good, so 'init' (and maybe 'set'?) will set core.sparseCheckout, and
disable will unset it, so the user doesn't have to worry about it...

> +
>  SPARSE CHECKOUT
>  ----------------
>
> @@ -61,6 +65,13 @@ Then it compares the new skip-worktree value with the previous one. If
>  skip-worktree turns from set to unset, it will add the corresponding
>  file back. If it turns from unset to set, that file will be removed.
>
> +To repopulate the working directory with all files, use the
> +`git sparse-checkout disable` command.

Good.

> +Sparse checkout support in 'git checkout' and similar commands is
> +disabled by default. You need to set `core.sparseCheckout` to `true`
> +in order to have sparse checkout support.

Aren't we having the user use 'git sparse-checkout init' to do that?
Why guide them to the core.sparseCheckout option?  And why mention it
without extensions.worktreeConfig?

> +
>  ## FULL PATTERN SET
>
>  By default, the sparse-checkout file uses the same syntax as `.gitignore`
> @@ -75,21 +86,6 @@ using negative patterns. For example, to remove the file `unwanted`:
>  !unwanted
>  ----------------
>
> -Another tricky thing is fully repopulating the working directory when you
> -no longer want sparse checkout. You cannot just disable "sparse
> -checkout" because skip-worktree bits are still in the index and your working
> -directory is still sparsely populated. You should re-populate the working
> -directory with the `$GIT_DIR/info/sparse-checkout` file content as
> -follows:
> -
> -----------------
> -/*
> -----------------

Yaay, glad to see this removed.

> -Then you can disable sparse checkout. Sparse checkout support in 'git
> -read-tree' and similar commands is disabled by default. You need to
> -set `core.sparseCheckout` to `true` in order to have sparse checkout
> -support.
>
>  SEE ALSO
>  --------
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index f726fcd6b8..f858f0b1b5 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -8,7 +8,7 @@
>  #include "strbuf.h"
>
>  static char const * const builtin_sparse_checkout_usage[] = {
> -       N_("git sparse-checkout [init|list|set] <options>"),
> +       N_("git sparse-checkout [init|list|set|disable] <options>"),
>         NULL
>  };
>
> @@ -74,7 +74,7 @@ static int update_working_directory(void)
>         return result;
>  }
>
> -static int sc_enable_config(void)
> +static int sc_set_config(int mode)

Nice to see this change from the RFC round; do we want to use an enum
instead of an int, or is the int good enough?  (No strong opinion
here, just asking.)

>  {
>         struct argv_array argv = ARGV_ARRAY_INIT;
>
> @@ -83,7 +83,12 @@ static int sc_enable_config(void)
>                 return 1;
>         }
>
> -       argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
> +       argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
> +
> +       if (mode)
> +               argv_array_pushl(&argv, "true", NULL);
> +       else
> +               argv_array_pushl(&argv, "false", NULL);
>
>         if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>                 error(_("failed to enable core.sparseCheckout"));
> @@ -101,7 +106,7 @@ static int sparse_checkout_init(int argc, const char **argv)
>         int res;
>         struct object_id oid;
>
> -       if (sc_enable_config())
> +       if (sc_set_config(1))
>                 return 1;
>
>         memset(&pl, 0, sizeof(pl));
> @@ -188,6 +193,28 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>         return write_patterns_and_update(&pl);
>  }
>
> +static int sparse_checkout_disable(int argc, const char **argv)
> +{
> +       char *sparse_filename;
> +       FILE *fp;
> +
> +       if (sc_set_config(1))
> +               die(_("failed to change config"));
> +
> +       sparse_filename = get_sparse_checkout_filename();
> +       fp = fopen(sparse_filename, "w");
> +       fprintf(fp, "/*\n");
> +       fclose(fp);
> +
> +       if (update_working_directory())
> +               die(_("error while refreshing working directory"));
> +
> +       unlink(sparse_filename);
> +       free(sparse_filename);
> +
> +       return sc_set_config(0);
> +}

So we update the .git/info/sparse-checkout file first (or the
worktree-specific equivalent), then call update_working_directory()
which can fail -- in particular if the user calls it when they have
any conflicted files.  But then the sparse-checkout file has already
been emptied, so it did make some changes, just not all the changes
the user would expect, leaving them in an intermediate state with an
error message that doesn't explain how to recover.  Would it be worth
checking for this case, and telling the user to fix up conflicts then
re-run the disable command?  Would it make more sense to just replace
the 'read-tree -mu HEAD' with something that doesn't error out in such
a case?  Or is this just a shortcoming of an experimental feature that
we'll get to later?  (I'm okay with the last of those, since we also
still need to address defaults of several other commands when sparse
checkouts are active[1].)

[1] https://public-inbox.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/

> +
>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  {
>         static struct option builtin_sparse_checkout_options[] = {
> @@ -212,6 +239,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>                         return sparse_checkout_init(argc, argv);
>                 if (!strcmp(argv[0], "set"))
>                         return sparse_checkout_set(argc, argv, prefix);
> +               if (!strcmp(argv[0], "disable"))
> +                       return sparse_checkout_disable(argc, argv);
>         }
>
>         usage_with_options(builtin_sparse_checkout_usage,
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 02ba9ec314..22fa032d6d 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -140,5 +140,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'sparse-checkout disable' '
> +       git -C repo sparse-checkout disable &&
> +       test_path_is_missing repo/.git/info/sparse-checkout &&
> +       git -C repo config --list >config &&
> +       test_i18ngrep "core.sparsecheckout=false" config &&
> +       ls repo >dir &&
> +       cat >expect <<-EOF &&
> +               a
> +               deep
> +               folder1
> +               folder2
> +       EOF
> +       test_cmp expect dir
> +'
> +
>  test_done

The rest of the patch looks good.
