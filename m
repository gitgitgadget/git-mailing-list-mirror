Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3973CD8CA
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149341; cv=none; b=QJUEwkWDR5HJhvYDt67P4JItoGkxZ86kYlOpo9tEujWvMXbzLT6oYDSuA6WF4xidD/ex1cIg+N/kV7BIdtUWy4k37gt/pyoeHYkwtJdBVlDlCntxeBMPMAo/t3Z1o3O1NTw4ZypsRXDJSVM70vjwR3lzh9RScDfKMrAXL1tmBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149341; c=relaxed/simple;
	bh=k7VRwVaGxwg21zXTrGBtBWr52s5sH1J/c/q2BIK6Pdo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dAdpT+n54RXJEjjsiHGzpTvo2q8WQ47+ZSr9ivnKapZ9q9K9fhrZUVBwi1ryo/axablsouQ1TS3niWIrGse8JPaZquEm7zbh4ZI3fw1/fBlUbgQMSe/OMk/ujZXuV0MhjFqsqHdhwmgg3gTcJwgzp2EUbNFzgYZotYqcScVEDrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4TvqKHT; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4TvqKHT"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f186025973so60594376d6.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149338; x=1784754138; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4AfjMXtSoUD03YtW++fE/TrHB0R7xJ0Ho064AMFxcPU=;
        b=E4TvqKHTh3ACXvn7BKlRH4gsHCI+gYJwXZzt04q1bwBiWyA6HJRFFESA3ar9GSZQPj
         ia/MbAckMsu/39dEGrhPGp2ENKf46DmtYQ8jeQ9wFH3BJYb2XNkBtgzUFg6TQuukbYoC
         hH5M4Ch6dqfmMZBMDMnnP6WxDNpSkfk7JcucwoinxIyDXSTQGKf/IHi9y0X3E6Q/4EYf
         0pUXEQXk645GNS0q1u7cV3sVl2i5mSjGjHjCIy2Q90s2DC7r4K3NCN2WSXkKLiWZFZ1O
         nUbc+GZmOlimKaDD28uZnL+HZMbiTiUA+1iUe5KJ2gmmBdsfdtFrYL067w2uCHd2vDuI
         BlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149338; x=1784754138;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AfjMXtSoUD03YtW++fE/TrHB0R7xJ0Ho064AMFxcPU=;
        b=CUTgrwZVm3ExJLuYNjddoZk33o1AwOBEuPGAuyrO7vc6WTD4sIr40UJ1fpFMFb4FGo
         pMwme3Y4QFDXcZBGbpYvVtwsXJ1FGo8fDcdPEAhP4yrCAk3DioLJFiwbyMkYcWYjw40t
         8dYYqdbJaHK+gLce94AVvtg32PGcLeGghWzB65de71HB2CZkO63X8pfsIr1zIW2E7l47
         swkggHE+C/gpgGQ/7ODo5NydKui3uhpicf3gj2G6vmhBD8zeA9vfQzIk4Dbjc2ufXP5p
         qvx2QJrDshzDH+3m2cZz5wiEimCiPFcLbX2sU4bodBkzumdohukxbSwcry6uLtJ5VYgq
         oQYg==
X-Gm-Message-State: AOJu0YzHUjHedJewV8xn0iIDQzGJCEBTrd+/MWDH/iEfK7dgfL7h8t6Y
	K+YyjoQlYaz4Poq12VPFGE2IGjTMqa9TwkFdVMu7IG0Eaw6jTnwKWKUIcnvbdA==
X-Gm-Gg: AfdE7cmJKGL+ArUA2XFhuIy3ig+b0hv9tAJgkZFFKtqUbIFK1dqFQVa0zS17M+T1RQl
	zOIxeRzlJffINCW+vPK/IUN4BhVUQ54kLkgul/xwqvZupadsIUJb7ySCpKbK7QV3RCJtd7UcHPl
	10ojZnhd+4nqoD7E6s7LgsRu/FWkub/4qEuHkujrtxGLKS3ksMz8w5BRUx/EUL4UX05CNB7FBKf
	5Hc3loilIYzNxm0rfTUxCDBVJHTso6O0oeOwOEQ2IDhIeqZJddOBLdZiOeHPbzlN4HLDxw3OPyN
	TA3IS7nqZAFOI2V/Zf3FtZO6Xr4xHX2UlfQkMx/nHzqWyEyXM3qJG2RHDFZl0FcW6uMfgx5RJq5
	s6M/WPl65bOvNmDR6HthrwZVmtkN/ibPTuyOcCVqdhRJu6akcUy0LV1PTZsuTekNZtAeZmMdsIQ
	maQSxVYQ==
