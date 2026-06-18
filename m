Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0335DA63
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806608; cv=none; b=mLAdlRK/th7aN6sV5v7YpUPp9IQq/yXqWRVslviybYJDcBKnlMK2WRFuKK+Omrz7X4BvboyFY1sNHjtsSN6USNOfQV26CfEoqTVY5dbRtzeblvpmNywe8gJ2FoWQzrOnn8IP8l6QbmtQjD9DOn0QwGEECMP79okRk4ALhm0X+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806608; c=relaxed/simple;
	bh=LbyK/eOe+VtpRTkpmG3qCT8ukqqFIb6+bCDVLHcuhe8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Zl7HErvVYDPQ3XW4bk7xtZde4OWdT+Quag18tPCn0UUCrLYCVp96AUDyhcapH7unbJXF/dPrp+BOPeaW3yWPxDKFLnc6UXG3kOVtTr/daPrUJ/+x2QUPd2fgKrQlOlvf15e11JD1caoyHZxs6+rhU6lg8nPiEyjI6o9HoJrYBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYl8F4+P; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYl8F4+P"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5176465a4a4so13996221cf.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806604; x=1782411404; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt+Wnr+d3V7Bg9YyyyCCClxCOA5ayMAxQHnC6qb+f90=;
        b=iYl8F4+PC3Tb1yVyDWx1enf79FYW9dm5b0ZCk06tUT+hyMpl2ujA8QCtnufCFkt/B8
         MZ86lpPhcqzDR9iLlgAi3jkKOKofcV3kgcQPl4sR45r0Az36agXeCooOseUofIERRbb5
         FLEk+HSywKVqqmIxwgJojyuNLnK3XcIZyDIXVTddn8NASk6ZVVIhf540GG50Xupo2xHy
         E+Uku44GtM/e5/aokIAeSP/EeJQiOvb9Vv7GPIjWhviQ5XY0awxxxiRO+RlgHUZCVTI0
         rqaY0d2WuMGrCYhiu96QdfYW/uiU1WWBI9uQdSvfuGxViQ2vNfTyEJVjBCo932yCAT1e
         uCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806604; x=1782411404;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yt+Wnr+d3V7Bg9YyyyCCClxCOA5ayMAxQHnC6qb+f90=;
        b=dXy7ra2vWSezZBYpzVaS9RmMeFu9DW4omL+Ing3NWPwooGMLnDSzWn7pIamKP5XO5Z
         2ps4l2lERIapPVRvLT3KeJ9OyP7accRjZVXKkHV6j6FlezedWah2ZJKF7WjkF/voGS9m
         wvEsnPhm9lckEm/zXBWzt63KgLGGeMBZdhRP/OtQTGvWaAG4riaGxECfnVJolGLJfXAR
         33MedYqYqoPBqoJkENFwkD6+I2yzdxomGJ78oaARJaWg8QxqMEIxUUAM+TLeCStiS0p6
         /I0A0repgXNusNViebB21z1a8rvwGA0Z70jr5j5ih0cwHbpG4qnHlClRj9Lzj+nyM2FJ
         ZIyA==
X-Gm-Message-State: AOJu0YxMLgf2hkSNiW2LwTq4Cber3VVhkKpg9N9wfyAuYMSIvx/c9ej+
	J/IumghG6NwA//2b37Zde+qDxD08SJ7jzzh3qHAJDalJxHnyJnHmgAGiBeNU6w==
