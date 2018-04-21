Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF041F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDUKaO (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:30:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:59229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeDUKaM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:30:12 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjvV7-1eYJAQ0vdp-00bs7W; Sat, 21
 Apr 2018 12:30:03 +0200
Date:   Sat, 21 Apr 2018 12:29:46 +0200 (DST)
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
Subject: [PATCH v8 00/16] rebase -i: offer to recreate commit topology by
 rebasing merges
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524306546.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0s2wo6KUAzwvDhIkbz7601OTfNQfq7KAQLPCYCsxqvUmIOjXhSb
 unXPGG3UFP9SOZ6QBcv6ALAj0Wf2Ueuv606Ez1A3wrUL8mOmh52s+NtCI78yKMrw851Kt92
 G2HEjiqbvcjuj3N2PItO/D3xluRMzqb8XK0x0ZzF1TDjH8s3FgcIGmR0D8cMazLycEkrUAv
 bmDSsooo9AAYL8a1GveVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tAkuYUZUWTs=:4KPeyY7t0lR7vuzI4pZo0e
 HuG47OOdVSpdDR4XErS0v5JbknaPTwVuHq10e6qBiAv9W0rxz0vnFqE6pd2UUpVMnz3G+cudc
 6z1cgAy3k/Ry12ow/7AWkmVTaHlPSN8yfdg7HK4qxshMoLZ5C9fSZOfonx9tpd7ARxwXiTPfu
 xkAmARvDUuvdEr9mshwtZXyYcnU/UgJhWu5+sa7uW3eCMh3auhg2lHzaC/z+r/xqtiwnH1Zg8
 b0hiw/HGJf48jcpBgk7D5RMO4ZCgepDfVn+IuDd1jQ5qbYLxxWBZoKM+s30JU9wqHwmXgE+B9
 /5Dyd/vqbYdMaaTiEsICWBU9qFa4k3P4afz1es41ZxUPKB/Npd67do0cSsFhv+ISY1Dxr7kOY
 9AR4dm8KusTb5hgwBupa6WtUPIU0t9bNmDzzChpPzUzrEJ3RREMMTo93maEc0PMTHz+4mBxVP
 KhAUAftmgFFfBCuqhpMN2UO8056Ok/YvEhCbhdgLv08hrDkP/QGay05fa1aqpY4VgLeGn07MQ
 1RMW1mGj89E+GOp788QiVY/G0hRGQ0rA9Rb0Wrl3fQbEPOXiUbRtzivKrash95pJvZ6z373en
 Rs7Ggw8T6I2MTUZ5BaQUigNGR9upg7rOJ5SijgOM0u9MM6x2EBgqWq2XYAt7AB/4IqLPfOShK
 kglPRjC14siyK0fvk3OE18PqYxc7SkczNr+56k2KpMHzYI0+WbVsAu2NQ8qMkhcok/6HKagW6
 yyTf8DzYLYHo/wYzWl2Clr2rSqpy5wsD8jy+oAvucQUuKh+TMW5qA7p2oqxTQGNkcBNMgbpms
 mmiNyE6giuTm1WXUoNBzY1I6t6wyAusmf4xiw8X2N5FBFu6l50=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, I think this is now ready for `next`. Thank you for your patience
and help with this.

Once upon a time, I dreamed of an interactive rebase that would not
linearize all patches and drop all merge commits, but instead recreate
the commit topology faithfully.

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

Changes since v7:

- Touched up all the documentation (it was a mistake to copy-edit the
  --preserve-merges description, for example).

- Disentangled the rescheduling of label/reset/merge from the one of the
  pick/fixup/squash code path (thanks Phillip!).

- When the merge failed, we now write out .git/rebase-merge/patch.

- An `exec git cherry-pick` or `exec git revert` will no longer mess
  with refs/rewritten/ in sequencer_remove_state() (d'oh....).


Johannes Schindelin (14):
  sequencer: avoid using errno clobbered by rollback_lock_file()
  sequencer: make rearrange_squash() a bit more obvious
  sequencer: refactor how original todo list lines are accessed
  sequencer: offer helpful advice when a command was rescheduled
  sequencer: introduce the `merge` command
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
 Documentation/git-pull.txt             |   6 +-
 Documentation/git-rebase.txt           | 160 ++++-
 builtin/pull.c                         |  14 +-
 builtin/rebase--helper.c               |  13 +-
 builtin/remote.c                       |  18 +-
 contrib/completion/git-completion.bash |   4 +-
 git-rebase--interactive.sh             |  22 +-
 git-rebase.sh                          |  16 +
 refs.c                                 |   3 +-
 sequencer.c                            | 891 +++++++++++++++++++++++--
 sequencer.h                            |   7 +
 t/t3421-rebase-topology-linear.sh      |   1 +
 t/t3430-rebase-merges.sh               | 244 +++++++
 14 files changed, 1347 insertions(+), 60 deletions(-)
 create mode 100755 t/t3430-rebase-merges.sh


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v8
Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v8

Interdiff vs v7:
 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index da46f154bb3..d6bcb5dcb67 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1059,8 +1059,8 @@ branch.<name>.rebase::
  	branch-specific manner.
  +
  When `merges`, pass the `--rebase-merges` option to 'git rebase'
 -so that locally committed merge commits will not be flattened
 -by running 'git pull'.
 +so that the local merge commits are included in the rebase (see
 +linkgit:git-rebase[1] for details).
  +
  When preserve, also pass `--preserve-merges` along to 'git rebase'
  so that locally committed merge commits will not be flattened
 @@ -2622,8 +2622,8 @@ pull.rebase::
  	per-branch basis.
  +
  When `merges`, pass the `--rebase-merges` option to 'git rebase'
 -so that locally committed merge commits will not be flattened
 -by running 'git pull'.
 +so that the local merge commits are included in the rebase (see
 +linkgit:git-rebase[1] for details).
  +
  When preserve, also pass `--preserve-merges` along to 'git rebase'
  so that locally committed merge commits will not be flattened
 diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
 index 6f76d815dd3..4e0ad6fd8e0 100644
 --- a/Documentation/git-pull.txt
 +++ b/Documentation/git-pull.txt
 @@ -109,7 +109,8 @@ include::merge-options.txt[]
  	to avoid rebasing non-local changes.
  +
  When set to `merges`, rebase using `git rebase --rebase-merges` so that
 -locally created merge commits will not be flattened.
 +the local merge commits are included in the rebase (see
 +linkgit:git-rebase[1] for details).
  +
  When set to preserve, rebase with the `--preserve-merges` option passed
  to `git rebase` so that locally created merge commits will not be flattened.
 diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
 index 0ff83b62821..3b996e46d6a 100644
 --- a/Documentation/git-rebase.txt
 +++ b/Documentation/git-rebase.txt
 @@ -380,15 +380,25 @@ have the long commit hash prepended to the format.
  
  -r::
  --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
 -	Rebase merge commits instead of flattening the history by replaying
 -	merges. Merge conflict resolutions or manual amendments to merge
 -	commits are not rebased automatically, but have to be applied
 +	By default, a rebase will simply drop merge commits and only rebase
 +	the non-merge commits. With this option, it will try to preserve
 +	the branching structure within the commits that are to be rebased,
 +	by recreating the merge commits. If a merge commit resolved any merge
 +	or contained manual amendments, then they will have to be re-applied
  	manually.
  +
  By default, or when `no-rebase-cousins` was specified, commits which do not
  have `<upstream>` as direct ancestor will keep their original branch point.
 -If the `rebase-cousins` mode is turned on, such commits are rebased onto
 -`<upstream>` (or `<onto>`, if specified).
 +If the `rebase-cousins` mode is turned on, such commits are instead rebased
 +onto `<upstream>` (or `<onto>`, if specified).
 ++
 +This mode is similar in spirit to `--preserve-merges`, but in contrast to
 +that option works well in interactive rebases: commits can be reordered,
 +inserted and dropped at will.
 ++
 +It is currently only possible to recreate the merge commits using the
 +`recursive` merge strategy; Different merge strategies can be used only via
 +explicit `exec git merge -s <strategy> [...]` commands.
  +
  See also REBASING MERGES below.
  
 @@ -795,8 +805,9 @@ REBASING MERGES
  The interactive rebase command was originally designed to handle
  individual patch series. As such, it makes sense to exclude merge
  commits from the todo list, as the developer may have merged the
 -current `master` while working on the branch, only to eventually
 -rebase all the commits onto `master` (skipping the merge commits).
 +then-current `master` while working on the branch, only to rebase
 +all the commits onto `master` eventually (skipping the merge
 +commits).
  
  However, there are legitimate reasons why a developer may want to
  recreate merge commits: to keep the branch structure (or "commit
 @@ -846,21 +857,23 @@ merge -C a1b2c3 refactor-button # Merge 'refactor-button'
  merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
  ------------
  
 -In contrast to a regular interactive rebase, there are `label`, `reset` and
 -`merge` commands in addition to `pick` ones.
 +In contrast to a regular interactive rebase, there are `label`, `reset`
 +and `merge` commands in addition to `pick` ones.
  
  The `label` command associates a label with the current HEAD when that
  command is executed. These labels are created as worktree-local refs
  (`refs/rewritten/<label>`) that will be deleted when the rebase
  finishes. That way, rebase operations in multiple worktrees linked to
 -the same repository do not interfere with one another. If the `label` command
 -fails, it is rescheduled immediately, with a helpful message how to proceed.
 +the same repository do not interfere with one another. If the `label`
 +command fails, it is rescheduled immediately, with a helpful message how
 +to proceed.
  
 -The `reset` command is essentially a `git read-tree -m -u` (think: `git
 -reset --hard`, but refusing to overwrite untracked files) to the
 -specified revision (typically a previously-labeled one). If the `reset`
 -command fails, it is rescheduled immediately, with a helpful message how to
 -proceed.
 +The `reset` command resets the HEAD, index and worktree to the specified
 +revision. It is isimilar to an `exec git reset --hard <label>`, but
 +refuses to overwrite untracked files. If the `reset` command fails, it is
 +rescheduled immediately, with a helpful message how to edit the todo list
 +(this typically happens when a `reset` command was inserted into the todo
 +list manually and contains a typo).
  
  The `merge` command will merge the specified revision into whatever is
  HEAD at that time. With `-C <original-commit>`, the commit message of
 @@ -875,7 +888,7 @@ At this time, the `merge` command will *always* use the `recursive`
  merge strategy, with no way to choose a different one. To work around
  this, an `exec` command can be used to call `git merge` explicitly,
  using the fact that the labels are worktree-local refs (the ref
 -`refs/rewritten/onto` would correspond to the label `onto`).
 +`refs/rewritten/onto` would correspond to the label `onto`, for example).
  
  Note: the first command (`label onto`) labels the revision onto which
  the commits are rebased; The name `onto` is just a convention, as a nod
 @@ -925,7 +938,7 @@ The todo list presented by `--preserve-merges --interactive` does not
  represent the topology of the revision graph.  Editing commits and
  rewording their commit messages should work fine, but attempts to
  reorder commits tend to produce counterintuitive results. Use
 ---rebase-merges for a more faithful representation.
 +`--rebase-merges` in such scenarios instead.
  
  For example, an attempt to rearrange
  ------------
 diff --git a/sequencer.c b/sequencer.c
 index 3c7bb5d3fd8..9ffadbb3d3c 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -258,7 +258,8 @@ int sequencer_remove_state(struct replay_opts *opts)
  	struct strbuf buf = STRBUF_INIT;
  	int i;
  
 -	if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
 +	if (is_rebase_i(opts) &&
 +	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
  		char *p = buf.buf;
  		while (*p) {
  			char *eol = strchr(p, '\n');
 @@ -2960,7 +2961,7 @@ N_("Could not execute the todo command\n"
  
  static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  {
 -	int res = 0;
 +	int res = 0, reschedule = 0;
  
  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
  	if (opts->allow_ff)
 @@ -3002,7 +3003,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			res = do_pick_commit(item->command, item->commit,
  					opts, is_final_fixup(todo_list));
  			if (is_rebase_i(opts) && res < 0) {
 -reschedule:
 +				/* Reschedule */
  				advise(_(rescheduled_advice),
  				       get_item_line_length(todo_list,
  							    todo_list->current),
 @@ -3059,21 +3060,42 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			}
  		} else if (item->command == TODO_LABEL) {
  			if ((res = do_label(item->arg, item->arg_len)))
 -				goto reschedule;
 +				reschedule = 1;
  		} else if (item->command == TODO_RESET) {
  			if ((res = do_reset(item->arg, item->arg_len, opts)))
 -				goto reschedule;
 +				reschedule = 1;
  		} else if (item->command == TODO_MERGE) {
 -			res = do_merge(item->commit, item->arg, item->arg_len,
 -				       item->flags, opts);
 -			if (res < 0)
 -				goto reschedule;
 -			if (item->commit)
 +			if ((res = do_merge(item->commit,
 +					    item->arg, item->arg_len,
 +					    item->flags, opts)) < 0)
 +				reschedule = 1;
 +			else if (item->commit)
  				record_in_rewritten(&item->commit->object.oid,
  						    peek_command(todo_list, 1));
 +			if (res > 0)
 +				/* failed with merge conflicts */
 +				return error_with_patch(item->commit,
 +							item->arg,
 +							item->arg_len, opts,
 +							res, 0);
  		} else if (!is_noop(item->command))
  			return error(_("unknown command %d"), item->command);
  
 +		if (reschedule) {
 +			advise(_(rescheduled_advice),
 +			       get_item_line_length(todo_list,
 +						    todo_list->current),
 +			       get_item_line(todo_list, todo_list->current));
 +			todo_list->current--;
 +			if (save_todo(todo_list, opts))
 +				return -1;
 +			if (item->commit)
 +				return error_with_patch(item->commit,
 +							item->arg,
 +							item->arg_len, opts,
 +							res, 0);
 +		}
 +
  		todo_list->current++;
  		if (res)
  			return res;
 diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
 index f2de7059830..3d4dfdf7bec 100755
 --- a/t/t3430-rebase-merges.sh
 +++ b/t/t3430-rebase-merges.sh
 @@ -125,6 +125,29 @@ test_expect_success '`reset` refuses to overwrite untracked files' '
  	git rebase --abort
  '
  
 +test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
 +	test_when_finished "test_might_fail git rebase --abort" &&
 +	git checkout -b conflicting-merge A &&
 +
 +	: fail because of conflicting untracked file &&
 +	>G.t &&
 +	echo "merge -C H G" >script-from-scratch &&
 +	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 +	test_tick &&
 +	test_must_fail git rebase -ir HEAD &&
 +	grep "^merge -C .* G$" .git/rebase-merge/done &&
 +	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 +	test_path_is_file .git/rebase-merge/patch &&
 +
 +	: fail because of merge conflict &&
 +	rm G.t .git/rebase-merge/patch &&
 +	git reset --hard &&
 +	test_commit conflicting-G G.t not-G conflicting-G &&
 +	test_must_fail git rebase --continue &&
 +	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 +	test_path_is_file .git/rebase-merge/patch
 +'
 +
  test_expect_success 'with a branch tip that was cherry-picked already' '
  	git checkout -b already-upstream master &&
  	base="$(git rev-parse --verify HEAD)" &&
-- 
2.17.0.windows.1.15.gaa56ade3205

