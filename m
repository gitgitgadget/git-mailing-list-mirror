Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D870262FC1
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230634; cv=none; b=AQ+Qlbc4QWvzgk9XhoAS45L41KuXHRcBaA+NtWZMFifjBDuie4tbLIJnIDVVeoDOkj5ciSmxq9kxGmoKPtpI3ieZLXvZhg/K5xc1Q8TznCfR7Kvf0/zhV6QJM559f4cRmt7ignfbgw/l2eaV116p4OCrsxwyjBb4gazm77RFdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230634; c=relaxed/simple;
	bh=D5jOdPFFRZGrPkBrhyyIl3Wrc41kcQkwt/P1wIEF2Ig=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rdSUKkOaq3ezTFNN0etWVEyjXR2Q2ZjGpVksa8SLHGOB9DaEq7PhPsrcvy7lI1uDb41woZH+Oz8ecR5kr3/47AZulqAcA1REMcXoFi4lKmmkmidzprZDdL+/KhFpm+NONyBQb4nJvoqFsAoc7d24Yg+KOVhhNdRmwaCo6qVWLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtZvcrOz; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtZvcrOz"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c7212836bso8043475c88.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777230632; x=1777835432; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AikmbQ5U18YdNP+O8OYJpIoRX7fDLe5dxYvU0Q1Vpro=;
        b=LtZvcrOzJTCWV6x2QzHvD4c6nviAbhl0o4h4HEKf2TcY5EzkIgfZaf4hVhn2kXksBY
         xG7Kqw583ntSCeFwSwpDUPBCFnDfYrSkv5jhAPoVfIgrQtYeDIqBYA01zcbcF292QHSA
         2Dle6nQdCX8LsumKBhstc01qbkxL5EoitrH+Oev5Dcmm3S7EvnxLabrRZVqS8H+j4jAk
         /uhAFK3ZP/pLOTNa5p4u/k9PfcGybaE93Sf6I73wlVPBSQGpPxVgq4SRLyOWvZFJH4i4
         aHu7Sc8yXy82aNqNrV7CyQrJ1xBQxFxLYOxSaOZowXu1lfDqtvgIsx1NlEDdGWdXxD5E
         /BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230632; x=1777835432;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AikmbQ5U18YdNP+O8OYJpIoRX7fDLe5dxYvU0Q1Vpro=;
        b=p9bam8EQWOgs7REs+Js3ihkDZSBpztc/1KNznVOF5N64rFnBAwTpDqzEVRtK1ncc7U
         zYtltmSecm+LRa4C56r0jVv1ZUOo8qYp3t+PpT0XLYW2a4K3LrVPaggkzsJQOTHe6Y6Q
         mnkBH5TOWBIWJA5a/5sPPUkMdVzYLMlLOkicGA/oy8KTLjxNvk5vxsytHlNojEuiDP7L
         /6fqfvlvL4dSw3cWgifvZVyzx+jJ9lSuJ9SDRDE77lAFAFauo883K4d9zHRgE/6N64tU
         bDiWHohDJ4a8t7dL4Vb6K3Fze8vwjn3/ZZK6KOJbClDMwhiSKVhoW9fsIupymUXy5CGI
         0Sbg==
X-Gm-Message-State: AOJu0YxF5oLTktJAJGJToh1f22Zv35oJ0OGj7BuSVmfffxphEj4uMNCb
	XMY4YupeHz55VCVML5Md6FTVIsPu8B9yKgwCxJuPKdDl6sY237R/1Ahg9BQTlA==