X-Received: by 2002:a05:620a:d88:b0:92e:c118:18b2 with SMTP id af79cd13be357-930963fdc56mr505560185a.81.1784149337943;
        Wed, 15 Jul 2026 14:02:17 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d04e3csm1818004485a.27.2026.07.15.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:17 -0700 (PDT)
Message-Id: <cf5bb8984ad35551a6faa072f91ea5633f16bfb9.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:02:00 +0000
Subject: [PATCH v5 7/9] blame: consult diff process for no-hunk detection
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

When a diff process is configured via diff.<driver>.process,
consult it during blame's per-commit diffing.  If the process
returns no hunks for a commit's changes to a file, treat the
commit as having no changes, causing blame to attribute lines
to earlier commits.

Introduce xdi_diff_process(), a process-aware xdi_diff() that
consults the process, runs xdiff on the tool's hunks or on the
builtin algorithm when it does not apply, frees the hunks, and
reports DIFF_PROCESS_EQUIVALENT (without running xdiff) so the caller
can drop or skip the change.  It is the shared consult-then-diff path
for consumers that work on raw hunks: blame's pass_blame_to_parent()
uses it here, and git log -L reuses it later.  builtin_diff() keeps
consulting the process directly, because it tests for equivalence
early, before its funcname-pattern and word-diff setup, so a
reformat-only file short-circuits without that work.

Blame's -w option is not communicated to the process and it could not
honor it, so blame must fall back to the builtin diff there.  Because
blame keeps its whitespace flags in sb->xdl_opts rather than diffopt,
the process bypass keys off xpp (the flags the diff actually runs
with), which covers blame without a guard of its own.

The subprocess is long-running (one startup cost amortized across the
blame traversal), but each commit in the file's history incurs a
round-trip to the tool.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 blame.c                 |  24 +++++++-
 diff-process.c          |  38 ++++++++++++
 diff-process.h          |  26 +++++++++
 t/t4080-diff-process.sh | 126 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/blame.c b/blame.c
index 126e232416..932a04c4e8 100644
--- a/blame.c
+++ b/blame.c
@@ -19,6 +19,8 @@
 #include "tag.h"
 #include "trace2.h"
 #include "blame.h"
+#include "diff-process.h"
+#include "xdiff-interface.h"
 #include "alloc.h"
 #include "commit-slab.h"
 #include "bloom.h"
@@ -1946,6 +1948,9 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *parent, int ignore_diffs)
 {
 	mmfile_t file_p, file_o;
+	xpparam_t xpp = {0};
+	xdemitconf_t xecfg = {0};
+	xdemitcb_t ecb = {NULL};
 	struct blame_chunk_cb_data d;
 	struct blame_entry *newdest = NULL;
 
@@ -1964,7 +1969,24 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 			 &sb->num_read_blob, ignore_diffs);
 	sb->num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
+	xpp.flags = sb->xdl_opts;
+	xecfg.hunk_func = blame_chunk_cb;
+	ecb.priv = &d;
+	/*
+	 * Consult the diff process, then attribute the resulting chunks
+	 * via blame_chunk_cb.  It bypasses the process for the whitespace-
+	 * ignoring options it cannot honor (they live in xpp.flags, which
+	 * the consultation checks), and when the process reports the blobs
+	 * equivalent it runs no diff, so blame passes this commit and looks
+	 * past it.  Look up the driver by the parent (old) path, as
+	 * builtin_diff() does with name_a, so a renamed file resolves to the
+	 * same driver across diff, blame, and line-log.  Pass no
+	 * old-oid/new-oid: blame diffs each blob pair once, so the tool gains
+	 * nothing from a per-invocation cache key.
+	 */
+	if (xdi_diff_process(&sb->revs->diffopt, parent->path,
+			     &file_p, &file_o, NULL, NULL, &xpp, &xecfg, &ecb)
+	    == DIFF_PROCESS_ERROR)
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
diff --git a/diff-process.c b/diff-process.c
index 4c748fdd2a..191b2b67b2 100644
--- a/diff-process.c
+++ b/diff-process.c
@@ -37,6 +37,7 @@
 #include "sub-process.h"
 #include "pkt-line.h"
 #include "strbuf.h"
