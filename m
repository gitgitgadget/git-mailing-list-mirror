Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CBC18E778
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250768; cv=none; b=OI0KmQ1Bb1rryOzN0MvnEbLW5/582NsR10AZO07nbAycWjMcnF8QhR2qYiVJOJ1GBsqQakmztiSPLPBN40PF8qpLsP97uWbwH7hFE3C3a5htrq84PSYXUsFmJ+FnOLpHYSlcSd7LxX33KVw7eNkuF0zlowZS3b+3jIKkIM9kPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250768; c=relaxed/simple;
	bh=r3UNEMkSy+2vPsAvqc9M6eUeSUSNfSdumOZ80smL+us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njZ0J3bB/J1rp927T1hJHRiHt2lKIk7G6AqXLspgMLkAzYxeN+12Ynq/bLU9gcOen/eCGUzOutO0BSfJdp0YvHl33S7PsBputUJm6t67EG2LbpMbeMoovrXUEvPy7Z0sdAcE1dPZIvj/I+GU3FpN/OKhgi6AA+2/mLcikgs1IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UOKQavui; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UOKQavui"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b0d45a7aaso863927b3.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250766; x=1721855566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/1mIPzJkYTGJfWMxbTvkTLHd6GV5kmJzXmnug6TJBY=;
        b=UOKQavuiZ+zYZySGTZT4s0C9UAo0q+CWMq7qopO7EneqTLUpj5M1/ieqgtZG2Omn/b
         SRJORvA0aZr8IFAgFgA3jwNUkteozJb7DwpCnPCNTry5F4rHvkzPSSq5FONN2riZAuzZ
         eJyXQA5kRbg5k7+4+jm2Ztfh4rcbt4FOOCBWqOu+W9xyFPiYaeRcoCZYLGJjPkXDBb+V
         CjX43u9J7eCu7TvB+JsLSIUfQz3KfU/HcVaRwN+J2GncmizPTAoNUd8HcgN7zrclN/qf
         3wYv1wu8nWlmbkHrZLmRkIrHRrwpHn1VbjtIk/7TRIvIda/BzHEiIJvrHK/ptrbpJ7Jk
         kQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250766; x=1721855566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/1mIPzJkYTGJfWMxbTvkTLHd6GV5kmJzXmnug6TJBY=;
        b=FyX9g+nS22Pe7aXpIcS8pWUsnCpHOU2YdAGZhQzovholQsIQ4WmW9RnD75uIBQtLJI
         UA9rLJainpqoc+tEVsiPm0cx0YgMNuOwC4cE9T4+cozM6dQRXAYFePfjkH0Y2XoxzF+y
         fWo9PzIOGU4g4ANzKZ9EKRrAa5/fxiHg0TMmoqA/bEKN8pZCvW+m3I9GJV5gJ0ERq4FN
         cMNbjfaplYdzZKIFRrZ4jiDXcbt/OD9Yw5k0ZMXJPEIVyqgEG7GCqW8447IDZVCOwcWR
         VgJA1CeUQb7OEtj18BfhW7gAYeJYPKm472yYhFGwnKrsCIlKoXKUvv9FyG9OL830JF+q
         0nEw==
X-Gm-Message-State: AOJu0YzG4hrZAyz6j/y2CU5UK27gZvhJxZuy1x+/dDIOy+SrgRqRqJfj
	3HqbicIgXVmbXo57hQJkzLsP+XR0TQr8TlPegk9lxoJBa24t60v9UdlGpa2bxwq5K26tpXSTUiQ
	B
X-Google-Smtp-Source: AGHT+IEfq0C3BTRCzRhjyvWbnsYyyC9A5k8AhXb8yDQ8Gd94ZrzdIojnjbe497JMzAjPqFqO3hpFGw==
X-Received: by 2002:a05:690c:2e0a:b0:61e:a26:c1b2 with SMTP id 00721157ae682-66601bd41d2mr7510337b3.17.1721250766157;
        Wed, 17 Jul 2024 14:12:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66601fb56c5sm787997b3.48.2024.07.17.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:45 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/19] midx: implement verification support for
 incremental MIDXs
Message-ID: <ad976ef4137d31929a0feef205396d7642de7da0.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

Teach the verification implementation used by `git multi-pack-index
verify` to perform verification for incremental MIDX chains by
independently validating each layer within the chain.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 47 ++++++++++++++++++++++++++++++-----------------
 midx.h |  2 ++
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/midx.c b/midx.c
index 0bfd17c021..21a9dbe23a 100644
--- a/midx.c
+++ b/midx.c
@@ -469,6 +469,13 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
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
@@ -817,6 +824,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	uint32_t i;
 	struct progress *progress = NULL;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *curr;
 	verify_midx_error = 0;
 
 	if (!m) {
@@ -839,8 +847,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_delayed_progress(_("Looking for referenced packfiles"),
-					  m->num_packs);
-	for (i = 0; i < m->num_packs; i++) {
+						  m->num_packs + m->num_packs_in_base);
+	for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 		if (prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
 
@@ -860,17 +868,20 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
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
 
@@ -880,8 +891,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
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
@@ -895,16 +906,18 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
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
2.46.0.rc0.94.g9b2aff57b3

