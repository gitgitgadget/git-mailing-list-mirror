Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BFD20248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfDQKZ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbfDQKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:25:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so31200109wrn.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=DFtmCiQ4PteDk3kRcQiMn96MdWRpbo1gfyibZtpp9rU=;
        b=aHojLmTff6Y6LmvCnYGvbtN4Q4jt6x9vWSSJEog8+ZB36QsRQ6Kjf8VTKttlyWRxxN
         S8iBxtduDKVeqtRHFE5gq4pwTq5OGccr0SMW0Skjc9bmWR6AxyjJpyLd18/QHcOuiYnt
         2jVP4sCD8+/KbtZPmZHy+u6nTTrAxLEqdsWOr+ONCv7ZSUn+VPhFx0qcIMbSdc9O1wS1
         JceuoWNQZ7TtWc2tz3Ha9H1lBWw+rgWbeehVlTaEOa/jb0t+vI89hJdv1Oj2Avypq6HK
         SCAUIK27Po8MlqyvVGJqSTj1asaEKBY2yc68vKNnWLnJ3wwN1OyqnlW3EgRwus1XEgCv
         /NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=DFtmCiQ4PteDk3kRcQiMn96MdWRpbo1gfyibZtpp9rU=;
        b=Mu7PLA7Z7HAka3r51Gav+X9yVYO+XRbhSERlTpxGgxsyjFPPiUrKFrLjoJKmfL2TZZ
         kTUlVkGaZQFCQcfSahpQ3ow4oh8CbL8AjRJpIHK9QlgyG9ynwzIOJi/xU6W0UNF9mLPv
         6a6Bw0vKOi7liWallx3j5vPxrI31BqzN2uf255p9V+0/vt7oe95Y4NHE8Zp0Gh/hPakT
         sihS/dGSJTBrlQ6ruypi33cbB/r+lvAhKqX6FhDTHUzyaGtRGX6PQp1m73KP8L9cO2A6
         2itRnW9VS7dSoof3DwBHmmm/grWp9XDEgdUNfOFR9iiKWDeC0tD5QIDZ/6ygIE6bKPyx
         zAbg==
X-Gm-Message-State: APjAAAW557hCEGfW+Qw7CDFd6DKe3isa1ZNk74IKrZahs3bXzXKD1KA3
        6QDgHJGSIfzCS5QrTZb1yYM=
X-Google-Smtp-Source: APXvYqz1+c7KHeoojIoUN8YyUow/bCBU3dRiLPxyUVhBlANIK8B16KPqzM2gMceyDj+DcY0NNaxEFw==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr53461527wrj.101.1555496725437;
        Wed, 17 Apr 2019 03:25:25 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:25:24 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v10 10/10] cherry-pick/revert: add scissors line on merge conflict
Date:   Wed, 17 Apr 2019 11:23:30 +0100
Message-Id: <20190417102330.24434-11-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Fix a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-cherry-pick.txt |  7 +++
 Documentation/git-revert.txt      |  7 +++
 builtin/merge.c                   | 10 +---
 builtin/revert.c                  |  7 +++
 sequencer.c                       | 16 ++++--
 sequencer.h                       |  3 +-
 t/t3507-cherry-pick-conflict.sh   | 86 +++++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index b8cfeec67e..cbb663a843 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -57,6 +57,13 @@ OPTIONS
 	With this option, 'git cherry-pick' will let you edit the commit
 	message prior to committing.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on to the commit machinery. See linkgit:git-commit[1] for more
+	details. In particular, if the '<mode>' is given a value of `scissors`,
+	scissors will be appended to `MERGE_MSG` before being passed on in the case
+	of a conflict.
+
 -x::
 	When recording the commit, append a line that says
 	"(cherry picked from commit ...)" to the original commit
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..7fd254df92 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -66,6 +66,13 @@ more details.
 	With this option, 'git revert' will not start the commit
 	message editor.
 
+--cleanup=<mode>::
+	This option determines how the commit message will be cleaned up before
+	being passed on to the commit machinery. See linkgit:git-commit[1] for more
+	details. In particular, if the '<mode>' is given a value of `scissors`,
+	scissors will be appended to `MERGE_MSG` before being passed on in the case
+	of a conflict.
+
 -n::
 --no-commit::
 	Usually the command automatically creates some commits with
diff --git a/builtin/merge.c b/builtin/merge.c
index 03b9f7230a..e96f72af80 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -927,14 +927,8 @@ static int suggest_conflicts(void)
 	 * Thus, we will get the cleanup mode which is returned when we _are_
 	 * using an editor.
 	 */
-	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
-	    fputc('\n', fp);
-	    wt_status_add_cut_line(fp);
-	    /* comments out the newline from append_conflicts_hint */
-	    fputc(comment_line_char, fp);
-	}
-
-	append_conflicts_hint(&the_index, &msgbuf);
+	append_conflicts_hint(&the_index, &msgbuf,
+			      get_cleanup_mode(cleanup_arg, 1));
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
diff --git a/builtin/revert.c b/builtin/revert.c
index a47b53ceaf..d4dcedbdc6 100644
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
@@ -137,6 +139,11 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
+	if (cleanup_arg) {
+		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
+		opts->explicit_cleanup = 1;
+	}
+
 	/* Check for incompatible command line arguments */
 	if (cmd) {
 		char *this_operation;
diff --git a/sequencer.c b/sequencer.c
index 3f4b0896e3..cff07c1907 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -182,7 +182,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
 			opts->explicit_cleanup = 1;
 		} else if (!strcmp(s, "scissors")) {
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
+			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SCISSORS;
 			opts->explicit_cleanup = 1;
 		} else {
 			warning(_("invalid commit message cleanup mode '%s'"),
@@ -554,10 +554,16 @@ static const char *describe_cleanup_mode(int cleanup_mode)
 }
 
 void append_conflicts_hint(struct index_state *istate,
-			   struct strbuf *msgbuf)
+	struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode)
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
@@ -625,7 +631,8 @@ static int do_recursive_merge(struct repository *r,
 			_(action_name(opts)));
 
 	if (!clean)
-		append_conflicts_hint(r->index, msgbuf);
+		append_conflicts_hint(r->index, msgbuf,
+				      opts->default_msg_cleanup);
 
 	return !clean;
 }
@@ -944,7 +951,6 @@ static int run_git_commit(struct repository *r,
 			  unsigned int flags)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	const char *value;
 
 	if ((flags & CREATE_ROOT_COMMIT) && !(flags & AMEND_MSG)) {
 		struct strbuf msg = STRBUF_INIT, script = STRBUF_INIT;
@@ -1014,7 +1020,7 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "-e");
 	else if (!(flags & CLEANUP_MSG) &&
 		 !opts->signoff && !opts->record_origin &&
-		 git_config_get_value("commit.cleanup", &value))
+		 !opts->explicit_cleanup)
 		argv_array_push(&cmd.args, "--cleanup=verbatim");
 
 	if ((flags & ALLOW_EMPTY))
diff --git a/sequencer.h b/sequencer.h
index 8295c8406f..7023da9b13 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -116,7 +116,8 @@ int rearrange_squash(struct repository *r);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
-void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
+void append_conflicts_hint(struct index_state *istate,
+		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor);
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 777fb23d18..a584b11c98 100755
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
2.21.0

