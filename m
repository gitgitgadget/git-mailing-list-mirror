Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190742D8793
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022626; cv=none; b=KwJxIideelwEs/chjOLnra1dZBkaZZ5l0uK9kQLkqPpn3hTlZ4k9Y8WqtdAWPATUjAg5hju0cbXpjc9kFxD+UZa/pnDP0MqWy2aMpikoLyce8WzUaA2VOzXJX/UeDX3dPrsOOtHO8KK4iGjqAZDW42GHbyuBmI1j4Omz4l5UMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022626; c=relaxed/simple;
	bh=gzTZ1WimXzJBQp72tkSH6vwGyCyTJln36YnT/yVdYN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKtrGRfRCBcDlyFJAH3QASZ4Psj5VTwxfVRO6+llWjHm2UULjUI1ipvA0XNDKhnXGQnW6fofpKlXMtppTolxRq7fgNIsI2KaGyc/ORgtVsrrSs/fFSG7j5c09XXFc2I9EFbVd3L9mNGGqjuQlgm/K//qJihwdngLRKpVAhaI9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYSot3Qq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYSot3Qq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824c9da9928so2604153b3a.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022624; x=1776627424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzTb5yrsZp1FbK1iAO8jRJGxQjfjLpvOpcsSMmYU6oE=;
        b=YYSot3QqiMo8f/03/0aJegM/eKRD9VPGMtB20zWIHhkPOFvgh4bIyhjiF97Q0iDIH1
         laAs0qW0a7IYKr6zc4oVhThmddZy6xEFlYJEqrOalaqsT+PjJGh9L8Y/I6huUHSiEdso
         jA//Q5LYfJ8oDV8VfOGDx3/z78AAy70sX9xYQ6KPWTO0KOP7NBLOWWz2kCehLY2s0Aqn
         lOS79AsUfuNG84LWFUjdmgKC8F3nkQvUhOb3Wb0XyPNmQqAekB5zzgohOTFXH4TbZB5C
         kxb+KV0+GDuEypV4V5JRugJscyDxTT3Q+9cvPxOL4DIDsl+WJnj6HVvBb57yVO9+AWOp
         Vn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022624; x=1776627424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzTb5yrsZp1FbK1iAO8jRJGxQjfjLpvOpcsSMmYU6oE=;
        b=PbfCt2KxzszoOJCbWQvYbrR4LyhptylFxsA0ODQXFXVKT1vDB8+5iu3+JVRchb5Y6G
         U+NYsTqrEdJ+5Y+G5jeJy66FwSHgpEaWK1IHASy2q+1Cex6JxcI6Y+Eym5pD/9HK3gfv
         9geHtOEv+imJJwbvFiVGEEzUEelDpPSKwsefToF51iInDRk5rRXb52SKja1qTBxoolEm
         7IA5c06u6n8XClHhSRS/7HK/m/v6K09ciPHTOu7oevgGwJ1ksS8VJevt9WZpuUjx6BfV
         ZrM40ozajlPdeq8IB7MQyo7Gq1G2XHFxdzDZUNjS9MNi+OmJiUs0N3Z5T00QbYTtTizz
         Nyxw==
X-Gm-Message-State: AOJu0YzkNGC3K1VR4x8uMQA0liLYeY6OC1N1AA0mCTyWCn/XE0Z/Nxhb
	LvfTLsvlCGMuTJj91NsdtCtHQrOdkdBiSZaF+QZzP8ZazoiJ+yh3O5x7
X-Gm-Gg: AeBDiesdWj+/rVLYiVxsfzHaJ0C7C77DMok0mEuDvD4OhIgvtyHDKm4lNltImN2CEbj
	I1Om2dgUz9ybuN1b5P9njZiyfvG+P/p5WiYwq7Otpc4N5hjbOa9HOd6UchxIDWon4TL4LvVgNqQ
	CFV27QiT3ckaroC9lkp8JptFskZuy3ZpW0cVZ0MqwR2pbxTo4GHICZJPTHAa0iburI5EaMNfkCy
	xB/0tZaeJz249jqpPBlz85o9Pb1ED2jQRAHzBQo+Ys5kokw9KneSEMSJaBsH26OokoiLBwc7hGZ
	kBUd9Ootg/SdT/vi4AKps5c/aDOtGx4z4hqR6FLr/tOVTG6XIYjcmUazv6HguJrUnI0xdfruekn
	dNAtetI2T1+vf6J+zuUOIrOLhRJYkDPKdpC+1IAy9E/jFfQNnAo3AkEKJ7A+iZyQg0/HCe7MbB/
	99Us8Ohwn44sOAar6oE2T4zF1JYaYEtm8g6p/h83ksgK0BrQ==
