Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA487C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbiG2TaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiG2TaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:30:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006838722B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r83-20020a1c4456000000b003a3a22178beso1097754wma.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bwsJMCUaNnaQVcBetUJjAkWYzd3maTfFPvF0ly6ZmQ8=;
        b=Icje1K9kIi0tQzDMEK0N4HkDq3kTO/+Jz68QvFig3kd1JGqvE1G608mo0erZFSrf5K
         GnzAfWyH9zwa+gPxtRUsoal2C1lqEpQZVquxbPIK1vbXQgm9yAgNzbaKfY+T3jMRCoX0
         xzT4xLPIPR2tggkpYMLUcUg54dsh4DqGBplyIOent6EAnHxmuVgEkSupoP1On2NZaWEK
         2gm/lWZNnAyBo841U2knYJnFc98nwf63xg/PdWksxXa8jl+jdsMRF2nRHJmXngousqNe
         tYRYF4mOaAoQL3Zmujmd/JinZ2n/9gW8kfa4eitUGt5eW7iVUr4phXohMASShQEc/3iU
         EwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bwsJMCUaNnaQVcBetUJjAkWYzd3maTfFPvF0ly6ZmQ8=;
        b=DelFO6qoHPoSqA3+HAaV0adLjJBa5gonn0EbbdgI24Gv0qyVEWkeAU4WhrnjsoeNAs
         7GS810dQJU1+LD9RZfLadZTJ74zz4vPlv29RY/kV1A7+swaeAbzVb+BsrvUPBo4kl3CE
         83EnZRCbg85irffSJ6cRvchWoBSJ6SGPFsc2qojiiXrIrHaFYpF8CQ8FGkAoES/hE2Y8
         rzoN5pmcBfxyxrU64rmouJuiBfOEjyTdty+IDJSDyuENY/78MqaYciGL/ZpguWXrbL3J
         KveZGeX6ZCuEvExnpxXjiOJoiH+9yTyVL6QQi+QZ9Hm2TvJ51l5mx9gJd61JhJ8dYxXy
         kiKQ==
X-Gm-Message-State: AJIora9AWA5nEUJ04/RBOjKckeBRQIo5KA+evV5Lz68wP/Zj0nq5K3XX
        Q8xGOQsLQTjg2KQU/KTMvd0Fwfyh724=
X-Google-Smtp-Source: AGRyM1u9SabcDKe79lD7J68b/M9HryCDqLuJhdiJVYvjQ8J6GalrO/ByYtQfZFqZ54dLMwgOMjt86w==
X-Received: by 2002:a05:600c:19cf:b0:3a3:1df6:af0c with SMTP id u15-20020a05600c19cf00b003a31df6af0cmr3764254wmq.37.1659122988949;
        Fri, 29 Jul 2022 12:29:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3-20020a1c5403000000b003a02f957245sm9336147wmb.26.2022.07.29.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:48 -0700 (PDT)
Message-Id: <64ee889369dd4044a4acd967876476ea6cfff1c3.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:36 +0000
Subject: [PATCH v2 07/10] log: add --decorate-all option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-log.txt                     |   5 +
 builtin/log.c                                 |  27 ++++-
 t/t4013-diff-various.sh                       |   2 +
 ...f.log_--decorate=full_--decorate-all_--all |  61 +++++++++++
 .../diff.log_--decorate_--decorate-all_--all  |  61 +++++++++++
 t/t4202-log.sh                                | 103 +++++++++++++++++-
 6 files changed, 252 insertions(+), 7 deletions(-)
 create mode 100644 t/t4013/diff.log_--decorate=full_--decorate-all_--all
 create mode 100644 t/t4013/diff.log_--decorate_--decorate-all_--all

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b2ac89dfafc..633705bde90 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -56,6 +56,11 @@ If none of these options or config settings are given, then references are
 used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
 `refs/stash/`, or `refs/tags/`.
 
