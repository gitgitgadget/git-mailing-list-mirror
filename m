Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E573C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiKIOY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKIOYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:24:05 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115F5240B1
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:22:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h9so26052458wrt.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/ruqVDSNCRQEeihuMFgDj0jjMVWyKqpIdgIpoLv1/U=;
        b=IRxs4WdHDT4iGCtdxlJvaUKCwoLsEV3edOgv0zduDgeY5PfffK+8Hk7X/3K28r4dIe
         UlfxFPWDzZFPqd7oUbVONVSxSh7GJAvc2KTKancRFHdOIX5XavvKaW9KMM3w3EYEJITW
         etEiWltGY+0wHmqs6zI6jkwYH5ce4sYalM5dDCxpZVhQW3xpA2+Ydkizw9AYNHfRQTRX
         3CK7X2rr1vaKy2ySBz3EmZUDMM7NBrfwRoLfrEL9xKC1iswF6SFwzuM8R0fnKDnrSNDt
         bmRE4751J/aB1PJJzFO6wNC1gnbxmkvcrM1pXjrsqh7L53bu+2mvSd15gnqLnL5CBsSJ
         smlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/ruqVDSNCRQEeihuMFgDj0jjMVWyKqpIdgIpoLv1/U=;
        b=KqZAu5x5ZEmx79gNkH9VgKF52IrfTLrJete6zQuLZWXchejsdJwo+n0vImMBF3jHvB
         brkp6Y7evYDnkEhAWrIYEaoG0KR1Ec3GHLMhUVVnABOoKOJdNuQ75pfs8Odt07MBf1XV
         Wu+xkgsoAgdBuRAot3h0Cy25GVm7RQtvmN2AFSnnMGfFMYH+dQB59dyUEOEVqMbFeeGi
         FEY/JcPMENQP0O2AllOyr4YJu/pJ+J7FjifHkUEDTkO2zTiMiKKXK1jhTseHrQmSpcgl
         ES+Ak5uneLHkTg8PDd+lHoSWMvsb9Nwk/PQTsywEFaTjItSWM2MhlVwZabMTUzsBhNMJ
         k0Wg==
X-Gm-Message-State: ACrzQf1QeiZXAUrFMZB+shAXkkGcNkbB5UCE4jtAm6LnfU0vA3hRfc7C
        cZkP0Y3Fuf5EzaSsZ++10j7Hw0F+Ass=
X-Google-Smtp-Source: AMsMyM4xsbEmb4rImE3K8Ez/+E1IcrR27fVVEHLz/fy4ZcwIrlwSLe2gcw/YIbuS1Wxnhzxy6cHCkQ==
X-Received: by 2002:adf:e0c8:0:b0:236:d9e5:4a51 with SMTP id m8-20020adfe0c8000000b00236d9e54a51mr31668757wri.168.1668003722390;
        Wed, 09 Nov 2022 06:22:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003b49bd61b19sm1992279wmb.15.2022.11.09.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:22:01 -0800 (PST)
Message-Id: <655b4e89f596b397865b67b58656f380f27d02fc.1668003719.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1405.v2.git.1668003718.gitgitgadget@gmail.com>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
        <pull.1405.v2.git.1668003718.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 14:21:57 +0000
Subject: [PATCH v2 1/2] sequencer: stop exporting GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Each time it picks a commit the sequencer copies the GIT_REFLOG_ACITON
environment variable so it can temporarily change it and then restore
the previous value. This results in code that is hard to follow and also
leaks memory because (i) we fail to free the copy when we've finished
with it and (ii) each call to setenv() leaks the previous value. Instead
pass the reflog action around in a variable and use it to set
GIT_REFLOG_ACTION in the child environment when running "git commit".

Within the sequencer GIT_REFLOG_ACTION is no longer set and is only read
by sequencer_reflog_action(). It is still set by rebase before calling
the sequencer, that will be addressed in the next commit. cherry-pick
and revert are unaffected as they do not set GIT_REFLOG_ACTION before
calling the sequencer.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 45 +++++++++++++++++++++++++--------------------
 sequencer.h |  6 ++++++
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e658df7e8ff..e23f6f0b718 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -375,6 +375,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 	}
 
 	free(opts->gpg_sign);
+	free(opts->reflog_action);
 	free(opts->default_strategy);
 	free(opts->strategy);
 	for (i = 0; i < opts->xopts_nr; i++)