X-Gm-Gg: AeBDietZO2z+3rXGS63gegtjG8E4lNs2W6wafmQHiAZx9L04eQmVlyeZPJDoyKp8HtN
	Dlvr7aUnvpFkfc5stUexZQYXbUr4HS6c1mkNKiLXZk29AXqD0gx0y2Cpe6r554D596uspYCF09C
	drIh2R3Dc803aiC6sy1Ocvki4KR5t6FfRMrU1bD53CfOaFBQZdTeZVPS3+nzzdJv9Bturwj6IsV
	U4H7BW9axCIumM9bgSM5UDHenQhv+OohO+mwBy+B73lOOkw+N4LPmVisIIdN4g9tKBcHdufZ750
	h1Pvxdjhimh+zDL8ZL7QxYAX0exA6XOSs449lOL8SCkfO8KCu9ebxKmGln8alc4VIgn7QhbaIns
	NDzQQQqUCkxf+9gnQQluKLszBGIGWxKVbHTJW7LTe8t1aH+1k96i8ho5KC/DyYC3OZFCG6foNZv
	CwZ3uAt98spFc83I/e+rtFI0N/Tfk8vWBT+0Lwhw==
X-Received: by 2002:a05:701b:2415:b0:12d:b26f:cafd with SMTP id a92af1059eb24-12db26fcc16mr9036999c88.5.1777230631610;
        Sun, 26 Apr 2026 12:10:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbaab165bsm25749673c88.6.2026.04.26.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:10:30 -0700 (PDT)
Message-Id: <pull.2099.git.1777230630020.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 19:10:29 +0000
Subject: [PATCH] diff: simplify line-range filter by classifying removals
 immediately
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

The line-range filter buffered '-' (removal) lines in a pending_rm
strbuf, deferring their classification until a '+' or ' ' line
arrived to reveal the post-image position.

This buffering is unnecessary.  Removal lines are pre-image content
that occupies no post-image space, so they do not advance lno_post.
Within a hunk, xdiff emits removals before additions for each
change, so a '-' line always arrives while lno_post is at the same
position that the following '+' or ' ' line will occupy.  Each
line can therefore be classified against the tracked ranges as it
arrives, without waiting for a non-removal line to confirm the
position.

The buffering also had a bug: flush_rhunk() unconditionally drained
the pending buffer when the range hunk was active, even if lno_post
had advanced past the tracked range.  This caused deletions
immediately after the tracked function to be incorrectly included
in patch output.

Remove the pending_rm buffer and classify '-' lines using the same
in_range check applied to '+' and ' ' lines.  This simplifies the
filter, removes three struct fields and a helper function, and
makes the flush_rhunk() bug impossible by construction.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
    diff: simplify line-range filter by classifying removals immediately
    
    The line-range filter buffered '-' (removal) lines in a
    pending_rm strbuf, deferring their classification until a '+'
    or ' ' line arrived to reveal the post-image position.
    
    This buffering is unnecessary. Removal lines are pre-image
    content that occupies no post-image space, so they do not
    advance lno_post. Within a hunk, xdiff emits removals before additions
    for each change, so a '-' line always arrives while
    lno_post is at the same position that the following '+' or ' ' line will
    occupy. Each line can therefore be classified against
    the tracked ranges as it arrives, without waiting for a
    non-removal line to confirm the position.
    
    The buffering also had a bug: flush_rhunk() unconditionally
    drained the pending buffer when the range hunk was active, even
    if lno_post had advanced past the tracked range. This caused deletions
    immediately after the tracked function to be
    incorrectly included in patch output.
    
    Remove the pending_rm buffer and classify '-' lines using the
    same in_range check applied to '+' and ' ' lines. This simplifies the
    filter, removes three struct fields and a helper function, and makes the
    flush_rhunk() bug impossible by
    construction.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2099%2Fmmontalbo%2Fmm%2Fline-log-immediate-classify-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2099/mmontalbo/mm/line-log-immediate-classify-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2099

 diff.c              | 110 ++++++++++++---------------------------
 t/t4211-line-log.sh | 124 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 77 deletions(-)

