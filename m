Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7EC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiBWHrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiBWHrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157C6662D
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q23so3407359wra.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WpxAId1kdO/lJ7t476gCpgr/ZvqAUZeQTXQX9mQSlaQ=;
        b=S9xTDzErfMmppiv3eCkDlipXgj3TOG4Ug+9j4vopWhR2JS96hkaUq827YdtDFVuRgs
         a9GdctTTVtCWQXBzMTiOecx/4Lmz9W6tXX5Z8WODlPvTOWuIvTixlwsRer+6q6n1XTzs
         xAjyQcFOClAYbW3KERS0bbJvnkO7ew89ipgBNdcQ+QQsVxRHt5PCuAb5FEl97XiJ0enu
         Vu4cCX2psYcj0NEbYgzf1hL0M687SNmWe0jt43lff/a3QHpwH//SIRblTS8EWnO9CQKI
         YhLtAA+WJ+P/sbBAiOeC4s/c+YsiohlM8B88PzqDRTDDJNmGBbhk3clWYhjNm/3ndrel
         cJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WpxAId1kdO/lJ7t476gCpgr/ZvqAUZeQTXQX9mQSlaQ=;
        b=rkm1Ze4xG3sXLQonpGlGr6EqUEAeMevP7zQG5SFOtIDrAYDXsKeFUVakWQf5VvD2G3
         3jUzp3pwjmm/Uk82WTmAJlLTtj+dtiz9xTIDqf/QmGYMfaWl97Vydh5hhCio1zIfM6xT
         qKIklmDN7n1xzlwkK0dSN6NJG6ksKZhstInfyRny5txYRM3roRY5X/Xen1ZIZ7qO4XDr
         0lLMtcC/l6FR0B/M6LnLt6DTu8b0/tZNdoYwwjJgupWBGUxYz5Se/0K4/g3uNo1BUjBY
         0BSsqazPlQKmbLSG64TJy6wtIJDBUwPltk8UVmUZFIC7LBpZmQpQR4E/OhRAx3wu+6a8
         VcTw==
X-Gm-Message-State: AOAM5319B+c1yJY3pSJAbVuymNxXDmRnNcWdq5Gpgeh93zxcRsOE1agS
        wBJMa3H2txOMRoTVl2N8MCEssI8/CmU=
X-Google-Smtp-Source: ABdhPJyNI8KQw7C8Kp02KCA73lTuDAVTiIUPnbB56yvFDGIfPD5zRgjwOFr2sKJe7r4zd+jPaI14xQ==
X-Received: by 2002:a05:6000:1445:b0:1e8:49ec:5c22 with SMTP id v5-20020a056000144500b001e849ec5c22mr22410328wrx.87.1645602420554;
        Tue, 22 Feb 2022 23:47:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3sm18870379wrm.69.2022.02.22.23.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:47:00 -0800 (PST)
Message-Id: <17b57efb71404a21b05db8284e8dfd2978e6a3dd.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:47 +0000
Subject: [PATCH v6 06/12] merge-tree: support including merge messages in
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

