Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176167;
	b=vBEccRRECNgf99aFjvwXnQotANa4TfRL7fGXuVhkX0OdkWACVqegI/oSbDELetRpScRU
	 noHUcQMeaPYXuKoaJQYCtP+MzU82geyXnpX8HRJyBlh0pCfeI/Xt4qYgdO1RlOpeDAorV
	 MWzTEWDcH5uIkAC1XtK5Xj6DWgFiuH//MCASV7/OhwJ0BqXRdLglyOA0T5QzujIl34hTd
	 ru+DxRSTaq0Vn9HApZmFrmisdNS6BT42/GwcCPnzSEOJLTss30FUcKYDfg17OOkC4cI4h
	 nqW6FawQBn8YUTMKe4nJvBS29ssrHa/X5ZaX7pxHYyMBeeG/3bYrjfCas8xCE7fZEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176167;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=RqyAKgVrCPwx1CWinTENlFLUQs+TBSgf4FTmllOktek=;
	b=4AI6EIn1TR9mwe3z2kKbMLed+pSPzHapaA1r/eJPuE4ptr7Rdhx61q3hxSNHdC2oG9kL
	 63I4YJvsqh8xf8fO7+Xa6YjdzEgwHJ70uSiCXZ9OQSiksU1EfV9uYKkVB7pqHqIGXQ6SI
	 O4y+9lMbzlabPBVQWEY5kEbGPnnOBXdTMbZ2Jf5kfJy862Zyt0GfGTI9KUzYqFiL3FcCC
	 Kb14cXUER6EuK/2NCxtQ3t0KyMyxcrmsfFZCjgnTY8EJAi2naO51AI+6vtcwLMjO9fYGi
	 H3tLwBMleygBZjRQGn1B2VAIxo4cqYfHW7szwbzNb2OcEjaYSUbVHRCPtLtstj5jSmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=uLZZSTDa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I1APQg0c;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F7606A326
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D08F7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=uLZZSTDa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I1APQg0c
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 313ECEC08F1
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 07:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795176166;
	 x=1795262566; bh=RqyAKgVrCPwx1CWinTENlFLUQs+TBSgf4FTmllOktek=; b=
	uLZZSTDa/c9/KboQTbH4OFNSNgHEtg7DoMWmTaz7eCIagmWkZOi2fjlCh5hQkRDR
	Gx9UC/QypbRmeKdmoqerPNdQcALTECX1j/qyg5wK8+avVUKb+9N1PAWllzGahkX/
	Qtk8VtgKDD4tYuLnpZ9Vfm8rPX5uPWtDSV+PZA3hI4rTcOIEpxEG+bGkDrGQyp6u
	EXIiVZXHqPvW3oFqTHBQz1fOgF69VCVocxpMiNWx2HwwaP855bH08udXgRVObEiN
	GLp0yhof7jZxiw5zh0BsK1skteNX4G+D8/O7Ze4XJ1hjCeGXERN0E5GkSigN5ShU
	KQt0Dau4Szt6SjSyGdUFEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795176166; x=
	1795262566; bh=RqyAKgVrCPwx1CWinTENlFLUQs+TBSgf4FTmllOktek=; b=I
	1APQg0ch7QYc0mKt2sZx8eTIFgv9xioM5m/N6pLUhtcXYC8lBKL4ifBvYlQDHLxm
	g0HpnpwY192/jLRTFSZxHmE7bZ8e/KGozNuOwmAkw50vkCWTA/qyHh3TayC4dyFE
	roZR+SwMnWEZZ9Ov2gW2mytUSCFUcBLwI27mEbPWKZ+6J9nV3nByQ7HGivr6RXwS
	t7hSv33fY/bZ9a76o9Kna7jcC/SVVkhV6vCq2Hm7Y4ZzwK/ngYvHe/wVcEMs9K8w
	CxljoKRBBLYLzSuzJ5kkpdP3jO36vX0HltgBbjs69F2hlQe6miBe7ZGzoqVbm11+
	yKv3cakQ/32+pOZs8aUNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176166; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:w+cyAA7oX2M8pgIkbc8Fi1wp1A5n/C9goHzpokLfHB54Sma
	HGA8l/VrVMv6zCGxn81z1dMmjwuI7j/d2VSkiQRuxYFVG4yw0FgwzNSdG2BO82Pa
	eZ9KtbitTc83cq0Yy5f5asj/vQI4UQ4/kDRQFj1toxqR28wjab4QB3yC3hImW6IB
	D2lmXF7GdVEmcQnxEA5SlmGszfgFeBRMCAYTV2u4uX2sbahRsGeFew2iGaw2NuKf
	snlU72ayJmxSziGmm0lACKvZfLt7pRL87MQymmZk/cghoJ1VnjjJ5AJdgNyEoKlL
	GYgU7Lc/TNtn+3gP8AM/ajheRkBrbkBcKWVyZ3Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:o9KC4TFM5LVXU40gO69SRSYSjfL6VLKaCw58grXH/Uk=:QhwFqVwNnzSBkC830CUErcqmyYpVS2bjvHTQ6B/fz5A=;