+#include "xdiff-interface.h"
 #include "xdiff/xdiff.h"
 
 #define CAP_HUNKS (1u << 0)
@@ -489,3 +490,40 @@ enum diff_process_result diff_process_fill_hunks(
 	}
 	return DIFF_PROCESS_SKIP;
 }
+
+enum diff_process_result xdi_diff_process(
+		struct diff_options *diffopt,
+		const char *path,
+		mmfile_t *file_a,
+		mmfile_t *file_b,
+		const struct object_id *oid_a,
+		const struct object_id *oid_b,
+		xpparam_t *xpp,
+		xdemitconf_t *xecfg,
+		xdemitcb_t *ecb)
+{
+	enum diff_process_result res;
+
+	/*
+	 * Consult the diff process, then run xdiff either constrained to
+	 * the tool's hunks or, when the process does not apply, computing
+	 * the diff itself as a fallback.  EQUIVALENT short-circuits: the
+	 * caller decides what "no change" means for it (drop the commit,
+	 * skip the file, ...), so xdiff is not run.
+	 *
+	 * A SKIP/ERROR from the process just selects the builtin path
+	 * (its warning, if any, was already emitted), so the result then
+	 * reflects whether xdiff itself succeeded, not the process.
+	 */
+	res = diff_process_fill_hunks(diffopt, path, file_a, file_b,
+				      oid_a, oid_b, xpp);
+	if (res == DIFF_PROCESS_EQUIVALENT)
+		return res;
+
+	res = xdi_diff(file_a, file_b, xpp, xecfg, ecb) < 0
+		? DIFF_PROCESS_ERROR : DIFF_PROCESS_OK;
+
+	FREE_AND_NULL(xpp->external_hunks);
+	xpp->external_hunks_nr = 0;
+	return res;
+}
diff --git a/diff-process.h b/diff-process.h
index 8d00dafe1d..5e5b514b77 100644
--- a/diff-process.h
+++ b/diff-process.h
@@ -46,4 +46,30 @@ enum diff_process_result diff_process_fill_hunks(
 		const struct object_id *oid_b,
 		xpparam_t *xpp);
 
+/*
+ * Process-aware xdi_diff(): consult the diff process for 'path', then
+ * run xdiff either constrained to the tool's hunks or computing the
+ * diff itself when the process does not apply or fails.  Frees any
+ * hunks it obtained before returning.
+ *
+ * Returns DIFF_PROCESS_EQUIVALENT (without running xdiff) when the tool
+ * reports the blobs equal, so the caller can drop or skip the change;
+ * DIFF_PROCESS_OK when xdiff ran (on tool hunks or builtin); and
+ * DIFF_PROCESS_ERROR if xdiff itself errored.
+ *
+ * The caller fills xpp (flags, ignore_regex, anchors) and xecfg/ecb as
+ * for a direct xdi_diff() call.  oid_a/oid_b are forwarded to
+ * diff_process_fill_hunks() (see there).
+ */
+enum diff_process_result xdi_diff_process(
+		struct diff_options *diffopt,
+		const char *path,
+		mmfile_t *file_a,
+		mmfile_t *file_b,
+		const struct object_id *oid_a,
+		const struct object_id *oid_b,
+		xpparam_t *xpp,
+		xdemitconf_t *xecfg,
+		xdemitcb_t *ecb);
+
 #endif /* DIFF_PROCESS_H */
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 7e71b70ab9..694c94edb2 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -658,4 +658,130 @@ test_expect_success 'diff process omits old-oid and new-oid for textconv content
 	test_must_be_empty stderr
 '
 
