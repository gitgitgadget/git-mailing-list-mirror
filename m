Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF721F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeA3URE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:17:04 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41327 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeA3URC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:17:02 -0500
Received: by mail-yw0-f194.google.com with SMTP id b129so5732337ywa.8
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5cwVztszzTMnHcecWIzEpfVYBsd97sMbhs3waDoGxo0=;
        b=eNvSBAAkWFXbjvHla3QCiVQUwe61QsM9MtMHxcSVy5dWAeVLzCA+I/VCcyvl+RZJ4C
         scQ11jln2cgsHNKP4fW5d8p0RWJx3hKCZBb/GEhQ2JMqq0gS295Ygv8ZUkd0QCwaOIeJ
         nhug1RTUY1HC7rVZt3a+c3HD3/OoICTMxRAcSLDEnPqK18eazs+dFW/XNMc7NKbubnf9
         4bcoVGjS19Yzue08Zun5x+MDeq5LiozBBFh2e8m9QKBYkiWQfBJuyzLiXS9UIStTxGEl
         Pd9S01b8vo53nDgVRk1eOGDT6U7j7CL8ohdL62qS9Va32mRRLBVUYeAgJ4FzUk+u2z+6
         NXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5cwVztszzTMnHcecWIzEpfVYBsd97sMbhs3waDoGxo0=;
        b=fwMIHPrMqPzsc+0AL5MKXSFXrBOWhHEQDLcNbO1pppJG7+TisK1oriC2tM+WaiWGKS
         taPv43CyIDU93yfNdpEcoAV+P4i/FoPXiK7uZW2dYZpdp1VgNZDUu0vnTmQJRIVInkI/
         FX0/GWoA7Pf4o6wkmATy/8mRkdZj/VcSa3cIYS57rC/MIxTb+Ewl1CV0vRp6F8R5ZdFR
         TOWJZ/IPTjiaOj9ukCnamhE/gYvZL6BgOuQfz9Gs9aSzBC6TUYRZwrHxQpSnRv0wgXce
         VR+n4FwKFsQexniCEAW6BlI+kzSafirVOQFRvV+f3SJj32NGOWiGIA7gX8xUkvvWNVXG
         LIXw==
X-Gm-Message-State: AKwxytcK19k6ueWdBdxBK/RcQKOgNukZU8mw2ymaN4QeUOA7BG03l8YP
        hWR0JaF+PRUFR/nZRxAtUpcb+nAzqyDQCKqoA/FVgdHda3k=
X-Google-Smtp-Source: AH8x227/xl5AfXjpJJMGgpn6a5sZVpzCkGu+yKNnH6fAFVx17IGn3f4Y3paG1IrlgMBRmZdqREX+fMu0AIgFPNt4Tno=
X-Received: by 10.129.122.73 with SMTP id v70mr20297677ywc.156.1517343421836;
 Tue, 30 Jan 2018 12:17:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 12:17:01 -0800 (PST)
