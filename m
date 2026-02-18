Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76833556E
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453470; cv=pass; b=G7uN8GVoMSnoefpX2c7kFqbJYxHqvUvxWDoObpoAQ4Q6LDqzgheYiII9nkxPNB6uhPHqFrSbPqF4XGSrNyPx12hf0gugEUAn2m+VPvR2MpwNfnojUOX+6VoSIYoMA8b3flya9pdC7fDTLbwvBa4U9VAEMnKpV7Ztvmj46im6Bsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453470; c=relaxed/simple;
	bh=tpCqExBuIGMh3UZGrCMrYbBiS9o4UxdZ4Arck2K6VPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4Pu8BlYqt0CkQ733+ohRRuRpbGSW4MxjJMMlN29k44tynqbp/F964zpGrvRDrM/ilbSLwYlXquJAdZDhotmqzG+kgDGdNXq6wknv0M+jbLhmoN+4aCDin5AgUqyXDgiiIzZY1HrpYEth7HZmsJrga6CWJDZAameEbpOnD+qdLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=J8pWCRGL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="J8pWCRGL"
ARC-Seal: i=1; a=rsa-sha256; t=1771453454; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xw7Fs5FLSUhqIPz57vA1w8cCAOEFrpuuIqk+06OneGgbRawWNREbNYhdajIVna2sc7y0TFMhBpEl92G9Za6SX1y9H1JgTQmTWPytViWxIVv2rwgV0R1jLfUWeWcNk84XEjlJN8V7GWuyGW+F0e9mafp+phWFwwK74ceNEAYiGPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453454; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FSISW3Vu8sbQkkDs+zGNGBW3WwUNmM3UWA7kMqyk2s8=; 
	b=JLUV95SX5rM6ZQ5nnTOoG2WsC8uua19jhh1PgLtqw1igY0u6q+KkbOrTq5z9WPAypvoKRxinCghsbU35ji/3Yt3Z8AT/EWubb/u5K/o/blryywVexUZr2pVKhQjZM7do0Zvqb8GtGm84DxbxhbrnDCIljmdKwo7Tu+TXj/z4gvo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453454;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FSISW3Vu8sbQkkDs+zGNGBW3WwUNmM3UWA7kMqyk2s8=;
	b=J8pWCRGL+MW2cpk3JgYlV9ILJr9MBx44AKO0TcIRJY6AMk208IvqRZSx8Ad26UYv
	G/KH8QdXEOABwisAkpfdlc+B2Q7DRfTIddPA8GkVkpUZrW8tDJfOsU2zl9amFOym8hG
	dxOwfxWKG5FhVd4AolfFW24uv4XV1/HKP2KNRnUE=
Received: by mx.zohomail.com with SMTPS id 17714534535231.9521341375700558;
	Wed, 18 Feb 2026 14:24:13 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 3/8] hook: add "git hook list" command
Date: Thu, 19 Feb 2026 00:23:47 +0200
Message-ID: <20260218222352.55393-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260218222352.55393-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

The previous commit introduced an ability to run multiple commands for
hook events and next commit will introduce the ability to define hooks
from configs, in addition to the "traditional" hooks from the hookdir.

Introduce a new command "git hook list" to make inspecting hooks easier
both for users and for the tests we will add.

Further commits will expand on this, e.g. by adding a -z output mode.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  5 ++++
 builtin/hook.c              | 60 +++++++++++++++++++++++++++++++++++++
 hook.c                      | 17 ++---------
 hook.h                      | 24 ++++++++++++++-
 t/t1800-hook.sh             | 22 ++++++++++++++
 5 files changed, 112 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index f6cc72d2ca..eb0ffcb8a9 100644
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
+	hooks are configured for that event, print a warning and return 1.
+
 OPTIONS
 -------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 7afec380d2..51660c4941 100644
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
 
@@ -20,6 +24,61 @@ static const char * const builtin_hook_run_usage[] = {
 	NULL
 };
 
+static int list(int argc, const char **argv, const char *prefix,
+		 struct repository *repo)
+{
+	static const char *const builtin_hook_list_usage[] = {
+		BUILTIN_HOOK_LIST_USAGE,
+		NULL
+	};
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
+	head = list_hooks(repo, hookname, NULL);
+
+	if (!head->nr) {
+		warning(_("No hooks found for event '%s'"), hookname);
+		ret = 1; /* no hooks found */
+		goto cleanup;
+	}
+
+	for_each_string_list_item(item, head) {
+		struct hook *h = item->util;
+
+		switch (h->kind) {
+		case HOOK_TRADITIONAL:
+			printf("%s\n", _("hook from hookdir"));
+			break;
+		default:
+			BUG("unknown hook kind");
+		}
+	}
+
+cleanup:
+	hook_list_clear(head, NULL);
+	free(head);
+	return ret;
+}
+
 static int run(int argc, const char **argv, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -77,6 +136,7 @@ int cmd_hook(int argc,
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_hook_options[] = {
 		OPT_SUBCOMMAND("run", &fn, run),
+		OPT_SUBCOMMAND("list", &fn, list),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index c008a7232d..979a97a538 100644
--- a/hook.c
+++ b/hook.c
@@ -61,7 +61,7 @@ static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
 	free(h);
 }
 
-static void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
+void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
 {
 	struct string_list_item *item;
 
@@ -101,20 +101,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	string_list_append(hook_list, hook_path)->util = h;
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
-static struct string_list *list_hooks(struct repository *r, const char *hookname,
+struct string_list *list_hooks(struct repository *r, const char *hookname,
 			       struct run_hooks_opt *options)
 {
 	struct string_list *hook_head;
diff --git a/hook.h b/hook.h
index 3256d2dddb..fea221f87d 100644
--- a/hook.h
+++ b/hook.h
@@ -163,7 +163,29 @@ struct hook_cb_data {
 	struct run_hooks_opt *options;
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
+struct string_list *list_hooks(struct repository *r, const char *hookname,
+			       struct run_hooks_opt *options);
+
+/**
+ * Frees the memory allocated for the hook list, including the `struct hook`
+ * items and their internal state.
+ */
+void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
+
+/**
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
  * overwritten by further calls to find_hook and run_hook_*.
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index ed28a2fadb..3ec11f1249 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -10,9 +10,31 @@ test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook run &&
 	test_expect_code 129 git hook run -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
+	test_expect_code 129 git hook list &&
+	test_expect_code 129 git hook list -h &&
 	grep "unknown option" err
 '
 
+test_expect_success 'git hook list: nonexistent hook' '
+	cat >stderr.expect <<-\EOF &&
+	warning: No hooks found for event '\''test-hook'\''
+	EOF
+	test_expect_code 1 git hook list test-hook 2>stderr.actual &&
+	test_cmp stderr.expect stderr.actual
+'
+
+test_expect_success 'git hook list: traditional hook from hookdir' '
+	test_hook test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
+	cat >expect <<-\EOF &&
+	hook from hookdir
+	EOF
+	git hook list test-hook >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git hook run: nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
 	error: cannot find a hook named test-hook
-- 
2.52.0.732.gb351b5166d.dirty