+#
+# Blame integration.
+#
+
+test_expect_success 'blame uses tool-provided hunks' '
+	cat >blame-hunk.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	original5
+	original6
+	line7
+	line8
+	line9
+	line10
+	EOF
+	git add blame-hunk.c &&
+	git commit -m "add blame-hunk.c" &&
+	ORIG=$(git rev-parse --short HEAD) &&
+
+	cat >blame-hunk.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	changed5
+	changed6
+	line7
+	line8
+	changed9
+	changed10
+	EOF
+	git add blame-hunk.c &&
+	git commit -m "change blame-hunk.c" &&
+	CHANGE=$(git rev-parse --short HEAD) &&
+
+	# With fixed-hunk mode the tool reports only lines 5-6 as changed,
+	# so blame should attribute lines 9-10 to the original commit
+	# even though the builtin diff would show them as changed.
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk" \
+		blame blame-hunk.c >actual &&
+	sed -n "9p" actual >line9 &&
+	sed -n "10p" actual >line10 &&
+	test_grep "$ORIG" line9 &&
+	test_grep "$ORIG" line10 &&
+	sed -n "5p" actual >line5 &&
+	sed -n "6p" actual >line6 &&
+	test_grep "$CHANGE" line5 &&
+	test_grep "$CHANGE" line6
+'
+
+test_expect_success 'blame skips commits with no hunks from diff process' '
+	cat >blame.c <<-\EOF &&
+	int main(void) {
+	return 0;
+	}
+	EOF
+	git add blame.c &&
+	git commit -m "add blame.c" &&
+	ORIG_COMMIT=$(git rev-parse --short HEAD) &&
+
+	cat >blame.c <<-\EOF &&
+	int main(void)
+	{
+	return 0;
+	}
+	EOF
+	git add blame.c &&
+	git commit -m "reformat blame.c" &&
+	BLAME_COMMIT=$(git rev-parse --short HEAD) &&
+
+	# Without no-hunks mode, blame attributes the change.
+	git blame blame.c >without &&
+	test_grep "$BLAME_COMMIT" without &&
+
+	# With no-hunks mode, the process considers the files equivalent
+	# and blame skips the reformat commit, attributing to the original.
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		blame blame.c >with &&
+	test_grep ! "$BLAME_COMMIT" with &&
+	test_grep "$ORIG_COMMIT" with
+'
+
+test_expect_success 'blame --no-ext-diff bypasses diff process' '
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		blame --no-ext-diff blame.c >actual &&
+	# Without the process, blame attributes the reformat commit normally.
+	test_grep "$BLAME_COMMIT" actual &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'blame --no-ext-diff uses builtin hunks' '
+	# fixed-hunk mode would narrow blame to lines 5-6, but
+	# --no-ext-diff should bypass it and use the builtin diff.
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk --log=backend.log" \
+		blame --no-ext-diff blame-hunk.c >actual &&
+	# Builtin diff attributes lines 9-10 to the change commit.
+	sed -n "9p" actual >line9 &&
+	test_grep "$CHANGE" line9 &&
+	test_path_is_missing backend.log
+'
+
+test_expect_success 'blame -w bypasses diff process' '
+	test_when_finished "rm -f backend.log" &&
+	printf "alpha\nbeta\ngamma\n" >blamew.c &&
+	git add blamew.c &&
+	git commit -m "add blamew.c" &&
+	orig=$(git rev-parse --short HEAD) &&
+	printf "alpha\n   beta   \ngamma\n" >blamew.c &&
+	git commit -am "reindent beta" &&
+	reindent=$(git rev-parse --short HEAD) &&
+	# blame -w must ignore the whitespace-only change and attribute
+	# beta to the original commit, not the reindent commit.  The tool
+	# is never told about -w, so blame must bypass it (not let tool
+	# hunks override -w).
+	git -c diff.cdiff.process="$BACKEND --mode=whole-file --log=backend.log" \
+		blame -w blamew.c >actual &&
+	sed -n "2p" actual >line2 &&
+	test_grep "$orig" line2 &&
+	test_grep ! "$reindent" line2 &&
+	test_path_is_missing backend.log
+'
+
 test_done
-- 
gitgitgadget

