Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79E306752
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149344; cv=none; b=CXqRAuYoiohmEouxBsojOezn3VgCooTtmluYPDthFNvEGvO+vdCEx5DlOMQUFmuOAI7uDLHarPzqkA+ZmGBlEO61y9sxHGorNplg7udgMPgQi3kngXs47CVj/YH/5V9k/uCNsDThym4G/X1z/2ZHW5sRu0cLJOyccHNxAL/kAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149344; c=relaxed/simple;
	bh=8z/A6W5e8uCWUgu4A3YFGLHKW4GJZ2j4xiwMwZdD4K4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c3T7oirFsajGLGoW409K95fW+X1tlCaPTB/S66xHyRp5pbBQufRbrz4YT9mGt/uzSh+xZLGnZXqtzZ/xVhW+P6zmEP4lQwl9FaOvu1cAoeNY4ktLrrKV9aNBcl51diUt7cGGOXSBSRu8ajAhQui6RzzD6/OVExalEOjlYsdY+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOdiOICA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOdiOICA"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0ecfaee7so49810571cf.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149342; x=1784754142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3g0vWabdJcNnuru+INkBa1KYxYI3YRSsUMNW5oh4WzI=;
        b=GOdiOICA8umeF5bpnic9VthdcRfg7QVL6h8iLVMiEY3DtRJWFEZFPLy38Jt3nsdNiy
         tPQxvRWNlIDinx+VCUmBcC/AD3+gusoamPDW5s44CZFXlRwVxU1BplQN8tebkte8oMO7
         ymf2ufBP3/3BEjKcvHUxTjYzL5xnL7ZliLSgj8ySm0T1PY/900QZyb1JUzjTADrtPp8I
         N7qT4YihFBhtRoSy6m2eBaIkW4pXIeU2CWxnYyNBYr6J67fmyPez4gCm0V4rEPE8HT0/
         2zYc6mvo7xQlaQs91x5M7oYJhx4+VOKjI/u8cYyvCDK+xbsYxnZMnC5/bT5tw/KjPckx
         YM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149342; x=1784754142;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3g0vWabdJcNnuru+INkBa1KYxYI3YRSsUMNW5oh4WzI=;
        b=OtlkcpekvacjoUmMtdZSt9myV97tyFQrzeJs/SU9d0MQtaZ3rC2PCZjldjuoXuz+ba
         /ONvxMHuatmjvB7ZZ/63n1qcosTsdnQ/xkfb9AbRjdTSauE3SlUlLdZKrSAFP2v6Wsv4
         u/iO2AlLHma9mwafX9infJyarfa6+rcrUcWuLOYQ0ETMKAO11W/BGXfDF7jdYCiubvh9
         OGcsPvvHwigwV1FMt9danFxMRbaVI86coYncJKiSTDiW3ER4GP45AopOZsHp0+j337/c
         SfX4K90aoqSWcf2G8ebhAW4TWcFT95dvu8wwknhc6/cbbZXM1TLhgXXPiyupV3gx/0wx
         Cxjg==
X-Gm-Message-State: AOJu0YxyFHtDv7csqTt9nr0QLcuW4WyflhqhkXd8O3Wk2n4f1g2TODlu
	6Z7IitqyhMjXsH1BMa4E6sEWVGM+Rf31wmICgido+jHFud+aduuYLhU+xbnMhQ==
X-Gm-Gg: AfdE7ckLKKzaw9uNhw30YTzF2OMt81TpslepcqbtRPR72GuEb2JfKdWiupEdvkOZIfQ
	VurQwBGzC2onq9CXtEP3z9uw5t0WctwRE6wawTE+WHrF9kMAQtzTvgZ5JpuZomuuHTs6mSlZQag
	gZ8BxFKZoAO7TfDGJhfqLpXjWZ5H6EGGk0UA2lESV02+pjt2x8tSk+xT8q5qbx7kwmhWHh7ECuF
	ZLO++riIt3BQoGkPHSrcqY6/GqXDDq/Mba7nf8ITgorLJdscegchowCtDvk64hs0vJYmshjd/5R
	lqA/CEEjCKeR9gbdNOfHyIVH/F9mDV31XtT8xFRBsKZpYphFraJtSLKQ8X/Tidd1J12OITgTrKa
	jWDV2U+0V0DMXOXVtbwb2gfQeLPZnqyyaX+o2/fuUVoL2TZFN/b8TgTJnX1hIGvQVFPEselPICb
	lgLXn1hODJVCNZOZc1
