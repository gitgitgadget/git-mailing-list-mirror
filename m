Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051563382C8
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581350; cv=none; b=skb3Lc4odaIckG4FJnYilkmXPXg+HvaA/Hnu4uQqNNMDtq2cbfA2YwbV5hZNLMasbbDVJ0fzs4cTJvhPsFkxF/QBFd+3KNx2u1cO3ZGDBBTL7NUbFJ3oAxdwBsdnHUHtkqulqDvQbt3Zl3kXKVdgDph+zlg0xLFI5x2q82r8rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581350; c=relaxed/simple;
	bh=xEEL1jBKd2l+lJUzamGvWgKntRr56nStLbIGC3OA+cU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bU7HdcamLWFDxI5OuxZaStNTAyysofHgInh21oW3WZ9HVLstjwf2ohAMW55gK+sbPdPkXny70VI7Ftb01eNNm8hZKPtiviS2LoLtziEtCSFMmlMOIJDwgqezdJvN8xhvUknkTFokBF47ChfzrQ2lJAbSUF7fPZviMBd8JpjoaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTG4OZZd; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTG4OZZd"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517dc520840so22755041cf.3
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581348; x=1783186148; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmBp+CLUr2bSpkTNIInyHgYMaTvja6wMO4R1wd6DYBc=;
        b=RTG4OZZdbyKyTATF8ZrhsQeBkzUwu2UHdRrkf2q28SCEa9tNltX9kGpeCNzih58YRm
         C3Cei1WhqLU1gYQ/Pv8M/eXF9aSpaERksRCfFn8ChmaVeY6h+QhrrDcspTYabjso+SsE
         iiZNQ7SWYO+Ti6gUnYUTyujbikXBLA245xv5OeahJSQYqhSEFmgQCbRGvXzSdbeHc7Cz
         TiyXHSwVqRdrDoAXtqyMbBFBVXuZjYaXVeKmC7VM1r8JacJ/oQFkJyt1Ww1UV2nUA8Al
         GW+x+HoLchrTxhdOhLnakyXpxP71+H3seBaXzvCRRGJvSYLOC1WdF3p63THb7sy9Efqz
         v5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581348; x=1783186148;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmBp+CLUr2bSpkTNIInyHgYMaTvja6wMO4R1wd6DYBc=;
        b=McIBVJQPqF3BVCQaTe6bPLZUPivVoGkq3UOuu/sv+FCZEAjEewL4EmA3bebJw2keY6
         y1G3nG2HN1k1BEthitm71bk/kB9/fIQ+2wuCJHVhqtQv0TbtDYNElHbtR3o0gSpsEnvd
         DMcdN26ae6BusVz5YgEp3csR+5W0XhYa+EzNJ5Ftgvw088P8Qsdh6VVOdldVJEAU+81J
         7kjzIZsv0ouWfqrrwIuPjc2ebdwFpQC7yGzSo10lg69g+86SrsaX9XK9m535PYJatCO7
         ZIIx3KTEJlLpyEoYD7yHxai942vR5EQETOQUsp+6p+FNl/a08oLzmlO3XCw9HSNLQ3Uu
         /Ktg==
X-Gm-Message-State: AOJu0YwyeSg5XkTXLt1g0h2R1YnBp/xNdPoHrjvAj8rd+TJiDzJVA1hc
	C7hImkP7UZkHawmzV4f8ozvPH1vNgFdzM0HyMeq2WJ/WxqDTV8oKip4ximNYxg==
X-Gm-Gg: AfdE7cmmJvLH/NUzPGsjKaUx4BkH8tzFKLkgoahNncdb04slPM+zZNSp1bkCegdtnVC
	u9mucJ/R/51rjJpIkUEDHhKRLFs5HuvWGhnyZs5nKfglELWCmTW773KTWVeuN1xC8DjpHmK4+nX
	ZFh2XV1qp4OHFFP6YjlkRfiSOAkxlue235ssKuS+bmrDi9XZTqS39iigNl9QqOlD6W2IDEfFaxj
	+v9PxSP/m9DmPjBHYzwPmMLUbQQQrw9cGYZhgc3CQQiboeeekLFaO+3E1Htu515Jc6dhLyblqpd
	Uv/Z3Pm3ecuN+yFLEb0hHaLD9PF0r3wwH4nGo6Zl1UPsIXy2H0+CBaZm84s2R3gRYF2FpGxF8AA
	Khr0W00qOU8NK89m/P1ZjYjGej4Yn13UsSjUQ3WqGoWAXZwe9NqFgY9+PXbLBci4PZQzoptNG6h
	ex5G7x/N14MiKlCLE=
