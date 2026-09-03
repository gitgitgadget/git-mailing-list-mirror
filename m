Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC4386441
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411933; cv=none; b=GiyM6mHOziqMWq+JVBsieJL4HSYyKeXvYKMUEhTeTtWkh+OX5keAoOBVOrpoGH3x05PAu/f7Xje1eYJTeHAmjE7I678brpWE5nY6zZTGQnGuFRvCzf3lXD10OFy36iQWkdsNEfFzavsuvFNm/aKk4FCW/Qnwxngefgur4GFT2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411933; c=relaxed/simple;
	bh=di22ndcDp0p8dGlBH6kqqSX+SU5eJeV6xcYFRKQ35cw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Dt9u+Q+GkSmcd5rPL720AP0cVBFJ1b7Tl1z6jhdvFLvfJjDa944/CrQMyn7IltjTPFiWBqnYxq289KZTr3FEPgILVwdMhonAtUgfcDm+sfXFnYckaosyHcLcmd0L4Q0TFQtU/qdNkqrFKGSrtKyjA5m2kwTby+qo2cJRUj1wQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/zEMfyv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/zEMfyv"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-936623c6dd3so72912285a.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411930; x=1789016730; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3tYSVpdTdWMFEDtEghhfCBGVeXtKXJkCdx6FeFvMw0=;
        b=A/zEMfyvTOct2N2Pj+G3yIqdxgrE5nsWa4MaCEHFqGVjC3dDppEYPvuw5a2XWF90NX
         hxFOGMLlQS7oNdLzbDIwibe9JfZGj5VFqtK4wkXcW7+6qezT0YVSlLSKjKsLgmZswGp/
         lFrWwNCDkRsQ4mwpFJbhf7kApKFzTL1XpHkGTincySdeO8RaVuuDeDR7dDBcHPxXyQ14
         ZzB1fv9JMxVNHtwWjdbhxT7P3Op60c/Q1PPy/7Nco5VaV01mus7kyT2dCAsdWW48t5bH
         Hg5Tp45zGMq0x8RW6Obzhg8Hl4GLcK/xFf48cINWgif73Z2ATMU5b8CPzgLJQIxjLDBd
         8FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411930; x=1789016730;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3tYSVpdTdWMFEDtEghhfCBGVeXtKXJkCdx6FeFvMw0=;
        b=CX2noflVEQy3ky+Oyf13zij+0abG2V3a552z2ysPokZaI+vQcbn9W+2zOizpy6KaiJ
         6P9pBVE3Kfghzr7eWhqiHRCG+WeODmWy3tivNO4g+/s8Xhn4ZSJ4T4nMK7OrwOz4zZHl
         B1AlyWx4IqZB0P8WGWFCcEHvPJsH5sT2xBtVuK32MTFYsqCMxW869JKMDEK4GljNz2/c
         lXM2/8xCglr9OMqp4saYaNZCIgXxF1A2NpDrW+dJM3k3+rV8Ljz5kqOrVyksBnnrFWR9
         la8S4Dd9moIKlMg4Em6/RKZkWorsPMpb64HWJVj4x8/BNe5cxetAXfRCCK2ZZFAvY3gH
         up7A==
X-Gm-Message-State: AFuF++kYxQDt8K3mg2P60spdSQ7/I3GXs06R9q0uJvsc1JYxJU10F+mL
	r6IwVU6cIpuSAVKIXvD1gsvfhyWDdGXVjQn9euyEkJ5wVMHkH1vHr79srqAILQER
X-Gm-Gg: AYBFou2vQZTXk7FWRJrDdpZNufcEirbXPLBN0NzFnQwOEG7tcHChUU5jfbLBUHyjlYO
	fOmMeMEebDkToIboZAy7UzpYvMzgyIELd9P1PkWXEniix+UubOC3zCLU6XkP85LpTWNa5Kyek74
	R/eTvl97oo/pJGAB4oIlixxywAD4UJ2xHXjj+xLo/bOH5PtT9Bk/6wCORyF6j9mCh8lQjb+fhVd
	Onwlf6pyplJhC15DxvWWhYlOeDCRRlq41gSn9fxpYuuPqwQ5a5Mbr9ZZQmjvK+N/3xp6A/GR/4C
	3JVUHT6xCXFgcyHp7oYlrYKzxwjEtIYrAvKRnusxXgeVAc/7O2PPyqE0SgXjhrwoVWTk16YN4Sd
	brDjaPQFrgLm1z25/vvj4sF2Kgn3crmHuR9E8jgs8vmozUvuWw6ZucAiU5oOFuZgzUSdPbyMU2h
	h0gX+3Uvyi6+nAW09MSwHVo7Hey0L93ZGte9GjBgdNHQo1209Sqhd5j2iWjE0mbFRX
X-Received: by 2002:a05:620a:400a:b0:939:4a3d:2a06 with SMTP id af79cd13be357-93972f0379emr94283585a.10.1788411929847;
        Wed, 02 Sep 2026 22:05:29 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f3fb661sm396382785a.47.2026.09.02.22.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:29 -0700 (PDT)
Message-Id: <cff5c124ecd9e28ea66921cebfa356ca38aa7c1e.1788411919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:19 +0000
Subject: [PATCH v3 7/7] diffcore-pickaxe: limit -G to the -L tracked range
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

Teach -G to only search the line ranges specified by -L.
Teaching -S is left as future work, so it still matches the entire
file even if -L is specified.

Rather than being part of diff.c's builtin implementations, the
diffcore-pickaxe functionality interacts with xdiff-interface as a
separate component. Add a sibling to xdi_diff_outf(), called
diff_emit_line_ranges(), that limits emitted lines to the given line
ranges.

