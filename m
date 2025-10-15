Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CF30B509
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567288; cv=none; b=OcZdLECrd2n5nz5IaUJej0Uc47fm6ny6/CaJNJQEwbH2xOnq7hu4pk2mWOexLW976IEx2bAOw4X3+HyoJuKKhVUpwZGL8FQzSgNAdyl0blEnTzTr9i4fXE9Ge919BJmk6MShfOi+Jk8mJ6IZ1ntD9ePJ9Iz3AALR6X9a76OtGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567288; c=relaxed/simple;
	bh=SexLOk+VIsUTRnfJJkJbwOqi2avFNXV3Ph8uRRF+xrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7WH5Vg7lSvxpiSPZ5spA8fmkH7v1E1PZQn4yf6jOb0+FcJkuIe8dkqyuG3VTBMnsp4sBJaWdA5XXlzLaP1KpdUfHA3L3cDX83xtBCW8oEC9gqgKiH7xvWPGGbkTzfGOjkfHYM1VrpR+l65dLbkfO3x9wVbeMikVFjRrCA0zJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=heykPUD5; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="heykPUD5"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-74435335177so27412947b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567286; x=1761172086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOh6+BfHJePso+ITxWiHJkBXiTBIcbXIXZfta8RzUvI=;
        b=heykPUD5rI7bmS1FbnDdJEDjDR3f3WrZ0czxR41xnwAkq1A03fYL24Ldxs0oUTf/8q
         37Gi8HquRfUXgPPuRswE101WbiTdQqxugSgMgbUZdHs93Hm8jAeZnj4Vbm1BwUSvt+k3
         gH1DMDuoMwP2KNiN93WC0eK7T/M6p+BYKzxUdTogO8arUivXovT/baK81gUXYSUYxd6m
         sbrRNDDQdxeyBUau6VNbXHbtUaC9J9N5neXbGEpTNolD8mgOvWTCh7Ek+IHzlDthBYtp
         xoVM9p7GZxhp7xA9W2yTToMBhUFaaWzUEZHer0QdfrdEv6dwb35Hrg2fTxM7+7O1ccHG
         rdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567286; x=1761172086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOh6+BfHJePso+ITxWiHJkBXiTBIcbXIXZfta8RzUvI=;
        b=JqYI5zNuYy57uMTXnVYyWcPlyEnO4tPM/jbCvKoTZV7NwWhSBoU/O12eYlR4VWc00J
         Po52s+1kV+eHVl6vFHr8jd4mrbvr/3M4FFxS0DV5y3KhSf59zJPaa0OZ9j6VUmOIIosz
         mJnBfVMxwpD7bORfuhMAfPenf3NrB4V/O7+W2CEd8m4VnvEJjMzxcP2YgMXMG/RSmxME
         UvsRi/sYtupr9NCOP2f4jsC6iSFi+YWCJ1oy8bsp4OR20vQ5/XYmUu992bQMrWiYeswZ
         rNq7HcbdkUAr589YTt4mVfxxIVH6AqD9JzXGTQ6jQ3un9W6X/nAlwp+kFbME7x9DM5qe
         YTHg==
X-Gm-Message-State: AOJu0Ywn1tRLGs51k8qvOC8YiLmJGoyYbFLReahyh5Soc80Fcyt7Hww9
	ig6ASrGMZuc2RAAwcDhRJJp5CKzvLfGqRr0N3rZaOazQ/SCKrafyzmQP5hYsJxbWH1updRmWJ9m
	SCG3wxG03HV5P
X-Gm-Gg: ASbGncs2w3XZRmJIW4AC58miuyssAiaChpsBQmrldLU7IYzms+vPT9jkDg4V9BFyq8J
	cNykW4s2FFOM7dtrcKsdjjpu+jf8YsBVbBdlO1Dj4+ydIePNo+J+PdxBBkfZwNy80eD64Gsz9ct
	iMRBsq8xaBrAODVwSQyBxtSdqOD1normToR7+9LiEp3LYf6exxBO4rn3Tf8iSzTWHfLsgqB27kC
	uX8Aac8bVza7ZW7axeuOpOKp/tEsLRmyRGbHdWkE9FhBJbBkHQs2r6EMJ64VRjTzVwJupYbMzgV
	K1IJcG410vLpAw0vkAGW7aybK09+3fy5dYZTJnuAhpox8722Ye4RTJ3ktqOLUA06Xto/uY4OVBL
	Gcrx7BukSkoxrYuF3AZ9SZfGepZqfaX1Scd9Q34jhm1M0sjSHOvSeJnoR3akg1eL5W61eFtxjV+
	f9TSiuIHRgv8CgfoPfbomTFZPpTJFOOv1+CiLbDSdw0s0p96SBf/kLNg7sY2w80ZL6eJCmLOEbm
	em9E8TesfN7C3hy6Q==
