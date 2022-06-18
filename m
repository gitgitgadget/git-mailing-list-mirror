Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C344C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383758AbiFRAVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383685AbiFRAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1859973
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so7511966wra.9
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WpxAId1kdO/lJ7t476gCpgr/ZvqAUZeQTXQX9mQSlaQ=;
        b=PTjQLfg0ZI7XjGwDl2GGKnIuKFSyPYem4ikxNOzPo3GUGk+eAf9aP1glvMPFmaZlVn
         YAr3SWsMK00/J5BP0TPbsBv9VyUerezzloLU2ThbtmdMTNHquXNOSdHL6N+F/jsuctOS
         wuEdl9VdlaA6/v12N7u9eh65R6rg2hMq3FVuXIe1hKIdzOCQQqFeWG5BZcvkf7erAY1B
         pLZXcjmiA1gn8YVSh4pCJGM0ShRwKfw2UGWblDK8H9qq5Dh+dVLZDmR5xVxWqRoDIrcY
         JSiXX+l4rGADdWAyTLpWIs+DyZXzXm9YUqc65RnMPHTolyMPUg81rQC/kiezAES/80xy
         d/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WpxAId1kdO/lJ7t476gCpgr/ZvqAUZeQTXQX9mQSlaQ=;
        b=Vafmhh622gUdgVlAmSnox04EH9NoHuIM+h0XI9QPAOF9j1CGfbYsvZzdfD56aTOC6y
         6aNjilbCS6oRUzgT4IMYJkS2o6NqiEB4ukXEhoh/GSWQnT1MWESTmX0LnvB73EhI+0FK
         0O8xYpOyvS1uh/sT+XJD+z05VqLHsNhBsNYf4PpJCl61xobXD0vac9QuSdjdF5mfIRCC
         WGeVPK8Dwf3J6SWt4scwcSEdrqXSbGaUkGASChkPB3np6zB14wyJoOlLJfHSR5oe+M7M
         jjW0e0UVEIPvef4t05RuPwsBwoegc8xxVy4BHg+LtZSMjLJvLkJDx2dfaOVaDeS8s+7j
         G2SQ==
X-Gm-Message-State: AJIora+modbik6RVWv5+qCKz4gbh4OFID4ofbWdku7f9QSSLmXZdnW3K
        gLxZmORNDXRX6ZKDntx10/uJRW2ijIE7hA==
X-Google-Smtp-Source: AGRyM1vs7UV8brxbjnl5P9i3TixrGQC+y5pKBCZdNOGrg+676NvcKiOoVigJS/yjNBMh47hsadCxow==
X-Received: by 2002:adf:fa8b:0:b0:214:1f4f:5e71 with SMTP id h11-20020adffa8b000000b002141f4f5e71mr11209722wrr.149.1655511669988;
        Fri, 17 Jun 2022 17:21:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3-20020adffbc3000000b0020e6ce4dabdsm6070589wrs.103.2022.06.17.17.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:09 -0700 (PDT)
Message-Id: <53c92a5d8d93c30305dddf8e2aa7a5e7fdfb493f.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:49 +0000
Subject: [PATCH v7 06/17] merge-tree: support including merge messages in
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
 Documentation/git-merge-tree.txt | 47 ++++++++++++++++++++++++++++----
 builtin/merge-tree.c             | 21 ++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 37 +++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 2a9c91328de..25b462be14e 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' [--write-tree] <branch1> <branch2>
+'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
 'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (deprecated)
 
 [[NEWMERGE]]
@@ -37,18 +37,50 @@ linkgit:git-merge[1], including:
 After the merge completes, a new toplevel tree object is created.  See
 `OUTPUT` below for details.
 
+OPTIONS
+-------
+
+--[no-]messages::
+	Write any informational messages such as "Auto-merging <path>"
+	or CONFLICT notices to the end of stdout.  If unspecified, the
+	default is to include these messages if there are merge
+	conflicts, and to omit them otherwise.
+
 [[OUTPUT]]
 OUTPUT
 ------
 
-For either a successful or conflicted merge, the output from
-git-merge-tree is simply one line:
+For a successful merge, the output from git-merge-tree is simply one
+line:
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
+[[OIDTLT]]
+OID of toplevel tree
+~~~~~~~~~~~~~~~~~~~~
+
+This is a tree object that represents what would be checked out in the
+working tree at the end of `git merge`.  If there were conflicts, then
+files within this tree may have embedded conflict markers.
+
+[[IM]]
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
@@ -72,6 +104,9 @@ used as a part of a series of steps such as:
        NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
        git update-ref $BRANCH1 $NEWCOMMIT
 
+Note that when the exit status is non-zero, `NEWTREE` in this sequence
+will contain a lot more output than just a tree.
+
 [[DEPMERGE]]
 DEPRECATED DESCRIPTION
 ----------------------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 2332525d8bd..831d9c77583 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -396,6 +396,7 @@ enum mode {
 
 struct merge_tree_options {
 	int mode;
+	int show_messages;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -435,18 +436,27 @@ static int real_merge(struct merge_tree_options *o,
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
@@ -456,10 +466,13 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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
@@ -483,8 +496,12 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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

