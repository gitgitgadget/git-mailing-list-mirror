Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427C61F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEHANW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35671 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfEHANV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so11209167wrp.2
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wy5dgWcfFi+MUsCGBskQwtPCCarPq0j7KioaKN99PGw=;
        b=X4LbzgHUl4TdCwmwPxixs6c97dAJbEkg3E4Xk4JQzEEInQUIGHkJZe7lA1Oju86SDX
         A/H832Y5BFc0Een7sApaPhdsckm3joWY31NdbP2OXZSaS6uIXDgDRmtdKMfUpIdSPD5Z
         7hqjClaPJ/o1/gvvbZ4Ut+svJDGQ+7cgiNmHT+sYclOxSrzbdxY9EwdMUQ9dgZRiJx4A
         bNWofwWV1ve3aillNbto0VC8tQWMTTcnBve2WHysgeQ/IJeiY/0Ci4yK3CfQTwZsTHTt
         M0d6cKA7UnWUO+JRI27Bexwkuws/J4bueH+I6GmiDuk+5l2bvWCyP4Fwg6JGGRbXLmJV
         A9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wy5dgWcfFi+MUsCGBskQwtPCCarPq0j7KioaKN99PGw=;
        b=dvTJMHlIHe/1Gk5jWBBbuXy0sQ3FTPGtwUpyOvuapv0L12Zgg9KGB5RYa7/xqLaGD8
         rYkvny1DPdNG2/Orne1EtjHpVirKqHQKN4GxI0fd0c5/2PktRbr+vIE3rJujdMG1GgHt
         313f+pNhxTcqnFQ4OwlW/aVV8IEnPCCIh6CtgVPaZnNk9+bxNh8fr7fMChNQ/4sLt48L
         2qKvOp7E0Lfl07AualBJ/qHlg8fwcb8OY+SR+qT0+PgT9PF33f2/T2DZ5J8wMJP+GSM7
         qGTkNK3G1kBLVPMI3W12eLZXV3SOlqkRdbgtDR7MKAA2OrjIaABWbl+uS/reFD2bMckJ
         9VfA==
X-Gm-Message-State: APjAAAX/nSVPNqEle6kapwSG9lkjW5nhSujoKhf01Ai0Ru8yqwD1TFcD
        9YXVvE/z/Z3aKLSbp2cH5U4jp2jRDcM=
X-Google-Smtp-Source: APXvYqzeyOfyqOTleCITwMmN2BouqlX2kb7/AW+zaJC/RYqYVyUdhyfUoE8FeQqIZ7AGj38nVuPMhw==
X-Received: by 2002:adf:f10f:: with SMTP id r15mr15158721wro.274.1557274397983;
        Tue, 07 May 2019 17:13:17 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 08/13] rebase: teach rebase --keep-base
Date:   Wed,  8 May 2019 02:12:47 +0200
Message-Id: <20190508001252.15752-9-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

A common scenario is if a user is working on a topic branch and they
wish to make some changes to intermediate commits or autosquash, they
would run something such as

	git rebase -i --onto master... master

in order to preserve the merge base. This is useful when contributing a
patch series to the Git mailing list, one often starts on top of the
current 'master'. However, while developing the patches, 'master' is
also developed further and it is sometimes not the bst idea to keep
rebasing on top of 'master', but to keep the base commit as-is.

Alternatively, a user wishing to test individual commits in a topic
branch without changing anything may run

	git rebase -x ./test.sh master... master

Since rebasing onto the merge base of the branch and the upstream is
such a common case, introduce the --keep-base option as a shortcut.

This allows us to rewrite the above as

	git rebase -i --keep-base master

and

	git rebase -x ./test.sh --keep-base master

respectively.

Add tests to ensure --keep-base works correctly in the normal case and
fails when there are multiple merge bases, both in regular and
interactive mode. Also, test to make sure conflicting options cause
rebase to fail. While we're adding test cases, add a missing
set_fake_editor call to 'rebase -i --onto master...side'.