X-Google-Smtp-Source: AGHT+IFOGmh0PJnZoplG3jmlrgnXkCxosMjvbd1bpAsngIBpf6HPhdhBDpJBMJFj/zJu1b54TxBaVg==
X-Received: by 2002:a53:c047:0:10b0:636:100c:ab with SMTP id 956f58d0204a3-63e08f699ebmr1235462d50.13.1760567285869;
        Wed, 15 Oct 2025 15:28:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78292d0a7cesm2590627b3.30.2025.10.15.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:05 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 15/49] builtin/repack.c: rename many 'struct
 existing_packs' functions
Message-ID: <a9767dc42dca66648152d966560cd14699bda81e.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Rename many of the 'struct existing_packs'-related functions according
to the convention introduced in and described by 541204aabe
(Documentation: document naming schema for structs and their functions,
2024-07-30).

Note that some functions which operate over an individual entry in the
list of existing packs are prefixed with "existing_pack_" instead of the
plural form.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 66 +++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ff93654cfe..f82e6c3930 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -121,39 +121,39 @@ struct existing_packs {
 	.cruft_packs = STRING_LIST_INIT_DUP, \
 }
 
-static int has_existing_non_kept_packs(const struct existing_packs *existing)
+static int existing_packs_has_non_kept(const struct existing_packs *existing)
 {
 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
 }
 
-static void pack_mark_for_deletion(struct string_list_item *item)
+static void existing_pack_mark_for_deletion(struct string_list_item *item)
 {
 	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
 }
 
-static void pack_unmark_for_deletion(struct string_list_item *item)
+static void existing_pack_unmark_for_deletion(struct string_list_item *item)
 {
 	item->util = (void*)((uintptr_t)item->util & ~DELETE_PACK);
 }
 
-static int pack_is_marked_for_deletion(struct string_list_item *item)
+static int existing_pack_is_marked_for_deletion(struct string_list_item *item)
 {
 	return (uintptr_t)item->util & DELETE_PACK;
 }
 
-static void pack_mark_retained(struct string_list_item *item)
+static void existing_packs_mark_retained(struct string_list_item *item)
 {
 	item->util = (void*)((uintptr_t)item->util | RETAIN_PACK);
 }
 
-static int pack_is_retained(struct string_list_item *item)
+static int existing_pack_is_retained(struct string_list_item *item)
 {
 	return (uintptr_t)item->util & RETAIN_PACK;
 }
 
-static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
-				      struct string_list *names,
-				      struct string_list *list)
+static void existing_packs_mark_for_deletion_1(const struct git_hash_algo *algop,
+					       struct string_list *names,
+					       struct string_list *list)
 {
 	struct string_list_item *item;
 	const int hexsz = algop->hexsz;
@@ -165,8 +165,8 @@ static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
 			continue;
 		sha1 = item->string + len - hexsz;
 
-		if (pack_is_retained(item)) {
-			pack_unmark_for_deletion(item);
+		if (existing_pack_is_retained(item)) {
+			existing_pack_unmark_for_deletion(item);
 		} else if (!string_list_has_string(names, sha1)) {
 			/*
 			 * Mark this pack for deletion, which ensures
@@ -175,13 +175,13 @@ static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
 			 * will actually delete this pack (if `-d` was
 			 * given).
 			 */
-			pack_mark_for_deletion(item);
+			existing_pack_mark_for_deletion(item);
 		}
 	}
 }
 
-static void retain_cruft_pack(struct existing_packs *existing,
-			      struct packed_git *cruft)
+static void existing_packs_retain_cruft(struct existing_packs *existing,
+					struct packed_git *cruft)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
@@ -193,17 +193,19 @@ static void retain_cruft_pack(struct existing_packs *existing,
 	if (!item)
 		BUG("could not find cruft pack '%s'", pack_basename(cruft));
 
-	pack_mark_retained(item);
+	existing_packs_mark_retained(item);
 	strbuf_release(&buf);
 }
 
