Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCB32AADE
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581357; cv=none; b=DUhL6V9/+BJ7QVlEiffxuCt9vp/dCE5M/6dL84OWGo3tJWlMGgv8SzGBz0bzPw720nlYnX5fhbImO9gS01CH5Ki39i04h23wcJKwDVHr94jWKGuFXgRtALpmt52sGHkJGKGV/UkQDh9HImfyHK2Frlpvq9uStSfrMe5f0oxsBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581357; c=relaxed/simple;
	bh=kQxYNEVHii0nsQOWqjV1m83/GBsW+cKqhUYYUnCmgd4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=blt5Bvd3Gr8c9KdiKgLJAL1OxhqVjVkmMDML/leX3/HcnD74qlxtzK7oZDY0q8bywYyk7u1nEfJkSfHoNW+YB0jpF62jSSI/NiOxpVrbRpkxKGGVi6YsWk00SvD4avUt5CxFbtACR8l2HuVwZwiaJi0XrH8+tLrykDFfFHMDBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhyvnDxD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhyvnDxD"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8dea42b547eso27130686d6.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581355; x=1783186155; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD21cpnEFOrOmtktH06SQ2ZyC/nvtk821LFk4SjbWbk=;
        b=dhyvnDxDLebz8T+sWuvDV2Xz28xPkFTWHk8qNuDjLkKQ1Clcq2/WkzfidYL7fYoGLR
         dn6Gh3A8u7+fYon8DiQE4K6kwWgIjU4ewbyuCOy1sQcnjALwVZJoxoYM26ivtPj8TKZK
         2AWcirqWh5mICxcaqK9oLTc32qoOqaj9flA1bs42RzqgSYOalvBVLVZIQqfXElZR9OMW
         T7ON/wwdTxaJuPetP+8KjD8Z8aA7cSTa9XFUfCIw+p91mzgce3+jZa31jo4o3W7CEVKW
         2WQaTByY5oVdXtyqU1MuxifuRZWCxVvusMuz0daAYRabRTJZD9WXOVH7XT+jkj2VF/mp
         AAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581355; x=1783186155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zD21cpnEFOrOmtktH06SQ2ZyC/nvtk821LFk4SjbWbk=;
        b=NduJjXm92+yyLPRzs2aSUmkDZf37yqThNQ62b8+tT2Bd6ngMiH3qZuh9Iz8PnEqQyx
         A2vvPRTkV2YwcZrwzlDdGjrEiUkAynut1YPpB/krkxBueCFL/c4ba7HjNP8ScmwCWDBE
         lTYweadataHVr2XBUiBxO+KnXBkLYj9sMiBGRaLvgVA2KZ1fSdFNMP22gPRN2fHC1Mo/
         2ivHiw48683MyKxf9A+JRLHgVl7a1UF72zsfCYgdLfxNxarRhEztEKh88j75zAc9tqTD
         LRQ1StVBPIfHmtv2eLupa8ixzq3VJXWHCaorMOKkFqPAmKzb38pypVDqVzM4dczKgiKl
         r2Fg==
X-Gm-Message-State: AOJu0YwsHOfk+67W71G1NRw5iJhRpW8l6K4AS3OklfmCDNLD0llryTVg
	FCuiTdbaw7EzW2nxK5RJNaNkNpGmaZOCUjJhHQlWLPqQExHnfNuJYZaVaRZZ+A==
X-Gm-Gg: AfdE7clD8XLdRo+p02SdxM9gdzFAcdG+Ii+kkd2RmvmzCn1dc4vireftQC1qNeLTnXk
	NypL8duhRVGHIP+u4DBgVljA7qttXhkV83rf1syeMwPOkE/ExBktaEibwd/yazEOlWeaFc+bfGl
	7d9xmHJwskAPYEJG0CINgmO+MW1adCzmp89a5hL4hkpsa+QJVTy1xHSMoX12g2/Pl7006H6UY75
	48Mt1kTIu7HtZz+pQ7nhCkp7aJGhvpEUZ4ySKNNuVJa8YiK4qRqBZ4tLI6wUdYEatWsr2rXkqeJ
	Xin4/r5Xx3OEwb5NvxF1VmpwCKJVmPW0PSCMPGr+fWfGvA4g7VxONwyKZdjV190yfzoxpPc/qNt
	fL/+hegPReB8yRzPM5rJpa+xaaIrlfHXM2BenL5RrBe+BXMqYHG5UWtjwUe505NjMKXDyBH9gWk
	43TPBArvndiuaTmpA=
X-Received: by 2002:a05:6214:5f81:b0:8e8:ca22:5c34 with SMTP id 6a1803df08f44-8e8ca227cc6mr84922246d6.40.1782581354477;
        Sat, 27 Jun 2026 10:29:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm253543626d6.8.2026.06.27.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:29:13 -0700 (PDT)
Message-Id: <df83e6275b93f2e22c8f7ab17b542343332c58d2.1782581342.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:29:01 +0000
Subject: [PATCH v2 7/7] diffcore-pickaxe: scope -G to the -L tracked range
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

