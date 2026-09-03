Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE42335BBB
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411927; cv=none; b=KzdEofehozh0YjclEEg05xxVy8G67wwCryYRuTSQZKMNPffjLJQk7Mu+X0IKalTpnVHLHzgj5OH3n11hX5S52+GAjWhc7ey5tFw4axdtr3dJiGUD5GPR+VtEBF2yp67e9xpMWkr7MWx1sWaQL7N6w0dSHZhKDTPaoY0uHNhH4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411927; c=relaxed/simple;
	bh=YOrGSZqATCuh5ZF55HaDCc8nY+oCS/HEgARazcjUpok=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ejwgiaKr6aXu6jqOGiesM0eSGARsORPPKhk5rAX0u3zzMuKyVfEv+rXeJuWubWbT/GrexehLWUWeZhmYjYAFwp7DL75JKbtmRVKXTYRW9lG9LkbBSC3GW4s9E9M7757vBdCAVzU4xV5iMZzl4y90MVZMH3fnCSV4Wl7IMgOzJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLh3fTx7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLh3fTx7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52eaeddc837so15660901cf.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411924; x=1789016724; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/DLqO1L30lBgoOoWvBSLqJCkgM84oKMD8MCbF7s3V/4=;
        b=iLh3fTx7wWmRlVkncv1glC3jzawbAXRfw+LeE0WmIhvpvzuFJGgzCdZUIWywufKnYm
         Tx3LFUzZfJpOAn0g46FH13h9JIeltFX21TzH3UXD0Nm05xtLP7uW8LAtyfOWEDh1eg3C
         pp1/uK8HVXq+7ME9UHHDA2XvkNuxARlccCxn9503X7WlbsnIrZ8TNFofSVIGTH0goktg
         qk42zRLF6QFFjtxunFS8eVQDfj0+Axj5iArsIWmvO1dOR2kU0e1upwVdxKoEb1xLmYlU
         Qo2gHeRvWRzzPY9Gs6hbFWeWLOvB1DJdzaL3xj4zKMpozi9NwFUk8oklQM2l9UJbC6L2
         0mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411924; x=1789016724;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/DLqO1L30lBgoOoWvBSLqJCkgM84oKMD8MCbF7s3V/4=;
        b=ngIlQfSJ9qQCFHwiE2OSGoWj/FLrolYQqu8BGoRjFcMeAuURJwxWgnCohlpfdvpmth
         EgOf4ioXwXU3HVZWe43fo1r/Eow5uVZ/W+ixyLy0ic7Msi+Tm5fCD8QRqYrQtk2dkhZC
         CfMqDP4kuixQRS9rqX1lI6437KH79OixWiAoRSMYmUEZRbJYzEA9eXq3cWpfaqWYpK0k
         q91HQYE+3qayprbZGG5yq0vm/aDEr7i2k8GRK+joMqAUVaSb6776x9uFJx/JLOIg/Q9w
         HRzn3/PZj4AW+E+KN5L5tINQVzWhSCJ6nYvg6F/7SmwDLPGziljvx28p5naP6b5W8sb/
         MHvw==
X-Gm-Message-State: AFuF++kwcL4HoA7lKOgaNDyFLgXpGS5b8r1QT4heP3PVUdIcEcfFJQOU
	n8bXB1xqNXdXOrzGWKDfXei26l8uXTIKtYw6PZg5H5iuUJ1pdLeL9gAJIDbM+T4b
X-Gm-Gg: AYBFou29igbFEMRP/mJErjBTy/RrP/rtWePUTxDhImOrKGiCvBrbDb5gPzhK/xLMhty
	LyZW7qWUEQm+C0fylglOgL4lK/F6OYgQc/BKamayhqztU54CP5xDO7H5oyxu1ghbNUvlC+hoivc
	mnHdxBZ+9womaSIANT6PbGkLG1s8ElpAUxfKhME1O1YkYv/ZnCpHbbh2Rc7c7aXoM3ApGSfiR7z
	2SdI3UUXLMEITCAOnOfQzFlw1z7WPVxRKBeCv/IwJ6IMcWpsV5u6eCLMfpiv1gXNDRAtDzu25Ct
	W+rc1RFytEPVG+0Vl17q2d2rE+6yWJkya1ycN6CqZ62mhxE7GJwLLSy3aKY3ZHCwYyy0xRqIomq
	enJDQtM/m8vY4x8KwRZJa9niIwm+TY63udL5tndNsNKqYFSYy0MKFMDPMGxs7ByxB8NBiSJIafO
	LNuBDKalKjBFJPTvcd2IvXhv0+OJ4rvTILBkTulBK8GJUwQzjoBxOFG6JH+aDvoWL1
X-Received: by 2002:a05:622a:1b90:b0:51c:2022:cef5 with SMTP id d75a77b69052e-53036cf21damr107143631cf.26.1788411924153;
        Wed, 02 Sep 2026 22:05:24 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee06c72sm35572086d6.3.2026.09.02.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:23 -0700 (PDT)
