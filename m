Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCE296BD1
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390783; cv=pass; b=u/tCA8KfczPS4yli5oNZ/jaUsbL5P7DkmMP/e44t428JUQNFqvhvXldR1705lC8DfhTsalMQNd5t8NZ0qrk8IkNL7oQAqQyrg5+YMqj5xfQo8EIt7veBb8jjTSK9B33N3pJONcFhDzQrZRBBkCvPwkbxj9qWcC3BnxPWSenFRH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390783; c=relaxed/simple;
	bh=AGJb8SZD/sICDfFoj/lJ+dafRxpdVGcFfOCTFNn4vvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAdkKrTyz3BgNV081n+pkeLZO9GQnt5XMwqbwPF/40RyxfPAAVCg4+3spytE3W2/69mAb46j9pR+0+Zoac8hEFpAPFwZXCf6zLXwrDVnyRt3M1KFIGBDlUKRV/y0q4VJnWDHhFNUBKtBD0BJWJVdk4iJIepNJwIz9C4BT32uicA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=UayQVlOM; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="UayQVlOM"
ARC-Seal: i=1; a=rsa-sha256; t=1772390765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bkshnQ9LjRbJj0hqIPbUa9kEFs0jOt3Idb6aCiqFZN2fAOAuf5b2+uv/IR57fcBBhgwmCnFNDPdQzjcs9OiZNwbh/gtaSWsr+mx+8hjWDhR349J2kBmd4XuyeFhP1OdNq53QbWmI5yLaA+IBSD1hVwz/FoinayHuKWoYnRG6Q3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390765; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GUcv/vEANiIHE/I+A3EmjRcC2AjC4/I6jYPDOtMn+q4=; 
	b=GVmCjuzlNAxpI9wnX1PEOsXU6VjZhGoyZ/al+7XFHPwukCvGFuSVbtvzEgSpviZzxC84ogGDavbMRBvvCQVPY38m8hr3CeiHBKW9Xv6PczfOzOwBAYhu2EOgHMEKV1uH3wdJc0hLOjH94nguotJHoGizGXU97CscCKEMAWd1b7M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390765;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GUcv/vEANiIHE/I+A3EmjRcC2AjC4/I6jYPDOtMn+q4=;
	b=UayQVlOMhHpzQd6yd5bYsbzFsxcum+j9mjvIPf/2eQEKSPhCT1s5jVo6lR24kfKa
	Ua+POU0pvPmzei+TKfwomA2aMb6rv0eZKSE3uiiOYJmqklYrHxr+552eJq25gWuOfbl
	0A3lZMs/XQSDQgerqDsIDmK5RI1NdhTPGFMfM8NU=
Received: by mx.zohomail.com with SMTPS id 1772390763938452.39938516962786;
	Sun, 1 Mar 2026 10:46:03 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 03/12] hook: add "git hook list" command
Date: Sun,  1 Mar 2026 20:44:51 +0200
Message-ID: <20260301184500.1488433-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260301184500.1488433-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
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
 builtin/hook.c              | 59 +++++++++++++++++++++++++++++++++++++
 hook.c                      | 21 ++-----------
 hook.h                      | 22 ++++++++++++++
 t/t1800-hook.sh             | 22 ++++++++++++++
 5 files changed, 110 insertions(+), 19 deletions(-)

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
index 7afec380d2..855116ba8c 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -9,9 +9,12 @@
 
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+#define BUILTIN_HOOK_LIST_USAGE \
+	N_("git hook list <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
+	BUILTIN_HOOK_LIST_USAGE,
 	NULL
 };
 
@@ -20,6 +23,61 @@ static const char * const builtin_hook_run_usage[] = {
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
+		usage_msg_opt(_("you must specify a hook event name to list."),
+			      builtin_hook_list_usage, list_options);
+
+	hookname = argv[0];
+
+	head = list_hooks(repo, hookname, NULL);
+
+	if (!head->nr) {
+		warning(_("no hooks found for event '%s'"), hookname);
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
+	string_list_clear_func(head, hook_free);
+	free(head);
+	return ret;
+}
+
 static int run(int argc, const char **argv, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -77,6 +135,7 @@ int cmd_hook(int argc,
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option builtin_hook_options[] = {
 		OPT_SUBCOMMAND("run", &fn, run),
+		OPT_SUBCOMMAND("list", &fn, list),
 		OPT_END(),
 	};
 
diff --git a/hook.c b/hook.c
index eb52d706b8..20c655918d 100644
--- a/hook.c
+++ b/hook.c
@@ -47,11 +47,7 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
-/*
- * Frees a struct hook stored as the util pointer of a string_list_item.
- * Suitable for use as a string_list_clear_func_t callback.
- */
-static void hook_free(void *p, const char *str UNUSED)
+void hook_free(void *p, const char *str UNUSED)
 {
 	struct hook *h = p;
 
@@ -99,20 +95,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
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
index 51fe873298..36d40c98df 100644
--- a/hook.h
+++ b/hook.h
@@ -175,6 +175,28 @@ struct hook_cb_data {
 	struct run_hooks_opt *options;
 };
 
+/**
+ * Frees a struct hook stored as the util pointer of a string_list_item.
+ * Suitable for use as a string_list_clear_func_t callback.
+ */
+void hook_free(void *p, const char *str);
+
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
 /**
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index ed28a2fadb..d1380a4f0e 100755
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
+	warning: no hooks found for event '\''test-hook'\''
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

