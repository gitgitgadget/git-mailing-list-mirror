Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA2201023
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724932; cv=none; b=eD4IYiou77FthndlUFJqeNIQ4LsG9BEIzbuy37YUiDB1xHJYp3ZbJjQJmuZcWHJyXazzcIoufB5TZEO3x/Ni67UNyr2iyyi5obrobmPkGxTHRkOeF/NyFrCPKjhaWjUrQTso4E9RAy27O0ZJFb6JTpL7SK/Rlbwn/Jot0njT5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724932; c=relaxed/simple;
	bh=sx1ryuGozGd99F3zCCNjEUrYsGPUv0as8MJU+JPslDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7pWZkmSbDB5+NsveB3qNt+cPWnVpxsSzlgtdt7wdgiA/1Lm3QLLxmkI2+X6fHmu7XWHJsCZ5r2yWxj9l+Cptt2deyJnhoWDM1p98G3umrpxXhrz2avweGLm2LiJaq6t7Dm2Q8aXa/xL1VG5Ud0UCYBxr7Ji3JuJyyzl2hEf7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXMV2pGP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXMV2pGP"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ec267b879so994141066b.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724928; x=1733329728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuzciJdDWRMUC08XcaSL/CVBQrMLNMHgY+X0NLG3WsU=;
        b=aXMV2pGPzIHwyfSGF/qrsKgK/YH6CcIu3VV2EBKW1yaRTYY6LxdE8ih9MEGsfnQcyB
         TrDVP9F1rmhEFoijcG5yirfyAwD+4OGIEJskRQmrSCMP9nLBd/HHwPNojVzbU8ZQ3JdR
         PZdfP1BwIUo4hMG2Ng+FJXebA5CbUItRPfZDQ13KgvAKbpLk/NwhWMLwcYx3vgB0+jeG
         Z8tcUzccFxaJx1BYDuSnFcC1P42H4x/c+zs3sWi+MxAqsSyVgKEmIlIShbX1ZvyhmDv0
         A9To07LgDphytaDDdYzS0GPHd8yrmpiYKq+E5FxOZCrFYeqa4uS29h4xKCRW3uia1J1S
         BwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724928; x=1733329728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuzciJdDWRMUC08XcaSL/CVBQrMLNMHgY+X0NLG3WsU=;
        b=Eq7AGvHMydBleARYd8Ifus+1onItaw7ujcHpJQJHnTWSnjII/noBCGUDZkq9DHa8cJ
         DKXMssWsn7Mo98C5oHMAf+0hc3YDnwwYkU74cmvJPJh+Yl8Q0BGoQg7eZHTsfEt0QgTa
         tm0bR/Ain7eLtzCQqzNJqpz8cjUmlonqTEd0re1OxkPaJLsOtQIdwVl6geUnOv+6DYsx
         5H5m7ig/HQWm45qY1sA+v50/2AxOg2ihSltsrIUuiFGV2g1lGBjT0GOW0kdSl/8umdBd
         oiGzP0/YcmnFr7TpRuIXhavwIcz6RcMkgTelGw7oWdNVsFpNsQtu7Tc4W6h9TKVOlBaB
         JROQ==
X-Gm-Message-State: AOJu0Yy/5vXlBSQa0gt4gKyrkJU8KpG/xA7GR1TtA6agtdA7l/p6G7nu
	ifZX6Y/V+SrNmd4SxSZk5PLKdjcguh5VQFQ82ofhfI+QOH4tt6BP
X-Gm-Gg: ASbGncvYrOorKRV4vW8354TuuM5ikioZHfEHiOrZNUVbXEnnT01hVexubnMV0mJC+/M
	5nZmr18+srmR2Fe4NnjhoT9y0drMguxznvMt0GlLYrIGzhbktx46Vf9HSF5wveliu5anydcRdWs
	8m1jbkd7n0HnKexnmzixDM5kWiJFNUrGlQgiUyBk/jkRZ9f7GY0V4jVaFVEHxcB62YeV7kSQgxk
	Dw7LTC7tOKbHY7L2vDdQqCJZ8LVHxXNai/iaDmsYuFatSGBI8f56Aw0rWYj0g==
