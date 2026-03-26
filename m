Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E339A072
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520442; cv=pass; b=Yx7LLyDdZYoQ5eOK/W7EtaxaKhxPQXQO14132H3VkYeL9TieKPSf2QldzacxxCYOJgPec/+jcYvfdvyRu5N2sdxSzuItydcEg9zJ9DHfWeIXKzTi1os1tPPRIJ/pNfFoyQaIS3R6lVNbR7SjnTLVcMStrdldfzIWa/6Yrw7qTFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520442; c=relaxed/simple;
	bh=QQiOBxVN++gPWcxPO4HX4yqyqKKYSRrTVJmimuJq/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjSGFnTL0E8Sj78cP/0nEiT2ydr9TL3whaKAXWNUK/9//+ZBOBU9ygONmqMSGeGcH6kh8mqz8BTMYK2Uxl2AqMfRhNIO2l0pzG13E5jbbfaHqKcUzscaUQwkq4yD5+xnyjIufxbGuttlduXMr6aVtnUPfEXdiXJpkf51Bek20c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KngnzaYJ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KngnzaYJ"
ARC-Seal: i=1; a=rsa-sha256; t=1774520425; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XWuFofESPjVGPpkT5z/Y6gb76BM0M6YlwYyiGY78X6BKvbZLs0y1rtQX/OeNIY1wqS9NZfOyB9E8PsgeWGY/QnPvxj99QoSEn0gXJsKbNUo3IUnLvchmCWoe7WyxAeOud1qj8LeA1qkTvAGsy1YS6iLCW7u6KrKoQjkQ+1CwOac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774520425; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BkRkEGZQ7qG+PYBb+d/SEvYAlC0IUyQ+NgL2g9Ciw3c=; 
	b=dFu3XWuoPWtRO/e3KJKchND4NKagePu7XkMItW0HiI47dE3OX2t70giGszx7ZVxkYn7bvAu8+EsmBI0c6wM8yIWUjWINKgbqDP+u+xKb0nMvSbt7Al6fYex+awJTxPI+itqKcDyEt6T7nPD8usY6itMBMyxm5KRV7duQOT2uV+w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774520425;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BkRkEGZQ7qG+PYBb+d/SEvYAlC0IUyQ+NgL2g9Ciw3c=;
	b=KngnzaYJcNga5WcMzBssKyF5Rfl1vm3NZGDcpOsl8ej/9dzuGYNZI/jFIQjug0tA
	RMHWm5IHOMT46No1d0i+65MtG969CxW9TRaOXINtXIhmj/1A1gGSTpagqu7v+id3OiC
	sK1YK4Ge6EJLfHUW18QvSVTgOhru54X2uMk3BaEE=
Received: by mx.zohomail.com with SMTPS id 1774520424799381.76026082101055;
	Thu, 26 Mar 2026 03:20:24 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v5 06/12] hook: mark non-parallelizable hooks
Date: Thu, 26 Mar 2026 12:18:13 +0200
Message-ID: <20260326101819.1307742-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260326101819.1307742-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Several hooks are known to be inherently non-parallelizable, so initialize
them with RUN_HOOKS_OPT_INIT_FORCE_SERIAL. This pins jobs=1 and overrides
any hook.jobs or runtime -j flags.

These hooks are:
applypatch-msg, pre-commit, prepare-commit-msg, commit-msg, post-commit,
post-checkout, and push-to-checkout.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc | 14 ++++++++++++++
 builtin/am.c                   |  8 +++++---
 builtin/checkout.c             | 19 +++++++++++++------
 builtin/clone.c                |  6 ++++--
 builtin/receive-pack.c         |  3 ++-
 builtin/worktree.c             |  2 +-
 commit.c                       |  2 +-
 t/t1800-hook.sh                | 16 ++++++++++++++++
 8 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 94c7a9808e..6f60775c28 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -36,6 +36,20 @@ hook.<friendly-name>.parallel::
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to 1 (serial execution).
+	Some hooks always run sequentially regardless of this setting because
+	they operate on shared data and cannot safely be parallelized:
++
+--
+`applypatch-msg`;;
+`prepare-commit-msg`;;
+`commit-msg`;;
+	Receive a commit message file and may rewrite it in place.
+`pre-commit`;;
+`post-checkout`;;
+`push-to-checkout`;;
+`post-commit`;;
+	Access the working tree, index, or repository state.
+--
 +
 This setting has no effect unless all configured hooks for the event have
 `hook.<friendly-name>.parallel` set to `true`.
diff --git a/builtin/am.c b/builtin/am.c
index 9d0b51c651..271b23160b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -490,9 +490,11 @@ static int run_applypatch_msg_hook(struct am_state *state)
 
 	assert(state->msg);
 
-	if (!state->no_verify)
-		ret = run_hooks_l(the_repository, "applypatch-msg",
-				  am_path(state, "final-commit"), NULL);
+	if (!state->no_verify) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+		strvec_push(&opt.args, am_path(state, "final-commit"));
+		ret = run_hooks_opt(the_repository, "applypatch-msg", &opt);
+	}
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..ac0186a33e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -31,6 +31,7 @@
 #include "resolve-undo.h"
 #include "revision.h"
 #include "setup.h"
+#include "strvec.h"
 #include "submodule.h"
 #include "symlinks.h"
 #include "trace2.h"
@@ -123,13 +124,19 @@ static void branch_info_release(struct branch_info *info)
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hooks_l(the_repository, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
-			   changed ? "1" : "0", NULL);
-	/* "new_commit" can be NULL when checking out from the index before
-	   a commit exists. */
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
 
+	/*
+	 * "new_commit" can be NULL when checking out from the index before
+	 * a commit exists.
+	 */
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
+		     changed ? "1" : "0",
+		     NULL);
+
+	return run_hooks_opt(the_repository, "post-checkout", &opt);
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
diff --git a/builtin/clone.c b/builtin/clone.c
index fba3c9c508..d23b0cafcf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -647,6 +647,7 @@ static int checkout(int submodule_progress,
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
 
 	if (option_no_checkout)
 		return 0;
@@ -697,8 +698,9 @@ static int checkout(int submodule_progress,
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hooks_l(the_repository, "post-checkout", oid_to_hex(null_oid(the_hash_algo)),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid(the_hash_algo)),
+		     oid_to_hex(&oid), "1", NULL);
+	err |= run_hooks_opt(the_repository, "post-checkout", &hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cb3656a034..1d9eb2e1a6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1464,7 +1464,8 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
 	opt.invoked_hook = invoked_hook;
 
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4035b1cb06..b6831c19b5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -609,7 +609,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout && !opts->orphan) {
-		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
 
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
diff --git a/commit.c b/commit.c
index 80d8d07875..4385ae4329 100644
--- a/commit.c
+++ b/commit.c
@@ -1970,7 +1970,7 @@ size_t ignored_log_message_bytes(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
 	va_list args;
 	const char *arg;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 9476a97ca5..6e8b1ad588 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -832,4 +832,20 @@ test_expect_success 'client hooks: pre-push runs in parallel when hook.jobs > 1'
 	test_cmp expect repo-parallel/hook.order
 '
 
+test_expect_success 'hook.jobs=2 is ignored for force-serial hooks (pre-commit)' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event pre-commit &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	test_config hook.hook-1.parallel true &&
+	test_config hook.hook-2.event pre-commit &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	test_config hook.hook-2.parallel true &&
+	test_config hook.jobs 2 &&
+	git commit --allow-empty -m "test: verify force-serial on pre-commit" &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

