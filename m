Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C54D20248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfCQKPz (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:15:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44408 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQKPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:15:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id a3so9272618pff.11
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cL4T0slcF8pEYnbFtN1bGkJFWTOcI8CyBJLu7lEoejk=;
        b=Qv04NsFPNUJ1QG4hoURwdtrtuj6XfpEvB1k2A/oG7enAGl65k06LgfQ+8jGy3df+S+
         KAwggOsrF2Dxhs37xStxrDHzlk3crle8/7T4c/hCuHpqK/tYeB6fAPjV7XbvzbpmekX9
         Sqjskb7Xeht0TXX19XwT8QStcXjJrbHxBKO+riSrIizqq4oxedsGZd5EOWYKzHuFwrtT
         HKa/8YXKTyYd2VG95gYhpn3SbdwDTfl87WqGxTevNPJ/n4LqcGZELjFSfh036QIPlZIT
         RrEm8aUpXZNn1tcCmkgonJYe7jrX7ANhCa7QksZSav0aIsi3LFwsMoPCJ/WkY6gZ1QdW
         f3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cL4T0slcF8pEYnbFtN1bGkJFWTOcI8CyBJLu7lEoejk=;
        b=Bt0opX0iXngRFm6wqNiYt+QlBXiImB4AshshAomVk2jymA+hb0+8EoOvVNIP0KEDE5
         /m5TX3BEjp2AK4eXImBWr2oRQOE6iG+MUrFAbkPAtjy7UnuBUUBxmwhg9HbldQe/YRHu
         Qhbq8clmUc+AWTdMTWvf4BzMYvE3J6emFW02899y3CXiblCziUuEPKrG8WYtQnmoHKoS
         LJdqqWXyFst5fOOlO1CVURhhDf7ObLXZk+ip1PJlZvHXvxlIB9VDxh+pLi5Ez4rEOwdX
         ORJ6u1kE4t5RxHEm993m+/Shhyu/0zsDrcFls77FxQMV2ACiv9lex0ahA8csuMAGL2zb
         1lYw==
X-Gm-Message-State: APjAAAXnFFum9A/BZ4KAdJgRGm3LaKBhSR9uxiKRkiQUcrDHEgcJz9d3
        /noVa83BDX0OcsQ20ZGaY+qkvbUQ
X-Google-Smtp-Source: APXvYqzt1EiY3YYaGZMgeCo5KQGsmb8BjEicEwOYv6zjN9it7rHoLoxPXmKGRSWgmrLVmq5MWSQAqg==
X-Received: by 2002:a63:66c1:: with SMTP id a184mr3612428pgc.60.1552817753468;
        Sun, 17 Mar 2019 03:15:53 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id c10sm9250164pfo.19.2019.03.17.03.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:15:52 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:15:50 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 00/11] Fix scissors bug during conflict
Message-ID: <cover.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552275703.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for taking so long to do a reroll, I've been pretty busy this week
and I've only been able to find the time now.

Previous discussion on the cherry-pick/revert changes can be found here[1].

Changes since revert/cherry-pick v3:

* Rebased on top of latest master
* Reordered and squashed patches
* Added populate_opts_cb and save_opts to save default_msg_cleanup at Phillip's suggestion

Changes since v7:

* Cleaned up more tests according to Eric's advice (and added some more cleanup patches!)
* Clarify meaning of "passed on" in documentation
* Consolidate common options into OPT_CLEANUP macro in parse-options.h
* Fix space indent to tabs in sequencer.c
* Shorten variable names for readability
* Make comment about 0th element in array being default more assertive
* Remove unnecessary braces around if/for statements
* Lowercase warning/error messages
* Unmark BUG messages for translation
* Rename get_config_from_cleanup -> describe_cleanup_mode
* Squashed in Ramsay's static patch

[1]: https://public-inbox.org/git/cover.1551867827.git.liu.denton@gmail.com/T/#u


