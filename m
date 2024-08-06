Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9143AD5
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958682; cv=none; b=D7Wl+FSFuQqTyiN3HDdjzHxCVwOfxaJV/+WXKiwjgTZirSMF5NXUrU/NYmmQ+aGa2yiRRlDS6z1EmpO9lXJ2KAy26aIWGu9pql1Nz81K9eF0DDylofW2hfcSr3zid9TwjvT0T6J9Or5X7a546N6YOyt2UuArLXB5Ca33J3z48lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958682; c=relaxed/simple;
	bh=cMl4GsdGNvRlSUP9EPtPS8BErGdng6cU/BZWX4GJoJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFm9jkIMxEuZUaWoNgAMhDfuXFcwN1BpKGef/66VMVIjGki6bx8uX9c0OmdoMsC9UFxA6BfkF8V6sMpR4Hum6cBpr7REa61/jC5wbU2smfVxktz/gXZ6Ezur4B6M3t1wR7LnOxc3GfkkA08unMpXw+NzmanPtW1n/kWQ6nO8aZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=A8BwSGTq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A8BwSGTq"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66599ca3470so7227457b3.2
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958680; x=1723563480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3JV7TWGYNq5kqJPCnyFKrRAe3+NDxsE+gIopkSyuIw=;
        b=A8BwSGTq0ee7HtnCPLsYmLoLWB47vQOCYMI9ZWp4P7HIB/zANTyYsz4eohTMliN//O
         HLk5nq/XJb/bj/y94VFkcpVFX4IcK2PMY6lSd7T8qEjkckqGaCGoa717ia0/cnef6jqA
         95Skq/Ivc4q1QIBQFEcvUNXG0SiuC8CSLCSGas7vZRY/rEFZ8/JlySXrNGXrBozxTkxf
         74l5Pao6bo8C00RTr7hik5eXPKRpkaWtpZVvdqSHlr7A2NO4BKUiOBnqwCugPaNxqxCZ
         H2gKjE2Bp2USazNlHPKiQu5eOx9a4rE7INv6WWkU1WWDpUbvgnaYgVelOsdj6U4/7tSq
         Isww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958680; x=1723563480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3JV7TWGYNq5kqJPCnyFKrRAe3+NDxsE+gIopkSyuIw=;
        b=HObW5si4xQZKyqqACViBsHCcaLkSLb+dmRZGqYVcT/2UJ04+KczV80vyzI/rFjKifW
         sZ9QafIWjfspRdS/UQYzsPXnVEWX4K90OrBkLi9kPG+BqwfbT56wfSCGfviaIkrGdzT0
         elRQmNehlilQzIG3I5nP6XNk3IXqUbEJX09K1kyhltYPvudYZPWqGq7BZzhivpVPGIxn
         Ndj0bgE+P7TM9G1DVR0nDU9AhrFjP449bgEjfyMNoltl1ZwfzEK2CLcYPJC+ZJvV5tc+
         ZIQmHTjhoDa+mvL6LIoLEzsPSq57S7oGKX18R+viQwzXjnWuZP3makOKKTlPwrml/Uxz
         qf0g==
X-Gm-Message-State: AOJu0YznAOwecLFTb8HSt6An8/xAy2ZQ3uXdHjJ59aVqQ2wojIfRZiU3
	LZF+f8j0CqFAcLCSsMw3akIb6WJy3s+Q21Wi56+bpTy7t7JcjTaUSLDuJGawfxeE59nPAR3LVlN
	W
X-Google-Smtp-Source: AGHT+IGZDKIzFP5hJcsjKekoA5LbOA5PYiwSSJV36nOH2i7iX4ond/DJ6k0FaCE2qM6IxgyVyvWNJw==
X-Received: by 2002:a0d:c647:0:b0:64a:79f6:2f2d with SMTP id 00721157ae682-689637fcb2emr154411967b3.31.1722958679774;
        Tue, 06 Aug 2024 08:37:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a14157203sm15682237b3.145.2024.08.06.08.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:59 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/19] midx: implement verification support for
 incremental MIDXs
