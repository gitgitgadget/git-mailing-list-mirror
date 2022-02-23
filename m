Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CBDC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiBWHsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiBWHrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620031920
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v21so2855985wrv.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LeY7XdOUECJwKHVlDjMn42GMKPkAu2BcGKlu3wOY/aI=;
        b=nagSDn4PPLiuQTiTT4pJRG/tD0vyr/wo4jyNakNb95wqKfyOgwaWepIU0p438nqcOc
         eYzl3pSx7n8sbXt9MxQOhAvMQ5dT/ev1+ex3TM6XvmwHDhE9HREow4+dMKEdA2YyssO0
         izNzE+hLzjEC+WNvysIBdGOQ7SAUhhOJ9zEALcVYHk+knQnhkMtWs7DX36TZ59Q77Vo4
         9W/SdNEpyRR2m79frb8xWiMQw68zBKn/bP1UEZKplDSZYnj+0LLV26xs+2oeWrDfh6br
         7pKExKoAMCgZlD4hB3qmbJ+kcC5nW/IoTxT36Cj04CQEPPweki0rZoiCQdwLjq6AoSNE
         qGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LeY7XdOUECJwKHVlDjMn42GMKPkAu2BcGKlu3wOY/aI=;
        b=FvcfiE+FsdTdCaTwj51obLgswUclvekGKlKsGN+sw4hbPB1twu4FHa07Fm/pS9AU3/
         nX2Fjve6RPxyURJfGB7JR/egTver9vXNivl3r5ESFE4SbTj4J37aPkFtmGgSjjJ3ulo+
         +qBaLhAiAqASxT22urYHp+VnvhoR+7dA4c2nFq+aUiszi3Z80W887AORBTBwl1b9/REi
         gjvGi0IMWKESHyXtVSkwouF/T9PszjnlwTcH2lxqLTIpb6h1iR7rz3sLxxKc7hZQNelr
         tDnAWK/NhpVG+KJTLBrF5hRRuV6N8pcuE4GJMTzYj0n30EDIn4NL7yOcVthyQY/W9f2g
         NJfw==
X-Gm-Message-State: AOAM532pOO1VILwWQS7N/KJCYs2pQqrart8KtF4bANtYS3lS2tRReZt1
        bzNVgjj5nBZBcn/a9KYDMUDnCkqKZSY=
X-Google-Smtp-Source: ABdhPJyo0Q//2CsEUJ/+ATz95So/CntaiKflNL/k1CXJrCLpWJIDF8fqN3vdSfNMJjDrV1coRkZ7Rw==
X-Received: by 2002:a5d:6343:0:b0:1e6:9825:101e with SMTP id b3-20020a5d6343000000b001e69825101emr22441356wrw.570.1645602424314;
        Tue, 22 Feb 2022 23:47:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm844154wrf.15.2022.02.22.23.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:47:03 -0800 (PST)
Message-Id: <22297e6ce75fc232125798e65d0887c5b660900f.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:51 +0000
Subject: [PATCH v6 10/12] merge-tree: allow `ls-files -u` style info to be NUL
 terminated
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

Much as `git ls-files` has a -z option, let's add one to merge-tree so
that the conflict-info section can be NUL terminated (and avoid quoting
of unusual filenames).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 21 +++++++++++++----
 builtin/merge-tree.c             |  6 +++--
 t/t4301-merge-tree-write-tree.sh | 40 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index b89aabdb98e..75b57f8abab 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -40,6 +40,12 @@ After the merge completes, a new toplevel tree object is created.  See
 OPTIONS
 -------
 
+-z::
+	Do not quote filenames in the <Conflicted file info> section,
+	and end each filename with a NUL character rather than
+	newline.  Also begin the messages section with a NUL character
+	instead of a newline.  See <<OUTPUT>> below for more information.
+
 --name-only::
 	In the Conflicted file info section, instead of writing a list
 	of (mode, oid, stage, path) tuples to output for conflicted
@@ -76,7 +82,8 @@ OID of toplevel tree
 
 This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
-files within this tree may have embedded conflict markers.
+files within this tree may have embedded conflict markers.  This section
+is always followed by a newline (or NUL if `-z` is passed).
 
 [[CFI]]
 Conflicted file info
@@ -89,20 +96,26 @@ This is a sequence of lines with the format
 The filename will be quoted as explained for the configuration
 variable `core.quotePath` (see linkgit:git-config[1]).  However, if
 the `--name-only` option is passed, the mode, object, and stage will
-be omitted.
+be omitted.  If `-z` is passed, the "lines" are terminated by a NUL
+character instead of a newline character.
 
 [[IM]]
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
-This always starts with a blank line to separate it from the previous
-sections, and then has free-form messages about the merge, such as:
+This always starts with a blank line (or NUL if `-z` is passed) to
+separate it from the previous sections, and then has free-form
+messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
   * "Failed to merge submodule <submodule> (<reason>)"
   * "Warning: cannot merge binary files: <filename>"
 
+Note that these free-form messages will never have a NUL character
+in or between them, even if -z is passed.  It is simply a large block
+of text taking up the remainder of the output.
+
 EXIT STATUS
 -----------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 4a79caf081a..767892006e3 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -445,7 +445,7 @@ static int real_merge(struct merge_tree_options *o,
 	if (o->show_messages == -1)
 		o->show_messages = !result.clean;
 
-	puts(oid_to_hex(&result.tree->object.oid));
+	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
 		const char *last = NULL;
@@ -467,7 +467,7 @@ static int real_merge(struct merge_tree_options *o,
 		string_list_clear(&conflicted_files, 1);
 	}
 	if (o->show_messages) {
-		printf("\n");
+		putchar(line_termination);
 		merge_display_update_messages(&opt, &result);
 	}
 	merge_finalize(&opt, &result);
@@ -493,6 +493,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_SET_INT('z', NULL, &line_termination,
+			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F(0, "name-only",
 			   &o.name_only,
 			   N_("list filenames without modes/oids/stages"),
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 0ec5f0d3f7e..22e03f0939c 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -173,4 +173,44 @@ test_expect_success 'Check conflicted oids and modes without messages' '
 	test_cmp conflicted-file-info actual
 '
 
+test_expect_success 'NUL terminated conflicted file "lines"' '
+	git checkout -b tweak1 side1 &&
+	test_write_lines zero 1 2 3 4 5 6 >numbers &&
+	git add numbers &&
+	git mv numbers "Αυτά μου φαίνονται κινέζικα" &&
+	git commit -m "Renamed numbers" &&
+
+	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
+	anonymize_hash out >actual &&
+
+	# Expected results:
+	#   "greeting" should merge with conflicts
+	#   "whatever" has *both* a modify/delete and a file/directory conflict
+	#   "Αυτά μου φαίνονται κινέζικα" should have a conflict
+	echo HASH | lf_to_nul >expect &&
+
+	q_to_tab <<-EOF | lf_to_nul >>expect &&
+	100644 HASH 1Qgreeting
+	100644 HASH 2Qgreeting
+	100644 HASH 3Qgreeting
+	100644 HASH 1Qwhatever~tweak1
+	100644 HASH 2Qwhatever~tweak1
+	100644 HASH 1QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 2QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 3QΑυτά μου φαίνονται κινέζικα
+
+	EOF
+
+	cat <<-EOF >>expect &&
+	Auto-merging greeting
+	CONFLICT (content): Merge conflict in greeting
+	CONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
+	CONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
+	Auto-merging Αυτά μου φαίνονται κινέζικα
+	CONFLICT (content): Merge conflict in Αυτά μου φαίνονται κινέζικα
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

