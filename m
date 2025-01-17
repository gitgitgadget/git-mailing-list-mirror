Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1941F9F74
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105686; cv=none; b=Wfsyix7OImcFqJmhwS3KUq94Fc7UAMJJbobihyDO/PEuDD3LZkFizi8A1dt5uSXyQmxbMu5/Ngbq4+G4Ee7qlE7BGKXkVP76L58HIj+3PWRfqHzMqSJXCO03+lHFbQKyD7Xq9HEiYdfnYQytVCBM7dT9iQeAy4dnL2diWRh6/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105686; c=relaxed/simple;
	bh=vn4955lD7ICrmMg8ThXo/IhTjkDfCKuJju+KaDnSbLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/D9cR/lpGtgovoeKO0L5ku5GgwHPzjzM/rZKQKN9lPCvrNgVGqyXgGj5eVAuuTBK7AE+A8VVejRjeFX2J3kO9LPuKI4mIbaBSDBVkrT/4d+jnb8ZyV+eu72wruNrgH7njrF6U4UNRaMSXiYBoJlE5iUSARE03KLxfc+53AeNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di9zN9Ow; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di9zN9Ow"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215770613dbso24713045ad.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 01:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105684; x=1737710484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk1UQ6oJZqm7WwWyDwoUPFccIhqducZWiXvQn8m+LUk=;
        b=Di9zN9Ow1JmnvnSSmdHGncLLLBJRExl4CPyipiy9Igie8Otcg5vux0ZUA5nO/azHC6
         +kN9+QEA0dByxnuLAwAgGhQhmt9L4hpzF7Qg/FTnGCWU76L4oberKCsvh6fVReclakwF
         nt3vmBl0rSAr2PYBWEVN3gn7SmW5NeHBQLjLeJt0KYBSPfNAXSCA7/QcTrYYpD+on2Jc
         jFAQ9BbBbDcEfD29fJFDfmMccR93T4J+9daPsdsBjwEGnElpqPxWF543j8jKJNTnjn7j
         KK3rGd9lpT1PctY+Dbctb+MpG8baOeknBkomIYG2/TyCuZGQPAfP1DO6RAWdtO8oleRK
         jZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105684; x=1737710484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zk1UQ6oJZqm7WwWyDwoUPFccIhqducZWiXvQn8m+LUk=;
        b=heyfJ3lGVmpReqNG8+gFMWijThj+poQoywYK4gZQGEQ1lITgJFyyg19jz5SjKgvcNe
         evK4QsVnanrzTNsJuyUhp98RBTqEp4grJHhorNrFeLzsOEJ+iBIIvVmjT53Tzd6RWyrg
         OEVxEuLKz2ct76MOqsQA46B+buKeWegY7rb8Q2HocjX50WFEhAz6OpIe45pQKXdwGgBb
         MCtdaA2GL709FhDCpUUcQG3nsX69viivfS+wcH9cRBBJs39wy4jkgGGft8PpMF4GYuuw
         GKQlGj/hSaPrgKTrsAGTrqTD8qTX5+F7slr6oSdmGju1D9SqmkZcw0DbKIGXOENKSwOj
         CNsg==
X-Gm-Message-State: AOJu0YwDbWu2TwKatln0xSf2A/WIeF8CPYqsqkmKvdDZGHcFUkcF8nHH
	XzzueMpdvM9taA+ce5uybK8NekrBHPeKe0uV6vGeiOBR8lNL3INytvZfkIl/
X-Gm-Gg: ASbGncs9avsQhCWAfYfZDybkT1ZiKDaDRxAj1p4er68thlanVIhsavTzYeap+oWlJUl
	2DvGtjjiV6opcH4+eg7sqiQloSIwATa9+ZyXvMU+eZSLZHVQZhgrSHEe5shYYlqGvTP8q6CUW6W
	fug0xfy5hzh2lRGaDLDf6FtVEVM1MQefagyjgxYwJT+21o88H5anLLrl4rAvTMDwZ8LX8Revlcf
	6qexI9dmO7Up0D60lF2rCON25DtoUk+OiWMNv8GaXhhGgWwLeJGR4LzFZQ=
