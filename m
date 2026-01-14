Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248133BBAB
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417139; cv=pass; b=cOVXAfglUdTLOmjOA/XpOWRe9+GRfuCWRHVDMP/2PN54r0Mwbd35U3R+Adv3pweW836uI2D5Vu44UjXK+RI4vVpwprbC8uMtnfBcAmmB7Wxh5VLeLqZnpVX7OFdNaBWvBX+k9Vz4u8OTUfxRojJawAVmvqhfZ3YyIZoffKYcUGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417139; c=relaxed/simple;
	bh=6EuTIqNqloW67IGIuER/C2u6/dgUF4XDtLkfxIfrbz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQMBB8B7sOiXxJ0m7jMHwBrKFqFZjlpTzA1851bAZzwamxOOO6aqvgD/Iw55wH/pc55pCQjhtkkUThrpyf/evL4zUrGdIx11VH84nEoL+PELhmjMocNIVQuMTSGdE6HlXJh3WYvJMraikG8sEfS1UWEV1bQpKWeixI3vr2Ftmgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Nx9KT/Wv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Nx9KT/Wv"
ARC-Seal: i=1; a=rsa-sha256; t=1768417125; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VJBspuWuZ4p7pT+2PPxbC6Z6CYgjA8HeZCmQ2paTQmiCPffq+cqZYMf9JsSu0wbXZXZyugBAQR79sBqtYy3ZTkCf1gMG6HoYhaoDoFjVYifGIypwP+BN7Wg85G7e5X+WVAD1HBKYbE4exZDAr6kl2aI897N1mVQZ004pq71C0Xs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768417125; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lNWYk6BC+5olxLdWYZQ0t7GHgmsbNxjU6tjWlfLnQuk=; 
	b=evooPJeJJhLZG+Jsyr/XLjoGxlkRWyl8WCNCieHX3vpGwIrYllZrzkv+ANrTfrjvHZsNmz7oqbnFBPvm5cQQt2C915XMpC7dFLsgW0KQpbDqYN5cBTq9ul4/vv+whL2Nsvhcsovd2RzjqkZpn1mDg6Op9hISUbY2pUTEXFXRJw0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768417124;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lNWYk6BC+5olxLdWYZQ0t7GHgmsbNxjU6tjWlfLnQuk=;
	b=Nx9KT/WvjMt7XIfqZ/JE7+TNgT66CCk1u2lrHnM9wvUc2d6Zp2uHUwaHK9/Y81W1
	aYeTkK13/bbgepF0k3bhHYaCMYlHWQCm67dvLy4YtxkXYMdCc8mEH7f2eauKXqAzofI
	yPALJdpmUeUWvoOyAzNz06b5dcP6YPdd8lX13oX8=
Received: by mx.zohomail.com with SMTPS id 1768417123365628.3308099276567;
	Wed, 14 Jan 2026 10:58:43 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jeff King <peff@peff.net>,
	Chris Darroch <chrisd@apache.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 2/2] hook: make ungroup opt-out instead of opt-in
Date: Wed, 14 Jan 2026 20:57:31 +0200
Message-ID: <20260114185731.2381550-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260114185731.2381550-1-adrian.ratiu@collabora.com>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

In 857f047e40 (hook: allow overriding the ungroup option, 2025-12-26),
I accidentally made the ungroup option opt-in instead of opt-out and
despite my best efforts to set it for all API users, I missed a case
which requires it to be set: the pre-push hook which regressed.

The only thing I needed in that commit was a way to change the default,
to convert the remaining receive-pack hooks which require ungroup == 0
for sideband output, so it doesn't matter if it's on or off by default.

Bring back the original behavior by setting it for all hooks in the
struct run_hooks_opt initializer, which nicely allows changing the
default value only where needed, in receive-pack.c.

While at it add a few hook tests which exercise receive-pack sideband
output since they are the only ungroup=0 exceptions and there are no
other tests exercising this functionality.

Fixes: 857f047e40f7 ("hook: allow overriding the ungroup option")
Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c         |  6 ------
 builtin/receive-pack.c | 12 ++++++++---
 commit.c               |  3 ---
 hook.c                 |  3 ---
 hook.h                 |  1 +
 t/t1800-hook.sh        | 49 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 73e7b8c2e8..7afec380d2 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -43,12 +43,6 @@ static int run(int argc, const char **argv, const char *prefix,
 	if (!argc)
 		goto usage;
 
-	/*
-	 * All current "hook run" use-cases require ungrouped child output.
-	 * If this changes, a hook run argument can be added to toggle it.
-	 */
-	opt.ungroup = 1;
-
 	/*
 	 * Having a -- for "run" when providing <hook-args> is
 	 * mandatory.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ef1f77be8c..2d1a94f3a9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -905,8 +905,10 @@ static int run_receive_hook(struct command *commands,
 	prepare_push_cert_sha1(&opt);
 
 	/* set up sideband printer */
-	if (use_sideband)
+	if (use_sideband) {
 		opt.consume_output = hook_output_to_sideband;
+		opt.ungroup = 0; /* mandatory for sideband output */
+	}
 
 	/* set up stdin callback */
 	feed_state.cmd = commands;
@@ -933,8 +935,10 @@ static int run_update_hook(struct command *cmd)
 		     oid_to_hex(&cmd->new_oid),
 		     NULL);
 