@@ -1050,6 +1051,8 @@ static int run_git_commit(const char *defmsg,
 			     gpg_opt, gpg_opt);
 	}
 
+	strvec_pushf(&cmd.env, GIT_REFLOG_ACTION "=%s", opts->reflog_message);
+
 	if (opts->committer_date_is_author_date)
 		strvec_pushf(&cmd.env, "GIT_COMMITTER_DATE=%s",
 			     opts->ignore_date ?
@@ -1589,8 +1592,8 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	if (update_head_with_reflog(current_head, oid,
-				    getenv("GIT_REFLOG_ACTION"), msg, &err)) {
+	if (update_head_with_reflog(current_head, oid, opts->reflog_message,
+				    msg, &err)) {
 		res = error("%s", err.buf);
 		goto out;
 	}
@@ -3674,17 +3677,28 @@ static int do_label(struct repository *r, const char *name, int len)
 	return ret;
 }
 
+static const char *sequencer_reflog_action(struct replay_opts *opts)
+{
+	if (!opts->reflog_action) {
+		opts->reflog_action = getenv(GIT_REFLOG_ACTION);
+		opts->reflog_action =
+			xstrdup(opts->reflog_action ? opts->reflog_action
+						    : action_name(opts));
+	}
+
+	return opts->reflog_action;
+}
+
 __attribute__((format (printf, 3, 4)))
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
 	va_list ap;
 	static struct strbuf buf = STRBUF_INIT;
-	char *reflog_action = getenv(GIT_REFLOG_ACTION);
 
 	va_start(ap, fmt);
 	strbuf_reset(&buf);
-	strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
+	strbuf_addstr(&buf, sequencer_reflog_action(opts));
 	if (sub_action)
 		strbuf_addf(&buf, " (%s)", sub_action);
 	if (fmt) {
@@ -4497,7 +4511,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		.head_msg = reflog_message(opts, "start", "checkout %s",
 					   onto_name),
-		.default_reflog_action = "rebase"
+		.default_reflog_action = sequencer_reflog_action(opts)
 	};
 	if (reset_head(r, &ropts)) {
 		apply_autostash(rebase_path_autostash());
@@ -4566,11 +4580,8 @@ static int pick_commits(struct repository *r,
 			struct replay_opts *opts)
 {
 	int res = 0, reschedule = 0;
-	char *prev_reflog_action;
 
-	/* Note that 0 for 3rd parameter of setenv means set only if not set */
-	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
+	opts->reflog_message = sequencer_reflog_action(opts);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
@@ -4618,14 +4629,12 @@ static int pick_commits(struct repository *r,
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
-				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
-					command_to_string(item->command), NULL),
-					1);
+				opts->reflog_message = reflog_message(opts,
+				      command_to_string(item->command), NULL);
+
 			res = do_pick_commit(r, item, opts,
 					     is_final_fixup(todo_list),
 					     &check_todo);
-			if (is_rebase_i(opts))
-				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
 			if (is_rebase_i(opts) && res < 0) {
 				/* Reschedule */
 				advise(_(rescheduled_advice),
@@ -5050,8 +5059,6 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
-		char *previous_reflog_action;
-
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 
@@ -5062,13 +5069,11 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
-		previous_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
-		setenv(GIT_REFLOG_ACTION, reflog_message(opts, "continue", NULL), 1);
+		opts->reflog_message = reflog_message(opts, "continue", NULL);
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
 		}
-		setenv(GIT_REFLOG_ACTION, previous_reflog_action, 1);
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r, opts);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
@@ -5116,7 +5121,7 @@ static int single_pick(struct repository *r,
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	opts->reflog_message = sequencer_reflog_action(opts);
 	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }
 
diff --git a/sequencer.h b/sequencer.h
index 563fe599334..888c18aad71 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -63,6 +63,9 @@ struct replay_opts {
 	char **xopts;
 	size_t xopts_nr, xopts_alloc;
 
+	/* Reflog */
+	char *reflog_action;
+
 	/* Used by fixup/squash */
 	struct strbuf current_fixups;
 	int current_fixup_count;
@@ -73,6 +76,9 @@ struct replay_opts {
 
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
+
+	/* Private use */
+	const char *reflog_message;
 };
 #define REPLAY_OPTS_INIT { .edit = -1, .action = -1, .current_fixups = STRBUF_INIT }
 
-- 
gitgitgadget

