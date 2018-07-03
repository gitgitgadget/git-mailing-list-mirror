Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF511F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 23:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeGCX44 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 19:56:56 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44075 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbeGCX4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 19:56:55 -0400
Received: by mail-yb0-f195.google.com with SMTP id a2-v6so1397410ybe.11
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cpQh49jxMysSamGTwAdtZV1hs8zG8Ds9r8vrNxZVfKY=;
        b=AHlcV/CT/adhxtMPbrcZA7cqerNC6R7VskNz8L39wefnTxWdpBq48S9klaU4TtHo81
         OGf/PpKzlbBg5jUGRZeLw7ckAZIITkB0OzKgK1HH8ph8NGVUSUbTYGaMG/UbYu+gM7Xw
         V54LCMppyWj2FoYCWhSj25aoTMs9IsGXMQGN66pdC01rXfhB+7Awcba7TFj0OH2j3aHh
         iglSVFmkOSUCYQgoQ2A2zr781RqCI86i6S9WGGniT2wkS1enjqb0H9v9WRPb59PXOprW
         kMZNzoXS+OHCkSXyjId1ss8PaG6wfQg0gl0NmwBOpgADWasDyPtCMiiOwMR1Wf1vQSSU
         8ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cpQh49jxMysSamGTwAdtZV1hs8zG8Ds9r8vrNxZVfKY=;
        b=a0+ljay+MKGXoGxsSJSx3MwRhFUHWiJeFxkNuYwMZUnG5G1NJTG7vvLPOzXK2Jf2sK
         xlvx+TltZVE2TgRaGcuY5Geu4EKE5cUX2Rh/nFwWE5UbUPIt4nTCezufC3PEZKA47t5c
         XJoxwqCRAhhWwjtwHjgzVjL5kGFG9mQ99EtTutux2PSXb3BxWG3VkAgRKxROIeJy6qXs
         6dJXjB42udZE6QZzOHI9RzIzI5nnoYlc+gy3kEMB7aoez2HdTAgxHmRSaKRuEBDftTE9
         t2F9B0cUb2AegbQjm4DlkTGOxqgLznA4XXKIaOFqAA3iR/YjBJzoEsYTNC6jAKkxLRfu
         XJ6g==
X-Gm-Message-State: APt69E2S7CHrDa1eCsc3MUWsKjS+E7oA02dnkmzuJP0Mh0/52m3YIx+H
        JnAVbTfVn8PtCBI7Hr5n/pt0/GUM
X-Google-Smtp-Source: ADUXVKLI9mfOh3gCLut0CLJU7GTkZ0b196z2PhnCaGb91uGFd7fi3zwl8Y+w6sqbAf8OeS8M17Z2Wg==
X-Received: by 2002:a25:748d:: with SMTP id p135-v6mr16950751ybc.23.1530662214564;
        Tue, 03 Jul 2018 16:56:54 -0700 (PDT)
Received: from localhost.localdomain ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id o126-v6sm845544ywf.102.2018.07.03.16.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:56:53 -0700 (PDT)
From:   Joshua Nelson <jyn514@gmail.com>
To:     git@vger.kernel.org
Cc:     Joshua Nelson <jyn514@gmail.com>
Subject: [PATCH] ls-tree: make <tree-ish> optional
Date:   Tue,  3 Jul 2018 19:53:38 -0400
Message-Id: <20180703235337.31770-1-jyn514@gmail.com>
X-Mailer: git-send-email 2.18.GIT
In-Reply-To: <26b538bd-df59-d9a6-460d-0b1042b35250@gmail.com>
References: <26b538bd-df59-d9a6-460d-0b1042b35250@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use syntax similar to `git-checkout` to make <tree-ish> optional for
`ls-tree`. If <tree-ish> is omitted, default to HEAD. Infer arguments as
follows:

1. If args start with '--', assume <tree-ish> to be HEAD
2. If exactly one arg precedes '--', treat the argument as <tree-ish>
3. If more than one arg precedes '--', exit with an error
4. If '--' is not in args:
	a) If args[0] is a valid <tree-ish> object, treat it as such
	b) Else, assume <tree-ish> to be HEAD

In all cases, every argument besides <tree-ish> is treated as a <path>.

Signed-off-by: Joshua Nelson <jyn514@gmail.com>
---

 Documentation/git-ls-tree.txt    |  2 +-
 builtin/ls-tree.c                | 40 ++++++++++++++++----
 t/t3104-ls-tree-optional-args.sh | 63 ++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 8 deletions(-)
 create mode 100755 t/t3104-ls-tree-optional-args.sh

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 9dee7bef3..290fd11c3 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
-	    <tree-ish> [<path>...]
+	    [<tree-ish>] [--] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 409da4e83..64bfbae71 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -26,7 +26,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const  char * const ls_tree_usage[] = {
-	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
+	N_("git ls-tree [<options>] [<tree-ish>] [--] [<path>...]"),
 	NULL
 };
 
