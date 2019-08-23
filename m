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
	by dcvr.yhbt.net (Postfix) with ESMTP id A33631F461
	for <e@80x24.org>; Fri, 23 Aug 2019 23:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHWXDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 19:03:10 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35837 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfHWXDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 19:03:10 -0400
Received: by mail-vs1-f66.google.com with SMTP id q16so7313828vsm.2
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kir25Ixer/VkTYcoVEBAGHhUM0db/tGsGVZGw2L88oo=;
        b=eEJ6aKr1DWoHZ5lNMdogEIPEtf89qVflCiC7bXtqcUF6YMY6ColUCrkT+mmhinKnh7
         bypKUc9aQ4Ruo4qqjLCzqaaysZqIgCGg14X+PFEeCH2ev7mzM0etNCKCPMxKcA7EAYSy
         ZFx2BC6+RZdD8vPo/mM+lRANLVct6qRDqxjfcd1AIJydeTUYY3O5NFRnqPRWrr101VWo
         3oylIwTz6rVT1HTjNYLKgiMBj8KVVBKjcHoYEKM7IbVtyW/42zeF5MWM8xa3vVvk/Wso
         4YdjHyjacSvtPKOTDUPJsMYbqJ9dpqgjx7FcmGcysn0drmbhs0OMdtchKGVjarkmOpiQ
         84FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kir25Ixer/VkTYcoVEBAGHhUM0db/tGsGVZGw2L88oo=;
        b=Eip3a918hat+V4w2SSmcLDubWpdcC3PuEGXw+y21YxX2c6rojEBF0rOExZ5SGlhign
         8yYlVsvmNYgZqcUy/tJVtj9zjdw/F+hoU1ZUiLJkF/Wq/lKEI2yDS2I/2xPlvLfqGbv3
         ds/rcDQRTBsIUfYGphVaPKEe5dyppkPsYIwpUi3SygWbPmd0VvK1WClRz2qwQvflu93C
         aMk+UL6+/1K7AI4aHR4Oa5Jf4dy8eQ+THEPZt0EGzA7yXkgxP6x1DZK/1KAeQht/THHZ
         5dXe5dHnqwo/lGfWFWdd4x+trjHjGSLYQNuw+LNw5dnJTRDztqJcsCXZLbg8NwPLspqQ
         Q0zA==
X-Gm-Message-State: APjAAAXHz3gnoFaXq3puMsbpRM13HD/7bGIr8OeOywYYX90fqD50IlQT
        CmdlxQXkznwt9cDlAIqWhpc8ekTqFcv8lk5zsGJYoovv
X-Google-Smtp-Source: APXvYqyjHwQQEW3yUwlqMHm1NwkINqd5dJZnsYYW2vjWy3vVO7L/vYn7QodU9x+ufQriWivhifXowFUVtbKPwNXG3AQ=
X-Received: by 2002:a67:fd13:: with SMTP id f19mr4325991vsr.53.1566601388936;
 Fri, 23 Aug 2019 16:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <e6e982e5a6e4517d97a7a404384057110f3a151d.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <e6e982e5a6e4517d97a7a404384057110f3a151d.1566313865.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Aug 2019 16:02:57 -0700
Message-ID: <CABPp-BEmwSwg4tgJg6nVG8a3Hpn_g-=ZjApZF4EiJO+qVgu4uw@mail.gmail.com>
Subject: Re: [PATCH 2/9] sparse-checkout: create 'init' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 8:13 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Getting started with a sparse-checkout file can be daunting. Help
> users start their sparse enlistment using 'git sparse-checkout init'.
> This will set 'core.sparseCheckout=true' in their config, write
> an initial set of patterns to the sparse-checkout file, and update
> their working directory.
>
> Using 'git read-tree' to clear directories does not work cleanly
> on Windows, so manually delete directories that are tracked by Git
> before running read-tree.

Is that a bug in read-tree that needs to be fixed?

> The use of running another process for 'git read-tree' is likely
> suboptimal, but that can be improved in a later change, if valuable.

