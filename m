Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B13B19B0
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812034; cv=pass; b=NQ/VUMNRTWbRZvkGvXn3AkLPteDhQXJ569xkiWjqEa3X1UesTTzkg4EpyqkdZSlhSv4dxP6Lu+28JPuKpGJaIzrLuTk73wcM6yd4Shpq2I12f7Na4jHmVjiPMl5cjITOh+zqz6b92tbyOl4mfTlnTh53hLdGFS9CYyIUUCgbSoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812034; c=relaxed/simple;
	bh=cFGBPVtSdnrQr5xYqCyllP7A24nnG20VieO52zQCKAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr35iaOe5kLiIkN5Tb/EBHAg0WysbJT92CxN3u0V/UF2zQfcOziLS+Tl1EjZp66j70uLyn86rvRUc4WukGdTbGU32t8qpISJRJp/3fKt8ArJSaeznealPh+x4Q3a97l8d5dVaVXCxfYfiYhXcfszvcVYH3ai1mBXuxZyeQK0DtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=lY7tQgBf; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="lY7tQgBf"
ARC-Seal: i=1; a=rsa-sha256; t=1775812017; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FRNxqSs8W1aA33BjGtiOhXBqY66knmXXx5G7sbdGnzSpDPotoBdO2XhcAW5pv/mUQLQpntWJBaqxCr12bq2NlTGP09/255DBYTJZNa7uX+fh6XO//a1xA58r2ml+EM6hmlv97+czssQRK4fVG2DiHd2bqe3ESu3VAY2o8tALcAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775812017; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5Q3+AGBXyo5leni61U9EiK+1ujdLljCbc74iK77z/Wg=; 
	b=WfK8SKlWnxirKLcpWfJbzkwxGb4SwqrFDGpYvZEC/VxRST/8NavSKV+lU7ltjj7hFQAdGJkFra85nSocXu23Negu8x3d/gK3luM5hY/waHZitto7d7nHI7wfmAeofAUz9vYnRXwDrrgVGqAMaeShpBMH6A8NydfZFAs5mQw7zqw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775812017;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5Q3+AGBXyo5leni61U9EiK+1ujdLljCbc74iK77z/Wg=;
	b=lY7tQgBfeO9IYd+nCmgO3d2RkdU0O1DZXwiB9pf0qTO7JvK/MNxHkBHxq65gZ21A
	B/9FJSKnojliH1OQt0qDWm5nQrZEQes3R9cfojmLwjZbKES1n4TlGpyol57ljD3J5H0
	BSesTF+iOmUj9L71fWLbc7r5eL4vrLNZlBSjf0KM=
Received: by mx.zohomail.com with SMTPS id 1775812014713476.3823038152252;
	Fri, 10 Apr 2026 02:06:54 -0700 (PDT)
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
Subject: [PATCH v7 05/13] hook: allow pre-push parallel execution
Date: Fri, 10 Apr 2026 12:06:00 +0300
Message-ID: <20260410090608.75283-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410090608.75283-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260410090608.75283-1-adrian.ratiu@collabora.com>
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
index a3011a01ca..4a978aff5e 100755
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
2.52.0