While we're documenting the --keep-base option, change an instance of
"merge-base" to "merge base", which is the consistent spelling.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt           | 30 ++++++++++++--
 builtin/rebase.c                       | 32 ++++++++++++---
 contrib/completion/git-completion.bash |  2 +-
 t/t3416-rebase-onto-threedots.sh       | 57 ++++++++++++++++++++++++++
 t/t3431-rebase-fork-point.sh           |  4 ++
 t/t3432-rebase-fast-forward.sh         | 11 +++++
 6 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f5e6ae3907..fafb7b4eb3 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,8 +8,8 @@ git-rebase - Reapply commits on top of another base tip
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
-	[<upstream> [<branch>]]
+'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
+	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
@@ -217,6 +217,24 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+--keep-base::
+	Set the starting point at which to create the new commits to the
+	merge base of <upstream> <branch>. Running
+	'git rebase --keep-base <upstream> <branch>' is equivalent to
+	running 'git rebase --onto <upstream>... <upstream>'.
++
+This option is useful in the case where one is developing a feature on
+top of an upstream branch. While the feature is being worked on, the
+upstream branch may advance and it may not be the best idea to keep
+rebasing on top of the upstream but to keep the base commit as-is.
++
+Although both this option and --fork-point find the merge base between
+<upstream> and <branch>, this option uses the merge base as the _starting
+point_ on which new commits will be created, whereas --fork-point uses
+the merge base to determine the _set of commits_ which will be rebased.
++
+See also INCOMPATIBLE OPTIONS below.
+
 <upstream>::
 	Upstream branch to compare against.  May be any valid commit,
 	not just an existing branch name. Defaults to the configured
@@ -369,6 +387,10 @@ ends up being empty, the <upstream> will be used as a fallback.
 +
 If either <upstream> or --root is given on the command line, then the
 default is `--no-fork-point`, otherwise the default is `--fork-point`.
++
+If your branch was based on <upstream> but <upstream> was rewound and
+your branch contains commits which were dropped, this option can be used
+with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
 --whitespace=<option>::
@@ -545,6 +567,8 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
+ * --keep-base and --onto
+ * --keep-base and --root
 
 BEHAVIORAL DIFFERENCES
 -----------------------
