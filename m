Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B733F589
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524363; cv=none; b=T/hV2KGaEjfaEaCVlcJm+7HJd7cCPeLSu/CrTkS1qotHt6/r9QI2RUFfJpHu/VC+Cg2MkIXZAEd1iERAi94BqgSUTjQqJ4tIPKIajfGWYFF6Tcq21cRQK8gNq60ysI2zy8QUYj1tlZsZIvoV9kisk0QTU5Rd6Krc150Tft00aHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524363; c=relaxed/simple;
	bh=ZWl4cOSbYLv2OVGhCYVvBOFdXyZoifMkafdP9NcC9Nc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TIfsKK+9anSUskCm2zmvS1lBAaIdiXPTnDedZapneV8oUxwmoBQLVPo1kAXFlk1eEhCuiUOzhn4F5ctwORLeySu+16WPU8SMKtxT/IM8L8cRSZAS0TJsu5HyEgo+fx7P+q0O/L55pveFNoDqi23uczEzN4je60POcduy2kA98QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nyuT5A3d; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyuT5A3d"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915c48e6ae2so273832585a.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524361; x=1782129161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QeGyCIZWa9uX7kqXOdw0IxXzAKbm1RcprbV076zQJw=;
        b=nyuT5A3dkLDEo062X2DrvmtL6pOLGTyPkgR5yiH2FfTc4DiqeNmyUu8N5PrMnmgLZf
         SiHf/sxHPI8LkULeiyMeunJ/y/HGVOZ2U0nYrutt+PHntXWQacc5oljVBCeNwbjSasRb
         n5nPHoZaFbtf38vqYX4y/w/XvE6W2Nq6zKbVHFhLVbORyM4MDnTeNdwqMowWioLWxiVK
         sX0KvVEW3jxsfudGKWRz+1E5NFBEYq0NWABIARXM1tGfEw+EXmxYg49lHtuk5W9QQFKA
         zL4DnxTb7ZB9mCUHM+xLgT6FSHaqtIazqwz/Tjxfb6jW/jTSTcEZVxPr2TVvANTHyNKT
         4SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524361; x=1782129161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QeGyCIZWa9uX7kqXOdw0IxXzAKbm1RcprbV076zQJw=;
        b=GjA/uiB1WPuGnBv/uSIm6f4H0SDVVvox1rx0z4xUxFeXtWVIn1ztW990g5wj8T5Kca
         m+XXy2b+qNEHstTlliu8fToFAlomt8SnMiXrkoS43QMR2+XmRpV1laenRmI9W9nLnUrk
         NT3KkuUIMxkuhUnI+nw2cnbZQBDv3K0SsNTaAIcQUchRBNwR4V7gvZVMRTBBxE4MUfL+
         Z+fVhWRawjKUtFf+DD6ep5Icbq6NtLf3EdA8b5e8tMjuIFiU7/m/zFwdTBT4sjSPJv2E
         Z621wKrT1cKGw2+1pcDqHA5l+qR8KpXJGVMJCVRbBqG0/zI/TDZbkwY/zzEI4oJqHYHd
         WzEg==
X-Gm-Message-State: AOJu0YzE5WPWT5L8uXyZ0BAfTYauBsXjrWPYdw8GRLahVdcGW7WHUBur
	fDXBpjfGkOa4v1/sW+O89q4rC4U5pDflI159Hgjfb9scZerllft6EUkP/roxoA==
X-Gm-Gg: Acq92OFF+HLXtee3BfhpAxzbL/ByTuQ4NHzAB5AzWdTLLhQBNBRhdftYMujZUUmuCe4
	6+A/TnM/x7UUfFhbS4AWUEga96Z2cQvI+9O5o5J3yD4lp3fWcJrReW5e5YXugdV/jQYF+o9qzou
	v2wsTj9/dpa8W/dY5u1nSS9lpOJ5vAKTMDAESYLcaWGVSJFB9VO6gxCwlswFacNO9qk+eSEvKRh
	f06wav2iwb28rmW3zlV1XZ7RdOTIkdoRNzu5o5stKqXIhdb6vrGcgcyLsVaETKWPrX8BNNljIoV
	U+uDALKXIJv7dsEsMaQdwoCxfBgxXWBNTTEemqLvWHLcxxhh+hdGZWQrRUe88mD0bo0zE6WNe6x
	PEicBSJKIec1DbfXdo2zYFK/WJNLK562pRc+oVvTR1bD4GaKRk7s+V2m5P79f4mAElP9ByPJ+Ir
	eN0zX39wagdCBHfW2BN7IKyP/8/lFeAFHShw+zpA==
