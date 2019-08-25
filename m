Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2ED1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfHYJMV (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:21 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39027 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYJMV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:21 -0400
Received: by mail-io1-f46.google.com with SMTP id l7so30265370ioj.6
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DymdOq3Oy0KwT9O5nYN6H+Nqa1pxqf/Y0Qpogghyof0=;
        b=P/7QdCBfm2We6AQvzMrjKn6B8wiyCVYDS2UwyzWWzirwmCyAIWHuMWWLwn7l1DMg+o
         c7fw7A9ll29r20OCLpMx2cpvCyaCbNXQVHElm+guiz5mnQcDfywlTi5BOMhIUsRLJy2l
         xt2X7b/ag8W62szYM78f++A0tP6+T2Wkw04dowp+XJULzRDvX7qW07tXFqXog8ouO6GD
         l+rZlDkeUjiemTJX6tjGwVTLJaTShfjMMvMdBKDl9QNgIfs5qmTv7zJWQyfTQl/wciE8
         zEucucbqUUFrEs32t8mlKYXjADz/PPtrdKzGDkBVMfBBDSqGIYw7VFsEmOoCpxwwTDJ5
         ktJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DymdOq3Oy0KwT9O5nYN6H+Nqa1pxqf/Y0Qpogghyof0=;
        b=Sx/uUYAM14Gon4tJjrQ1aoHkwm/DIY1YYJHnoMPBJ3QPh41fvfUrUidS8oAk0dECa/
         iObDVNdSvTEgRcK2fdYF5xYf2rnDZFXH/FbNRLKiTKE8r8mk47sJ1dcxqLKlrDehoa9w
         Ye2efeyxYkjRsdqCSHTz0CySJ4IdsJSTNV937oV98wf+0XuQWQFZu2C10ZGTqXvW3c59
         F13aZANpVBSCjTpAyLPtlfKLW4psz1Kf2p2pj/8iPmXHS4/FZJ7f1HRbEN1c980N1Oer
         wmP6z77MiR7loqyx234pnzciRp9PKydMQHFTe2gzgliRn1xZ++cOet9IuW64m+qnAOuP
         2L6A==
X-Gm-Message-State: APjAAAUDLTDxW/0v1Cm2m6BrMhn7FFL5AWDY0ZGsiEqhIs6nqsILRW0H
        0mfs3TtILh8xj5gOUSOhbhQS+rPE
X-Google-Smtp-Source: APXvYqzjzqYORgogkYvXjV7iIBXOCO1L/AO9NvRYQSQLfgGOZYJHl/1Dm+7Ln9fXg1/8CwSRyQTcLg==
X-Received: by 2002:a5e:8344:: with SMTP id y4mr10525087iom.213.1566724339736;
        Sun, 25 Aug 2019 02:12:19 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id n21sm6453128iom.69.2019.08.25.02.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:19 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 9/9] rebase: teach rebase --keep-base
Message-ID: <6927aba6176fb1b6f30c63e7d8c096861b2f0141.1566724236.git.liu.denton@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
also developed further and it is sometimes not the best idea to keep
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
 Documentation/git-rebase.txt           | 30 ++++++++++++--
 builtin/rebase.c                       | 32 ++++++++++++---
 contrib/completion/git-completion.bash |  2 +-
 t/t3416-rebase-onto-threedots.sh       | 57 ++++++++++++++++++++++++++
 t/t3431-rebase-fork-point.sh           |  4 ++
 t/t3432-rebase-fast-forward.sh         | 11 +++++
 6 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6156609cf7..3146c1592d 100644
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
 'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
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
@@ -870,7 +894,7 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       --interactive` will be **resurrected**!
 
 The idea is to manually tell 'git rebase' "where the old 'subsystem'
-ended and your 'topic' began", that is, what the old merge-base
+ended and your 'topic' began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
 of the old 'subsystem', for example:
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b78bd92002..1a49060973 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -29,8 +29,8 @@
 #include "rebase-interactive.h"
 
 static char const * const builtin_rebase_usage[] = {
-	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
-		"[<upstream>] [<branch>]"),
+	N_("git rebase [-i] [options] [--exec <cmd>] "
+		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
 	N_("git rebase --continue | --abort | --skip | --edit-todo"),
@@ -1397,6 +1397,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
+	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
@@ -1415,6 +1416,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "keep-base", &keep_base,
+			 N_("use the merge-base of upstream and branch as the current base")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
@@ -1568,6 +1571,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		warning(_("git rebase --preserve-merges is deprecated. "
 			  "Use --rebase-merges instead."));
 
+	if (keep_base) {
+		if (options.onto_name)
+			die(_("cannot combine '--keep-base' with '--onto'"));
+		if (options.root)
+			die(_("cannot combine '--keep-base' with '--root'"));
+	}
+
 	if (action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
@@ -1903,12 +1913,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index e087c4bf00..71e7159694 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2030,7 +2030,7 @@ _git_rebase ()
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
index fbedfe7b4a..2f9f82be10 100755
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
 
 test_expect_success 'add work same to side' '
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
 
 test_expect_success 'add work same to upstream' '
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
2.23.0.248.g3a9dd8fb08

