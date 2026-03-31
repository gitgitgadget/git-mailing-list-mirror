Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462B3A8734
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959132; cv=none; b=DvRUx5gvNePruMYC1WWGyz7KSwDkK4IUfK7TKqyC/rUmRNbdCyvI4pXkjoovwpsnERnWzgBnmUsqm08TSFKV2cIM2RK/8kIgzp3td3d44Ym79eLGJIzXvlfS+upMoFd2chnIBO0ayPHHN879uIyLHtkHPJqgl49IL54ROsngsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959132; c=relaxed/simple;
	bh=TNkbmT/LmeF/95EVk18AjXOIk4EPu0c7HNkOuYXeky0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeCPciAMO3SV8z1yI7CqlQyVqNUdXG2OBjLsCMbjN739D8+yHWUfJajQK5CuZKkOLWWg2g8PL1kBnINIDG9B/vIHcfEh4YdPHJBGHGe1MpVdJ92ODffhVelXxy1YZi9miDUswS0rUCM7Q0igGMCNmR8F5FhCMhhcrjip2jD3MMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQ+SMgvy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQ+SMgvy"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso3707633a91.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774959130; x=1775563930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+WurA/cp4n+yc5B0fxP5EY3N7LF7lEyvfcDpzQNS/Q=;
        b=qQ+SMgvyY3kaPR04lbWZa69VIlOT1+jXLWeNGUH9+rmdms5ljZgELXbL9UTuhbA8n3
         xclwbvEEs0JuUchowFZc0E0Z4q0qnVx423MjndeaqexgetRmLfl42f0+QhWo0FVEbIYL
         1Yycmdx1QLcLcvUbE2vvy2dyWBvvFH0wViynypuoE6JRW28ai6FpotrJaZOTv5cs4jRj
         4z6N/1YvEm605xlzmwPR3A6vF/y6JB0U8WHt/txzEtKIApLfoQrGQ0tR6hGXehf7kMq1
         IZBJJQJcUWaRyAQa8wvJ4vg1K4rC1nqhVZYZMNJ9jz+frXMqmUKaUxeKytAfJYyrQ/OY
         X3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959130; x=1775563930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+WurA/cp4n+yc5B0fxP5EY3N7LF7lEyvfcDpzQNS/Q=;
        b=dJfmNsFn033afLKk3DLtgNHRMZnq2QPNt9jLBPvFeMMAKue2xgZvsXhAYAfbrddUvN
         3z5HOO7p3qo4VtoMUFmQfapw+UcodtJuEFR+xk2uMT0s+bZCKSJTfG03XUYwGJY5HNyJ
         J4iAemljyT4G4S1Aj4NcX62a24JFf1zgBmWH09uh664YDCoPCnKreO9YJrOsPuQl2Ngb
         TTbI1OAt+YVziFgTwzXTkMheh6sZ9yK78ln0aemsDX/dZISnx7mPjt3t+5HGknkCnFet
         8FjIVe89D/OpOyhdtpp+/wMC3cVso9kb5f44ulIfohcgCb2rWgIGtzN8ZKAmR6KNz3O4
         GMWQ==
X-Gm-Message-State: AOJu0YyU2htQ0hejXEmYImJnSIZ4gw/YyZL00bdmhCf/OYB1i0oTHTwr
	6g6lWgWgs2X0VtlukWey+Rsjv9gIOAHWIcJTySliqLd5iT5+dNYHkKJc8ScfIAVA
X-Gm-Gg: ATEYQzzFqL95/CYv+jnKLdtJf9zz98Ylmwk/QQSMs+bx6+CDWnW+NDiivtTxjD98otm
	EkLrfKd2Nmoe+DvJv0itGbBLQ3fjCcTiUXfY6u5Zu1DGzTr78jrHKv/wV0qmmThfUGS9X/Kds00
	hLUaQcohxYnXg7VWUFOdGZMXedz3UuIPAKE5/lPu0s4zisHMY2aMkWiW6Dflxzl162expemxZcI
	Mm0zPO4d/pATkBDmKf3fTZM7Olu3l+v8TUlF5LXj8qECtYxmxFWTFnNFMzGE7GTMj84vly8ivqA
	tCvjnP04jrVNdbMHr5xbDBWUWzdB4vRXnPQUyfr44thKylZ9u6aMB1XosOgpn/QAvjNxv2a5i2H
	k2OZOP0HWuOyQI6KVL1fDNbQvgPOGlUbV05O1DQSqkS4/ykFCPv3ofSDm4C+VovdKMYFC+DXTEt
	mEs9P+YATsk64fcBNGoZnn3PY5rz6PlbGToW+RKLmeKDC1UW0PEb6fZXl+CJDPjEM5rHWUzTYJ1
	UP2oTUVZg==
X-Received: by 2002:a17:90b:4c8d:b0:359:855f:ff96 with SMTP id 98e67ed59e1d1-35c300b29b3mr15342776a91.17.1774959129933;
        Tue, 31 Mar 2026 05:12:09 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6953a8sm1608558a91.12.2026.03.31.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:12:09 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [RFC GSoC PATCH] backfill: skip downloading for empty batches
Date: Tue, 31 Mar 2026 21:12:04 +0900
Message-ID: <20260331121204.787826-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git backfill finishes its object walk, it unconditionally calls
download_batch to process any remaining objects. If the repository
is already up-to-date (no missing objects found), this call still
performs an unnecessary directory scan via odb_reprepare.

Fix it by adding a check in do_backfill to ensure download_batch is only
called if the current batch actually contains objects (nr > 0).

To facilitate testing and provide better telemetry, add a trace2 data
event for batches_requested. This allows us to verify that no batches
are processed when the command is run on an up-to-date repository.

Add a test case in t5620-backfill.sh to ensure silence and efficiency
when no objects are missing.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
Need discussion:
1. Is adding trace2_data_intmax() the preferred way to verify this 
   behavior in our test suite, or should we rely on redirection of 
   stderr to check for progress messages when the progress option
   is supported?

 builtin/backfill.c  |  3 ++-
 t/t5620-backfill.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 0f31844ce7..67f9f28daf 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -58,6 +58,7 @@ static void download_batch(struct backfill_context *ctx)
 	 */
 	odb_reprepare(ctx->repo->objects);
 	display_progress(ctx->progress, ++ctx->batches_requested);
+	trace2_data_intmax("backfill", ctx->repo, "batches_requested", ctx->batches_requested);
 }
 
 static int fill_missing_blobs(const char *path UNUSED,
@@ -109,7 +110,7 @@ static int do_backfill(struct backfill_context *ctx)
 	ret = walk_objects_by_path(&info);
 
 	/* Download the objects that did not fill a batch. */
-	if (!ret)
+	if ( (!ret) && (ctx->current_batch.nr > 0) )
 		download_batch(ctx);
 
 	path_walk_info_clear(&info);
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index a1a8d736db..d3cc4022bf 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -221,6 +221,22 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
 	test_line_count = 12 missing
 '
 
+test_expect_success 'backfill does not request batches when up-to-date' '
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" backfill-up-to-date &&
+
+	# First trigger to have a full download
+	git -C backfill-up-to-date backfill &&
+
+	# Second trigger to verify when already have a full download previously
+	GIT_TRACE2_EVENT="$(pwd)/up-to-date-trace" git \
+		-C backfill-up-to-date backfill &&
+
+	# Verify no  batches_request occurr
+	test_grep ! "batches_requested" up-to-date-trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.43.0

