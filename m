Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BAC1F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeBKAKN (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:55681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752910AbeBKAKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:12 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MK0Np-1ejIAn3Luv-001V8m; Sun, 11 Feb 2018 01:10:00 +0100
Date:   Sun, 11 Feb 2018 01:09:58 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 00/12] rebase -i: offer to recreate merge commits
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3cgo+HD8KwVd316GsxgUvJNRTESvyhNwlf6c/iXVRdE8hk6ONZ4
 I7/aL+3OpxO1e/FcKnHGN9+f7Q11nsInRxyVM2ncEqaRZxJ/4Aw9L7zuKKP6DUAWyQLlea8
 fzJ1rNjL8bgxqI7TniEICuidR0KvFiFc39/7jAMS7g4RtRcMdmQn2tbfWUMp/mYNsTiT+5E
 eMymnMecn3TjwtXTseANQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B0WFbl8+coE=:zMk5hR/uZI11QSMKhpV02r
 FofceVhs3CuWIfckeShxy63n4fNW7vNGg0V3x1g1gaugxIJR05BNsgxGJQ2ZzNCKxdKLAUYAe
 HANibRNoi7ypPtN6Nf8P0vWDufX+8wh56FotQ7c1fJjGA5fvZo4oXCAyMl/UTGGlSmRA9T5sr
 Vm6YDO2i7AYfy9l1d4NDKTs1W0r5wu6RYV1T7nMTH8yuyhymQinXVbthU4Rpyc3FhBxAvMJFp
 m2HTm5CYGLghlpj6OWvxLiYUJdx2lbGtA0Ogz5q4JBKHqtMjC2yVPafWt9c6WyEaql3UX+T21
 QlF1uZ0lHAeUI96Y5teAaFI9WgBZaYMPsoeKW0iYCImZYOe/b3lGjeE45O5LmWvhocj5qT2LH
 v+1US97NebfrS3iDd9Fz4TWw0M+HC77Ow4QYizp9ES7bRPaAkak9MORpJcaNgUcjFJET/FYOR
 +Ds6Z5LoXgybqseOueTgVM9ZBKulVC0j8bHKDnpsg2B2VW8M+CwdpVu9qXYC+c+NPNotQGwRe
 RGVyDRubiLJZRhgLe9UBV8BK53vERkZYe8TCmj2sP3qCBGcJSnbDXFguPciRiWRrssbHpu0h0
 Qf9t1X8XLxvV+g1JxTLNOIcgy49Gn72nJRTf9/9vbjZcXFz0WzEq2U5efnngd567cTpxsrL1Y
 vGLxu2V+DU68RLKeDGXojyWt0JG1p4dpB1C2EsI4ifD3hu97+MARdS4DuztYgIVkXaqsqsCLM
 yGsRpWMVi1L8aqix7MwWtT8OuYjOwjSufID5M5iZALNcBaEXP5+0g595eSgRrVnxp4h62f68x
 u22p8dn2tQRSDUltssyIxe81Twyr1LpY3n6DUzU1U+DNDyQEgw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, I dreamt of an interactive rebase that would not
flatten branch structure, but instead recreate the commit topology
faithfully.

My original attempt was --preserve-merges, but that design was so
limited that I did not even enable it in interactive mode.

Subsequently, it *was* enabled in interactive mode, with the predictable
consequences: as the --preserve-merges design does not allow for
specifying the parents of merge commits explicitly, all the new commits'
parents are defined *implicitly* by the previous commit history, and
hence it is *not possible to even reorder commits*.

This design flaw cannot be fixed. Not without a complete re-design, at
least. This patch series offers such a re-design.

Think of --recreate-merges as "--preserve-merges done right". It
introduces new verbs for the todo list, `label`, `reset` and `merge`.
For a commit topology like this:

            A - B - C
              \   /
                D

the generated todo list would look like this:

            # branch D
            pick 0123 A
            label branch-point
            pick 1234 D
            label D

            reset branch-point
            pick 2345 B
            merge -C 3456 D # C

There are more patches in the pipeline, based on this patch series, but
left for later in the interest of reviewable patch series: one mini
series to use the sequencer even for `git rebase -i --root`, and another
one to add support for octopus merges to --recreate-merges.

Changes since v2:

- fixed the incorrect comment for rebase_path_refs_to_delete.

- we now error out properly if read_cache_unmerged() fails.

- if there are unresolved merge conflicts, the `reset` command now errors out
  (even if the current design should not allow for such a scenario to occur).

- a diff hunk that was necessary to support `bud` was dropped from 2/10.