Use diff_emit_line_ranges() when searching text if line ranges have
been specified. If textconv is enabled, use normal diffing instead of
diff_emit_line_ranges() since line range tracking relies on the line
coordinates of the original, pre-textconv file.

Update documentation and add tests accordingly.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc |  4 +-
 diff.c                                | 11 ++++
 diffcore-pickaxe.c                    | 30 ++++++++--
 t/t4211-line-log.sh                   | 81 ++++++++++++++++++++++-----
 xdiff-interface.h                     | 10 ++++
 5 files changed, 115 insertions(+), 21 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index 4a7ab97d75..52e1262fd7 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -19,6 +19,8 @@
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
-as are pickaxe options (`-S`, `-G`) and `--diff-filter`.
+as are pickaxe options (`-S`, `-G`) and `--diff-filter`. `-G` is
+limited to the tracked range. In contrast, `-S` is evaluated over the whole
+file and may select a commit with a change outside the tracked range.
 +
 include::line-range-format.adoc[]
diff --git a/diff.c b/diff.c
index 49b6732c81..1a3571d229 100644
--- a/diff.c
+++ b/diff.c
@@ -2701,6 +2701,17 @@ static int line_range_filter_diff(struct line_range_filter *filter,
 	return ret;
 }
 
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
index b0915be86f..2425fe8101 100644
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
@@ -65,8 +67,12 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
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
@@ -119,8 +125,13 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws,
 
 static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o UNUSED,
-		       regex_t *regexp, kwset_t kws)
+		       regex_t *regexp, kwset_t kws,
+		       const struct range_set *ranges UNUSED)
 {
+	/*
+	 * -S counts needle occurrences in each whole blob. Limiting this to
+	 * an -L range is left as a follow-up; for now -S ignores the range.
+	 */
 	unsigned int c1 = one ? contains(one, regexp, kws, 0) : 0;
 	unsigned int c2 = two ? contains(two, regexp, kws, c1 + 1) : 0;
 	return c1 != c2;
@@ -132,6 +143,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
+	const struct range_set *ranges;
 	int ret;
 
 	/* ignore unmerged */
@@ -169,7 +181,13 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
-	ret = fn(&mf1, &mf2, o, regexp, kws);
+	/*
+	 * -L limits the search to the tracked range, but the range is in
+	 * pre-textconv line coordinates that do not map onto textconv
+	 * output, so search the whole file when textconv is enabled.
+	 */
+	ranges = (textconv_one || textconv_two) ? NULL : p->line_ranges;
+	ret = fn(&mf1, &mf2, o, regexp, kws, ranges);
 
 	if (textconv_one)
 		free(mf1.ptr);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 2a542aa643..2354400d1c 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -703,24 +703,18 @@ test_expect_success '-L suppresses deletions outside tracked range' '
 	test $(grep -c "^diff --git" actual) = 1
 '
 
-test_expect_success '-L with -S filters to string-count changes' '
+test_expect_success '-L with -S selects only the matching commit' '
 	git checkout parent-oids &&
-	git log -L:func2:file.c -S "F2 + 2" --format= >actual &&
-	# -S searches the whole file, not just the tracked range;
-	# combined with the -L range walk, this selects commits that
-	# both touch func2 and change the count of "F2 + 2" in the file.
-	test $(grep -c "^diff --git" actual) = 1 &&
-	test_grep "F2 + 2" actual
+	git log -L:func2:file.c -S "F2 + 2" --format=%s --no-patch >actual &&
+	echo "Modify func2() in file.c" >expect &&
+	test_cmp expect actual
 '
 
-test_expect_success '-L with -G filters to diff-text matches' '
+test_expect_success '-L with -G selects only the matching commit' '
 	git checkout parent-oids &&
-	git log -L:func2:file.c -G "F2 [+] 2" --format= >actual &&
-	# -G greps the whole-file diff text, not just the tracked range;
-	# combined with -L, this selects commits that both touch func2
-	# and have "F2 + 2" in their diff.
-	test $(grep -c "^diff --git" actual) = 1 &&
-	test_grep "F2 + 2" actual
+	git log -L:func2:file.c -G "F2 [+] 2" --format=%s --no-patch >actual &&
+	echo "Modify func2() in file.c" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'setup for trailing deletion test' '
@@ -1007,4 +1001,63 @@ test_expect_success '--check does not report blank-at-eof outside the range' '
 	test_cmp expect actual
 '
 
+test_expect_success '-L -G is limited to the tracked range' '
+	git checkout --orphan grep-range &&
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
+	git log -L:func2:gp.c -G BETA --format=%s --no-patch >actual &&
+	cat >expect <<-\EOF &&
+	touch both functions
+	add gp.c
+	EOF
+	test_cmp expect actual &&
+	git log -L:func2:gp.c -G ALPHA --format=%s --no-patch >actual &&
+	test_must_be_empty actual
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
+	sed -e "s/F1/F1 + 1/" -e "s/return F2/return FINDME/" tc.c >tmp &&
+	mv tmp tc.c &&
+	git commit -a -m "change both funcs" &&
+	echo "tc.c diff=tc" >.gitattributes &&
+	git log -L:func1:tc.c -G FINDME --format=%s --no-patch >actual &&
+	test_must_be_empty actual &&
+	git config diff.tc.textconv cat &&
+	git log -L:func1:tc.c -G FINDME --format=%s --no-patch >actual &&
+	echo "change both funcs" >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 2428456629..4151bc2097 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -46,6 +46,16 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_line_fn line_fn,
 		  void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
+
+struct range_set;
+/*
+ * Like xdi_diff_outf(), but forwards only the lines within the given
+ * postimage line ranges to line_fn.
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
