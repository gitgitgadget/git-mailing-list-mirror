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
	by dcvr.yhbt.net (Postfix) with ESMTP id 295D71F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 22:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfJLW52 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 18:57:28 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35787 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfJLW52 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 18:57:28 -0400
Received: by mail-vk1-f194.google.com with SMTP id d66so2865594vka.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zy24Zd7t0hUH43WwamGwvqSHtbtGTtOVEiLmN5RUp6U=;
        b=H9O9dRmqGwDrofJmScL5KL0guGOkNPCketMC9at7PiP5QdaQEXvZPKo5/gmfYDXNLg
         2vrhNrstwCiK8XK6FmZlhsY3M1pB66licpqBrBGIOEeHNW+m/KE/HnGURbBC3qBfUByz
         24zUDKhl4yunKDHQ1Q+tGDt3cxcwf2j44sQSn+Zuprb3chkMVAVIDgVYbeVyNsg+heT9
         7ASJ1pOuvXxze9Kj3n+5lJzEqKv5d5LggJueLb8m/+fXngZP2SK9//0VRfg2oI9qCEL/
         +j58URAGSQbXLhFY82TVfBrxHzzHhBu6P4NHVDwqRFncx8l3IkAo8ULilphnULKFT4If
         5lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy24Zd7t0hUH43WwamGwvqSHtbtGTtOVEiLmN5RUp6U=;
        b=dzGgA/MzSD5Qhsuw62/6MvOIXSKXGDgbnJgQPWJSu49tQJXznCg9KCgIpzcHWvbU8T
         XzOQF/gilewAudgaAS6qZ3GPXDhOtBI7SYqsXsrShkmnkq9yBpYFr3MvXUn9GtlZAUGe
         8+NqiIi/8/p9ZD18c5Mfs7644gjPNerFHGW60/dWWAC0SaGukpvQlpRhTNzAsRjpeSEI
         3eCdSjkNUB66f04ojHRgBl+5spDWOp/e0CcdyGSX6j/QSixU8v2IoFdJ9G0kPr3LqQXd
         Yk1tixcM0dkVxPuE1miXKSIdmAW+uCV8y97yhxu72LKmlY282UZXVXHyetYJxu3w+A8a
         o8hA==
X-Gm-Message-State: APjAAAUHiD0ot/JFiNGK9f+NgNRyACQeRKdXoEcMIdW886TydjZNHK69
        POiKdhn4cLUhNlturk+IBfB1e+m/rhl/4d8xxRI=
X-Google-Smtp-Source: APXvYqyb9o0dBgCBsro1k3BKswKQwLbwYkqnJhMJq/AT93xpgO9TSU+t5oZRLGmgREjQb9SAm/szyMkTwnyfa7xUpjE=
X-Received: by 2002:a1f:2013:: with SMTP id g19mr12522129vkg.88.1570921045757;
 Sat, 12 Oct 2019 15:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <a6f17e9a77d86f8ec856ea08617d1c1af2853d54.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <a6f17e9a77d86f8ec856ea08617d1c1af2853d54.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Oct 2019 15:57:14 -0700
Message-ID: <CABPp-BF+JWYZfDqp2Tn4AEKVp4b0YMA=Mbz4Nz62D-gGgiduYQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] sparse-checkout: update working directory in-process
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse-checkout builtin used 'git read-tree -mu HEAD' to update the
> skip-worktree bits in the index and to update the working directory.
> This extra process is overly complex, and prone to failure. It also
> requires that we write our changes to the sparse-checkout file before
> trying to update the index.
>
> Remove this extra process call by creating a direct call to
> unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
> adition, provide an in-memory list of patterns so we can avoid

s/adition/addition/

> reading from the sparse-checkout file. This allows us to test a
> proposed change to the file before writing to it.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/read-tree.c                |  2 +-
>  builtin/sparse-checkout.c          | 85 +++++++++++++++++++++++++-----
>  t/t1091-sparse-checkout-builtin.sh | 17 ++++++
>  unpack-trees.c                     |  5 +-
>  unpack-trees.h                     |  3 +-
>  5 files changed, 95 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 69963d83dc..d7eeaa26ec 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -186,7 +186,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>
>         if (opts.reset || opts.merge || opts.prefix) {
>                 if (read_cache_unmerged() && (opts.prefix || opts.merge))
> -                       die("You need to resolve your current index first");
> +                       die(_("You need to resolve your current index first"));

A good change, but isn't this unrelated to the current commit?

>                 stage = opts.merge = 1;
>         }
>         resolve_undo_clear();
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 25786f8bb0..542d57fac6 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -7,6 +7,11 @@
>  #include "run-command.h"
>  #include "strbuf.h"
>  #include "string-list.h"
> +#include "cache.h"
> +#include "cache-tree.h"
> +#include "lockfile.h"
> +#include "resolve-undo.h"
> +#include "unpack-trees.h"
>
>  static char const * const builtin_sparse_checkout_usage[] = {
>         N_("git sparse-checkout [init|list|set|disable] <options>"),
> @@ -60,18 +65,53 @@ static int sparse_checkout_list(int argc, const char **argv)
>         return 0;
>  }
>
> -static int update_working_directory(void)
> +static int update_working_directory(struct pattern_list *pl)
>  {
> -       struct argv_array argv = ARGV_ARRAY_INIT;
>         int result = 0;
> -       argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
> +       struct unpack_trees_options o;
> +       struct lock_file lock_file = LOCK_INIT;
> +       struct object_id oid;
> +       struct tree *tree;
> +       struct tree_desc t;
> +       struct repository *r = the_repository;
>
> -       if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> -               error(_("failed to update index with new sparse-checkout paths"));
> -               result = 1;
> +       if (repo_read_index_unmerged(r))
> +               die(_("You need to resolve your current index first"));

Well, at least that ensures that the user gets a good error message.
I'm not sure I like the error, because e.g. if a user hits a conflict
while merging in a sparse checkout and wants to return to a non-sparse
checkout because they think other files might help them resolve the
conflicts, then they ought to be able to do it.  Basically, unless
they are trying use sparsification to remove entries from the working
directory that differ from the index (and conflicted entries always
differ), then it seems like we should be able to support
sparsification despite the presence of conflicts.

Your series is long enough, doesn't make this problem any worse (and
appears to make it slightly better), and so you really don't need to
tackle that problem in this series. I'm just stating a gripe with
sparse checkouts again.  :-)