- changed all `rollback_lock_file(); return error_errno(...);` patterns to
  first show the errors (i.e. using the correct errno). This added 1/11.

- The temporary refs are now also cleaned up upon `git rebase --abort`.

- Reworked the entire patch series to support

	merge -C <commit> <tip> # <oneline>

  instead of the previous `merge <commit> <tip> <oneline>`.

- Dropped the octopus part of the description of the `merge` command in
  the usage at the bottom of the todo list, as it is subject to change.

- The autosquash handling was not elegant, and cuddled into the same
  commit as the post-rewrite changes. Now, the autosquash handling is a
  lot more elegant, and a separate introductory patch (as it arguably
  improves the current code on its own).


Johannes Schindelin (11):
  sequencer: avoid using errno clobbered by rollback_lock_file()
  sequencer: make rearrange_squash() a bit more obvious
  sequencer: introduce new commands to reset the revision
  sequencer: introduce the `merge` command
  sequencer: fast-forward merge commits, if possible
  rebase-helper --make-script: introduce a flag to recreate merges
  rebase: introduce the --recreate-merges option
  sequencer: make refs generated by the `label` command worktree-local
  sequencer: handle post-rewrite for merge commands
  pull: accept --rebase=recreate to recreate the branch topology
  rebase -i: introduce --recreate-merges=[no-]rebase-cousins

Stefan Beller (1):
  git-rebase--interactive: clarify arguments

 Documentation/config.txt               |   8 +
 Documentation/git-pull.txt             |   5 +-
 Documentation/git-rebase.txt           |  14 +-
 builtin/pull.c                         |  14 +-
 builtin/rebase--helper.c               |  13 +-
 builtin/remote.c                       |   2 +
 contrib/completion/git-completion.bash |   4 +-
 git-rebase--interactive.sh             |  22 +-
 git-rebase.sh                          |  16 +
 refs.c                                 |   3 +-
 sequencer.c                            | 736 ++++++++++++++++++++++++++++++++-
 sequencer.h                            |   7 +
 t/t3430-rebase-recreate-merges.sh      | 208 ++++++++++
 13 files changed, 1021 insertions(+), 31 deletions(-)
 create mode 100755 t/t3430-rebase-recreate-merges.sh


base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v3
Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v3

