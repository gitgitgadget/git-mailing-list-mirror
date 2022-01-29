Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FD8C433FE
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353031AbiA2SHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352990AbiA2SHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC2C06174A
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso10619247wmj.2
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QUAEoi4aLmkdvqTyeW5+zkc86dJRK8t2CDOBRn9/dKI=;
        b=ShqTFqX7rqL780auB/jem5aJHr0Dmdb1DT9urDZ4L6e/TNP5oIZYSUVeDdk2DuK01o
         RqpnC0ZUct8/AY1fAkqgeADsnNGfMh3oYClom3wiMLRcjDPFYhdN7bBsF9sF+O58AWc3
         ZQHDEft61fgE/As5TS/Ob32Fog1LIpy558dZaGv8P4w1ksRa3EV5Af3bj5UsQuO9sMPG
         mmx14RjvTUF31fm0LUZMcE/vSgmSycQYfNl7URcMuEi1QY4/ZNM2LhMbWk4UqoLGuhlm
         XzrdQdiozwPEq8k0dP41Uflzv7cpKrzdAyAxsyfh1JWz4TCtfgj3WMkfAWbDPQRUw0Yg
         Zrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QUAEoi4aLmkdvqTyeW5+zkc86dJRK8t2CDOBRn9/dKI=;
        b=rfM9R1V7pz847AyRRs/1l+2X8Z7+BeFDDpye7GB6PlSZIlOdgbGI3KnVnw4+Yw4bgL
         QnnqDsGFPfzos0RqXuC0hfgYaueSZdcTaiPa+XKuaigcLdNQh48g+IJBo5BfM3ZK3lJt
         ZwcPq+c8v6+4KNOj6Qlbb51CLjtWtZ+Zit9HtFSACkYeOGlms1CP1IgnY/JtSZtXIOyb
         h5p0GBOietn6nQoSqcja+gYo92sa31sAcxGQnKMD3HNX9U3kscmjzBpFrnkWybdV4wuB
         BzNG5ePCyjhrBfIhfwXuKHGHlXwE4RI3lEjwfSKRTD1YKq9EigQsyqyivfwYUcdLkBe+
         /mnw==
X-Gm-Message-State: AOAM533HZGZxUF58JUXNHjEQl/YGP5jfScr025oE55mMC+fzATX3NypX
        pqJVSe86GFGWm9o6cQwKkukTrl1Seu8=
X-Google-Smtp-Source: ABdhPJwEEF+H3cV0roBmqOBwLwNeQ8vZ0DrFOEPRL1AL4rqxHTYPCv81gyJ105qeq2VMuqiy6OR+qw==
X-Received: by 2002:a05:600c:1498:: with SMTP id c24mr12054442wmh.78.1643479643012;
        Sat, 29 Jan 2022 10:07:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm4732963wmr.3.2022.01.29.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:22 -0800 (PST)
Message-Id: <243134dc2478e21f67a6d9cb999d6754b616f6ee.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:10 +0000
Subject: [PATCH v2 10/13] merge-tree: provide a list of which files have
 conflicts
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Callers of `git merge-tree --write-tree` will often want to know which
files had conflicts.  While they could potentially attempt to parse the
CONFLICT notices printed, those messages are not meant to be machine
readable.  Provide a simpler mechanism of just printing the files (in
the same format as `git ls-files` with quoting, but restricted to
unmerged files) in the output before the free-form messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  8 ++++++++
 builtin/merge-tree.c             | 24 ++++++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 42e0f8f6183..160e8f44b62 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -55,6 +55,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Conflicted file list>
 	<Informational messages>
 
 These are discussed individually below.
@@ -66,6 +67,13 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
+Conflicted file list
+~~~~~~~~~~~~~~~~~~~~
+
+This is a sequence of lines containing a filename on each line, quoted
+as explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
+
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 6a556ab1c9c..54dae018203 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -11,6 +11,9 @@
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
+#include "quote.h"
+
+static int line_termination = '\n';
 
 struct merge_list {
 	struct merge_list *next;
@@ -394,7 +397,8 @@ struct merge_tree_options {
 };
 
 static int real_merge(struct merge_tree_options *o,
-		      const char *branch1, const char *branch2)
+		      const char *branch1, const char *branch2,
+		      const char *prefix)
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *common;
@@ -438,6 +442,22 @@ static int real_merge(struct merge_tree_options *o,
 		o->show_messages = !result.clean;
 
 	puts(oid_to_hex(&result.tree->object.oid));
+	if (!result.clean) {
+		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
+		const char *last = NULL;
+		int i;
+
+		merge_get_conflicted_files(&result, &conflicted_files);
+		for (i = 0; i < conflicted_files.nr; i++) {
+			const char *name = conflicted_files.items[i].string;
+			if (last && !strcmp(last, name))
+				continue;
+			write_name_quoted_relative(
+				name, prefix, stdout, line_termination);
+			last = name;
+		}
+		string_list_clear(&conflicted_files, 1);
+	}
 	if (o->show_messages) {
 		printf("\n");
 		merge_display_update_messages(&opt, &result, stdout);
@@ -486,7 +506,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == 'w')
-		return real_merge(&o, argv[0], argv[1]);
+		return real_merge(&o, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index e2255711f9c..7113d060bc5 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -95,6 +95,8 @@ test_expect_success 'test conflict notices and such' '
 	#   "whatever" has *both* a modify/delete and a file/directory conflict
 	cat <<-EOF >expect &&
 	HASH
+	greeting
+	whatever~side1
 
 	Auto-merging greeting
 	CONFLICT (content): Merge conflict in greeting
@@ -106,4 +108,13 @@ test_expect_success 'test conflict notices and such' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Just the conflicted files without the messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
+
+	test_write_lines HASH greeting whatever~side1 >expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

