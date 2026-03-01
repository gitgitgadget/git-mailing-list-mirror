Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192713376A0
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390797; cv=pass; b=EPPJaJL1tmjI1bAlBsxdu8viWk11QjexSDXqq2goqpRofl0KY5ogxC6J9QYFAM8mIonToIJIDtS0a8xvyXcWAkHPutaBWe8Is7PRSGbi4R8FI3JzxzAwfbW40uFQ3re79IQ6vgPZmb6rKzRTtU3ZthEd1QeoY1KKVqtF+7sSYSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390797; c=relaxed/simple;
	bh=ys74LrPnf10TVwGsoXAnWYPvkL+f6RObHkvVwApfxXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSLo43P8JJvHzhIuoaI3S4g9PDLGkHLCL0zpzSRfyoGchzwY3H7c0KALctc1CRq+Fi2fKgDJ0VsTpJJkgibxkCcmRmswUJqeKg47Ugnp9sbYEXZ3+fCjO2VrfrfLwaV9LCfz4MBDbBJ6MYLMHNdg0umLV/tZKStFtr+xTTejpr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Yv3mZNPx; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Yv3mZNPx"
ARC-Seal: i=1; a=rsa-sha256; t=1772390783; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fbrRZiMA4CumJNUW2H+hgQTgWyuWSFzioRNOLxl7ZVx21+xRlDB9aoEnBGXz4tLZ3/NfXoXbxjn1LuTY03c5e2FBB6vY7IHVWlXZVqdy3TSU1oHbD7Oy7VQErff0zDAuv2+sQGFkyIRhira8/rIYAD9J+jqzQZh9r0Dge3wwUKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390783; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ti/zlme3C4xVVqjSMfOi2C9muPQe/F4hfYYJWrWL7uA=; 
	b=QCRa7CfEdYTogvPMo0W8lJ4F/UpQAz19cpLTbi2Oon8DLU4SqfRuQoo83NHSqR3Z0SouWHjedr6dZLb4tN1Pct2T+ea6TVhSZBfnSOYeYScD5md4bFLFUFpHqbptUk0x2q29au12udZlstCEWXhR7+yfj6K9nq3xGKXl1jmlQBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390783;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ti/zlme3C4xVVqjSMfOi2C9muPQe/F4hfYYJWrWL7uA=;
	b=Yv3mZNPx6Q+w2KXImDQ5JJGPtZbt3Sp6ufQRmCsncKJTIbr1qyf8ZgrYPaSqFxg5
	IYokD8+DIvBjPxAPcl4tO4Ykima7cY4IWg6lOuwc72SLSh6VDbTCKEp+JI1/NMRX9e3
	YUqhOJuqsweGYgtkX4dyxZzMPWiHZVRmO4vE/Eew=
Received: by mx.zohomail.com with SMTPS id 1772390781306110.11453803580241;
	Sun, 1 Mar 2026 10:46:21 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 11/12] hook: store and display scope for configured hooks in git hook list
Date: Sun,  1 Mar 2026 20:44:59 +0200
Message-ID: <20260301184500.1488433-12-adrian.ratiu@collabora.com>
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

Users running "git hook list" can see which hooks are configured but
have no way to tell at which config scope (local, global, system...)
each hook was defined.

Store the scope from ctx->kvi->scope in the single-pass config callback,
then carry it through the cache to the hook structs, then expose it to
the users via the "git hook list --show-scope" flag, which mirrors the
existing git config --show-scope convention.

Without the flag the output is unchanged.

$ git hook list --show-scope pre-commit
linter (global)
no-leaks (local)
hook from hookdir

Traditional hooks from the hookdir are unaffected by --show-scope since
the config scope concept does not apply to them.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  9 +++++++--
 builtin/hook.c              | 14 ++++++++++++--
 hook.c                      | 17 +++++++++++++----
 hook.h                      |  2 ++
 t/t1800-hook.sh             | 19 +++++++++++++++++++
 5 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 966388660a..4d4e728327 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
-'git hook' list [-z] <hook-name>
+'git hook' list [-z] [--show-scope] <hook-name>
 
 DESCRIPTION
 -----------
@@ -113,7 +113,7 @@ Any positional arguments to the hook should be passed after a
 mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
 linkgit:githooks[5] for arguments hooks might expect (if any).
 
-list [-z]::
+list [-z] [--show-scope]::
 	Print a list of hooks which will be run on `<hook-name>` event. If no
 	hooks are configured for that event, print a warning and return 1.
 	Use `-z` to terminate output lines with NUL instead of newlines.
@@ -134,6 +134,11 @@ OPTIONS
 -z::
 	Terminate "list" output lines with NUL instead of newlines.
 
