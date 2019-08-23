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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8A01F461
	for <e@80x24.org>; Fri, 23 Aug 2019 23:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfHWXuX (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 19:50:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33965 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHWXuX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 19:50:23 -0400
Received: by mail-vs1-f68.google.com with SMTP id b20so7389730vso.1
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RpLfBT5aznO6Hg5QuMSUBSNstezfTkcpMFZ25627oM=;
        b=Glvn4L5XYSmEb5L6koTeAJJll6wH7DDvazNdHpqdSQxwEW2nHrZ0fbzNeXqzLMspM0
         q91QfTLj41YTTXXc12Nl0KGCUUE8lA7d7SZiknJQOik1YHZ0DzrpywJ0SK4pGMQCFUbj
         8jHg3ICuvIB4/Jg/uMiop5HkhdB6RWvV1nrcQvzeBmDHUz5qVOiVGIwUzAHUi5yv/7av
         Vq8vcZ/6NysRwI82KoR70DEpH7sozBwy05zKkjVUZkswLBKDrQybhynH9kxa1Y4Tx/KG
         dGn2nle3URh7s0jr19uomFM7kXTXT8RnGYFJdFLb7xEsVNRbvfwp24lFyinpTpZxEFdq
         3Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RpLfBT5aznO6Hg5QuMSUBSNstezfTkcpMFZ25627oM=;
        b=r2R426lF3FrIrhOdO1GIwWiSyZMIvf5RILBWCQ7O7mP2DlUHkkefZeB99kFhWgjZno
         twFJMd7//0oyr+cSfCHeUxH6zQAXuiE/aMR/vfwNsDv8i6Aw6//JNt5AEo23a1z9tF8q
         D9uSBOD32zac+SpwRcwOrdDmVieDjLM4iDOmbWEkwCPA52wlNl7JgwEnKHzPshR/gTS5
         xiakWpYjyPvLZ6rPNzqcvI+gkGTL3HlbtgJua6Pus9Imntu3pTMmS/cuibYODUeogNkD
         VmOBZ+4FTMF2nYyvH2u7kfPT9SKjFnacFYGwqZV7MxnvI0WXEgqtVLc3Za9za4YyBTzV
         zvqA==
X-Gm-Message-State: APjAAAU9vwWs5HslHXGtfX4lstDSWtXd0NRTQEuIeI0tceiWl7H+DD5G
        xt0k757IugErZgegYyT6yaYHn+Q7rYCMjeRQ4Ps=
X-Google-Smtp-Source: APXvYqwxUTZg8HYEBtLZ2EZQ83+o6SRjQOro8lB0LdWzAvG/vL/aTmOr1ChAdRdFTrav2EsxVaweFXJ9AcOgAnSirf8=
X-Received: by 2002:a67:f887:: with SMTP id h7mr1882907vso.116.1566604221453;
 Fri, 23 Aug 2019 16:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <5f332b799f90b64e2c0720fd0aba0e163d41587a.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <5f332b799f90b64e2c0720fd0aba0e163d41587a.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 16:50:10 -0700
Message-ID: <CABPp-BHon=QgZXPjwyZspq0wW3rFLZqx1HZgE8eMq6DuTCc-0g@mail.gmail.com>
Subject: Re: [PATCH 5/9] sparse-checkout: create 'disable' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:14 AM Derrick Stolee via GitGitGadget
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
>  Documentation/git-sparse-checkout.txt | 26 +++++++---------
>  builtin/sparse-checkout.c             | 45 ++++++++++++++++++++++++---
>  t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++
>  3 files changed, 67 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 6f540a3443..de04b768ae 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -38,6 +38,10 @@ COMMANDS
>         Add a set of patterns to the sparse-checkout file, as given over
>         stdin. Updates the working directory to match the new patterns.
>
> +'disable'::
> +       Remove the sparse-checkout file, set `core.sparseCheckout` to
> +       `false`, and restore the working directory to include all files.
> +
>  SPARSE CHECKOUT
>  ----------------
>
> @@ -60,6 +64,13 @@ Then it compares the new skip-worktree value with the previous one. If
>  skip-worktree turns from set to unset, it will add the corresponding
>  file back. If it turns from unset to set, that file will be removed.
>
> +To repopulate the working directory with all files, use the
> +`git sparse-checkout disable` command.

Make sense.

> +
> +Sparse checkout support in 'git read-tree' and similar commands is
> +disabled by default. You need to set `core.sparseCheckout` to `true`
> +in order to have sparse checkout support.

But why add this paragraph?  read-tree is plumbing that we'd rather
not force on users, so I'd rather not mention it.  And I thought we
were setting core.sparseCheckout for the user.

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
> -
> -Then you can disable sparse checkout. Sparse checkout support in 'git
> -read-tree' and similar commands is disabled by default. You need to
> -set `core.sparseCheckout` to `true` in order to have sparse checkout
> -support.

Wahoo!


> -static int sc_enable_config(void)
> +static int sc_set_config(int mode)
>  {
>         struct argv_array argv = ARGV_ARRAY_INIT;
>         int result = 0;
> -       argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", "true", NULL);
> +       argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", NULL);

Remove "--add" and add "--worktree".

> +
> +       switch (mode) {
> +       case 1:
> +               argv_array_pushl(&argv, "true", NULL);
> +               break;
> +
> +       case 0:
> +               argv_array_pushl(&argv, "false", NULL);
> +               break;
> +
> +       default:
> +               die(_("invalid config mode"));
> +       }
>
>         if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {

Can't we use git_config_set instead of run_command_v_opt?

>                 error(_("failed to enable core.sparseCheckout"));
> @@ -125,7 +138,7 @@ static int sparse_checkout_init(int argc, const char **argv)
>         FILE *fp;
>         int res;
>
> -       if (sc_enable_config())
> +       if (sc_set_config(1))

Random idea: The code would be more self-documenting, if you just made
sc_set_config take a string and you passed either "true" or "false".
Then you could also dispense with the switch statement.  Yes, you can
make typos, but there are only going to be 2-3 places in the code that
call it, right?

>                 return 1;
>
>         memset(&el, 0, sizeof(el));
> @@ -194,6 +207,28 @@ static int sparse_checkout_add(int argc, const char **argv)
>         return sc_read_tree();
>  }
>
> +static int sparse_checkout_disable(int argc, const char **argv)
> +{
> +       char *sparse_filename;
> +       FILE *fp;
> +
> +       if (sc_set_config(1))
> +               die(_("failed to change config"));

Ooh, preventative setting.  This'll probably save some grief for
people who get themselves in a weird state and start mucking around
manually; very nice.

> +
> +       sparse_filename = get_sparse_checkout_filename();
> +       fp = fopen(sparse_filename, "w");
> +       fprintf(fp, "/*\n");
> +       fclose(fp);
> +
> +       if (sc_read_tree())
> +               die(_("error while refreshing working directory"));

This can fail e.g. if there are conflicts in the index.  Luckily, if
they fix them up and then re-run "git sparse-checkout disable" then it
can work.  But you've already changed the
$GIT_DIR/info/sparse-checkout file to a state that won't match what
they actually have checked out.  Will that cause any problems?  (I
can't think of any immediately, but I am curious.)

Also, should or can we give a better error message, such as
instructing them to try again after they've fixed any problems
reported by the sc_read_tree() operation?

> +
> +       unlink(sparse_filename);
> +       free(sparse_filename);
> +
> +       return sc_set_config(0);
> +}
> +
>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  {
>         static struct option builtin_sparse_checkout_options[] = {
> @@ -217,6 +252,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>                         return sparse_checkout_init(argc, argv);
>                 if (!strcmp(argv[0], "add"))
>                         return sparse_checkout_add(argc, argv);
> +               if (!strcmp(argv[0], "disable"))
> +                       return sparse_checkout_disable(argc, argv);
>         }
>
>         usage_with_options(builtin_sparse_checkout_usage,
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 499bd8d6d0..68ca63a6f6 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -120,4 +120,19 @@ test_expect_success 'add to existing sparse-checkout' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'sparse-checkout disable' '
> +       git -C repo sparse-checkout disable &&
> +       test_path_is_missing repo/.git/info/sparse-checkout &&
> +       git -C repo config --list >config &&

Should this command also have a --worktree flag (just for consistency,
even if we know there will only be one worktree so it doesn't matter
in practice)?  There are probably similar cases I overlooked on the
previous patches.

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
> \ No newline at end of file
> --
> gitgitgadget
>
