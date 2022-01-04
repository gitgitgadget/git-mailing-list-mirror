Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30101C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 14:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiADOtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiADOtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 09:49:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F1C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 06:49:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v6so14964075wra.8
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oSae2Ip8yNdGVgqWWrq5h6MbWREdyktffN1q7ywrdUs=;
        b=NFZCJ/kSxZpxIOi1Hh+l96uAc/lqy8Oje1ZjKzNsWSr7MROeLHGQSXC8hqcC3bPoVR
         HwfSeSrV/MsXmqM4Xq+px0DBCEhWCChnrEwhnEsld0PcXqY/MWJEl0ZSIUgDt6VpSzax
         8SNYpW9prl5e6QI4m1++6/DNI48+ZccjT8p8W3gxq91889MXeW8T00OlLr5Dr8TXd1aH
         xigL/8XYDdtxfJ0l7uE1PZ3TMNZ/Pxkbw4XfEcUq6NDP3tqri8n/JIOFflz+Kx/dHxHj
         j2Y53aXHfnhZgltflIG4w+iy04Dnwllj6hFk46I0NUrgIqHq/t1x6D4pgU1bY7YVT1Qc
         qkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oSae2Ip8yNdGVgqWWrq5h6MbWREdyktffN1q7ywrdUs=;
        b=32BXBHtxkXorxAJBrfczbLv6iqkBX0yb4+lVdKAXdFEr5Rmc60YR8n0i6GY9o2aKYK
         6l+8O6a/LDZ4dbSg+Rui4EZInnPJANTbJ8W9nxQ4EzKZRIYFR5IUDcWaMeLqAMKOZx8Y
         7cRbVkJ9njNg7yGBY4+PGTGqx8QM2D9Sv9SWR5fwufKCfhRT1triCl4wzn7eaduzNwwA
         MTQtlOJytDdVnbN30D7UhKqgDUJwUUf7rFu7KEmGfAAqNmEvLtUUVE9S8/537rwEhzSp
         bKx6u9h95teWfafAaeYA44yDu0FCkmPqSF2Gx2ypDF6lCXa2lukM5YROYfPOCd6PqDtu
         /E3w==
X-Gm-Message-State: AOAM532qnaP4uKKt/ikanomKr+cRVJ6yGJjoj4B7arUW4oVnsqlIK3I1
        IYC9nBS+N5Rt9r9NLmjIH3YIBlj0iVo=
X-Google-Smtp-Source: ABdhPJzTBgP+I7mYdbXbE7lQqIjpBrkgPehHkI40MikJxoMlevweevGuOdOuRisNl3EHk8WfonItQA==
X-Received: by 2002:a5d:6dd1:: with SMTP id d17mr27801719wrz.520.1641307778169;
        Tue, 04 Jan 2022 06:49:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm37563907wru.66.2022.01.04.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:49:37 -0800 (PST)