X-Received: by 2002:a05:622a:610d:b0:516:e10f:7140 with SMTP id d75a77b69052e-51a7279ff95mr160502981cf.35.1782581347689;
        Sat, 27 Jun 2026 10:29:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a514b5271sm127887371cf.5.2026.06.27.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:29:06 -0700 (PDT)
Message-Id: <5602b7976a0fcb6eeb582d4cd88ca379f48dd98d.1782581342.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:28:56 +0000
Subject: [PATCH v2 2/7] diff: simplify the line-range filter by classifying
 removals immediately
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

The filter buffered '-' lines in a pending_rm strbuf, deferring their
classification until a '+' or ' ' line revealed the post-image
position.  That buffering is unnecessary: a removal occupies no
post-image line, so it does not advance lno_in_postimage, and xdiff
emits removals before additions within a change.  A '-' therefore
arrives while lno_in_postimage already holds the index the following
'+'/' ' will occupy, and can be classified against the ranges as it
arrives.

The buffering also hid a bug: flush_range_hunk() drained pending_rm into
the range hunk whenever the hunk was active, even after lno_in_postimage
had advanced past the tracked range, so a deletion just after the
tracked function leaked into the patch.  Classifying each line as it
arrives removes the pending_rm buffer, the discard_pending_rm() helper,
three struct fields, and makes that bug impossible by construction.

With every line classified on arrival, the buffered lines are the
hunk's single source of truth, so the old/new counts need not be kept
alongside them: flush_range_hunk() derives the counts (and whether the
hunk holds any change) from the buffer when it builds the header.  Drop
the per-line counting and the old_count, new_count, and has_changes
fields; there is no longer a second tally that could fall out of sync
with the buffer.

Add begin_range_hunk() to open the accumulator at the first in-range
line, seeding both begins from the live image cursors, as the
counterpart to flush_range_hunk().  With the counting gone too,
line_range_line_fn() now only appends an in-range line.

Document the coordinate model: a block comment on struct
line_range_filter states it (the pre/post-image cursors, the 0-based
idx_in_postimage, removals classified by the following line) with a
worked example.

Add tests for the leaked trailing deletion this fixes, the symmetric
leading-deletion case, and the filter's range boundaries (a change at
the first and last line of a range, and a pure in-range deletion).

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c              | 215 ++++++++++++++++++++++++--------------------
 t/t4211-line-log.sh | 125 ++++++++++++++++++++++++++
 2 files changed, 243 insertions(+), 97 deletions(-)

