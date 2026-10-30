Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382006;
	b=sW0X7jHtwy5wnTMzmoDRaJNQdbjvlIqFZH1GgHaJUpM3fUIvncWf9Wr/8evpC/CvUES5
	 CRZ0u1PUt4eYUOI+0QNRZo2QIqSEW2m/+XUcAS4VGNsPzlo403XD1ccNI8dBGVLGwoIB1
	 G60XmDcuk4SdrhiVfdRyZYt8t8ZH98esb/QpfYDuGrDaqRp7/uzGD9HVvJgGNfAkxr2dC
	 kFi04mvO7xxYqbdRd6nvPg9JWMluogSymcSsZ3lPKCPdN3K1tMDXnHjQVBuv5gwDC7y3d
	 jN0NkuouWh0AeZWgMjgTcKPQScOz2/jgGdGvrtaMIYUUlZFXqpW4LeLpurZumfM5A6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382006;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=eoSOTpUKcefW7qoI4fU15HC/AjbUoGnlZWjMAK6yMM4=;
	b=wmP70glutImQyfZbNirJV2M65HRNzT5uVKH2afZzUOZGUQ5wVT3F2/AvVh1+MF/nWiKK
	 IlbJNEcitMG7yWDwXF0C0tVKMDdPIhbq14lh/gzK+kGu3zbb9t43A8coS0IY/CMRPF2rS
	 TF26fBaxZ+3/T1wJkPN/VQo9oFXOSKmyLqVxo7oWQ/QqBMvUU/MZVGOX7XIj9BsUCSa03
	 VuRAWIo1mIJiWrCAPwhvaL5iOG8+95lf8KXGWSf88qAzLqyl6Lh/T9tD1QtCDQDUmnde0
	 g5Ukf1BON4x7nlemnUYFOVuxvqFsPBpDViVwjPHa/R5VBKU0T1dwhPfDfHuRza2yKDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oY5jsRje;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=diuxM4Gk;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39F606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC39F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oY5jsRje;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=diuxM4Gk
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 01D181D0000F
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:40:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 30 Oct 2026 13:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793382004; x=
	1793468404; bh=eoSOTpUKcefW7qoI4fU15HC/AjbUoGnlZWjMAK6yMM4=; b=o
	Y5jsRjeAm47ySpwPQd8ERL9gAWlPgoXX+IGXBJFdE3264Lixf2zhP18Nb5iQBBTg
	Px/q85wCz4Jj0fqzfpDxVHedpkDFHxA5W8eglzPNQlscsExeSeExE8awc/oxdEON
	VzJ5iPH9SXshy3hY2740QATiWcILQHFDBJ22j3nUSguKJnSrnUIzv7ICjUPR24X2
	KBkYn4As6grJqtgIwWogLq4s7/cDqGWtugYRhp942y2Cd04+2do/JSQbdZPRTShY
	Fck/UQ1iNb1mum0ubQhgLz5ge7TmaWPSLBkwnlWJWMfYMm2U46PKWJFAE2doPvBk
	nOvcAh+nxihCtYruGLDnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793382004; x=1793468404; bh=eoSOTpUKcefW7qoI4fU15HC/AjbU
	oGnlZWjMAK6yMM4=; b=diuxM4GkC3jK/YbLVeymA9qaJmHOHp8tXDtOtEumiOFV
	pN6zqJcAMBdyelv86BMmHzhlax0uGxl048zWEx3/+su3/CA6IOxpMcw9sCzWVhbv
	Dj4cthElFcXQnf9WyBB+Sh5ttTXsUmV2r1fNmPdrL2+pJlq3TzB7+kyajH3ciDkc
	uRS7I5CpS1L1LDh/EvnfzAMX4KvgTuH82IpYtU7ezwt4w6u8ksLmhn8F713ODu32
	ab5TNXnaG3hoNUTfbQtShEus93J8qTMrsbCkxtdEP5owf+EjqJxwD19iFmSLf7PR
	1DUoxcilEYmRIHHf+zZgtxTM6CXEGLJG/UDEjb04YA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793382004; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dnDKPSzNZGQ1Fk4Frz4sfODAcg90NeWTO5C27/I367AlkZH
	xRpOgEhxZdj2VZV1MOAwicpjlInXiu4I8BHTE0YoBPzO7O+TVMx8sbWTLZL7S8Ma
	LU2gGL7zVIkGoap8pFhB1E32KLs2DedJmA6m93PViRo9WXlXs/wFy1gHn4AgGnM8
	7XVd8jLHc2q8T8YhItmmE4IUo5k+lbnDENE2EpZ/u0bCDHBdJ4h9/TjRbjUEkzEE
	C5c+SPHeStS+WwbL1MhvAWMYCT+0VRqGSJZjd4cjHI+gL25N8ptfJ2Sei0pOmNmE
	qfW1ZrPzXH/+KfbjaLAV95FRPR72/tyJmShJf7g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PhdD6ZGom6SQaDzgOrcKFz6AA+AjTQY1ibeBJiskd0Q=:bZalOJi1K+9blmUvKe//DTCtD67/PR7siN1BAZsQxqw=;