git log -L scopes its diff output to the tracked range, but pickaxe
(-S, -G) still runs in diffcore over the whole-file change, so -L -G
selects a commit whenever the pattern appears in any added or removed
line of the file, even outside the tracked range.

Teach -G to honor the range.  diff_grep() already runs an xdiff pass
and greps the +/- lines; route that pass through the line-range filter
so only the tracked range's lines are grepped.  Expose the filter as
diff_emit_line_ranges(), an xdi_diff_outf() that emits only the tracked
range's lines, thread the filepair's line_ranges through the pickaxe
callback, and pass it from pickaxe_match().  Skip scoping under
textconv, whose output is not in the original file's line coordinates.

-G needs only a hit/no-hit answer, so the line-number concerns the
filter handles for patch and check output do not apply here.

-S is left matching the whole file: it counts needle occurrences per
blob rather than grepping the diff, so scoping it needs a different
approach, left to a follow-up.  has_changes() takes the range parameter
but ignores it for now.

Document the resulting -L pickaxe scoping: -G is scoped to the tracked
range, while -S still matches the whole file.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc |  5 +-
 diff.c                                | 15 ++++++
 diffcore-pickaxe.c                    | 37 +++++++++++---
 t/t4211-line-log.sh                   | 72 +++++++++++++++++++++++++--
 xdiff-interface.h                     | 13 +++++
 5 files changed, 130 insertions(+), 12 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index 33b4e94881..d619ffa633 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -20,6 +20,9 @@
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
-as are pickaxe options (`-S`, `-G`) and `--diff-filter`.
+as are pickaxe options (`-S`, `-G`) and `--diff-filter`.  `-G` is
+scoped to the tracked range; `-S` is still evaluated over the whole
+file, so an `-S` query may select a commit for a change outside the
+range.
 +
 include::line-range-format.adoc[]
diff --git a/diff.c b/diff.c
index 519c513356..a8f346621b 100644
--- a/diff.c
+++ b/diff.c
@@ -2817,6 +2817,21 @@ static int line_range_filter_diff(struct line_range_filter *filter,
 	return ret;
 }
 
