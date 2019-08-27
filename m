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
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7F21F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfH0FiK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:38:10 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:42579 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0FiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:38:10 -0400
Received: by mail-io1-f44.google.com with SMTP id e20so43332046iob.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c/5QWT3HjTnA+rxUvWPDvvkf6RmlHqU/5wxYCEgzBC4=;
        b=ZK9OSGTu6FFmK0XdsoJlzHpDzHqytxDsBy/9Om3Y+aIZkA+2CtTihNSM0f7jx3nlP1
         aMnCs96UkoDjVOEZdAuBBrQP06qVatyqGAzs7ls6qJTgA1fAPyIGjUiO1yfCkHQm33Z8
         n0FWTmu69yKGqrqfT+NGy3k7/2B383YPTWXE1yHKmty+pl4uhcP9aLEJqTUCu9nvLQoR
         I4avoVEZD5nutyE5Z26YWoh/PBx7ug+NFDI4HdP2Q/C4GMi0/I2kgFeg3WcGNcsi3kCR
         /vc0KiQspn7B/BNckHT8taaXYs6ZFMCQv8Gz5mdRbFIA3dMl9EPvOkktQv7K8R3m0BIs
         cp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c/5QWT3HjTnA+rxUvWPDvvkf6RmlHqU/5wxYCEgzBC4=;
        b=Wd2GTwQrnKH51yp7RmcHnurRJF9gpuzpESree1YpiDWTJMv4Z+R3dmnXwQXaabFKha
         imtOjTR1YQZHyS2Rpm+zesXrhj3hhBG6d9619G9kdrnQYbaw2WpU6sUhgAoc/kfLoPX8
         Y5vI2yRbMfubNg7vT4Gs0aA/L9Ym9U6x/guHFqW9NsQdeb9YC30sowd5rPCo4adUJprg
         D6SHrIHBGAvbSfVJlrznAjMuVIAVqWlIZjaf1cGIC2HfLwqKQuYG0A5d2pBKwpqaIS9m
         fT4pIjylWCCYSDXnE+z7Op64p8qbhOBLP7pVR7gWZqtXVgbskEaw5LkVliTtmyAvlm9z
         7tsA==
X-Gm-Message-State: APjAAAULW3V+Z88qKiYvZ1ZDbJe1Jyai1M5VihBZ3fl6ujaLJTLA2UCl
        0L4R55LPU6L8m/gzPOVM+TtakMR7
X-Google-Smtp-Source: APXvYqyWO0QgaCLVjJIJuwMnIE50q4lb5GOBAEdoKitGwU/MJ5huCWvTuPBKAR0yqd7m/lMAN1Fhww==
X-Received: by 2002:a6b:fd13:: with SMTP id c19mr20458903ioi.168.1566884289008;
        Mon, 26 Aug 2019 22:38:09 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id a9sm11645438iod.76.2019.08.26.22.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:38:08 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:38:06 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 9/9] rebase: teach rebase --keep-base
Message-ID: <6bc7423ac1e6f7d81de96cd4911ff652dc0e5a88.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566884063.git.liu.denton@gmail.com>
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
current 'master'. While developing the patches, 'master' is also
developed further and it is sometimes not the best idea to keep rebasing
on top of 'master', but to keep the base commit as-is.

In addition to this, a user wishing to test individual commits in a
topic branch without changing anything may run

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
index 7ef9095e7c..27d5c4e19d 100644
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
@@ -1396,6 +1396,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct rebase_options options = REBASE_OPTIONS_INIT;
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
+	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
@@ -1414,6 +1415,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "keep-base", &keep_base,
+			 N_("use the merge-base of upstream and branch as the current base")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
@@ -1567,6 +1570,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1902,12 +1912,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