Message-Id: <020e07c0ea82c732bdb0702d2ec211503bd6f6e6.1788411919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:14 +0000
Subject: [PATCH v3 2/7] diff: simplify the line-range filter by classifying
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Currently, the diff line-range filter buffers preimage removal lines
until a postimage line arrives. That line's number confirms whether the
preimage line falls in a relevant range. However, storing preimage
lines in a separate buffer is unnecessary. Worse, the logic has a bug:
a preimage line outside the target range is included when it
immediately follows an in-range postimage line.

Preimage lines will always precede their postimage counterpart both in
content line number and emission order from xdiff's line callback
function. So preimage lines can share the postimage buffer. The filter
flushes them based on whether the postimage lines fall within the
target range.

Remove logic related to storing preimage lines in a separate "removal"
buffer and prepending them to the accumulating_hunk's line buffer.
Instead, store those lines in the accumulating_hunk's line_buffer
immediately and flush everything as appropriate based on postimage
line numbers that arrive. This resolves the bug by construction.

Also, calculate the old and new line counts for the diff hunk header
when flushing rather than storing counters in line_range_filter to
simplify state management further.

Add a test to t/t4211-line-log.sh that verifies the preimage line
emission bug is fixed.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c              | 121 +++++++++++++++++---------------------------
 t/t4211-line-log.sh |  31 ++++++++++++
 2 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/diff.c b/diff.c
index 679a0e27d4..c94ddbebe5 100644
--- a/diff.c
+++ b/diff.c
@@ -621,19 +621,14 @@ struct line_range_filter {
 	struct {
 		char func_name[80];
 		long func_name_len;
-		long old_begin, old_count;
-		long new_begin, new_count;
+		long old_begin;
+		long new_begin;
 		long lno_in_preimage;
 		long lno_in_postimage;
 		struct strbuf lines;
 		int active;
-		int has_changes;
 	} accumulating_hunk;
 
-	struct strbuf pending_rm;
-	int pending_rm_count;
-	long pending_rm_pre_begin;
-
 	int ret;
 };
 
@@ -2522,40 +2517,56 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
 	return 1;
 }
 
-static void discard_pending_rm(struct line_range_filter *filter)
+static void begin_range_hunk(struct line_range_filter *filter)
 {
-	strbuf_reset(&filter->pending_rm);
-	filter->pending_rm_count = 0;
+	filter->accumulating_hunk.active = 1;
+	filter->accumulating_hunk.new_begin = filter->accumulating_hunk.lno_in_postimage;
+	filter->accumulating_hunk.old_begin = filter->accumulating_hunk.lno_in_preimage;
+	strbuf_reset(&filter->accumulating_hunk.lines);
 }
 
 static void flush_range_hunk(struct line_range_filter *filter)
 {
 	struct strbuf hdr = STRBUF_INIT;
 	const char *line_buf, *line_buf_end;
+	long old_count = 0, new_count = 0;
+	int has_changes = 0;
 
 	if (!filter->accumulating_hunk.active || filter->ret)
 		return;
 
-	if (filter->pending_rm_count) {
-		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
-		filter->accumulating_hunk.old_count += filter->pending_rm_count;
-		filter->accumulating_hunk.has_changes = 1;
-		discard_pending_rm(filter);
+	line_buf = filter->accumulating_hunk.lines.buf;
+	line_buf_end = line_buf + filter->accumulating_hunk.lines.len;
+	while (line_buf < line_buf_end) {
+		const char *eol = memchr(line_buf, '\n', line_buf_end - line_buf);
+		if (*line_buf == ' ') {
+			old_count++;
+			new_count++;
+		}
+		else if (*line_buf == '-') {
+			old_count++;
+			has_changes = 1;
+		}
+		else if (*line_buf == '+') {
+			new_count++;
+			has_changes = 1;
+		}
+		line_buf = eol ? eol + 1 : line_buf_end;
 	}
 
-	if (!filter->accumulating_hunk.has_changes) {
+	if (!has_changes) {
 		filter->accumulating_hunk.active = 0;
 		strbuf_reset(&filter->accumulating_hunk.lines);
 		return;
 	}
 
 	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
-		    filter->accumulating_hunk.old_begin, filter->accumulating_hunk.old_count,
-		    filter->accumulating_hunk.new_begin, filter->accumulating_hunk.new_count);
+		    filter->accumulating_hunk.old_begin, old_count,
+		    filter->accumulating_hunk.new_begin, new_count);
 	if (filter->accumulating_hunk.func_name_len > 0) {
 		strbuf_addch(&hdr, ' ');
 		strbuf_add(&hdr, filter->accumulating_hunk.func_name,
-	     filter->accumulating_hunk.func_name_len);
+			   filter->accumulating_hunk.func_name_len);
 	}
 	strbuf_addch(&hdr, '\n');
 
@@ -2598,84 +2609,48 @@ static void line_range_hunk_fn(void *data,
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
-			filter->pending_rm_pre_begin =
-				filter->accumulating_hunk.lno_in_preimage;
-		filter->accumulating_hunk.lno_in_preimage++;
-		strbuf_add(&filter->pending_rm, line, len);
-		filter->pending_rm_count++;
-		return filter->ret;
-	}
-
 	if (line[0] == '\\') {
-		if (filter->pending_rm_count)
-			strbuf_add(&filter->pending_rm, line, len);
-		else if (filter->accumulating_hunk.active)
+		if (filter->accumulating_hunk.active)
 			strbuf_add(&filter->accumulating_hunk.lines, line, len);
 		return filter->ret;
 	}
 
