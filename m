Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6C3CF1F6
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149343; cv=none; b=hpqA2OYfB4p9722N1n34N7+IXzo95j/AUe2xBIjn1V6AHlcx+LfL0KeYiy+divDotmP4bn/XiuDW3QRha0jN10ZJWEz7CnbhBMBFky9LF6tKR3Xzz8HdbTnlqZ0qV+s/h+3L6TvqekYS8dmekuiS075OLtp/OWKSwK9Gg88Zfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149343; c=relaxed/simple;
	bh=Mu144sUVKG3fLqWR7DhBlajxLVd4Rh2jMNJbKRi8w4o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s/GKjJm/nnCkSU8j+AU/dtreEW4olMTzZX2McjXOvpuKg6i273I7g57fJQR8hXXFDQPMesGczYDdJjNPyhvBMVbG42zgjQu6hQLGJJX4vBGvsVHuglC9sLaEfttGs35+PJwcXlOJlfg0iIGTv56iJ+t0Vqp1Y9bt3IKJMYMope8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVa8y2Xh; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVa8y2Xh"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-725cf9a923aso4810732137.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149340; x=1784754140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EC0UU34KuZN3oaHVTzp4Uz4xbdenP6vJvB7oZw9YePw=;
        b=DVa8y2XhyGSTF5HTDxNRwc+o6y0tJEe6QYFP9sjbYQkFKbRJIpsd0XhAW4ul9hsh8R
         gvZfxhQBTXV04x1VqKSMA1rDxl3TXA5fPZ3dweyYJc1UYYG491vUQGoJBTyxSh/Aovoy
         4Mbaw3PGluHM73mD0VU4HYINCN1Xs4XAvEuay+zNoW2+MWz+A+Y4RDO4Bc/StYy2BsZG
         cbCGk+5S/FlsNLYfJ+wr0gIoiDBMzdtgNQ+lklYwdrtnBj3kgixzhIh7HS3H6O/7Uqk8
         y244CQ4yhf6AMBFf3vNPXMXZ4rvdOGD8wTLu+vMooE9ZznyWn8HwU8UIDvr2syidkP9q
         y2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149340; x=1784754140;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EC0UU34KuZN3oaHVTzp4Uz4xbdenP6vJvB7oZw9YePw=;
        b=f7hG3250RrFL/GptPyb715nDvd2qDJFkc/cAq+sxFP7TmcdFnlg642rHeGZCKaB49f
         Rm0xOj3ZwnbSyPVOlprtyrF8r4VHqrtvscdE9ULkm6WYxXHqQ6PaRN6mSXxYVRji9+wL
         ehW6uGr8m3RrAqr9FDSkFB7lds6u++CE5tQVegGpo+j5KLJrrSfEASUBmDf7KRscM5NI
         +7wzvyF/0TdlCtFhtR9efMgGyWkDaT+1UkVvS95ChYvLDgLSFBimQ+9DMwTes0L6OUJK
         U3nvynaJDEP8aze2BDkJ4Frp9fCBcxgfczP3G7r4GBRZX+9LUZwYLerF11UA8nffrI1j
         CEKw==
X-Gm-Message-State: AOJu0YzSBsPwW+lNO4CgwPbEE64kkxQCe6BB463CZtgrgqriMu8ICo8t
	vz42O7fJZ0Sj0oKSI7Cyc3JuCxr8gaMio5BgwuVve9u13L/9Sun3Xrd+UlPIVA==
X-Gm-Gg: AfdE7cn02b0CD2PKb2UnvbcxJH2YCt1YfP4ERuRbH2i5RGq6ZwNzqx25738kqGxtdG7
	V5X13rAtiWouphwU0PVEJee/F3C9hWN3uyR82sW+Lce0DwCjmO4GPnsmgUGqkKFBpwCxJu3VW45
	U2I98a/euKAIMyRxRafrEMd0yGXjLgNlvq/v/VcJS9JM0TZQZi5h3+7xnVQfInI9PiCkNMriP5e
	4JebfApzAhrCaXGQuoFwAFOQqeGwUpyxw384ofsbpuWIaWpvlPqq8uScA62e6KId0kDjl/t8Dai
	CKxrJpciKERyUQ46sVhv6vKZXFIseNg/LboaqoWAb9Ed6As2Ca1cLFYgNJbACUGLZ7eSrxgd8lj
	m/E1chby+oZfaN8b96ewTx5JtO5L9WXQKOa7obKpQNrSLLXHhzf3PBGVKRYf0cHybayjLwXlz8b
	j/5srXbA==