I think it's valuable.  The bigger problem may be that "git read-tree
-mu HEAD" may turn out to be insufficient for our needs; see below....

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |   7 ++
>  builtin/sparse-checkout.c             | 106 +++++++++++++++++++++++++-
>  t/t1091-sparse-checkout-builtin.sh    |  40 ++++++++++
>  3 files changed, 152 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index ca0ca6a12f..50c53ee60a 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -26,6 +26,13 @@ COMMANDS
>  'list'::
>         Provide a list of the contents in the sparse-checkout file.
>
> +'init'::
> +       Enable the `core.sparseCheckout` setting. If the
> +       sparse-checkout file does not exist, then populate it with
> +       patterns that match every file in the root directory and
> +       no other directories, then will remove all directories tracked
> +       by Git. Add patterns to the sparse-checkout file to
> +       repopulate the working directory.
>
>  SPARSE CHECKOUT
>  ----------------
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 6477a6ed9c..86d24e6295 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -8,7 +8,7 @@
>  #include "strbuf.h"
>
>  static char const * const builtin_sparse_checkout_usage[] = {
> -       N_("git sparse-checkout [list]"),
> +       N_("git sparse-checkout [init|list]"),
>         NULL
>  };
>
> @@ -64,6 +64,108 @@ static int sparse_checkout_list(int argc, const char **argv)
>         return 0;
>  }
>
> +static int sc_read_tree(void)
> +{
> +       struct argv_array argv = ARGV_ARRAY_INIT;
> +       int result = 0;
> +       argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
> +
> +       if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +               error(_("failed to update index with new sparse-checkout paths"));
> +               result = 1;
> +       }

`git read-tree -m -u HEAD` will fail if the index has any higher stage
entries in it, even if those higher stage entries correspond to files
which are included in the sparseness patterns and thus would not need
an update.  It might be nice if we can find a way to provide a better
error message, and/or implement the read-tree -m -u HEAD internally in
a way that will allow us to not fail if the conflicted files are
included in the sparse set.

> +
> +       argv_array_clear(&argv);
> +       return result;
> +}
> +
> +static int sc_enable_config(void)
> +{
> +       struct argv_array argv = ARGV_ARRAY_INIT;
> +       int result = 0;
> +       argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", "true", NULL);

Why --add?  That seems really odd to me.

This should also have "--worktree".  And this function should either
set extensions.worktreeConfig to true or die if it isn't already set;
not sure which.  There's some UI and documentation stuff to figure out
here...

> +
> +       if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +               error(_("failed to enable core.sparseCheckout"));
> +               result = 1;
> +       }
> +
> +       argv_array_clear(&argv);
> +       return result;
> +}
> +
> +static int delete_directory(const struct object_id *oid, struct strbuf *base,
> +               const char *pathname, unsigned mode, int stage, void *context)
> +{
> +       struct strbuf dirname = STRBUF_INIT;
> +       struct stat sb;
> +
> +       strbuf_addstr(&dirname, the_repository->worktree);
> +       strbuf_addch(&dirname, '/');
> +       strbuf_addstr(&dirname, pathname);
> +
> +       if (stat(dirname.buf, &sb) || !(sb.st_mode & S_IFDIR))
> +               return 0;
> +
> +       if (remove_dir_recursively(&dirname, 0))

flags = 0 implies not REMOVE_DIR_EMPTY_ONLY.  I'm not familiar with
remove_dir_recursively(), but won't this delete everything...including
untracked files?  If so, that sounds like a bug.

> +               warning(_("failed to remove directory '%s'"),
> +                       dirname.buf);
> +
> +       strbuf_release(&dirname);
> +       return 0;
> +}
> +
> +static int sparse_checkout_init(int argc, const char **argv)
> +{
> +       struct tree *t;
> +       struct object_id oid;
> +       struct exclude_list el;
> +       static struct pathspec pathspec;
> +       char *sparse_filename;
> +       FILE *fp;
> +       int res;
> +
> +       if (sc_enable_config())
> +               return 1;
> +
> +       memset(&el, 0, sizeof(el));
> +
> +       sparse_filename = get_sparse_checkout_filename();
> +       res = add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);

But 'el' isn't used again?  Why are we getting the list of files from
sparse_filename then?

> +
> +       /* If we already have a sparse-checkout file, use it. */
> +       if (res >= 0) {
> +               free(sparse_filename);
> +               goto reset_dir;
> +       }
> +
> +       /* initial mode: all blobs at root */
> +       fp = fopen(sparse_filename, "w");
> +       free(sparse_filename);
> +       fprintf(fp, "/*\n!/*/*\n");
> +       fclose(fp);

Makes sense.

> +
> +       /* remove all directories in the root, if tracked by Git */
> +       if (get_oid("HEAD", &oid)) {
> +               /* assume we are in a fresh repo */
> +               return 0;
> +       }
> +
> +       t = parse_tree_indirect(&oid);
> +
> +       parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
> +                                 ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
> +                      PATHSPEC_PREFER_CWD,
> +                      "", NULL);
> +
> +       if (read_tree_recursive(the_repository, t, "", 0, 0, &pathspec,
> +                               delete_directory, NULL))
> +               return 1;

Since this is only needed on Windows, as per your commit message,
should it be #ifdef'd?  Or is this actually a bug that should be fixed
in "git read-tree -mu HEAD"?

> +
> +reset_dir:
> +       return sc_read_tree();
> +}
> +

The rest looks fine.
