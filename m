Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666A3033D6
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463569; cv=none; b=Z2yhW8UD7/VFrQ6UVajYH/Up6xn4QsZ1y9cxoWYEjAcNjI5lhmBNY3M2WTXSEo9UJCMLK4RogFVlKjQnWuU3UUCL4swUFFo/+UrNkWa670nfw/ZsNAxEEB2+SRMthxsu37bj5QAj4kk4TzPI3v6gh/pedn97n9WiIvhqmo5D4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463569; c=relaxed/simple;
	bh=T7fOuBFaLO+c3/fPyQGyefGJRaR0iI4VXvHgojkvRp8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dLgvS3fgKzaC2wpcLYf3uwQdQoHoc5YPSYHNKGTH2/b+LKbmquFxa0f3RKGljJqjxfMAjx7tMX/w2Mgij/JNF2LDuAtyKRJi9k+scZ1A9vlSczFZYM7rrYDZVuIkTlBpUhHvIwu+Sk3o5W55vsy3O8bwThPafxKQz1/UOivpFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfH3I+AN; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfH3I+AN"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304cf518c9dso4086096eec.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463567; x=1782068367; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeFLBHFMauwUpVn7BXxjUkM+RtmgTZ9hmKLYwJBd9f8=;
        b=IfH3I+AN1/qsLhri/1s+lgXXTQig5kpCq6IRW6mRJzg5qRxFJL+0YF1nWufWVNJbAB
         kqi22aui0Z2Pe2OUTqIjPaKOA3q35d93NZTLYG4Ymqfj4aYbvBJexl5tuAnAUG9GvID6
         EzKKESnMJpaqZ3nIMN+ua7MCMVREp0VLJQQ4Vh6N9u4GI+VUrB7DL6/as1NI9r9r5m/N
         KOPLH3bU+StJ3JA97pCsDm6Bv+zQM3Ka1RYdkkTIg8wbhIP4OyCoVKjJnt+7bJeATOOd
         yHYVWlzeww9BauePBgjMpUZ122oPT9/F2l3yZs5IHvJbCyL7twMffim48tjd0NaTJNQr
         RoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463567; x=1782068367;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LeFLBHFMauwUpVn7BXxjUkM+RtmgTZ9hmKLYwJBd9f8=;
        b=NIyb8s8VYKH8HobntrWG+sj/p1phNXRBMXiPV6nTznBugbRHJbfAmIr2y9fUIyzvJf
         meijrFu7PB2pahy5A5lp/Y0pW+biHC6zu+zB5I+zbnqRmT9Th9OEXutCsKvpr6OCjaou
         o+EpVkWw3f1koqZ+A/BxAjonLQ8tMqmWKeQSJWN1Ty6wVc1oDHWMY4sceo/R3kkFrb10
         WUmMd/MFBoCQPqnfBHIWLMv4eEaGtdA8ealA1VrdK+U6Fw/Yf1hmNniB8T66/r98syku
         WiN1VCRpTIw+020q9aIfcrD/YJQNRZdNdHZ+PshUCLxA8J7pldfp6ll4EqMQGWDOT67b
         0Q/A==
X-Gm-Message-State: AOJu0YxWTDOPKMP4mu7W/KluZJZ/GG2eBm8RfZglE/Mt1KxW9TdIh65J
	XvqKv4+gc/HxKfbe1DSX0TQrguj7k5IlvsREnv9JfCXRw+j8eVY5dVZfYc/yMQ==
X-Gm-Gg: Acq92OGYABfc5B5Ll2lZazKsjH8MvnzZm/AuKU1rY1+KkgrHsLcvANm+qP3NfqG9CYq
	P5B0f7y0SvRk/08eTjPzzTp8qB4alPxo9FDoMasBzAzSGPWxDhTkhzNOQFK0Sm4i/KYYrzcoWOn
	nQsb5zGX2lCFCSMQ7+JdkzT/DgyrCs/HXsDpdnj4MftnU209DAIVFbtiBrC16iuvla7qgjWMMmF
	BQd7W+2aSh2luqAu8VHJQyotYwMggdXz0jUTt5dfT7SYpjVLziQMzOiVcby4fJ8dIwB9F4luPPO
	871UrVUDNcW9ArOeMy8NSUg/nYGUv2nLAx63SnMYuTCPUDXIhtT8QABZII6g3ZZDFMF90Um2/7X
	tDcMZslLMVEYZHPBwHCvyCXmioDLn91zztM+/29xTuCZmv7fBzURoziWuTOlvpnZU0/CYgCY7Uk
	YsgvmP27e0hWaxJau05x5HTHmU