+--decorate-all::
+	When specified, this option clears all previous `--decorate-refs`
+	or `--decorate-refs-exclude` options and relaxes the default
+	decoration filter to include all possible decoration refs.
+
 --source::
 	Print out the ref name given on the command line by which each
 	commit was reached.
diff --git a/builtin/log.c b/builtin/log.c
index 0b5efc9434c..b7fc4946c35 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -101,6 +101,25 @@ static int parse_decoration_style(const char *value)
 	return -1;
 }
 
+static int decorate_all;
+static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
+static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+
+static int decorate_all_callback(const struct option *opt,
+				 const char *arg, int unset)
+{
+	if (unset) {
+		decorate_all = 0;
+		return 0;
+	}
+
+	string_list_clear(&decorate_refs_include, 0);
+	string_list_clear(&decorate_refs_exclude, 0);
+	decorate_all = 1;
+	return 0;
+}
+
 static int decorate_callback(const struct option *opt, const char *arg, int unset)
 {
 	if (unset)
@@ -176,7 +195,8 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 					   item->string);
 	}
 
-	if (decoration_filter->exclude_ref_pattern->nr ||
+	if (decorate_all ||
+	    decoration_filter->exclude_ref_pattern->nr ||
 	    decoration_filter->include_ref_pattern->nr ||
 	    decoration_filter->exclude_ref_config_pattern->nr)
 		return;
@@ -199,9 +219,6 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	struct userformat_want w;
 	int quiet = 0, source = 0, mailmap;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
-	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 	struct decoration_filter decoration_filter = {
 		.exclude_ref_pattern = &decorate_refs_exclude,
 		.include_ref_pattern = &decorate_refs_include,
@@ -214,6 +231,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
+		OPT_CALLBACK_F(0, "decorate-all", NULL, NULL, N_("how all ref decorations"),
+			       PARSE_OPT_NOARG, decorate_all_callback),
 		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
 		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 056e922164d..577221c71ed 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -352,6 +352,8 @@ log -GF -p --pickaxe-all master
 log -IA -IB -I1 -I2 -p master
 log --decorate --all
 log --decorate=full --all
+log --decorate --decorate-all --all
+log --decorate=full --decorate-all --all
 
 rev-list --parents HEAD
 rev-list --children HEAD
diff --git a/t/t4013/diff.log_--decorate=full_--decorate-all_--all b/t/t4013/diff.log_--decorate=full_--decorate-all_--all
new file mode 100644
index 00000000000..d6e79287846
--- /dev/null
+++ b/t/t4013/diff.log_--decorate=full_--decorate-all_--all
@@ -0,0 +1,61 @@
+$ git log --decorate=full --decorate-all --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (refs/heads/mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (refs/heads/note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4013/diff.log_--decorate_--decorate-all_--all b/t/t4013/diff.log_--decorate_--decorate-all_--all
new file mode 100644
index 00000000000..5d22618bb60
--- /dev/null
+++ b/t/t4013/diff.log_--decorate_--decorate-all_--all
@@ -0,0 +1,61 @@
+$ git log --decorate --decorate-all --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (initial)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 9ea9e835d43..e939ed34ff7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -704,9 +704,12 @@ test_expect_success 'set up more tangled history' '
 	git checkout -b tangle HEAD~6 &&
 	test_commit tangle-a tangle-a a &&
 	git merge main~3 &&
+	git update-ref refs/prefetch/merge HEAD &&
 	git merge side~1 &&
+	git update-ref refs/rewritten/merge HEAD &&
 	git checkout main &&
 	git merge tangle &&
+	git update-ref refs/hidden/tangle HEAD &&
 	git checkout -b reach &&
 	test_commit reach &&
 	git checkout main &&
@@ -974,9 +977,9 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	Merge-tag-reach (HEAD -> main)
 	reach (tag: reach, reach)
 	seventh (tag: seventh)
-	Merge-branch-tangle
-	Merge-branch-side-early-part-into-tangle (tangle)
-	tangle-a (tag: tangle-a)
+	Merge-branch-tangle (refs/hidden/tangle)
+	Merge-branch-side-early-part-into-tangle (refs/rewritten/merge, tangle)
+	Merge-branch-main-early-part-into-tangle (refs/prefetch/merge)
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="*octopus*" \
@@ -1037,6 +1040,100 @@ test_expect_success 'decorate-refs focus from default' '
 	! grep HEAD actual
 '
 
+test_expect_success '--decorate-all overrides defaults' '
+	cat >expect.default <<-\EOF &&
+	Merge-tag-reach (HEAD -> refs/heads/main)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh (tag: refs/tags/seventh)
+	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
+	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
+	reach (tag: refs/tags/reach, refs/heads/reach)
+	Merge-branch-tangle
+	Merge-branch-side-early-part-into-tangle (refs/heads/tangle)
+	Merge-branch-main-early-part-into-tangle
+	tangle-a (tag: refs/tags/tangle-a)
+	Merge-branch-side
+	side-2 (tag: refs/tags/side-2, refs/heads/side)
+	side-1 (tag: refs/tags/side-1)
+	Second
+	sixth
+	fifth
+	fourth
+	third
+	second
+	initial
+	EOF
+	git log --decorate=full --pretty="tformat:%f%d" >actual &&
+	test_cmp expect.default actual &&
+
+	cat >expect.all <<-\EOF &&
+	Merge-tag-reach (HEAD -> refs/heads/main)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh (tag: refs/tags/seventh)
+	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
+	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
+	reach (tag: refs/tags/reach, refs/heads/reach)
+	Merge-branch-tangle (refs/hidden/tangle)
+	Merge-branch-side-early-part-into-tangle (refs/rewritten/merge, refs/heads/tangle)
+	Merge-branch-main-early-part-into-tangle (refs/prefetch/merge)
+	tangle-a (tag: refs/tags/tangle-a)
+	Merge-branch-side
+	side-2 (tag: refs/tags/side-2, refs/heads/side)
+	side-1 (tag: refs/tags/side-1)
+	Second
+	sixth
+	fifth
+	fourth
+	third
+	second
+	initial
+	EOF
+	git log --decorate=full --pretty="tformat:%f%d" \
+		--decorate-all >actual &&
+	test_cmp expect.all actual
+'
+
+test_expect_success '--decorate-all clears previous exclusions' '
+	cat >expect.all <<-\EOF &&
+	Merge-tag-reach (HEAD -> refs/heads/main)
+	reach (tag: refs/tags/reach, refs/heads/reach)
+	Merge-tags-octopus-a-and-octopus-b
+	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
+	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
+	seventh (tag: refs/tags/seventh)
+	Merge-branch-tangle (refs/hidden/tangle)
+	Merge-branch-side-early-part-into-tangle (refs/rewritten/merge, refs/heads/tangle)
+	Merge-branch-main-early-part-into-tangle (refs/prefetch/merge)
+	tangle-a (tag: refs/tags/tangle-a)
+	side-2 (tag: refs/tags/side-2, refs/heads/side)
+	side-1 (tag: refs/tags/side-1)
+	initial
+	EOF
+
+	git log --decorate=full --pretty="tformat:%f%d" \
+		--simplify-by-decoration \
+		--decorate-refs-exclude="heads/octopus*" \
+		--decorate-refs="heads" \
+		--decorate-all >actual &&
+	test_cmp expect.all actual &&
+
+	cat >expect.filtered <<-\EOF &&
+	Merge-tags-octopus-a-and-octopus-b
+	octopus-b (refs/heads/octopus-b)
+	octopus-a (refs/heads/octopus-a)
+	initial
+	EOF
+
+	git log --decorate=full --pretty="tformat:%f%d" \
+		--simplify-by-decoration \
+		--decorate-refs-exclude="heads/octopus" \
+		--decorate-refs="heads" \
+		--decorate-all \
+		--decorate-refs-exclude="tags/" \
+		--decorate-refs="heads/octopus*" >actual &&
+	test_cmp expect.filtered actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
gitgitgadget

