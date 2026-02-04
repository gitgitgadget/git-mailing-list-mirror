Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5E32D7F3
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223923; cv=pass; b=qifYJjFkez/0rSNbmmWPnU1jFoGwocJrH0+iyNoueNV3V7l0Elh4okDZQ+XO8yAlNCFYqtyWzIhXYgfZ4wr3ND55S5fHFWp3x8GJgdYnfmtghXW2xeYMU54nDF4uKH8lMOI10ZyOWUFlOjUxQcF6pSdERdv+hyInE+4WFdAjD0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223923; c=relaxed/simple;
	bh=07b1L64rlWcqz6bfe49jBZ+6hZWiqg13G0W+ixZdq1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuFpX4b+a13Kpma37u5Ge9OYOfdtQ8YW/FtL8NE3mYDlca5rUYXE2FCkBaIi7DK0ee+1MO/PCo65P8C702YwzRou7fmIo9UsBs8357Fj9ftIAUUOGS5Pt/cw5qjfIOQMSNK6x5Q7x8obK0M73ZkEviAQ8xvUcnpiftaYUwvXfvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=jPDvA23e; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="jPDvA23e"
ARC-Seal: i=1; a=rsa-sha256; t=1770223910; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bVFsaOTUE/btX9ooVBOMGxiRZbvu1JSN6I+syjnbtnV0D052CFPpElw+tNUCycgok36CtcbXqT1kWvMkYm9JSjHmogvABDfLvqlC488ClcuIx5TFhgzts9WpxdWPX3fPy463dtcIT4/8AG5cP2Xt9RO00V071qbZ5b2eZaUKySw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770223910; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=93CFA0zslHu6wxugPvF2aCrOZWrHm0cYuZiUhIVv4fE=; 
	b=iIf9m3Fp19SsRUks7LJMKG0emWsyPgeNt/jO2GOhe7Jm+JJds+COjH+QpEn5D81Vbwyb5WH0Fxsy+VBL4bzv9qqNThK1UZYdj3LOKpEcloMTLBOxMj1KcfrioW/+4rYONlbc+wUnAIGWrTJQlVCZn3HWS+8sEOjvYk4l2lbxyG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770223910;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=93CFA0zslHu6wxugPvF2aCrOZWrHm0cYuZiUhIVv4fE=;
	b=jPDvA23emqt4KHRLHutj+4tRPJMQk8J9ofMiQRRgkCNgqVh1np0PZHNgrqx/Kcyj
	nxNmbPjDZFY687S5xOR4nC+CQ9jS8NqX9dCdV5BWb0QD/0Ay1nohwYwUcBRb4sNPeza
	81OyoXrmf0ljYLfKrOEpPkune34rwxa1I4oN/1n4=
Received: by mx.zohomail.com with SMTPS id 1770223907702266.6501576405036;
	Wed, 4 Feb 2026 08:51:47 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 2/4] hook: introduce "git hook list"
Date: Wed,  4 Feb 2026 18:51:24 +0200
Message-ID: <20260204165126.1548805-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

If more than one hook will be run, it may be useful to see a list of
which hooks should be run. At very least, it will be useful for us to
test the semantics of multihooks ourselves.

For now, only list the hooks which will run in the order they will run
in; later, it might be useful to include more information like where the
hooks were configured and whether or not they will run.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  5 ++++
 builtin/hook.c              | 53 +++++++++++++++++++++++++++++++++++++
 hook.c                      | 15 +----------
 hook.h                      | 17 +++++++++++-
 t/t1800-hook.sh             |  2 ++
 5 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index f6cc72d2ca..93d734f687 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
+'git hook' list <hook-name>
 
 DESCRIPTION
 -----------
@@ -28,6 +29,10 @@ Any positional arguments to the hook should be passed after a
 mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
 linkgit:githooks[5] for arguments hooks might expect (if any).
 