Message-ID: <3d4181df518ece2268534182a11f66b2d84302e9.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

Teach the verification implementation used by `git multi-pack-index
verify` to perform verification for incremental MIDX chains by
independently validating each layer within the chain.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 47 ++++++++++++++++++++++++++++++-----------------
 midx.h |  2 ++
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/midx.c b/midx.c
index 54c06cbb86..a53d65702d 100644
--- a/midx.c
+++ b/midx.c
@@ -470,6 +470,13 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	return 0;
 }
 
+struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
+				   uint32_t pack_int_id)
+{
+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+	return m->packs[local_pack_int_id];
+}
+
 #define MIDX_CHUNK_BITMAPPED_PACKS_WIDTH (2 * sizeof(uint32_t))
 
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
@@ -818,6 +825,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	uint32_t i;
 	struct progress *progress = NULL;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *curr;
 	verify_midx_error = 0;
 
 	if (!m) {
@@ -840,8 +848,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(_("Looking for referenced packfiles"),
-					  m->num_packs);
-	for (i = 0; i < m->num_packs; i++) {
+						  m->num_packs + m->num_packs_in_base);
+	for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 		if (prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
 
@@ -861,17 +869,20 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
 						 m->num_objects - 1);
-	for (i = 0; i < m->num_objects - 1; i++) {
-		struct object_id oid1, oid2;
 
-		nth_midxed_object_oid(&oid1, m, i);
-		nth_midxed_object_oid(&oid2, m, i + 1);
+	for (curr = m; curr; curr = curr->base_midx) {
+		for (i = 0; i < m->num_objects - 1; i++) {
+			struct object_id oid1, oid2;
 
-		if (oidcmp(&oid1, &oid2) >= 0)
-			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
-				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+			nth_midxed_object_oid(&oid1, m, m->num_objects_in_base + i);
+			nth_midxed_object_oid(&oid2, m, m->num_objects_in_base + i + 1);
 
-		midx_display_sparse_progress(progress, i + 1);
+			if (oidcmp(&oid1, &oid2) >= 0)
+				midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
+					    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+
+			midx_display_sparse_progress(progress, i + 1);
+		}
 	}
 	stop_progress(&progress);
 
@@ -881,8 +892,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	 * each of the objects and only require 1 packfile to be open at a
 	 * time.
 	 */
-	ALLOC_ARRAY(pairs, m->num_objects);
-	for (i = 0; i < m->num_objects; i++) {
+	ALLOC_ARRAY(pairs, m->num_objects + m->num_objects_in_base);
+	for (i = 0; i < m->num_objects + m->num_objects_in_base; i++) {
 		pairs[i].pos = i;
 		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
 	}
@@ -896,16 +907,18 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
-	for (i = 0; i < m->num_objects; i++) {
+	for (i = 0; i < m->num_objects + m->num_objects_in_base; i++) {
 		struct object_id oid;
 		struct pack_entry e;
 		off_t m_offset, p_offset;
 
 		if (i > 0 && pairs[i-1].pack_int_id != pairs[i].pack_int_id &&
-		    m->packs[pairs[i-1].pack_int_id])
-		{
-			close_pack_fd(m->packs[pairs[i-1].pack_int_id]);
-			close_pack_index(m->packs[pairs[i-1].pack_int_id]);
+		    nth_midxed_pack(m, pairs[i-1].pack_int_id)) {
+			uint32_t pack_int_id = pairs[i-1].pack_int_id;
+			struct packed_git *p = nth_midxed_pack(m, pack_int_id);
+
+			close_pack_fd(p);
+			close_pack_index(p);
 		}
 
 		nth_midxed_object_oid(&oid, m, pairs[i].pos);
diff --git a/midx.h b/midx.h
index 94de16a8c4..9d30935589 100644
--- a/midx.h
+++ b/midx.h
@@ -95,6 +95,8 @@ void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
+struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
+				   uint32_t pack_int_id);
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id);
 int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
-- 
2.46.0.46.g406f326d27.dirty

