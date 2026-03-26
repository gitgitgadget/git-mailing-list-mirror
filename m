Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71144388390
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520450; cv=pass; b=otCFxKZe5j/O1zLwvuZr8eeJMDxkVhFSHXeB10C6yb0NGHqftEEWUcS411kFbj35G98UxTLog4qJCSLTb1arMO38iA6nnHpkkCR8JprrKXtaNe+CXAVIHw+2jN26JRVyLSktvwDKUQF9R9B0ioIau5Tj741aqZvuNr9ps+pq350=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520450; c=relaxed/simple;
	bh=OByR70wa9MSo4TadY7mg/uxx5vv5UQsWxgA187jd4z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMtoE2PcBrQZJAXttJnZNgSLAjqE0+PkcICttBHNhmzM8wTP8C0efwegkYoCFD48XwYgzaFQcrpIrrjQSEdv+W+tMZhK68nNB+zDqqOeuYK+BC0h4VcDloujYIMyyrj9DGtXSZIHfvwzw975JIbQDtuVS/5rerB9yK3Rvi4xH4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=M66QfuQY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="M66QfuQY"
ARC-Seal: i=1; a=rsa-sha256; t=1774520431; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cs8HS8ZubVtsS3BE2ZEHr/xWVft6n0LDnuR6sJyJjVKND09yj96vhiZ2Njr0pmm+W+RR2SnO5BBEXHEypzTtuClHoSybnWyy69XgnnQhQQ4KaNeenFIvgCLvuRTb5aNryHvCFfS0liFwaKVl2M5Fw2XTPUJ/sglczTp09Qxu+H0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774520431; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jRxrqq7qOZSUpdZItLGnImA0IdixZgVT3hBAyNMGr+o=; 
	b=mDwS0cUZWBRca5xymE9waBllhLDt737lbAtgWHZnDEyKNcLhvLnZWF9gtu0ufEbUBxrYBZwW3TSO3miepFns9f0jd6Ux9X0VoYFptJN8/duYexV+sxIN8/LP0FYQ90iNFoRMvfblF83fUViK89IqvBT41JsMmvVQsmsRJLGOPDI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774520431;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jRxrqq7qOZSUpdZItLGnImA0IdixZgVT3hBAyNMGr+o=;
	b=M66QfuQYN1nN5qi0o2EqUMDuyNPSTF7hJyz8bV5CZ/QaVbtIuU+tvv/FETQrvXwI
	OhMdKQqQdbAVhvVmDQArY11+x+TcY+uxdu2hPCVWyhGcDBW3rY9ZVGZFnVBbBPHDY2f
	vwtlZF1PGbnbUgAOs4r7GisFWMVlGIIWl/B84oPM=
Received: by mx.zohomail.com with SMTPS id 1774520422119383.9947128535339;
	Thu, 26 Mar 2026 03:20:22 -0700 (PDT)
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
Subject: [PATCH v5 05/12] hook: allow pre-push parallel execution
Date: Thu, 26 Mar 2026 12:18:12 +0200
Message-ID: <20260326101819.1307742-6-adrian.ratiu@collabora.com>
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

pre-push is the only hook that keeps stdout and stderr separate (for
backwards compatibility with git-lfs and potentially other users). This
prevents parallelizing it because run-command needs stdout_to_stderr=1
to buffer and de-interleave parallel outputs.

Since we now default to jobs=1, backwards compatibility is maintained
without needing any extension or extra config: when no parallelism is
requested, pre-push behaves exactly as before.

When the user explicitly opts into parallelism via hook.jobs > 1,
hook.<event>.jobs > 1, or -jN, they accept the changed output behavior.

Document this and let get_hook_jobs() set stdout_to_stderr=1 automatically
when jobs > 1, removing the need for any extension infrastructure.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  4 ++++
 hook.c                         | 24 ++++++++++++++++--------
 hook.h                         |  6 ++++--
 t/t1800-hook.sh                | 32 ++++++++++++++++++++++++++++++++
 transport.c                    |  6 ++++--
 5 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 21800db648..94c7a9808e 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -39,3 +39,7 @@ hook.jobs::
 +
 This setting has no effect unless all configured hooks for the event have
 `hook.<friendly-name>.parallel` set to `true`.
++
+For `pre-push` hooks, which normally keep stdout and stderr separate,
+setting this to a value greater than 1 (or passing `-j`) will merge stdout
+into stderr to allow correct de-interleaving of parallel output.
diff --git a/hook.c b/hook.c
index 85c0de5e47..25762b6c8d 100644
--- a/hook.c
+++ b/hook.c
@@ -555,18 +555,24 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 	strvec_clear(&options->args);
 }
 
