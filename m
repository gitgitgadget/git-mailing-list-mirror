Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBA2FA0C6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727723; cv=none; b=kDz2ZgNjjHRpjGS1oyfn5eTwavPsBhYgswh0AkLLH4U83faxwGctaI9LqRny0AMCMvJ+wGmXQnjepEPW+spSX+JDJZzj61DVb5JuJkxK+xdp2C8pf4StxFVIyY5kv3Gkze4xJLOvffbo36BFicMsqbnXcNf8wxfB301bgpGMbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727723; c=relaxed/simple;
	bh=D/K7gZEsV40tY1kwvGsnxHHH9H68SJp9a3QGraZu66k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMLllWidHIJBACzrgryP5a9wVfj+rGl2onm+78bzCGlfqtltFzMtGR6skN/tfMUWkKiqcUveHpw88UKAC6TjYC6rYbq07ciuWDvjJjh5RfGot2zr61sIr7Dt4DEjAR3gachSpjSvwoB2tMVb1rzjymu5WFiVASUi8SfLl+f8M7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjsjlkuV; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjsjlkuV"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso36100115e9.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790727719; x=1791332519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlrI5d9Jn5H9+o9Y6qk8ltxOYbQzUrnLTb2yMofGUdc=;
        b=pjsjlkuVMenMNvbVNo2ug8es9iRjg3pWxreTYOELUVRUj5VtTLt6T26GBzRzIq2Fcv
         3frjlfNuUW7uwNWskt6mBIP2SG5jLmA1DmIwVUdUTjsIlGIw0kXowD+EPV9fd85gjapF
         Nodb2lBX+O38jPiEjJ44Mz8Nlqqe2sHzfZsV2gLF0Uq+TgP+yz5UPPyIFrUQM7wzx0RA
         IEx6HyyYtBhVK7+YojGNaMhDmxSZIQscY1K2EYu1wV+60yQJYjIulo8a504GHm4nsKWX
         MRUv1nuEyimWJwGMwJS7hwQTzqHrD4r8mytOtKQoL2HRhFCrzH1OsjuRpDlQPqNqs0/R
         Bsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727719; x=1791332519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RlrI5d9Jn5H9+o9Y6qk8ltxOYbQzUrnLTb2yMofGUdc=;
        b=AiJETUB32tDnQoVir4ItIAjKNRWHYcXjycMHX351rVvRKE3JHf6O1V7ozXm2mI4DcM
         E5VJBnU4Js0gtZN3wq7SxXzcqg3yQmeywolbLtgtPaFiv8MuznGRy6nLjEO5YuRC7Uso
         CyDRf5xMdTDNduNlXZAiYK2cigGmY2eyMLbLx+fwE1D94rrGKJ68qchGHEvlGnfwpaFA
         xluSP4Gn7SbO08culeAjPdQw5L5HqExqK5jpLOxD96Q6IZdHzulQO3ZrizOdARRV5qRy
         PGrLNtipx8WmtXQmqKQ7X3arFz+jWh9x6vJn8VCLDvVAnVVwWLVrOoOviPqImytHwtzs
         rL6g==
X-Gm-Message-State: AFuF++lAcwMBAgMa2ASQ49QpVB3oDNe5tSwV8mjvy307ADaEENS7MQQM
	CgLReWKWWM2pmdV0Auwzu2gIUJOLrZZRbnEz9qZybz1CudYlT04APnLa/EvUP0NPPog=
X-Gm-Gg: AYBFou2wDePn1bFHgUYNV7BMMjt0yWLjVu/AXAnY//nSc05cLyuBQOSgHksrxYRckBN
	zYrisdrIuiXKZhhoPwbesU/M/hWvw7fHeANM7qlEmiMGuYCp2z3z2FzkGjISXFl44NUACgVwfHw
	ZQxchpv2wnjYdPQwNI+SS+3/D6MjimCd0ILczgbo6IfY7s+JPgCRkWwMWkR8i93PP293RVAxxp/
	G2Zhf5M9UV7EVSaX13x7uO6WVBdBC2QMsB3b8l4NHxIk71/d5QhanIBdwO3ERLOTrt/8z/TaDJf
	RkKG6/j6Z8FUgs1KrabVifaDLXj5YCSU+lKBJdbHnlw8P54Wxd/IBO5Bl+9howo7nJrRZNjeOKu
	EmQr2HD03Y8MxFEH3AQGDqTosN9ZkS6AvEX4xU1y0rg+TESb+oFYs65648EBm2c0Y+Zscxp+q+8
	VtY8kEQLhRaUZGu9UJBUv65OU7AiAvBKoU1jGt3ODrzWVitun1kiAKiH04ksRSQ2rprGysQsh/4
	NiAjqjBNG8TY/POP/8BUd6NfV6eKn91yc6edDxyuudyYVUgMMKogyrIrG6oNEtCgxJr6ISIMIEo
	P5uUmBOCCCYD/AM0Cgve8oYzAAM9akYY2eJ1eQKgg+NOXzI3NCp4AFsZlZ8xKLG8+fwhIytwyYN
	I+kf5l43vC11ZVW5DT3jJ