diff --git a/diff.c b/diff.c
index 1e043c959f..ee765d7ac2 100644
--- a/diff.c
+++ b/diff.c
@@ -610,18 +610,58 @@ struct emit_callback {
 };
 
 /*
- * State for the line-range callback wrappers that sit between
- * xdi_diff_outf() and fn_out_consume().  xdiff produces a normal,
- * unfiltered diff; the wrappers intercept each hunk header and line,
- * track post-image position, and forward only lines that fall within
- * the requested ranges.  Contiguous in-range lines are collected into
- * range hunks and flushed with a synthetic @@ header so that
- * fn_out_consume() sees well-formed unified-diff fragments.
+ * Line-range filter: scopes "git log -L" output to the tracked ranges.
  *
- * Removal lines ('-') cannot be classified by post-image position, so
- * they are buffered in pending_rm until the next '+' or ' ' line
- * reveals whether they precede an in-range line (flush into range hunk) or
- * an out-of-range line (discard).
+ * It sits between xdi_diff_outf() and an output callback (fn_out_consume,
+ * diffstat_consume, checkdiff_consume).  xdiff produces a normal diff; the
+ * filter forwards only the lines inside the requested ranges, collecting
+ * contiguous in-range lines into a "range hunk" emitted with a synthetic
+ * @@ header so the callback sees well-formed unified-diff fragments.
+ *
+ * A diff describes the change from a pre-image to a post-image.  Each
+ * line is context (' ', in both), a removal ('-', pre-image only), or
+ * an addition ('+', post-image only).  -L tracks ranges in the
+ * post-image, so a line is in range by its post-image position.
+ *
+ * Two 1-based cursors track the next line in each image, named as in
+ * struct emit_callback and seeded from the xdiff hunk header:
+ *
+ *	lno_in_postimage  advances on '+' and ' '   (lines in the post-image)
+ *	lno_in_preimage   advances on '-' and ' '   (lines in the pre-image)
+ *
+ * Ranges are 0-based half-open [start, end), so a line is tested at the
+ * 0-based index idx_in_postimage = lno_in_postimage - 1.
+ *
+ * A '-' is not present in the post-image, so it has no post-image line
+ * number of its own.  Since it does not advance lno_in_postimage, it is
+ * classified at the idx_in_postimage that the following '+'/' ' will
+ * occupy.  xdiff emits a change's removals before its additions, so that
+ * index is already known when the '-' arrives.
+ *
+ * The synthetic "@@ -<old> +<new> @@" header has two sides, old (the
+ * pre-image) and new (the post-image), matching the xdiff_emit_hunk_fn
+ * callback; the hunk.old_begin / hunk.new_begin fields below hold those
+ * begins, and flush_range_hunk() derives the counts from the buffered
+ * lines.
+ *
+ * Example, tracking post-image line 2 (range [1, 2)) of:
+ *
+ *	pre-image  post-image
+ *	1 a        1 a
+ *	2 b        2 X      (b -> X)
+ *	3 c        3 c
+ *
+ *	classify each line by idx_in_postimage.  The pre and post columns
+ *	are each cursor's value while that line is classified, i.e. before
+ *	the line advances them (pre = lno_in_preimage,
+ *	post = lno_in_postimage, idx = idx_in_postimage):
+ *	' a'  pre 1  post 1  idx 0  ->  before start, skip
+ *	'-b'  pre 2  post 2  idx 1  ->  keep (removal)
+ *	'+X'  pre 3  post 2  idx 1  ->  keep (addition)
+ *	' c'  pre 3  post 3  idx 2  ->  past end, flush
+ *
+ * -b and +X share idx = 1 because -b did not advance lno_in_postimage;
+ * both land in the range hunk, flushed when ' c' crosses the range end.
  */
 struct line_range_filter {
 	xdiff_emit_line_fn orig_line_fn;
@@ -640,20 +680,18 @@ struct line_range_filter {
 	char func[80];
 	long funclen;
 
-	/* The range hunk being accumulated for the current range. */
+	/*
+	 * The range hunk being accumulated.  At most one is live at a time:
+	 * it is flushed and reset as the cursor leaves each range (and once
+	 * more at end of diff), then reused for the next range.
+	 */
 	struct {
 		struct strbuf lines;	/* buffered in-range diff lines */
-		long old_begin, old_count;
-		long new_begin, new_count;
+		long old_begin;
+		long new_begin;
 		int active;
-		int has_changes;	/* any '+' or '-' line? */
 	} hunk;
 
-	/* Removal lines not yet known to be in-range */
-	struct strbuf pending_rm;
-	int pending_rm_count;
-	long pending_rm_pre_begin;	/* pre-image line of first pending */
-
 	int ret;			/* latched error from orig_line_fn */
 };
 
@@ -2542,26 +2580,48 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
 	return 1;
 }
 