X-Received: by 2002:a05:693c:3742:b0:307:26a3:75d2 with SMTP id 5a478bee46e88-3093551c319mr4557078eec.7.1781463566930;
        Sun, 14 Jun 2026 11:59:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm11773286eec.5.2026.06.14.11.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 11:59:26 -0700 (PDT)
Message-Id: <03f261dfe2ed68194866f286c336db358861d7d5.1781463564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
References: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
	<pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 18:59:18 +0000
Subject: [PATCH v4 1/6] xdiff: support external hunks via xpparam_t
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

Add two new xpparam_t fields (external_hunks, external_hunks_nr)
that let callers supply pre-computed hunks.  When set, xdl_diff()
populates the changed[] arrays from these hunks instead of running
the diff algorithm, then continues through compaction and emission
as usual.

Validate supplied hunks before use: reject out-of-bounds line
numbers, overlapping or out-of-order hunks, negative counts, and
violations of the synchronization invariant (unchanged line counts
must match between files).  On validation failure, fall back to
the builtin diff algorithm; this re-runs xdl_prepare_env() since
the first call may have dirtied the changed[] arrays.

Skip trim_common_tail() in xdi_diff() when external hunks are
present, since external hunks reference line numbers in the
original content.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 xdiff-interface.c |   7 ++-
 xdiff/xdiff.h     |  14 ++++++
 xdiff/xdiffi.c    | 123 +++++++++++++++++++++++++++++++++++++++++++++-
 xdiff/xprepare.c  |  10 ++++
 xdiff/xprepare.h  |   1 +
 5 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 5ee2b96d0a..76a24fc589 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -124,7 +124,12 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 	if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
 		return -1;
 