X-Received: by 2002:a05:620a:6f0c:b0:915:c858:7d1c with SMTP id af79cd13be357-9161bad7f02mr2116987885a.14.1781524360991;
        Mon, 15 Jun 2026 04:52:40 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a055046sm1097396585a.41.2026.06.15.04.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:39 -0700 (PDT)
Message-Id: <12c142f8abb0df11f716a9cf6d0e4f41966f8548.1781524349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
	<pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:28 +0000
Subject: [PATCH v2 6/7] packfile,delta: drop the `cast_size_t_to_ulong()`
 wrappers
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When I started the transition from `unsigned long` to `size_t`, in the
interest of keeping the patches reviewable, I introduced these calls to
prevent data type narrowing from silently failing to handle large object
sizes. I also introduced `*_sz()` variants that would allow most of the
callers to keep using that `unsigned long` that the 90s kindly asked to
be returned.

After the preceding commits, the only places that called the narrow
wrappers either no longer exist or already use the `_sz` form
internally, so the wrappers just narrow values back through
`cast_size_t_to_ulong()` for no reason.

Drop them and rename the `_sz` variants back to the natural names.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h       | 14 ++------------
 packfile.c    | 28 ++++++++--------------------
 packfile.h    |  2 +-
 patch-delta.c |  4 ++--
 4 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/delta.h b/delta.h
index bb149dc82b..eb5c6d2fdb 100644
--- a/delta.h
+++ b/delta.h
@@ -86,11 +86,8 @@ void *patch_delta(const void *src_buf, size_t src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-/*
- * Size_t variant that doesn't truncate - use for >4GB objects on Windows.
- */
-static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
-					   const unsigned char *top)
+static inline size_t get_delta_hdr_size(const unsigned char **datap,
+					const unsigned char *top)
 {
 	const unsigned char *data = *datap;
 	size_t cmd, size = 0;
@@ -104,11 +101,4 @@ static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
 	return size;
 }
 
-static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
-					       const unsigned char *top)
-{
-	size_t size = get_delta_hdr_size_sz(datap, top);
-	return cast_size_t_to_ulong(size);
-}
-
 #endif
diff --git a/packfile.c b/packfile.c
index dab0a9b16d..c174982d10 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1164,11 +1164,12 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 }
 
 /*
- * Size_t variant for >4GB delta results on Windows.
+ * Read a delta object's header at curpos in p (already inflated as needed)
+ * and return the size of the result object (the post-application target).
  */
-static size_t get_size_from_delta_sz(struct packed_git *p,
-				     struct pack_window **w_curs,
-				     off_t curpos)
+size_t get_size_from_delta(struct packed_git *p,
+			   struct pack_window **w_curs,
+			   off_t curpos)
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
@@ -1215,18 +1216,10 @@ static size_t get_size_from_delta_sz(struct packed_git *p,
 	data = delta_head;
 
 	/* ignore base size */
-	get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
+	get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 
 	/* Read the result size */
-	return get_delta_hdr_size_sz(&data, delta_head+sizeof(delta_head));
-}
-
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-				  off_t curpos)
-{
-	size_t size = get_size_from_delta_sz(p, w_curs, curpos);
-	return cast_size_t_to_ulong(size);
+	return get_delta_hdr_size(&data, delta_head+sizeof(delta_head));
 }
 
 int unpack_object_header(struct packed_git *p,
@@ -1634,12 +1627,7 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 				ret = -1;
 				goto out;
 			}
-			/*
-			 * Use size_t variant to avoid die() on >4GB deltas.
-			 * oi->sizep is unsigned long, so truncation may occur,
-			 * but streaming code uses its own size_t tracking.
-			 */
-			size = get_size_from_delta_sz(p, &w_curs, tmp_pos);
+			size = get_size_from_delta(p, &w_curs, tmp_pos);
 			if (size == 0) {
 				ret = -1;
 				goto out;
diff --git a/packfile.h b/packfile.h
index 0b5ae3f9fc..bd4494906d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -458,7 +458,7 @@ int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t,
 		   enum object_type *, size_t *);
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
-unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+size_t get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
diff --git a/patch-delta.c b/patch-delta.c
index 44cda97994..42199fa956 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -27,12 +27,12 @@ void *patch_delta(const void *src_buf, size_t src_size,
 	top = (const unsigned char *) delta_buf + delta_size;
 
 	/* make sure the orig file size matches what we expect */
-	size = get_delta_hdr_size_sz(&data, top);
+	size = get_delta_hdr_size(&data, top);
 	if (size != src_size)
 		return NULL;
 
 	/* now the result size */
-	size = get_delta_hdr_size_sz(&data, top);
+	size = get_delta_hdr_size(&data, top);
 	dst_buf = xmallocz(size);
 
 	out = dst_buf;
-- 
gitgitgadget