X-Received: by 2002:a05:622a:149:b0:51c:7b12:600a with SMTP id d75a77b69052e-51e4f2674c7mr45885121cf.86.1784149341436;
        Wed, 15 Jul 2026 14:02:21 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae206b6sm143166131cf.14.2026.07.15.14.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:20 -0700 (PDT)
Message-Id: <c3c17ba8fc1f13830e190baeb9c27ebe1d12f1a5.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:02:02 +0000
Subject: [PATCH v5 9/9] line-log: consult diff process for range tracking
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

git log -L tracks line ranges by diffing each commit against its
parent in collect_diff().  This pass used the builtin diff while the
displayed diff (builtin_diff()) consults a configured
diff.<driver>.process, so the two could disagree: a reformat-only
commit selected by builtin tracking was then rendered with an empty
diff because the tool reported the files equivalent.

Consult the process in collect_diff() too, mirroring the blame
integration.  When the tool reports the files equivalent, collect no
ranges; the tracked range then maps across unchanged and the commit
drops out of the log, matching what is displayed.  Like the summary
formats, the tracking pass diffs raw content, so the tool is consulted
on the raw blobs here.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc | 20 ++++++++++---------
 line-log.c                       | 33 ++++++++++++++++++++++++++++----
 t/t4080-diff-process.sh          | 33 ++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index 7cdede6b21..8021dc8e39 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -1037,12 +1037,16 @@ Features that ask "which lines changed" use the tool's hunks in place
 of the builtin algorithm:
 
 - `git diff` patch output, together with everything layered on it:
-  word diff, function context (`-W`), `--color-moved`, the `@@` hunk
-  headers, and the `-L` line-range display.  These operate on the
-  lines the patch step already emitted, so they reflect the tool's
-  hunks without any further negotiation.
+  word diff, function context (`-W`), `--color-moved`, and the `@@`
+  hunk headers.  These operate on the lines the patch step already
+  emitted, so they reflect the tool's hunks without any further
+  negotiation.
 - `git blame`: a commit whose change the tool reports as equivalent is
   skipped, and its lines are attributed to an earlier commit.
+- `git log -L`: both the line-range display and the underlying range
+  tracking consult the tool, so a commit it reports as equivalent is
+  dropped from the log (its tracked range maps across unchanged)
+  rather than selected and then shown with an empty diff.
 - `--stat`, `--numstat`, and `--shortstat`: the inserted and deleted
   counts come from the tool's hunks, so a file the tool calls
   equivalent contributes no stat line, matching the empty patch that
@@ -1079,11 +1083,9 @@ design:
 - `--raw`, `--name-only`, and `--name-status` compare object ids at
   the tree level and never run a line-level diff at all.
 
-Two cases ask "which lines changed" but still use the builtin
-algorithm, and may consult the process in a later change: `git log
--L`'s commit selection and parent range propagation (as distinct from
-its display, which is covered above), and combined diffs (`--cc` and
-merge diffs), whose protocol would have to be extended from a single
+Combined diffs (`--cc` and merge diffs) ask "which lines changed" but
+still use the builtin algorithm, and may consult the process in a
+later change; their protocol would have to be extended from a single
 old/new pair to one comparison per merge parent.
 
 `--no-ext-diff` and `--diff-algorithm` bypass the process entirely,
diff --git a/line-log.c b/line-log.c
index 5fc75ae275..97b3e0a31d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -7,11 +7,11 @@
 #include "tag.h"
 #include "tree.h"
 #include "diff.h"