X-Received: by 2002:a05:600c:c4a8:b0:49f:ce72:dfe7 with SMTP id 5b1f17b1804b1-4a01515104emr9661595e9.35.1790727719110;
        Tue, 29 Sep 2026 17:21:59 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015cde27asm5135615e9.3.2026.09.29.17.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:21:58 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 30 Sep 2026 01:21:49 +0100
Subject: [PATCH RFC 4/5] backfill: add --dry-run option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-backfill-dryrun-v1-4-1128f247ee01@gmail.com>
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Users have no way to know how many blobs git backfill is going to
download before running it.

Add a new --dry-run option to the backfill command. The objects are
walked as usual, but instead of fetching each batch of missing blobs
they are only counted, and the total is printed at the end.

A subsequent commit will also print their size when the server supports
the object-info capability.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-backfill.adoc |  6 +++++-
 builtin/backfill.c              | 37 +++++++++++++++++++++++++++++++++----
 t/t5620-backfill.sh             | 26 ++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index 82d6a1969d..08f19fea17 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [synopsis]
-git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [<revision-range>]
+git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [--dry-run] [<revision-range>]
 
 DESCRIPTION
 -----------
@@ -70,6 +70,10 @@ OPTIONS
 	--onto TARGET A..B`, where A..B normally excludes A but you need
 	the blobs from A as well.  `--include-edges` is the default.
 
+`--dry-run`::
+	Do not download any objects. Instead, print the number of
+	missing blobs that would be downloaded.
+
 `<revision-range>`::
 	Backfill only blobs reachable from commits in the specified
 	revision range.  When no _<revision-range>_ is specified, it
diff --git a/builtin/backfill.c b/builtin/backfill.c
index e71e0f4742..6019112966 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -26,7 +26,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [<revision-range>]"),
+	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [--dry-run] [<revision-range>]"),
 	NULL
 };
 
@@ -36,6 +36,8 @@ struct backfill_context {
 	size_t min_batch_size;
 	int sparse;
 	int include_edges;
+	int dry_run;
+	size_t total_batch_nr;
 	struct rev_info revs;
 };
 
@@ -58,6 +60,15 @@ static void download_batch(struct backfill_context *ctx)
 	odb_reprepare(ctx->repo->objects);
 }
 
+static void dry_run_batch(struct backfill_context *ctx)
+{
+	if (!ctx->current_batch.nr)
+		return;
+
+	ctx->total_batch_nr += ctx->current_batch.nr;
+	oid_array_clear(&ctx->current_batch);
+}
+
 static int fill_missing_blobs(const char *path UNUSED,
 			      struct oid_array *list,
 			      enum object_type type,
@@ -73,8 +84,12 @@ static int fill_missing_blobs(const char *path UNUSED,
 			oid_array_append(&ctx->current_batch, &list->oid[i]);
 	}
 
-	if (ctx->current_batch.nr >= ctx->min_batch_size)
-		download_batch(ctx);
+	if (ctx->current_batch.nr >= ctx->min_batch_size) {
+		if (ctx->dry_run)
+			dry_run_batch(ctx);
+		else
+			download_batch(ctx);
+	}
 
 	return 0;
 }
@@ -131,10 +146,23 @@ static int do_backfill(struct backfill_context *ctx)
 
 	ret = walk_objects_by_path(&info);
 
+	if (ret)
+		goto end;
+
 	/* Download the objects that did not fill a batch. */
-	if (!ret)
+	if (!ctx->dry_run) {
 		download_batch(ctx);
+		goto end;
+	}
+
+	dry_run_batch(ctx);
+
+	printf(Q_("After backfill, %" PRIuMAX " blob would be fetched.\n",
+		  "After backfill, %" PRIuMAX " blobs would be fetched.\n",
+		  (unsigned long)ctx->total_batch_nr),
+	       (uintmax_t)ctx->total_batch_nr);
 
+end:
 	path_walk_info_clear(&info);
 	return ret;
 }
@@ -157,6 +185,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 			 N_("Restrict the missing objects to the current sparse-checkout")),
 		OPT_BOOL(0, "include-edges", &ctx.include_edges,
 			 N_("Include blobs from boundary commits in the backfill")),
+		OPT__DRY_RUN(&ctx.dry_run, N_("Preview the number of blobs to be fetched")),
 		OPT_END(),
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 7462280470..e76fa6081b 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -141,6 +141,32 @@ test_expect_success 'do partial clone 2, backfill min batch size' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success '--dry-run reports missing blobs without fetching them' '
+	test_when_finished "rm -rf backfill-dry-run dry-trace" &&
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" backfill-dry-run &&
+
+	GIT_TRACE2_EVENT="$(pwd)/dry-trace" git \
+		-C backfill-dry-run backfill --dry-run >out &&
+
+	test_grep "48 blobs would be fetched" out &&
+	test_grep ! fetch_count dry-trace &&
+	git -C backfill-dry-run rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing
+'
+
+test_expect_success '--dry-run with no missing blobs' '
+	test_when_finished rm -rf backfill-dry-run &&
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" backfill-dry-run &&
+	git -C backfill-dry-run backfill &&
+
+	git -C backfill-dry-run backfill --dry-run >out &&
+	test_grep "0 blobs would be fetched" out
+'
+
 test_expect_success 'backfill --sparse without sparse-checkout fails' '
 	git init not-sparse &&
 	test_must_fail git -C not-sparse backfill --sparse 2>err &&

-- 
2.54.0

