Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64317209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 17:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbcJJRYs (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:24:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:56378 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752232AbcJJRYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:24:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mda8q-1bWUDL2GLM-00PLSd; Mon, 10 Oct 2016 19:24:16
 +0200
Date:   Mon, 10 Oct 2016 19:24:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 00/25] Prepare the sequencer for the upcoming rebase -i
 patches
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0JTiqDEZtirjzT4B2p1P3/3E33xB6zUvqcSbgXXkAnNdbXchnX4
 wtVmTPOJbz+5qM/YJJYVFVpYODOd36Sn9X2TUSOUa0B93dEy8d4U+6o/WuogPBt9fsF/Iav
 qI6SpbK/OEESNZ4ehXX++50GPTsFHrNAg/YDzoIZ4yGsEFLyAyAqzyJpLfumZWtlAjHnkMl
 RyGArVkCDrVfDs/riKeoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3diFMf7e6HI=:FiodlCmz3Jdr9hXGe7yJ2t
 J7kyIAuPj06rpCBjbxWge/u80W+ZNnTsfxOPeh1copPlZwNGA761F5dnmJGD6Ohr5MyUro54X
 SQb3t6SYBrnvvhPR4nPNtauEBM8x0b25hb9qsqPdFJrTkR3XTn3w9F52k/xzt667uPgZ0hd99
 pivlDg/ASKV+CPkK7PY2aCy6pPONm33/DI3sgYH8G6RmXf7NcUSo9dJL/aSMMDXkxDpO4XSwd
 KpkxezOuroZVim/UuE/SEX8/qVUx3a9jOzV/7kVqmu1tlPCdE1atB3A/QNI7A18sEQ17iU/VK
 hXKjgPGEWc9aMc6iddSnajw0c0XF5WYxzNRa+RQvTDrRoUZdK2/OKofnVAUAEObquZwKzGAe5
 EtXRo+9qCFOPRxZY/AS/bL9pM6kJE2WuX4ZD/A/HTNAjod0u1t12+ydUUWAchP6VbvrQYTbfq
 LadwIv2bNXftbSE23wERBtJhBApTDoHd7k5TYXHAic9RSg02Ibb3XiqkQITOLDnRKI7jgaoMb
 lZYtc1Xi8ns13xEorvvqtyhssfhS5PLG3wsKdJ3Lk07dTC3fh2gu8eV/rdETZzlKgfY+a10hk
 nkmVPP4RALNY4o8RL7PSCd0N5tKV/zhT/vkobvnjzBh4rKzo9H19rF7L1135fYevTGnubxv5j
 qJiGcHQxt7I+cHKSSrVP41mENeehnl8HvgLXBQhulxsaf5QlvF55PsIYpr4wpfNMYcPHH4rEq
 8QSX8YCB898MGpJ+goQch60kcafVQzmMjn7cJF4BJ8g85dqXmgMFlAbSAPJTHOtcfo4uw3O72
 wgmuyC+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series marks the  '4' in the countdown to speed up rebase -i
by implementing large parts in C. It is based on the `libify-sequencer`
patch series that I submitted last week.

The patches in this series merely prepare the sequencer code for the
next patch series that actually teaches the sequencer to run an
interactive rebase.

The reason to split these two patch series is simple: to keep them at a
sensible size.

The two patch series after that are much smaller: a two-patch "series"
that switches rebase -i to use the sequencer (except with --root or
--preserve-merges), and a couple of patches to move several pretty
expensive script processing steps to C (think: autosquash).

The end game of this patch series is a git-rebase--helper that makes
rebase -i 5x faster on Windows (according to t/perf/p3404). Travis says
that even MacOSX and Linux benefit (4x and 3x, respectively).

I have been working on this since early February, whenever time allowed,
and it is time to put it into the users' hands. To that end, I will most
likely submit the remaining three patch series in the next two days, and
integrate the whole shebang into Git for Windows 2.10.0.