X-ME-Sender: <xms:5jYAa1EiHrtPLgeIwpHwpAam3lBgHCcRv-rXnIYBGmU5p-p2PThCLg>
    <xme:5jYAaxR39UV_697VzrcqlZoOApl18U1WGsgn-dD_ZwdWwwMzO82c31r2sXmIdAbxd
    OoekNJTROu1XRFnpE5R4i8GbYZz1csKIi-lYsnAlFZ60-UcMJi7KFE>
X-ME-Received: <xmr:5jYAa8wWEu1em86oCzlcIANUlkWutFmjcCng9R6HFABFl5p3B8DsSqLcSABe3hMiqoEF-Jg>
X-ME-Proxy-Cause: dmFkZTFHAgmJztTcDCPyZJnL0iP1g6Zd/dTY2NGGsR5DFH4R/k8g3YLCCs9nh03P2/jR+/
    nfvb6c/cNdoi4u9fBHNZ0O45HWkv2L1oRwgJpwbJeqPxx1+Lo7mwIuXmOIk49F0b0HS95c
    nMXl2G7WctB3PEQjznjVyXTWzdw2TjT0qh5dnSmn6Ew8CulHgHa6v/sZMa0Ww6JiOVe+xf
    X1NnJNPxDQB0JxNWH8WENe9OeVk/vQXei5Lm3iifJn1OWeyiChV136Vh0O8YpXn9lfm57K
    FRI5qXk1xUTe8xAVDkS/C+2ZxnSLXnCUOfn1JI7lC/rONuO8ou4ULl9DTxpKXTZ5NJs4Yj
    AbZIig1mDO8dh0Tn3oTnZ1GV2UHm1yFcMcsV/jfGR2cyBmadE10L5iYpLz7yp8uY2Q4wwx
    nNUeWlcv3172M9vY5KBpYcTRwTpZYm/yoZVtPX0Cqa0ZQ4l6orhyeWjshZkyHr592wH3qa
    EdeqgsUep3TxdmxG/QWopTOs6BunkleJ8Hp/S3oiPbT/Cxi4+JpzFpTswq+xfaHI1jeQsk
    URjuDbDl+/DrLjkt++vBJ4vjbgfQ5L9JEqW6wwLtXjtLGoT6YxXGno5pXLtAOdw2gy1i9j
    TbJ6+aa6BFFT9+XHVOYzUSDeVYMgqDuGfY0P2QCXhifJbxH5oRZF4urkGuRg
X-ME-Proxy: <xmx:5jYAawN-tIVCZeBJ5Ue_z24Dcpw4_TeVxp8_CQKsHc_m6-QFE8bJ_g>
    <xmx:5jYAa7NO-Xx3pNC0v3GwHkdv1YxQFKnwzzRs7H9qAcumd7ZhmnKqTA>
    <xmx:5jYAayRBirshyWlTVGs1RQPD-7YCGK8RmWPAETqwZh3nD_AQK4Rm9Q>
    <xmx:5jYAa9Adk2RtBf62Vh3p9PJJ9HCMW_xhfKqyYAx39npZGn-F0K45kQ>
    <xmx:5jYAazVUIPdtNaCPoYEqANFCY60ypxYohIe9OBpez2OifmkNDqzHEtih>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86a23c3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Nov 2026 12:02:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Nov 2026 13:02:30 +0100
