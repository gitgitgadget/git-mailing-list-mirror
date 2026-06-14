Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D651306486
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463575; cv=none; b=GCsqa1OR5yhcd1/Xq3ENmF4ekJBCcQDnDWhghYzOxC6mLyJm+vhhp4VnwXreQ5DI7G1BWxxRCet5m8lQMTS9zngfgU8Tjp/MScsuumTDRZjdc5aUlURFKXrbTteXu5s+u2ygHSAzHfS6SeGwF5qfJaXaCKUAD+XeZM7B2xCTghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463575; c=relaxed/simple;
	bh=+EzWZrKJyTMsjJM0/2cjK51ydawnBcf1bAEx0zQ9aoQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bl1hhdz+v3VSMC6W91ItM0jvQfaqPpzESZGvgYMk4j/vNdXIykyIa6ygMxWcw8Bmi3+e1wdAy7j0Ngflh+UlPfM/T+d1KlAT4B0DhpTM2zf/b+PF5v0XtkarfUN5PvgctkX4liIxE9Ke9YsJXSFSIJ4bDVMhTQUQsJB7y0Y/TzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9r1CHku; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9r1CHku"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30807ba471bso7577133eec.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463574; x=1782068374; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+Wwrx8L0mRrwtYy1J+nOna5VRruznj4mw1CTa6ij3Y=;
        b=I9r1CHkuEKX0haKHIrqncC4Ry5bjh5Yr4OYPL7kjRIOHNm73KsYMzjac7KVBt1wDbL
         0eVEANG4P27KDhCM0CkSl9uK72dZItoBjf6xgqf1T0q7/dEEBv+RsMp1MU1N5i4zYOXj
         PdOyCmj3CfaXojg/kKdZXbxATNjlC//MT5kW1MiMM3DPeQIShmX+/yAPCItftjRfN9D+
         bFZCTIoC9gSt3vJiAARzsb58ibj8FtF0eiXlBFN/akpqK78muAbzS4/Cx3hmjfEAXyjP
         56dtkMHWvuLGrQYUWVobgGIuxX0Yztegxbeki8NFeKsGopp2QstudLsA07uxjZSwlV5T
         rTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463574; x=1782068374;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+Wwrx8L0mRrwtYy1J+nOna5VRruznj4mw1CTa6ij3Y=;
        b=OB0RWOAHIHQ8M8rKWX6F4stFCxWag7lToJqjZRbmMXrZ2j7BgdfZo+QBKAcVieiMXL
         wL8vGIIb7zGV+fNFII8a+0WCJVlcejkk/lzcpTCuE3B3Z8r/U+lF5Jokq6sbCiQPaQ5z
         1TGv7ZqkKKtB9JwOGNuSFyBYMJG2/A0JFQEg0IZo6MXQCDuz72UPwSMFE9PwcLO6R4Tf
         XEDzBl6nq4QXaf+6eJh0elYasZ3pF8hpBimoMH00dooaI2MWQagq9HEIo+fcXY5L+uN+
         f4S7cMRyzbRGukEvDeVLdcfA2Mo2mOmAJkcyKLYlD6uRL05Hkf+zIdz5gv8fNfa4Rhll
         TgnA==
X-Gm-Message-State: AOJu0YyyUisMRwsKx0yclvbkcVmCFAM+vZ4SxS9zj+XjBKv6NxJtPMNU
	CLuCEAqQyYwGcmGQ+sGMFnrcsPdSUD9wmeRojoeeW/Hhp/C96XMDbqsplyl0Kg==
X-Gm-Gg: Acq92OFafsJhzZbNLiOvitpX2dGJZO41O9yKZmgyUjFvXLrVcry4VYwC/3X0MS1KPkA
	o/7BLdPFxfpksOvpD6yqMmund7s5RDJC29udPikLHzBz17ACpJ6SgEx8qPXWVOwV930sSFsAg4c
	3ZgHEtpDCpmFYrID2m0jObmB7dDNgnH6JK/zedeXNOnk2sSJ3PQ1CiF2zZX/cfqv2PRepCnZtU9
	N9WjiJ21fn4Zo4cGSSL4LTTA2l4VByDShdFJPGQa/iKaupnYGD/ZI15wM7AZ4U8zX51/NMof62p
	D/vtrr2GX2aWhQh/qxi2ycn6ge3UGjhBfT7O2xkaaL3pVnkBUnteoAC3YKRl1xqaJ92b0O6UXb2
	Za7FIH7bPs0NUUZQCIL+HXwspbD6UbugnvsM2r1moCsvbYbarrd9O7s91XIXnUcH/BWa5GJCslm
	izXK20ZRn9BtpxnCM65ZORlM/R