Denton Liu (11):
  t7600: clean up style
  t3507: cleanup space after redirection operators
  t7604: refactor out Git commands upstream of pipe
  t7502: clean up test style
  commit: extract cleanup_mode functions to sequencer
  parse-options.h: extract common --cleanup option
  sequencer.c: remove duplicate code
  merge: cleanup messages like commit
  merge: add scissors line on merge conflict
  sequencer.c: define describe_cleanup_mode
  cherry-pick/revert: add scissors line on merge conflict

 Documentation/git-cherry-pick.txt |   7 ++
 Documentation/git-revert.txt      |   7 ++
 Documentation/merge-options.txt   |   7 ++
 builtin/commit.c                  |  47 +++++-------
 builtin/merge.c                   |  40 ++++++++--
 builtin/pull.c                    |   6 ++
 builtin/rebase--interactive.c     |   2 +-
 builtin/revert.c                  |   5 ++
 builtin/tag.c                     |   3 +-
 parse-options.h                   |   1 +
 sequencer.c                       |  97 +++++++++++++++++++-----
 sequencer.h                       |   9 ++-
 t/t3507-cherry-pick-conflict.sh   | 120 +++++++++++++++++++++++++-----
 t/t7502-commit-porcelain.sh       | 100 +++++++++++++++----------
 t/t7600-merge.sh                  |  70 ++++++++++++++---
 t/t7604-merge-custom-message.sh   |  75 ++++++++++++++++++-
 wt-status.c                       |  12 ++-
 wt-status.h                       |   1 +
 18 files changed, 478 insertions(+), 131 deletions(-)

Interdiff against v7:
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index b4ff8e136d..2601e1868e 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -60,9 +60,9 @@ OPTIONS
 --cleanup=<mode>::
 	This option determines how the commit message will be cleaned up before
 	being passed on. See linkgit:git-commit[1] for more details. In
-	addition, if the '<mode>' is given a value of `scissors`, scissors will
-	be appended to MERGE_MSG before being passed on in the case of a
-	conflict.
+	particular, if the '<mode>' is given a value of `scissors`, scissors
+	will be appended to `MERGE_MSG` before being passed on to the commit
+	machinery in the case of a conflict.
 
 -x::
 	When recording the commit, append a line that says
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index bd4ad395a9..cabeb9df2c 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -69,9 +69,9 @@ more details.
 --cleanup=<mode>::
 	This option determines how the commit message will be cleaned up before
 	being passed on. See linkgit:git-commit[1] for more details. In
-	addition, if the '<mode>' is given a value of `scissors`, scissors will
-	be appended to MERGE_MSG before being passed on in the case of a
-	conflict.
+	particular, if the '<mode>' is given a value of `scissors`, scissors
+	will be appended to `MERGE_MSG` before being passed on to the commit
+	machinery in the case of a conflict.
 
 -n::
 --no-commit::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index c7b889d6f5..405e16c617 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -36,8 +36,8 @@ set to `no` at the beginning of them.
 	This option determines how the merge message will be cleaned up
 	before commiting or being passed on. See linkgit:git-commit[1] for more
 	details. In addition, if the '<mode>' is given a value of `scissors`,
-	scissors will be appended to MERGE_MSG before being passed on in the
-	case of a merge conflict.
+	scissors will be appended to `MERGE_MSG` before being passed on to the
+	commit machinery in the case of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
diff --git a/builtin/commit.c b/builtin/commit.c
index d8c4626a68..b9159c2e7b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,7 +1483,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/builtin/merge.c b/builtin/merge.c
index 671d6a19a4..90c64346e9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -253,7 +253,7 @@ static struct option builtin_merge_options[] = {
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
-	OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
+	OPT_CLEANUP(&cleanup_arg),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
 	OPT_SET_INT_F(0, "ff-only", &fast_forward,
 		      N_("abort if fast-forward is not possible"),
diff --git a/builtin/pull.c b/builtin/pull.c
index 3ec7882375..292c1dac27 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -171,7 +171,7 @@ static struct option pull_options[] = {
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
 		N_("how to strip spaces and #comments from message"),
-		PARSE_OPT_NOARG),
+		0),
 	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
 		N_("allow fast-forward"),
 		PARSE_OPT_NOARG),
diff --git a/builtin/revert.c b/builtin/revert.c
index e8168e0214..41e7392c24 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -102,7 +102,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..a3870fbdba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -397,8 +397,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
-			N_("how to strip spaces and #comments from message")),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
diff --git a/parse-options.h b/parse-options.h
index 7d83e2971d..85faaee390 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -303,5 +303,6 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
+#define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 496554a474..ea4687c3da 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -161,13 +161,13 @@ static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_re
 static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
 
 struct cleanup_config_mapping {
-    const char *config_value;
-    enum commit_msg_cleanup_mode editor_cleanup;
-    enum commit_msg_cleanup_mode no_editor_cleanup;
+	const char *value;
+	enum commit_msg_cleanup_mode editor;
+	enum commit_msg_cleanup_mode no_editor;
 };
 