Subject: [PATCH 3/6] packfile: inline `open_packed_git_1()`
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-pks-packfile-global-statistics-v1-3-19beb83b145f@pks.im>
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `open_packed_git()` is responsible for opening a packfile.
The majority of work is not performed by it though, but instead by its
`_1()` sibling. But this sibling really only exists because we thought
it too hard to handle errors properly and close the packfile's file
descriptor on an error path. So `_1()` doesn't handle those, and instead
defers to its only caller to close the file descriptor in the error path
again.

Fix this design smell by introducing a common exit path that knows to
close the file descriptor on error. This allows us to inline the call to
`open_packed_git_1()`.

While at it, rename the function to `packfile_open_pack()` to match
modern best practices. Besides that, it also gives the caller a better
idea of _what_ is being opened, as we also have functions that open
other files that belong to a packfile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 115 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 45 deletions(-)

diff --git a/packfile.c b/packfile.c
index 95a97c302c7..9b03258311f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -480,11 +480,7 @@ const char *pack_basename(struct packed_git *p)
 	return ret;
 }
 
-/*
- * Do not call this directly as this leaks p->pack_fd on error return;
- * call open_packed_git() instead.
- */
-static int open_packed_git_1(struct packed_git *p)
+static int packfile_open_pack(struct packed_git *p)
 {
 	struct stat st;
 	struct pack_header hdr;
@@ -492,9 +488,12 @@ static int open_packed_git_1(struct packed_git *p)
 	unsigned char *idx_hash;
 	ssize_t read_result;
 	const unsigned hashsz = p->repo->hash_algo->rawsz;
+	int ret;
 
-	if (packfile_open_index(p))
-		return error("packfile %s index unavailable", p->pack_name);
+	if (packfile_open_index(p)) {
+		ret = error("packfile %s index unavailable", p->pack_name);
+		goto out;
+	}
 
 	if (!pack_max_fds) {
 		unsigned int max_fds = get_max_fd_limit();
@@ -510,55 +509,81 @@ static int open_packed_git_1(struct packed_git *p)
 		; /* nothing */
 
 	p->pack_fd = git_open(p->pack_name);
-	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
-		return -1;
+	if (p->pack_fd < 0 || fstat(p->pack_fd, &st)) {
+		ret = -1;
+		goto out;
+	}
 	pack_open_fds++;
 
 	/* If we created the struct before we had the pack we lack size. */
 	if (!p->pack_size) {
-		if (!S_ISREG(st.st_mode))
-			return error("packfile %s not a regular file", p->pack_name);
+		if (!S_ISREG(st.st_mode)) {
+			ret = error("packfile %s not a regular file", p->pack_name);
+			goto out;
+		}
+
 		p->pack_size = st.st_size;
-	} else if (p->pack_size != st.st_size)
-		return error("packfile %s size changed", p->pack_name);
+	} else if (p->pack_size != st.st_size) {
+		ret = error("packfile %s size changed", p->pack_name);
+		goto out;
+	}
 
 	/* Verify we recognize this pack file format. */
 	read_result = read_in_full(p->pack_fd, &hdr, sizeof(hdr));
-	if (read_result < 0)
-		return error_errno("error reading from %s", p->pack_name);
-	if (read_result != sizeof(hdr))
-		return error("file %s is far too short to be a packfile", p->pack_name);
-	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
-		return error("file %s is not a GIT packfile", p->pack_name);
-	if (!pack_version_ok(hdr.hdr_version))
-		return error("packfile %s is version %"PRIu32" and not"
-			" supported (try upgrading GIT to a newer version)",
-			p->pack_name, ntohl(hdr.hdr_version));
+	if (read_result < 0) {
+		ret = error_errno("error reading from %s", p->pack_name);
+		goto out;
+	}
+
+	if (read_result != sizeof(hdr)) {
+		ret = error("file %s is far too short to be a packfile", p->pack_name);
+		goto out;
+	}
+
+	if (hdr.hdr_signature != htonl(PACK_SIGNATURE)) {
+		ret = error("file %s is not a GIT packfile", p->pack_name);
+		goto out;
+	}
+
+	if (!pack_version_ok(hdr.hdr_version)) {
+		ret = error("packfile %s is version %"PRIu32" and not"
+			    " supported (try upgrading GIT to a newer version)",
+			    p->pack_name, ntohl(hdr.hdr_version));
+		goto out;
+	}
 
 	/* Verify the pack matches its index. */
-	if (p->num_objects != ntohl(hdr.hdr_entries))
-		return error("packfile %s claims to have %"PRIu32" objects"
-			     " while index indicates %"PRIu32" objects",
-			     p->pack_name, ntohl(hdr.hdr_entries),
-			     p->num_objects);
+	if (p->num_objects != ntohl(hdr.hdr_entries)) {
+		ret = error("packfile %s claims to have %"PRIu32" objects"
+			    " while index indicates %"PRIu32" objects",
+			    p->pack_name, ntohl(hdr.hdr_entries),
+			    p->num_objects);
+		goto out;
+	}
+
 	read_result = pread_in_full(p->pack_fd, hash, hashsz,
 					p->pack_size - hashsz);
-	if (read_result < 0)
-		return error_errno("error reading from %s", p->pack_name);
-	if (read_result != hashsz)
-		return error("packfile %s signature is unavailable", p->pack_name);
+	if (read_result < 0) {
+		ret = error_errno("error reading from %s", p->pack_name);
+		goto out;
+	}
+	if (read_result != hashsz) {
+		ret = error("packfile %s signature is unavailable", p->pack_name);
+		goto out;
+	}
+
 	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
-	if (!hasheq(hash, idx_hash, p->repo->hash_algo))
-		return error("packfile %s does not match index", p->pack_name);
-	return 0;
-}
+	if (!hasheq(hash, idx_hash, p->repo->hash_algo)) {
+		ret = error("packfile %s does not match index", p->pack_name);
+		goto out;
+	}
 