X-ME-Sender: <xms:dNbkamwQNU_bGA5ZV5J4u2nOTB26ZNB7frgulR7iZUDAiTcM7SIzRA>
    <xme:dNbkaoSlfArlUIMs8JMeQCApm5bIo1ILfRnzVlW_5aVPgbAB20GsDdinlCtlOxkAp
    6PYWmJhetoA3AR7ZA4HdanSgA0Td9FQ_5iSSRIJ-35w-fNJFhlO4A>
X-ME-Received: <xmr:dNbkal8HwLUNmWwD2JDYpgCGHkmTXNgVwJuQoJIrkr6YOpM4c8W3h8CHuu41BpukvJlx5QyqcJWyXqQgReJDF3EbpwupjGTFiaJl>
X-ME-Proxy-Cause: dmFkZTES3TQjvhT6JGxcQNqra5Fje/GmahBRK2K5UBap7web+fxi8llJ2UQwMHhz4o0Wk4
    u1gSVYlNvxziRqdWFFEdVU0gnOBvfSNDKg7b8p1KwZVlp/wx+Rligg3XtLOsnRLHNisBPJ
    R319bxIG4V5vfZhBJ9sIoZvBMJKa9fcJW0AxsCCu6itePzJNX3dHxtIoWNP4fK3cf/GP3q
    2JOD+s+bQ9JDoGHtixt4mZh9cl5ozb971FLY5mR5gCy/sLuE8x19+n4Ok/RWwLPI8Y5rVf
    XZ5vyawgOYICQv3CdI5BdQjI5NPto+nWBi8U9HYq7645bDA6rrUQBuKgHCBy8J0x+/ICGz
    5tmX+2Vwz51KJSw8vSmGXfvF/DVNIPJLt9nSiPlwMZZnBpHyH/Hic5KQRRm/diak+e6LwN
    pBVLeXuPiTv01pqctkSrCO7aK1mVB9cBcIoIkClYnCE1t79mj57BGMZ1qBIrQ/gfSnc2Oy
    wqnnSb2GbLjDhp08znyIpeEWk6G6cwBjRHrFGKC4oAUHPQLz74M/Tzr1IHQxFN3fZjkyk/
    /3VbsSpQ1bZEfnnYPyc0uY0DxosNsPtYgbSVpis0IDYV26q+IVKhqUiaC63zdfYIHi+J+r
    6hXgJKTWaonoWDxOglmJ1fFn+mklisWySqHF8Tp5qZDRj+mxzesaa/OELNEQ
X-ME-Proxy: <xmx:dNbkanrG0D5n0lWTGypaKlhBnacDD0DeZcawb5iv-Yxk-DQL3V8HoQ>
    <xmx:dNbkaqmbdP_YrlNbiZuzfvYAqC93AQI4fz_Cq8F9bw0v3VARYUe7xg>
    <xmx:dNbkamII5DMGPIl8-bmUKawh0c8OBLPvDjCrEfnlPfXy9XSI4_QKCw>
    <xmx:dNbkanxQjIm6-vwt6Lt2gTgyuDlctxWwf-7t9G1cFvySTTCoADvOlw>
    <xmx:dNbkaqLEViEGmMLU-dEg0-iJhaiM22TRSOM-6xj39nWoYgzacI-Wc0CN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:40:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] read-cache: hide refresh_cache_entry()
Date: Fri, 30 Oct 2026 10:39:55 -0700
Message-ID: <20261030173956.585250-4-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-486-gd49ba3b80a
In-Reply-To: <20261030173956.585250-1-gitster@pobox.com>
References: <20261030173956.585250-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once upon a time, there was a merge strategy called "recursive",
which was added in 6d297f8137 (Status update on merge-recursive in
C, 2006-07-08).  This implementation came with its own machinery
that creates an in-core index entry, and then refreshed the index
entry it created by calling the refresh_cache_entry() function
borrowed from the read-cache.c API.  refresh_cache_entry() used to
be file-scope static, but was made public with this change.

When ad45b327c0 (merge-recursive.[ch]: thoroughly debug these,
2025-04-08) finally removed the entire code for the "recursive"
merge strategy, the last external caller of refresh_cache_entry()
went with it.

