Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707B220248
	for <e@80x24.org>; Wed, 17 Apr 2019 18:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbfDQSBh (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 14:01:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34544 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfDQSBf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 14:01:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so12372618pgq.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VgHeVfZ4JXet4urFM85LcKHE9ODyyaHX+LEXJBAiSGo=;
        b=MSgAn89UPNjcxpGsy/Jyq+Uwl+av1TYjljQ5jQx0ATK065Rj1S4+q77KlqY/WBSAXm
         7tDxRtEFHL65DPFRIdMdBXTEWDHb9FCE1T2GNXpz9liImlu8qItxAxa6I6/3b7iZRl94
         VL+du5YPMcslpRPlQNTHQqGB4o7GjZqqehP/GrYdvA3A8VONEWJlZ7wQ8hVND3f+TKNo
         COouM7P/KSyXGN/JYogv10dFL4DAiCgSgUmySaokq2zxzuJ3HUgBv1H6VirYtFl5I9R9
         Yd9OEvrjdqcbJzF/RhWbwz/mvmMQTd9Vy7pmWX9j8nzH6qg7RQsEX3QUhNc7INh+wTa6
         33PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VgHeVfZ4JXet4urFM85LcKHE9ODyyaHX+LEXJBAiSGo=;
        b=R1QtYOr0Ik1Bj5YQ+Z+wPl1VhxbcGnx2Ti49O+VF1MYGZi9eBzL2ae5PAxlblWb09W
         f20zl0v8Pz6p69cZ77qldsCu4YqUQq3pujWx94csEUdVoSvX+rFq+lLBITZ9GnStJyRD
         AUH8HPRh1VNn39UU3ttIWer6Sbsg13TFDp3dEpwNSrBx+DMLe5uFPwXz87/vTHYUlr5n
         K6Ugyxg6XD8r7Kz+ni7by+esvnPNb1ZKubXVfpnMZSW7G3H9pmNaXmmCyIF5nFOsKI0B
         tiTQVmypZc8UZcTpKDB6FY3H6gDTIDlE6WWgfZIL2VgHic6ZPxFy0woCGF2mZLgfUMM0
         RO7Q==
X-Gm-Message-State: APjAAAVWnHhW7knxYGNWq56B5UtN0p78ieLO9XpSrtHZJ0gKmBrL7oqd
        wn0dBFFtY46mLeKeyAWfwdtu6mtnDBQ=
X-Google-Smtp-Source: APXvYqynnP5YfU2HP/+I9TXR6h6i2o7agkjJCOEpZev9ljlRe7+R6nEZXKPwA9/sDUOeEcnhunlIFw==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr3504029pgm.15.1555524093856;
        Wed, 17 Apr 2019 11:01:33 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id y1sm105045392pgc.29.2019.04.17.11.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:01:33 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:01:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v6 6/6] rebase: teach rebase --keep-base
Message-ID: <c542c7afc1af942dc6ca0d05582ff43e9eda2cbe.1555523176.git.liu.denton@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555523176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1555523176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 Documentation/git-rebase.txt     | 30 +++++++++++++++--
 builtin/rebase.c                 | 32 ++++++++++++++----
 t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++++++++++++
 t/t3431-rebase-fork-point.sh     |  4 +++
 t/t3432-rebase-fast-forward.sh   | 11 ++++++
 5 files changed, 125 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6363d674b7..569ab708d4 100644
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
@@ -364,6 +382,10 @@ ends up being empty, the <upstream> will be used as a fallback.
 +
 If either <upstream> or --root is given on the command line, then the
 default is `--no-fork-point`, otherwise the default is `--fork-point`.
++
+If your branch was based on <upstream> but <upstream> was rewound and
+your branch contains commits which were dropped, this option can be used
+with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
 --whitespace=<option>::
@@ -539,6 +561,8 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
+ * --keep-base and --onto
+ * --keep-base and --root
 
 BEHAVIORAL DIFFERENCES
 -----------------------
@@ -863,7 +887,7 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       --interactive` will be **resurrected**!
 
 The idea is to manually tell 'git rebase' "where the old 'subsystem'
-ended and your 'topic' began", that is, what the old merge-base
+ended and your 'topic' began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
 of the old 'subsystem', for example:
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e29ea652f..87a23f17eb 100644
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
@@ -1040,6 +1040,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
+	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
@@ -1073,6 +1074,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "keep-base", &keep_base,
+			 N_("use the merge-base of upstream and branch as the current base")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
@@ -1239,6 +1242,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
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
@@ -1563,12 +1573,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index 9b517d87a3..f848946f5a 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -43,11 +43,15 @@ test_rebase() {
 
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
index 1cb2896fb4..1ba02cc95f 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -33,11 +33,15 @@ test_rebase_same_head success master
 test_rebase_same_head success --onto B B
 test_rebase_same_head success --onto B... B
 test_rebase_same_head success --onto master... master
+test_rebase_same_head success --keep-base master
+test_rebase_same_head success --keep-base
 test_rebase_same_head success --no-fork-point
+test_rebase_same_head success --keep-base --no-fork-point
 test_rebase_same_head success --fork-point master
 test_rebase_same_head success --fork-point --onto B B
 test_rebase_same_head success --fork-point --onto B... B
 test_rebase_same_head success --fork-point --onto master... master
+test_rebase_same_head success --fork-point --keep-base master
 
 test_expect_success 'add work to side' '
 	test_commit E
@@ -49,11 +53,15 @@ test_rebase_same_head success master
 test_rebase_same_head success --onto B B
 test_rebase_same_head success --onto B... B
 test_rebase_same_head success --onto master... master
+test_rebase_same_head success --keep-base master
+test_rebase_same_head success --keep-base
 test_rebase_same_head success --no-fork-point
+test_rebase_same_head success --keep-base --no-fork-point
 test_rebase_same_head success --fork-point master
 test_rebase_same_head success --fork-point --onto B B
 test_rebase_same_head success --fork-point --onto B... B
 test_rebase_same_head success --fork-point --onto master... master
+test_rebase_same_head success --fork-point --keep-base master
 
 test_expect_success 'add work to upstream' '
 	git checkout master &&
@@ -65,8 +73,11 @@ changes='our and their changes'
 test_rebase_same_head success --onto B B
 test_rebase_same_head success --onto B... B
 test_rebase_same_head success --onto master... master
+test_rebase_same_head success --keep-base master
+test_rebase_same_head success --keep-base
 test_rebase_same_head success --fork-point --onto B B
 test_rebase_same_head success --fork-point --onto B... B
 test_rebase_same_head success --fork-point --onto master... master
+test_rebase_same_head success --fork-point --keep-base master
 
 test_done
-- 
2.21.0.944.gce45564dfd