+/*
+ * When running in parallel, stdout must be merged into stderr so
+ * run-command can buffer and de-interleave outputs correctly. This
+ * applies even to hooks like pre-push that normally keep stdout and
+ * stderr separate: the user has opted into parallelism, so the output
+ * stream behavior changes accordingly.
+ */
+static void merge_output_if_parallel(struct run_hooks_opt *options)
+{
+	if (options->jobs > 1)
+		options->stdout_to_stderr = 1;
+}
+
 /* Determine how many jobs to use for hook execution. */
 static unsigned int get_hook_jobs(struct repository *r,
 				  struct run_hooks_opt *options,
 				  struct string_list *hook_list)
 {
-	/*
-	 * Hooks needing separate output streams must run sequentially.
-	 * Next commit will allow parallelizing these as well.
-	 */
-	if (!options->stdout_to_stderr)
-		return 1;
-
 	/*
 	 * An explicit job count overrides everything else: this covers both
 	 * FORCE_SERIAL callers (for hooks that must never run in parallel)
@@ -575,7 +581,7 @@ static unsigned int get_hook_jobs(struct repository *r,
 	 * aggressively than the default.
 	 */
 	if (options->jobs)
-		return options->jobs;
+		goto cleanup;
 
 	/*
 	 * Use hook.jobs from the already-parsed config cache (in-repo), or
@@ -603,6 +609,8 @@ static unsigned int get_hook_jobs(struct repository *r,
 		}
 	}
 
+cleanup:
+	merge_output_if_parallel(options);
 	return options->jobs;
 }
 
diff --git a/hook.h b/hook.h
index ba7056f872..01db4226a6 100644
--- a/hook.h
+++ b/hook.h
@@ -106,8 +106,10 @@ struct run_hooks_opt {
 	 * Send the hook's stdout to stderr.
 	 *
 	 * This is the default behavior for all hooks except pre-push,
-	 * which has separate stdout and stderr streams for backwards
-	 * compatibility reasons.
+	 * which keeps stdout and stderr separate for backwards compatibility.
+	 * When parallel execution is requested (jobs > 1), get_hook_jobs()
+	 * overrides this to 1 for all hooks so run-command can de-interleave
+	 * their outputs correctly.
 	 */
 	unsigned int stdout_to_stderr:1;
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 3774a6c2e1..9476a97ca5 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -800,4 +800,36 @@ test_expect_success 'one non-parallel hook forces the whole event to run seriall
 	test_cmp expect hook.order
 '
 
+test_expect_success 'client hooks: pre-push parallel execution merges stdout to stderr' '
+	test_when_finished "rm -rf remote-par stdout.actual stderr.actual" &&
+	git init --bare remote-par &&
+	git remote add origin-par remote-par &&
+	test_commit par-commit &&
+	mkdir -p .git/hooks &&
+	setup_hooks pre-push &&
+	test_config hook.jobs 2 &&
+	git push origin-par HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-push
+'
+
+test_expect_success 'client hooks: pre-push runs in parallel when hook.jobs > 1' '
+	test_when_finished "rm -rf repo-parallel remote-parallel" &&
+	git init --bare remote-parallel &&
+	git init repo-parallel &&
+	git -C repo-parallel remote add origin ../remote-parallel &&
+	test_commit -C repo-parallel A &&
+
+	write_sentinel_hook repo-parallel/.git/hooks/pre-push &&
+	git -C repo-parallel config hook.hook-2.event pre-push &&
+	git -C repo-parallel config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	git -C repo-parallel config hook.hook-2.parallel true &&
+
+	git -C repo-parallel config hook.jobs 2 &&
+
+	git -C repo-parallel push origin HEAD >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect repo-parallel/hook.order
+'
+
 test_done
diff --git a/transport.c b/transport.c
index e53936d87b..9406ec4f2d 100644
--- a/transport.c
+++ b/transport.c
@@ -1391,8 +1391,10 @@ static int run_pre_push_hook(struct transport *transport,
 	opt.feed_pipe_cb_data_free = pre_push_hook_data_free;
 
 	/*
-	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
-	 * them to keep backwards compatibility with existing hooks.
+	 * pre-push hooks keep stdout and stderr separate by default for
+	 * backwards compatibility. When the user opts into parallel execution
+	 * via hook.jobs > 1 or -j, get_hook_jobs() will set stdout_to_stderr=1
+	 * automatically so run-command can de-interleave the outputs.
 	 */
 	opt.stdout_to_stderr = 0;
 
-- 
2.52.0.732.gb351b5166d.dirty

