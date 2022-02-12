Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1976C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiBLUfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiBLUfF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC1606E7
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso9267603wme.5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YC+PILdDKMPHMPRXjtSVNKuqv2zXYvxMiGpRu5YK0sg=;
        b=MisPVKfgIGZzq7GhSDRzfwFJPhKgJ3NRDXsyOqFD+i5Cd1W7HergCEW7t9nbxHk78G
         NCEjboZtgXHZB2qYH68QtkKeS8tvUiFkKfDPlWoaTNDZ06g9AxQNclFi9p8PVk2xum81
         fD6OkBix4f65qLqrtR4X4xJpwFW77CP8MRfKeyTKR/zYfDjLsIw++d8IKGBW8jDmSGXp
         e/qAe9aZvON1HcI/NfalK0wvmDfEsFElvpg6ZX2sKEyZlsDTY0J5Lk40lgngKiWgpb7N
         yHQEau8lIvn6PHn0hEDWWIvzGvF/RFXFyT2VwGi5kcoSRQTRDi4lYkHeOKSqFJFvXIeH
         BE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YC+PILdDKMPHMPRXjtSVNKuqv2zXYvxMiGpRu5YK0sg=;
        b=PbkqIdXu2gBJJHE3zn478wYmgTRFkAB32PKtUu+Nj4okKghpysPIyXfL23e2V0G38Z
         +KEnHAnWAbGpy68/BHb8qus44+pqykgVgZ49oXVAqus1VPckcttGLuv5eFRzzWBArx/i
         R8fi4mGdca+GFrSC207aGr/u5NHu1LyiMo22SR3AyQW/ZVAB8xywfB3O+7FjXTYdWGWS
         h2hIs5E4xt7V79LH0Z/XWpRQkkoi0M+VQMIwsZHCMBUhbCtBsv6yAwrbGbhITDgmTbvL
         1lEotLTLNdW5bVv9oDLBjyJMSF9IkWh+VT8w//1iE9bfHOkb0S60i+INVBIvm6jZ3Dj8
         C+2A==
X-Gm-Message-State: AOAM5311bUVcX6vZGc1xLDFLAojQJ5jR7TKpQ4UqzNfTGdBokjDpYKJ3
        vGBuoo9vWqGRem5AycrYHCPOjqoLiAY=
X-Google-Smtp-Source: ABdhPJzI4BToGUlia1p7xVHRUeDJsRFb9l8uMPgd0h/nR5z6yFqIQ1TIddGCfKVlraeZgBNqvhPSQg==
X-Received: by 2002:a05:600c:588:: with SMTP id o8mr5094133wmd.103.1644698099695;
        Sat, 12 Feb 2022 12:34:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm18179723wrt.57.2022.02.12.12.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:34:59 -0800 (PST)
Message-Id: <fa55cb4d644ef7513001d88081f6db8df4265141.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:47 +0000
Subject: [PATCH v4 06/12] merge-tree: support including merge messages in
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
index 586733ea564..869c38f8223 100644
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
index e4f9421c105..25adcf36bdf 100755
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