Interdiff vs v2:
 diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
 index 5e21e4cf269..e199fe1cca5 100644
 --- a/git-rebase--interactive.sh
 +++ b/git-rebase--interactive.sh
 @@ -164,10 +164,10 @@ x, exec <commit> = run command (the rest of the line) using shell
  d, drop <commit> = remove commit
  l, label <label> = label current HEAD with a name
  t, reset <label> = reset HEAD to a label
 -m, merge <original-merge-commit> ( <label> | \"<label>...\" ) [<oneline>]
 +m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
  .       create a merge commit using the original merge commit's
 -.       message (or the oneline, if "-" is given). Use a quoted
 -.       list of commits to be merged for octopus merges.
 +.       message (or the oneline, if no original merge commit was
 +.       specified). Use -c <commit> to reword the commit message.
  
  These lines can be re-ordered; they are executed from top to bottom.
  " | git stripspace --comment-lines >>"$todo"
 diff --git a/sequencer.c b/sequencer.c
 index cd2f2ae5d53..c877432d7b4 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -123,7 +123,7 @@ static GIT_PATH_FUNC(rebase_path_rewritten_pending,
  
  /*
   * The path of the file listing refs that need to be deleted after the rebase
 - * finishes. This is used by the `merge` command.
 + * finishes. This is used by the `label` command to record the need for cleanup.
   */
  static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  
 @@ -206,18 +206,33 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
  
  int sequencer_remove_state(struct replay_opts *opts)
  {
 -	struct strbuf dir = STRBUF_INIT;
 +	struct strbuf buf = STRBUF_INIT;
  	int i;
  
 +	if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
 +		char *p = buf.buf;
 +		while (*p) {
 +			char *eol = strchr(p, '\n');
 +			if (eol)
 +				*eol = '\0';
 +			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0)
 +				warning(_("could not delete '%s'"), p);
 +			if (!eol)
 +				break;
 +			p = eol + 1;
 +		}
 +	}
 +
  	free(opts->gpg_sign);
  	free(opts->strategy);
  	for (i = 0; i < opts->xopts_nr; i++)
  		free(opts->xopts[i]);
  	free(opts->xopts);
  
 -	strbuf_addstr(&dir, get_dir(opts));
 -	remove_dir_recursively(&dir, 0);
 -	strbuf_release(&dir);
 +	strbuf_reset(&buf);
 +	strbuf_addstr(&buf, get_dir(opts));
 +	remove_dir_recursively(&buf, 0);
 +	strbuf_release(&buf);
  
  	return 0;
  }
 @@ -307,12 +322,14 @@ static int write_message(const void *buf, size_t len, const char *filename,
  	if (msg_fd < 0)
  		return error_errno(_("could not lock '%s'"), filename);
  	if (write_in_full(msg_fd, buf, len) < 0) {
 +		error_errno(_("could not write to '%s'"), filename);
  		rollback_lock_file(&msg_file);
 -		return error_errno(_("could not write to '%s'"), filename);
 +		return -1;
  	}
  	if (append_eol && write(msg_fd, "\n", 1) < 0) {
 +		error_errno(_("could not write eol to '%s'"), filename);
  		rollback_lock_file(&msg_file);
 -		return error_errno(_("could not write eol to '%s'"), filename);
 +		return -1;
  	}
  	if (commit_lock_file(&msg_file) < 0) {
  		rollback_lock_file(&msg_file);
 @@ -781,6 +798,7 @@ enum todo_command {
  	TODO_LABEL,
  	TODO_RESET,
  	TODO_MERGE,
 +	TODO_MERGE_AND_EDIT,
  	/* commands that do nothing but are counted for reporting progress */
  	TODO_NOOP,
  	TODO_DROP,
 @@ -802,6 +820,7 @@ static struct {
  	{ 'l', "label" },
  	{ 't', "reset" },
  	{ 'm', "merge" },
 +	{ 0, "merge" }, /* MERGE_AND_EDIT */
  	{ 0,   "noop" },
  	{ 'd', "drop" },
  	{ 0,   NULL }
 @@ -1270,8 +1289,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
  			item->command = i;
  			break;
 -		} else if ((bol + 1 == eol || bol[1] == ' ') &&
 -			   *bol == todo_command_info[i].c) {
 +		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
  			bol++;
  			item->command = i;
  			break;
 @@ -1305,21 +1323,30 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  		return 0;
  	}
  
 -	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
 -	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
 -	item->arg_len = (int)(eol - item->arg);
 -
 -	if (item->command == TODO_MERGE && *bol == '-' &&
 -	    bol + 1 == end_of_object_name) {
 -		item->commit = NULL;
 -		return 0;
 +	if (item->command == TODO_MERGE) {
 +		if (skip_prefix(bol, "-C", &bol))
 +			bol += strspn(bol, " \t");
 +		else if (skip_prefix(bol, "-c", &bol)) {
 +			bol += strspn(bol, " \t");
 +			item->command = TODO_MERGE_AND_EDIT;
 +		} else {
 +			item->command = TODO_MERGE_AND_EDIT;
 +			item->commit = NULL;
 +			item->arg = bol;
 +			item->arg_len = (int)(eol - bol);
 +			return 0;
 +		}
  	}
  
 +	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
  	saved = *end_of_object_name;
  	*end_of_object_name = '\0';
  	status = get_oid(bol, &commit_oid);
  	*end_of_object_name = saved;
  
 +	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
 +	item->arg_len = (int)(eol - item->arg);
 +
  	if (status < 0)
  		return -1;
  
 @@ -1609,16 +1636,17 @@ static int save_head(const char *head)
  
  	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
  	if (fd < 0) {
 +		error_errno(_("could not lock HEAD"));
  		rollback_lock_file(&head_lock);
 -		return error_errno(_("could not lock HEAD"));
 +		return -1;
  	}
  	strbuf_addf(&buf, "%s\n", head);
  	written = write_in_full(fd, buf.buf, buf.len);
  	strbuf_release(&buf);
  	if (written < 0) {
 +		error_errno(_("could not write to '%s'"), git_path_head_file());
  		rollback_lock_file(&head_lock);
 -		return error_errno(_("could not write to '%s'"),
 -				   git_path_head_file());
 +		return -1;
  	}
  	if (commit_lock_file(&head_lock) < 0) {
  		rollback_lock_file(&head_lock);
 @@ -1948,11 +1976,12 @@ static int safe_append(const char *filename, const char *fmt, ...)
  {
  	va_list ap;
  	struct lock_file lock = LOCK_INIT;
 -	int fd = hold_lock_file_for_update(&lock, filename, 0);
 +	int fd = hold_lock_file_for_update(&lock, filename,
 +					   LOCK_REPORT_ON_ERROR);
  	struct strbuf buf = STRBUF_INIT;
  
  	if (fd < 0)
 -		return error_errno(_("could not lock '%s'"), filename);
 +		return -1;
  
  	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
  		return error_errno(_("could not read '%s'"), filename);
 @@ -1962,8 +1991,9 @@ static int safe_append(const char *filename, const char *fmt, ...)
  	va_end(ap);
  
  	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 +		error_errno(_("could not write to '%s'"), filename);
  		rollback_lock_file(&lock);
 -		return error_errno(_("could not write to '%s'"), filename);
 +		return -1;
  	}
  	if (commit_lock_file(&lock) < 0) {
  		rollback_lock_file(&lock);
 @@ -1982,6 +2012,9 @@ static int do_label(const char *name, int len)
  	int ret = 0;
  	struct object_id head_oid;
  
 +	if (len == 1 && *name == '#')
 +		return error("Illegal label name: '%.*s'", len, name);
 +
  	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
  	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
  
 @@ -2010,14 +2043,14 @@ static int do_label(const char *name, int len)
  	return ret;
  }
  
 -static int do_reset(const char *name, int len)
 +static int do_reset(const char *name, int len, struct replay_opts *opts)
  {
  	struct strbuf ref_name = STRBUF_INIT;
  	struct object_id oid;
  	struct lock_file lock = LOCK_INIT;
  	struct tree_desc desc;
  	struct tree *tree;
 -	struct unpack_trees_options opts;
 +	struct unpack_trees_options unpack_tree_opts;
  	int ret = 0, i;
  
  	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 @@ -2037,16 +2070,18 @@ static int do_reset(const char *name, int len)
  		return -1;
  	}
  
 -	memset(&opts, 0, sizeof(opts));
 -	opts.head_idx = 1;
 -	opts.src_index = &the_index;
 -	opts.dst_index = &the_index;
 -	opts.fn = oneway_merge;
 -	opts.merge = 1;
 -	opts.update = 1;
 -	opts.reset = 1;
 +	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 +	unpack_tree_opts.head_idx = 1;
 +	unpack_tree_opts.src_index = &the_index;
 +	unpack_tree_opts.dst_index = &the_index;
 +	unpack_tree_opts.fn = oneway_merge;
 +	unpack_tree_opts.merge = 1;
 +	unpack_tree_opts.update = 1;
 +	unpack_tree_opts.reset = 1;
 +
 +	if (read_cache_unmerged())
 +		return error_resolve_conflict(_(action_name(opts)));
  
 -	read_cache_unmerged();
  	if (!fill_tree_descriptor(&desc, &oid)) {
  		error(_("failed to find tree of %s"), oid_to_hex(&oid));
  		rollback_lock_file(&lock);
 @@ -2055,7 +2090,7 @@ static int do_reset(const char *name, int len)
  		return -1;
  	}
  
 -	if (unpack_trees(1, &desc, &opts)) {
 +	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
  		rollback_lock_file(&lock);
  		free((void *)desc.buffer);
  		strbuf_release(&ref_name);
 @@ -2083,7 +2118,7 @@ static int do_reset(const char *name, int len)
  }
  
  static int do_merge(struct commit *commit, const char *arg, int arg_len,
 -		    struct replay_opts *opts)
 +		    int run_commit_flags, struct replay_opts *opts)
  {
  	int merge_arg_len;
  	struct strbuf ref_name = STRBUF_INIT;
 @@ -2137,6 +2172,8 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  		strbuf_reset(&buf);
  
  		p += strspn(p, " \t");
 +		if (*p == '#' && isspace(p[1]))
 +			p += 1 + strspn(p + 1, " \t");
  		if (*p)
  			len = strlen(p);
  		else {
 @@ -2221,7 +2258,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  	}
  	rollback_lock_file(&lock);
  
 -	ret = run_git_commit(git_path_merge_msg(), opts, 0);
 +	ret = run_git_commit(git_path_merge_msg(), opts, run_commit_flags);
  	strbuf_release(&ref_name);
  
  	return ret;
 @@ -2413,10 +2450,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  		} else if (item->command == TODO_LABEL)
  			res = do_label(item->arg, item->arg_len);
  		else if (item->command == TODO_RESET)
 -			res = do_reset(item->arg, item->arg_len);
 -		else if (item->command == TODO_MERGE) {
 -			res = do_merge(item->commit,
 -				       item->arg, item->arg_len, opts);
 +			res = do_reset(item->arg, item->arg_len, opts);
 +		else if (item->command == TODO_MERGE ||
 +			 item->command == TODO_MERGE_AND_EDIT) {
 +			res = do_merge(item->commit, item->arg, item->arg_len,
 +				       item->command == TODO_MERGE_AND_EDIT ?
 +				       EDIT_MSG | VERIFY_MSG : 0, opts);
  			if (item->commit)
  				record_in_rewritten(&item->commit->object.oid,
  						    peek_command(todo_list, 1));
 @@ -2525,23 +2564,6 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  		}
  		apply_autostash(opts);
  
 -		strbuf_reset(&buf);
 -		if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0)
 -		    > 0) {
 -			char *p = buf.buf;
 -			while (*p) {
 -				char *eol = strchr(p, '\n');
 -				if (eol)
 -					*eol = '\0';
 -				if (delete_ref("(rebase -i) cleanup",
 -					       p, NULL, 0) < 0)
 -					warning(_("could not delete '%s'"), p);
 -				if (!eol)
 -					break;
 -				p = eol + 1;
 -			}
 -		}
 -
  		fprintf(stderr, "Successfully rebased and updated %s.\n",
  			head_ref.buf);
  
 @@ -2867,11 +2889,14 @@ static const char *label_oid(struct object_id *oid, const char *label,
  		}
  	} else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
  		    !get_oid_hex(label, &dummy)) ||
 +		   (len == 1 && *label == '#') ||
  		   hashmap_get_from_hash(&state->labels,
  					 strihash(label), label)) {
  		/*
  		 * If the label already exists, or if the label is a valid full
 -		 * OID, we append a dash and a number to make it unique.
 +		 * OID, or the label is a '#' (which we use as a separator
 +		 * between merge heads and oneline), we append a dash and a
 +		 * number to make it unique.
  		 */
  		struct strbuf *buf = &state->buf;
  
 @@ -2997,7 +3022,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
  				*(char *)p1 = '-';
  
  		strbuf_reset(&buf);
 -		strbuf_addf(&buf, "%s %s",
 +		strbuf_addf(&buf, "%s -C %s",
  			    cmd_merge, oid_to_hex(&commit->object.oid));
  
  		/* label the tip of merged branch */
 @@ -3012,7 +3037,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
  
  			strbuf_addstr(&buf, label_oid(oid, label.buf, &state));
  		}
 -		strbuf_addf(&buf, " %s", oneline.buf);
 +		strbuf_addf(&buf, " # %s", oneline.buf);
  
  		FLEX_ALLOC_STR(entry, string, buf.buf);
  		oidcpy(&entry->entry.oid, &commit->object.oid);
 @@ -3262,9 +3287,14 @@ int transform_todos(unsigned flags)
  					  short_commit_name(item->commit) :
  					  oid_to_hex(&item->commit->object.oid);
  
 +			if (item->command == TODO_MERGE)
 +				strbuf_addstr(&buf, " -C");
 +			else if (item->command == TODO_MERGE_AND_EDIT)
 +				strbuf_addstr(&buf, " -c");
 +
  			strbuf_addf(&buf, " %s", oid);
 -		} else if (item->command == TODO_MERGE)
 -			strbuf_addstr(&buf, " -");
 +		}
 +
  		/* add all the rest */
  		if (!item->arg_len)
  			strbuf_addch(&buf, '\n');
 @@ -3567,8 +3597,7 @@ int rearrange_squash(void)
  		struct subject2item_entry *entry;
  
  		next[i] = tail[i] = -1;
 -		if (item->command >= TODO_EXEC &&
 -		    (item->command != TODO_MERGE || !item->commit)) {
 +		if (!item->commit || item->command == TODO_DROP) {
  			subjects[i] = NULL;
  			continue;
  		}
 diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-recreate-merges.sh
 index ab51b584ff9..9a59f12b670 100755
 --- a/t/t3430-rebase-recreate-merges.sh
 +++ b/t/t3430-rebase-recreate-merges.sh
 @@ -59,8 +59,8 @@ pick B
  label second
  
  reset onto
 -merge H second
 -merge - onebranch Merge the topic branch 'onebranch'
 +merge -C H second
 +merge onebranch # Merge the topic branch 'onebranch'
  EOF
  
  test_cmp_graph () {
 @@ -106,8 +106,8 @@ test_expect_success 'generate correct todo list' '
  
  	reset branch-point # C
  	pick 12bd07b D
 -	merge 2051b56 E E
 -	merge 233d48a H H
 +	merge -C 2051b56 E # E
 +	merge -C 233d48a H # H
  
  	EOF
  
-- 
2.16.1.windows.1