-static void mark_packs_for_deletion(struct existing_packs *existing,
-				    struct string_list *names)
+static void existing_packs_mark_for_deletion(struct existing_packs *existing,
+					     struct string_list *names)
 
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
-	mark_packs_for_deletion_1(algop, names, &existing->non_kept_packs);
-	mark_packs_for_deletion_1(algop, names, &existing->cruft_packs);
+	existing_packs_mark_for_deletion_1(algop, names,
+					   &existing->non_kept_packs);
+	existing_packs_mark_for_deletion_1(algop, names,
+					   &existing->cruft_packs);
 }
 
 static void remove_redundant_pack(struct repository *repo,
@@ -225,13 +227,13 @@ static void remove_redundant_packs_1(struct repository *repo,
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
-		if (!pack_is_marked_for_deletion(item))
+		if (!existing_pack_is_marked_for_deletion(item))
 			continue;
 		remove_redundant_pack(repo, packdir, item->string);
 	}
 }
 
-static void remove_redundant_existing_packs(struct existing_packs *existing)
+static void existing_packs_remove_redundant(struct existing_packs *existing)
 {
 	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs);
 	remove_redundant_packs_1(existing->repo, &existing->cruft_packs);
@@ -250,7 +252,7 @@ static void existing_packs_release(struct existing_packs *existing)
  * .keep file or not.  Packs without a .keep file are not to be kept
  * if we are going to pack everything into one file.
  */
-static void collect_pack_filenames(struct existing_packs *existing,
+static void existing_packs_collect(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
 {
 	struct packfile_store *packs = existing->repo->objects->packfiles;
@@ -721,7 +723,7 @@ static int midx_has_unknown_packs(char **midx_pack_names,
 
 			item = string_list_lookup(&existing->non_kept_packs,
 						  pack_name);
-			if (item && !pack_is_marked_for_deletion(item))
+			if (item && !existing_pack_is_marked_for_deletion(item))
 				continue;
 		}
 
@@ -851,7 +853,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
-			if (pack_is_marked_for_deletion(item))
+			if (existing_pack_is_marked_for_deletion(item))
 				continue;
 
 			strbuf_reset(&buf);
@@ -888,10 +890,10 @@ static void midx_included_packs(struct string_list *include,
 			 * --geometric case, but doing so is unnecessary
 			 *  since no packs are marked as pending
 			 *  deletion (since we only call
-			 *  `mark_packs_for_deletion()` when doing an
-			 *  all-into-one repack).
+			 *  `existing_packs_mark_for_deletion()` when
+			 *  doing an all-into-one repack).
 			 */
-			if (pack_is_marked_for_deletion(item))
+			if (existing_pack_is_marked_for_deletion(item))
 				continue;
 
 			strbuf_reset(&buf);
@@ -1128,7 +1130,7 @@ static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 		if (p->pack_size < combine_cruft_below_size) {
 			fprintf(in, "-%s\n", pack_basename(p));
 		} else {
-			retain_cruft_pack(existing, p);
+			existing_packs_retain_cruft(existing, p);
 			fprintf(in, "%s\n", pack_basename(p));
 		}
 	}
@@ -1382,7 +1384,7 @@ int cmd_repack(int argc,
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
 	existing.repo = repo;
-	collect_pack_filenames(&existing, &keep_pack_list);
+	existing_packs_collect(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
 		if (pack_everything)
@@ -1431,7 +1433,7 @@ int cmd_repack(int argc,
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(repo, &po_args, &names);
 
-		if (has_existing_non_kept_packs(&existing) &&
+		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
@@ -1647,7 +1649,7 @@ int cmd_repack(int argc,
 	/* End of pack replacement. */
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
-		mark_packs_for_deletion(&existing, &names);
+		existing_packs_mark_for_deletion(&existing, &names);
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_DUP;
@@ -1671,7 +1673,7 @@ int cmd_repack(int argc,
 
 	if (delete_redundant) {
 		int opts = 0;
-		remove_redundant_existing_packs(&existing);
+		existing_packs_remove_redundant(&existing);
 
 		if (geometry.split_factor)
 			geometry_remove_redundant_packs(&geometry, &names,
-- 
2.51.0.540.ga7423965ad8

