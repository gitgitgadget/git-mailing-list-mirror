Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A57120248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfCQKQ0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:16:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39226 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQKQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:16:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so9378486pgp.6
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZvE3+AT/DQ+rm/lXQfcHvzumCAVmsD/G0VJ0M2pzT54=;
        b=P1KtsQ/Crb/uUxuHgjpgWoyQutAk5EWGF+gvifqlpZmBu72XPZKeJKs6C3FHtDBkmM
         HBcReBI1oI7jrH+k6HxKv28QY4RLoXAnJ8RmlrN+uHuEQeg7atzUvST7gDBhxAl5Bi1h
         GdorV+0FLAngXBK2iDXYfonywlw/3sbdTXxuS2YnM+TKD3FrGDZPEcYceZhZ46ofN988
         9vxZwOagjAfP/njMnoXNtAX+lyAjr1Zjy207NxZwYoQ3eKPp7/BVH0V6dPMGqnd97OGF
         TuILzFs4c6m3qmtYBkLUCJ8Mmd6TPLa4pd5w7Qh5wnh2nOmlgnQsWQ6m0anIiBAIP0jE
         /uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZvE3+AT/DQ+rm/lXQfcHvzumCAVmsD/G0VJ0M2pzT54=;
        b=TuD9ajtZooTcMbEo6IpDOXfGGhR2dIerL+MlsC6g3hLx8cN7fFa8IJyfVcG1/9DPv/
         Pb0D2t2/GpnCNLlkPFjxamrhkySHWo6L3pbUiP1ESbKCOitUP8MLUJcoz6Rqt3ChFIUt
         a3TkDlKgerJ3KJHn5j1kthIu0+QtlyW9jeUiBVcJtjPSil1POSm6dIUwzc79csmIXc+x
         u77Lt+G+T3YTRAc9VJT0v1+WT4SLG/ZI7z6ntIiDR9xMxBdJmIcpbmpymOeVjHrIPSmZ
         mtzZyGWh6/HOJaPXHBAwpYBZZ/20qcfbouNI7tLNNw49Dr5ovU7p6VHy0wYdlU/YxCUE
         /2RQ==
X-Gm-Message-State: APjAAAXTjN3pqW7Xr41fP19yqFvt4LsZQgRsrVfcS9gHnH2TpyUiIhJm
        rBYRP7wn8GmR0veAlshdtpmzfFX2
X-Google-Smtp-Source: APXvYqzcutvlf/CRK4XVO5CyZOyHEPAUjCCxf1XSyXOLtTYm449qjfsVjeVDixbXJ2xi2EdDKwfRdw==
X-Received: by 2002:a65:514a:: with SMTP id g10mr12471464pgq.400.1552817784575;
        Sun, 17 Mar 2019 03:16:24 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id j14sm10005576pfn.77.2019.03.17.03.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:16:23 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:16:22 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 11/11] cherry-pick/revert: add scissors line on merge
 conflict
Message-ID: <5685ff80b582ab1d6daf4f2d0fcb93344b9069f5.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Reviewed-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-cherry-pick.txt |  7 +++
 Documentation/git-revert.txt      |  7 +++
 builtin/merge.c                   |  9 +---
 builtin/rebase--interactive.c     |  2 +-
 builtin/revert.c                  |  5 ++
 sequencer.c                       | 22 +++++---
 sequencer.h                       |  3 +-
 t/t3507-cherry-pick-conflict.sh   | 86 +++++++++++++++++++++++++++++++
 8 files changed, 123 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index b8cfeec67e..2601e1868e 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -57,6 +57,13 @@ OPTIONS
 	With this option, 'git cherry-pick' will let you edit the commit
 	message prior to committing.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on. See linkgit:git-commit[1] for more details. In
+	particular, if the '<mode>' is given a value of `scissors`, scissors
+	will be appended to `MERGE_MSG` before being passed on to the commit
+	machinery in the case of a conflict.
+
 -x::
 	When recording the commit, append a line that says
 	"(cherry picked from commit ...)" to the original commit
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..cabeb9df2c 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -66,6 +66,13 @@ more details.
 	With this option, 'git revert' will not start the commit
 	message editor.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on. See linkgit:git-commit[1] for more details. In
+	particular, if the '<mode>' is given a value of `scissors`, scissors
+	will be appended to `MERGE_MSG` before being passed on to the commit
+	machinery in the case of a conflict.
+
 -n::
 --no-commit::
 	Usually the command automatically creates some commits with
diff --git a/builtin/merge.c b/builtin/merge.c
index 86c54bff76..90c64346e9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -923,14 +923,7 @@ static int suggest_conflicts(void)
 	 * Thus, we will get the cleanup mode which is returned when we _are_ using
 	 * an editor.
 	 */
