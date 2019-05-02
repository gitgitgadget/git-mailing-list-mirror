Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA77A1F453
	for <e@80x24.org>; Thu,  2 May 2019 10:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEBKjW (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 06:39:22 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33874 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBKjW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 06:39:22 -0400
Received: by mail-it1-f193.google.com with SMTP id p18so5302931itm.1
        for <git@vger.kernel.org>; Thu, 02 May 2019 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhzVcuidRDLEgAPAMch5mEjdTqUIlFgf6Xq4YOXhhBY=;
        b=dJ/ONVTPmY+Ls4cs7DQ53S2ZJZJOZfppAUHj6yhxEa9AJRk6O0CIaHj463H3qFaPAr
         iXLd2n/ga8lF5siY3EKEpbDBJqqYA+6agh8fzjLZqC37Kuhg4aqaJ5qmzRlC4drbBszE
         2q/EIfUjm4NxciDGiRSf42c8bZlRVfow+wdJrBo0gh0TnRyJ6wnalgUVFQIRW+OvPnaF
         p8KPOmQjlWGHXIlhaN7YeRYAVP8WMK+8sWOBw3VhuOiCCl23CVnKeZ7Qq6F17n/i5DYt
         A/7NYmk4ivJVo+EGOknbMdGBHXtoD/XcYZDZdoI0ZYkYexKBVLEu6HAvml25ut7MLud0
         7awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhzVcuidRDLEgAPAMch5mEjdTqUIlFgf6Xq4YOXhhBY=;
        b=ITMLWwRt8Blw0dF0xK/54roM3lgodZIY3BGTj/OyEouwTFhHgAgNJ53Ui/roQwUePp
         Jl4QeCqP2m64G9ba6KvaEtR504EkH704NqfhaN6gOtGjtJ//kRvJ92k06C6XSDGplwrB
         lJNVazipPn8CdN52dYWWhPh6afVuns1dlYqAPlmokvdlZh1/9q7OLhnMXZGqu3/OrGb7
         TDSO7Vrs1SBQUxpMGul1CW6Sz+3vtX6w46RsNEv/UQBeJJZchIoHxMcGaBkYuebAdGTH
         Mcd6D0J00E/NVXzx96SSOKyc4rKDFvHtt5n9WhLmHTWPFB393bj8iCn7IaOEZeHpHYgK
         mCxQ==
X-Gm-Message-State: APjAAAUAvBFt8wChNgpTKKuptg6eWDG2leRHBJpF1sdBN4q5PCQfBjkk
        2Bbv+FwO/pRGW6EILrd3elMo667e0JlcWFiyb18=
X-Google-Smtp-Source: APXvYqzqSoAnrzXJV1deRjnIZ1BE65d3tW8v9unvpwobeABv9oUQxP5ZFdqMHdBNyfr7G+7TuyT5USoDDsUUYzU+LQM=
X-Received: by 2002:a02:c64a:: with SMTP id k10mr1831197jan.30.1556793561098;
 Thu, 02 May 2019 03:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190501101403.20294-1-phillip.wood123@gmail.com> <20190501101403.20294-2-phillip.wood123@gmail.com>
In-Reply-To: <20190501101403.20294-2-phillip.wood123@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 May 2019 17:38:54 +0700
Message-ID: <CACsJy8C731LL3z1zaF4mpWmag1k7V3Ny6+ar9dMmHR4hdw_9AA@mail.gmail.com>
Subject: Re: [PATCH 1/2] read-tree --reset: add --protect-untracked
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 5:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Currently there is no way to get git to discard changes to the
> worktree without overwriting untracked files. `reset --hard`,
> `checkout --force`, `checkout <rev> :/` and `read-tree --reset -u`

"checkout <rev> :/" does not use unpack-trees, I think, so it does not
belong to this group.

> will all overwrite untracked files. unpack_trees() has known how to
> avoid overwriting untracked files since commit fcc387db9b ("read-tree
> -m -u: do not overwrite or remove untracked working tree files.",
> 2006-05-17) in response to concerns about lost files [1] but those
> protections do not apply to --reset. This patch adds an
> --protect-untracked option for read-tree/unpack_trees() to apply th
> same protections with --reset.

Your enum makes me wonder if we should have --reset-tracked instead of
--protect-untracked (say what you want to reset seems tiny bit easier
to understand than "reset except untracked"). Which leads to another
question, do we ever need --reset-untracked (i.e. overwriting
untracked files but never ever touch tracked ones).

I have one use case that --reset-untracked might make sense. Suppose
you do "git reset HEAD^" where HEAD has some new files. The new files
will be left alone in worktree of course, but switching back to HEAD
after that, unpack-trees will cry murder because it would otherwise
overwrite untracked files (that have the exact same content).

--reset-untracked might be useful for that. I'm carrying a patch to
detect identical file content though which addresses this very
specific case. Maybe it's the only case that --reset-untracked may be
useful.

> It does not change the behavior of any
> of the porcelain commands but paves the way for adding options or
> changing the default for those in future.
>
> Note the actual change in unpack-trees.c is quite simple, the majority
> of this patch is converting existing callers to use the new
> unpack_trees_reset_type enum.

This could be split in a separate patch, then the actual change would
become small and more to the point.

> [1] https://public-inbox.org/git/8aa486160605161500m1dd8428cj@mail.gmail.com/
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     adding --protect-untracked to the invocation of
>     test_submodule_forced_switch() in t1013 fixes the known breakage of
>     tests 57 & 58 but breaks test 64 which relies on forcing. I'm not sure
>     that the expected results of 57 & 58 are correct if we're forcing.
>
>  Documentation/git-read-tree.txt | 10 +++++++--
>  builtin/am.c                    |  8 ++++---
>  builtin/checkout.c              |  2 +-
>  builtin/read-tree.c             | 12 +++++++++++
>  builtin/rebase.c                |  2 +-
>  builtin/reset.c                 |  2 +-
>  builtin/stash.c                 |  7 ++++---
>  t/lib-read-tree.sh              | 11 ++++++++++
>  t/t1005-read-tree-reset.sh      | 37 +++++++++++++++++++++++++++++++--
>  unpack-trees.c                  |  3 ++-
>  unpack-trees.h                  | 10 +++++++--
>  11 files changed, 88 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index d271842608..67864c6bbc 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -40,12 +40,18 @@ OPTIONS
>  --reset::
>         Same as -m, except that unmerged entries are discarded instead
>         of failing. When used with `-u`, updates leading to loss of
> -       working tree changes will not abort the operation.
> +       working tree changes will not abort the operation and
> +       untracked files will be overwritten. Use `--protect-untracked`
> +       to avoid overwriting untracked files.
>
>  -u::
>         After a successful merge, update the files in the work
>         tree with the result of the merge.
>
> +--protect-untracked::
> +       Prevent `--reset` `-u` from overwriting untracked files. Requires
> +       `--reset` and `-u` (`-m` never overwrites untracked files).
> +
>  -i::
>         Usually a merge requires the index file as well as the
>         files in the working tree to be up to date with the
> @@ -89,7 +95,7 @@ OPTIONS
>         existed in the original index file.
>
>  --exclude-per-directory=<gitignore>::
> -       When running the command with `-u` and `-m` options, the
> +       When using `-u` with `-m` or `--reset` `--protect-untracked` options, the
>         merge result may need to overwrite paths that are not
>         tracked in the current branch.  The command usually
>         refuses to proceed with the merge to avoid losing such a
> diff --git a/builtin/am.c b/builtin/am.c
> index 912d9821b1..a92394b682 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1854,7 +1854,8 @@ static void am_resolve(struct am_state *state)
>   * true, any unmerged entries will be discarded. Returns 0 on success, -1 on
>   * failure.
>   */
> -static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
> +static int fast_forward_to(struct tree *head, struct tree *remote,
> +                          enum unpack_trees_reset_type reset)
>  {
>         struct lock_file lock_file = LOCK_INIT;
>         struct unpack_trees_options opts;
> @@ -1942,7 +1943,8 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
>
>         read_cache_unmerged();
>
> -       if (fast_forward_to(head_tree, head_tree, 1))
> +       if (fast_forward_to(head_tree, head_tree,
> +                           UNPACK_RESET_OVERWRITE_UNTRACKED))
>                 return -1;
>
>         if (write_cache_as_tree(&index, 0, NULL))
> @@ -1952,7 +1954,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
>         if (!index_tree)
>                 return error(_("Could not parse object '%s'."), oid_to_hex(&index));
>
> -       if (fast_forward_to(index_tree, remote_tree, 0))
> +       if (fast_forward_to(index_tree, remote_tree, UNPACK_NO_RESET))
>                 return -1;
>
>         if (merge_tree(remote_tree))
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index ffa776c6e1..e9e70018f9 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -506,7 +506,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>         opts.head_idx = -1;
>         opts.update = worktree;
>         opts.skip_unmerged = !worktree;
> -       opts.reset = 1;
> +       opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
>         opts.merge = 1;
>         opts.fn = oneway_merge;
>         opts.verbose_update = o->show_progress;
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 5c9c082595..23735adde9 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -114,6 +114,7 @@ static int git_read_tree_config(const char *var, const char *value, void *cb)
>  int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  {
>         int i, stage = 0;
> +       int protect_untracked = -1;
>         struct object_id oid;
>         struct tree_desc t[MAX_UNPACK_TREES];
>         struct unpack_trees_options opts;
> @@ -140,6 +141,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>                   PARSE_OPT_NONEG },
>                 OPT_BOOL('u', NULL, &opts.update,
>                          N_("update working tree with merge result")),
> +               OPT_BOOL(0, "protect-untracked", &protect_untracked,
> +                        N_("do not overwrite untracked files")),
>                 { OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
>                   N_("gitignore"),
>                   N_("allow explicitly ignored files to be overwritten"),
> @@ -209,8 +212,17 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>         if ((opts.update || opts.index_only) && !opts.merge)
>                 die("%s is meaningless without -m, --reset, or --prefix",
>                     opts.update ? "-u" : "-i");
> +       if (protect_untracked >= 0) {
> +               if (!opts.reset || !opts.update)
> +                       die("-%s-protect-untracked requires --reset and -u",
> +                           protect_untracked ? "" : "-no");
> +               opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
> +       }
>         if ((opts.dir && !opts.update))
>                 die("--exclude-per-directory is meaningless unless -u");
> +       if (opts.dir && opts.reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
> +               warning("--exclude-per-directory without --preserve-untracked "
> +                       "has no effect");
>         if (opts.merge && !opts.index_only)
>                 setup_work_tree();
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 2e41ad5644..feb30a71f5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -398,7 +398,7 @@ static int reset_head(struct object_id *oid, const char *action,
>         unpack_tree_opts.update = 1;
>         unpack_tree_opts.merge = 1;
>         if (!detach_head)
> -               unpack_tree_opts.reset = 1;
> +               unpack_tree_opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
>
>         if (repo_read_index_unmerged(the_repository) < 0) {
>                 ret = error(_("could not read index"));
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 26ef9a7bd0..a39dd92fb2 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -70,7 +70,7 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
>                 opts.update = 1;
>                 /* fallthrough */
>         default:
> -               opts.reset = 1;
> +               opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
>         }
>
>         read_cache_unmerged();
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 2a8e6d09b4..175d1b62d3 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -227,7 +227,8 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
>         return do_clear_stash();
>  }
>
> -static int reset_tree(struct object_id *i_tree, int update, int reset)
> +static int reset_tree(struct object_id *i_tree, int update,
> +                     enum unpack_trees_reset_type reset)
>  {
>         int nr_trees = 1;
>         struct unpack_trees_options opts;
> @@ -461,7 +462,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>         }
>
>         if (has_index) {
> -               if (reset_tree(&index_tree, 0, 0))
> +               if (reset_tree(&index_tree, 0, UNPACK_NO_RESET))
>                         return -1;
>         } else {
>                 struct strbuf out = STRBUF_INIT;
> @@ -471,7 +472,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>                         return -1;
>                 }
>
> -               if (reset_tree(&c_tree, 0, 1)) {
> +               if (reset_tree(&c_tree, 0, UNPACK_RESET_OVERWRITE_UNTRACKED)) {
>                         strbuf_release(&out);
>                         return -1;
>                 }
> diff --git a/t/lib-read-tree.sh b/t/lib-read-tree.sh
> index b95f485606..22f516d91f 100644
> --- a/t/lib-read-tree.sh
> +++ b/t/lib-read-tree.sh
> @@ -39,3 +39,14 @@ read_tree_u_must_fail () {
>         test_cmp pre-dry-run-wt post-dry-run-wt &&
>         test_must_fail git read-tree "$@"
>  }
> +
> +read_tree_u_must_fail_save_err () {
> +       git ls-files -s >pre-dry-run &&
> +       git diff-files -p >pre-dry-run-wt &&
> +       test_must_fail git read-tree -n "$@" &&
> +       git ls-files -s >post-dry-run &&
> +       git diff-files -p >post-dry-run-wt &&
> +       test_cmp pre-dry-run post-dry-run &&
> +       test_cmp pre-dry-run-wt post-dry-run-wt &&
> +       test_must_fail git read-tree "$@" 2>actual-err
> +}
> diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
> index 83b09e1310..6c9dd6805b 100755
> --- a/t/t1005-read-tree-reset.sh
> +++ b/t/t1005-read-tree-reset.sh
> @@ -19,15 +19,48 @@ test_expect_success 'setup' '
>         git add df &&
>         echo content >new &&
>         git add new &&
> -       git commit -m two
> +       git commit -m two &&
> +       git ls-files >expect-two
>  '
>
> -test_expect_success 'reset should work' '
> +test_expect_success '--protect-untracked option sanity checks' '
> +       read_tree_u_must_fail --reset --protect-untracked HEAD &&
> +       read_tree_u_must_fail --reset --no-protect-untracked HEAD &&
> +       read_tree_u_must_fail -m -u --protect-untracked HEAD &&
> +       read_tree_u_must_fail -m -u --no-protect-untracked
> +'
> +
> +test_expect_success 'reset should reset worktree' '
> +       echo changed >df &&
>         read_tree_u_must_succeed -u --reset HEAD^ &&
>         git ls-files >actual &&
>         test_cmp expect actual
>  '
>
> +test_expect_success 'reset --protect-untracked protects untracked file' '
> +       echo changed >new &&
> +       read_tree_u_must_fail_save_err -u --reset --protect-untracked HEAD &&
> +       echo "error: Untracked working tree file '\'new\'' would be overwritten by merge." >expected-err &&
> +       test_cmp expected-err actual-err
> +'
> +
> +test_expect_success 'reset --protect-untracked protects untracked directory' '
> +       rm new &&
> +       mkdir new &&
> +       echo untracked >new/untracked &&
> +       read_tree_u_must_fail_save_err -u --reset --protect-untracked HEAD &&
> +       echo "error: Updating '\'new\'' would lose untracked files in it" >expected-err &&
> +       test_cmp expected-err actual-err
> +'
> +
> +test_expect_success 'reset --protect-untracked resets' '
> +       rm -rf new &&
> +       echo changed >df/file &&
> +       read_tree_u_must_succeed -u --reset --protect-untracked HEAD &&
> +       git ls-files >actual-two &&
> +       test_cmp expect-two actual-two
> +'
> +
>  test_expect_success 'reset should remove remnants from a failed merge' '
>         read_tree_u_must_succeed --reset -u HEAD &&
>         git ls-files -s >expect &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 50189909b8..b1722730fe 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1917,7 +1917,8 @@ static int verify_absent_1(const struct cache_entry *ce,
>         int len;
>         struct stat st;
>
> -       if (o->index_only || o->reset || !o->update)
> +       if (o->index_only || o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED ||
> +           !o->update)
>                 return 0;
>
>         len = check_leading_path(ce->name, ce_namelen(ce));
> diff --git a/unpack-trees.h b/unpack-trees.h
> index d344d7d296..732b262c4d 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -41,9 +41,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>   */
>  void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
>
> +enum unpack_trees_reset_type {
> +       UNPACK_NO_RESET = 0,
> +       UNPACK_RESET_OVERWRITE_UNTRACKED,
> +       UNPACK_RESET_PROTECT_UNTRACKED
> +};
> +
>  struct unpack_trees_options {
> -       unsigned int reset,
> -                    merge,
> +       enum unpack_trees_reset_type reset;
> +       unsigned int merge,
>                      update,
>                      clone,
>                      index_only,
> --
> 2.21.0
>


-- 
Duy
