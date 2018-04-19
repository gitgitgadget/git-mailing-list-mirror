Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1631F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeDSMNH (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:13:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:52253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeDSMNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:13:06 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lip2P-1eYyfN1uJR-00cycO; Thu, 19
 Apr 2018 14:12:56 +0200
Date:   Thu, 19 Apr 2018 14:12:39 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 00/17] rebase -i: offer to recreate commit topology
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5qPJISGTjFrwz0yoDvXGS9Bjt+8X/xhUlzDkEVEA+khQB+wfvW4
 hLyN1fpKpcMV02SgCaLnruV0F+xi5vY6Lf4I8FLW5nGWjEFEnSDC3EDMe2FrklBslZ4vX5O
 oze2v93dCfoUtL9mXPBKrQF62ncMP2cmnAzlQyQyT2xATByE5xiAsty7v/Bs+XXioQWNRRo
 iWxZzvmwocmK9tEdiwCXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JLJKZ9U+kMM=:MA0bHCCHbiB+RWC9ss5OIj
 2ihxIkHqhlseRcC6F6zmgZ2y+rFMyS86fNSCmwLmsNloo1o3l8PutqmEiH5ZHYykMpiVpRDkm
 4aD6cz5jERH1EwTwbKDWMK1KrtZ99dN/Ow3oYlOW4r0B+YQ7lnNPukwVZ/b+IdIwqRU7Z2SvM
 Wu3KYdRFD4P5Gg3DmK+QIAdjWb5k4dv2QlVrv1YZbMSPsuJ1vUZAzESXrk98Ibaa5FrFAOgBT
 rZx6RfOBy1ti8ptNX/rgPuL46485i05vuicqTqvaTLdtaw8vH8SLQnYW5KCQ3Opx0yoQIacgm
 QHknq5RNyWOxbSjh2YbW1yrpVtjZWJ+0UAsMYVaGfTbuxG+n/ZjmJ2BpUsJv7EYfHsXOk4M7q
 pUbJczggD2607b7z9iqnEm6xV+QmGDyg7NcKosy9/5/WUQvwqbgCAUhKcZ9OtwuI8mHmu/FxG
 ZR8V9u0p4sMOkCSrE+WGz9TIg5foAOz0EuQ4VdasNLmyPq9+2WHeaMhpjxYLbFcuyTIYb5MUS
 g6c8h78tzSIWqwF9FYskUlqUB7wF6y1seD+lt1wDGErSuBgUTl3WjZkffuMQjCFUdgqmcw6yf
 Vw+eHnOH5Xb09EouCE4Sr6ZWnbJqAR++hfWm7wcPG8NLAH4CJ9+Wy6/UkT79TfZdYMje8BQD7
 pY3cadEk42Vd+Weom8QsI1BQeYqYyizMF4iPc7uDpO+3zioc6J/kCga8hgX+3wa88I944XUv5
 XgxukbhlQOqX9Xs+ovCD1Hslk8XV5POVwH9a7IW9BdiJsyOW7dYnaVSd1zsdVBJYrEpLFs7mm
 TOp9tPoi12LdEWbk1NnyJMAJm39Fa5QnByDbdC9T/zXvRj304Y=
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

Think of --rebase-merges as "--preserve-merges done right". It
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
one to add support for octopus merges to --rebase-merges. And then one
to allow for rebasing merge commits in a smarter way (this one will need
a bit more work, though, as it can result in very complicated, nested
merge conflicts *very* easily).

Changes since v6:

- Reworded the REBASING MERGES section of the man page a bit (thanks, Martin &
  Phillip!).

- The `reset` todo command now refuses to overwrite untracked files (thanks
  Phillip!).

- The do_merge() function was prevented from leaking memory left and right.

- Added a nice advice for the case when todo commands were rescheduled.

- Refactored the way we get to the original line of any given todo command in
  the todo list, simplifying even existing code to make it a lot more readable.

- Failed `label` and `reset` commands, as well as `merge` that failed before
  even attempting to merge, are now rescheduled automatically (thanks
  Phillip and Philip!).

- The do_merge() function no longer tries to commit when there are merge
  conflicts (thanks Phillip!).

- When do_merge() failed to run the recursive merge, it no longer claims that
  there were conflicts (thanks Phillip!).