diff --git a/diff.c b/diff.c
index 397e38b41c..5662d080be 100644
--- a/diff.c
+++ b/diff.c
@@ -616,11 +616,6 @@ struct emit_callback {
  * the requested ranges.  Contiguous in-range lines are collected into
  * range hunks and flushed with a synthetic @@ header so that
  * fn_out_consume() sees well-formed unified-diff fragments.
- *
- * Removal lines ('-') cannot be classified by post-image position, so
- * they are buffered in pending_rm until the next '+' or ' ' line
- * reveals whether they precede an in-range line (flush into range hunk) or
- * an out-of-range line (discard).
  */
 struct line_range_callback {
 	xdiff_emit_line_fn orig_line_fn;
@@ -646,11 +641,6 @@ struct line_range_callback {
 	int rhunk_active;
 	int rhunk_has_changes;		/* any '+' or '-' lines? */
 
-	/* Removal lines not yet known to be in-range */
-	struct strbuf pending_rm;
-	int pending_rm_count;
-	long pending_rm_pre_begin;	/* pre-image line of first pending */
-
 	int ret;			/* latched error from orig_line_fn */
 };
 
@@ -2539,12 +2529,6 @@ static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED
 	return 1;
 }
 
-static void discard_pending_rm(struct line_range_callback *s)
-{
-	strbuf_reset(&s->pending_rm);
-	s->pending_rm_count = 0;
-}
-
 static void flush_rhunk(struct line_range_callback *s)
 {
 	struct strbuf hdr = STRBUF_INIT;
@@ -2553,14 +2537,6 @@ static void flush_rhunk(struct line_range_callback *s)
 	if (!s->rhunk_active || s->ret)
 		return;
 
-	/* Drain any pending removal lines into the range hunk */
-	if (s->pending_rm_count) {
-		strbuf_addbuf(&s->rhunk, &s->pending_rm);
-		s->rhunk_old_count += s->pending_rm_count;
-		s->rhunk_has_changes = 1;
-		discard_pending_rm(s);
-	}
-
 	/*
 	 * Suppress context-only hunks: they contain no actual changes
 	 * and would just be noise.  This can happen when the inflated
@@ -2615,11 +2591,6 @@ static void line_range_hunk_fn(void *data,
 	 * When count > 0, begin is 1-based.  When count == 0, begin is
 	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
 	 * that type will arrive, so the value is unused.
-	 *
-	 * Any pending removal lines from the previous xdiff hunk are
-	 * intentionally left in pending_rm: the line callback will
-	 * flush or discard them when the next content line reveals
-	 * whether the removals precede in-range content.
 	 */
 	s->lno_post = new_begin;
 	s->lno_pre = old_begin;
@@ -2635,88 +2606,75 @@ static void line_range_hunk_fn(void *data,
 static int line_range_line_fn(void *priv, char *line, unsigned long len)
 {
 	struct line_range_callback *s = priv;
-	const struct range *cur;
-	long lno_0, cur_pre;
+	long lno_0;
+	int in_range;
 
 	if (s->ret)
 		return s->ret;
 
-	if (line[0] == '-') {
-		if (!s->pending_rm_count)
-			s->pending_rm_pre_begin = s->lno_pre;
-		s->lno_pre++;
-		strbuf_add(&s->pending_rm, line, len);
-		s->pending_rm_count++;
-		return s->ret;
-	}
-
 	if (line[0] == '\\') {
-		if (s->pending_rm_count)
-			strbuf_add(&s->pending_rm, line, len);
-		else if (s->rhunk_active)
+		if (s->rhunk_active)
 			strbuf_add(&s->rhunk, line, len);
-		/* otherwise outside tracked range; drop silently */
 		return s->ret;
 	}
 
-	if (line[0] != '+' && line[0] != ' ')
+	if (line[0] != '+' && line[0] != ' ' && line[0] != '-')
 		BUG("unexpected diff line type '%c'", line[0]);
 
+	/*
+	 * Compute post-image position.  '+' and ' ' lines advance
+	 * lno_post; '-' lines do not (they occupy no post-image space).
+	 */
 	lno_0 = s->lno_post - 1;
-	cur_pre = s->lno_pre;	/* save before advancing for context lines */
-	s->lno_post++;
-	if (line[0] == ' ')
-		s->lno_pre++;
+	if (line[0] != '-')
+		s->lno_post++;
 
-	/* Advance past ranges we've passed */
+	/*
+	 * Advance past any ranges we've moved beyond.  Emit the
+	 * accumulated range hunk for the range we're leaving.
+	 */
 	while (s->cur_range < s->ranges->nr &&
 	       lno_0 >= s->ranges->ranges[s->cur_range].end) {
 		if (s->rhunk_active)
 			flush_rhunk(s);
-		discard_pending_rm(s);
 		s->cur_range++;
 	}
 
-	/* Past all ranges */
-	if (s->cur_range >= s->ranges->nr) {
-		discard_pending_rm(s);
-		return s->ret;
-	}
-
-	cur = &s->ranges->ranges[s->cur_range];
+	in_range = s->cur_range < s->ranges->nr &&
+		   lno_0 >= s->ranges->ranges[s->cur_range].start &&
+		   lno_0 < s->ranges->ranges[s->cur_range].end;
 
-	/* Before current range */
-	if (lno_0 < cur->start) {
-		discard_pending_rm(s);
+	if (!in_range) {
+		if (line[0] != '+')
+			s->lno_pre++;
 		return s->ret;
 	}
 
-	/* In range so start a new range hunk if needed */
+	/* Start a new range hunk if this is the first in-range line */
 	if (!s->rhunk_active) {
 		s->rhunk_active = 1;
 		s->rhunk_has_changes = 0;
 		s->rhunk_new_begin = lno_0 + 1;
-		s->rhunk_old_begin = s->pending_rm_count
-			? s->pending_rm_pre_begin : cur_pre;
+		s->rhunk_old_begin = s->lno_pre;
 		s->rhunk_old_count = 0;
 		s->rhunk_new_count = 0;
 		strbuf_reset(&s->rhunk);
 	}
 
-	/* Flush pending removals into range hunk */
-	if (s->pending_rm_count) {
-		strbuf_addbuf(&s->rhunk, &s->pending_rm);
-		s->rhunk_old_count += s->pending_rm_count;
-		s->rhunk_has_changes = 1;
-		discard_pending_rm(s);
-	}
-
+	/* Append line to the range hunk */
 	strbuf_add(&s->rhunk, line, len);
-	s->rhunk_new_count++;
-	if (line[0] == '+')
+	if (line[0] == '-') {
+		s->rhunk_old_count++;
 		s->rhunk_has_changes = 1;
-	else
+		s->lno_pre++;
+	} else if (line[0] == '+') {
+		s->rhunk_new_count++;
+		s->rhunk_has_changes = 1;
+	} else {
 		s->rhunk_old_count++;
+		s->rhunk_new_count++;
+		s->lno_pre++;
+	}
 
 	return s->ret;
 }
@@ -4072,7 +4030,6 @@ static void builtin_diff(const char *name_a,
 			lr_state.orig_cb_data = &ecbdata;
 			lr_state.ranges = line_ranges;
 			strbuf_init(&lr_state.rhunk, 0);
-			strbuf_init(&lr_state.pending_rm, 0);
 
 			/*
 			 * Inflate ctxlen so that all changes within
@@ -4107,7 +4064,6 @@ static void builtin_diff(const char *name_a,
 				die("unable to generate diff for %s",
 				    one->path);
 			strbuf_release(&lr_state.rhunk);
-			strbuf_release(&lr_state.pending_rm);
 		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
 					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index aaf197d2ed..2bff0e4c26 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -711,4 +711,128 @@ test_expect_success '-L with -G filters to diff-text matches' '
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
+	grep "return 2" actual &&
+	! grep "trailing comment" actual
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
+	# non-removal line (void tracked), which is in range.
+	# Pending removals are attributed to the range they precede.
+	grep "return 2" actual &&
+	grep "leading comment" actual
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
+	grep "change first line" actual &&
+	grep "+int tracked" actual &&
+	grep "\\-void tracked" actual
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
+	grep "change last line" actual &&
+	grep "end tracked" actual
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
+	grep "pure deletion" actual &&
+	grep "\\-.*int c" actual
+'
+
 test_done

base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
-- 
gitgitgadget