+#include "diff-process.h"
 #include "commit.h"
 #include "decorate.h"
 #include "repository.h"
 #include "revision.h"
-#include "xdiff-interface.h"
 #include "strbuf.h"
 #include "line-log.h"
 #include "setup.h"
@@ -330,12 +330,15 @@ static int collect_diff_cb(long start_a, long count_a,
 	return 0;
 }
 
-static int collect_diff(mmfile_t *parent, mmfile_t *target, struct diff_ranges *out)
+static int collect_diff(struct diff_options *diffopt, const char *path,
+			mmfile_t *parent, mmfile_t *target,
+			struct diff_ranges *out)
 {
 	struct collect_diff_cbdata cbdata = {NULL};
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
+	int ret = 0;
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -345,7 +348,23 @@ static int collect_diff(mmfile_t *parent, mmfile_t *target, struct diff_ranges *
 	xecfg.hunk_func = collect_diff_cb;
 	memset(&ecb, 0, sizeof(ecb));
 	ecb.priv = &cbdata;
-	return xdi_diff(parent, target, &xpp, &xecfg, &ecb);
+
+	/*
+	 * Consult the diff process so range tracking agrees with the
+	 * diff that will be shown.  When the tool reports the files as
+	 * equivalent we collect no ranges, so the tracked range maps
+	 * across unchanged and the commit drops out of the log, rather
+	 * than being selected here but rendered with an empty diff by
+	 * the process-aware builtin_diff().  Blob oids are not threaded to
+	 * this path yet, so pass NULL and send no old-oid/new-oid (a later
+	 * change can supply the pair, where they would let the tool cache
+	 * across the range-tracking and display passes over the same
+	 * commit).
+	 */
+	if (xdi_diff_process(diffopt, path, parent, target,
+			     NULL, NULL, &xpp, &xecfg, &ecb) == DIFF_PROCESS_ERROR)
+		ret = -1;
+	return ret;
 }
 
 /*
@@ -927,7 +946,13 @@ static int process_diff_filepair(struct rev_info *rev,
 	}
 
 	diff_ranges_init(&diff);
-	if (collect_diff(&file_parent, &file_target, &diff))
+	/*
+	 * Select the driver by the old (parent) path, as builtin_diff() does
+	 * with name_a, so a renamed file resolves to the same driver for
+	 * range tracking as for the diff that is shown.
+	 */
+	if (collect_diff(&rev->diffopt, pair->one->path,
+			 &file_parent, &file_target, &diff))
 		die("unable to generate diff for %s", pair->one->path);
 
 	/* NEEDSWORK should apply some heuristics to prevent mismatches */
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index e1c7256747..c20ab15ecd 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -914,4 +914,37 @@ test_expect_success 'blame -w bypasses diff process' '
 	test_path_is_missing backend.log
 '
 
+#
+# Line-log (git log -L) range tracking.
+#
+
+test_expect_success 'diff process drops equivalent commit from log -L' '
+	test_when_finished "rm -f backend.log" &&
+	cat >linelog.c <<-\EOF &&
+	int tracked(void) { return 1; }
+	EOF
+	git add linelog.c &&
+	git commit -m "add linelog.c" &&
+
+	cat >linelog.c <<-\EOF &&
+	int tracked(void) { return 2; }
+	EOF
+	git commit -am "change tracked line" &&
+
+	# Builtin line tracking selects the change commit.
+	git log --no-ext-diff -L1,1:linelog.c --format="%s" >builtin &&
+	test_grep "change tracked line" builtin &&
+
+	# With the tool reporting the change as equivalent, tracking
+	# drops the commit (the range maps across unchanged) instead of
+	# selecting it and rendering an empty diff.
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		log -L1,1:linelog.c --format="%s" >actual &&
+	test_grep ! "change tracked line" actual &&
+	# The creating commit still appears, so the change commit was
+	# selectively dropped rather than the whole log going empty.
+	test_grep "add linelog.c" actual &&
+	test_grep "command=hunks pathname=linelog.c" backend.log
+'
+
 test_done
-- 
gitgitgadget
