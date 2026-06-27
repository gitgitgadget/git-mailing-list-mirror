Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D40324B20
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581353; cv=none; b=c5pcDND+BuLGBRU9EtqGoc3LVD0DWxwlDBO+UEJe4FkEWo22Y67PvL5zAJIj7x+D/2ETRRjfDBhhiDzYM1Ka5rYiWPTrMnmO3jSwIQUkKq5M7lY+KQDfEkdFrT4aaxkIqMQuG3sWfWrvj6qEOdetVRSIGm47ownjX7C+/YrJLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581353; c=relaxed/simple;
	bh=nAbTmx7S9iauGan1pON3XDW4bbUII7NrgOZ8wSTtB2w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tPVu2Xem3lZ6xaQZJuNlbx82nu6NC/XZUun00eANLVyOSIsrWwu8iNMOwwU+yIcHIaB8HLnN7tOBorIqJO9jdlxyMyCjhrLT7xl6zV+yU4FcP0KwRHbEasEMmceFB/6EX8IKWhkBfUYKP64U82QWr565QRzG09UeJoxqwzoh/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G159zPOa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G159zPOa"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51a8f78b1d2so4443921cf.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581351; x=1783186151; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1/uc69ZBPjvi761gR5LtaXgClbo5975NI6D2zpHNok=;
        b=G159zPOamiEAp02hC2xJWoJvgvms+m0j5LehMmEAQIvaVPMp3rmeFGzlgXOFlCAxK7
         4jSZMWgNwlMWgyRM2aY8S7LQVfUBQHmWWVhVuYZ+7oplKUc68zihIk8IIF4cBzIfMgSr
         I9/r0HjenwB1MvgDh3uLGfRUJIfHbHR3GEwdleYDkY4wsceaNFN/pArjMPJymj+PKO9Y
         Kf9Vs2zwUrZPtEqaaqLHOWoUqYfZoYvrjjK0+S+OPwtGNsszUAYf99Dn1IN7cin8sjmd
         tNhviFBX+uM9iHdnpbNLpfi/H3heWx9jNBJl1E5hj0lKTVaFXZ/BrtLdzKLtYn6IilXC
         1hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581351; x=1783186151;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J1/uc69ZBPjvi761gR5LtaXgClbo5975NI6D2zpHNok=;
        b=oMLyTFezwPnlgJup8OXgMfVwcYOA+mP3aUKo4QE/cV872nayiIPQuUsHqJSMSQWoYI
         KWwUpQQYdQHQKKKzIUA4ghe433Ubj2T2GFFXoFZTpdcrAQ5r9uPRBEOFUL7vhL+NsS8U
         9I4evdP9Sm6AwGt4LMKSrkhLG4+IpBF3Xap8MRb8+VBaH/2t6DDiaUDpX+5gAsQGwAun
         Sx8tPmL7UUJ6xWmc2ZiDSwENlxtd0dNJuHG+GEOkZxYNOXmIQyh80evOUB8WZP3orxkv
         o3pc3uKleuZmVEbWTqKVGp7dpRWfZXU7HIyYmmIK0DCVs/r5AUViTCBDtR3w8EVTAkjF
         Q6BQ==
X-Gm-Message-State: AOJu0YzhFrf8KVu3LxO4Odx+CtrSyKV4/VxzYSvmiVLRU3W/jjO5hnH6
	mPsh8CE+FquO/h7ABCPSa0wXE9E8j0eps/nApoxg/XGeBenkuqNY/uzRfNAHWQ==
X-Gm-Gg: AfdE7cl0BAOztHJFNRgfLJLOYkWypuOhOHxLv5SFF0lg7Uqb7MSzbp58/dpDcxUF9PO
	0cZygm6pTnjtXlCVGFYReAPI8H3BeQRE3/euPYN2iey6Tqj6K+qrEOrZKm9ABTHmj8IigAN3Nsi
	iI1xjIv0fEAuUeSTx3mR1sKZHDiPESxfi9R82j/ofZfMbWwRy6iRVwc7spSn1ZqEz2smbQKwHRG
	cQp3vt9ayyea9XgL+Wl5Y+JTQ5Lk12nO+QEGrMppdXcY9PvglfX5yBVWiuHccNQdMz67OmYnUts
	qbZtIIcYYs0VeIwRkDlfsG1dLK+ODPk91G5Ol73wRVCc1TfFLT1zU7Z5WHlR/WDuBl8T5BXOQnC
	mvS6Gkj9cshiAWIhUj2B6PK6v6oDOP4x1pOeXBzJmgJhzbqzNXfIF5AulZZVzTSAeuQg88x+MU/
	fuYYVNNNsegSuJK4w=
X-Received: by 2002:ac8:6f1b:0:b0:517:76ad:8161 with SMTP id d75a77b69052e-51a8b02bce8mr75502641cf.24.1782581350840;
        Sat, 27 Jun 2026 10:29:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015805sm251762606d6.1.2026.06.27.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:29:10 -0700 (PDT)
Message-Id: <b82a997359b7e1acd16151439b1dabad4cfb20ea.1782581342.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:28:58 +0000
Subject: [PATCH v2 4/7] diff: extract a line-range diff helper for reuse
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

builtin_diff() open-codes the line-range filter setup and teardown
around its xdi_diff_outf() call: zero the struct, point it at the
output callback, inflate ctxlen to the largest range span so each range
yields a single xdiff hunk, run the diff, flush the trailing range
hunk, and release the buffer.  The upcoming -L stat and check formats
need the same sequence.