X-Google-Smtp-Source: AGHT+IFHCrCFqZ+IKDCrl2wLl8sGQ4MprpUeG5Lg62tTeNlTGYQmjmMHMZ5pEEsuo8mVpKQB55BsVg==
X-Received: by 2002:a17:906:31d0:b0:aa5:37b4:cd5a with SMTP id a640c23a62f3a-aa580eded57mr276938866b.3.1732724927985;
        Wed, 27 Nov 2024 08:28:47 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:47 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:26 +0100
Subject: [PATCH v3 1/8] midx-write: pass down repository to static
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-1-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8901; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=sx1ryuGozGd99F3zCCNjEUrYsGPUv0as8MJU+JPslDM=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i8y63XgNWGjlgcFPkbG4Afum1cvq+UkbceC
 MGzy4TVit2JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvAAKCRA+1Z8kjkaM
 f5iXC/95RHg/tW3LAcBYlqQ029upt0bzAGEUNcUbzrwzOyAL0uPLqxNI349t+dprQPMT2QrGJj9
 Lpnwhqvme9etaeUlW/xF4zh1facZxC7XykPkF5msA4CsF1nNH0jAVMrue0F2mz+x/jK+bvmCGlX
 qCV1VhZVCDMyVIHfAJfj7tQRyvuVvHMHZwP1H8B14JyBEjmPikz6LRBzmovWD2gs48/4IP4XVGb
 NBZv9ZrkpgeMIsn73PLQpJlB8XVUvKTps/1cublcsvdhUT2h4il/pm9B80TC9KE4m0wLjtfKhyK
 9C4GdsW04y79X0HRUnFeRan/rt6ZsSQs4KJ8iidEG1fDdM46Sl0dXshM9R9ETJF5ozVErahz/Sy
 7Ue7bS5uyQCLzpNB9/NuSZGEQWXNgalPC/sBg0QBxHmhAKEmg4JLk447GECBenKz6D4pD0ioKnl
 WdadQC+JCNwrIyY8USJeql9SNZV3p6Qo70v0W36pWefeqL0V9oJTpp++PbAtnyP4+aTuo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 'midx-write.c' there are a lot of static functions which use global
variables `the_repository` or `the_hash_algo`. In a follow up commit,
the repository variable will be added to `write_midx_context`, which
some of the functions can use. But for functions which do not have
access to this struct, pass down the required information from
non-static functions `write_midx_file` and `write_midx_file_only`.

This requires that the function `hash_to_hex` is also replaced with
`hash_to_hex_algop` since the former internally accesses the
`the_hash_algo` global variable.

This ensures that the usage of global variables is limited to these
non-static functions, which will be cleaned up in a follow up commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c | 57 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c57726ef9475df693890d61627ce91409c1def7c..22b5233f51ec6c6d99b8f9613818f1581dca5982 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -35,13 +35,13 @@ extern void clear_incremental_midx_files_ext(const char *object_dir,
 extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 				const char *idx_name);
 
-static size_t write_midx_header(struct hashfile *f,
-				unsigned char num_chunks,
+static size_t write_midx_header(const struct git_hash_algo *hash_algo,
+				struct hashfile *f, unsigned char num_chunks,
 				uint32_t num_packs)
 {
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	hashwrite_u8(f, MIDX_VERSION);
-	hashwrite_u8(f, oid_version(the_hash_algo));
+	hashwrite_u8(f, oid_version(hash_algo));
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused */
 	hashwrite_be32(f, num_packs);
@@ -702,7 +702,7 @@ static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
 		return 0;
 	}
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!peel_iterated_oid(revs->repo, oid, &peeled))
 		oid = &peeled;
 
 	object = parse_object_or_die(oid, refname);
@@ -827,7 +827,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	return cb.commits;
 }
 