@@ -122,7 +122,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	struct object_id oid;
 	struct tree *tree;
-	int i, full_tree = 0;
+	const char *tree_ish;
+	int i, full_tree = 0, oid_initialized = 0, dash_dash_pos = -1;
+
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -153,7 +155,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		chomp_prefix = strlen(prefix);
 
 	argc = parse_options(argc, argv, prefix, ls_tree_options,
-			     ls_tree_usage, 0);
+			     ls_tree_usage, PARSE_OPT_KEEP_DASHDASH);
 	if (full_tree) {
 		ls_tree_prefix = prefix = NULL;
 		chomp_prefix = 0;
@@ -164,9 +166,33 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		ls_options |= LS_SHOW_TREES;
 
 	if (argc < 1)
-		usage_with_options(ls_tree_usage, ls_tree_options);
-	if (get_oid(argv[0], &oid))
-		die("Not a valid object name %s", argv[0]);
+		tree_ish = "HEAD";
+	else {
+		for (i = 0; i < argc; i++) {
+			if (!strcmp(argv[i], "--")) {
+				dash_dash_pos = i;
+				break;
+			}
+		}
+		if (dash_dash_pos == 0) {
+			tree_ish = "HEAD";
+			argv++;
+		} else if (dash_dash_pos == 1) {
+			tree_ish = argv[0];
+			argv += 2;
+		} else if (dash_dash_pos >= 2)
+			die(_("only one reference expected, %d given."), dash_dash_pos);
+		else if (get_oid(argv[0], &oid)) // not a valid object
+			tree_ish = "HEAD";
+		else {
+			argv++;
+			oid_initialized = 1;
+		}
+	}
+
+	if (!oid_initialized) /* if we've already run get_oid, don't run it again */
+		if (get_oid(tree_ish, &oid))
+			die("Not a valid object name %s", tree_ish);
 
 	/*
 	 * show_recursive() rolls its own matching code and is
@@ -177,7 +203,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
 				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
-		       prefix, argv + 1);
+		       prefix, argv);
 	for (i = 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len = pathspec.items[i].len;
 	pathspec.has_wildcard = 0;
diff --git a/t/t3104-ls-tree-optional-args.sh b/t/t3104-ls-tree-optional-args.sh
new file mode 100755
index 000000000..e9d8389bc
--- /dev/null
+++ b/t/t3104-ls-tree-optional-args.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='ls-tree test (optional args)
+
+This test runs git-ls-tree with ambiguous positional options.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hi > test &&
+	cp test test2 &&
+	git add test test2 &&
+	git commit -m initial &&
+	printf "100644 blob 45b983be36b73c0788dc9cbcb76cbb80fc7bb057\ttest\n" > expected1 &&
+	printf "100644 blob 45b983be36b73c0788dc9cbcb76cbb80fc7bb057\ttest2\n" > expected2
+'
+
+# cat appends newlines after every file
+test_expect_success 'show HEAD when given no args' '
+	if [ "$(git ls-tree)" != "$(cat expected1 expected2)" ]; then false; fi
+'
+
+test_expect_success 'show HEAD when given only --' '
+	if [ "$(git ls-tree --)" != "$(cat expected1 expected2)" ]; then false; fi
+'
+
+test_expect_success 'setup' '
+	echo hi > test3 &&
+	echo there >> test1 &&
+	git add test3 test1 &&
+	git commit -m "commit 2" &&
+	printf "100644 blob 45b983be36b73c0788dc9cbcb76cbb80fc7bb057\ttest3\n" > expected3
+'
+
+test_expect_success 'show all files when given only revision' '
+	if [ "$(git ls-tree HEAD~1)" != "$(cat expected1 expected2)" ]; then false; fi
+'
+
+test_expect_success 'show all files when given revision and --' '
+	if [ "$(git ls-tree HEAD~1 --)" != "$(cat expected1 expected2)" ]; then false; fi
+'
+
+test_expect_success 'show file when given -- and file' '
+	if [ "$(git ls-tree -- test3)" != "$(cat expected3)" ]; then false; fi
+'
+
+test_expect_success 'show file when given revision and file' '
+	if [ "$(git ls-tree HEAD~1 test)" != "$(cat expected1)" ]; then false; fi
+'
+
+test_expect_success 'show file when given only file' '
+	if [ "$(git ls-tree test3)" != "$(cat expected3)" ]; then false; fi
+'
+
+test_expect_success 'raise error when given bad args' '
+	test_must_fail  git ls-tree HEAD HEAD --
+'
+
+test_expect_success 'raise error when given bad revision' '
+	test_must_fail git ls-tree bad_revision --
+'
+
+test_done
-- 
2.18.GIT