X-Received: by 2002:a05:7300:a10b:b0:2e7:c701:aa85 with SMTP id 5a478bee46e88-30820054ddamr6836179eec.17.1781463573661;
        Sun, 14 Jun 2026 11:59:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0357sm11059598eec.11.2026.06.14.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:59:33 -0700 (PDT)
Message-Id: <3dadafa1bc237f8003fb96f69cf44350e72cc46e.1781463564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 18:59:23 +0000
Subject: [PATCH v4 6/6] blame: consult diff process for no-hunk detection
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

The consultation happens at the pass_blame_to_parent() callsite
using diff_process_fill_hunks(), matching how builtin_diff() in
diff.c uses the same function.  A new diff_hunks_xpp() variant
accepts a pre-populated xpparam_t so callers can pass external
hunks, while the existing diff_hunks() retains its original
signature and behavior.  The copy-detection callsite is
unaffected since it does not use the diff process.

The subprocess is long-running (one startup cost amortized
across the blame traversal), but each commit in the file's
history incurs a round-trip to the tool.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 blame.c                 |  40 +++++++++++----
 t/t4080-diff-process.sh | 105 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/blame.c b/blame.c
index 977cbb7097..354e6c15f4 100644
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
@@ -314,17 +316,25 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 
 
 
-static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
-		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
+static int diff_hunks_xpp(mmfile_t *file_a, mmfile_t *file_b,
+			  xdl_emit_hunk_consume_func_t hunk_func,
+			  void *cb_data, xpparam_t *xpp)
 {
-	xpparam_t xpp = {0};
 	xdemitconf_t xecfg = {0};
 	xdemitcb_t ecb = {NULL};
 
-	xpp.flags = xdl_opts;
 	xecfg.hunk_func = hunk_func;
 	ecb.priv = cb_data;
-	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
+	return xdi_diff(file_a, file_b, xpp, &xecfg, &ecb);
+}
+
+static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
+{
+	xpparam_t xpp = {0};
+
+	xpp.flags = xdl_opts;
+	return diff_hunks_xpp(file_a, file_b, hunk_func, cb_data, &xpp);
 }
 
 static const char *get_next_line(const char *start, const char *end)
@@ -1943,6 +1953,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *parent, int ignore_diffs)
 {
 	mmfile_t file_p, file_o;
+	xpparam_t xpp = {0};
 	struct blame_chunk_cb_data d;
 	struct blame_entry *newdest = NULL;
 
@@ -1961,10 +1972,21 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 			 &sb->num_read_blob, ignore_diffs);
 	sb->num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
-		die("unable to generate diff (%s -> %s)",
-		    oid_to_hex(&parent->commit->object.oid),
-		    oid_to_hex(&target->commit->object.oid));
+	xpp.flags = sb->xdl_opts;
+	/*
+	 * If the diff process considers the files equivalent,
+	 * skip the diff so blame looks past this commit.
+	 */
+	if (diff_process_fill_hunks(&sb->revs->diffopt, target->path,
+				    &file_p, &file_o, &xpp)
+	    != DIFF_PROCESS_EQUIVALENT) {
+		if (diff_hunks_xpp(&file_p, &file_o, blame_chunk_cb,
+				   &d, &xpp))
+			die("unable to generate diff (%s -> %s)",
+			    oid_to_hex(&parent->commit->object.oid),
+			    oid_to_hex(&target->commit->object.oid));
+	}
+	free(xpp.external_hunks);
 	/* The rest are the same as the parent */
 	blame_chunk(&d.dstq, &d.srcq, INT_MAX, d.offset, INT_MAX, 0,
 		    parent, target, 0);
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index df4d08e31f..9fc3c01eec 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -445,4 +445,109 @@ test_expect_success 'diff process skipped when tool omits capability' '
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
 test_done
-- 
gitgitgadget
