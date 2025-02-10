Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CC1BC064
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173621; cv=none; b=VJgqcOmCJjD+ElON2JHaq/LbB7a7k7GboQgzmXKZ4TAoHmu6+34zXEAT9fD2V+Mi6JuK73tYpJ5ffJOyVH86cjk+IuEpNu6ecYLHpFcyG7Q0vunCHNlNdkH0mF5RLW348bVQFntRuAxBm9dQha1eaK9NZVyu+sEgw27ge0WHTe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173621; c=relaxed/simple;
	bh=O60XW27YkcTeAfBC9/iH5xZ+M4XjZGwGL1m3KYYD3I0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI3DcYkn07re/QF41ZUWzWTtL7lAUBsy4POmGDeZi1J3usrJuwBd+EVfpwBJ53GQ4ewTcn/thLcOFc0PrQZNpyJR0JxvbNFMSj7c53PAHy6EdaY//gOQzoeb1QhKQl//cttUetWXzFXopN99JFYbJMfjrn5qhpz9m1G2n9esnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfmEjGyc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfmEjGyc"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so1825713a91.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739173619; x=1739778419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVYfJ7nsLEA+C4cK1MZ96Kfrb2h2Otbnwco0uOTGXOs=;
        b=OfmEjGyc/et0mtEHwfM7nqMMZ9x2n0NcHgfdIgQgP3xfsK8Z2bYcUJ9VI0KUvpk5pe
         yWiptDFV6XnHcH3GlGQYcj+8BGhsDMi/or7e74CySFfw8294VdL6qtejRotT+8JmchK/
         Zo0Tv/xCRHtBvUudQelZdYQi17aQ5eAWTBFtvDW4gzK3V4p+aCBkvVFjLN7FlGUdPhfq
         O+k1G92GTXTXDLkWjw4y8tC90v2xS67aznY4tM4gzkHt7VisoeJSqrdBCq4tGq1OC/o/
         zApY/e2lZ0sIBSJ1w1nc4S82U+wCoJohOmqtarEMRvRKibQ6qRVVIdpDIcelEOQk5e6B
         T3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173619; x=1739778419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVYfJ7nsLEA+C4cK1MZ96Kfrb2h2Otbnwco0uOTGXOs=;
        b=CketeabO9HSMDPWDIMiv+SvtEOHeChmUsJW4lHQwzQzhCexWWDfLj8oj1ix99mskur
         5m5NWZMm5PlmsAYHUnBKRdpf+yHMyOQXiKQ1sgUsMasf6R8mapcb0PzQSnkLIVGhY7Rq
         K3urDiDb6SZMcpaO67xl16bfF5QcfjtPwlHgLsSbZlZWC8OhXKhiW56HPk0NkfPizD2P
         50gebcxTdT0Dr1JjxP8F8S6M2+vj+Jecc8eSPTLl0xBkWSSM135XedS9qJjHvUbiC401
         GjutEZT/YIfeaaIhfaplfgzfJmfuCO2T2DiL6zPwqY6uGIwjOQEmVkgkjS+CiBp8Ui4D
         8RKw==
X-Gm-Message-State: AOJu0Yxx/PFvyFir85XyRw5SbwUBds7Ga9/WuKiVabphTAxszq8lwQ2H
	thMqweoEyjoj8mzReJ5PWqgr4LQuwTa3VYl3/JQ47NXrX6etx4oXFaPDpwlD2Jc=
X-Gm-Gg: ASbGncsJffBuOXY0EQEhvRl0KqZQD08+LDluHZivaDcnF8y6yPaYWWhq6X4QlRKRe6m
	9x754mezovFaJ6QQieT1e+APBJhT0Ot0GXoEXRQ6K7NiMoOSwWLmBrD2OvUHq1GNeHz6JbEn+dU
	6wSW+9ibBxFGHf9GCDUXdBaO0U40CsGb5fUQor5cAYmhEDbiglZf+4Pj8Ai48XuW6Fm2YjPUuiJ
	IRzUKY/uFoPsEbdFK3He4uX1XaFA5KWVnCmA4Fr+6XihEdklaUroOaXcQfK/pse80WV9BaxZXP4
	1Lpyz+0sN7Zl6bNkZaWdGKlc4s/c7jeb