Therefore I would be most grateful for every in-depth review.

Changes vs v2:

- dramatically simplified the logic to retain do_recursive_merge()'s
  return value, even when positive (indicating merge conflicts).

- ensured that write_message() rolls back locked files in case of
  errors.

- added a patch to downcase all first letters of sequencer's error
  messages, as suggested by Junio.

- replaced 25/25 ("sequencer: remove bogus hint for translators") by a
  fix to 8/25 ("completely revamp todo parsing"): the first %s is no
  longer "revert" or "cherry-pick", but a "todo" command.

- backed out the sequencer_entrust() function and uglified the code to
  always duplicate the option values for the sake of being able to
  properly releasing them afterwards.

- CR/LFs are now handled like LFs in todo scripts: they are stripped
  (thanks to Hannes Sixt for pointing that out).

- unexported sequencer_commit() (it can safely remain a static
  function). While at it, renamed it back to run_git_commit() (the
  unspecific name does not hurt if it remains private to sequencer.c).

- clarified in a code comment what read_author_script() does.

- marked for translation the last remaining error message in sequencer.c
  that was not yet marked for translation.


Johannes Schindelin (25):
  sequencer: use static initializers for replay_opts
  sequencer: use memoized sequencer directory path
  sequencer: avoid unnecessary indirection
  sequencer: future-proof remove_sequencer_state()
  sequencer: eventually release memory allocated for the option values
  sequencer: future-proof read_populate_todo()
  sequencer: completely revamp the "todo" script parsing
  sequencer: strip CR from the todo script
  sequencer: avoid completely different messages for different actions
  sequencer: get rid of the subcommand field
  sequencer: refactor the code to obtain a short commit name
  sequencer: remember the onelines when parsing the todo file
  sequencer: prepare for rebase -i's commit functionality
  sequencer: introduce a helper to read files written by scripts
  sequencer: allow editing the commit message on a case-by-case basis
  sequencer: support amending commits
  sequencer: support cleaning up commit messages
  sequencer: do not try to commit when there were merge conflicts
  sequencer: left-trim lines read from the script
  sequencer: refactor write_message()
  sequencer: remove overzealous assumption in rebase -i mode
  sequencer: mark action_name() for translation
  sequencer: quote filenames in error messages
  sequencer: start error messages consistently with lower case
  sequencer: mark all error messages for translation

 builtin/commit.c              |   2 +-
 builtin/revert.c              |  48 +--
 sequencer.c                   | 690 ++++++++++++++++++++++++++++--------------
 sequencer.h                   |  23 +-
 t/t3501-revert-cherry-pick.sh |   2 +-
 5 files changed, 503 insertions(+), 262 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/prepare-sequencer-v3
Fetch-It-Via: git fetch https://github.com/dscho/git prepare-sequencer-v3