-	if (use_sideband)
+	if (use_sideband) {
 		opt.consume_output = hook_output_to_sideband;
+		opt.ungroup = 0; /* mandatory for sideband output */
+	}
 
 	return run_hooks_opt(the_repository, "update", &opt);
 }
@@ -1623,8 +1627,10 @@ static void run_update_post_hook(struct command *commands)
 	if (!opt.args.nr)
 		return;
 
-	if (use_sideband)
+	if (use_sideband) {
 		opt.consume_output = hook_output_to_sideband;
+		opt.ungroup = 0; /* mandatory for sideband output */
+	}
 
 	run_hooks_opt(the_repository, "post-update", &opt);
 }
diff --git a/commit.c b/commit.c
index efd0c02683..28bb5ce029 100644
--- a/commit.c
+++ b/commit.c
@@ -1978,9 +1978,6 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&opt.args, arg);
 	va_end(args);
 
-	/* All commit hook use-cases require ungrouping child output. */
-	opt.ungroup = 1;
-
 	opt.invoked_hook = invoked_hook;
 	return run_hooks_opt(the_repository, name, &opt);
 }
diff --git a/hook.c b/hook.c
index ebd9d9e26e..4e7631132a 100644
--- a/hook.c
+++ b/hook.c
@@ -199,9 +199,6 @@ int run_hooks(struct repository *r, const char *hook_name)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
-	/* All use-cases of this API require ungrouping. */
-	opt.ungroup = 1;
-
 	return run_hooks_opt(r, hook_name, &opt);
 }
 
diff --git a/hook.h b/hook.h
index 2488db7133..b2b4db2b3d 100644
--- a/hook.h
+++ b/hook.h
@@ -99,6 +99,7 @@ struct run_hooks_opt
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
 	.stdout_to_stderr = 1, \
+	.ungroup = 1, \
 }
 
 struct hook_cb_data {
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 0e4f93fb31..0555a1fd42 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -311,4 +311,53 @@ test_expect_success 'server push-to-checkout hook expects stdout redirected to s
 	check_stdout_merged_to_stderr push-to-checkout
 '
 
+test_expect_success 'receive-pack hooks sideband output works' '
+	git init --bare target-sideband.git &&
+	test_commit sideband-a &&
+	git remote add origin-sideband ./target-sideband.git &&
+
+	# pre-receive hook
+	test_hook -C target-sideband.git pre-receive <<-\EOF &&
+	echo "stdout pre-receive"
+	echo "stderr pre-receive" >&2
+	EOF
+
+	git push origin-sideband HEAD:refs/heads/pre-receive 2>actual &&
+	test_grep "remote: stdout pre-receive" actual &&
+	test_grep "remote: stderr pre-receive" actual &&
+
+	# update hook
+	test_hook -C target-sideband.git update <<-\EOF &&
+	echo "stdout update"
+	echo "stderr update" >&2
+	EOF
+
+	test_commit sideband-b &&
+	git push origin-sideband HEAD:refs/heads/update 2>actual &&
+	test_grep "remote: stdout update" actual &&
+	test_grep "remote: stderr update" actual &&
+
+	# post-receive hook
+	test_hook -C target-sideband.git post-receive <<-\EOF &&
+	echo >&1 "stdout post-receive"
+	echo >&2 "stderr post-receive"
+	EOF
+
+	test_commit sideband-c &&
+	git push origin-sideband HEAD:refs/heads/post-receive 2>actual &&
+	test_grep "remote: stdout post-receive" actual &&
+	test_grep "remote: stderr post-receive" actual &&
+
+	# post-update hook
+	test_hook -C target-sideband.git post-update <<-\EOF &&
+	echo >&1 "stdout post-update"
+	echo >&2 "stderr post-update"
+	EOF
+
+	test_commit sideband-d &&
+	git push origin-sideband HEAD:refs/heads/post-update 2>actual &&
+	test_grep "remote: stdout post-update" actual &&
+	test_grep "remote: stderr post-update" actual
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