Hide the low-level implementation detail again by making it a
file-scope static function.  The external callers would indirectly
call it when they call make_cache_entry() or rename_index_entry_at()
external interface, which "ort" (the successor of "recursive") does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache-ll.h |   2 -
 read-cache.c    | 258 ++++++++++++++++++++++++------------------------
 2 files changed, 129 insertions(+), 131 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 066dd8bc3b..dd30befbb3 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -475,8 +475,6 @@ int refresh_index(struct index_state *, unsigned int flags, const struct pathspe
  */
 int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
 
-struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
-
 void set_alternate_index_output(const char *);
 
 extern int verify_index_checksum;
diff --git a/read-cache.c b/read-cache.c
index e40f290bb3..555bf55132 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -129,6 +129,135 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
 	return *pool_ptr;
 }
 
+/*
+ * "refresh" does not calculate a new sha1 file or bring the
+ * cache up-to-date for mode/content changes. But what it
+ * _does_ do is to "re-match" the stat information of a file
+ * with the cache, so that you can refresh the cache for a
+ * file that hasn't been changed but where the stat entry is
+ * out of date.
+ *
+ * For example, you'd want to do this after doing a "git-read-tree",
+ * to link up the stat cache details with the proper files.
+ */
+static struct cache_entry *refresh_cache_ent(struct index_state *istate,
+					     struct cache_entry *ce,
+					     unsigned int options, int *err,
+					     int *changed_ret,
+					     int *t2_did_lstat,
+					     int *t2_did_scan)
+{
+	struct stat st;
+	struct cache_entry *updated;
+	int changed;
+	int refresh = options & CE_MATCH_REFRESH;
+	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
+	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
+	int ignore_missing = options & CE_MATCH_IGNORE_MISSING;
+	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
+
+	if (!refresh || ce_uptodate(ce))
+		return ce;
+
+	if (!ignore_fsmonitor)
+		refresh_fsmonitor(istate);
+	/*
+	 * CE_VALID or CE_SKIP_WORKTREE means the user promised us
+	 * that the change to the work tree does not matter and told
+	 * us not to worry.
+	 */
+	if (!ignore_skip_worktree && ce_skip_worktree(ce)) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
+	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
+	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID)) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
+
+	if (has_symlink_leading_path(ce->name, ce_namelen(ce))) {
+		if (ignore_missing)
+			return ce;
+		if (err)
+			*err = ENOENT;
+		return NULL;
+	}
+
+	if (t2_did_lstat)
+		*t2_did_lstat = 1;
+	if (lstat(ce->name, &st) < 0) {
+		if (ignore_missing && errno == ENOENT)
+			return ce;
+		if (err)
+			*err = errno;
+		return NULL;
+	}
+
+	changed = ie_match_stat(istate, ce, &st, options);
+	if (changed_ret)
+		*changed_ret = changed;
+	if (!changed) {
+		/*
+		 * The path is unchanged.  If we were told to ignore
+		 * valid bit, then we did the actual stat check and
+		 * found that the entry is unmodified.  If the entry
+		 * is not marked VALID, this is the place to mark it
+		 * valid again, under "assume unchanged" mode.
+		 */
+		if (ignore_valid && assume_unchanged &&
+		    !(ce->ce_flags & CE_VALID))
+			; /* mark this one VALID again */
+		else {
+			/*
+			 * We do not mark the index itself "modified"
+			 * because CE_UPTODATE flag is in-core only;
+			 * we are not going to write this change out.
+			 */
+			if (!S_ISGITLINK(ce->ce_mode)) {
+				ce_mark_uptodate(ce);
+				mark_fsmonitor_valid(istate, ce);
+			}
+			return ce;
+		}
+	}
+
+	if (t2_did_scan)
+		*t2_did_scan = 1;
+	if (ie_modified(istate, ce, &st, options)) {
+		if (err)
+			*err = EINVAL;
+		return NULL;
+	}
+
+	updated = make_empty_cache_entry(istate, ce_namelen(ce));
+	copy_cache_entry(updated, ce);
+	memcpy(updated->name, ce->name, ce->ce_namelen + 1);
+	fill_stat_cache_info(istate, updated, &st);
+	/*
+	 * If ignore_valid is not set, we should leave CE_VALID bit
+	 * alone.  Otherwise, paths marked with --no-assume-unchanged
+	 * (i.e. things to be edited) will reacquire CE_VALID bit
+	 * automatically, which is not really what we want.
+	 */
+	if (!ignore_valid && assume_unchanged &&
+	    !(ce->ce_flags & CE_VALID))
+		updated->ce_flags &= ~CE_VALID;
+
+	/* istate->cache_changed is updated in the caller */
+	return updated;
+}
+
+static struct cache_entry *refresh_cache_entry(struct index_state *istate,
+					       struct cache_entry *ce,
+					       unsigned int options)
+{
+	return refresh_cache_ent(istate, ce, options, NULL, NULL, NULL, NULL);
+}
+
 static const char *alternate_index_output;
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
@@ -1339,128 +1468,6 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 	return 0;
 }
 
