Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AD3ACA60
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087706; cv=none; b=l1O9pq+wUoZeFRALmOzIezArKn3ELiV5jISY5BkQ5HRaWvuQuRm9xce46C7INxiHMX4y6OkkV3N7Ge0zbCABDsuvd+hMJ8MI2c7z2XR07G4i8b+fWJKL2lKOTEr2V6Nv5oHaE7gN74b1+3flkpWs+y5xsx0JtRJyQffhQ9/ix+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087706; c=relaxed/simple;
	bh=ozuB2lYYrTV6QxONATdLk1zjHUAt+OoXbr5T0nu+8Io=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Us7D8jUy1+H1pWICpr0hhcz3jA2wE9FBF3RmxDRwVtbVLY80WRxl17mESRkTpWdCiM2r8n7EueNRURjQwwcNQnnYYniDdY219pm2Mt8U41FP6jYzgh7lFJzlDiZEfkh1zgFVNuyMtRBd032Q7La1epRdkvWqGILyceq9uPqHk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezr9K2IZ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezr9K2IZ"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304ec41197bso1114442eec.1
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780087704; x=1780692504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfBgHFqqO8LTEK7IvaH6EJ7l4+BWH/zPmtz/JBIoMr8=;
        b=ezr9K2IZbBDT2F+tdTF96l3W54k+LQBFbGyXUWMJvRcQZgKU1scwJVCUuNIaU1kAvE
         Ml6g0vfO3rkYXlnJJOi8vqolUXF7et3Piyr9sbY6PTMWa28pD7lowRcxbEY4iALbeUOq
         zbekzLRUe3geB9VIBYEnzImuHSVSUJ+bBIbhvROmA3LhqryMgmOZDHfocq6cVXWwD6F3
         IRiXEUzWoIZQ1rQwUCIQv6svVEbDGNpiMXFGZqGMddSSJWqS9198TRoZ6kOI5Xpa6AxJ
         4h87qwtASiBlEkbfoUtvBw5/kfcFWGeWP3hz5i9Ke3OtdYfy3iSivdoZKAnXxRKK+DDl
         4ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087704; x=1780692504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfBgHFqqO8LTEK7IvaH6EJ7l4+BWH/zPmtz/JBIoMr8=;
        b=DVHaNwhq44cDzTG7Vds0vkw8ihjxubAg4IYq/dsTffy64+T9FDQDZEPxV9UCpVwXDH
         pknImSweiEPOvu/Xo6rEgmYtzyQE4bZSSDJw1Y+sY82MJQOMg14A/9nTRroOsE8/dR5T
         DOvF6+z2Ky3FLp4qj5ltq17EhvplOcmfkPkprgM4WOE1mF5uG3irAzrxwVHXA7ETeZvW
         D6lgVfVDRP1SDQz3xDFmsZBNFWvCOO4EdLbmOAa9IhNjUigNu3hGK9S9A1qkKrivhbPn
         BOlrCJo9o8BE8kMJSrgrkSvWKBl9ms6CMrRUCaHudGbqzgLvctwr/h6o30UFI0gCU4HW
         nVeA==
X-Gm-Message-State: AOJu0Yww1HgP9dOxU0tys+4cJqzvEC1z1eqwZAkm0UMFZ/HMQCh2pOZH
	va90U6ownEP4Yso9wM0Y6Vpd/z2Yk7giXLIYPq/5nNV0ZeNsra21aDbssULx+Q==
X-Gm-Gg: Acq92OE2JUrkbjW7aLDAIG/OW74woIddT4o9IfLTBL2j3LvHiX3+PuX9PZBlSaAVlPA
	P+Nc9FRz/swYPac9E6do2PdxsYRc/ud5i/JSojhAALBNEWMy625Qgok/kfkPMEP1mVCm9Nr+ELh
	Fv232xwfWy5LTjm3jB6iHYrN/LoAeOo9Tu3gWeTNP5rDyciXQLtSNNYStPWpAvA+cr3y9PMDULv
	mO8sknkb/Bgn+jpn0GNY6DSf9kzP9gYfqdeclkksbbGcJUeQ3JGJpNDfVjJojMsKoeIBg98Chl4
	xZsytWo4yBcCU3MpepOuvQLlFR/WnO4FJAvN2i8KnO9pECaFrGS+IEnv6qW0jlX41KqKieznYhj
	8HwO0lxwCXrz0I4gU1FrsPdDphQfDPHXBozzdxJlGaM66RYX4+b0GKlpp7uOLfS6h9QYCsDHVAT
	vhiJeVyhUu5XObUkHWWEuftkUGgv2FD9/NrYLAf1P672sby301
X-Received: by 2002:a05:7300:a944:b0:304:8870:2ac5 with SMTP id 5a478bee46e88-304fa52647cmr694815eec.6.1780087703951;
        Fri, 29 May 2026 13:48:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm2330728eec.28.2026.05.29.13.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:48:23 -0700 (PDT)
Message-Id: <13eb201d635164dc0f3eefd7244df5360a169e42.1780087700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 20:48:14 +0000
Subject: [PATCH v3 1/6] xdiff: support external hunks via xpparam_t
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
 xdiff-interface.c |  7 +++-
 xdiff/xdiff.h     | 13 ++++++++
 xdiff/xdiffi.c    | 85 +++++++++++++++++++++++++++++++++++++++++++++--
 xdiff/xprepare.c  | 10 ++++++
 xdiff/xprepare.h  |  1 +
 5 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index f043330f2a..9542c0bcc2 100644
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
index dc370712e9..a7e8502e4c 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -78,6 +78,15 @@ typedef struct s_mmbuffer {
 	long size;
 } mmbuffer_t;
 
+/*
+ * Hunk descriptor for externally computed diffs.
+ * Line numbers are 1-based, matching unified diff convention.
+ */
+struct xdl_hunk {
+	long old_start, old_count;
+	long new_start, new_count;
+};
+
 typedef struct s_xpparam {
 	unsigned long flags;
 
@@ -88,6 +97,10 @@ typedef struct s_xpparam {
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
index 5455b4690d..b0a01ca856 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1085,16 +1085,97 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
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
+	long total_old = 0, total_new = 0;
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
+		if (h->old_count < 0 || h->new_count < 0)
+			return -1;
+		if (h->old_start < 1 || h->new_start < 1)
+			return -1;
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
+		if (h->old_count > (long)xe->xdf1.nrec - h->old_start + 1)
+			return -1;
+		if (h->new_count > (long)xe->xdf2.nrec - h->new_start + 1)
+			return -1;
+
+		/* Ordering: no overlap with previous hunk (adjacent is OK) */
+		if (h->old_start < prev_old_end ||
+		    h->new_start < prev_new_end)
+			return -1;
+
+		for (j = 0; j < h->old_count; j++)
+			xe->xdf1.changed[h->old_start - 1 + j] = true;
+		for (j = 0; j < h->new_count; j++)
+			xe->xdf2.changed[h->new_start - 1 + j] = true;
+
+		prev_old_end = h->old_start + h->old_count;
+		prev_new_end = h->new_start + h->new_count;
+		total_old += h->old_count;
+		total_new += h->new_count;
+	}
+
+	/*
+	 * Synchronization invariant: unchanged line counts must match.
+	 * Otherwise xdl_build_script() would walk off one array.
+	 */
+	if ((long)xe->xdf1.nrec - total_old !=
+	    (long)xe->xdf2.nrec - total_new)
+		return -1;
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
index cd4fc405eb..4645a9a746 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -432,3 +432,13 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
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

