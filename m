Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3171EC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiBTGzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiBTGzM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:12 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FAF3587F
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so5886475wrf.1
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hlm+FxseD64b/QTR4+4MuccqKwPuYMbNm71T37iVhh0=;
        b=WgnQ55xUlbLXnhyCQrlcOoYvAThKkbCw2SXruWlU6C5kzWy8vjbEDCLJzRkjZXVPUt
         irTXYqyWHuCWJgVf1h34Rw0PrcLic8BVqrN5VZ3gwYG7vmyW019ieUHbbpPpwrsFiRkB
         cBFV6+GpklB2oPHNoPfGqx8Y7tPq5STkdV4cxwycgHnGAR3o/4XEnsjlY11K0rydbpUI
         s9VDOMrPWD1uXMAyXd+vV1H+SPYzIL9bYadqHpi8LLrv+GdLV0WtSnmC+QY+bUvrRpCv
         Tle9ObRwRECBGegr3rQ1NnCR4emPaZ8cftaDd+7Zq3lJwdT5CPE00MEYrwpYAowKGa3v
         bl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hlm+FxseD64b/QTR4+4MuccqKwPuYMbNm71T37iVhh0=;
        b=v6EzodgtlhjqQNUDYmE2o/bts/AjJn1yIGN83NbmmPoVLSgxMVhMK6wHd+iAU6Q+yf
         As2WbzMyB5yEfNs6+gwKjnfmmMp8FgkYd5hSAmry0Hfecx/UKxTqkcBjo2aUoE6useQm
         Vlh1aNVcEYvOymNm2sczFomcXFYD/wyCgE0agdllmv2PTBKkg+JSfqHA5J9fpwnVif4M
         7rFkCq9v87961dVJBbzhqRr8KlRd96LiFohvm1YudCIDU5tGKRY+NWm79jR4DaOV5Alm
         S/G0UrR3j8fxPwapka+wMpWKOkBT9+8r1NhYJg+XLVUdJqGxBj4/d4BRrxR3Bz1HAMdT
         PooA==
X-Gm-Message-State: AOAM533I7Ay9wVDEe2tgti7mrDuVeW708UtzhZFiNv+Pv+iZP8pX5n+p
        Sxa65XtBZDp76GEVB6ra52VALH30dso=
X-Google-Smtp-Source: ABdhPJykACNVYINSNUeyliOZLSdIbzRCFaCmjyO1wW1ezQDyDdNdMAILTxEK7M8xeS+eZligZParng==
X-Received: by 2002:a05:6000:2a2:b0:1e8:6dd5:767b with SMTP id l2-20020a05600002a200b001e86dd5767bmr11118341wry.444.1645340088461;
        Sat, 19 Feb 2022 22:54:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm16707894wro.104.2022.02.19.22.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:48 -0800 (PST)
Message-Id: <90c4adecb23770febc204b9061c8da0cd517c8a2.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:36 +0000
Subject: [PATCH v5 06/12] merge-tree: support including merge messages in
 output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When running `git merge-tree --write-tree`, we previously would only
return an exit status reflecting the cleanness of a merge, and print out
the toplevel tree of the resulting merge.  Merges also have
informational messages, such as:
  * "Auto-merging <PATH>"
  * "CONFLICT (content): ..."
  * "CONFLICT (file/directory)"
  * etc.
In fact, when non-content conflicts occur (such as file/directory,
modify/delete, add/add with differing modes, rename/rename (1to2),
etc.), these informational messages may be the only notification the
user gets since these conflicts are not representable in the contents
of the file.

Add a --[no-]messages option so that callers can request these messages
be included at the end of the output.  Include such messages by default
when there are conflicts, and omit them by default when the merge is
clean.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 45 +++++++++++++++++++++++++++-----
 builtin/merge-tree.c             | 21 +++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 37 ++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 589a83738ce..f415d6de5a3 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' [--write-tree] <branch1> <branch2>
+'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
 'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
 
 DESCRIPTION
@@ -47,17 +47,47 @@ than the first form even on successful merges (especially if working
 in large repositories).  The remainder of this manual will only
 discuss the first form.
 
+OPTIONS
+-------
+
+--[no-]messages::
+	Write any informational messages such as "Auto-merging <path>"
+	or CONFLICT notices to the end of stdout.  If unspecified, the
+	default is to include these messages if there are merge
+	conflicts, and to omit them otherwise.
+
 OUTPUT
 ------
 
