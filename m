Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC82905
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285586; cv=none; b=hkBRVTEI3A9aeo2mv47ifB85ouRT00AXv4TEShmaEXa9199PZFuCKmmTAUaxAmRWekuPGQH/TiyzBFQXmLntFYjR5yX7EMk9a95EzJVwuoojzh7exMP79btgkhrvFn5WkNC5RKFpZApGeuisg1UYOs/GzgujxRsn+SxrFwgab14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285586; c=relaxed/simple;
	bh=z/hvDkk2DJ15vSRotsVQFINNIZHtpQSKKB/IRckKOa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwFFBjVWjTJOBbk1CGCq2gvQ73Wduno0YQoJfDWNSgId3vXQSTjtH9tSOx1CJyO+dPXL6tI94zUy6qvpkh9UfVAJUu/O9ePHGf6V/iuuRszuwBX2jX0L4pacyv1behMhcRNq/762nL6CR3GKDfVcPUOMUFyTC4+LfeO1o8I/zh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUnKTS0/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUnKTS0/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216281bc30fso82689825ad.0
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285584; x=1737890384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ordz7YpAXEG5TId6d9ADjSwqJ0gwgziIasGjel0WM3M=;
        b=VUnKTS0/2OKJGcrTqhMwLF7XKqqiNE2kSuSAq9UX4lhFd0HTxyyNwakdtg+sBcybFt
         RuDXgxE6c9Z920J+Gt1FlKQ2ZDKnPvESfIRdDj2e99eeGurrf7mVejbP/r8pfngOHsXB
         INSmcZGiLnG2z0Zvcv+cpG1/0bmo2tU4kRnLGAklCDVQdBYdN1k1e7tBfgb4kdED1V2m
         VmcDrLVycy934izC+nbgJicchTOj3AS0L8jHiiplX9oUZFQcxQ65loI8L6TIhe4o7Obt
         tIC198WFxQbxkSUYL0z+64VqOS8w0XBclMPLmyA2gpHcDDYCnNVEayrrqt7Lo7LlPktP
         5uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285584; x=1737890384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ordz7YpAXEG5TId6d9ADjSwqJ0gwgziIasGjel0WM3M=;
        b=d6/p82z+xxf+80za51K/60zrnWVpnUHsh0Mnpin/EOGpkNi2od93eYg/WFkszZZOtT
         t5aWGVZuInzz3jEIe23lDuKPfNximrqAsjeBgG1a5EvJi51vH/YQSeAPchkRptbBYYpl
         Hw8ajZuGnMVQKO7gmmOWEJAAg2EDn6fnQTrjI1glz0oVfeuN44pWSy3+ISP8E7B89uFE
         wYS+jgPr8croQUuuOv2gnSkvXICwcnmi3LN5MQFv2TZsqZSsFhQK29ZAHriapqJH8XWN
         10IWExxitvG4XVyKjPXSwv41ZI+Zc4zcaZDcMoWmxr2hTv5Xf8ysCL+WFySqzCL4s6hd
         BB2Q==
X-Gm-Message-State: AOJu0Yyem1VfL/VhLvlBXN1YYwPKjz9h87j1fBNku8b950shE220eq24
	cHDoay070cujbUiVTw3hF9FNLNa6+Nc14+S3oviF3V7qBKE+33X/
X-Gm-Gg: ASbGncthwzmpDpYD+1dcY4oo1PPURe01WKeZEkOTi52OWLcPViojxupmoVVR6XigWSN
	YXxGYXh6PUeJQHqvbW6+hODHD2PynohQRXd0mJ379n//cVAiBUgCpQKI3rC0AsLKVYM1qXPh/5g
	pbpW9IIh97A1AaFMq7GJl7buhA9DdGPCozySHLBLQQBasSlMXSoIJkJdToqXWFWC1khHbmcbsbU
	h7B96Ov3zkcejgeDmhnljf6iAlSQcjAjdSMr8OUhW7sXPPPx0X33sFcDihdVeuDjyfEhqis
X-Google-Smtp-Source: AGHT+IHBDr+tvds5u8Lr+6j6ZXvywbG+7zy07/2crYXMe+dSjmMweWj7OsjqGUdbbBgs+MjbArWdbw==
X-Received: by 2002:a17:902:e544:b0:21a:87d1:168a with SMTP id d9443c01a7336-21c3563c6e6mr143798515ad.41.1737285584341;
        Sun, 19 Jan 2025 03:19:44 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cfbd01fsm43031415ad.104.2025.01.19.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 03:19:44 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 19 Jan 2025 12:19:28 +0100
Subject: [PATCH v3 3/5] pack-write: pass hash_algo to `write_idx_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-kn-the-repo-cleanup-v3-3-a495fce08d71@gmail.com>
References: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
In-Reply-To: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 toon@iotcl.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7519; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=z/hvDkk2DJ15vSRotsVQFINNIZHtpQSKKB/IRckKOa8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeM38Xa30gtdQYv21Ke/RSnk27f3qgLikbI5
 YR0Vo16QoQnqIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjN/FAAoJED7VnySO
 Rox/CUYL/1eTJ4fjHMuUlM89RBeb4ni2MJMhF7rLln7/vZaZLbEvgVvOyS/zmH3T7YiKFEoZ/IH
 ngll68mZQ94tX7B8Ru1/dJ+jDTJbUbH9v4HBkhfsX0pC66qgKdXjkvew25KqlW9VWziCeVoG1r/
 eZbSmN3DNj91ngFvipZbwInAnA7NTYpKFRJ6L3iJ8fBjiJTvOLqTeU0nJ/bAmVwpZUPGMOrF9WW
 XMe2BQNa3/1m43pBQjXtFJJNe+lKyC5iBZSTdod7R95NL8nm+w57nq/P1ninZ37X+CIcwno8xCX
 OFkVALPQ0boFR7Psra+/txa0QXfmYx8v8GNPeeEWrS5AzCz3Az5di9vOCeoG9YFPMF0Ie++HBQ5
 LHXVioxmKjqmGp6kuJE7x4Y87kFh/TkPWdrQvT2iwZPzR9aknIL9nbeYOEmcJklKslofGqe821r
 hPL8NjINl6+hEkpUFm+3soRXa2vKoVEAmPsdXCqlXsNnfd/Gw9BRPr/M4yfTgN1kbMwXK4O9U27
 NM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_idx_file()` function uses the global `the_hash_algo` variable
to access the repository's hash_algo. To avoid global variable usage,
pass a hash_algo from the layers above.

Since `stage_tmp_packfiles()` also resides in 'pack-write.c' and calls
`write_idx_file()`, update it to accept a `struct git_hash_algo` as a
parameter and pass it through to the callee.

Altough the layers above could have access to the hash_algo internally,
simply pass in `the_hash_algo`. This avoids any compatibility issues and
bubbles up global variable usage to upper layers which can be eventually
resolved.

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

