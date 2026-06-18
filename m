Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCA330D2A
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806603; cv=none; b=s2GdrzFyIuwUCtwvq4BJy+QHS8j54+Z/X5pcQV1sX7FW4kJvwC1l4l5dRVzMndBHDSwqILPa5BkkiIN7nzzR9tSJXfzxa9HsNzB/dIov5RKd6Hsj+llC8D5EzXknWXSJ6AhIpaDO1vMfOmsosfVqOrjo1Ho7whEYK23Az2YJGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806603; c=relaxed/simple;
	bh=nAbTmx7S9iauGan1pON3XDW4bbUII7NrgOZ8wSTtB2w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lTh4zhOoUqrA+7LdSV5WtnHKJRAorcQX4Iob/ceUm5Hbo/TOJ1++5no/xsBt+Cci7SLk/74TKIAvEuNuKKHZ6VaHDY44ZO7wru0JvDAZEtWYqUbTkUXsQJhxXwO6oSOFRxZYryH/E1ffQaprkniPDdDhAYtLQpX2FNuAirWP+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvu1jvp3; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvu1jvp3"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91587626ae1so144718185a.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806600; x=1782411400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1/uc69ZBPjvi761gR5LtaXgClbo5975NI6D2zpHNok=;
        b=gvu1jvp3HEIdBVENVQjJJXSOL8SaVWC/d17vYMELfna8emgYapaA/+zgkDkHAoEILa
         jOJzcL9Bg3WnPYk/wFazaOlmQWedOft8qGQJNxtXR7QTiVySd5Z+Sye7QF8Jh80Acsr3
         B8ZguREuKrnFPricR2JXRZ+fkMeRRkUpbR9pxqmoU8R0jFhWuYQLn57VN1722msSDziU
         1I9U9hD8LsdkxfDeq0GWCtxHBLcT9JtbddubZIDniCvyBnDGaGF3cHfCbNrcUVlPWQ0+
         +xiKcnWZz6YQnGLmKN2DSTe/UfG5BUvGSXcYqcZSdAxY6igfri7ijq0bzSqTVVmGo8Dt
         iPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806600; x=1782411400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J1/uc69ZBPjvi761gR5LtaXgClbo5975NI6D2zpHNok=;
        b=Xzc2L2wVkogB8S56CVe6t9zvbnTT/DkmrHRbElNwsRP/xVaYRFDEoSP8L53UtfPsAA
         JMhfZZT02Z56h93h/58eQk3FU3ClXXzciFfOBQu+FrubIxBH1RGz2d6Oq2lMASjPkFpg
         zvesjUkzvjqhkYBWua90HDDO0sCzBPIaN0s2Eqfi4vurW0Mr08btxKUmOpMgudBLvHlA
         zDBO/933z7dK1vmRW5VtOGMCQuIKoKr6MTUGAiHydlRyS7CocymZpVc1uNlvUUXDF/dG
         btel39/Rzdzb8dDVgga0wQ6ESnebNHNinwZpw39ZdwVya1RW6NpV1shinCqbMLiEEaiQ
         qcZA==
X-Gm-Message-State: AOJu0Yy1SyOvDq3eNl0itb5SPWhW7eLRvOU6p7eEFL7nsKqdgamLV9jX
	yHwg3GMpNi+NkfLCIpYVIrTshRc8LupiOU5NHFHPPTHa4E0L9vG88hDat3RMUA==
X-Gm-Gg: AfdE7cnugRJ8rXAYhyv1D75b65lRdIKy7fHgNzh9zdetVoHjDPcG7Xy2j5vkSukydcw
	DhhrJvq/WhdwK5ZGMjwdsRgogb0d97odFyv99rTS2GNN9WK1kYU3KmmUOdheU9hsacluoGw0+Em
	gKMoeIoBkKRIisOHM4z+zlwdadLSS9Tvr1k1bBngtmFA9U1cwDi+3h5f1iYVIWRZ65UQRwIQWHy
	iTS97q68Dlg3b4XgeAtnukB6dbBvObnGvIHFT1XWcEQd177XEXRNyr9nCzXI3Sy3+cLVAJan1ar
	bNkI85j2Uo6qnltYOxKeKlKIF32ndYdK46tLEe7kTTUGNBFj2Wt3ODwfMXY1x33DSVIoEGfLiBv
	HDXEBcg3THEm21U4biY7pczAoQ2sZTbgm3LVyv47IuqoGiFDhfyS+bowww2Sq6MvDQKTKy82ntf
	Eg5iORyRhaj2muCg==
X-Received: by 2002:a05:620a:290b:b0:915:c858:7d1c with SMTP id af79cd13be357-9208f832d22mr14431785a.14.1781806600424;
        Thu, 18 Jun 2026 11:16:40 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a00598fsm2160583085a.31.2026.06.18.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:16:39 -0700 (PDT)
Message-Id: <b82a997359b7e1acd16151439b1dabad4cfb20ea.1781806593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 18:16:29 +0000
Subject: [PATCH 4/7] diff: extract a line-range diff helper for reuse
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