-static int open_packed_git(struct packed_git *p)
-{
-	if (!open_packed_git_1(p))
-		return 0;
-	packfile_close_fd(p);
-	return -1;
+	ret = 0;
+
+out:
+	if (ret < 0)
+		packfile_close_fd(p);
+	return ret;
 }
 
 static int in_window(struct repository *r, struct pack_window *win,
@@ -587,7 +612,7 @@ unsigned char *use_pack(struct packed_git *p,
 	 * hash, and the in_window function above wouldn't match
 	 * don't allow an offset too close to the end of the file.
 	 */
-	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
+	if (!p->pack_size && p->pack_fd == -1 && packfile_open_pack(p))
 		die("packfile %s cannot be accessed", p->pack_name);
 	if (offset > (p->pack_size - p->repo->hash_algo->rawsz))
 		die("offset beyond end of packfile (truncated pack?)");
@@ -612,7 +637,7 @@ unsigned char *use_pack(struct packed_git *p,
 
 			window_align = settings->packed_git_window_size / 2;
 
-			if (p->pack_fd == -1 && open_packed_git(p))
+			if (p->pack_fd == -1 && packfile_open_pack(p))
 				die("packfile %s cannot be accessed", p->pack_name);
 
 			CALLOC_ARRAY(win, 1);
@@ -1810,7 +1835,7 @@ int is_pack_valid(struct packed_git *p)
 	}
 
 	/* Force the pack to open to prove its valid. */
-	return !open_packed_git(p);
+	return !packfile_open_pack(p);
 }
 
 int packfile_fill_entry(struct packed_git *p,

-- 
2.56.1.831.g720f3f5937.dirty