-/* note that we assume that cleanup_config_mapping[0] contains the default settings */
-struct cleanup_config_mapping cleanup_config_mappings[] = {
+/* the 0th element of this array must be the "default" */
+static struct cleanup_config_mapping cleanup_config_mapping[] = {
 	{ "default", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_SPACE },
 	{ "verbatim", COMMIT_MSG_CLEANUP_NONE, COMMIT_MSG_CLEANUP_NONE },
 	{ "whitespace", COMMIT_MSG_CLEANUP_SPACE, COMMIT_MSG_CLEANUP_SPACE },
@@ -520,40 +520,35 @@ static int fast_forward_to(struct repository *r,
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor, int die_on_error)
 {
-	struct cleanup_config_mapping *default_mapping = &cleanup_config_mappings[0];
-	struct cleanup_config_mapping *current_mapping;
+	struct cleanup_config_mapping *def = &cleanup_config_mapping[0];
+	struct cleanup_config_mapping *p;
 
-	if (!cleanup_arg) {
-		return use_editor ? default_mapping->editor_cleanup :
-				    default_mapping->no_editor_cleanup;
-	}
+	if (!cleanup_arg)
+		return use_editor ? def->editor :
+				    def->no_editor;
 
-	for (current_mapping = cleanup_config_mappings; current_mapping->config_value; current_mapping++) {
-		if (!strcmp(cleanup_arg, current_mapping->config_value)) {
-			return use_editor ? current_mapping->editor_cleanup :
-					    current_mapping->no_editor_cleanup;
-		}
-	}
+	for (p = cleanup_config_mapping; p->value; p++)
+		if (!strcmp(cleanup_arg, p->value))
+			return use_editor ? p->editor :
+					    p->no_editor;
 
 	if (!die_on_error) {
-		warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);
-		return use_editor ? default_mapping->editor_cleanup :
-				    default_mapping->no_editor_cleanup;
+		warning(_("invalid cleanup mode %s, falling back to default"), cleanup_arg);
+		return use_editor ? def->editor :
+				    def->no_editor;
 	} else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
+		die(_("invalid cleanup mode %s"), cleanup_arg);
 }
 
-const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode)
+static const char *describe_cleanup_mode(enum commit_msg_cleanup_mode cleanup_mode)
 {
-	struct cleanup_config_mapping *current_mapping;
+	struct cleanup_config_mapping *curr;
 
-	for (current_mapping = &cleanup_config_mappings[1]; current_mapping->config_value; current_mapping++) {
-		if (cleanup_mode == current_mapping->editor_cleanup) {
-			return current_mapping->config_value;
-		}
-	}
+	for (curr = &cleanup_config_mapping[1]; curr->value; curr++)
+		if (cleanup_mode == curr->editor)
+			return curr->value;
 
-	BUG(_("invalid cleanup_mode provided"));
+	BUG("invalid cleanup_mode provided (%d)", cleanup_mode);
 }
 
 void append_conflicts_hint(struct index_state *istate,
@@ -2796,7 +2791,7 @@ static int save_opts(struct replay_opts *opts)
 						     "true" : "false");
 
 	res |= git_config_set_in_file_gently(opts_file, "options.default-msg-cleanup",
-					     get_config_from_cleanup(opts->default_msg_cleanup));
+					     describe_cleanup_mode(opts->default_msg_cleanup));
 	return res;
 }
 
diff --git a/sequencer.h b/sequencer.h
index 95ff9db508..830d8232f6 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -119,7 +119,6 @@ void append_conflicts_hint(struct index_state *istate,
 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	int use_editor, int die_on_error);
