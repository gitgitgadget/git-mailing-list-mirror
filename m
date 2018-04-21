Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460141F404
	for <e@80x24.org>; Sat, 21 Apr 2018 15:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeDUP43 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 11:56:29 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:63361 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbeDUP42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 11:56:28 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 9usCfw0k7C0Wb9usCfAtcs; Sat, 21 Apr 2018 16:56:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524326186;
        bh=AtDTvL0pJMlgn7AthP+kGLYWEdehBsQ+s0ZHdz68Srk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=f/kogD4mBID2FOtxb3QdIqiZOuth6kaeE6YcamGSZs2I3y80E1XBj6QPx2OmLP71K
         VfMfggsMQTnzjqzn4JnN1zBZ6/t1yAendl9koC5s0/rODuEbqFWo+FgGLRYGV5fQ7c
         cN+pWt4z/hiJIeEBY4QEYWA11C0iLMDCk5bkQ5sQ=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=5D_q5xKx6-mmE5nwjOkA:9
 a=eYe15jlsyzK-yUNm:21 a=BDFqcNWXu9Xvpyjk:21 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
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
References: <cover.1524139900.git.johannes.schindelin@gmx.de>
 <cover.1524306546.git.johannes.schindelin@gmx.de>
 <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b05915e6-2259-5dee-69d8-90a5a524662d@talktalk.net>
Date:   Sat, 21 Apr 2018 16:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHf6w0O3o5/I5d+ECPf+j31IfKwgQhsMcfiQR7oQK7eQPA61CA6jYFVvzviFl+JwIHtDu814v1dkgCl9Hbavhri7Lcet4hLIhQINrewCaM0Z8crXeNLZ
 Xx9uBqyyKg/XPeeVFgzW8uxwRYMNKC78QXgtBbiKGJOI0AXOYY0UrvFheuJDh23kwP9UVgpZJP5Qrc0r3ZxaSPvC3f6BoDAnxYJACYjR5CGIvcpR6jOOSK7f
 lF2WgMFFcs3deZ5PVxxNCIaL2y8YBuwgH87/ApqLFU5IJHjzAiE+9qBF+82YTdQ0B2pPD38+O3gYiSME9uBHrSTu+wvsAAleXQsxc4I2ucwZu4Y9CYXg1ukF
 p9hSvgMs6+RvePoQEhy9iVe+Ss9/Rb85l6iTGQS0VeL0tmkgwdqFXmq3XTTN04RKPs+hCJeAluWOVn73MO+HuvOXMxte2zTMB+FGQXqc2dmmG/39sWI7V7KG
 i1htJHuE33DWxfe0cJ6wYg0wZ09yLw6h1fAmJ9G2PYsqvNWRWwRAy0HU9samuwhCn88ZgV+ns1LF9vL5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/04/18 11:33, Johannes Schindelin wrote:
> This patch is part of the effort to reimplement `--preserve-merges` with
> a substantially improved design, a design that has been developed in the
> Git for Windows project to maintain the dozens of Windows-specific patch
> series on top of upstream Git.
> 
> The previous patch implemented the `label` and `reset` commands to label
> commits and to reset to labeled commits. This patch adds the `merge`
> command, with the following syntax:

The two patches seem to have been fused together in this series.

If the reset command fails because it would overwrite untracked files it 
says

error: Untracked working tree file 'b' would be overwritten by merge.

Followed by the hint to edit the todo file. Saying 'merge' rather 
'reset' is possibly confusing to users. Perhaps it could call 
setup_unpack_trees_porcelain(), though that would need to be extended to 
handle 'reset'. Also it currently refuses to overwrite ignored files 
which is either annoying or safe depending on one's point of view.

Best Wishes

Phillip