@@ -869,7 +893,7 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       --interactive` will be **resurrected**!
 
 The idea is to manually tell 'git rebase' "where the old 'subsystem'
-ended and your 'topic' began", that is, what the old merge-base
+ended and your 'topic' began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
 of the old 'subsystem', for example:
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5f9beda46b..ae6b9b42b8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -27,8 +27,8 @@
 #include "branch.h"
 
 static char const * const builtin_rebase_usage[] = {
-	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
-		"[<upstream>] [<branch>]"),
+	N_("git rebase [-i] [options] [--exec <cmd>] "
+		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
 	N_("git rebase --continue | --abort | --skip | --edit-todo"),
@@ -1022,6 +1022,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
+	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
@@ -1055,6 +1056,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "keep-base", &keep_base,
+			 N_("use the merge-base of upstream and branch as the current base")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
@@ -1214,6 +1217,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		warning(_("git rebase --preserve-merges is deprecated. "
 			  "Use --rebase-merges instead."));
 
+	if (keep_base) {
+		if (options.onto_name)
+			die(_("cannot combine '--keep-base' with '--onto'"));
+		if (options.root)
+			die(_("cannot combine '--keep-base' with '--root'"));
+	}
+
 	if (action != NO_ACTION && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
@@ -1538,12 +1548,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Make sure the branch to rebase onto is valid. */
-	if (!options.onto_name)
+	if (keep_base) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, options.upstream_name);
+		strbuf_addstr(&buf, "...");
+		options.onto_name = xstrdup(buf.buf);
+	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &merge_base) < 0)
-			die(_("'%s': need exactly one merge base"),
-			    options.onto_name);
+		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
+			if (keep_base)
+				die(_("'%s': need exactly one merge base with branch"),
+				    options.upstream_name);
+			else
+				die(_("'%s': need exactly one merge base"),
+				    options.onto_name);
+		}
 		options.onto = lookup_commit_or_die(&merge_base,
 						    options.onto_name);
 	} else {
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3eefbabdb1..fe3768c8c6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2028,7 +2028,7 @@ _git_rebase ()
 			--autosquash --no-autosquash
 			--fork-point --no-fork-point
 			--autostash --no-autostash
-			--verify --no-verify
+			--verify --no-verify --keep-base
 			--keep-empty --root --force-rebase --no-ff
 			--rerere-autoupdate
 			--exec
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index ddf2f64853..9c2548423b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -99,7 +99,64 @@ test_expect_success 'rebase -i --onto master...side' '
 	git checkout side &&
 	git reset --hard K &&
 
+	set_fake_editor &&
 	test_must_fail git rebase -i --onto master...side J
 '
 
+test_expect_success 'rebase --keep-base --onto incompatible' '
+	test_must_fail git rebase --keep-base --onto master...
+'
+
+test_expect_success 'rebase --keep-base --root incompatible' '
+	test_must_fail git rebase --keep-base --root
+'
+
+test_expect_success 'rebase --keep-base master from topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	git rebase --keep-base master &&
+	git rev-parse C >base.expect &&
+	git merge-base master HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --keep-base master from side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	test_must_fail git rebase --keep-base master
+'
+
+test_expect_success 'rebase -i --keep-base master from topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	set_fake_editor &&
+	EXPECT_COUNT=2 git rebase -i --keep-base master &&
+	git rev-parse C >base.expect &&
+	git merge-base master HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase -i --keep-base master from side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	set_fake_editor &&
+	test_must_fail git rebase -i --keep-base master
+'
+
 test_done
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 2d5c6e641e..78851b9a2a 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -43,11 +43,15 @@ test_rebase () {
 
 test_rebase 'G F E D B A'
 test_rebase 'G F D B A' --onto D
+test_rebase 'G F B A' --keep-base
 test_rebase 'G F C E D B A' --no-fork-point
 test_rebase 'G F C D B A' --no-fork-point --onto D
+test_rebase 'G F C B A' --no-fork-point --keep-base
 test_rebase 'G F E D B A' --fork-point refs/heads/master
 test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
 test_rebase 'G F C E D B A' refs/heads/master
 test_rebase 'G F C D B A' --onto D refs/heads/master
+test_rebase 'G F C B A' --keep-base refs/heads/master
 
 test_done
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 8f4996e476..e8a9bf42b6 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -75,11 +75,15 @@ test_rebase_same_head success noop same success noop-force same master
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
 test_rebase_same_head success noop same success noop-force same --onto master... master
+test_rebase_same_head success noop same success noop-force same --keep-base master
+test_rebase_same_head success noop same success noop-force same --keep-base
 test_rebase_same_head success noop same success noop-force same --no-fork-point
+test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
 test_rebase_same_head success noop same success work same --fork-point master
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
 test_rebase_same_head success noop same success work same --fork-point --onto master... master
+test_rebase_same_head success noop same success work same --keep-base --keep-base master
 
 test_expect_success 'add work same  to side' '
 	test_commit E
@@ -91,11 +95,15 @@ test_rebase_same_head success noop same success noop-force same master
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
 test_rebase_same_head success noop same success noop-force same --onto master... master
+test_rebase_same_head success noop same success noop-force same --keep-base master
+test_rebase_same_head success noop same success noop-force same --keep-base
 test_rebase_same_head success noop same success noop-force same --no-fork-point
+test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
 test_rebase_same_head success noop same success work same --fork-point master
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
 test_rebase_same_head success noop same success work same --fork-point --onto master... master
+test_rebase_same_head success noop same success work same --fork-point --keep-base master
 
 test_expect_success 'add work same  to upstream' '
 	git checkout master &&
@@ -107,8 +115,11 @@ changes='our and their changes'
 test_rebase_same_head success noop same success noop-force diff --onto B B
 test_rebase_same_head success noop same success noop-force diff --onto B... B
 test_rebase_same_head success noop same success work diff --onto master... master
+test_rebase_same_head success noop same success work diff --keep-base master
+test_rebase_same_head success noop same success work diff --keep-base
 test_rebase_same_head failure work same success work diff --fork-point --onto B B
 test_rebase_same_head failure work same success work diff --fork-point --onto B... B
 test_rebase_same_head success noop same success work diff --fork-point --onto master... master
+test_rebase_same_head success noop same success work diff --fork-point --keep-base master
 
 test_done
-- 
2.21.0.1020.gf2820cf01a