-const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode);
 
 void cleanup_message(struct strbuf *msgbuf,
 	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index ca4a740da0..f035e4a507 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -16,7 +16,9 @@ commit_msg_is () {
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
-	git commit ${3+"$3"} -m "$2" | head -1 > act &&
+	git commit ${3+"$3"} -m "$2" >act &&
+	head -1 <act >tmp &&
+	mv tmp act &&
 
 	# branch name
 	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
@@ -68,7 +70,7 @@ test_expect_success 'output summary format for merges' '
 	git checkout recursive-a &&
 	test_must_fail git merge recursive-b &&
 	# resolve the conflict
-	echo commit-a > file1 &&
+	echo commit-a >file1 &&
 	git add file1 &&
 	check_summary_oneline "" "Merge"
 '
@@ -142,8 +144,8 @@ test_expect_success 'sign off' '
 	>positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
-	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
+	actual=$(git cat-file commit HEAD >tmp && sed -ne "s/Signed-off-by: //p" <tmp && rm tmp) &&
+	expected=$(git var GIT_COMMITTER_IDENT >tmp && sed -e "s/>.*/>/" <tmp && rm tmp) &&
 	test "z$actual" = "z$expected"
 
 '
@@ -153,8 +155,8 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
-	expected=$(echo one; echo; echo two; echo; echo three) &&
+	actual=$(git cat-file commit HEAD >tmp && sed -e "1,/^\$/d" <tmp && rm tmp) &&
+	expected=$(test_write_lines "one" "" "two" "" "three") &&
 	test "z$actual" = "z$expected"
 
 '
@@ -163,7 +165,9 @@ test_expect_success 'verbose' '
 
 	echo minus >negative &&
 	git add negative &&
-	git status -v | sed -ne "/^diff --git /p" >actual &&
+	git status -v >actual &&
+	sed -ne "/^diff --git /p" <actual >tmp &&
+	mv tmp actual &&
 	echo "diff --git a/negative b/negative" >expect &&
 	test_cmp expect actual
 
@@ -189,7 +193,9 @@ test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim --no-status -t expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -198,7 +204,9 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -207,7 +215,9 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -215,10 +225,12 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo; } >text &&
+	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -226,48 +238,54 @@ test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 test_expect_success 'cleanup commit messages (scissors option,-F,-e)' '
 
 	echo >>negative &&
-	cat >text <<EOF &&
+	cat >text <<-\EOF &&
 
-# to be kept
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-# ------------------------ >8 ------------------------
-to be removed
-# ------------------------ >8 ------------------------
-to be removed, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	# ------------------------ >8 ------------------------
+	to be removed
+	# ------------------------ >8 ------------------------
+	to be removed, too
+	EOF
 
-	cat >expect <<EOF &&
-# to be kept
+	cat >expect <<-\EOF &&
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	EOF
 	git commit --cleanup=scissors -e -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'cleanup commit messages (scissors option,-F,-e, scissors on first line)' '
 
 	echo >>negative &&
-	cat >text <<EOF &&
-# ------------------------ >8 ------------------------
-to be removed
-EOF
+	cat >text <<-\EOF &&
+	# ------------------------ >8 ------------------------
+	to be removed
+	EOF
 	git commit --cleanup=scissors -e -F text -a --allow-empty-message &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'cleanup commit messages (strip option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo sample;echo; } >text &&
+	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >actual &&
+	sed -e "1,/^\$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -275,7 +293,7 @@ test_expect_success 'cleanup commit messages (strip option,-F)' '
 test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 
 	echo >>negative &&
-	{ echo;echo sample;echo; } >text &&
+	test_write_lines "" "sample" "" >text &&
 	git commit -e -F text -a &&
 	head -n 4 .git/COMMIT_EDITMSG >actual
 '
@@ -387,7 +405,7 @@ test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 '
 
 write_script .git/FAKE_EDITOR <<EOF
-echo editor started > "$(pwd)/.git/result"
+echo editor started >"$(pwd)/.git/result"
 exit 0
 EOF
 
@@ -455,7 +473,7 @@ EOF
 test_expect_success EXECKEEPSPID 'a SIGTERM should break locks' '
 	echo >>negative &&
 	! "$SHELL_PATH" -c '\''
-	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  echo kill -TERM $$ >>.git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git commit -a'\'' &&
@@ -471,7 +489,9 @@ test_expect_success 'Hand committing of a redundant merge removes dups' '
 	test_must_fail git merge second master &&
 	git checkout master g &&
 	EDITOR=: git commit -a &&
-	git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/q" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -n -e "s/^parent //p" -e "/^$/q" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 
 '
@@ -480,7 +500,9 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 	git reset --hard &&
 	git commit -s -m "hello: kitty" --allow-empty &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_line_count = 3 actual
 
 '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2cb57e5878..ed11b08db2 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -234,15 +234,16 @@ test_expect_success 'merge --squash c3 with c7' '
 	git commit --no-edit -a &&
 
 	cat >expect <<-EOF &&
-		Squashed commit of the following:
+	Squashed commit of the following:
 
-		$(git show -s c7)
+	$(git show -s c7)
 
-		# Conflicts:
-		#	file
-		EOF
-	git cat-file commit HEAD >tmp &&
-	sed -e '1,/^$/d' <tmp >actual &&
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >actual &&
+	sed -e '1,/^$/d' <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 '
 
@@ -253,18 +254,19 @@ test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
 	cat result.9z >file &&
 	git commit --no-edit -a &&
 
-	cat >expect <<-EOF &&
-		Merge tag '"'"'c7'"'"'
-
-		# ------------------------ >8 ------------------------
-		# Do not modify or remove the line above.
-		# Everything below it will be ignored.
-		#
-		# Conflicts:
-		#	file
-		EOF
-	git cat-file commit HEAD >tmp &&
-	sed -e '1,/^$/d' <tmp >actual &&
+	cat >expect <<-\EOF &&
+	Merge tag '"'"'c7'"'"'
+
+	# ------------------------ >8 ------------------------
+	# Do not modify or remove the line above.
+	# Everything below it will be ignored.
+	#
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >actual &&
+	sed -e '1,/^$/d' <actual >tmp &&
+	mv tmp actual &&
 	test_i18ncmp expect actual
 '
 
@@ -276,19 +278,20 @@ test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
 	git commit --no-edit -a &&
 
 	cat >expect <<-EOF &&
-		Squashed commit of the following:
-
-		$(git show -s c7)
-
-		# ------------------------ >8 ------------------------
-		# Do not modify or remove the line above.
-		# Everything below it will be ignored.
-		#
-		# Conflicts:
-		#	file
-		EOF
-	git cat-file commit HEAD >tmp &&
-	sed -e '1,/^$/d' <tmp >actual &&
+	Squashed commit of the following:
+
+	$(git show -s c7)
+
+	# ------------------------ >8 ------------------------
+	# Do not modify or remove the line above.
+	# Everything below it will be ignored.
+	#
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >actual &&
+	sed -e '1,/^$/d' <actual >tmp &&
+	mv tmp actual &&
 	test_i18ncmp expect actual
 '
 
@@ -728,7 +731,7 @@ cat >editor <<\EOF
 	cat <"$1"
 ) >"$1.tmp" && mv "$1.tmp" "$1"
 # strip comments and blank lines from end of message
-sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > expected
+sed -e '/^#/d' < "$1" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' >expected
 EOF
 chmod 755 editor
 
@@ -859,7 +862,7 @@ EOF
 test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue' '
 	git reset --hard c0 &&
 	! "$SHELL_PATH" -c '\''
-	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  echo kill -TERM $$ >>.git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git merge --no-ff --edit c1'\'' &&
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 3fcd58eb2c..c9685a318d 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -36,14 +36,18 @@ test_expect_success 'setup' '
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
 	git merge -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp exp.subject actual
 '
 
 test_expect_success 'merge --log appends to custom message' '
 	git reset --hard c1 &&
 	git merge --log -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp exp.log actual
 '
 
@@ -59,53 +63,59 @@ test_expect_success 'prepare file with comment line and trailing newlines'  '
 test_expect_success 'cleanup commit messages (verbatim option)' '
 	git reset --hard c1 &&
 	git merge --cleanup=verbatim -F expect c2 &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'cleanup commit messages (whitespace option)' '
 	git reset --hard c1 &&
-	{ echo;echo "# text";echo; } >text &&
+	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git merge --cleanup=whitespace -F text c2 &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'cleanup merge messages (scissors option)' '
 	git reset --hard c1 &&
-	cat >text <<EOF &&
+	cat >text <<-\EOF &&
 
-# to be kept
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-# ------------------------ >8 ------------------------
-to be removed
-# ------------------------ >8 ------------------------
-to be removed, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	# ------------------------ >8 ------------------------
+	to be removed
+	# ------------------------ >8 ------------------------
+	to be removed, too
+	EOF
 
-	cat >expect <<EOF &&
-# to be kept
+	cat >expect <<-\EOF &&
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	EOF
 	git merge --cleanup=scissors -e -F text c2 &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'cleanup commit messages (strip option)' '
 	git reset --hard c1 &&
-	{ echo;echo "# text";echo sample;echo; } >text &&
+	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git merge --cleanup=strip -F text c2 &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file commit HEAD >actual &&
+	sed -e "1,/^$/d" <actual >tmp &&
+	mv tmp actual &&
 	test_cmp expect actual
-
 '
 
 test_done
-- 
2.21.0.512.g57bf1b23e1