- When the merge failed, we now write out the index before giving `rerere` a
  chance (d'oh!).


Johannes Schindelin (15):
  sequencer: avoid using errno clobbered by rollback_lock_file()
  sequencer: make rearrange_squash() a bit more obvious
  sequencer: refactor how original todo list lines are accessed
  sequencer: offer helpful advice when a command was rescheduled
  sequencer: introduce new commands to reset the revision
  # This is a combination of 2 commits. # This is the 1st commit
    message:
  sequencer: fast-forward `merge` commands, if possible
  rebase-helper --make-script: introduce a flag to rebase merges
  rebase: introduce the --rebase-merges option
  sequencer: make refs generated by the `label` command worktree-local
  sequencer: handle post-rewrite for merge commands
  rebase --rebase-merges: avoid "empty merges"
  pull: accept --rebase=merges to recreate the branch topology
  rebase -i: introduce --rebase-merges=[no-]rebase-cousins
  rebase -i --rebase-merges: add a section to the man page

Phillip Wood (1):
  rebase --rebase-merges: add test for --keep-empty

Stefan Beller (1):
  git-rebase--interactive: clarify arguments

 Documentation/config.txt               |   8 +
 Documentation/git-pull.txt             |   5 +-
 Documentation/git-rebase.txt           | 147 ++++-
 builtin/pull.c                         |  14 +-
 builtin/rebase--helper.c               |  13 +-
 builtin/remote.c                       |  18 +-
 contrib/completion/git-completion.bash |   4 +-
 git-rebase--interactive.sh             |  22 +-
 git-rebase.sh                          |  16 +
 refs.c                                 |   3 +-
 sequencer.c                            | 869 +++++++++++++++++++++++--
 sequencer.h                            |   7 +
 t/t3421-rebase-topology-linear.sh      |   1 +
 t/t3430-rebase-merges.sh               | 221 +++++++
 14 files changed, 1288 insertions(+), 60 deletions(-)
 create mode 100755 t/t3430-rebase-merges.sh


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v7
Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v7

Interdiff vs v6:
 diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
 index be946de2efb..0ff83b62821 100644
 --- a/Documentation/git-rebase.txt
 +++ b/Documentation/git-rebase.txt
 @@ -849,14 +849,18 @@ merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
  In contrast to a regular interactive rebase, there are `label`, `reset` and
  `merge` commands in addition to `pick` ones.
  
 -The `label` command puts a label to whatever will be the current
 -revision when that command is executed. Internally, these labels are
 -worktree-local refs that will be deleted when the rebase finishes or
 -when it is aborted. That way, rebase operations in multiple worktrees
 -linked to the same repository do not interfere with one another.
 -
 -The `reset` command is essentially a `git reset --hard` to the specified
 -revision (typically a previously-labeled one).
 +The `label` command associates a label with the current HEAD when that
 +command is executed. These labels are created as worktree-local refs
 +(`refs/rewritten/<label>`) that will be deleted when the rebase
 +finishes. That way, rebase operations in multiple worktrees linked to
 +the same repository do not interfere with one another. If the `label` command
 +fails, it is rescheduled immediately, with a helpful message how to proceed.
 +
 +The `reset` command is essentially a `git read-tree -m -u` (think: `git
 +reset --hard`, but refusing to overwrite untracked files) to the
 +specified revision (typically a previously-labeled one). If the `reset`
 +command fails, it is rescheduled immediately, with a helpful message how to
 +proceed.
  
  The `merge` command will merge the specified revision into whatever is
  HEAD at that time. With `-C <original-commit>`, the commit message of
 @@ -864,13 +868,16 @@ the specified merge commit will be used. When the `-C` is changed to
  a lower-case `-c`, the message will be opened in an editor after a
  successful merge so that the user can edit the message.
  
 +If a `merge` command fails for any reason other than merge conflicts (i.e.
 +when the merge operation did not even start), it is rescheduled immediately.
 +
  At this time, the `merge` command will *always* use the `recursive`
  merge strategy, with no way to choose a different one. To work around
  this, an `exec` command can be used to call `git merge` explicitly,
  using the fact that the labels are worktree-local refs (the ref
  `refs/rewritten/onto` would correspond to the label `onto`).
  
 -Note: the first command (`reset onto`) labels the revision onto which
 +Note: the first command (`label onto`) labels the revision onto which
  the commits are rebased; The name `onto` is just a convention, as a nod
  to the `--onto` option.
  
 diff --git a/sequencer.c b/sequencer.c
 index 809df1ce484..3c7bb5d3fd8 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -1925,6 +1925,23 @@ static int count_commands(struct todo_list *todo_list)
  	return count;
  }
  
 +static int get_item_line_offset(struct todo_list *todo_list, int index)
 +{
 +	return index < todo_list->nr ?
 +		todo_list->items[index].offset_in_buf : todo_list->buf.len;
 +}
 +
 +static const char *get_item_line(struct todo_list *todo_list, int index)
 +{
 +	return todo_list->buf.buf + get_item_line_offset(todo_list, index);
 +}
 +
 +static int get_item_line_length(struct todo_list *todo_list, int index)
 +{
 +	return get_item_line_offset(todo_list, index + 1)
 +		-  get_item_line_offset(todo_list, index);
 +}
 +
  static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
  {
  	int fd;
 @@ -2299,29 +2316,27 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
  	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
  	if (fd < 0)
  		return error_errno(_("could not lock '%s'"), todo_path);
 -	offset = next < todo_list->nr ?
 -		todo_list->items[next].offset_in_buf : todo_list->buf.len;
 +	offset = get_item_line_offset(todo_list, next);
  	if (write_in_full(fd, todo_list->buf.buf + offset,
  			todo_list->buf.len - offset) < 0)
  		return error_errno(_("could not write to '%s'"), todo_path);
  	if (commit_lock_file(&todo_lock) < 0)
  		return error(_("failed to finalize '%s'"), todo_path);
  
 -	if (is_rebase_i(opts)) {
 -		const char *done_path = rebase_path_done();
 -		int fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
 -		int prev_offset = !next ? 0 :
 -			todo_list->items[next - 1].offset_in_buf;
 +	if (is_rebase_i(opts) && next > 0) {
 +		const char *done = rebase_path_done();
 +		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);
 +		int ret = 0;
  
 -		if (fd >= 0 && offset > prev_offset &&
 -		    write_in_full(fd, todo_list->buf.buf + prev_offset,
 -				  offset - prev_offset) < 0) {
 -			close(fd);
 -			return error_errno(_("could not write to '%s'"),
 -					   done_path);
 -		}
 -		if (fd >= 0)
 -			close(fd);
 +		if (fd < 0)
 +			return 0;
 +		if (write_in_full(fd, get_item_line(todo_list, next - 1),
 +				  get_item_line_length(todo_list, next - 1))
 +		    < 0)
 +			ret = error_errno(_("could not write to '%s'"), done);
 +		if (close(fd) < 0)
 +			ret = error_errno(_("failed to finalize '%s'"), done);
 +		return ret;
  	}
  	return 0;
  }
 @@ -2619,7 +2634,6 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
  	unpack_tree_opts.fn = oneway_merge;
  	unpack_tree_opts.merge = 1;
  	unpack_tree_opts.update = 1;
 -	unpack_tree_opts.reset = 1;
  
  	if (read_cache_unmerged()) {
  		rollback_lock_file(&lock);
 @@ -2671,6 +2685,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  	static struct lock_file lock;
  	const char *p;
  
 +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
 +		ret = -1;
 +		goto leave_merge;
 +	}
 +
 +	head_commit = lookup_commit_reference_by_name("HEAD");
 +	if (!head_commit) {
 +		ret = error(_("cannot merge without a current revision"));
 +		goto leave_merge;
 +	}
 +
  	oneline_offset = arg_len;
  	merge_arg_len = strcspn(arg, " \t\n");
  	p = arg + merge_arg_len;
 @@ -2688,19 +2713,10 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
  		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
  	}
 -	if (!merge_commit) {
 -		error(_("could not resolve '%s'"), ref_name.buf);
 -		strbuf_release(&ref_name);
 -		return -1;
 -	}
  
 -	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 -		return -1;
 -
 -	head_commit = lookup_commit_reference_by_name("HEAD");
 -	if (!head_commit) {
 -		rollback_lock_file(&lock);
 -		return error(_("cannot merge without a current revision"));
 +	if (!merge_commit) {
 +		ret = error(_("could not resolve '%s'"), ref_name.buf);
 +		goto leave_merge;
  	}
  
  	if (commit) {
 @@ -2709,21 +2725,20 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  		int len;
  
  		if (!message) {
 -			rollback_lock_file(&lock);
 -			return error(_("could not get commit message of '%s'"),
 -				     oid_to_hex(&commit->object.oid));
 +			ret = error(_("could not get commit message of '%s'"),
 +				    oid_to_hex(&commit->object.oid));
 +			goto leave_merge;
  		}
  		write_author_script(message);
  		find_commit_subject(message, &body);
  		len = strlen(body);
 -		if (write_message(body, len, git_path_merge_msg(), 0) < 0) {
 +		ret = write_message(body, len, git_path_merge_msg(), 0);
 +		unuse_commit_buffer(commit, message);
 +		if (ret) {
  			error_errno(_("could not write '%s'"),
  				    git_path_merge_msg());
 -			unuse_commit_buffer(commit, message);
 -			rollback_lock_file(&lock);
 -			return -1;
 +			goto leave_merge;
  		}
 -		unuse_commit_buffer(commit, message);
  	} else {
  		struct strbuf buf = STRBUF_INIT;
  		int len;
 @@ -2742,14 +2757,13 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  			len = buf.len;
  		}
  
 -		if (write_message(p, len, git_path_merge_msg(), 0) < 0) {
 +		ret = write_message(p, len, git_path_merge_msg(), 0);
 +		strbuf_release(&buf);
 +		if (ret) {
  			error_errno(_("could not write '%s'"),
  				    git_path_merge_msg());
 -			strbuf_release(&buf);
 -			rollback_lock_file(&lock);
 -			return -1;
 +			goto leave_merge;
  		}
 -		strbuf_release(&buf);
  	}
  
  	/*
 @@ -2777,10 +2791,10 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  	    !commit->parents->next->next &&
  	    !oidcmp(&commit->parents->next->item->object.oid,
  		    &merge_commit->object.oid)) {
 -		strbuf_release(&ref_name);
  		rollback_lock_file(&lock);
 -		return fast_forward_to(&commit->object.oid,
 -				       &head_commit->object.oid, 0, opts);
 +		ret = fast_forward_to(&commit->object.oid,
 +				      &head_commit->object.oid, 0, opts);
 +		goto leave_merge;
  	}
  
  	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 @@ -2790,10 +2804,9 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  	bases = get_merge_bases(head_commit, merge_commit);
  	if (bases && !oidcmp(&merge_commit->object.oid,
  			     &bases->item->object.oid)) {
 -		strbuf_release(&ref_name);
 -		rollback_lock_file(&lock);
 +		ret = 0;
  		/* skip merging an ancestor of HEAD */
 -		return 0;
 +		goto leave_merge;
  	}
  
  	for (j = bases; j; j = j->next)
 @@ -2807,28 +2820,40 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  	o.buffer_output = 2;
  
  	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
 -	if (!ret)
 -		rerere(opts->allow_rerere_auto);
  	if (ret <= 0)
  		fputs(o.obuf.buf, stdout);
  	strbuf_release(&o.obuf);
  	if (ret < 0) {
 -		strbuf_release(&ref_name);
 -		rollback_lock_file(&lock);
 -		return error(_("conflicts while merging '%.*s'"),
 -			     merge_arg_len, arg);
 +		error(_("could not even attempt to merge '%.*s'"),
 +		      merge_arg_len, arg);
 +		goto leave_merge;
  	}
 +	/*
 +	 * The return value of merge_recursive() is 1 on clean, and 0 on
 +	 * unclean merge.
 +	 *
 +	 * Let's reverse that, so that do_merge() returns 0 upon success and
 +	 * 1 upon failed merge (keeping the return value -1 for the cases where
 +	 * we will want to reschedule the `merge` command).
 +	 */
 +	ret = !ret;
  
  	if (active_cache_changed &&
  	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
 -		strbuf_release(&ref_name);
 -		return error(_("merge: Unable to write new index file"));
 +		ret = error(_("merge: Unable to write new index file"));
 +		goto leave_merge;
  	}
 +
  	rollback_lock_file(&lock);
 +	if (ret)
 +		rerere(opts->allow_rerere_auto);
 +	else
 +		ret = run_git_commit(git_path_merge_msg(), opts,
 +				     run_commit_flags);
  
 -	ret = run_git_commit(git_path_merge_msg(), opts, run_commit_flags);
 +leave_merge:
  	strbuf_release(&ref_name);
 -
 +	rollback_lock_file(&lock);
  	return ret;
  }
  
 @@ -2922,6 +2947,17 @@ static const char *reflog_message(struct replay_opts *opts,
  	return buf.buf;
  }
  
 +static const char rescheduled_advice[] =
 +N_("Could not execute the todo command\n"
 +"\n"
 +"    %.*s"
 +"\n"
 +"It has been rescheduled; To edit the command before continuing, please\n"
 +"edit the todo list first:\n"
 +"\n"
 +"    git rebase --edit-todo\n"
 +"    git rebase --continue\n");
 +
  static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  {
  	int res = 0;
 @@ -2966,7 +3002,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			res = do_pick_commit(item->command, item->commit,
  					opts, is_final_fixup(todo_list));
  			if (is_rebase_i(opts) && res < 0) {
 -				/* Reschedule */
 +reschedule:
 +				advise(_(rescheduled_advice),
 +				       get_item_line_length(todo_list,
 +							    todo_list->current),
 +				       get_item_line(todo_list,
 +						     todo_list->current));
  				todo_list->current--;
  				if (save_todo(todo_list, opts))
  					return -1;
 @@ -2990,7 +3031,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  					intend_to_amend();
  				return error_failed_squash(item->commit, opts,
  					item->arg_len, item->arg);
 -			} else if (res && is_rebase_i(opts))
 +			} else if (res && is_rebase_i(opts) && item->commit)
  				return res | error_with_patch(item->commit,
  					item->arg, item->arg_len, opts, res,
  					item->command == TODO_REWORD);
 @@ -3016,13 +3057,17 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  				/* `current` will be incremented below */
  				todo_list->current = -1;
  			}
 -		} else if (item->command == TODO_LABEL)
 -			res = do_label(item->arg, item->arg_len);
 -		else if (item->command == TODO_RESET)
 -			res = do_reset(item->arg, item->arg_len, opts);
 -		else if (item->command == TODO_MERGE) {
 +		} else if (item->command == TODO_LABEL) {
 +			if ((res = do_label(item->arg, item->arg_len)))
 +				goto reschedule;
 +		} else if (item->command == TODO_RESET) {
 +			if ((res = do_reset(item->arg, item->arg_len, opts)))
 +				goto reschedule;
 +		} else if (item->command == TODO_MERGE) {
  			res = do_merge(item->commit, item->arg, item->arg_len,
  				       item->flags, opts);
 +			if (res < 0)
 +				goto reschedule;
  			if (item->commit)
  				record_in_rewritten(&item->commit->object.oid,
  						    peek_command(todo_list, 1));
 @@ -4046,8 +4091,7 @@ int skip_unnecessary_picks(void)
  		oid = &item->commit->object.oid;
  	}
  	if (i > 0) {
 -		int offset = i < todo_list.nr ?
 -			todo_list.items[i].offset_in_buf : todo_list.buf.len;
 +		int offset = get_item_line_offset(&todo_list, i);
  		const char *done_path = rebase_path_done();
  
  		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
 @@ -4227,12 +4271,10 @@ int rearrange_squash(void)
  				continue;
  
  			while (cur >= 0) {
 -				int offset = todo_list.items[cur].offset_in_buf;
 -				int end_offset = cur + 1 < todo_list.nr ?
 -					todo_list.items[cur + 1].offset_in_buf :
 -					todo_list.buf.len;
 -				char *bol = todo_list.buf.buf + offset;
 -				char *eol = todo_list.buf.buf + end_offset;
 +				const char *bol =
 +					get_item_line(&todo_list, cur);
 +				const char *eol =
 +					get_item_line(&todo_list, cur + 1);
  
  				/* replace 'pick', by 'fixup' or 'squash' */
  				command = todo_list.items[cur].command;
 diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
 index ee006810573..f2de7059830 100755
 --- a/t/t3430-rebase-merges.sh
 +++ b/t/t3430-rebase-merges.sh
 @@ -52,25 +52,24 @@ test_expect_success 'setup' '
  	git tag -m H H
  '
  
 -cat >script-from-scratch <<\EOF
 -label onto
 -
 -# onebranch
 -pick G
 -pick D
 -label onebranch
 +test_expect_success 'create completely different structure' '
 +	cat >script-from-scratch <<-\EOF &&
 +	label onto
  
 -# second
 -reset onto
 -pick B
 -label second
 +	# onebranch
 +	pick G
 +	pick D
 +	label onebranch
  
 -reset onto
 -merge -C H second
 -merge onebranch # Merge the topic branch 'onebranch'
 -EOF
 +	# second
 +	reset onto
 +	pick B
 +	label second
  
 -test_expect_success 'create completely different structure' '
 +	reset onto
 +	merge -C H second
 +	merge onebranch # Merge the topic branch '\''onebranch'\''
 +	EOF
  	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
  	test_tick &&
  	git rebase -i -r A &&
 @@ -115,6 +114,17 @@ test_expect_success 'generate correct todo list' '
  	test_cmp expect output
  '
  
 +test_expect_success '`reset` refuses to overwrite untracked files' '
 +	git checkout -b refuse-to-reset &&
 +	test_commit dont-overwrite-untracked &&
 +	git checkout @{-1} &&
 +	: >dont-overwrite-untracked.t &&
 +	echo "reset refs/tags/dont-overwrite-untracked" >script-from-scratch &&
 +	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 +	test_must_fail git rebase -r HEAD &&
 +	git rebase --abort
 +'
 +
  test_expect_success 'with a branch tip that was cherry-picked already' '
  	git checkout -b already-upstream master &&
  	base="$(git rev-parse --verify HEAD)" &&
-- 
2.17.0.windows.1.4.g7e4058d72e3