X-Google-Smtp-Source: AGHT+IGNeTH6irJt6i7z3sRWHpDLCqI8aaHOsEEck1WsYwQbFnFwM+HjyIn8x/KGW2fVrMhB1hyeWg==
X-Received: by 2002:a17:902:d4cf:b0:215:a97a:c6bb with SMTP id d9443c01a7336-21c35400a0dmr30824915ad.12.1737105683757;
        Fri, 17 Jan 2025 01:21:23 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm11714065ad.173.2025.01.17.01.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:21:22 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 10:20:50 +0100
Subject: [PATCH v2 3/5] pack-write: pass hash_algo to `write_idx_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-kn-the-repo-cleanup-v2-3-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7524; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=vn4955lD7ICrmMg8ThXo/IhTjkDfCKuJju+KaDnSbLE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKIQeUVuWfcvgL4KR20mUtxMGY8RPOjTvJs
 Zdzit4k6Z9SO4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniiEHAAoJED7VnySO
 Rox/hxoMAJl86aomyrIBJV9R5GkLF9Qz8o+WzhBjrEyKO8FMk2rRObAIslfQgaxUXY+s/VPetbB
 ueUrgm5L6j5pQvjUTFk1dL8Uy49zzyBIJyBUPNU3VuJ6JBZgNSgde6CSomBMYlEe5o4beMmmBKX
 P63B9tbbMwOmP1vGpx7g6NgscjxrCfa09Cya3qPMPUTabfsWsaqzXUIt+IWaA5WsqTiCJZi7YRT
 nhtux7JS3m7rLGQrdZbuezeq5QonpNVGcnk0qp0+3252oXoomAIbHy/X/Mi0n0VT534BBljahWm
 b0VzbJKwDp1IyAH5UjSQs5mva2gx0fR309dYm730MWxa9IL3zdTAvBe0jxJH8lISUgYyjQxTqlU
 aBJ0+ianIY6aWH4nzvLppquTM/G1lbWq4aao2asPbYRrOuhCVqCUsRnTJT4PEGjzZdf20NqjAo4
 Ct9Vq+R7ewsAeyb1QaPuksM0cbFjLWRvChK06DsIi/jGgTJCG9eGe3+k6ysm+ZaLtuWgdivhA46
 fU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_idx_file()` function uses the global `the_hash_algo` variable
to access the repository's hash function. To avoid global variable
usage, pass the hash function from the layers above.

Since `stage_tmp_packfiles()` also resides in 'pack-write.c' and calls
`write_idx_file()`, update it to accept `the_hash_algo` as a parameter
and pass it through to the callee.

Altough the layers above could have access to the hash function
internally, simply pass in `the_hash_algo`. This avoids any
compatibility issues and bubbles up global variable usage to upper
layers which can be eventually resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c  |  4 ++--
 builtin/index-pack.c   |  3 ++-
 builtin/pack-objects.c |  7 ++++---
 bulk-checkin.c         |  5 +++--
 pack-write.c           | 14 ++++++++------
 pack.h                 | 10 ++++++++--
 6 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 6baf2b1b71e2443a7987a41e0cd246076682bf58..c4bc52f93c011f34bd7f98c8e9d74a33cf9783bd 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -798,8 +798,8 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts,