[...]

>  static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
>  {
> -       struct pattern_entry *e = xmalloc(sizeof(struct pattern_entry));
> +       struct pattern_entry *e = xmalloc(sizeof(*e));

This is a good fix, but shouldn't it be squashed into the
"sparse-checkout: init and set in cone mode" commit from earlier in
your series?

> @@ -262,12 +308,21 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  {
>         char *sparse_filename;
>         FILE *fp;
> -
> +       int result;
> +

Trailing whitespace that should be cleaned up.

>         if (!core_apply_sparse_checkout) {
>                 warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
>                 warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
>         }
>
> +       result = update_working_directory(pl);
> +
> +       if (result) {
> +               clear_pattern_list(pl);
> +               update_working_directory(NULL);
> +               return result;
> +       }
> +
>         sparse_filename = get_sparse_checkout_filename();
>         fp = fopen(sparse_filename, "w");
>
> @@ -277,9 +332,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
>                 write_patterns_to_file(fp, pl);
>
>         fclose(fp);
> +
>         free(sparse_filename);
> +       clear_pattern_list(pl);
>
> -       return update_working_directory();
> +       return 0;
>  }
>
>  static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
> @@ -330,6 +387,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>                 struct strbuf line = STRBUF_INIT;
>                 hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
>                 hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
> +               pl.use_cone_patterns = 1;
>
>                 if (set_opts.use_stdin) {
>                         while (!strbuf_getline(&line, stdin))
> @@ -375,7 +433,8 @@ static int sparse_checkout_disable(int argc, const char **argv)
>         fprintf(fp, "/*\n");
>         fclose(fp);
>
> -       if (update_working_directory())
> +       core_apply_sparse_checkout = 1;
> +       if (update_working_directory(NULL))
>                 die(_("error while refreshing working directory"));
>
>         unlink(sparse_filename);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index ee4d361787..82eb5fb2f8 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -199,11 +199,13 @@ test_expect_success 'cone mode: init and set' '
>                 a
>                 deep
>         EOF
> +       test_cmp dir expect &&
>         ls repo/deep >dir  &&
>         cat >expect <<-EOF &&
>                 a
>                 deeper1
>         EOF
> +       test_cmp dir expect &&
>         ls repo/deep/deeper1 >dir  &&
>         cat >expect <<-EOF &&
>                 a
> @@ -245,4 +247,19 @@ test_expect_success 'cone mode: set with nested folders' '
>         test_cmp repo/.git/info/sparse-checkout expect
>  '
>
> +test_expect_success 'revert to old sparse-checkout on bad update' '
> +       echo update >repo/deep/deeper2/a &&
> +       cp repo/.git/info/sparse-checkout expect &&
> +       test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
> +       test_i18ngrep "Cannot update sparse checkout" err &&
> +       test_cmp repo/.git/info/sparse-checkout expect &&
> +       ls repo/deep >dir &&
> +       cat >expect <<-EOF &&
> +               a
> +               deeper1
> +               deeper2
> +       EOF
> +       test_cmp dir expect
> +'
> +
>  test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index edf0fb4673..f0fee5adf2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1508,7 +1508,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>         memset(&pl, 0, sizeof(pl));
>         if (!core_apply_sparse_checkout || !o->update)
>                 o->skip_sparse_checkout = 1;
> -       if (!o->skip_sparse_checkout) {
> +       if (!o->skip_sparse_checkout && !o->pl) {
>                 char *sparse = git_pathdup("info/sparse-checkout");
>                 pl.use_cone_patterns = core_sparse_checkout_cone;
>                 if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
> @@ -1681,7 +1681,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>
>  done:
>         trace_performance_leave("unpack_trees");
> -       clear_pattern_list(&pl);
> +       if (!o->keep_pattern_list)
> +               clear_pattern_list(&pl);
>         return ret;
>
>  return_failed:
> diff --git a/unpack-trees.h b/unpack-trees.h
> index f2eee0c7c5..ca94a421a5 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -59,7 +59,8 @@ struct unpack_trees_options {
>                      quiet,
>                      exiting_early,
>                      show_all_errors,
> -                    dry_run;
> +                    dry_run,
> +                    keep_pattern_list;
>         const char *prefix;
>         int cache_bottom;
>         struct dir_struct *dir;
> --

The rest looks reasonable.