X-Gm-Gg: AfdE7ck8jlm5bWu8EvJ4ONmPtvyeXfkWRUdXy/n7SPnfyyXzrm6ZrnnsGGo+IhL2riw
	klxUlVKDvbM9sFXXj8Ab/4Vt3sDDYzUOOmvOzH+QiVlPGV9YFya72jxbxvZQSXjioPQ/58TYaoH
	+0LVZ7QuNTQ176C5AZ2RH/KNNtjp8r8bHS1lnvDyqDuDwzI60SV9g4Q7snmjW/F74yOUe0PVMqP
	FIdO7zMNuA7MjFxm8q2W4k3QZogz+8lZy++2ROmfBUR1UUlysLOuS6ZtT8rlxAxhTD3Juk/kGtn
	OmNJu8ExSnPBE2NjAN9Ixcgy0px14e+MhFgEVLEtBHezeVWyuFE0LNs4zhGwaDw1ZoAeXobJ9ww
	3zrMgXHDIKmwLkXy8NdEXmo4OzxyUt6UnJqrfkwBNU7qbZVzWFfcB8PbpaRRMN7n6ANDl4qAr7K
	Im8UYfyy9igtTB0A==
X-Received: by 2002:a05:622a:5906:b0:517:5f04:f24c with SMTP id d75a77b69052e-519e4c6939bmr4241591cf.39.1781806603394;
        Thu, 18 Jun 2026 11:16:43 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e4e10891sm1277621cf.2.2026.06.18.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:16:42 -0700 (PDT)
Message-Id: <be0679a5a73337bad94e997687d0e889907c25b6.1781806593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 18:16:31 +0000
Subject: [PATCH 6/7] diff: support --check with -L line ranges
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

builtin_checkdiff() runs its own xdiff pass to detect whitespace
errors in newly added lines.  When -L is active, the check should
be scoped to the tracked line ranges rather than the whole file.

Reuse the line_range_filter to wrap checkdiff_consume(), the same
pattern already used for patch output and diffstat.  The filter
forwards only in-range lines for whitespace checking.

checkdiff reports the file line number of each error, which it
normally learns from the hunk header via checkdiff_consume_hunk().
The filter synthesizes its own hunk headers, so give it an optional
hunk callback and route checkdiff_consume_hunk() through it; this
sets the post-image position before the in-range lines are replayed.
Without it the reported line numbers would count from the start of
the range hunk rather than the start of the file.

The trailing blank-at-eof check is a second pass that scans the whole
file via check_blank_at_eof(), so gate its report on the tracked
ranges as well; otherwise a blank line added at end of file is
reported even when it lies outside the range.