+list::
+	Print a list of hooks which will be run on `<hook-name>` event. If no
+	hooks are configured for that event, print nothing and return 1.
+
 OPTIONS
 -------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 7afec380d2..4cc6dac45a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -6,12 +6,16 @@
 #include "hook.h"
 #include "parse-options.h"
 #include "strvec.h"
+#include "abspath.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+#define BUILTIN_HOOK_LIST_USAGE \
+	N_("git hook list <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
+	BUILTIN_HOOK_LIST_USAGE,
 	NULL
 };
 
@@ -20,6 +24,54 @@ static const char * const builtin_hook_run_usage[] = {
 	NULL
 };
 
+static const char *const builtin_hook_list_usage[] = {
+	BUILTIN_HOOK_LIST_USAGE,
+	NULL
+};
+
+static int list(int argc, const char **argv, const char *prefix,
+		 struct repository *repo UNUSED)
+{
+	struct string_list *head;
+	struct string_list_item *item;
+	const char *hookname = NULL;
+	int ret = 0;
+
+	struct option list_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, list_options,
+			     builtin_hook_list_usage, 0);
+
+	/*
+	 * The only unnamed argument provided should be the hook-name; if we add
+	 * arguments later they probably should be caught by parse_options.
+	 */
+	if (argc != 1)
+		usage_msg_opt(_("You must specify a hook event name to list."),
+			      builtin_hook_list_usage, list_options);
+
+	hookname = argv[0];
+
+	head = list_hooks(the_repository, hookname);
+
+	if (!head->nr) {
+		ret = 1; /* no hooks found */
+		goto cleanup;
+	}
+
+	for_each_string_list_item(item, head) {
+		printf("%s\n", *item->string ? item->string
+			     : _("hook from hookdir"));
+	}
+
+cleanup:
+	string_list_clear(head, 1);
+	free(head);
+	return ret;
+}
+
 static int run(int argc, const char **argv, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -77,6 +129,7 @@ int cmd_hook(int argc,
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_hook_options[] = {
 		OPT_SUBCOMMAND("run", &fn, run),
+		OPT_SUBCOMMAND("list", &fn, list),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index fb90f91f3b..949c907b59 100644
--- a/hook.c
+++ b/hook.c
@@ -47,20 +47,7 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
-/*
- * Provides a list of hook commands to run for the 'hookname' event.
- *
- * This function consolidates hooks from two sources:
- * 1. The config-based hooks (not yet implemented).
- * 2. The "traditional" hook found in the repository hooks directory
- *    (e.g., .git/hooks/pre-commit).
- *
- * The list is ordered by execution priority.
- *
- * The caller is responsible for freeing the memory of the returned list
- * using string_list_clear() and free().
- */
-static struct string_list *list_hooks(struct repository *r, const char *hookname)
+struct string_list *list_hooks(struct repository *r, const char *hookname)
 {
 	struct string_list *hook_head;
 
diff --git a/hook.h b/hook.h
index 33a0e33684..cdbe5a9167 100644
--- a/hook.h
+++ b/hook.h
@@ -143,7 +143,22 @@ struct hook_cb_data {
 	struct repository *repository;
 };
 
-/*
+/**
+ * Provides a list of hook commands to run for the 'hookname' event.
+ *
+ * This function consolidates hooks from two sources:
+ * 1. The config-based hooks (not yet implemented).
+ * 2. The "traditional" hook found in the repository hooks directory
+ *    (e.g., .git/hooks/pre-commit).
+ *
+ * The list is ordered by execution priority.
+ *
+ * The caller is responsible for freeing the memory of the returned list
+ * using string_list_clear() and free().
+ */
+struct string_list *list_hooks(struct repository *r, const char *hookname);
+
+/**
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
  * overwritten by further calls to find_hook and run_hook_*.
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index ed28a2fadb..d2d4a8760c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -10,6 +10,8 @@ test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook run &&
 	test_expect_code 129 git hook run -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
+	test_expect_code 129 git hook list &&
+	test_expect_code 129 git hook list -h &&
 	grep "unknown option" err
 '
 
-- 
2.52.0.732.gb351b5166d.dirty