X-Google-Smtp-Source: AGHT+IF5WH1NzqBnzsH4zEZ4UQOnuv1dFU4LNWkPqOU/OT8Pv/lmnP0BCblxPPPUC5ORXvfI199M3w==
X-Received: by 2002:a17:90b:1d52:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2fa23f44beemr17814512a91.1.1739173617150;
        Sun, 09 Feb 2025 23:46:57 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e239eesm10187721a91.30.2025.02.09.23.46.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:46:56 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] midx: show progress during QSORT operation
Date: Mon, 10 Feb 2025 13:16:22 +0530
Message-ID: <20250210074623.136599-2-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <20250210074623.136599-1-ayu.chandekar@gmail.com>
References: <20250210074623.136599-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add progress reporting during the QSORT operation in multi-pack-index
verification. This helps users track the progress of large sorting
operations.

In previous versions, the progress would jump directly from 0% to 100%
without any intermediate updates.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 midx.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/midx.c b/midx.c
index d91088efb8..69937f5ca8 100644
--- a/midx.c
+++ b/midx.c
@@ -14,6 +14,7 @@
 #include "pack-bitmap.h"
 #include "pack-revindex.h"
 
+
 int midx_checksum_valid(struct multi_pack_index *m);
 void clear_midx_files_ext(const char *object_dir, const char *ext,
 			  const char *keep_hash);
@@ -853,32 +854,43 @@ static void midx_report(const char *fmt, ...)
 	va_end(ap);
 }
 
+/*
+ * Limit calls to display_progress() for performance reasons.
+ * The interval here was arbitrarily chosen.
+ */
+#define SPARSE_PROGRESS_INTERVAL (1 << 12)
+#define midx_display_sparse_progress(progress, n) \
+	do { \
+		uint64_t _n = (n); \
+		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0) \
+			display_progress(progress, _n); \
+	} while (0)
+
 struct pair_pos_vs_id
 {
 	uint32_t pos;
 	uint32_t pack_int_id;
 };
 
+static struct progress *sort_progress;
+static uint64_t last_max_pos;
+
 static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 {
 	struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
 	struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
+	
+	if (sort_progress) {
+		uint64_t max_pos = (a->pos > b->pos) ? a->pos : b->pos;
+		if (max_pos > last_max_pos) {
+			last_max_pos = max_pos;
+			midx_display_sparse_progress(sort_progress, last_max_pos);
+		}
+	}
 
 	return b->pack_int_id - a->pack_int_id;
 }
 
-/*
- * Limit calls to display_progress() for performance reasons.
- * The interval here was arbitrarily chosen.
- */
-#define SPARSE_PROGRESS_INTERVAL (1 << 12)
-#define midx_display_sparse_progress(progress, n) \
-	do { \
-		uint64_t _n = (n); \
-		if ((_n & (SPARSE_PROGRESS_INTERVAL - 1)) == 0) \
-			display_progress(progress, _n); \
-	} while (0)
-
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
 {
 	struct pair_pos_vs_id *pairs = NULL;
@@ -960,12 +972,15 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
 	}
 
-	if (flags & MIDX_PROGRESS)
+	if (flags & MIDX_PROGRESS) {
 		progress = start_sparse_progress(r,
 						 _("Sorting objects by packfile"),
 						 m->num_objects);
-	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
+		last_max_pos = 0;
+		sort_progress = progress;
+	}
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
+	sort_progress = NULL;
 	stop_progress(&progress);
 
 	if (flags & MIDX_PROGRESS)
-- 
2.48.GIT