-static void discard_pending_rm(struct line_range_filter *filter)
+/*
+ * Begin a range hunk at the first in-range line.  Its position fixes the
+ * hunk's begins, taken from the two image cursors before they advance:
+ * new_begin from the post-image, old_begin from the pre-image.  The line
+ * counts are not tracked here; flush_range_hunk() derives them from the
+ * buffered lines.
+ */
+static void begin_range_hunk(struct line_range_filter *filter)
 {
-	strbuf_reset(&filter->pending_rm);
-	filter->pending_rm_count = 0;
+	filter->hunk.active = 1;
+	filter->hunk.new_begin = filter->lno_in_postimage;
+	filter->hunk.old_begin = filter->lno_in_preimage;
+	strbuf_reset(&filter->hunk.lines);
 }
 
 static void flush_range_hunk(struct line_range_filter *filter)
 {
 	struct strbuf hdr = STRBUF_INIT;
 	const char *p, *end;
+	long old_count = 0, new_count = 0;
+	int has_changes = 0;
 
 	if (!filter->hunk.active || filter->ret)
 		return;
 
-	/* Drain any pending removal lines into the range hunk */
-	if (filter->pending_rm_count) {
-		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
-		filter->hunk.old_count += filter->pending_rm_count;
-		filter->hunk.has_changes = 1;
-		discard_pending_rm(filter);
+	/*
+	 * Derive the hunk's geometry from the buffered lines: a ' '
+	 * counts on both sides, a '-' on the old side, a '+' on the new.
+	 * A '-' or '+' marks a real change; the "\ No newline at end of
+	 * file" marker (line[0] == '\\') counts on neither side.
+	 */
+	p = filter->hunk.lines.buf;
+	end = p + filter->hunk.lines.len;
+	while (p < end) {
+		const char *eol = memchr(p, '\n', end - p);
+		if (*p == ' ' || *p == '-')
+			old_count++;
+		if (*p == ' ' || *p == '+')
+			new_count++;
+		if (*p == '-' || *p == '+')
+			has_changes = 1;
+		p = eol ? eol + 1 : end;
 	}
 
 	/*
@@ -2570,15 +2630,15 @@ static void flush_range_hunk(struct line_range_filter *filter)
 	 * ctxlen causes xdiff to emit context covering a range that
 	 * has no changes in this commit.
 	 */
-	if (!filter->hunk.has_changes) {
+	if (!has_changes) {
 		filter->hunk.active = 0;
 		strbuf_reset(&filter->hunk.lines);
 		return;
 	}
 
 	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
-		    filter->hunk.old_begin, filter->hunk.old_count,
-		    filter->hunk.new_begin, filter->hunk.new_count);
+		    filter->hunk.old_begin, old_count,
+		    filter->hunk.new_begin, new_count);
 	if (filter->funclen > 0) {
 		strbuf_addch(&hdr, ' ');
 		strbuf_add(&hdr, filter->func, filter->funclen);
@@ -2618,11 +2678,6 @@ static void line_range_hunk_fn(void *data,
 	 * When count > 0, begin is 1-based.  When count == 0, begin is
 	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
 	 * that type will arrive, so the value is unused.
-	 *
-	 * Any pending removal lines from the previous xdiff hunk are
-	 * intentionally left in pending_rm: the line callback will
-	 * flush or discard them when the next content line reveals
-	 * whether the removals precede in-range content.
 	 */
 	filter->lno_in_postimage = new_begin;
 	filter->lno_in_preimage = old_begin;
@@ -2638,88 +2693,56 @@ static void line_range_hunk_fn(void *data,
 static int line_range_line_fn(void *priv, char *line, unsigned long len)
 {
 	struct line_range_filter *filter = priv;
-	const struct range *cur;
-	long idx_in_postimage, cur_pre;
+	long idx_in_postimage;
+	int in_range;
 
 	if (filter->ret)
 		return filter->ret;
 
-	if (line[0] == '-') {
-		if (!filter->pending_rm_count)
-			filter->pending_rm_pre_begin = filter->lno_in_preimage;
-		filter->lno_in_preimage++;
-		strbuf_add(&filter->pending_rm, line, len);
-		filter->pending_rm_count++;
-		return filter->ret;
-	}
-
 	if (line[0] == '\\') {
-		if (filter->pending_rm_count)
-			strbuf_add(&filter->pending_rm, line, len);
-		else if (filter->hunk.active)
+		if (filter->hunk.active)
 			strbuf_add(&filter->hunk.lines, line, len);
-		/* otherwise outside tracked range; drop silently */
 		return filter->ret;
 	}
 
-	if (line[0] != '+' && line[0] != ' ')
+	if (line[0] != '+' && line[0] != ' ' && line[0] != '-')
 		BUG("unexpected diff line type '%c'", line[0]);
 
+	/*
+	 * idx_in_postimage is this line's 0-based post-image index (see the model on
+	 * struct line_range_filter).  The cursors are advanced only after
+	 * the line is classified, so a '-' is tested at the same idx_in_postimage as
+	 * the '+'/' ' that follows it.
+	 */
 	idx_in_postimage = filter->lno_in_postimage - 1;
-	cur_pre = filter->lno_in_preimage;	/* save before advancing for context lines */
-	filter->lno_in_postimage++;
-	if (line[0] == ' ')
-		filter->lno_in_preimage++;
 
-	/* Advance past ranges we've passed */
+	/* Retire ranges we have passed, flushing the one we leave. */
 	while (filter->cur_range < filter->ranges->nr &&
 	       idx_in_postimage >= filter->ranges->ranges[filter->cur_range].end) {
 		if (filter->hunk.active)
 			flush_range_hunk(filter);
-		discard_pending_rm(filter);
 		filter->cur_range++;
 	}
 
-	/* Past all ranges */
-	if (filter->cur_range >= filter->ranges->nr) {
-		discard_pending_rm(filter);
-		return filter->ret;
-	}
+	in_range = filter->cur_range < filter->ranges->nr &&
+		   idx_in_postimage >= filter->ranges->ranges[filter->cur_range].start &&
+		   idx_in_postimage < filter->ranges->ranges[filter->cur_range].end;
 
-	cur = &filter->ranges->ranges[filter->cur_range];
+	if (in_range) {
+		if (!filter->hunk.active)
+			begin_range_hunk(filter);
 
-	/* Before current range */
-	if (idx_in_postimage < cur->start) {
-		discard_pending_rm(filter);
-		return filter->ret;
+		strbuf_add(&filter->hunk.lines, line, len);
 	}
 
-	/* In range so start a new range hunk if needed */
-	if (!filter->hunk.active) {
-		filter->hunk.active = 1;
-		filter->hunk.has_changes = 0;
-		filter->hunk.new_begin = idx_in_postimage + 1;
-		filter->hunk.old_begin = filter->pending_rm_count
-			? filter->pending_rm_pre_begin : cur_pre;
-		filter->hunk.old_count = 0;
-		filter->hunk.new_count = 0;
-		strbuf_reset(&filter->hunk.lines);
-	}
-
-	/* Flush pending removals into range hunk */
-	if (filter->pending_rm_count) {
-		strbuf_addbuf(&filter->hunk.lines, &filter->pending_rm);
-		filter->hunk.old_count += filter->pending_rm_count;
-		filter->hunk.has_changes = 1;
-		discard_pending_rm(filter);
-	}
-
-	strbuf_add(&filter->hunk.lines, line, len);
-	filter->hunk.new_count++;
-	if (line[0] == '+')
-		filter->hunk.has_changes = 1;
-	else
-		filter->hunk.old_count++;
+	/*
+	 * Advance each image's cursor: a line present in that image (see
+	 * the model) consumes one of its line numbers.
+	 */
+	if (line[0] != '-')
+		filter->lno_in_postimage++;
+	if (line[0] != '+')
+		filter->lno_in_preimage++;
 
 	return filter->ret;
 }
@@ -4097,7 +4120,6 @@ static void builtin_diff(const char *name_a,
 			lr_state.orig_cb_data = &ecbdata;
 			lr_state.ranges = line_ranges;
 			strbuf_init(&lr_state.hunk.lines, 0);
-			strbuf_init(&lr_state.pending_rm, 0);
 
 			/*
 			 * Inflate ctxlen so that all changes within
@@ -4132,7 +4154,6 @@ static void builtin_diff(const char *name_a,
 				die("unable to generate diff for %s",
 				    one->path);
 			strbuf_release(&lr_state.hunk.lines);
-			strbuf_release(&lr_state.pending_rm);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index ca4eb7bbc7..e9691066de 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -738,6 +738,131 @@ test_expect_success '-L with -G filters to diff-text matches' '
 	grep "F2 + 2" actual
 '
 
+test_expect_success 'setup for trailing deletion test' '
+	git checkout --orphan trailing-del &&
+	git reset --hard &&
+	cat >file.c <<-\EOF &&
+	void tracked()
+	{
+	    return 1;
+	}
+	// trailing comment
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "add file with trailing comment" &&
+	# Modify tracked() AND delete the trailing comment in
+	# one commit, so the commit touches the tracked range
+	# and is not filtered out by the revision walker.
+	cat >file.c <<-\EOF &&
+	void tracked()
+	{
+	    return 2;
+	}
+	EOF
+	git commit -a -m "modify tracked and delete trailing comment"
+'
+
+test_expect_success '-L does not include deletions past end of tracked range' '
+	git log -L:tracked:file.c --format= -1 -p >actual &&
+	# The trailing comment deletion is outside the tracked
+	# range and should not appear in the patch output.
+	test_grep "return 2" actual &&
+	test_grep ! "trailing comment" actual
+'
+
+test_expect_success '-L includes leading deletions resolved by in-range line' '
+	git checkout --orphan leading-del &&
+	git reset --hard &&
+	cat >file.c <<-\EOF &&
+	// leading comment
+	void tracked()
+	{
+	    return 1;
+	}
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "add file with leading comment" &&
+	cat >file.c <<-\EOF &&
+	void tracked()
+	{
+	    return 2;
+	}
+	EOF
+	git commit -a -m "modify tracked and delete leading comment" &&
+	git log -L:tracked:file.c --format= -1 -p >actual &&
+	# The leading comment deletion is resolved by the next
+	# non-removal line (void tracked), which is in range: a
+	# removal is classified by the position of the following
+	# line, so it joins the range that line falls in.
+	test_grep "return 2" actual &&
+	test_grep "leading comment" actual
+'
+
+test_expect_success 'setup for line-range filter edge cases' '
+	git checkout --orphan filter-edge &&
+	git reset --hard &&
+	cat >file.c <<-\EOF &&
+	void before()
+	{
+	    return 0;
+	}
+
+	void tracked()
+	{
+	    int a = 1;
+	    int b = 2;
+	    int c = 3;
+	    return a + b + c;
+	}
+
+	void after()
+	{
+	    return 9;
+	}
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "initial"
+'
+
+test_expect_success '-L change at exact first line of range' '
+	git checkout filter-edge &&
+	# Change the function signature (first line of range)
+	sed "s/void tracked/int tracked/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "change first line" &&
+	git log -L:tracked:file.c -p --format=%s -1 >actual &&
+	test_grep "change first line" actual &&
+	test_grep "+int tracked" actual &&
+	test_grep "\\-void tracked" actual
+'
+
+test_expect_success '-L change at exact last line of range' '
+	git checkout filter-edge &&
+	git reset --hard HEAD~1 &&
+	# Change the closing brace line (last line of range)
+	sed "s/^}$/} \/\/ end tracked/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "change last line" &&
+	git log -L:tracked:file.c -p --format=%s -1 >actual &&
+	test_grep "change last line" actual &&
+	test_grep "end tracked" actual
+'
+
+test_expect_success '-L pure deletion in range (no additions)' '
+	git checkout filter-edge &&
+	git reset --hard HEAD~1 &&
+	# Delete a line inside tracked() without adding anything
+	sed "/int c/d" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "pure deletion" &&
+	git log -L:tracked:file.c -p --format=%s -1 >actual &&
+	test_grep "pure deletion" actual &&
+	test_grep "\\-.*int c" actual
+'
+
 test_expect_success '-L with --diff-filter=M excludes root commit' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c --diff-filter=M --format=%s --no-patch >actual &&
-- 
gitgitgadget