In-Reply-To: <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <cover.1517266437.git.johannes.schindelin@gmx.de> <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 12:17:01 -0800
Message-ID: <CAGZ79kYK9H88HRLKBFs+OatYMVVqmc1WOsTbaUbaK9yW0Sqqrg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] sequencer: introduce new commands to reset the revision
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 2:54 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> In the upcoming commits, we will teach the sequencer to recreate merges.
> This will be done in a very different way from the unfortunate design of
> `git rebase --preserve-merges` (which does not allow for reordering
> commits, or changing the branch topology).
>
> The main idea is to introduce new todo list commands, to support
> labeling the current revision with a given name, resetting the current
> revision to a previous state, merging labeled revisions.
>
> This idea was developed in Git for Windows' Git garden shears (that are
> used to maintain the "thicket of branches" on top of upstream Git), and
> this patch is part of the effort to make it available to a wider
> audience, as well as to make the entire process more robust (by
> implementing it in a safe and portable language rather than a Unix shell
> script).
>
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
>
>         label <name>
>         reset <name>
>
> Internally, the `label <name>` command creates the ref
> `refs/rewritten/<name>`. This makes it possible to work with the labeled
> revisions interactively, or in a scripted fashion (e.g. via the todo
> list command `exec`).
>
> Later in this patch series, we will mark the `refs/rewritten/` refs as
> worktree-local, to allow for interactive rebases to be run in parallel in
> worktrees linked to the same repository.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh |   2 +
>  sequencer.c                | 180 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 179 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index fcedece1860..7e5281e74aa 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -162,6 +162,8 @@ s, squash <commit> = use commit, but meld into previous commit
>  f, fixup <commit> = like \"squash\", but discard this commit's log message
>  x, exec <commit> = run command (the rest of the line) using shell
>  d, drop <commit> = remove commit
> +l, label <label> = label current HEAD with a name
> +t, reset <label> = reset HEAD to a label
>
>  These lines can be re-ordered; they are executed from top to bottom.
>  " | git stripspace --comment-lines >>"$todo"
> diff --git a/sequencer.c b/sequencer.c
> index 4d3f60594cb..92ca8d2adee 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -21,6 +21,8 @@
>  #include "log-tree.h"
>  #include "wt-status.h"
>  #include "hashmap.h"
> +#include "unpack-trees.h"
> +#include "worktree.h"
>
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>
> @@ -116,6 +118,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
>  static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
>  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
>         "rebase-merge/rewritten-pending")
> +
> +/*
> + * The path of the file listing refs that need to be deleted after the rebase
> + * finishes. This is used by the `merge` command.
> + */

So this file contains (label -> commit), which is appended in do_label,
it uses refs to store the commits in refs/rewritten.
We do not have to worry about the contents of that file getting too long,
or label re-use, because the directory containing all these helper files will
be deleted upon successful rebase in `sequencer_remove_state()`.