X-Received: by 2002:a05:6102:5806:b0:738:ff1b:940 with SMTP id ada2fe7eead31-74599d988eemr2946529137.4.1784149339838;
        Wed, 15 Jul 2026 14:02:19 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d22bsm201669476d6.32.2026.07.15.14.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:19 -0700 (PDT)
Message-Id: <c1d02d0e15525e2d76f2e9ebfbad4f3b6222d945.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:02:01 +0000
Subject: [PATCH v5 8/9] diff: consult diff process for --stat counts
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

builtin_diff() already consults a configured diff.<driver>.process: a
file the tool reports as equivalent emits no patch, and otherwise the
tool's hunks drive the output.  builtin_diffstat() ran its own xdiff
and ignored the process, so "git diff --stat" still counted a
byte-level change for a file that "git diff" showed as unchanged.

Consult diff_process_fill_hunks() before the stat xdiff, as
builtin_diff() does.  On DIFF_PROCESS_EQUIVALENT, skip the xdiff so
the file keeps its zero inserted and deleted counts and the existing
"nothing changed" pruning drops it, matching the empty patch.
Otherwise the tool's hunks, or the builtin fallback, feed the counts
through the shared xpparam_t.

Like the builtin summary path, builtin_diffstat() does not apply
textconv, so the process is consulted on the raw blob content here,
unlike builtin_diff() which sends textconv'd content.  This keeps
"git diff --stat" counting raw lines as it does today; the asymmetry
between patch output and summary counts under textconv predates this
change.  Because the content is the raw blob, the stat path sends the
blob object names to the tool (old-oid/new-oid) for any stored blob,
where the patch path omits the oid under textconv.

Move the summary formats out of the "not yet wired" group of the
"Which features consult the diff process" documentation and into the
list of features that use the tool's hunks, noting the raw,
non-textconv content they receive.  Document that the line-counting
--dirstat=lines follows these counts while the default --dirstat does
not, and that summary formats and blame (only under --textconv) differ
from patch output in whether they textconv the content the tool sees.

Add tests covering counts from the tool's hunks (--numstat,
--shortstat), an equivalent file producing no stat line, --stat
--exit-code, the raw non-textconv content the tool receives, a
multi-file mix of equivalent and changed files, and a mode-only
change.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc |  33 +++++---
 diff.c                           |  20 ++++-
 t/t4080-diff-process.sh          | 130 +++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index a03fb9deb1..7cdede6b21 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -874,7 +874,10 @@ a flush packet, followed by the old and new file content as packetized
 data, each terminated with a flush packet.  The pathname is relative
 to the repository root.  When `diff.<name>.textconv` is also set,
 the tool receives the textconv-transformed content rather than the
-raw blob.  Git does not send binary files to the diff process.
+raw blob, matching what the consuming feature itself diffs: patch
+output is textconv'd, the summary formats (noted below) are not, and
+`git blame` applies textconv only under `--textconv`.  Git does not
+send binary files to the diff process.
 
 -----------------------
 packet:          git> command=hunks
@@ -960,8 +963,8 @@ still slide or regroup those changes against matching context for
 display, exactly as it compacts its own diffs, so the tool controls
 which lines are reported as changed, not the precise hunk boundaries.
 Patch output features (word diff, function context, color) work
-normally.  Summary formats such as `--stat` still compute their counts
-with the builtin diff for now; see "Which features consult the diff
+normally, as do summary formats like `--stat`.  Not every feature
+consults the process, though; see "Which features consult the diff
 process" below for the full picture and the reasoning behind it.
 
 If no hunk lines precede the flush, followed by "success", Git
@@ -1040,6 +1043,17 @@ of the builtin algorithm:
   hunks without any further negotiation.
 - `git blame`: a commit whose change the tool reports as equivalent is
   skipped, and its lines are attributed to an earlier commit.
+- `--stat`, `--numstat`, and `--shortstat`: the inserted and deleted
+  counts come from the tool's hunks, so a file the tool calls
+  equivalent contributes no stat line, matching the empty patch that
+  `git diff` produces for it.  These summary formats do not apply
+  textconv (just as the builtin summary path does not), so the tool
+  is consulted on the raw blob content even when a `textconv` is also
+  configured for patch output; this mirrors how builtin `--stat`
+  already counts raw lines rather than the textconv'd view.  The
+  line-counting `--dirstat=lines` uses these same counts; the default
+  `--dirstat`, which weighs byte changes, is computed on its own and
+  does not consult the tool.
 
 Features that ask a different question do not consult the process, by
 design:
@@ -1065,13 +1079,12 @@ design:
 - `--raw`, `--name-only`, and `--name-status` compare object ids at
   the tree level and never run a line-level diff at all.
 
-Some features ask "which lines changed" but still use the builtin
-algorithm for now, and may consult the process in a later change: the
-summary formats (`--stat`, `--numstat`, `--shortstat`); `git log -L`'s
-commit selection and parent range propagation (as distinct from its
-display, which is covered above); and combined diffs (`--cc` and merge
-diffs), whose protocol would have to be extended from a single old/new
-pair to one comparison per merge parent.
+Two cases ask "which lines changed" but still use the builtin
+algorithm, and may consult the process in a later change: `git log
+-L`'s commit selection and parent range propagation (as distinct from
+its display, which is covered above), and combined diffs (`--cc` and
+merge diffs), whose protocol would have to be extended from a single
+old/new pair to one comparison per merge parent.
 
 `--no-ext-diff` and `--diff-algorithm` bypass the process entirely,
 for every feature listed above.  The whitespace-ignoring options
diff --git a/diff.c b/diff.c
index a9a732629e..f3c8267a39 100644
--- a/diff.c
+++ b/diff.c
@@ -4269,9 +4269,27 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-		if (xdi_diff_outf(&mf1, &mf2, NULL,
+		/*
+		 * Consult the diff process so --stat reflects the
+		 * tool's view of which lines changed rather than the
+		 * builtin line diff.  --stat never applies textconv, so
+		 * the tool is fed the same raw mmfiles the stat itself
+		 * diffs (unlike builtin_diff, which consults the process
+		 * on textconv'd content).
+		 * When the tool reports the files as equivalent we skip
+		 * xdiff entirely, leaving added and deleted at zero so
+		 * the file is pruned below, just as builtin_diff() emits
+		 * no patch for an equivalent file.
+		 */
+		if (diff_process_fill_hunks(o, name_a, &mf1, &mf2,
+					    one->oid_valid ? &one->oid : NULL,
+					    two->oid_valid ? &two->oid : NULL,
+					    &xpp)
+		    != DIFF_PROCESS_EQUIVALENT &&
+		    xdi_diff_outf(&mf1, &mf2, NULL,
 				  diffstat_consume, diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
+		free(xpp.external_hunks);
 
 		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
 			struct diffstat_file *file =
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 694c94edb2..e1c7256747 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -282,6 +282,21 @@ test_expect_success 'diff process works alongside textconv' '
 	test_must_be_empty stderr
 '
 
+test_expect_success 'diff process --stat is fed raw, not textconv, content' '
+	# Reuses textconv.c from the previous test (committed "hello
+	# world", modified to "goodbye world").  Unlike patch output,
+	# --stat does not apply textconv, so the tool sees raw lowercase
+	# content here even with a textconv configured.
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.textconv="./uppercase-filter" \
+	    -c diff.cdiff.process="$BACKEND --log=backend.log" \
+		diff --stat -- textconv.c >actual 2>stderr &&
+	test_grep "pathname=textconv.c" backend.log &&
+	test_grep "old=hello world" backend.log &&
+	test_grep "new=goodbye world" backend.log &&
+	test_must_be_empty stderr
+'
+
 #
 # Downstream features: word diff, log, equivalent files, exit code.
 #
@@ -386,6 +401,121 @@ test_expect_success 'diff process with --exit-code and hunks returns failure' '
 		diff --exit-code newfile.c
 '
 
+test_expect_success 'diff process feeds --numstat counts' '
+	# fixed-hunk reports only lines 5-6 as changed, so the stat
+	# counts come from the tool (2/2), not the builtin diff (4/4).
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk --log=backend.log" \
+		diff --numstat boundary.c >actual 2>stderr &&
+	printf "2\t2\tboundary.c\n" >expect &&
+	test_cmp expect actual &&
+	test_grep "command=hunks pathname=boundary.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process --numstat sums multi-hunk counts' '
+	# multi-hunk reports both 2-line regions (5-6 and 9-10), so the
+	# counts add up across both hunks: 4 inserted, 4 deleted.  This
+	# exercises the two-region hunk path through builtin_diffstat.
+	git -c diff.cdiff.process="$BACKEND --mode=multi-hunk" \
+		diff --numstat boundary.c >actual &&
+	printf "4\t4\tboundary.c\n" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff process equivalent files produce no --stat line' '
+	# A file the tool calls equivalent contributes no stat line,
+	# matching the empty patch that git diff produces for it.
+	test_when_finished "rm -f backend.log" &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		diff --stat worddiff.c >actual 2>stderr &&
+	test_must_be_empty actual &&
+	test_grep "command=hunks pathname=worddiff.c" backend.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process feeds --shortstat counts' '
+	# fixed-hunk reports lines 5-6 only, so the summary counts come
+	# from the tool (2 insertions, 2 deletions), not builtin (4/4).
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk" \
+		diff --shortstat boundary.c >actual &&
+	test_grep "2 insertions" actual &&
+	test_grep "2 deletions" actual
+'
+
+test_expect_success 'diff process equivalent file makes --stat --exit-code succeed' '
+	# The tool reports worddiff.c equivalent, so --exit-code reports
+	# no change (0); the builtin diff would report a change (1).
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks" \
+		diff --stat --exit-code worddiff.c &&
+	test_expect_code 1 git diff --no-ext-diff --stat --exit-code worddiff.c
+'
+
+test_expect_success 'diff process --numstat with mixed equivalent and changed files' '
+	test_when_finished "rm -f c.log h.log" &&
+	# Self-contained fixtures: *.c uses whole-file (changed); *.mh
+	# uses no-hunks (equivalent).
+	echo "*.mh diff=hdiff" >>.gitattributes &&
+	git add .gitattributes &&
+	printf "int a(void) { return 1; }\n" >mixed.c &&
+	printf "int b(void) { return 1; }\n" >mixed.mh &&
+	git add mixed.c mixed.mh &&
+	git commit -m "add mixed fixtures" &&
+	printf "int a(void) { return 2; }\n" >mixed.c &&
+	printf "int b(void) { return 2; }\n" >mixed.mh &&
+	git -c diff.cdiff.process="$BACKEND --mode=whole-file --log=c.log" \
+	    -c diff.hdiff.process="$BACKEND --mode=no-hunks --log=h.log" \
+		diff --numstat mixed.c mixed.mh >actual 2>stderr &&
+	test_grep "mixed.c" actual &&
+	test_grep ! "mixed.mh" actual &&
+	test_grep "pathname=mixed.c" c.log &&
+	test_grep "pathname=mixed.mh" h.log &&
+	test_must_be_empty stderr
+'
+
+test_expect_success POSIXPERM 'diff process keeps mode-only change in --stat' '
+	test_when_finished "rm -f backend.log" &&
+	cat >modeonly.c <<-\EOF &&
+	int m(void) { return 1; }
+	EOF
+	git add modeonly.c &&
+	git commit -m "add modeonly.c" &&
+	cat >modeonly.c <<-\EOF &&
+	int m(void) { return 2; }
+	EOF
+	git add modeonly.c &&
+	test_chmod +x modeonly.c &&
+	git commit -m "edit and chmod modeonly.c" &&
+	# Content and mode both changed, but no-hunks reports the content
+	# equivalent.  The tool is consulted (counts are zero, not the
+	# builtin 1/1), yet the mode change keeps the file from being
+	# pruned.
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		diff --stat HEAD^ HEAD >actual 2>stderr &&
+	test_grep "modeonly.c" actual &&
+	test_grep "command=hunks pathname=modeonly.c" backend.log &&
+	test_grep ! "1 insertion" actual &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'diff process not consulted for default --dirstat' '
+	# The default (change-based) --dirstat algorithm counts via its
+	# own path and never contacts the tool (here --dirstat=0 just
+	# sets a 0% threshold), so the change is still reported even
+	# though no-hunks would call it equivalent.  --dirstat=lines
+	# instead uses the process-aware stat path.
+	test_when_finished "rm -f backend.log" &&
+	mkdir -p dsub &&
+	printf "a\nb\nc\n" >dsub/d.c &&
+	git add dsub/d.c &&
+	git commit -m "add dsub/d.c" &&
+	printf "a\nB\nc\n" >dsub/d.c &&
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		diff --dirstat=0 dsub/d.c >actual &&
+	test_grep "dsub" actual &&
+	test_path_is_missing backend.log
+'
+
 #
 # Bypass mechanisms: flags and commands that skip the diff process.
 #
-- 
gitgitgadget