-	if (get_cleanup_mode(cleanup_arg, 1, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
-	    fputc('\n', fp);
-	    wt_status_add_cut_line(fp);
-	    /* comments out the newline from append_conflicts_hint */
-	    fputc(comment_line_char, fp);
-	}
-
-	append_conflicts_hint(&the_index, &msgbuf);
+	append_conflicts_hint(&the_index, &msgbuf, get_cleanup_mode(cleanup_arg, 1, 1));
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 888390f911..cf2151b271 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -199,10 +199,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	opts.action = REPLAY_INTERACTIVE_REBASE;
 	sequencer_init_config(&opts);
 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
-	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
 	opts.allow_empty = 1;
 
diff --git a/builtin/revert.c b/builtin/revert.c
index a47b53ceaf..41e7392c24 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -96,11 +96,13 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
+	const char *cleanup_arg = NULL;
 	int cmd = 0;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
@@ -137,6 +139,9 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
+	if (cleanup_arg)
+		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1, 1);
+
 	/* Check for incompatible command line arguments */
 	if (cmd) {
 		char *this_operation;
diff --git a/sequencer.c b/sequencer.c
index f782e8bab2..ea4687c3da 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -176,6 +176,11 @@ static struct cleanup_config_mapping cleanup_config_mapping[] = {
 	{ NULL, 0, 0 }
 };
 
+static inline int is_rebase_i(const struct replay_opts *opts)
+{
+	return opts->action == REPLAY_INTERACTIVE_REBASE;
+}
+
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
 	struct replay_opts *opts = cb;
@@ -188,7 +193,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		if (status)
 			return status;
 
-		opts->default_msg_cleanup = get_cleanup_mode(s, 0, 0);
+		opts->default_msg_cleanup = get_cleanup_mode(s, !is_rebase_i(opts), 0);
 
 		free((char *)s);
 		return status;
@@ -212,11 +217,6 @@ void sequencer_init_config(struct replay_opts *opts)
 	git_config(git_sequencer_config, opts);
 }
 
-static inline int is_rebase_i(const struct replay_opts *opts)
-{
-	return opts->action == REPLAY_INTERACTIVE_REBASE;
-}
-
 static const char *get_dir(const struct replay_opts *opts)
 {
 	if (is_rebase_i(opts))
@@ -552,10 +552,16 @@ static const char *describe_cleanup_mode(enum commit_msg_cleanup_mode cleanup_mo
 }
 
 void append_conflicts_hint(struct index_state *istate,
-			   struct strbuf *msgbuf)
+		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
 {
 	int i;
 
+	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+		strbuf_addch(msgbuf, '\n');
+		wt_status_append_cut_line(msgbuf);
+		strbuf_addch(msgbuf, comment_line_char);
+	}
+
 	strbuf_addch(msgbuf, '\n');
 	strbuf_commented_addf(msgbuf, "Conflicts:\n");
 	for (i = 0; i < istate->cache_nr;) {
@@ -623,7 +629,7 @@ static int do_recursive_merge(struct repository *r,
 			_(action_name(opts)));
 
 	if (!clean)
-		append_conflicts_hint(r->index, msgbuf);
+		append_conflicts_hint(r->index, msgbuf, opts->default_msg_cleanup);
 
 	return !clean;
 }
diff --git a/sequencer.h b/sequencer.h
index e7908f558e..830d8232f6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -115,7 +115,8 @@ int rearrange_squash(struct repository *r);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
-void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
+void append_conflicts_hint(struct index_state *istate,
+		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor, int die_on_error);
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 74ff925526..c3894ca9d6 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -189,6 +189,46 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 	test_cmp expected actual
 '
 
+test_expect_success \
+	'cherry-pick conflict, ensure commit.cleanup = scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config commit.cleanup scissors &&
+	cat <<-EOF >expected &&
+		picked
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git cherry-pick picked &&
+
+	test_i18ncmp expected .git/MERGE_MSG
+'
+
+test_expect_success \
+	'cherry-pick conflict, ensure cleanup=scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config --unset commit.cleanup &&
+	cat <<-EOF >expected &&
+		picked
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git cherry-pick --cleanup=scissors picked &&
+
+	test_i18ncmp expected .git/MERGE_MSG
+'
+
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	pristine_detach initial &&
 	cat <<-EOF >expected &&
@@ -335,6 +375,52 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	test_cmp expected actual
 '
 
+test_expect_success \
+	'revert conflict, ensure commit.cleanup = scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config commit.cleanup scissors &&
+	cat >expected <<-EOF &&
+		Revert "picked"
+
+		This reverts commit OBJID.
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git revert picked &&
+
+	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
+	test_i18ncmp expected actual
+'
+
+test_expect_success \
+	'revert conflict, ensure cleanup=scissors places scissors line properly' '
+	pristine_detach initial &&
+	git config --unset commit.cleanup &&
+	cat >expected <<-EOF &&
+		Revert "picked"
+
+		This reverts commit OBJID.
+
+		# ------------------------ >8 ------------------------
+		# Do not modify or remove the line above.
+		# Everything below it will be ignored.
+		#
+		# Conflicts:
+		#	foo
+		EOF
+
+	test_must_fail git revert --cleanup=scissors picked &&
+
+	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'failed cherry-pick does not forget -s' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked &&
-- 
2.21.0.512.g57bf1b23e1