-static int write_midx_bitmap(const char *midx_name,
+static int write_midx_bitmap(struct repository *r, const char *midx_name,
 			     const unsigned char *midx_hash,
 			     struct packing_data *pdata,
 			     struct commit **commits,
@@ -840,9 +840,9 @@ static int write_midx_bitmap(const char *midx_name,
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
-					hash_to_hex(midx_hash));
+				    hash_to_hex_algop(midx_hash, r->hash_algo));
 
-	trace2_region_enter("midx", "write_midx_bitmap", the_repository);
+	trace2_region_enter("midx", "write_midx_bitmap", r);
 
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
@@ -859,7 +859,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_init(&writer, the_repository, pdata);
+	bitmap_writer_init(&writer, r, pdata);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(&writer, index);
 
@@ -892,7 +892,7 @@ static int write_midx_bitmap(const char *midx_name,
 	free(bitmap_name);
 	bitmap_writer_free(&writer);
 
-	trace2_region_leave("midx", "write_midx_bitmap", the_repository);
+	trace2_region_leave("midx", "write_midx_bitmap", r);
 
 	return ret;
 }
@@ -1049,7 +1049,7 @@ static void clear_midx_files(const char *object_dir,
 	strbuf_release(&buf);
 }
 
-static int write_midx_internal(const char *object_dir,
+static int write_midx_internal(struct repository *r, const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -1070,7 +1070,8 @@ static int write_midx_internal(const char *object_dir,
 	const char **keep_hashes = NULL;
 	struct chunkfile *cf;
 
-	trace2_region_enter("midx", "write_midx_internal", the_repository);
+	trace2_region_enter("midx", "write_midx_internal", r);
+
 
 	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
 	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
@@ -1087,8 +1088,7 @@ static int write_midx_internal(const char *object_dir,
 			  midx_name.buf);
 
 	if (!packs_to_include || ctx.incremental) {
-		struct multi_pack_index *m = lookup_multi_pack_index(the_repository,
-								     object_dir);
+		struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
 		if (m && !midx_checksum_valid(m)) {
 			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 			m = NULL;
@@ -1351,7 +1351,7 @@ static int write_midx_internal(const char *object_dir,
 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
 		  write_midx_oid_fanout);
 	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
-		  st_mult(ctx.entries_nr, the_hash_algo->rawsz),
+		  st_mult(ctx.entries_nr, r->hash_algo->rawsz),
 		  write_midx_oid_lookup);
 	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
 		  st_mult(ctx.entries_nr, MIDX_CHUNK_OFFSET_WIDTH),
@@ -1373,7 +1373,8 @@ static int write_midx_internal(const char *object_dir,
 			  write_midx_bitmapped_packs);
 	}
 
-	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
+	write_midx_header(r->hash_algo, f, get_num_chunks(cf),
+			  ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
 	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
@@ -1405,7 +1406,7 @@ static int write_midx_internal(const char *object_dir,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
+		if (write_midx_bitmap(r, midx_name.buf, midx_hash, &pdata,
 				      commits, commits_nr, ctx.pack_order,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
@@ -1449,12 +1450,13 @@ static int write_midx_internal(const char *object_dir,
 		strbuf_release(&final_midx_name);
 
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex(midx_hash));
+			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 
 		for (i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-			keep_hashes[j] = xstrdup(hash_to_hex(get_midx_checksum(m)));
+			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
+								   r->hash_algo));
 			m = m->base_midx;
 		}
 
@@ -1462,7 +1464,7 @@ static int write_midx_internal(const char *object_dir,
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex(midx_hash));
+			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 	}
 
 	if (ctx.m || ctx.base_midx)
@@ -1495,7 +1497,7 @@ static int write_midx_internal(const char *object_dir,
 	}
 	strbuf_release(&midx_name);
 
-	trace2_region_leave("midx", "write_midx_internal", the_repository);
+	trace2_region_leave("midx", "write_midx_internal", r);
 
 	return result;
 }
@@ -1505,8 +1507,8 @@ int write_midx_file(const char *object_dir,
 		    const char *refs_snapshot,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   refs_snapshot, flags);
+	return write_midx_internal(the_repository, object_dir, NULL, NULL,
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 int write_midx_file_only(const char *object_dir,
@@ -1515,8 +1517,9 @@ int write_midx_file_only(const char *object_dir,
 			 const char *refs_snapshot,
 			 unsigned flags)
 {
-	return write_midx_internal(object_dir, packs_to_include, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	return write_midx_internal(the_repository, object_dir, packs_to_include,
+				   NULL, preferred_pack_name, refs_snapshot,
+				   flags);
 }
 
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
@@ -1572,7 +1575,8 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
+		result = write_midx_internal(r, object_dir, NULL,
+					     &packs_to_drop, NULL, NULL, flags);
 
 	string_list_clear(&packs_to_drop, 0);
 
@@ -1769,7 +1773,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
+	result = write_midx_internal(r, object_dir, NULL, NULL, NULL, NULL,
+				     flags);
 
 cleanup:
 	free(include_pack);

-- 
2.47.1