-				 pack_data->hash);
+	tmpfile = write_idx_file(the_hash_algo, NULL, idx, object_count,
+				 &pack_idx_opts, pack_data->hash);
 	free(idx);
 	return tmpfile;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6c5e3483f4fe67fb2e26132c55b1f8395d60c11f..d73699653a2227f8ecfee2c0f51cd680093ac764 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2096,7 +2096,8 @@ int cmd_index_pack(int argc,
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(index_name, idx_objects, nr_objects, &opts, pack_hash);
+	curr_index = write_idx_file(the_hash_algo, index_name, idx_objects,
+				    nr_objects, &opts, pack_hash);
 	if (rev_index)
 		curr_rev_index = write_rev_file(rev_index_name, idx_objects,
 						nr_objects, pack_hash,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ffc62930b68c9b4152057572ede216381a4b0991..7b2dacda514c29f5393b604f15d379abb81546c0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1369,9 +1369,10 @@ static void write_pack_file(void)
 			if (cruft)
 				pack_idx_opts.flags |= WRITE_MTIMES;
 
-			stage_tmp_packfiles(&tmpname, pack_tmp_name,
-					    written_list, nr_written,
-					    &to_pack, &pack_idx_opts, hash,
+			stage_tmp_packfiles(the_hash_algo, &tmpname,
+					    pack_tmp_name, written_list,
+					    nr_written, &to_pack,
+					    &pack_idx_opts, hash,
 					    &idx_tmp_name);
 
 			if (write_bitmap_index) {
diff --git a/bulk-checkin.c b/bulk-checkin.c
index c4b085f57f74fb8b998576ac9d84fed9e01ed0ed..0d49889bfbb233d58fc094f5e2c2d2433dad9851 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -44,8 +44,9 @@ static void finish_tmp_packfile(struct strbuf *basename,
 {
 	char *idx_tmp_name = NULL;
 
-	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
-			    NULL, pack_idx_opts, hash, &idx_tmp_name);
+	stage_tmp_packfiles(the_hash_algo, basename, pack_tmp_name,
+			    written_list, nr_written, NULL, pack_idx_opts, hash,
+			    &idx_tmp_name);
 	rename_tmp_packfile_idx(basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
diff --git a/pack-write.c b/pack-write.c
index 0cd75d2e55419362a61cf981fc11117ea7a1d88a..f344e78a9ec20cea9812a5eaffc72ae0b7e7424d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -56,7 +56,8 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
  * The *sha1 contains the pack content SHA1 hash.
  * The objects array passed in will be sorted by SHA1 on exit.
  */
-const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
+const char *write_idx_file(const struct git_hash_algo *hash_algo,
+			   const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
 			   const unsigned char *sha1)
 {
@@ -130,7 +131,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		struct pack_idx_entry *obj = *list++;
 		if (index_version < 2)
 			hashwrite_be32(f, obj->offset);
-		hashwrite(f, obj->oid.hash, the_hash_algo->rawsz);
+		hashwrite(f, obj->oid.hash, hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
@@ -172,7 +173,7 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		}
 	}
 
-	hashwrite(f, sha1, the_hash_algo->rawsz);
+	hashwrite(f, sha1, hash_algo->rawsz);
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
 			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
@@ -546,7 +547,8 @@ void rename_tmp_packfile_idx(struct strbuf *name_buffer,
 	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
 }
 
-void stage_tmp_packfiles(struct strbuf *name_buffer,
+void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
@@ -561,8 +563,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
 
-	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
-					       pack_idx_opts, hash);
+	*idx_tmp_name = (char *)write_idx_file(hash_algo, NULL, written_list,
+					       nr_written, pack_idx_opts, hash);
 	if (adjust_shared_perm(*idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
diff --git a/pack.h b/pack.h
index 46d85e5bec787c90af69700fd4b328b1ebf1d606..c650fdbe2dcde8055ad0efe55646338cd0f81df5 100644
--- a/pack.h
+++ b/pack.h
@@ -86,7 +86,12 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
-const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
+const char *write_idx_file(const struct git_hash_algo *hash_algo,
+			   const char *index_name,
+			   struct pack_idx_entry **objects,
+			   int nr_objects,
+			   const struct pack_idx_option *,
+			   const unsigned char *sha1);
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
@@ -119,7 +124,8 @@ int read_pack_header(int fd, struct pack_header *);
 struct packing_data;
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void stage_tmp_packfiles(struct strbuf *name_buffer,
+void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,

-- 
2.47.0

