Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905963E3DB1
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091906; cv=none; b=Qe4v5YuwzfU3i+E86o64A9DZ72qBCMXtaFEP/9rg/zeILJCRoycgEychuiml/0N0UBBkkLRScpZmGzfDMTZhN822S6zoi4VEMrGLn71tULYsfBlWlqyG3W/lDAOO6Ixb7xpUVWgUooOnn3sOhomCoRlkPEQ1INi01BoQOEfZ9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091906; c=relaxed/simple;
	bh=NCivQlpMoIzLwB6bJhxd1vcxm71lBemObdj7zZDkJIw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hQx7RlcwJuwUgecM9S51kQs2OZQE0NMyVn7hKS1KPx8Oriae3X1Eo25rCgUlwqyoqCTG+dFvdoKSiTlQecVyGs6uuv0a9UjlbYAhaKUrWJesLcVGSiTT9RpXcb1aPIM+Vd5Fun2gTiodeYrdQWevNFqhIudX6hSaSRwh2JreqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjpEWelA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjpEWelA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso22728995ad.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091904; x=1785696704; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oFPXVTu96TYr4+kEer9j9hB3JD+6C2gEnDChtAL0mAE=;
        b=QjpEWelA8tTcronNv+HZqzlfoijHRZURJMZO0HcNOu83/3yKTChlEoYQX5Cd216zaE
         XfTvsHt/1fgSI1eUFG15k+l6OX1wDDEXCQrbjEzdbAXrg4G31S8Sm0QnLXLD43UEsKfO
         1v/93Moddvs3O+3YP1ZsUPXDj4C2iyiNYXRbyuotN/kTXGd4p9J91zd7TJRQGkgMA09b
         v11C+Fy5U4UiskM18nvomQjUZNjCb6iSPQIkL1dj0uLLSJSTX7idDhcy7hU59Uoqrmsq
         /o7tQVEPJiY1Qd6LbYgVqUk1WzFddAO7N0c0HEAHBV07fLM3YhtyxJW4AL4r78H1FZXh
         mqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091904; x=1785696704;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFPXVTu96TYr4+kEer9j9hB3JD+6C2gEnDChtAL0mAE=;
        b=XTbYBtJG16vZjT8uc8N2tESHQoPI2KC29oL7m0tdU8Zh1Ryjlh8lXxjd1MsiGMA+VL
         jQ/C1HT5628zLgJANE+iUItfPVR8v6J/zfrJkf7waCpoFpjOLPxYjLrwLfFVS/DyVVVf
         tdb7UaQhb+WBkpMI2KKnZb6C6t+pN3H3HhtstjBU7V1owrN2r8ShQD/Uk1XoL+PxyfNL
         d2kEpa+OQ9R6QDnB0U7TqmFER3qFq5E7FxCSFXrpPohJ5O/W1QebOeLD3cBXUyP4K/Ch
         0xkdkaYmScKlaOySkCiL7fO9UrkdxizeE9DNQzz+GoGqJAZKJgk9MWtM2BkYoeT6Cmq1
         ePXw==
X-Gm-Message-State: AOJu0YwfWtlPaf2UTUA/sALNd+E/c9jyqUNz9665gKnxa++Vdufp/Qsh
	8ruiYxFWUbg965zXSuIMFR+66uXbb1cLn1ubNonsozzKypHztdxj+R/TV8TCXg==
X-Gm-Gg: AR+sD12s3LefKBnsHCZZPgHFGxCWfKCN9BsJKt7Jbe6gWs0eIsZn0yayu/MFQpRddqm
	jlz8FpoDLQmEoosiRI1cBnYnj/EaBcp+xXp5OvRSk6pljXiP7YfwtJBxOWXzsTHLa1rTJ/Q99ei
	aNC7lSo0l7hFG9RO7TgowUY5ZwFI8sDoCSoI91GRS3KM5DqIDblWEy0EcxheXQ1SNh2Y37NLaL/
	fJkic2/xKVpxPhBgc36UNyVkV3FAMhfFVhFMWQayyqzd4aOH+EXqiEVBmphaRYMDO9Sp8pubofd
	uL1FLiYAld77c6Lw0zpiLKKCmE4IMlHs7s2nLVLfBevY2zvWdq/rpEbz99bgZ5VzVN/++dA/JH7
	dMm6MU/vIFzSKNgpZYw8kKDOpL9xoQ49Jt+77HMKukI2uKqdGydJTtevHHoKeBMPRP8gS5JFbkY
	tyHcxC