Add DIFF_FORMAT_CHECKDIFF to the -L output format allowlist in
setup_revisions() so that -L --check is accepted, and list --check
among the supported formats in the documentation.  Add tests covering
that whitespace errors are reported, scoped to the tracked range, and
labeled with the correct file line number, including when two errors
in one range are separated by a gap that would otherwise split into
multiple xdiff hunks.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc |  2 +-
 diff.c                                | 65 ++++++++++++++++++-
 revision.c                            |  2 +-
 t/t4211-line-log.sh                   | 92 +++++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 5 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index 1a25f55bb1..ec92f43ae4 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -10,7 +10,7 @@
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`.
 	The following non-patch diff formats are supported: `--raw`,
-	`--name-only`, `--name-status`, `--summary`,
+	`--name-only`, `--name-status`, `--summary`, `--check`,
 	`--stat`, `--numstat`, and `--shortstat`.
 	The stat formats show range-scoped counts: only lines within
 	the tracked range are counted.  `--dirstat` is not supported
diff --git a/diff.c b/diff.c
index 026fafeb90..519c513356 100644
--- a/diff.c
+++ b/diff.c
@@ -665,6 +665,12 @@ struct emit_callback {
  */
 struct line_range_filter {
 	xdiff_emit_line_fn orig_line_fn;
+	/*
+	 * Optional; consumers that report file line numbers (e.g.
+	 * checkdiff) need the synthetic hunk header to set their
+	 * post-image position before in-range lines are replayed.
+	 */
+	xdiff_emit_hunk_fn orig_hunk_fn;
 	void *orig_cb_data;
 	const struct range_set *ranges;	/* 0-based [start, end) */
 	unsigned int cur_range;		/* index into the range_set */
@@ -2652,6 +2658,17 @@ static void flush_range_hunk(struct line_range_filter *filter)
 			       filter->hunk.new_begin, new_count,
 			       filter->func, filter->funclen);
 
+	/*
+	 * Inform a line-numbering consumer of the post-image position
+	 * before replaying lines, mirroring the hunk callback xdiff
+	 * would have issued for a non-scoped diff.
+	 */
+	if (filter->orig_hunk_fn)
+		filter->orig_hunk_fn(filter->orig_cb_data,
+				filter->hunk.old_begin, old_count,
+				filter->hunk.new_begin, new_count,
+				filter->func, filter->funclen);
+
 	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
 	strbuf_release(&hdr);
 
@@ -4330,11 +4347,29 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	diff_free_filespec_data(two);
 }
 
+/*
+ * Is the 0-based line index within any of the tracked ranges?
+ * (range_set ranges are 0-based, half-open [start, end).)  This is a
+ * one-shot query for a single line and scans; the streaming filter
+ * (line_range_line_fn) uses a forward cursor instead.
+ */
+static int idx_in_ranges(const struct range_set *ranges, long idx)
+{
+	unsigned int i;
+
+	for (i = 0; i < ranges->nr; i++)
+		if (idx >= ranges->ranges[i].start &&
+		    idx < ranges->ranges[i].end)
+			return 1;
+	return 0;
+}
+
 static void builtin_checkdiff(const char *name_a, const char *name_b,
 			      const char *attr_path,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
-			      struct diff_options *o)
+			      struct diff_options *o,
+			      const struct range_set *line_ranges)
 {
 	mmfile_t mf1, mf2;
 	struct checkdiff_t data;
@@ -4374,7 +4409,19 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = 0;
-		if (xdi_diff_outf(&mf1, &mf2, checkdiff_consume_hunk,
+
+		if (line_ranges) {
+			struct line_range_filter lr_filter;
+
+			line_range_filter_init(&lr_filter, line_ranges,
+					       checkdiff_consume, &data);
+			lr_filter.orig_hunk_fn = checkdiff_consume_hunk;
+
+			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
+						   &xpp, &xecfg))
+				die("unable to generate checkdiff for %s",
+				    one->path);
+		} else if (xdi_diff_outf(&mf1, &mf2, checkdiff_consume_hunk,
 				  checkdiff_consume, &data,
 				  &xpp, &xecfg))
 			die("unable to generate checkdiff for %s", one->path);
@@ -4387,6 +4434,17 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 			blank_at_eof = ecbdata.blank_at_eof_in_postimage;
 
+			/*
+			 * check_blank_at_eof() scans the whole file; with -L,
+			 * keep the report only when its line is in a tracked
+			 * range.  The error's location is the first trailing
+			 * blank line (blank_at_eof, 1-based; ranges 0-based), so
+			 * we scope by that line.
+			 */
+			if (blank_at_eof && line_ranges &&
+			    !idx_in_ranges(line_ranges, blank_at_eof - 1))
+				blank_at_eof = 0;
+
 			if (blank_at_eof) {
 				static char *err;
 				if (!err)
@@ -5179,7 +5237,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	diff_fill_oid_info(p->one, o->repo->index);
 	diff_fill_oid_info(p->two, o->repo->index);
 
-	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
+	builtin_checkdiff(name, other, attr_path, p->one, p->two, o,
+			  p->line_ranges);
 }
 
 void repo_diff_setup(struct repository *r, struct diff_options *options)
diff --git a/revision.c b/revision.c
index 2c76e15778..7abb287451 100644
--- a/revision.c
+++ b/revision.c
@@ -3195,7 +3195,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
 		DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY |
 		DIFF_FORMAT_NUMSTAT | DIFF_FORMAT_DIFFSTAT |
-		DIFF_FORMAT_SHORTSTAT))))
+		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_CHECKDIFF))))
 		die(_("-L does not support the requested diff format"));
 
 	if (revs->expand_tabs_in_log < 0)
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index af37bd532f..9d351aa05f 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -1018,4 +1018,96 @@ test_expect_success '--summary shows new file on root commit' '
 	test_grep "create mode 100644 file.c" actual
 '
 
+test_expect_success 'setup for --check test' '
+	git checkout --orphan check-test &&
+	git reset --hard &&
+	cat >check.c <<-\EOF &&
+	void tracked()
+	{
+	    return;
+	}
+
+	void other()
+	{
+	    return;
+	}
+	EOF
+	git add check.c &&
+	test_tick &&
+	git commit -m "add check.c" &&
+	# Introduce trailing whitespace errors in both functions
+	sed "s/return;/return; /" check.c >check.c.tmp &&
+	mv check.c.tmp check.c &&
+	git commit -a -m "introduce trailing whitespace"
+'
+
+test_expect_success '--check scoped to tracked range with correct file line' '
+	# tracked() trailing whitespace is at check.c:3; report it with the
+	# real file line number, not a count from the start of the range
+	# hunk.  other() at check.c:8 is outside the range and is excluded.
+	test_must_fail git log -L:tracked:check.c --check --format= >actual &&
+	test_grep "check.c:3: trailing whitespace" actual &&
+	test_grep ! "check.c:8:" actual
+'
+
+test_expect_success '--check reports each of several tracked ranges' '
+	# Track both functions as separate ranges.  Each range is flushed
+	# as its own hunk, so the second error must report its real file
+	# line (check.c:8), not continue the numbering from the first
+	# range (check.c:3).
+	test_must_fail git log -L:tracked:check.c -L:other:check.c \
+		--check --format= >actual &&
+	test_grep "check.c:3: trailing whitespace" actual &&
+	test_grep "check.c:8: trailing whitespace" actual
+'
+
+test_expect_success '--check line numbers stay correct across a gap in one range' '
+	git checkout --orphan check-gap &&
+	git reset --hard &&
+	cat >gap.c <<-\EOF &&
+	void tracked()
+	{
+	    int a = 1;
+	    int b = 2;
+	    int c = 3;
+	    int d = 4;
+	    int e = 5;
+	    int g = 7;
+	    return;
+	}
+	EOF
+	git add gap.c &&
+	test_tick &&
+	git commit -m "add gap.c" &&
+	# Two trailing-whitespace errors within one tracked range,
+	# separated by clean lines.  ctxlen is inflated to the range span,
+	# so they land in a single xdiff hunk with the gap as context;
+	# both must report their real file line number, with the context
+	# lines between them counted.
+	sed -e "s/int a = 1;/int a = 1; /" -e "s/int g = 7;/int g = 7; /" gap.c >tmp &&
+	mv tmp gap.c &&
+	git commit -a -m "ws errors with a gap" &&
+	test_must_fail git log -L:tracked:gap.c --check --format= >actual &&
+	test_grep "gap.c:3: trailing whitespace" actual &&
+	test_grep "gap.c:8: trailing whitespace" actual
+'
+
+test_expect_success '--check does not report blank-at-eof outside the range' '
+	git checkout --orphan check-eof &&
+	git reset --hard &&
+	printf "void tracked()\n{\n    return;\n}\n\nint tail = 1;\n" >eof.c &&
+	git add eof.c &&
+	test_tick &&
+	git commit -m "add eof.c" &&
+	# One commit introduces a trailing-whitespace error inside tracked()
+	# (line 3) and a blank line at end of file (line 7, outside the
+	# range).  The blank-at-eof check scans the whole file, so it must be
+	# scoped: report the in-range error, not the out-of-range EOF blank.
+	printf "void tracked()\n{\n    return; \n}\n\nint tail = 1;\n\n" >eof.c &&
+	git commit -a -m "ws in range, blank at eof out of range" &&
+	test_must_fail git log -L:tracked:eof.c --check --format= >actual &&
+	test_grep "eof.c:3: trailing whitespace" actual &&
+	test_grep ! "blank line at EOF" actual
+'
+
 test_done
-- 
gitgitgadget

