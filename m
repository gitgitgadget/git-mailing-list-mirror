Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62841F424
	for <e@80x24.org>; Fri, 20 Apr 2018 09:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754267AbeDTJjp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 05:39:45 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:8148 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754170AbeDTJjn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 05:39:43 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 9SW2flnpQLjjA9SW3fXOhM; Fri, 20 Apr 2018 10:39:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524217180;
        bh=6eFsfOiH2UJV6tMLnJNh24c8ci65J++Umgft8JOgf0s=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dE+fkc2Hnmco683nNj2DrEHCDG25/59CzuYqhrdpLyGa7hg6W12+4/pOZacPj4i/u
         8s765oaTjXJ3wbh9K8Km3QUYfheWXaqD771yHmaYNrJfANjij18QR0cmveGJXjwKcH
         UX5i6VAD0Zow0dgUsOiUn8l8pTNi+SmM266+KkXA=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=k3s2tj-HojBvZ64-kRgA:9
 a=uC8Rb-qEAlX2qMB0:21 a=VGRm5YqpI8qMmDyD:21 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 06/17] sequencer: introduce new commands to reset the
 revision
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <cover.1523362469.git.johannes.schindelin@gmx.de>
 <cover.1524139900.git.johannes.schindelin@gmx.de>
 <77c08b61387057af1be57c2b50769651cc8ec898.1524139900.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <fa4d22ec-0c40-b7ec-6715-67507b15181d@talktalk.net>
Date:   Fri, 20 Apr 2018 10:39:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <77c08b61387057af1be57c2b50769651cc8ec898.1524139900.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE162cxVog4lYm6dug9KBcuT8PF40mlxrtgS50W14sw2hQqS3H4PHnxU1JicKFrqLVn2ZKrBg/qQBWJWWc/G00QrdGoR1rienxVedOG3/viqPT/uyaD+
 JTF5AVlZJcyGlAsm1VzNGA/NTZKabUfrCcqLvGbYe4Toq8bqhHMaoKBQl1ynwNoHYYkya91hYwdM02z5mXwDxt4WiIccNI01aeEmeEo0xA/O6S0kb1hPcUDr
 chFO8N6LSRABh/Fd8n7XfhFssdeSOluQrQ5if1cWRqpz8bs1UjvtYNRIAumN/GnYsPyNyCEsfWUlfRK9YzELDldoAh1XFO9MpMedMsLtM01Lsv5m1liRCa8+
 GGt3xDn8t0QvGjELUCWjyZADoMsZKATGPiQq9vahNFLam7PrDFwGqtr5HYbmMvsYirw3wq9HIwlOE7hAiou1s9Q6DQPnN4MHVUEbhMtbCmGMdE0MHS/fajSm
 K9bJpabCUqNpMAo63CFYTPjmdJ4Hes+OMH709XnADTyChHsfbeiw9vizkRwaR0WYjXJFH0qBoAJgCK/p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/04/18 13:20, Johannes Schindelin wrote:
> In the upcoming commits, we will teach the sequencer to rebase merges.
> This will be done in a very different way from the unfortunate design of
> `git rebase --preserve-merges` (which does not allow for reordering
> commits, or changing the branch topology).
> 
> The main idea is to introduce new todo list commands, to support
> labeling the current revision with a given name, resetting the current
> revision to a previous state, and  merging labeled revisions.
> 
> This idea was developed in Git for Windows' Git garden shears (that are
> used to maintain Git for Windows' "thicket of branches" on top of
> upstream Git), and this patch is part of the effort to make it available
> to a wider audience, as well as to make the entire process more robust
> (by implementing it in a safe and portable language rather than a Unix
> shell script).
> 
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
> 
> 	label <name>
> 	reset <name>
> 
> Internally, the `label <name>` command creates the ref
> `refs/rewritten/<name>`. This makes it possible to work with the labeled
> revisions interactively, or in a scripted fashion (e.g. via the todo
> list command `exec`).
> 
> These temporary refs are removed upon sequencer_remove_state(), so that
> even a `git rebase --abort` cleans them up.
> 
> We disallow '#' as label because that character will be used as separator
> in the upcoming `merge` command.
> 
> Later in this patch series, we will mark the `refs/rewritten/` refs as
> worktree-local, to allow for interactive rebases to be run in parallel in
> worktrees linked to the same repository.
> 
> As typos happen, a failed `label` or `reset` command will be rescheduled
> immediately. Note that this needs a little change in the original code to
> perform a reschedule: there is no commit from which to generate a patch
> here (and we will simply fall through to the regular `return res`). We
> keep that code path, though, because we will use it for the upcoming
> `merge` command, too.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh |   2 +
>  sequencer.c                | 201 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 196 insertions(+), 7 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index e1b865f43f2..e8d3a7d7588 100644
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
> index 01443e0f245..9e09026b594 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -23,6 +23,8 @@
>  #include "hashmap.h"
>  #include "notes-utils.h"
>  #include "sigchain.h"
> +#include "unpack-trees.h"
> +#include "worktree.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -120,6 +122,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
>  static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
>  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
>  	"rebase-merge/rewritten-pending")
> +
> +/*
> + * The path of the file listing refs that need to be deleted after the rebase
> + * finishes. This is used by the `label` command to record the need for cleanup.
> + */
> +static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
> +
>  /*
>   * The following files are written by git-rebase just after parsing the
>   * command-line (and are only consumed, not modified, by the sequencer).
> @@ -244,18 +253,33 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>  
>  int sequencer_remove_state(struct replay_opts *opts)
>  {
> -	struct strbuf dir = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
>  	int i;
>  
> +	if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
> +		char *p = buf.buf;
> +		while (*p) {
> +			char *eol = strchr(p, '\n');
> +			if (eol)
> +				*eol = '\0';
> +			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0)
> +				warning(_("could not delete '%s'"), p);
> +			if (!eol)
> +				break;
> +			p = eol + 1;
> +		}
> +	}
> +
>  	free(opts->gpg_sign);
>  	free(opts->strategy);
>  	for (i = 0; i < opts->xopts_nr; i++)
>  		free(opts->xopts[i]);
>  	free(opts->xopts);
>  
> -	strbuf_addstr(&dir, get_dir(opts));
> -	remove_dir_recursively(&dir, 0);
> -	strbuf_release(&dir);
> +	strbuf_reset(&buf);
> +	strbuf_addstr(&buf, get_dir(opts));
> +	remove_dir_recursively(&buf, 0);
> +	strbuf_release(&buf);
>  
>  	return 0;
>  }
> @@ -1279,6 +1303,8 @@ enum todo_command {
>  	TODO_SQUASH,
>  	/* commands that do something else than handling a single commit */
>  	TODO_EXEC,
> +	TODO_LABEL,
> +	TODO_RESET,
>  	/* commands that do nothing but are counted for reporting progress */
>  	TODO_NOOP,
>  	TODO_DROP,
> @@ -1297,6 +1323,8 @@ static struct {
>  	{ 'f', "fixup" },
>  	{ 's', "squash" },
>  	{ 'x', "exec" },
> +	{ 'l', "label" },
> +	{ 't', "reset" },
>  	{ 0,   "noop" },
>  	{ 'd', "drop" },
>  	{ 0,   NULL }
> @@ -1802,7 +1830,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>  		return error(_("missing arguments for %s"),
>  			     command_to_string(item->command));
>  
> -	if (item->command == TODO_EXEC) {
> +	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
> +	    item->command == TODO_RESET) {
>  		item->commit = NULL;
>  		item->arg = bol;
>  		item->arg_len = (int)(eol - bol);
> @@ -2465,6 +2494,158 @@ static int do_exec(const char *command_line)
>  	return status;
>  }
>  
> +static int safe_append(const char *filename, const char *fmt, ...)
> +{
> +	va_list ap;
> +	struct lock_file lock = LOCK_INIT;
> +	int fd = hold_lock_file_for_update(&lock, filename,
> +					   LOCK_REPORT_ON_ERROR);
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (fd < 0)
> +		return -1;
> +
> +	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT) {
> +		error_errno(_("could not read '%s'"), filename);
> +		rollback_lock_file(&lock);
> +		return -1;
> +	}
> +	strbuf_complete(&buf, '\n');
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&buf, fmt, ap);
> +	va_end(ap);
> +
> +	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +		error_errno(_("could not write to '%s'"), filename);
> +		strbuf_release(&buf);
> +		rollback_lock_file(&lock);
> +		return -1;
> +	}
> +	if (commit_lock_file(&lock) < 0) {
> +		strbuf_release(&buf);
> +		rollback_lock_file(&lock);
> +		return error(_("failed to finalize '%s'"), filename);
> +	}
> +
> +	strbuf_release(&buf);
> +	return 0;
> +}
> +
> +static int do_label(const char *name, int len)
> +{
> +	struct ref_store *refs = get_main_ref_store();
> +	struct ref_transaction *transaction;
> +	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
> +	struct strbuf msg = STRBUF_INIT;
> +	int ret = 0;
> +	struct object_id head_oid;
> +
> +	if (len == 1 && *name == '#')
> +		return error("Illegal label name: '%.*s'", len, name);
> +
> +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> +	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
> +
> +	transaction = ref_store_transaction_begin(refs, &err);
> +	if (!transaction) {
> +		error("%s", err.buf);
> +		ret = -1;
> +	} else if (get_oid("HEAD", &head_oid)) {
> +		error(_("could not read HEAD"));
> +		ret = -1;
> +	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
> +					  NULL, 0, msg.buf, &err) < 0 ||
> +		   ref_transaction_commit(transaction, &err)) {
> +		error("%s", err.buf);
> +		ret = -1;
> +	}
> +	ref_transaction_free(transaction);
> +	strbuf_release(&err);
> +	strbuf_release(&msg);
> +
> +	if (!ret)
> +		ret = safe_append(rebase_path_refs_to_delete(),
> +				  "%s\n", ref_name.buf);
> +	strbuf_release(&ref_name);
> +
> +	return ret;
> +}
> +
> +static const char *reflog_message(struct replay_opts *opts,
> +	const char *sub_action, const char *fmt, ...);
> +
> +static int do_reset(const char *name, int len, struct replay_opts *opts)
> +{
> +	struct strbuf ref_name = STRBUF_INIT;
> +	struct object_id oid;
> +	struct lock_file lock = LOCK_INIT;
> +	struct tree_desc desc;
> +	struct tree *tree;
> +	struct unpack_trees_options unpack_tree_opts;
> +	int ret = 0, i;
> +
> +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +		return -1;
> +
> +	/* Determine the length of the label */
> +	for (i = 0; i < len; i++)
> +		if (isspace(name[i]))
> +			len = i;
> +
> +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> +	if (get_oid(ref_name.buf, &oid) &&
> +	    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
> +		error(_("could not read '%s'"), ref_name.buf);
> +		rollback_lock_file(&lock);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> +	unpack_tree_opts.head_idx = 1;
> +	unpack_tree_opts.src_index = &the_index;
> +	unpack_tree_opts.dst_index = &the_index;
> +	unpack_tree_opts.fn = oneway_merge;
> +	unpack_tree_opts.merge = 1;
> +	unpack_tree_opts.update = 1;
> +
> +	if (read_cache_unmerged()) {
> +		rollback_lock_file(&lock);
> +		strbuf_release(&ref_name);
> +		return error_resolve_conflict(_(action_name(opts)));
> +	}
> +
> +	if (!fill_tree_descriptor(&desc, &oid)) {
> +		error(_("failed to find tree of %s"), oid_to_hex(&oid));
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	tree = parse_tree_indirect(&oid);
> +	prime_cache_tree(&the_index, tree);
> +
> +	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> +		ret = error(_("could not write index"));
> +	free((void *)desc.buffer);
> +
> +	if (!ret)
> +		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
> +						len, name), "HEAD", &oid,
> +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> +
> +	strbuf_release(&ref_name);
> +	return ret;
> +}
> +
>  static int is_final_fixup(struct todo_list *todo_list)
>  {
>  	int i = todo_list->current;
> @@ -2610,7 +2791,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			res = do_pick_commit(item->command, item->commit,
>  					opts, is_final_fixup(todo_list));
>  			if (is_rebase_i(opts) && res < 0) {
> -				/* Reschedule */
> +reschedule:
>  				advise(_(rescheduled_advice),
>  				       get_item_line_length(todo_list,
>  							    todo_list->current),
> @@ -2639,7 +2820,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  					intend_to_amend();
>  				return error_failed_squash(item->commit, opts,
>  					item->arg_len, item->arg);
> -			} else if (res && is_rebase_i(opts))
> +			} else if (res && is_rebase_i(opts) && item->commit)
>  				return res | error_with_patch(item->commit,
>  					item->arg, item->arg_len, opts, res,
>  					item->command == TODO_REWORD);
> @@ -2665,6 +2846,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  				/* `current` will be incremented below */
>  				todo_list->current = -1;
>  			}
> +		} else if (item->command == TODO_LABEL) {
> +			if ((res = do_label(item->arg, item->arg_len)))
> +				goto reschedule;

I can see why you've implemented like this but I'm uneasy with jumping
into a block guarded with "if (item->command <= TODO_SQUASH)" when
item->command > TODO_SQUASH. I think it works OK at the moment but it's
possible that in the future someone will edit that block of code and add
something like

if (item->command == TODO_PICK)
	do_something()
else
	do_something_else()

assuming that item->command <= TODO_SQUASH because they haven't noticed
the goto jumping back into that block.

Best Wishes

Phillip


> +		} else if (item->command == TODO_RESET) {
> +			if ((res = do_reset(item->arg, item->arg_len, opts)))
> +				goto reschedule;
>  		} else if (!is_noop(item->command))
>  			return error(_("unknown command %d"), item->command);
>  
> 