Message-Id: <4e9200922a4c2c91e69e3b497fbf4c8702046a27.1641307776.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 14:49:35 +0000
Subject: [PATCH v4 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Introduce a --annotate-stdin that is functionally equivalent of --stdin.
--stdin does not behave as --stdin in other subcommands, such as
pack-objects whereby it takes one argument per line. Since --stdin can
be a confusing and misleading name, rename it to --annotate-stdin.

This change adds a warning to --stdin warning that it will be removed in
the future.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 Documentation/git-name-rev.txt       | 30 ++++++++++++++++++++++++++--
 builtin/name-rev.c                   | 19 +++++++++++++-----
 t/t3412-rebase-root.sh               |  2 +-
 t/t4202-log.sh                       |  2 +-
 t/t6007-rev-list-cherry-pick-file.sh | 26 ++++++++++++------------
 t/t6012-rev-list-simplify.sh         |  2 +-
 t/t6111-rev-list-treesame.sh         |  3 ++-
 t/t6120-describe.sh                  |  9 +++++++--
 8 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 5cb0eb0855f..96e8fd5ea47 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -42,11 +42,37 @@ OPTIONS
 --all::
 	List all commits reachable from all refs
 
---stdin::
+--annotate-stdin::
 	Transform stdin by substituting all the 40-character SHA-1
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
 	--name-only, substitute with "$rev_name", omitting $hex
-	altogether.  Intended for the scripter's use.
+	altogether.
+
+For example:
+
+----------
+$ cat sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+
+$ git name-rev --annotate-stdin <sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907 (master),
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+
+$ git name-rev --name-only --annotate-stdin <sample.txt
+
+An abbreviated revision 2ae0a9cb82 will not be substituted.
+The full name after substitution is master,
+while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
+----------
+
+--stdin::
+	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
+	They are functionally equivalent.
 
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 27f60153a6c..21370afdaf9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -527,7 +527,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
 {
 	struct object_array revs = OBJECT_ARRAY_INIT;
-	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
+	int all = 0, annotate_stdin = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
@@ -539,6 +539,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
 		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
+		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
@@ -554,11 +555,19 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	init_commit_rev_name(&rev_names);
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
-	if (all + transform_stdin + !!argc > 1) {
+
+	if (transform_stdin) {
+		warning("--stdin is deprecated. Please use --annotate-stdin instead, "
+					"which is functionally equivalent.\n"
+					"This option will be removed in a future release.");
+		annotate_stdin = 1;
+	}
+
+	if (all + annotate_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-	if (all || transform_stdin)
+	if (all || annotate_stdin)
 		cutoff = 0;
 
 	for (; argc; argc--, argv++) {
@@ -613,8 +622,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	for_each_ref(name_ref, &data);
 	name_tips();
 
-	if (transform_stdin) {
-		char buffer[2048];
+	if (annotate_stdin) {
+		struct strbuf sb = STRBUF_INIT;
 
 		while (!feof(stdin)) {
 			char *p = fgets(buffer, sizeof(buffer), stdin);
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 19c6f4acbf6..1e9f7833dd6 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -11,7 +11,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 log_with_names () {
 	git rev-list --topo-order --parents --pretty="tformat:%s" HEAD |
-	git name-rev --stdin --name-only --refs=refs/heads/$1
+	git name-rev --annotate-stdin --name-only --refs=refs/heads/$1
 }
 
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 50495598619..dc884107de4 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -659,7 +659,7 @@ EOF
 
 test_expect_success 'log --graph with full output' '
 	git log --graph --date-order --pretty=short |
-		git name-rev --name-only --stdin |
+		git name-rev --name-only --annotate-stdin |
 		sed "s/Merge:.*/Merge: A B/;s/ *\$//" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index aebe4b69e13..6f3e5439771 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -58,7 +58,7 @@ EOF
 
 test_expect_success '--left-right' '
 	git rev-list --left-right B...C > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
@@ -78,14 +78,14 @@ EOF
 
 test_expect_success '--cherry-pick bar does not come up empty' '
 	git rev-list --left-right --cherry-pick B...C -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
 
 test_expect_success 'bar does not come up empty' '
 	git rev-list --left-right B...C -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
@@ -97,14 +97,14 @@ EOF
 
 test_expect_success '--cherry-pick bar does not come up empty (II)' '
 	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
 
 test_expect_success 'name-rev multiple --refs combine inclusive' '
 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
-	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/F" --refs="*tags/E" \
 		<actual >actual.named &&
 	test_cmp expect actual.named
 '
@@ -116,7 +116,7 @@ EOF
 test_expect_success 'name-rev --refs excludes non-matched patterns' '
 	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
-	git name-rev --stdin --name-only --refs="*tags/F" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/F" \
 		<actual >actual.named &&
 	test_cmp expect actual.named
 '
@@ -128,14 +128,14 @@ EOF
 test_expect_success 'name-rev --exclude excludes matched patterns' '
 	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
 	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" --exclude="*E" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" --exclude="*E" \
 		<actual >actual.named &&
 	test_cmp expect actual.named
 '
 
 test_expect_success 'name-rev --no-refs clears the refs list' '
 	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
-	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
 		<expect >actual &&
 	test_cmp expect actual
 '
@@ -149,7 +149,7 @@ EOF
 
 test_expect_success '--cherry-mark' '
 	git rev-list --cherry-mark F...E -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
@@ -163,7 +163,7 @@ EOF
 
 test_expect_success '--cherry-mark --left-right' '
 	git rev-list --cherry-mark --left-right F...E -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
@@ -174,14 +174,14 @@ EOF
 
 test_expect_success '--cherry-pick --right-only' '
 	git rev-list --cherry-pick --right-only F...E -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
 
 test_expect_success '--cherry-pick --left-only' '
 	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
@@ -193,7 +193,7 @@ EOF
 
 test_expect_success '--cherry' '
 	git rev-list --cherry F...E -- bar > actual &&
-	git name-rev --stdin --name-only --refs="*tags/*" \
+	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
 		< actual > actual.named &&
 	test_cmp expect actual.named
 '
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 4f7fa8b6c03..4fedc614fa6 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -12,7 +12,7 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
+	git name-rev --tags --annotate-stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
 }
 
 #
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index e07b6070e0e..90ff1416400 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -23,7 +23,8 @@ note () {
 }
 
 unnote () {
-	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
+	git name-rev --tags --annotate-stdin | \
+	sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
 }
 
 test_expect_success setup '
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index d8af2bb9d2b..9781b92aedd 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -270,7 +270,7 @@ test_expect_success 'name-rev --all' '
 	test_cmp expect actual
 '
 
-test_expect_success 'name-rev --stdin' '
+test_expect_success 'name-rev --annotate-stdin' '
 	>expect.unsorted &&
 	for rev in $(git rev-list --all)
 	do
@@ -278,11 +278,16 @@ test_expect_success 'name-rev --stdin' '
 		echo "$rev ($name)" >>expect.unsorted || return 1
 	done &&
 	sort <expect.unsorted >expect &&
-	git rev-list --all | git name-rev --stdin >actual.unsorted &&
+	git rev-list --all | git name-rev --annotate-stdin >actual.unsorted &&
 	sort <actual.unsorted >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'name-rev --stdin deprecated' "
+	git rev-list --all | git name-rev --stdin 2>actual &&
+	grep -E 'warning: --stdin is deprecated' actual
+"
+
 test_expect_success 'describe --contains with the exact tags' '
 	echo "A^0" >expect &&
 	tag_object=$(git rev-parse refs/tags/A) &&
-- 
gitgitgadget