Extract line_range_filter_init() for the setup and a
line_range_filter_diff() helper that prepares the xdiff config the
filter needs, runs an initialized filter through xdi_diff_outf(),
flushes the final range hunk, and releases it, returning the latched
error.  The helper inflates ctxlen to the largest range span so each
range yields a single xdiff hunk, and clears XDL_EMIT_NO_HUNK_HDR so
the hunk headers the filter seeds its position from are always emitted.
Folding both into the helper keeps these invariants, which the filter's
position tracking relies on, in a single place for every consumer.
builtin_diff() now does init + line_range_filter_diff(); the next two
patches reuse them in builtin_diffstat() and builtin_checkdiff()
instead of repeating the boilerplate.

No behavior change: builtin_diff() leaves XDL_EMIT_NO_HUNK_HDR unset,
so clearing it is a no-op until the suppressing consumers arrive.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c | 100 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/diff.c b/diff.c
index 9751bb6798..6233a96bf0 100644
--- a/diff.c
+++ b/diff.c
@@ -2580,6 +2580,18 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
 	return 1;
 }
 
+static void line_range_filter_init(struct line_range_filter *filter,
+				   const struct range_set *ranges,
+				   xdiff_emit_line_fn line_fn,
+				   void *cb_data)
+{
+	memset(filter, 0, sizeof(*filter));
+	filter->orig_line_fn = line_fn;
+	filter->orig_cb_data = cb_data;
+	filter->ranges = ranges;
+	strbuf_init(&filter->hunk.lines, 0);
+}
+
 /*
  * Begin a range hunk at the first in-range line.  Its position fixes the
  * hunk's begins, taken from the two image cursors before they advance:
@@ -2744,6 +2756,50 @@ static int line_range_line_fn(void *priv, char *line, unsigned long len)
 	return filter->ret;
 }
 
+/*
+ * Run an xdiff pass through an initialized line-range filter, flush the
+ * final range hunk, and release the filter.  Inflates ctxlen to the largest
+ * range span first, so that every change within a single range lands in one
+ * xdiff hunk and the inter-change context is emitted; the filter then clips
+ * back to range boundaries.  The optimal ctxlen depends on where changes fall
+ * within the range, which is only known after xdiff runs, so the max span is
+ * the upper bound that guarantees correctness in a single pass.  Every
+ * consumer (patch, diffstat, check) relies on one xdiff hunk per range, so
+ * this lives here rather than at each call site.  Also clears
+ * XDL_EMIT_NO_HUNK_HDR: the filter seeds its per-image position from the hunk
+ * headers, so a consumer that otherwise suppresses them (diffstat) still gets
+ * them here.  Returns non-zero if xdiff or any forwarded callback failed.
+ */
+static int line_range_filter_diff(struct line_range_filter *filter,
+				  mmfile_t *mf1, mmfile_t *mf2,
+				  xpparam_t *xpp, xdemitconf_t *xecfg)
+{
+	const struct range_set *ranges = filter->ranges;
+	long max_span = 0;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ranges->nr; i++) {
+		long span = ranges->ranges[i].end - ranges->ranges[i].start;
+		if (span > max_span)
+			max_span = span;
+	}
+	if (max_span > xecfg->ctxlen)
+		xecfg->ctxlen = max_span;
+
+	/* the filter seeds its per-image position from hunk headers */
+	xecfg->flags &= ~XDL_EMIT_NO_HUNK_HDR;
+
+	ret = xdi_diff_outf(mf1, mf2, line_range_hunk_fn,
+			    line_range_line_fn, filter, xpp, xecfg);
+	if (!ret) {
+		flush_range_hunk(filter);
+		ret = filter->ret;
+	}
+	strbuf_release(&filter->hunk.lines);
+	return ret;
+}
+
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old_name = a;
@@ -4108,49 +4164,15 @@ static void builtin_diff(const char *name_a,
 			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
 				      &ecbdata, &xpp, &xecfg);
 		} else if (line_ranges) {
-			struct line_range_filter lr_state;
-			unsigned int i;
-			long max_span = 0;
+			struct line_range_filter lr_filter;
 
-			memset(&lr_state, 0, sizeof(lr_state));
-			lr_state.orig_line_fn = fn_out_consume;
-			lr_state.orig_cb_data = &ecbdata;
-			lr_state.ranges = line_ranges;
-			strbuf_init(&lr_state.hunk.lines, 0);
-
-			/*
-			 * Inflate ctxlen so that all changes within
-			 * any single range are merged into one xdiff
-			 * hunk and the inter-change context is emitted.
-			 * The callback clips back to range boundaries.
-			 *
-			 * The optimal ctxlen depends on where changes
-			 * fall within the range, which is only known
-			 * after xdiff runs; the max range span is the
-			 * upper bound that guarantees correctness in a
-			 * single pass.
-			 */
-			for (i = 0; i < line_ranges->nr; i++) {
-				long span = line_ranges->ranges[i].end -
-					    line_ranges->ranges[i].start;
-				if (span > max_span)
-					max_span = span;
-			}
-			if (max_span > xecfg.ctxlen)
-				xecfg.ctxlen = max_span;
-
-			if (xdi_diff_outf(&mf1, &mf2,
-					  line_range_hunk_fn,
-					  line_range_line_fn,
-					  &lr_state, &xpp, &xecfg))
-				die("unable to generate diff for %s",
-				    one->path);
+			line_range_filter_init(&lr_filter, line_ranges,
+					       fn_out_consume, &ecbdata);
 
-			flush_range_hunk(&lr_state);
-			if (lr_state.ret)
+			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
+						   &xpp, &xecfg))
 				die("unable to generate diff for %s",
 				    one->path);
-			strbuf_release(&lr_state.hunk.lines);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
-- 
gitgitgadget