-/*
- * "refresh" does not calculate a new sha1 file or bring the
- * cache up-to-date for mode/content changes. But what it
- * _does_ do is to "re-match" the stat information of a file
- * with the cache, so that you can refresh the cache for a
- * file that hasn't been changed but where the stat entry is
- * out of date.
- *
- * For example, you'd want to do this after doing a "git-read-tree",
- * to link up the stat cache details with the proper files.
- */
-static struct cache_entry *refresh_cache_ent(struct index_state *istate,
-					     struct cache_entry *ce,
-					     unsigned int options, int *err,
-					     int *changed_ret,
-					     int *t2_did_lstat,
-					     int *t2_did_scan)
-{
-	struct stat st;
-	struct cache_entry *updated;
-	int changed;
-	int refresh = options & CE_MATCH_REFRESH;
-	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
-	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
-	int ignore_missing = options & CE_MATCH_IGNORE_MISSING;
-	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
-
-	if (!refresh || ce_uptodate(ce))
-		return ce;
-
-	if (!ignore_fsmonitor)
-		refresh_fsmonitor(istate);
-	/*
-	 * CE_VALID or CE_SKIP_WORKTREE means the user promised us
-	 * that the change to the work tree does not matter and told
-	 * us not to worry.
-	 */
-	if (!ignore_skip_worktree && ce_skip_worktree(ce)) {
-		ce_mark_uptodate(ce);
-		return ce;
-	}
-	if (!ignore_valid && (ce->ce_flags & CE_VALID)) {
-		ce_mark_uptodate(ce);
-		return ce;
-	}
-	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID)) {
-		ce_mark_uptodate(ce);
-		return ce;
-	}
-
-	if (has_symlink_leading_path(ce->name, ce_namelen(ce))) {
-		if (ignore_missing)
-			return ce;
-		if (err)
-			*err = ENOENT;
-		return NULL;
-	}
-
-	if (t2_did_lstat)
-		*t2_did_lstat = 1;
-	if (lstat(ce->name, &st) < 0) {
-		if (ignore_missing && errno == ENOENT)
-			return ce;
-		if (err)
-			*err = errno;
-		return NULL;
-	}
-
-	changed = ie_match_stat(istate, ce, &st, options);
-	if (changed_ret)
-		*changed_ret = changed;
-	if (!changed) {
-		/*
-		 * The path is unchanged.  If we were told to ignore
-		 * valid bit, then we did the actual stat check and
-		 * found that the entry is unmodified.  If the entry
-		 * is not marked VALID, this is the place to mark it
-		 * valid again, under "assume unchanged" mode.
-		 */
-		if (ignore_valid && assume_unchanged &&
-		    !(ce->ce_flags & CE_VALID))
-			; /* mark this one VALID again */
-		else {
-			/*
-			 * We do not mark the index itself "modified"
-			 * because CE_UPTODATE flag is in-core only;
-			 * we are not going to write this change out.
-			 */
-			if (!S_ISGITLINK(ce->ce_mode)) {
-				ce_mark_uptodate(ce);
-				mark_fsmonitor_valid(istate, ce);
-			}
-			return ce;
-		}
-	}
-
-	if (t2_did_scan)
-		*t2_did_scan = 1;
-	if (ie_modified(istate, ce, &st, options)) {
-		if (err)
-			*err = EINVAL;
-		return NULL;
-	}
-
-	updated = make_empty_cache_entry(istate, ce_namelen(ce));
-	copy_cache_entry(updated, ce);
-	memcpy(updated->name, ce->name, ce->ce_namelen + 1);
-	fill_stat_cache_info(istate, updated, &st);
-	/*
-	 * If ignore_valid is not set, we should leave CE_VALID bit
-	 * alone.  Otherwise, paths marked with --no-assume-unchanged
-	 * (i.e. things to be edited) will reacquire CE_VALID bit
-	 * automatically, which is not really what we want.
-	 */
-	if (!ignore_valid && assume_unchanged &&
-	    !(ce->ce_flags & CE_VALID))
-		updated->ce_flags &= ~CE_VALID;
-
-	/* istate->cache_changed is updated in the caller */
-	return updated;
-}
-
 static void show_file(const char * fmt, const char * name, int in_porcelain,
 		      int * first, const char *header_msg)
 {
@@ -1627,13 +1634,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	return has_errors;
 }
 
-struct cache_entry *refresh_cache_entry(struct index_state *istate,
-					struct cache_entry *ce,
-					unsigned int options)
-{
-	return refresh_cache_ent(istate, ce, options, NULL, NULL, NULL, NULL);
-}
-
 
 /*****************************************************************
  * Index File I/O
-- 
2.56.0-486-gd49ba3b80a