+--show-scope::
+	For "list"; print the config scope (e.g. `local`, `global`, `system`)
+	in parentheses after the friendly name of each configured hook, to show
+	where it was defined. Traditional hooks from the hookdir are unaffected.
+
 WRAPPERS
 --------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 542183795a..eb8dfcd31b 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -10,7 +10,7 @@
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
-	N_("git hook list [-z] <hook-name>")
+	N_("git hook list [-z] [--show-scope] <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -34,11 +34,14 @@ static int list(int argc, const char **argv, const char *prefix,
 	struct string_list_item *item;
 	const char *hookname = NULL;
 	int line_terminator = '\n';
+	int show_scope = 0;
 	int ret = 0;
 
 	struct option list_options[] = {
 		OPT_SET_INT('z', NULL, &line_terminator,
 			    N_("use NUL as line terminator"), '\0'),
+		OPT_BOOL(0, "show-scope", &show_scope,
+			 N_("show the config scope that defined each hook")),
 		OPT_END(),
 	};
 
@@ -71,7 +74,14 @@ static int list(int argc, const char **argv, const char *prefix,
 			printf("%s%c", _("hook from hookdir"), line_terminator);
 			break;
 		case HOOK_CONFIGURED:
-			printf("%s%c", h->u.configured.friendly_name, line_terminator);
+			if (show_scope)
+				printf("%s (%s)%c",
+				       h->u.configured.friendly_name,
+				       config_scope_name(h->u.configured.scope),
+				       line_terminator);
+			else
+				printf("%s%c", h->u.configured.friendly_name,
+				       line_terminator);
 			break;
 		default:
 			BUG("unknown hook kind");
diff --git a/hook.c b/hook.c
index 0bab491953..a868d8cf17 100644
--- a/hook.c
+++ b/hook.c
@@ -106,11 +106,11 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 
 /*
  * Cache entry stored as the .util pointer of string_list items inside the
- * hook config cache. For now carries only the command for the hook. Next
- * commits will add more data.
+ * hook config cache.
  */
 struct hook_config_cache_entry {
 	char *command;
+	enum config_scope scope;
 };
 
 /*
@@ -127,7 +127,7 @@ struct hook_all_config_cb {
 
 /* repo_config() callback that collects all hook.* configuration in one pass. */
 static int hook_config_lookup_all(const char *key, const char *value,
-				  const struct config_context *ctx UNUSED,
+				  const struct config_context *ctx,
 				  void *cb_data)
 {
 	struct hook_all_config_cb *data = cb_data;
@@ -164,7 +164,12 @@ static int hook_config_lookup_all(const char *key, const char *value,
 
 			/* Re-insert if necessary to preserve last-seen order. */
 			unsorted_string_list_remove(hooks, hook_name, 0);
-			string_list_append(hooks, hook_name);
+			/*
+			 * Store the config scope in util so callers can
+			 * report where each hook was defined.
+			 */
+			string_list_append(hooks, hook_name)->util =
+				(void *)(uintptr_t)ctx->kvi->scope;
 		}
 	} else if (!strcmp(subkey, "command")) {
 		/* Store command overwriting the old value */
@@ -243,6 +248,8 @@ static void build_hook_config_map(struct repository *r,
 
 		for (size_t i = 0; i < hook_names->nr; i++) {
 			const char *hname = hook_names->items[i].string;
+			enum config_scope scope =
+				(enum config_scope)(uintptr_t)hook_names->items[i].util;
 			struct hook_config_cache_entry *entry;
 			char *command;
 
@@ -260,6 +267,7 @@ static void build_hook_config_map(struct repository *r,
 			/* util stores a cache entry; owned by the cache. */
 			CALLOC_ARRAY(entry, 1);
 			entry->command = xstrdup(command);
+			entry->scope = scope;
 			string_list_append(hooks, hname)->util = entry;
 		}
 
@@ -336,6 +344,7 @@ static void list_hooks_add_configured(struct repository *r,
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
 		hook->u.configured.command = xstrdup(entry->command);
+		hook->u.configured.scope = entry->scope;
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
diff --git a/hook.h b/hook.h
index 277390b744..b862cde01b 100644
--- a/hook.h
+++ b/hook.h
@@ -1,5 +1,6 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "config.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "string-list.h"
@@ -29,6 +30,7 @@ struct hook {
 		struct {
 			const char *friendly_name;
 			const char *command;
+			enum config_scope scope;
 		} configured;
 	} u;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 0a4b2a9978..6e36ac5229 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -406,6 +406,25 @@ test_expect_success 'globally disabled hook can be re-enabled locally' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list --show-scope shows config scope' '
+	test_config_global hook.global-hook.command "echo global" &&
+	test_config_global hook.global-hook.event test-hook --add &&
+	test_config hook.local-hook.command "echo local" &&
+	test_config hook.local-hook.event test-hook --add &&
+
+	cat >expected <<-\EOF &&
+	global-hook (global)
+	local-hook (local)
+	EOF
+	git hook list --show-scope test-hook >actual &&
+	test_cmp expected actual &&
+
+	# without --show-scope the scope must not appear
+	git hook list test-hook >actual &&
+	test_grep ! "(global)" actual &&
+	test_grep ! "(local)" actual
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
-- 
2.52.0.732.gb351b5166d.dirty

