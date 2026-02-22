Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD803EBF33
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720192; cv=pass; b=KivibqkmrqEB+WglqOMd02oLLlsZatK+/oKzymV+tJZCMo7Aj3pfRcmPxKkBlrJ7XvOUbYAP9ibLDJ4HKWZuugG5sD7cEA4OGbdCsRZqzNPBKiEXgFLnAx14qh7vx1tzqdyAfWYuFtMz0QL7DYuBWS3dMY4VL05yvsSyJq0MhLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720192; c=relaxed/simple;
	bh=8OpWTRkmt/Ss7LRPWk3jLGGxPPm3EF1ZwWy1+N6jCls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlh/ONAR0GyKIPdUpexiFXk7WkcxCVCVh1CvZRu/IU1X0UGUEUPUu2QLEqXZAyzUNnRcBYxdOipgzXfFOFyJQut525MNMBLGR1dky5trfQhwLNnXvHKCehF1AcbnfGaxSNGnI2u4Uwce1KpneMYx4ZMgJx5UwS9qjHLzFvud470=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ihzfRIP3; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ihzfRIP3"
ARC-Seal: i=1; a=rsa-sha256; t=1771720173; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KE+CT8rhnA4BgoDtHGiD21XYX7pw/kw2g70TxeCkkP5th56q/uBFTv3L+wM3Z5bAKRiXyDl7TdKTBgd28/iQnlqRk/hTL1eqQfADrQ1p3O4tGozrmRwMjx9Zr3rT4R7zsXkWCfaQUXua0NLjz8ug3fyYqeVxxQ8CzJeWQMVgxmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720173; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DNYFASFiKvpEOu+9Nh9pg/Qt3qdfXeiu8Cy7zLUObtQ=; 
	b=PhRDGdkuPDz7HpKGIccRpdAtA5cZis9dEKLzbhZASZvxWwr2y2eulTlSbXvGTqD21VavCEA4z451fUAM24Gie4yMCo3Q2NNvm4SPIRjWRabDc0eebTEEmMQ3y8xC79ivIDyK1mHxDR9nlxX3GPwLlg9y2xnWH1sb3rJv6lpmi4w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720172;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DNYFASFiKvpEOu+9Nh9pg/Qt3qdfXeiu8Cy7zLUObtQ=;
	b=ihzfRIP3TfhpeMVLxcOv046kOfN7SbHvNx5JUjzn+Yx/HZv2mq613czD/qJV47OQ
	rEUdSjJOCywmDUYM1sq9qVsVRS5cN/u5rBsNn+Ly/WBshBlOj5CMsHPGXbpZ/osepTS
	mhYRnXXGT9cSdsrwaKYKhLLaldOZpJe9L0TL4jq8=
Received: by mx.zohomail.com with SMTPS id 1771720170814935.6210559268612;
	Sat, 21 Feb 2026 16:29:30 -0800 (PST)
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
Subject: [PATCH v2 06/10] hook: mark non-parallelizable hooks
Date: Sun, 22 Feb 2026 02:29:00 +0200
Message-ID: <20260222002904.1879356-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260222002904.1879356-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260222002904.1879356-1-adrian.ratiu@collabora.com>
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
 Documentation/config/hook.adoc |  4 ++++
 builtin/am.c                   |  8 +++++---
 builtin/checkout.c             | 19 +++++++++++++------
 builtin/clone.c                |  6 ++++--
 builtin/receive-pack.c         |  3 ++-
 builtin/worktree.c             |  2 +-
 commit.c                       |  2 +-
 t/t1800-hook.sh                | 16 ++++++++++++++++
 8 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index e306ffa80b..8894088bda 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -36,6 +36,10 @@ hook.<name>.parallel::
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to 1 (serial execution).
+	Some hooks always run sequentially regardless of this setting because
+	git knows they cannot safely be parallelized: `applypatch-msg`,
+	`pre-commit`, `prepare-commit-msg`, `commit-msg`, `post-commit`,
+	`post-checkout`, and `push-to-checkout`.
 +
 This setting has no effect unless all configured hooks for the event have
 `hook.<name>.parallel` set to `true`.
diff --git a/builtin/am.c b/builtin/am.c
index e0c767e223..45a8e78d0b 100644
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
index f7b313816e..9f2d84e3fc 100644
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
@@ -137,13 +138,19 @@ static void branch_info_release(struct branch_info *info)
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
index b14a39a687..bce3f732b9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -644,6 +644,7 @@ static int checkout(int submodule_progress, int filter_submodules,
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
 
 	if (option_no_checkout)
 		return 0;
@@ -694,8 +695,9 @@ static int checkout(int submodule_progress, int filter_submodules,
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
index f23772bc56..5f9335936a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1453,7 +1453,8 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
 	opt.invoked_hook = invoked_hook;
 
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3d6547c23b..af13386697 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -574,7 +574,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout && !opts->orphan) {
-		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
 
 		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
 		strvec_pushl(&opt.args,
diff --git a/commit.c b/commit.c
index d16ae73345..5b2276a80e 100644
--- a/commit.c
+++ b/commit.c
@@ -1957,7 +1957,7 @@ size_t ignored_log_message_bytes(const char *buf, size_t len)
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...)
 {
-	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
 	va_list args;
 	const char *arg;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index f8318c3510..0d17969cdf 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -695,4 +695,20 @@ test_expect_success 'one non-parallel hook forces the whole event to run seriall
 	test_cmp expect hook.order
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