X-Received: by 2002:a05:6a20:7f97:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-39fe3f1ce8emr10994814637.39.1776022624307;
        Sun, 12 Apr 2026 12:37:04 -0700 (PDT)
Received: from localhost.localdomain ([42.113.141.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216fedfdsm8469417a12.4.2026.04.12.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:37:03 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: stolee@gmail.com,
	gitster@pobox.com
Cc: git@vger.kernel.org,
	Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH v2] backfill: add --[no-]progress option
Date: Mon, 13 Apr 2026 02:36:59 +0700
Message-ID: <20260412193659.26288-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trieu Huynh <vikingtc4@gmail.com>

'git backfill' does not show an overall progress bar across
batches, giving no cross-batch feedback during potentially
long-running operations on large repositories.  By contrast,
'git fetch', 'git gc', and 'git index-pack' all support
--[no-]progress.

Add a --[no-]progress option that tracks the total number of
missing blobs downloaded across all batches, defaulting to
showing progress when stderr is a terminal (matching the
behaviour of 'git fetch').

Add tests to verify that:
 - progress is shown by default on a TTY
 - --progress forces output regardless of TTY
 - --no-progress suppresses output

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 builtin/backfill.c  | 18 +++++++++++++++++-
 t/t5620-backfill.sh | 24 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index d794dd842f..e90c899071 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -26,7 +26,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse]"),
+	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]progress]"),
 	NULL
 };
 
@@ -36,6 +36,9 @@ struct backfill_context {
 	size_t min_batch_size;
 	int sparse;
 	struct rev_info revs;
+	int show_progress;
+	size_t nr_downloaded;
+	struct progress *progress;
 };
 
 static void backfill_context_clear(struct backfill_context *ctx)
@@ -48,6 +51,7 @@ static void download_batch(struct backfill_context *ctx)
 	promisor_remote_get_direct(ctx->repo,
 				   ctx->current_batch.oid,
 				   ctx->current_batch.nr);
+	ctx->nr_downloaded += ctx->current_batch.nr;
 	oid_array_clear(&ctx->current_batch);
 
 	/*
@@ -55,6 +59,7 @@ static void download_batch(struct backfill_context *ctx)
 	 * avoid possible duplicate downloads of the same objects.
 	 */
 	odb_reprepare(ctx->repo->objects);
+	display_progress(ctx->progress, ctx->nr_downloaded);
 }
 
 static int fill_missing_blobs(const char *path UNUSED,
@@ -121,12 +126,16 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.min_batch_size = 50000,
 		.sparse = -1,
 		.revs = REV_INFO_INIT,
+		.nr_downloaded = 0,
+		.show_progress = -1,
 	};
 	struct option options[] = {
 		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
 			     N_("Minimum number of objects to request at a time")),
 		OPT_BOOL(0, "sparse", &ctx.sparse,
 			 N_("Restrict the missing objects to the current sparse-checkout")),
+		OPT_BOOL(0, "progress", &ctx.show_progress,
+			 N_("show progress while downloading missing objects")),
 		OPT_END(),
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
@@ -150,7 +159,14 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	if (ctx.sparse < 0)
 		ctx.sparse = cfg->apply_sparse_checkout;
 
+	if (ctx.show_progress < 0)
+		ctx.show_progress = isatty(2);
+
+	if (ctx.show_progress)
+		ctx.progress = start_progress(ctx.repo,
+					      _("Downloading missing blobs"), 0);
 	result = do_backfill(&ctx);
+	stop_progress(&ctx.progress);
 	backfill_context_clear(&ctx);
 	release_revisions(&ctx.revs);
 	return result;
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index f3b5e39493..a75b84d8ac 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -133,6 +133,30 @@ test_expect_success 'do partial clone 2, backfill min batch size' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success TTY 'backfill shows progress on tty by default' '
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" clone-tty &&
+	test_terminal env GIT_PROGRESS_DELAY=0 git -C clone-tty backfill 2>err &&
+	test_grep "Downloading missing blobs" err
+'
+
+test_expect_success 'backfill --progress shows progress' '
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" clone-progress &&
+	git -C clone-progress backfill --progress 2>err &&
+	test_grep "Downloading missing blobs" err
+'
+
+test_expect_success 'backfill --no-progress suppresses progress' '
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" clone-no-progress &&
+	git -C clone-no-progress backfill --no-progress 2>err &&
+	test_grep ! "Downloading missing blobs" err
+'
+
 test_expect_success 'backfill --sparse without sparse-checkout fails' '
 	git init not-sparse &&
 	test_must_fail git -C not-sparse backfill --sparse 2>err &&
-- 
2.43.0

