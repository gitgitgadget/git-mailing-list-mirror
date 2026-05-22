Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA3195811
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415890; cv=none; b=o5rEIKVCCKferAcIOvo7dahqZyd5ltMhKnK4D8MDoik4YRX2V/qHq+d6Xs3qit6Vshe0F1L4hJrr5JE2OsYLPFaGOhCE78frYPLr6zBMLwipKJh2aku7WbOMuu3VlZnLLKXbe62rpili7Oc6V6MwUhSrnFstL+8DFW+gxEbdbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415890; c=relaxed/simple;
	bh=neAPdxREKR/NrCkeuz4AqxNZH7gjeuRZZXbNtWXmIpQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S0d4/d8WTFFU0ygxDknFrlXMZLJN+gHSI71vOsL4p1S9I4egRqL3BNzbJ9T1b4IG/jUoEw2BJhCYaohvqYifQgvnsgitk4JU2k0XdUvyQAcEdgr6zqLMS0FFyWoQVpjM9yclVuw1B5T1Qk7Um1vZpCunvscg1o5t/6koMQHWjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tB8eELN/; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB8eELN/"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-910bb291688so822385485a.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779415887; x=1780020687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V56qFdgCJvrAcbnw18TNSXhBHGTqfq+H+2UwWvkXtXg=;
        b=tB8eELN/7FmB/yC1v8BlVus3n//+E0AGlBXrPZwCPQovMMBBy0hEFbBhs8oR66ahCz
         OOYhIpZqCbUkkp3QaJiFi/j3qCHlu94lqqchEvO86Vi7dMRc/ggi95TeZo3wOKeByp7Q
         DpnjfLHARTPsTos09S3SlbBmkKaovu02ZI59jJPbOIs6IG9yDflRO/Ze6/Hx1awy2cjy
         eqThIW6yUFm6ThOhb5g32FcMzdR8TFTt9WaCrGHGkzIvUxYjVs5cfT9RW22jn9v9apZG
         zzZAn5wqrnxVrdWQLYUwucekOGKA6bljm99JkzxsyoBVFYzQoOEX+8JCrt8A30Z75/j0
         m+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779415887; x=1780020687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V56qFdgCJvrAcbnw18TNSXhBHGTqfq+H+2UwWvkXtXg=;
        b=AqjWPNNtEMsLHoQuLIENaNimlPOs+yXkBwSpBGizl6loQWlS5Ywj2JlRUi9oupz9mv
         JvAHDUdPUg6j9vf4tExf62uoolgMrwYDqOPFrb4F0Wk7R+0tzWwnguLwIx4K/xszULgY
         9+jPxfOElKq6EU/FJm+b/szBzEf1CR7say9IeCk/tGqNeZHnpQiyelX87CbMCf2KPFGf
         ezhoYxd9Lpdhr+fEl3O6w+b2d7093RsamtpFuhTGAdxh9alcgyG7uzJw/wI74UCWlhwE
         5Dwb0rLisg+lbnVQUySgFJ/k/YnizrEgY1/5P5zAFSkeFEo+7pBY1Fjp4n+bO9cH4lto
         1ghw==
X-Gm-Message-State: AOJu0YzzJhK2bNWGbt0assORtloto3tn7LSIZ6/u/5WmScAVwF7vG9+P
	YU3wdLOPQoSBeZlEdBvJhyDPIvocVxXtfrbAEoc4jfK1emSPIHx9+n4kHzMNWg==
X-Gm-Gg: Acq92OHOjx/IBKYsjoGevQlI0oRW1T4sPqpME3TKJ/Ez6BZOS67tXc4tQ5jkrz4teio
	VJQvVgHag2HgaU5OXESlRpVErlDOWInM4kSj8U4b4NIXXohkhiMXmvRIF5MufhAy2dizMmjpgNP
	N8BPjfaXElOOr5bDRZbITRyB43EjQJ3SNQLHHFBZ+aZm5Bh0fEFRbeBmLqGQ/UDUnGRAOGVRiP5
	g7+ZRSOEU1KANJ/9U5hwYNGhMBc1hWiNmjralir9mnLldbPpbL51Aza8YvvvYhQXRraB4RrQBBL
	QH99rksSzliKUfK/Ui7JKiIP+qWK8MV0ftrtveciKAxr3A0O+vzJ6EH38fgIxs5jFmGzHt3zCck
	dgJO4ZMRYaWy9MWLzdaLYPCMeOODyBJC7cIrS1X1CcoDV8nIUMS5Ehbad8uFZxkUHz5Xb6mhK9x
	dPU7gS8epZ0OgIJFpStX+x7al4Fe8eUV8tecI=
X-Received: by 2002:a05:620a:4806:b0:8ef:74c9:daa7 with SMTP id af79cd13be357-914b491222emr280478685a.8.1779415887555;
        Thu, 21 May 2026 19:11:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b604e302sm65731985a.43.2026.05.21.19.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:11:26 -0700 (PDT)
Message-Id: <8c0ea0bc0742651e634db7a3002e8cbe1240acf9.1779415884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 02:11:20 +0000
Subject: [PATCH 1/5] xdiff: support external hunks via xpparam_t
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
 xdiff/xdiff.h     | 13 +++++++
 xdiff/xdiffi.c    | 98 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 114 insertions(+), 4 deletions(-)

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
index 5455b4690d..7eca4ab4a1 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -1085,16 +1085,108 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
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
+	/*
+	 * Clear changed[] arrays.  xdl_prepare_env() may have dirtied
+	 * them via xdl_cleanup_records().  The allocation is nrec + 2
+	 * elements; changed points one past the start (see xprepare.c).
+	 */
+	memset(xe->xdf1.changed - 1, 0,
+	       (xe->xdf1.nrec + 2) * sizeof(bool));
+	memset(xe->xdf2.changed - 1, 0,
+	       (xe->xdf2.nrec + 2) * sizeof(bool));
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
+		     h->old_start + h->old_count - 1 > xe->xdf1.nrec))
+			return -1;
+		if (h->new_count > 0 &&
+		    (h->new_start < 1 ||
+		     h->new_start + h->new_count - 1 > xe->xdf2.nrec))
+			return -1;
+
+		/* Zero-count hunks: start must still be in [1, nrec+1] */
+		if (h->old_count == 0 &&
+		    (h->old_start < 1 || h->old_start > xe->xdf1.nrec + 1))
+			return -1;
+		if (h->new_count == 0 &&
+		    (h->new_start < 1 || h->new_start > xe->xdf2.nrec + 1))
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
-
-		return -1;
+	if (xpp->external_hunks) {
+		if (xdl_prepare_env(mf1, mf2, xpp, &xe) < 0)
+			return -1;
+		if (xdl_populate_hunks_from_external(&xe,
+						     xpp->external_hunks,
+						     xpp->external_hunks_nr) < 0) {
+			/*
+			 * Invalid external hunks; fall back to the
+			 * builtin diff algorithm.  Re-runs
+			 * xdl_prepare_env() via xdl_do_diff().
+			 */
+			xdl_free_env(&xe);
+			if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
+				return -1;
+		}
+	} else {
+		if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
+			return -1;
 	}
+
 	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe, &xscr) < 0) {
-- 
gitgitgadget