X-Received: by 2002:a17:902:c40a:b0:2cc:61e8:5fba with SMTP id d9443c01a7336-2cfde866e46mr60832895ad.32.1785091903622;
        Sun, 26 Jul 2026 11:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a67f3sm23977643eec.29.2026.07.26.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:51:43 -0700 (PDT)
Message-Id: <7e3ba569679401c98d78d0a0eff42c19c2886edb.1785091889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
References: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
	<pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 18:51:27 +0000
Subject: [PATCH v6 8/9] diff: consult diff process for --stat counts
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

Under -L, route the surviving hunks through the same line-range filter
builtin_diffstat() already uses for a tracked range, so a
process-provided diff is scoped to that range: "git log -L<range>
--stat" counts the tool's changed lines within the range rather than
the builtin line diff's.

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
multi-file mix of equivalent and changed files, a mode-only change,
and a range-scoped --stat under "git log -L" that reflects the tool's
hunks.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc |  33 ++++--
 diff.c                           |  47 ++++++---
 t/t4080-diff-process.sh          | 176 +++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+), 22 deletions(-)

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
index 1a487bb353..241c07fc63 100644
--- a/diff.c
+++ b/diff.c
@@ -4342,20 +4342,43 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-
-		if (p->line_ranges) {
-			struct line_range_filter lr_filter;
-
-			line_range_filter_init(&lr_filter, p->line_ranges,
-					       diffstat_consume, diffstat);
-
-			if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
-						   &xpp, &xecfg))
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
+		 *
+		 * Under -L, feed the tool's hunks through the same
+		 * line-range filter the builtin stat uses, so a
+		 * process-provided diff is scoped to the tracked range.
+		 */
+		if (diff_process_fill_hunks(o, name_a, &mf1, &mf2,
+					    one->oid_valid ? &one->oid : NULL,
+					    two->oid_valid ? &two->oid : NULL,
+					    &xpp)
+		    != DIFF_PROCESS_EQUIVALENT) {
+			if (p->line_ranges) {
+				struct line_range_filter lr_filter;
+
+				line_range_filter_init(&lr_filter, p->line_ranges,
+						       diffstat_consume, diffstat);
+
+				if (line_range_filter_diff(&lr_filter, &mf1, &mf2,
+							   &xpp, &xecfg))
+					die("unable to generate diffstat for %s",
+					    one->path);
+			} else if (xdi_diff_outf(&mf1, &mf2, NULL, diffstat_consume,
+						 diffstat, &xpp, &xecfg))
 				die("unable to generate diffstat for %s",
 				    one->path);
-		} else if (xdi_diff_outf(&mf1, &mf2, NULL,
-				  diffstat_consume, diffstat, &xpp, &xecfg))
-			die("unable to generate diffstat for %s", one->path);
+		}
+		free(xpp.external_hunks);
 
 		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
 			struct diffstat_file *file =
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 694c94edb2..118d0f9464 100755
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
@@ -386,6 +401,167 @@ test_expect_success 'diff process with --exit-code and hunks returns failure' '
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
+test_expect_success 'diff process scopes --stat to the tracked range under log -L' '
+	test_when_finished "rm -f backend.log" &&
+	cat >rangestat.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	OLD5
+	OLD6
+	line7
+	line8
+	OLD9
+	OLD10
+	EOF
+	git add rangestat.c &&
+	git commit -m "add rangestat.c" &&
+
+	cat >rangestat.c <<-\EOF &&
+	line1
+	line2
+	line3
+	line4
+	NEW5
+	NEW6
+	line7
+	line8
+	NEW9
+	NEW10
+	EOF
+	git add rangestat.c &&
+	git commit -m "change rangestat.c" &&
+
+	# The file changes at lines 5-6 and 9-10, but fixed-hunk reports
+	# only 5-6.  The builtin line diff counts both regions (4/4); the
+	# tool hunks flow through the same line-range filter the stat uses,
+	# so the range-scoped stat reflects the tool view instead (2/2).
+	git log --no-ext-diff -L1,10:rangestat.c --oneline --stat >builtin &&
+	test_grep "4 insertions(+), 4 deletions(-)" builtin &&
+
+	git -c diff.cdiff.process="$BACKEND --mode=fixed-hunk --log=backend.log" \
+		log -L1,10:rangestat.c --oneline --stat >actual &&
+	test_grep "2 insertions(+), 2 deletions(-)" actual &&
+	test_grep ! "4 insertions" actual &&
+	test_grep "command=hunks pathname=rangestat.c" backend.log
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