+/*
+ * Expose the in-file line-range filter to callers outside diff.c (e.g.
+ * pickaxe -G); see xdiff-interface.h for the contract.
+ */
+int diff_emit_line_ranges(mmfile_t *one, mmfile_t *two,
+			  const struct range_set *ranges,
+			  xdiff_emit_line_fn line_fn, void *cb_data,
+			  xpparam_t *xpp, xdemitconf_t *xecfg)
+{
+	struct line_range_filter filter;
+
+	line_range_filter_init(&filter, ranges, line_fn, cb_data);
+	return line_range_filter_diff(&filter, one, two, xpp, xecfg);
+}
+
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old_name = a;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a52d569911..047b2bf7ac 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -16,7 +16,8 @@
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
-			  regex_t *regexp, kwset_t kws);
+			  regex_t *regexp, kwset_t kws,
+			  const struct range_set *ranges);
 
 struct diffgrep_cb {
 	regex_t *regexp;
@@ -42,7 +43,8 @@ static int diffgrep_consume(void *priv, char *line, unsigned long len)
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
 		     struct diff_options *o,
-		     regex_t *regexp, kwset_t kws UNUSED)
+		     regex_t *regexp, kwset_t kws UNUSED,
+		     const struct range_set *ranges)
 {
 	struct diffgrep_cb ecbdata;
 	xpparam_t xpp;
@@ -50,8 +52,11 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	int ret;
 
 	/*
-	 * We have both sides; need to run textual diff and see if
-	 * the pattern appears on added/deleted lines.
+	 * We have both sides; need to run textual diff and see if the
+	 * pattern appears on added/deleted lines.  Under -L (ranges set),
+	 * forward only the tracked range's lines so the match is scoped.
+	 * -G needs only a hit/no-hit answer, so the line-number bookkeeping
+	 * the filter does for -L patch and check output is irrelevant here.
 	 */
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -65,8 +70,12 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	 * An xdiff error might be our "data->hit" from above. See the
 	 * comment for xdiff_emit_line_fn in xdiff-interface.h
 	 */
-	ret = xdi_diff_outf(one, two, NULL, diffgrep_consume,
-			    &ecbdata, &xpp, &xecfg);
+	if (ranges)
+		ret = diff_emit_line_ranges(one, two, ranges, diffgrep_consume,
+					    &ecbdata, &xpp, &xecfg);
+	else
+		ret = xdi_diff_outf(one, two, NULL, diffgrep_consume,
+				    &ecbdata, &xpp, &xecfg);
 	if (ecbdata.hit)
 		return 1;
 	if (ret)
@@ -119,8 +128,13 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws,
 
 static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o UNUSED,
-		       regex_t *regexp, kwset_t kws)
+		       regex_t *regexp, kwset_t kws,
+		       const struct range_set *ranges UNUSED)
 {
+	/*
+	 * -S counts needle occurrences in each whole blob.  Scoping this to
+	 * a -L range is left to a follow-up; for now -S ignores the range.
+	 */
 	unsigned int c1 = one ? contains(one, regexp, kws, 0) : 0;
 	unsigned int c2 = two ? contains(two, regexp, kws, c1 + 1) : 0;
 	return c1 != c2;
@@ -132,6 +146,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
+	const struct range_set *ranges;
 	int ret;
 
 	/* ignore unmerged */
@@ -169,7 +184,13 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
-	ret = fn(&mf1, &mf2, o, regexp, kws);
+	/*
+	 * -L scopes the search to the tracked range, but the range is in
+	 * original-file line coordinates that do not map onto textconv
+	 * output, so search the whole file when textconv is in play.
+	 */
+	ranges = (textconv_one || textconv_two) ? NULL : p->line_ranges;
+	ret = fn(&mf1, &mf2, o, regexp, kws, ranges);
 
 	if (textconv_one)
 		free(mf1.ptr);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 68576418f4..bac74d4479 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -722,9 +722,9 @@ test_expect_success '-L with -S filters to string-count changes' '
 test_expect_success '-L with -G filters to diff-text matches' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c -G "F2 [+] 2" --format= >actual &&
-	# -G greps the whole-file diff text, not just the tracked range;
-	# combined with -L, this selects commits that both touch func2
-	# and have "F2 + 2" in their diff.
+	# -G greps the diff text, and under -L only the lines in the
+	# tracked range (unlike -S above, which searches the whole file);
+	# this selects commits whose change to func2 contains "F2 + 2".
 	test $(grep -c "^diff --git" actual) = 1 &&
 	grep "F2 + 2" actual
 '
@@ -1110,4 +1110,70 @@ test_expect_success '--check does not report blank-at-eof outside the range' '
 	test_grep ! "blank line at EOF" actual
 '
 
+test_expect_success '-L -G is scoped to the tracked range' '
+	git checkout --orphan grep-scope &&
+	git reset --hard &&
+	cat >gp.c <<-\EOF &&
+	int func1()
+	{
+	    return ALPHA;
+	}
+
+	int func2()
+	{
+	    return BETA;
+	}
+	EOF
+	git add gp.c &&
+	test_tick &&
+	git commit -m "add gp.c" &&
+	sed -e "s/ALPHA/ALPHA2/" -e "s/BETA/BETA2/" gp.c >tmp &&
+	mv tmp gp.c &&
+	git commit -a -m "touch both functions" &&
+	# The commit changes ALPHA (func1) and BETA (func2).  Tracking func2,
+	# -G BETA matches its in-range change; -G ALPHA must not, since ALPHA
+	# changes only outside the tracked range.
+	git log -L:func2:gp.c -G BETA --format=%s >actual &&
+	test_grep "touch both functions" actual &&
+	git log -L:func2:gp.c -G ALPHA --format=%s >actual &&
+	test_grep ! "touch both functions" actual
+'
+
+test_expect_success '-L -G searches the whole file under textconv' '
+	git checkout --orphan grep-textconv &&
+	git reset --hard &&
+	cat >tc.c <<-\EOF &&
+	int func1()
+	{
+	    return F1;
+	}
+
+	int func2()
+	{
+	    return F2;
+	}
+	EOF
+	git add tc.c &&
+	test_tick &&
+	git commit -m "add tc.c" &&
+	# One commit changes func1 and func2; MAGIC lands only in the
+	# func2 change, outside func1.
+	sed -e "s/F1/F1 + 1/" -e "s/return F2/return MAGIC/" tc.c >tmp &&
+	mv tmp tc.c &&
+	git commit -a -m "change both funcs" &&
+	echo "tc.c diff=tc" >.gitattributes &&
+
+	# Without a textconv driver, -G is scoped to func1, so MAGIC (only
+	# in the func2 change) does not select the commit.
+	git log -L:func1:tc.c -G MAGIC --format=%s --no-patch >actual &&
+	test_must_be_empty actual &&
+
+	# A textconv driver makes the range (original-file line numbers)
+	# meaningless against the driver output, so -G falls back to the
+	# whole file and MAGIC now selects the commit.
+	git config diff.tc.textconv cat &&
+	git log -L:func1:tc.c -G MAGIC --format=%s --no-patch >actual &&
+	test_grep "change both funcs" actual
+'
+
 test_done
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 51c88296ed..71e5dffefb 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -46,6 +46,19 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_line_fn line_fn,
 		  void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
+
+struct range_set;
+/*
+ * Like xdi_diff_outf(), but forwards only the lines within the given
+ * (post-image) line ranges to line_fn, as "git log -L" scopes its output.
+ * Returns line_fn's latched return value (so a consumer can signal a hit
+ * with a non-zero return), or non-zero on xdiff failure.  Defined in
+ * diff.c (it reuses the line-range filter there).
+ */
+int diff_emit_line_ranges(mmfile_t *mf1, mmfile_t *mf2,
+			  const struct range_set *ranges,
+			  xdiff_emit_line_fn line_fn, void *cb_data,
+			  xpparam_t *xpp, xdemitconf_t *xecfg);
 int read_mmfile(mmfile_t *ptr, const char *filename);
 void read_mmblob(mmfile_t *ptr, struct object_database *odb,
 		 const struct object_id *oid);
-- 
gitgitgadget