> 
> 	merge [-C <commit>] <rev> # <oneline>
> 
> The <commit> parameter in this instance is the *original* merge commit,
> whose author and message will be used for the merge commit that is about
> to be created.
> 
> The <rev> parameter refers to the (possibly rewritten) revision to
> merge. Let's see an example of a todo list:
> 
> 	label onto
> 
> 	# Branch abc
> 	reset onto
> 	pick deadbeef Hello, world!
> 	label abc
> 
> 	reset onto
> 	pick cafecafe And now for something completely different
> 	merge -C baaabaaa abc # Merge the branch 'abc' into master
> 
> To edit the merge commit's message (a "reword" for merges, if you will),
> use `-c` (lower-case) instead of `-C`; this convention was borrowed from
> `git commit` that also supports `-c` and `-C` with similar meanings.
> 
> To create *new* merges, i.e. without copying the commit message from an
> existing commit, simply omit the `-C <commit>` parameter (which will
> open an editor for the merge message):
> 
> 	merge abc
> 
> This comes in handy when splitting a branch into two or more branches.
> 
> Note: this patch only adds support for recursive merges, to keep things
> simple. Support for octopus merges will be added later in a separate
> patch series, support for merges using strategies other than the
> recursive merge is left for the future.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   git-rebase--interactive.sh |   6 +
>   sequencer.c                | 407 ++++++++++++++++++++++++++++++++++++-
>   2 files changed, 406 insertions(+), 7 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index e1b865f43f2..ccd5254d1c9 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -162,6 +162,12 @@ s, squash <commit> = use commit, but meld into previous commit
>   f, fixup <commit> = like \"squash\", but discard this commit's log message
>   x, exec <commit> = run command (the rest of the line) using shell
>   d, drop <commit> = remove commit
> +l, label <label> = label current HEAD with a name
> +t, reset <label> = reset HEAD to a label
> +m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
> +.       create a merge commit using the original merge commit's
> +.       message (or the oneline, if no original merge commit was
> +.       specified). Use -c <commit> to reword the commit message.
>   
>   These lines can be re-ordered; they are executed from top to bottom.
>   " | git stripspace --comment-lines >>"$todo"
> diff --git a/sequencer.c b/sequencer.c
> index 01443e0f245..35fcacbdf0f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -23,6 +23,8 @@
>   #include "hashmap.h"
>   #include "notes-utils.h"
>   #include "sigchain.h"
> +#include "unpack-trees.h"
> +#include "worktree.h"
>   
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>   
> @@ -120,6 +122,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
>   static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
>   static GIT_PATH_FUNC(rebase_path_rewritten_pending,
>   	"rebase-merge/rewritten-pending")
> +
> +/*
> + * The path of the file listing refs that need to be deleted after the rebase
> + * finishes. This is used by the `label` command to record the need for cleanup.
> + */
> +static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
> +
>   /*
>    * The following files are written by git-rebase just after parsing the
>    * command-line (and are only consumed, not modified, by the sequencer).
> @@ -244,18 +253,34 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>   
>   int sequencer_remove_state(struct replay_opts *opts)
>   {
> -	struct strbuf dir = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
>   	int i;
>   
> +	if (is_rebase_i(opts) &&
> +	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
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
>   	free(opts->gpg_sign);
>   	free(opts->strategy);
>   	for (i = 0; i < opts->xopts_nr; i++)
>   		free(opts->xopts[i]);
>   	free(opts->xopts);
>   
> -	strbuf_addstr(&dir, get_dir(opts));
> -	remove_dir_recursively(&dir, 0);
> -	strbuf_release(&dir);
> +	strbuf_reset(&buf);
> +	strbuf_addstr(&buf, get_dir(opts));
> +	remove_dir_recursively(&buf, 0);
> +	strbuf_release(&buf);
>   
>   	return 0;
>   }
> @@ -1279,6 +1304,9 @@ enum todo_command {
>   	TODO_SQUASH,
>   	/* commands that do something else than handling a single commit */
>   	TODO_EXEC,
> +	TODO_LABEL,
> +	TODO_RESET,
> +	TODO_MERGE,
>   	/* commands that do nothing but are counted for reporting progress */
>   	TODO_NOOP,
>   	TODO_DROP,
> @@ -1297,6 +1325,9 @@ static struct {
>   	{ 'f', "fixup" },
>   	{ 's', "squash" },
>   	{ 'x', "exec" },
> +	{ 'l', "label" },
> +	{ 't', "reset" },
> +	{ 'm', "merge" },
>   	{ 0,   "noop" },
>   	{ 'd', "drop" },
>   	{ 0,   NULL }
> @@ -1724,9 +1755,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>   	return 0;
>   }
>   
> +enum todo_item_flags {
> +	TODO_EDIT_MERGE_MSG = 1
> +};
> +
>   struct todo_item {
>   	enum todo_command command;
>   	struct commit *commit;
> +	unsigned int flags;
>   	const char *arg;
>   	int arg_len;
>   	size_t offset_in_buf;
> @@ -1761,6 +1797,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>   	char *end_of_object_name;
>   	int i, saved, status, padding;
>   
> +	item->flags = 0;
> +
>   	/* left-trim */
>   	bol += strspn(bol, " \t");
>   
> @@ -1802,13 +1840,29 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>   		return error(_("missing arguments for %s"),
>   			     command_to_string(item->command));
>   
> -	if (item->command == TODO_EXEC) {
> +	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
> +	    item->command == TODO_RESET) {
>   		item->commit = NULL;
>   		item->arg = bol;
>   		item->arg_len = (int)(eol - bol);
>   		return 0;
>   	}
>   
> +	if (item->command == TODO_MERGE) {
> +		if (skip_prefix(bol, "-C", &bol))
> +			bol += strspn(bol, " \t");
> +		else if (skip_prefix(bol, "-c", &bol)) {
> +			bol += strspn(bol, " \t");
> +			item->flags |= TODO_EDIT_MERGE_MSG;
> +		} else {
> +			item->flags |= TODO_EDIT_MERGE_MSG;
> +			item->commit = NULL;
> +			item->arg = bol;
> +			item->arg_len = (int)(eol - bol);
> +			return 0;
> +		}
> +	}
> +
>   	end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
>   	saved = *end_of_object_name;
>   	*end_of_object_name = '\0';
> @@ -2465,6 +2519,305 @@ static int do_exec(const char *command_line)
>   	return status;
>   }
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
> +static int do_merge(struct commit *commit, const char *arg, int arg_len,
> +		    int flags, struct replay_opts *opts)
> +{
> +	int run_commit_flags = (flags & TODO_EDIT_MERGE_MSG) ?
> +		EDIT_MSG | VERIFY_MSG : 0;
> +	struct strbuf ref_name = STRBUF_INIT;
> +	struct commit *head_commit, *merge_commit, *i;
> +	struct commit_list *bases, *j, *reversed = NULL;
> +	struct merge_options o;
> +	int merge_arg_len, oneline_offset, ret;
> +	static struct lock_file lock;
> +	const char *p;
> +
> +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
> +		ret = -1;
> +		goto leave_merge;
> +	}
> +
> +	head_commit = lookup_commit_reference_by_name("HEAD");
> +	if (!head_commit) {
> +		ret = error(_("cannot merge without a current revision"));
> +		goto leave_merge;
> +	}
> +
> +	oneline_offset = arg_len;
> +	merge_arg_len = strcspn(arg, " \t\n");
> +	p = arg + merge_arg_len;
> +	p += strspn(p, " \t\n");
> +	if (*p == '#' && (!p[1] || isspace(p[1]))) {
> +		p += 1 + strspn(p + 1, " \t\n");
> +		oneline_offset = p - arg;
> +	} else if (p - arg < arg_len)
> +		BUG("octopus merges are not supported yet: '%s'", p);
> +
> +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
> +	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
> +	if (!merge_commit) {
> +		/* fall back to non-rewritten ref or commit */
> +		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
> +		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
> +	}
> +
> +	if (!merge_commit) {
> +		ret = error(_("could not resolve '%s'"), ref_name.buf);
> +		goto leave_merge;
> +	}
> +
> +	if (commit) {
> +		const char *message = get_commit_buffer(commit, NULL);
> +		const char *body;
> +		int len;
> +
> +		if (!message) {
> +			ret = error(_("could not get commit message of '%s'"),
> +				    oid_to_hex(&commit->object.oid));
> +			goto leave_merge;
> +		}
> +		write_author_script(message);
> +		find_commit_subject(message, &body);
> +		len = strlen(body);
> +		ret = write_message(body, len, git_path_merge_msg(), 0);
> +		unuse_commit_buffer(commit, message);
> +		if (ret) {
> +			error_errno(_("could not write '%s'"),
> +				    git_path_merge_msg());
> +			goto leave_merge;
> +		}
> +	} else {
> +		struct strbuf buf = STRBUF_INIT;
> +		int len;
> +
> +		strbuf_addf(&buf, "author %s", git_author_info(0));
> +		write_author_script(buf.buf);
> +		strbuf_reset(&buf);
> +
> +		if (oneline_offset < arg_len) {
> +			p = arg + oneline_offset;
> +			len = arg_len - oneline_offset;
> +		} else {
> +			strbuf_addf(&buf, "Merge branch '%.*s'",
> +				    merge_arg_len, arg);
> +			p = buf.buf;
> +			len = buf.len;
> +		}
> +
> +		ret = write_message(p, len, git_path_merge_msg(), 0);
> +		strbuf_release(&buf);
> +		if (ret) {
> +			error_errno(_("could not write '%s'"),
> +				    git_path_merge_msg());
> +			goto leave_merge;
> +		}
> +	}
> +
> +	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
> +		      git_path_merge_head(), 0);
> +	write_message("no-ff", 5, git_path_merge_mode(), 0);
> +
> +	bases = get_merge_bases(head_commit, merge_commit);
> +	for (j = bases; j; j = j->next)
> +		commit_list_insert(j->item, &reversed);
> +	free_commit_list(bases);
> +
> +	read_cache();
> +	init_merge_options(&o);
> +	o.branch1 = "HEAD";
> +	o.branch2 = ref_name.buf;
> +	o.buffer_output = 2;
> +
> +	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
> +	if (ret <= 0)
> +		fputs(o.obuf.buf, stdout);
> +	strbuf_release(&o.obuf);
> +	if (ret < 0) {
> +		error(_("could not even attempt to merge '%.*s'"),
> +		      merge_arg_len, arg);
> +		goto leave_merge;
> +	}
> +	/*
> +	 * The return value of merge_recursive() is 1 on clean, and 0 on
> +	 * unclean merge.
> +	 *
> +	 * Let's reverse that, so that do_merge() returns 0 upon success and
> +	 * 1 upon failed merge (keeping the return value -1 for the cases where
> +	 * we will want to reschedule the `merge` command).
> +	 */
> +	ret = !ret;
> +
> +	if (active_cache_changed &&
> +	    write_locked_index(&the_index, &lock, COMMIT_LOCK)) {
> +		ret = error(_("merge: Unable to write new index file"));
> +		goto leave_merge;
> +	}
> +
> +	rollback_lock_file(&lock);
> +	if (ret)
> +		rerere(opts->allow_rerere_auto);
> +	else
> +		ret = run_git_commit(git_path_merge_msg(), opts,
> +				     run_commit_flags);
> +
> +leave_merge:
> +	strbuf_release(&ref_name);
> +	rollback_lock_file(&lock);
> +	return ret;
> +}
> +
>   static int is_final_fixup(struct todo_list *todo_list)
>   {
>   	int i = todo_list->current;
> @@ -2568,7 +2921,7 @@ N_("Could not execute the todo command\n"
>   
>   static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>   {
> -	int res = 0;
> +	int res = 0, reschedule = 0;
>   
>   	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>   	if (opts->allow_ff)
> @@ -2639,7 +2992,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>   					intend_to_amend();
>   				return error_failed_squash(item->commit, opts,
>   					item->arg_len, item->arg);
> -			} else if (res && is_rebase_i(opts))
> +			} else if (res && is_rebase_i(opts) && item->commit)
>   				return res | error_with_patch(item->commit,
>   					item->arg, item->arg_len, opts, res,
>   					item->command == TODO_REWORD);
> @@ -2665,9 +3018,41 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>   				/* `current` will be incremented below */
>   				todo_list->current = -1;
>   			}
> +		} else if (item->command == TODO_LABEL) {
> +			if ((res = do_label(item->arg, item->arg_len)))
> +				reschedule = 1;
> +		} else if (item->command == TODO_RESET) {
> +			if ((res = do_reset(item->arg, item->arg_len, opts)))
> +				reschedule = 1;
> +		} else if (item->command == TODO_MERGE) {
> +			if ((res = do_merge(item->commit,
> +					    item->arg, item->arg_len,
> +					    item->flags, opts)) < 0)
> +				reschedule = 1;
> +			else if (res > 0)
> +				/* failed with merge conflicts */
> +				return error_with_patch(item->commit,
> +							item->arg,
> +							item->arg_len, opts,
> +							res, 0);
>   		} else if (!is_noop(item->command))
>   			return error(_("unknown command %d"), item->command);
>   
> +		if (reschedule) {
> +			advise(_(rescheduled_advice),
> +			       get_item_line_length(todo_list,
> +						    todo_list->current),
> +			       get_item_line(todo_list, todo_list->current));
> +			todo_list->current--;
> +			if (save_todo(todo_list, opts))
> +				return -1;
> +			if (item->commit)
> +				return error_with_patch(item->commit,
> +							item->arg,
> +							item->arg_len, opts,
> +							res, 0);
> +		}
> +
>   		todo_list->current++;
>   		if (res)
>   			return res;
> @@ -3147,8 +3532,16 @@ int transform_todos(unsigned flags)
>   					  short_commit_name(item->commit) :
>   					  oid_to_hex(&item->commit->object.oid);
>   
> +			if (item->command == TODO_MERGE) {
> +				if (item->flags & TODO_EDIT_MERGE_MSG)
> +					strbuf_addstr(&buf, " -c");
> +				else
> +					strbuf_addstr(&buf, " -C");
> +			}
> +
>   			strbuf_addf(&buf, " %s", oid);
>   		}
> +
>   		/* add all the rest */
>   		if (!item->arg_len)
>   			strbuf_addch(&buf, '\n');
> 