> +static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
> +
>  /*
>   * The following files are written by git-rebase just after parsing the
>   * command-line (and are only consumed, not modified, by the sequencer).
> @@ -767,6 +776,8 @@ enum todo_command {
>         TODO_SQUASH,
>         /* commands that do something else than handling a single commit */
>         TODO_EXEC,
> +       TODO_LABEL,
> +       TODO_RESET,
>         /* commands that do nothing but are counted for reporting progress */
>         TODO_NOOP,
>         TODO_DROP,
> @@ -785,6 +796,8 @@ static struct {
>         { 'f', "fixup" },
>         { 's', "squash" },
>         { 'x', "exec" },
> +       { 'l', "label" },
> +       { 't', "reset" },
>         { 0,   "noop" },
>         { 'd', "drop" },
>         { 0,   NULL }
> @@ -1253,7 +1266,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>                 if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
>                         item->command = i;
>                         break;
> -               } else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
> +               } else if ((bol + 1 == eol || bol[1] == ' ') &&
> +                          *bol == todo_command_info[i].c) {
>                         bol++;
>                         item->command = i;
>                         break;
> @@ -1279,7 +1293,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>                 return error(_("missing arguments for %s"),
>                              command_to_string(item->command));
>
> -       if (item->command == TODO_EXEC) {
> +       if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
> +           item->command == TODO_RESET) {
>                 item->commit = NULL;
>                 item->arg = bol;
>                 item->arg_len = (int)(eol - bol);
> @@ -1919,6 +1934,144 @@ static int do_exec(const char *command_line)
>         return status;
>  }
>
> +static int safe_append(const char *filename, const char *fmt, ...)
> +{
> +       va_list ap;
> +       struct lock_file lock = LOCK_INIT;
> +       int fd = hold_lock_file_for_update(&lock, filename, 0);
> +       struct strbuf buf = STRBUF_INIT;
> +
> +       if (fd < 0)
> +               return error_errno(_("could not lock '%s'"), filename);
> +
> +       if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
> +               return error_errno(_("could not read '%s'"), filename);
> +       strbuf_complete(&buf, '\n');
> +       va_start(ap, fmt);
> +       strbuf_vaddf(&buf, fmt, ap);
> +       va_end(ap);
> +
> +       if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +               rollback_lock_file(&lock);
> +               return error_errno(_("could not write to '%s'"), filename);
> +       }
> +       if (commit_lock_file(&lock) < 0) {
> +               rollback_lock_file(&lock);
> +               return error(_("failed to finalize '%s'"), filename);
> +       }
> +
> +       return 0;
> +}
> +
> +static int do_label(const char *name, int len)
> +{
> +       struct ref_store *refs = get_main_ref_store();
> +       struct ref_transaction *transaction;
> +       struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
> +       struct strbuf msg = STRBUF_INIT;
> +       int ret = 0;
> +       struct object_id head_oid;
> +
> +       strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> +       strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
> +
> +       transaction = ref_store_transaction_begin(refs, &err);
> +       if (!transaction) {
> +               error("%s", err.buf);
> +               ret = -1;
> +       } else if (get_oid("HEAD", &head_oid)) {
> +               error(_("could not read HEAD"));
> +               ret = -1;
> +       } else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
> +                                         NULL, 0, msg.buf, &err) < 0 ||
> +                  ref_transaction_commit(transaction, &err)) {
> +               error("%s", err.buf);
> +               ret = -1;
> +       }
> +       ref_transaction_free(transaction);
> +       strbuf_release(&err);
> +       strbuf_release(&msg);
> +
> +       if (!ret)
> +               ret = safe_append(rebase_path_refs_to_delete(),
> +                                 "%s\n", ref_name.buf);
> +       strbuf_release(&ref_name);
> +
> +       return ret;
> +}
> +
> +static int do_reset(const char *name, int len)
> +{
> +       struct strbuf ref_name = STRBUF_INIT;
> +       struct object_id oid;
> +       struct lock_file lock = LOCK_INIT;
> +       struct tree_desc desc;
> +       struct tree *tree;
> +       struct unpack_trees_options opts;
> +       int ret = 0, i;
> +
> +       if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +               return -1;
> +
> +       /* Determine the length of the label */
> +       for (i = 0; i < len; i++)
> +               if (isspace(name[i]))
> +                       len = i;
> +
> +       strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> +       if (get_oid(ref_name.buf, &oid) &&
> +           get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
> +               error(_("could not read '%s'"), ref_name.buf);
> +               rollback_lock_file(&lock);
> +               strbuf_release(&ref_name);
> +               return -1;
> +       }
> +
> +       memset(&opts, 0, sizeof(opts));
> +       opts.head_idx = 1;
> +       opts.src_index = &the_index;
> +       opts.dst_index = &the_index;
> +       opts.fn = oneway_merge;
> +       opts.merge = 1;
> +       opts.update = 1;
> +       opts.reset = 1;
> +
> +       read_cache_unmerged();

In read-tree.c merge.c and pull.c we guard this conditionally
and use die_resolve_conflict to bail out. In am.c we do not.

I think we'd want to guard it here, too?

Constructing an instruction sheet that produces a merge
conflict just before the reset is a bit artificial, but still:

    label onto
    pick abc
    exec false # run "git merge out-of-rebase-merge"
        # manually to produce a conflict
    reset onto # we want to stop here telling the user to fix it.

> +       if (!fill_tree_descriptor(&desc, &oid)) {
> +               error(_("failed to find tree of %s"), oid_to_hex(&oid));
> +               rollback_lock_file(&lock);
> +               free((void *)desc.buffer);
> +               strbuf_release(&ref_name);
> +               return -1;
> +       }
> +
> +       if (unpack_trees(1, &desc, &opts)) {
> +               rollback_lock_file(&lock);
> +               free((void *)desc.buffer);
> +               strbuf_release(&ref_name);
> +               return -1;
> +       }
> +
> +       tree = parse_tree_indirect(&oid);
> +       prime_cache_tree(&the_index, tree);
> +
> +       if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> +               ret = error(_("could not write index"));
> +       free((void *)desc.buffer);

For most newer structs we have a {release, clear, free}_X,
but for tree_desc's this seems to be the convention to avoid memleaks.

Thanks,
Stefan