-For either a successful or conflicted merge, the output from
-git-merge-tree is simply one line:
+By default, for a successful merge, the output from git-merge-tree is
+simply one line:
+
+	<OID of toplevel tree>
+
+Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Informational messages>
+
+These are discussed individually below.
 
-The printed tree object corresponds to what would be checked out in
-the working tree at the end of `git merge`, and thus may have files
-with conflict markers in them.
+OID of toplevel tree
+~~~~~~~~~~~~~~~~~~~~
+
+This is a tree object that represents what would be checked out in the
+working tree at the end of `git merge`.  If there were conflicts, then
+files within this tree may have embedded conflict markers.
+
+Informational messages
+~~~~~~~~~~~~~~~~~~~~~~
+
+This always starts with a blank line to separate it from the previous
+section, and then has free-form messages about the merge, such as:
+
+  * "Auto-merging <file>"
+  * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
+  * "Failed to merge submodule <submodule> (<reason>)"
+  * "Warning: cannot merge binary files: <filename>"
 
 EXIT STATUS
 -----------
@@ -79,6 +109,9 @@ Thus, it could be used as a part of a series of steps such as
        NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
 
+Note that when the exit status is non-zero, NEWTREE in this sequence
+will contain a lot more output than just a tree.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index af445cb1576..d44e8d087b1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -396,6 +396,7 @@ enum mode {
 
 struct merge_tree_options {
 	int mode;
+	int show_messages;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -438,18 +439,27 @@ static int real_merge(struct merge_tree_options *o,
 	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
 	if (result.clean < 0)
 		die(_("failure to merge"));
+
+	if (o->show_messages == -1)
+		o->show_messages = !result.clean;
+
 	puts(oid_to_hex(&result.tree->object.oid));
+	if (o->show_messages) {
+		printf("\n");
+		merge_display_update_messages(&opt, &result);
+	}
 	merge_finalize(&opt, &result);
 	return !result.clean; /* result.clean < 0 handled above */
 }
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	struct merge_tree_options o = { 0 };
+	struct merge_tree_options o = { .show_messages = -1 };
 	int expected_remaining_argc;
+	int original_argc;
 
 	const char * const merge_tree_usage[] = {
-		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
+		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
 		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
 		NULL
 	};
@@ -459,10 +469,13 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    MODE_REAL),
 		OPT_CMDMODE(0, "trivial-merge", &o.mode,
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
+		OPT_BOOL(0, "messages", &o.show_messages,
+			 N_("also show informational/conflict messages")),
 		OPT_END()
 	};
 
 	/* Parse arguments */
+	original_argc = argc - 1; /* ignoring argv[0] */
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	switch (o.mode) {
@@ -486,8 +499,12 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 		break;
 	case MODE_TRIVIAL:
 		expected_remaining_argc = 3;
+		/* Removal of `--trivial-merge` is expected */
+		original_argc--;
 		break;
 	}
+	if (o.mode == MODE_TRIVIAL && argc < original_argc)
+		die(_("--trivial-merge is incompatible with all other options"));
 
 	if (argc != expected_remaining_argc)
 		usage_with_options(merge_tree_usage, mt_options);
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 6d321652e21..719d81e7173 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -103,4 +103,41 @@ test_expect_success 'Barf on too many arguments' '
 	grep "^usage: git merge-tree" expect
 '
 
+anonymize_hash() {
+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" "$@"
+}
+
+test_expect_success 'test conflict notices and such' '
+	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
+	anonymize_hash out >actual &&
+
+	# Expected results:
+	#   "greeting" should merge with conflicts
+	#   "numbers" should merge cleanly
+	#   "whatever" has *both* a modify/delete and a file/directory conflict
+	cat <<-EOF >expect &&
+	HASH
+
+	Auto-merging greeting
+	CONFLICT (content): Merge conflict in greeting
+	Auto-merging numbers
+	CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
+	CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
+	EOF
+
+	test_cmp expect actual
+'
+
+for opt in $(git merge-tree --git-completion-helper-all)
+do
+	if test $opt = "--trivial-merge" || test $opt = "--write-tree"
+	then
+		continue
+	fi
+
+	test_expect_success "usage: --trivial-merge is incompatible with $opt" '
+		test_expect_code 128 git merge-tree --trivial-merge $opt side1 side2 side3
+	'
+done
+
 test_done
-- 
gitgitgadget