-	if (line[0] != '+' && line[0] != ' ')
+	if (line[0] != '+' && line[0] != ' ' && line[0] != '-')
 		BUG("unexpected diff line type '%c'", line[0]);
 
 	idx_in_postimage = filter->accumulating_hunk.lno_in_postimage - 1;
-	cur_pre = filter->accumulating_hunk.lno_in_preimage;
-	filter->accumulating_hunk.lno_in_postimage++;
-	if (line[0] == ' ')
-		filter->accumulating_hunk.lno_in_preimage++;
 
 	while (filter->range_set_idx < filter->range_sets_to_filter_by->nr &&
 	       idx_in_postimage >=
 		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].end) {
 		if (filter->accumulating_hunk.active)
 			flush_range_hunk(filter);
-		discard_pending_rm(filter);
 		filter->range_set_idx++;
 	}
 
-	if (filter->range_set_idx >= filter->range_sets_to_filter_by->nr) {
-		discard_pending_rm(filter);
-		return filter->ret;
-	}
-
-	cur = &filter->range_sets_to_filter_by->ranges[filter->range_set_idx];
-
-	if (idx_in_postimage < cur->start) {
-		discard_pending_rm(filter);
-		return filter->ret;
-	}
+	in_range = filter->range_set_idx < filter->range_sets_to_filter_by->nr &&
+		   idx_in_postimage >=
+		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].start &&
+		   idx_in_postimage <
+		filter->range_sets_to_filter_by->ranges[filter->range_set_idx].end;
 
-	if (!filter->accumulating_hunk.active) {
-		filter->accumulating_hunk.active = 1;
-		filter->accumulating_hunk.has_changes = 0;
-		filter->accumulating_hunk.new_begin = idx_in_postimage + 1;
-		filter->accumulating_hunk.old_begin = filter->pending_rm_count
-			? filter->pending_rm_pre_begin : cur_pre;
-		filter->accumulating_hunk.old_count = 0;
-		filter->accumulating_hunk.new_count = 0;
-		strbuf_reset(&filter->accumulating_hunk.lines);
-	}
+	if (in_range) {
+		if (!filter->accumulating_hunk.active)
+			begin_range_hunk(filter);
 
-	if (filter->pending_rm_count) {
-		strbuf_addbuf(&filter->accumulating_hunk.lines, &filter->pending_rm);
-		filter->accumulating_hunk.old_count += filter->pending_rm_count;
-		filter->accumulating_hunk.has_changes = 1;
-		discard_pending_rm(filter);
+		strbuf_add(&filter->accumulating_hunk.lines, line, len);
 	}
 
-	strbuf_add(&filter->accumulating_hunk.lines, line, len);
-	filter->accumulating_hunk.new_count++;
-	if (line[0] == '+')
-		filter->accumulating_hunk.has_changes = 1;
-	else
-		filter->accumulating_hunk.old_count++;
+	if (line[0] == ' ' || line[0] == '+')
+		filter->accumulating_hunk.lno_in_postimage++;
+	if (line[0] == ' ' || line[0] == '-')
+		filter->accumulating_hunk.lno_in_preimage++;
 
 	return filter->ret;
 }
@@ -4033,7 +4008,6 @@ static void builtin_diff(const char *name_a,
 			lr_state.orig_cb_data = &ecbdata;
 			lr_state.range_sets_to_filter_by = line_ranges;
 			strbuf_init(&lr_state.accumulating_hunk.lines, 0);
-			strbuf_init(&lr_state.pending_rm, 0);
 
 			/*
 			 * Inflate ctxlen so that all changes within
@@ -4068,7 +4042,6 @@ static void builtin_diff(const char *name_a,
 				die("unable to generate diff for %s",
 				    one->path);
 			strbuf_release(&lr_state.accumulating_hunk.lines);
-			strbuf_release(&lr_state.pending_rm);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index d0a834ed8f..233dc232e3 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -738,6 +738,37 @@ test_expect_success '-L with -G filters to diff-text matches' '
 	test_grep "F2 + 2" actual
 '
 
+test_expect_success 'setup for trailing deletion test' '
+	git checkout --orphan trailing-del &&
+	git reset --hard &&
+	cat >file.c <<-\EOF &&
+	void tracked()
+	{
+	    return 1;
+	}
+	// trailing comment outside tracked range
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "add file with trailing comment" &&
+	# Remove the trailing comment AND modify tracked() so there
+	# is a modification to the line range we track and a
+	# modification to the following line, which we do not track.
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
+	test_grep "return 2" actual &&
+	test_grep ! "trailing comment" actual
+'
+
 test_expect_success '-L with --diff-filter=M excludes root commit' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c --diff-filter=M --format=%s --no-patch >actual &&
-- 
gitgitgadget

