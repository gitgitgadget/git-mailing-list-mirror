Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62595C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F302087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgJLT7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:59:49 -0400
Received: from vimdzmsp-sfwd03.bluewin.ch ([195.186.120.132]:42357 "EHLO
        vimdzmsp-sfwd03.bluewin.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgJLT7s (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2020 15:59:48 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 15:59:38 EDT
Received: from localhost.localdomain ([178.82.236.236])
        by vimdzmsp-sfwd03.bluewin.ch Swisscom AG with ESMTPA
        id S3t2knEmD4up0S3tAkPITi; Mon, 12 Oct 2020 21:53:44 +0200
X-Bluewin-Spam-Analysis: v=2.3 cv=Zsp21+zG c=1 sm=1 tr=0
 a=HtqHOeZjyPUdB8xaH0hM2g==:117 a=HtqHOeZjyPUdB8xaH0hM2g==:17
 a=4jXnBNkPC1KuDogJENsA:9
X-Bluewin-Spam-Score: 0.00
X-FXIT-IP: IPv4[178.82.236.236] Epoch[1602532424]
X-Bluewin-AuthAs: cedricschwyter@bluewin.ch
From:   Cedric Schwyter <cedricschwyter@bluewin.ch>
To:     git@vger.kernel.org
Cc:     Cedric Schwyter <cedricschwyter@bluewin.ch>
Subject: [PATCH 1/1] subcommands: alias 'list'-subcommands to 'ls' where applicable docs: update docs with new alias
Date:   Mon, 12 Oct 2020 21:53:35 +0200
Message-Id: <20201012195335.189194-2-cedricschwyter@bluewin.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012195335.189194-1-cedricschwyter@bluewin.ch>
References: <20201012195335.189194-1-cedricschwyter@bluewin.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJdfYnAgfg+lNijhEHUY2uUTYblIQh4yaNH02lP7CO5/j9+imDHdy7TQSp9ca2ahR+oB5/Kzwx6V7lf1jJGkNZuZOovBh8w3DfUxr7ZoGzw2wv56tofv
 AC21wo9SUqPdfBxDAyTlHnpy9a61nPeRdGaNuA0j+WsYKsCvZzozDfHVxdGXRfomFcq2yUjE2+v1KjFiamu9x1TgRqcHt3VhNnZY9yx0LTjYaeXZV/7o/2SC
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For ease-of-use various built-in subcommands now alias 'ls' to 'list'

Signed-off-by: Cedric Schwyter <cedricschwyter@bluewin.ch>
---
 Documentation/git-bundle.txt          | 4 ++++
 Documentation/git-sparse-checkout.txt | 3 +++
 Documentation/git-stash.txt           | 5 +++++
 Documentation/git-worktree.txt        | 5 +++++
 builtin/bundle.c                      | 3 ++-
 builtin/sparse-checkout.c             | 3 ++-
 builtin/stash.c                       | 4 +++-
 builtin/worktree.c                    | 3 ++-
 8 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 53804cad4b..18f4bc1cff 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 		    [--version=<version>] <file> <git-rev-list-args>
 'git bundle' verify [-q | --quiet] <file>
 'git bundle' list-heads <file> [<refname>...]
+'git bundle' ls <file> [<refname>...]
 'git bundle' unbundle <file> [<refname>...]
 
 DESCRIPTION
@@ -56,6 +57,9 @@ list-heads <file>::
 	list of references, only references matching those given are
 	printed out.
 
+ls <file>::
+	Short alias for `list-heads`.
+
 unbundle <file>::
 	Passes the objects in the bundle to 'git index-pack'
 	for storage in the repository, then prints the names of all
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index a0eeaeb02e..366ab5f0c0 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -30,6 +30,9 @@ COMMANDS
 'list'::
 	Describe the patterns in the sparse-checkout file.
 
+'ls'::
+    Short alias for `list`.
+
 'init'::
 	Enable the `core.sparseCheckout` setting. If the
 	sparse-checkout file does not exist, then populate it with
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 31f1beb65b..083aecd4ab 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
+'git stash' ls [<options>]
 'git stash' show [<options>] [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
@@ -83,6 +84,10 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
+ls [<options>]::
+
+	Short alias for `list`.
+
 show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 32e8440cde..83e45821c0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
+'git worktree ls' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
@@ -99,6 +100,10 @@ followed by each of the linked working trees.  The output details include
 whether the working tree is bare, the revision currently checked out, and the
 branch currently checked out (or "detached HEAD" if none).
 
+ls::
+
+Short alias for `list`.
+
 lock::
 
 If a working tree is on a portable device or network share which
diff --git a/builtin/bundle.c b/builtin/bundle.c
index ea6948110b..e5bb1d07b7 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -31,6 +31,7 @@ static const char * const builtin_bundle_verify_usage[] = {
 
 static const char * const builtin_bundle_list_heads_usage[] = {
   N_("git bundle list-heads <file> [<refname>...]"),
+  N_("git bundle ls <file> [<refname>...]"),
   NULL
 };
 
@@ -185,7 +186,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		result = cmd_bundle_create(argc, argv, prefix);
 	else if (!strcmp(argv[0], "verify"))
 		result = cmd_bundle_verify(argc, argv, prefix);
-	else if (!strcmp(argv[0], "list-heads"))
+	else if (!strcmp(argv[0], "list-heads") || !strcmp(argv[0], "ls"))
 		result = cmd_bundle_list_heads(argc, argv, prefix);
 	else if (!strcmp(argv[0], "unbundle"))
 		result = cmd_bundle_unbundle(argc, argv, prefix);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e3140db2a0..197f90d5f9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -48,6 +48,7 @@ static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
 
 static char const * const builtin_sparse_checkout_list_usage[] = {
 	N_("git sparse-checkout list"),
+	N_("git sparse-checkout ls"),
 	NULL
 };
 
@@ -644,7 +645,7 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (argc > 0) {
-		if (!strcmp(argv[0], "list"))
+		if (!strcmp(argv[0], "list") || !strcmp(argv[0], "ls"))
 			return sparse_checkout_list(argc, argv);
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
diff --git a/builtin/stash.c b/builtin/stash.c
index 3f811f3050..4b7e9872e7 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -20,6 +20,7 @@
 
 static const char * const git_stash_usage[] = {
 	N_("git stash list [<options>]"),
+	N_("git stash ls [<options>]"),
 	N_("git stash show [<options>] [<stash>]"),
 	N_("git stash drop [-q|--quiet] [<stash>]"),
 	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
@@ -36,6 +37,7 @@ static const char * const git_stash_usage[] = {
 
 static const char * const git_stash_list_usage[] = {
 	N_("git stash list [<options>]"),
+	N_("git stash ls [<options>]"),
 	NULL
 };
 
@@ -1589,7 +1591,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
-	else if (!strcmp(argv[0], "list"))
+	else if (!strcmp(argv[0], "list") || !strcmp(argv[0], "ls"))
 		return !!list_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "show"))
 		return !!show_stash(argc, argv, prefix);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 99abaeec6c..e571601796 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -16,6 +16,7 @@
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
 	N_("git worktree list [<options>]"),
+	N_("git worktree ls [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
@@ -1072,7 +1073,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
-	if (!strcmp(av[1], "list"))
+	if (!strcmp(av[1], "list") || !strcmp(av[1], "ls"))
 		return list(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "lock"))
 		return lock_worktree(ac - 1, av + 1, prefix);
-- 
2.28.0