-	if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
+	/*
+	 * External hunks reference line numbers in the original content;
+	 * trimming the tail would change line counts and invalidate them.
+	 */
+	if (!xpp->external_hunks &&
+	    !xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
 		trim_common_tail(&a, &b);
 
 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index dc370712e9..dd4915fe16 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -78,6 +78,16 @@ typedef struct s_mmbuffer {
 	long size;
 } mmbuffer_t;
 
+/*
+ * Hunk descriptor for externally computed diffs.
+ * Line numbers are 1-based; a start of 0 is accepted when
+ * count is 0 (empty file side, matching git diff output).
+ */
+struct xdl_hunk {
+	long old_start, old_count;
+	long new_start, new_count;
+};
+
 typedef struct s_xpparam {
 	unsigned long flags;
 
@@ -88,6 +98,10 @@ typedef struct s_xpparam {
 	/* See Documentation/diff-options.adoc. */
 	char **anchors;
 	size_t anchors_nr;
+
+	/* Externally computed hunks: bypass the diff algorithm.  Owned by caller. */
+	struct xdl_hunk *external_hunks;
+	size_t external_hunks_nr;
 } xpparam_t;
 
 typedef struct s_xdemitcb {
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index c5a892f91e..bf820b52e3 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1085,16 +1085,135 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 	}
 }
 
+/*
+ * Populate the changed[] arrays from externally supplied hunks,
+ * bypassing the diff algorithm.  Validates that hunks are in order,
+ * non-overlapping, and within bounds.
+ *
+ * Returns 0 on success, -1 on validation failure.
+ */
+static int xdl_populate_hunks_from_external(xdfenv_t *xe,
+					    struct xdl_hunk *hunks,
+					    size_t nr_hunks)
+{
+	size_t i;
+	long j, prev_old_end = 0, prev_new_end = 0;
+	long changed_old = 0, changed_new = 0;
+
+	/*
+	 * xdl_prepare_env() may dirty changed[] via xdl_cleanup_records().
+	 * Clear them so only the external hunks are marked.
+	 */
+	xdl_clear_changed(&xe->xdf1);
+	xdl_clear_changed(&xe->xdf2);
+
+	for (i = 0; i < nr_hunks; i++) {
+		struct xdl_hunk *h = &hunks[i];
+
+		if (h->old_count < 0 || h->new_count < 0) {
+			warning("diff process hunk %"PRIuMAX": "
+				"negative count (old=%ld, new=%ld)",
+				(uintmax_t)(i + 1),
+				h->old_count, h->new_count);
+			return -1;
+		}
+		if (h->old_start < 1 || h->new_start < 1) {
+			warning("diff process hunk %"PRIuMAX": "
+				"start must be >= 1 (old=%ld, new=%ld)",
+				(uintmax_t)(i + 1),
+				h->old_start, h->new_start);
+			return -1;
+		}
+
+		/*
+		 * Range must fit: start + count - 1 <= nrec,
+		 * rewritten to avoid overflow.  Same for both sides.
+		 *
+		 * When count is 0 (pure insert/delete) the check
+		 * reduces to 0 > nrec - start + 1, which rejects
+		 * start > nrec + 1 and allows start == nrec + 1
+		 * (the position after the last line).
+		 */
+		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1) {
+			warning("diff process hunk %"PRIuMAX": "
+				"old range %ld+%ld exceeds %lu lines",
+				(uintmax_t)(i + 1),
+				h->old_start, h->old_count,
+				(unsigned long)xe->xdf1.nrec);
+			return -1;
+		}
+		if (h->new_count > (long)xe->xdf2.nrec - h->new_start + 1) {
+			warning("diff process hunk %"PRIuMAX": "
+				"new range %ld+%ld exceeds %lu lines",
+				(uintmax_t)(i + 1),
+				h->new_start, h->new_count,
+				(unsigned long)xe->xdf2.nrec);
+			return -1;
+		}
+
+		/* Ordering: no overlap with previous hunk (adjacent is OK) */
+		if (h->old_start < prev_old_end ||
+		    h->new_start < prev_new_end) {
+			warning("diff process hunk %"PRIuMAX": "
+				"overlaps with previous hunk",
+				(uintmax_t)(i + 1));
+			return -1;
+		}
+
+		for (j = 0; j < h->old_count; j++)
+			xe->xdf1.changed[h->old_start - 1 + j] = true;
+		for (j = 0; j < h->new_count; j++)
+			xe->xdf2.changed[h->new_start - 1 + j] = true;
+
+		prev_old_end = h->old_start + h->old_count;
+		prev_new_end = h->new_start + h->new_count;
+	}
+
+	/*
+	 * Synchronization invariant: unchanged line counts must match.
+	 * Otherwise xdl_build_script() would walk off one array.
+	 *
+	 * Count changed lines from the arrays rather than accumulating
+	 * during the loop to avoid any overflow in the summation.
+	 */
+	for (j = 0; j < (long)xe->xdf1.nrec; j++)
+		if (xe->xdf1.changed[j])
+			changed_old++;
+	for (j = 0; j < (long)xe->xdf2.nrec; j++)
+		if (xe->xdf2.changed[j])
+			changed_new++;
+	if ((long)xe->xdf1.nrec - changed_old !=
+	    (long)xe->xdf2.nrec - changed_new) {
+		warning("diff process: unchanged line count mismatch "
+			"(old: %ld unchanged, new: %ld unchanged)",
+			(long)xe->xdf1.nrec - changed_old,
+			(long)xe->xdf2.nrec - changed_new);
+		return -1;
+	}
+
+	return 0;
+}
+
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
 	xdfenv_t xe;
 	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
 
-	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
+	if (xpp->external_hunks) {
+		if (xdl_prepare_env(mf1, mf2, xpp, &xe) < 0)
+			return -1;
+		if (xdl_populate_hunks_from_external(&xe,
+						     xpp->external_hunks,
+						     xpp->external_hunks_nr) == 0)
+			goto diff_done;
+		xdl_free_env(&xe);
+	}
 
+	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
 		return -1;
-	}
+
+diff_done:
 	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe, &xscr) < 0) {
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 11bada2608..f4ab935332 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -471,3 +471,13 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 	return 0;
 }
+
+/*
+ * Reset the changed[] array so that no lines are marked as changed.
+ * Also clears the sentinel slots at changed[-1] and changed[nrec]
+ * that xdl_change_compact() relies on during backward scans.
+ */
+void xdl_clear_changed(xdfile_t *xdf)
+{
+	memset(xdf->changed - 1, 0, (xdf->nrec + 2) * sizeof(bool));
+}
diff --git a/xdiff/xprepare.h b/xdiff/xprepare.h
index 947d9fc1bb..0413baf07b 100644
--- a/xdiff/xprepare.h
+++ b/xdiff/xprepare.h
@@ -28,6 +28,7 @@
 int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		    xdfenv_t *xe);
 void xdl_free_env(xdfenv_t *xe);
+void xdl_clear_changed(xdfile_t *xdf);
 
 
 
-- 
gitgitgadget