Interdiff vs v2:

 diff --git a/builtin/revert.c b/builtin/revert.c
 index c9ae4dc..0a7b5f4 100644
 --- a/builtin/revert.c
 +++ b/builtin/revert.c
 @@ -165,6 +165,12 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
  	if (argc > 1)
  		usage_with_options(usage_str, options);
  
 +	/* These option values will be free()d */
 +	if (opts->gpg_sign)
 +		opts->gpg_sign = xstrdup(opts->gpg_sign);
 +	if (opts->strategy)
 +		opts->strategy = xstrdup(opts->strategy);
 +
  	if (cmd == 'q')
  		return sequencer_remove_state(opts);
  	if (cmd == 'c')
 diff --git a/sequencer.c b/sequencer.c
 index cdff0f1..86d86ce 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -148,23 +148,15 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
  	return buf.buf;
  }
  
 -void *sequencer_entrust(struct replay_opts *opts, void *to_free)
 -{
 -	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
 -	opts->owned[opts->owned_nr++] = to_free;
 -
 -	return to_free;
 -}
 -
  int sequencer_remove_state(struct replay_opts *opts)
  {
  	struct strbuf dir = STRBUF_INIT;
  	int i;
  
 -	for (i = 0; i < opts->owned_nr; i++)
 -		free(opts->owned[i]);
 -	free(opts->owned);
 -
 +	free(opts->gpg_sign);
 +	free(opts->strategy);
 +	for (i = 0; i < opts->xopts_nr; i++)
 +		free(opts->xopts[i]);
  	free(opts->xopts);
  
  	strbuf_addf(&dir, "%s", get_dir(opts));
 @@ -249,13 +241,19 @@ static int write_with_lock_file(const char *filename,
  
  	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
  	if (msg_fd < 0)
 -		return error_errno(_("Could not lock '%s'"), filename);
 -	if (write_in_full(msg_fd, buf, len) < 0)
 -		return error_errno(_("Could not write to '%s'"), filename);
 -	if (append_eol && write(msg_fd, "\n", 1) < 0)
 -		return error_errno(_("Could not write eol to '%s"), filename);
 -	if (commit_lock_file(&msg_file) < 0)
 -		return error(_("Error wrapping up '%s'."), filename);
 +		return error_errno(_("could not lock '%s'"), filename);
 +	if (write_in_full(msg_fd, buf, len) < 0) {
 +		rollback_lock_file(&msg_file);
 +		return error_errno(_("could not write to '%s'"), filename);
 +	}
 +	if (append_eol && write(msg_fd, "\n", 1) < 0) {
 +		rollback_lock_file(&msg_file);
 +		return error_errno(_("could not write eol to '%s"), filename);
 +	}
 +	if (commit_lock_file(&msg_file) < 0) {
 +		rollback_lock_file(&msg_file);
 +		return error(_("failed to finalize '%s'."), filename);
 +	}
  
  	return 0;
  }
 @@ -288,7 +286,7 @@ static int read_oneliner(struct strbuf *buf,
  		return 0;
  
  	if (strbuf_read_file(buf, path, 0) < 0) {
 -		warning_errno("could not read '%s'", path);
 +		warning_errno(_("could not read '%s'"), path);
  		return 0;
  	}
  
 @@ -314,11 +312,11 @@ static int error_dirty_index(struct replay_opts *opts)
  	if (read_cache_unmerged())
  		return error_resolve_conflict(_(action_name(opts)));
  
 -	error(_("Your local changes would be overwritten by %s."),
 +	error(_("your local changes would be overwritten by %s."),
  		_(action_name(opts)));
  
  	if (advice_commit_before_merge)
 -		advise(_("Commit your changes or stash them to proceed."));
 +		advise(_("commit your changes or stash them to proceed."));
  	return -1;
  }
  
 @@ -379,7 +377,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  	struct merge_options o;
  	struct tree *result, *next_tree, *base_tree, *head_tree;
  	int clean;
 -	const char **xopt;
 +	char **xopt;
  	static struct lock_file index_lock;
  
  	hold_locked_index(&index_lock, 1);
 @@ -427,7 +425,7 @@ static int is_index_unchanged(void)
  	struct commit *head_commit;
  
  	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
 -		return error(_("Could not resolve HEAD commit\n"));
 +		return error(_("could not resolve HEAD commit\n"));
  
  	head_commit = lookup_commit(head_sha1);
  
 @@ -447,11 +445,15 @@ static int is_index_unchanged(void)
  
  	if (!cache_tree_fully_valid(active_cache_tree))
  		if (cache_tree_update(&the_index, 0))
 -			return error(_("Unable to update cache tree\n"));
 +			return error(_("unable to update cache tree\n"));
  
  	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
  }
  
 +/*
 + * Read the author-script file into an environment block, ready for use in
 + * run_command(), that can be free()d afterwards.
 + */
  static char **read_author_script(void)
  {
  	struct strbuf script = STRBUF_INIT;
 @@ -495,11 +497,11 @@ static char **read_author_script(void)
   * If we are revert, or if our cherry-pick results in a hand merge,
   * we had better say that the current user is responsible for that.
   *
 - * An exception is when sequencer_commit() is called during an
 + * An exception is when run_git_commit() is called during an
   * interactive rebase: in that case, we will want to retain the
   * author metadata.
   */
 -int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 +static int run_git_commit(const char *defmsg, struct replay_opts *opts,
  			  int allow_empty, int edit, int amend,
  			  int cleanup_commit_message)
  {
 @@ -513,16 +515,19 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
  		if (!env) {
  			const char *gpg_opt = gpg_sign_opt_quoted(opts);
  
 -			return error("You have staged changes in your working "
 -				"tree. If these changes are meant to be\n"
 -				"squashed into the previous commit, run:\n\n"
 -				"  git commit --amend %s\n\n"
 -				"If they are meant to go into a new commit, "
 -				"run:\n\n"
 -				"  git commit %s\n\n"
 -				"In both cases, once you're done, continue "
 -				"with:\n\n"
 -				"  git rebase --continue\n", gpg_opt, gpg_opt);
 +			return error(_("you have staged changes in your "
 +				       "working tree. If these changes are "
 +				       "meant to be\n"
 +				       "squashed into the previous commit, "
 +				       "run:\n\n"
 +				       "  git commit --amend %s\n\n"
 +				       "If they are meant to go into a new "
 +				       "commit, run:\n\n"
 +				       "  git commit %s\n\n"
 +				       "In both cases, once you're done, "
 +				       "continue with:\n\n"
 +				       "  git rebase --continue\n"),
 +				     gpg_opt, gpg_opt);
  		}
  	}
  
 @@ -566,12 +571,12 @@ static int is_original_commit_empty(struct commit *commit)
  	const unsigned char *ptree_sha1;
  
  	if (parse_commit(commit))
 -		return error(_("Could not parse commit %s\n"),
 +		return error(_("could not parse commit %s\n"),
  			     oid_to_hex(&commit->object.oid));
  	if (commit->parents) {
  		struct commit *parent = commit->parents->item;
  		if (parse_commit(parent))
 -			return error(_("Could not parse parent commit %s\n"),
 +			return error(_("could not parse parent commit %s\n"),
  				oid_to_hex(&parent->object.oid));
  		ptree_sha1 = parent->tree->object.oid.hash;
  	} else {
 @@ -645,7 +650,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  	const char *base_label, *next_label;
  	struct commit_message msg = { NULL, NULL, NULL, NULL };
  	struct strbuf msgbuf = STRBUF_INIT;
 -	int res = 0, unborn = 0, allow;
 +	int res, unborn = 0, allow;
  
  	if (opts->no_commit) {
  		/*
 @@ -655,7 +660,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		 * to work on.
  		 */
  		if (write_cache_as_tree(head, 0, NULL))
 -			return error(_("Your index file is unmerged."));
 +			return error(_("your index file is unmerged."));
  	} else {
  		unborn = get_sha1("HEAD", head);
  		if (unborn)
 @@ -674,7 +679,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		struct commit_list *p;
  
  		if (!opts->mainline)
 -			return error(_("Commit %s is a merge but no -m option was given."),
 +			return error(_("commit %s is a merge but no -m option was given."),
  				oid_to_hex(&commit->object.oid));
  
  		for (cnt = 1, p = commit->parents;
 @@ -682,11 +687,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		     cnt++)
  			p = p->next;
  		if (cnt != opts->mainline || !p)
 -			return error(_("Commit %s does not have parent %d"),
 +			return error(_("commit %s does not have parent %d"),
  				oid_to_hex(&commit->object.oid), opts->mainline);
  		parent = p->item;
  	} else if (0 < opts->mainline)
 -		return error(_("Mainline was specified but commit %s is not a merge."),
 +		return error(_("mainline was specified but commit %s is not a merge."),
  			oid_to_hex(&commit->object.oid));
  	else
  		parent = commit->parents->item;
 @@ -697,12 +702,16 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
  
  	if (parent && parse_commit(parent) < 0)
 +		/*
 +		 * TRANSLATORS: The first %s will be a "todo" command like
 +		 * "revert" or "pick", the second %s a SHA1.
 +		 */
  		return error(_("%s: cannot parse parent commit %s"),
  			command_to_string(command),
  			oid_to_hex(&parent->object.oid));
  
  	if (get_message(commit, &msg) != 0)
 -		return error(_("Cannot get commit message for %s"),
 +		return error(_("cannot get commit message for %s"),
  			oid_to_hex(&commit->object.oid));
  
  	/*
 @@ -754,7 +763,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  	}
  
  	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 -		res |= do_recursive_merge(base, next, base_label, next_label,
 +		res = do_recursive_merge(base, next, base_label, next_label,
  					 head, &msgbuf, opts);
  		if (res < 0)
  			return res;
 @@ -763,11 +772,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  		struct commit_list *common = NULL;
  		struct commit_list *remotes = NULL;
  
 -		res |= write_message(&msgbuf, git_path_merge_msg());
 +		res = write_message(&msgbuf, git_path_merge_msg());
  
  		commit_list_insert(base, &common);
  		commit_list_insert(next, &remotes);
 -		res |= try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
 +		res |= try_merge_command(opts->strategy,
 +					 opts->xopts_nr, (const char **)opts->xopts,
  					common, sha1_to_hex(head), remotes);
  		free_commit_list(common);
  		free_commit_list(remotes);
 @@ -800,13 +810,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  
  	allow = allow_empty(opts, commit);
  	if (allow < 0) {
 -		res |= allow;
 +		res = allow;
  		goto leave;
  	}
 -	if (!opts->no_commit)
 -		res |= sequencer_commit(opts->edit ?
 -				NULL : git_path_merge_msg(),
 -			opts, allow, opts->edit, 0, 0);
 +	if (!res && !opts->no_commit)
 +		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
 +				     opts, allow, opts->edit, 0, 0);
  
  leave:
  	free_message(commit, &msg);
 @@ -924,23 +933,27 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
  {
  	struct todo_item *item;
 -	char *p = buf;
 +	char *p = buf, *next_p;
  	int i, res = 0;
  
 -	for (i = 1; *p; i++) {
 +	for (i = 1; *p; i++, p = next_p) {
  		char *eol = strchrnul(p, '\n');
  
 +		next_p = *eol ? eol + 1 /* skip LF */ : eol;
 +
 +		if (p != eol && eol[-1] == '\r')
 +			eol--; /* skip Carriage Return */
 +
  		item = append_new_todo(todo_list);
  		item->offset_in_buf = p - todo_list->buf.buf;
  		if (parse_insn_line(item, p, eol)) {
 -			res |= error(_("Invalid line %d: %.*s"),
 +			res = error(_("invalid line %d: %.*s"),
  				i, (int)(eol - p), p);
  			item->command = -1;
  		}
 -		p = *eol ? eol + 1 : eol;
  	}
  	if (!todo_list->nr)
 -		return error(_("No commits parsed."));
 +		return error(_("no commits parsed."));
  	return res;
  }
  
 @@ -953,16 +966,16 @@ static int read_populate_todo(struct todo_list *todo_list,
  	strbuf_reset(&todo_list->buf);
  	fd = open(todo_file, O_RDONLY);
  	if (fd < 0)
 -		return error_errno(_("Could not open '%s'"), todo_file);
 +		return error_errno(_("could not open '%s'"), todo_file);
  	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
  		close(fd);
 -		return error(_("Could not read '%s'."), todo_file);
 +		return error(_("could not read '%s'."), todo_file);
  	}
  	close(fd);
  
  	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
  	if (res)
 -		return error(_("Unusable instruction sheet: '%s'"), todo_file);
 +		return error(_("unusable instruction sheet: '%s'"), todo_file);
  
  	if (!is_rebase_i(opts)) {
  		enum todo_command valid =
 @@ -973,9 +986,9 @@ static int read_populate_todo(struct todo_list *todo_list,
  			if (valid == todo_list->items[i].command)
  				continue;
  			else if (valid == TODO_PICK)
 -				return error(_("Cannot cherry-pick during a revert."));
 +				return error(_("cannot cherry-pick during a revert."));
  			else
 -				return error(_("Cannot revert during a cherry-pick."));
 +				return error(_("cannot revert during a cherry-pick."));
  	}
  
  	return 0;
 @@ -1001,22 +1014,29 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
  	else if (!strcmp(key, "options.mainline"))
  		opts->mainline = git_config_int(key, value);
  	else if (!strcmp(key, "options.strategy")) {
 -		git_config_string(&opts->strategy, key, value);
 -		sequencer_entrust(opts, (char *) opts->strategy);
 +		if (!value)
 +			config_error_nonbool(key);
 +		else {
 +			free(opts->strategy);
 +			opts->strategy = xstrdup(value);
 +		}
  	}
  	else if (!strcmp(key, "options.gpg-sign")) {
 -		git_config_string(&opts->gpg_sign, key, value);
 -		sequencer_entrust(opts, (char *) opts->gpg_sign);
 +		if (!value)
 +			config_error_nonbool(key);
 +		else {
 +			free(opts->gpg_sign);
 +			opts->gpg_sign = xstrdup(value);
 +		}
  	}
  	else if (!strcmp(key, "options.strategy-option")) {
  		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 -		opts->xopts[opts->xopts_nr++] =
 -			sequencer_entrust(opts, xstrdup(value));
 +		opts->xopts[opts->xopts_nr++] = xstrdup(value);
  	} else
 -		return error(_("Invalid key: %s"), key);
 +		return error(_("invalid key: %s"), key);
  
  	if (!error_flag)
 -		return error(_("Invalid value for %s: %s"), key, value);
 +		return error(_("invalid value for %s: %s"), key, value);
  
  	return 0;
  }
 @@ -1030,11 +1050,11 @@ static int read_populate_opts(struct replay_opts *opts)
  			if (!starts_with(buf.buf, "-S"))
  				strbuf_reset(&buf);
  			else {
 -				opts->gpg_sign = buf.buf + 2;
 -				sequencer_entrust(opts,
 -					strbuf_detach(&buf, NULL));
 +				free(opts->gpg_sign);
 +				opts->gpg_sign = xstrdup(buf.buf + 2);
  			}
  		}
 +		strbuf_release(&buf);
  
  		return 0;
  	}
 @@ -1048,7 +1068,7 @@ static int read_populate_opts(struct replay_opts *opts)
  	 * are pretty certain that it is syntactically correct.
  	 */
  	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
 -		return error(_("Malformed options sheet: '%s'"),
 +		return error(_("malformed options sheet: '%s'"),
  			git_path_opts_file());
  	return 0;
  }
 @@ -1091,7 +1111,7 @@ static int create_seq_dir(void)
  		return -1;
  	}
  	else if (mkdir(git_path_seq_dir(), 0777) < 0)
 -		return error_errno(_("Could not create sequencer directory '%s'"),
 +		return error_errno(_("could not create sequencer directory '%s'"),
  				   git_path_seq_dir());
  	return 0;
  }
 @@ -1105,17 +1125,17 @@ static int save_head(const char *head)
  	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
  	if (fd < 0) {
  		rollback_lock_file(&head_lock);
 -		return error_errno(_("Could not lock HEAD"));
 +		return error_errno(_("could not lock HEAD"));
  	}
  	strbuf_addf(&buf, "%s\n", head);
  	if (write_in_full(fd, buf.buf, buf.len) < 0) {
  		rollback_lock_file(&head_lock);
 -		return error_errno(_("Could not write to '%s'"),
 +		return error_errno(_("could not write to '%s'"),
  				   git_path_head_file());
  	}
  	if (commit_lock_file(&head_lock) < 0) {
  		rollback_lock_file(&head_lock);
 -		return error(_("Error wrapping up '%s'."), git_path_head_file());
 +		return error(_("failed to finalize '%s'."), git_path_head_file());
  	}
  	return 0;
  }
 @@ -1194,14 +1214,14 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
  
  	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
  	if (fd < 0)
 -		return error_errno(_("Could not lock '%s'"), todo_path);
 +		return error_errno(_("could not lock '%s'"), todo_path);
  	offset = next < todo_list->nr ?
  		todo_list->items[next].offset_in_buf : todo_list->buf.len;
  	if (write_in_full(fd, todo_list->buf.buf + offset,
  			todo_list->buf.len - offset) < 0)
 -		return error_errno(_("Could not write to '%s'"), todo_path);
 +		return error_errno(_("could not write to '%s'"), todo_path);
  	if (commit_lock_file(&todo_lock) < 0)
 -		return error(_("Error wrapping up '%s'."), todo_path);
 +		return error(_("failed to finalize '%s'."), todo_path);
  	return 0;
  }
  
 @@ -1376,7 +1396,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
  			create_seq_dir() < 0)
  		return -1;
  	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
 -		return error(_("Can't revert as initial commit"));
 +		return error(_("can't revert as initial commit"));
  	if (save_head(sha1_to_hex(sha1)))
  		return -1;
  	if (save_opts(opts))
 diff --git a/sequencer.h b/sequencer.h
 index 688fff1..7a513c5 100644
 --- a/sequencer.h
 +++ b/sequencer.h
 @@ -26,37 +26,23 @@ struct replay_opts {
  
  	int mainline;
  
 -	const char *gpg_sign;
 +	char *gpg_sign;
  
  	/* Merge strategy */
 -	const char *strategy;
 -	const char **xopts;
 +	char *strategy;
 +	char **xopts;
  	size_t xopts_nr, xopts_alloc;
  
  	/* Only used by REPLAY_NONE */
  	struct rev_info *revs;
 -
 -	/* malloc()ed data entrusted to the sequencer */
 -	void **owned;
 -	int owned_nr, owned_alloc;
  };
  #define REPLAY_OPTS_INIT { -1 }
  
 -/*
 - * Make it the duty of sequencer_remove_state() to release the memory;
 - * For ease of use, return the same pointer.
 - */
 -void *sequencer_entrust(struct replay_opts *opts, void *to_free);
 -
  int sequencer_pick_revisions(struct replay_opts *opts);
  int sequencer_continue(struct replay_opts *opts);
  int sequencer_rollback(struct replay_opts *opts);
  int sequencer_remove_state(struct replay_opts *opts);
  
 -int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 -			  int allow_empty, int edit, int amend,
 -			  int cleanup_commit_message);
 -
  extern const char sign_off_header[];
  
  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
 diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
 index 51f3bbb..394f000 100755
 --- a/t/t3501-revert-cherry-pick.sh
 +++ b/t/t3501-revert-cherry-pick.sh
 @@ -96,7 +96,7 @@ test_expect_success 'revert forbidden on dirty working tree' '
  	echo content >extra_file &&
  	git add extra_file &&
  	test_must_fail git revert HEAD 2>errors &&
 -	test_i18ngrep "Your local changes would be overwritten by " errors
 +	test_i18ngrep "your local changes would be overwritten by " errors
  
  '
  

-- 
2.10.0.windows.1.325.ge6089c1

base-commit: a23ca1b8dc42ffd4de2ef30d67ce1e21ded29886
