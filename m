Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C660355F41
	for <git@vger.kernel.org>; Mon, 25 May 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733805; cv=none; b=eTB+kqrt97e0NRQAUgO0aYEkWbw1DZyR8QOTAtvLsEHfyq4hfFAC8ohpIgbYMUsMtY9gyK5v0/aXYQSLNLTQuDY4nImvY1CMS7B2JrkP5WlyRmg2PkmV+RqljCJVO/0JyEb5BfWSdIOS5uu8/V93+R8juhW35mLEOxnB7fY71rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733805; c=relaxed/simple;
	bh=+KlFAxEwfZABuPepgFUWCeD1DZaBiKhx+zd18LDghoU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JBKsPMI4l078vhK+rZBUmUT5oakmeXamIas0NnsL+6E1f1hisdkXYkbIjd+gcrU1ITLTCzQgoXvIWguvjXEI2tGR5k3vic2IuWhXG79J45jPsRguhnOVqtdFFestyUbMjBAp3YDWO1G6uOF4U+aPGoxQuLCBTXzv9+fcTc85KWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlD3LxL8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlD3LxL8"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914bf787977so254840685a.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779733802; x=1780338602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sq803nh+tOyCTQWWUjln8JNn5m435fdB34a3N/lv78=;
        b=mlD3LxL8aiLTEuSU5yUWCBJRvRy3yceKyD4z6WNAgcJVSX6ko5+AjFEhrooPCda2ii
         EXwGE3J0tgs1h311xJVyNlE22Z49J0x284X7C8bbwkxA4LVj77xYbV4Drjv5SG+wbx1g
         enTxbuZVEHK48Pb8qQntBWU1U/rPtOmCsusOTm3bFFwH8hHt951mvAGJQ37mVbZY9XZt
         bxRi3yqA+0MmQO1RdAZnwHq4C6zq3ke51WQcyoZAOi7hBwnrOiK47ClCeUTXQ1FlM3BA
         6YvOCUxy9QzYvVV2/Y66geBw81YVH/1v+zSPG0N6BKICXfv7RpY7+lcZLOrQHEadYOrb
         HJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733802; x=1780338602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sq803nh+tOyCTQWWUjln8JNn5m435fdB34a3N/lv78=;
        b=k01FmG2apGaBI8/FiXEZuFn/82fH5xR6siK++Qr2IWph7B4B5FU+XspcbQHkxnP2Hs
         GK/QuztYgUWawSnezTNXRJMVuBTIGS9RY8+MOLEjMQL8PHA89rg484e3Vg4C0WXMW4u4
         Tyi3j2BYrkTloFoCDxLC+g0mVkchpHpvX11hrxGnd9ijATO1hI1TYk7+xqbQSJ9Jcdnc
         f5xHmR4rx5f1QzwrRLJtVigAgL6iu3XeigQWYEjAyMDl+GkIv+hG3KTlEoKO79gNjKqL
         cXLzXQDJYuEw79cVtljzfc+sWCQblN3FKmkapsPfT5VKxwQhesoO77qe21yJ5N8umIGy
         8DPw==
X-Gm-Message-State: AOJu0YyaA2KUg8HtXN923h70Fx7YI4bYZiQADnyWKFj1wZTsgTlAU4Fz
	JuCsq8ncJFCUD9VcdBKSvUQse1TunnPBDmZSkQYomx148/w/7A0b8JrpOrn05x0r
X-Gm-Gg: Acq92OF11waVQk1ENyAy64yRBEN5J1dHBmU8MCx7N7eZX7Syclbbpj/zP7iNjPtpO2c
	dhtSA/htTZ5fOl9nEV2yFGHTBwyaMcl33seEtcC9N/ZuK5tSX3m+jIVnZBIOeHVkSy6kXrTgvsm
	QBaNQm0PZY7CJaIjFtV0ghJrUGQUX9/60AKVgCqvS86CxR7BK2d00oOJ3BRKjfCYYhfhUBiKWaM
	nNHUaoTDbaOQOM964tZlR+lGgIYjM8BYm67snt6ylerUMrP+KiWKs8rArvrEfmTQwZC7pQ77YqR
	+TYKGyHG6I03KCMJXzhuqCtAZY3x/1UJBwLIgwcgE4AX1x0IZHq1TSPVufdbX0ylsDV3J4GQ+Ky
	EwmgCRhfxTO8DdoBDv177/KfeY6sAUIKfpozcwk53ho0yWM9RvvQTMj5CyL2lb3Ho7F+loezebf
	x4qayxlrZ0F2QJVVNn2SHmmYZotac=
X-Received: by 2002:a05:620a:1a1c:b0:910:4e35:cf02 with SMTP id af79cd13be357-914b49ca211mr2342108385a.37.1779733801918;
        Mon, 25 May 2026 11:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.180.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba1b8f4sm1085682985a.45.2026.05.25.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:30:01 -0700 (PDT)
Message-Id: <f887a7e2ba697b6a2aa77319ed92cf4009f46871.1779733799.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 18:29:55 +0000
Subject: [PATCH v2 1/4] xdiff: support external hunks via xpparam_t
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
the builtin diff algorithm.

Skip trim_common_tail() in xdi_diff() when external hunks are
present, since external hunks reference line numbers in the
original content.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 xdiff-interface.c |  7 +++-
 xdiff/xdiff.h     | 13 ++++++++
 xdiff/xdiffi.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++--
 xdiff/xprepare.c  | 10 ++++++
 xdiff/xprepare.h  |  1 +
 5 files changed, 112 insertions(+), 3 deletions(-)

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
index dc370712e9..2ee6f1aae3 100644
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
+	/* Externally computed hunks: bypass the diff algorithm. */
+	const struct xdl_hunk *external_hunks;
+	size_t external_hunks_nr;
 } xpparam_t;
 
 typedef struct s_xdemitcb {
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5455b4690d..e7d6190d37 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1085,16 +1085,96 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
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
+					    const struct xdl_hunk *hunks,
+					    size_t nr_hunks)
+{
+	size_t i;
+	long j, prev_old_end = 0, prev_new_end = 0;
+	long total_old = 0, total_new = 0;
+
+	xdl_clear_changed(&xe->xdf1);
+	xdl_clear_changed(&xe->xdf2);
+
+	for (i = 0; i < nr_hunks; i++) {
+		const struct xdl_hunk *h = &hunks[i];
+
+		if (h->old_count < 0 || h->new_count < 0)
+			return -1;
+
+		/* Bounds check (1-based line numbers) */
+		if (h->old_count > 0 &&
+		    (h->old_start < 1 ||
+		     h->old_start + h->old_count - 1 > (long)xe->xdf1.nrec))
+			return -1;
+		if (h->new_count > 0 &&
+		    (h->new_start < 1 ||
+		     h->new_start + h->new_count - 1 > (long)xe->xdf2.nrec))
+			return -1;
+
+		/* Zero-count hunks: start must still be in [1, nrec+1] */
+		if (h->old_count == 0 &&
+		    (h->old_start < 1 || h->old_start > (long)xe->xdf1.nrec + 1))
+			return -1;
+		if (h->new_count == 0 &&
+		    (h->new_start < 1 || h->new_start > (long)xe->xdf2.nrec + 1))
+			return -1;
+
+		/* Ordering: no overlap with previous hunk */
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
+
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

