Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398391F91C3
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105680; cv=none; b=myY6vfh7lsnVDT0napoQ7dX/rF8w/UHhyDpYGGXWWtbwOk9Kp1U9RuK8zW/ZngTt7o2PtC+i/31TzFitFUdAR1NUQv4yvcBHpNL5FXw0CHDcmfm0+TvjWCvS0C4FDuhvDIRjZ/ObTRtgYZbOGKOz1Y5gh7cPP7MF6MiT1dDMXSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105680; c=relaxed/simple;
	bh=Q3YTpVPctjeWQ1SI5ZHfabnjeICNZIAxFUmfeObUWxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2zoMVQ9r4o9NBZRMi8W0GlSKImOldJTPYbcvW7nUtd1mTSRF2XfIj+9DdOPIgXpWrcCGeMjz6+GfpjN8oKdG1dQdGeTYHqFuvlDWbrGCAH2L8qFBqk3oe9PMy6DFLZaTUX68rd6pvJimaHnPTGwXrJ5Nuyc+4DlGUykik3IKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvetGq2c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvetGq2c"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216281bc30fso42990225ad.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105678; x=1737710478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cG/8Kxa+G1FdV/BsesI0eK2yhTEIBu4vHbqMzWuN1eM=;
        b=fvetGq2cQktJA4b0y1SMSBIAkLLDlhFj2lDhn7QOFmSIKB1ivqqSVpkf4AN7YV2yF2
         WkpsJkL23pVm7FYfUNaFN0krdgwQcp5A4WS70/XdgGMBNu8jCk/5mplyefx35OMgvpLF
         l04ZXTNOXYYdd91/SZLLyCoghlA3KramJPCxlNcWDy9Y0H4H87XiG8ArIb0mO2CfJjq3
         Pkg2XDe6PFRaKtnvVvmLv2V/yJlrfm5c2mBDyfbVGFt6MUaZ4T++hpM8iWklQv95uv1Z
         KpeBgQLJmB7K4qGPyuk7bFbgbbznDSq/RgAteVB2kEhNOfxV8wVVC8EBPHHHNWfXE7d7
         nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105678; x=1737710478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG/8Kxa+G1FdV/BsesI0eK2yhTEIBu4vHbqMzWuN1eM=;
        b=BY/lKQvShfcT08jEma4rIzbWcEObpHl1lwhIXuUPHJ0fIPFC16YFuiJnTX1x5I9Hx5
         ro8ct3hwFkLJtSeuNMD6AHSn2AIkme7bx9XRUlrUeR0K8WyC+Q+1FR4xKm2waZbgMVi1
         aFscXP7u1EfxEcYEiaX7wkSigsEDJbWhkra5jmVwNL0giIfL5WrsDlaUI1QNuhDLOuxi
         wo26Gr0YlYFvH3uNfcO2+Qc99RR6QjnC7v/dajY+cwi0bS1N0IltmBdeLD+bQOXrBBIg
         GnvY8aGzQGkWqJ123jffHdC3LHBWZu39FPI1OHkE/6Tvop/D56uDsjkV5ibbGnEAKkou
         5yjQ==
X-Gm-Message-State: AOJu0Yz8Hg8Bd6ehEfpTw/D1bXFq33BcPAQwRTpJND8iStA7gs1iSDpp
	9sCDdtEKpIDAXScmPZFYoNHlSuG9G0A8Xejn1WLcdA7oBcjDjXHmVoOflhYR
X-Gm-Gg: ASbGncuM9qGyZgiSg3mYIUVBOY/bZ6DUkAyhNrr2MxJtlQfpRP//wPWBBh5XV25ATdO
	y4/7LjGCZTQY8eVR6NoMNmGyFP/cDj7IZRMKFBWgxu2wlPGsnoiJx9rGt4eyyFVe9FxHxVXzVs+
	GrN681Ep4nekoys2W2MyPqICZwQ+P37g88XytN1aCiFtODg3t3XGUHD5EtQK2TZKxPGz9RA3/OM
	YFAhOL9KobO2xgwrQubI/4wtrsUvVzL+u2ojEktaGlKtOSvGtV+LZVS5g4=
X-Google-Smtp-Source: AGHT+IHZgZHd3uUl6aSIl59o7yHVE1o6rTIOQCCF7CWbIuLgOxANrT2oKqcS6NGvcxfpC4IQ1+UGZA==
X-Received: by 2002:a17:902:d4c8:b0:216:2e6d:babd with SMTP id d9443c01a7336-21c355beb90mr34200325ad.15.1737105677868;
        Fri, 17 Jan 2025 01:21:17 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm11714065ad.173.2025.01.17.01.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:21:17 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 10:20:48 +0100
Subject: [PATCH v2 1/5] pack-write: pass hash_algo to
 `fixup_pack_header_footer()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-kn-the-repo-cleanup-v2-1-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7847; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Q3YTpVPctjeWQ1SI5ZHfabnjeICNZIAxFUmfeObUWxA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKIQcEscebP3IscXsjZkrWx0bSGuzhBR1K3
 Mf2LM76R0Y2lYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniiEHAAoJED7VnySO
 Rox/owML/RVQ+/xyU0tqN86RVmzziwffggh885EoQ1GEcubgxcYlal8cAaO6xXUsS1HhMJIfjA+
 6CHuUW+3mp0EEIdk8f1Ip0yTz+YpCwBLIa3xDrO4ZNUTMMjKaEMAttrjCT/dSGWSlRniuNl7wUv
 rxzP78dGiCpRHib2hVrlgf4WkPahgRQSjejbW6wk1bhV43TaGRsmbKZZnGeMcsaJeH1pwTEDQTY
 S+h1Gw1Ti1N/BLz4uX/EQU+3R5p95SCyqIn0CE8xQAvsZUYdRPDMjVxQEWMMWw8eZq7LaEwNMLX
 jM6shqoU3hfexGx0P4LJ8iVFV1dLoSHlWowb8lxs7IOY+2KBmQd37JLX5yPwNSYW91Y2co1Nlvo
 pjl8H27RUgm4entP2/QahGztHWkxN+TfKr6MP1e3WZLvAFvqfyhoZYOJW51Chp4igiQvQ6O3c0M
 1BDdRGQ8iku90NA6pZscmadU2X+wW6ybgLR62ZV9hbx1mrkswblvE8NKM9YfjOXSK7aO+fwspx5
 og=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `fixup_pack_header_footer()` function uses the global
`the_hash_algo` variable to access the repository's hash function. To
avoid global variable usage, pass the hash function from the layers
above.

Altough the layers above could have access to the hash function
internally, simply pass in `the_hash_algo`. This avoids any
compatibility issues and bubbles up global variable usage to upper
layers which can be eventually resolved.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c  |  7 ++++---
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  5 +++--
 bulk-checkin.c         |  2 +-
 pack-write.c           | 28 ++++++++++++++--------------
 pack.h                 |  4 +++-
 6 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa..6baf2b1b71e2443a7987a41e0cd246076682bf58 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -878,9 +878,10 @@ static void end_packfile(void)
 
 		close_pack_windows(pack_data);
 		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
-					 pack_data->pack_name, object_count,
-					 cur_pack_oid.hash, pack_size);
+		fixup_pack_header_footer(the_hash_algo, pack_data->pack_fd,
+					 pack_data->hash, pack_data->pack_name,
+					 object_count, cur_pack_oid.hash,
+					 pack_size);
 
 		if (object_count <= unpack_limit) {
 			if (!loosen_small_pack(pack_data)) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0bef61c57232e198ba539cd44ec301d26dcb0eb8..6c5e3483f4fe67fb2e26132c55b1f8395d60c11f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1390,7 +1390,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		strbuf_release(&msg);
 		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
 		hashcpy(read_hash, pack_hash, the_repository->hash_algo);
-		fixup_pack_header_footer(output_fd, pack_hash,
+		fixup_pack_header_footer(the_hash_algo, output_fd, pack_hash,
 					 curr_pack, nr_objects,
 					 read_hash, consumed_bytes-the_hash_algo->rawsz);
 		if (!hasheq(read_hash, tail_hash, the_repository->hash_algo))
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d51c021d99d9f470c04b7ec52565ab2f4c1c19ae..ffc62930b68c9b4152057572ede216381a4b0991 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1319,8 +1319,9 @@ static void write_pack_file(void)
 			 */
 
 			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
-			fixup_pack_header_footer(fd, hash, pack_tmp_name,
-						 nr_written, hash, offset);
+			fixup_pack_header_footer(the_hash_algo, fd, hash,
+						 pack_tmp_name, nr_written,
+						 hash, offset);
 			close(fd);
 			if (write_bitmap_index) {
 				if (write_bitmap_index != WRITE_BITMAP_QUIET)
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 5044cb7fa083d692a3797e2491c27b61ec44c69c..c4b085f57f74fb8b998576ac9d84fed9e01ed0ed 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -70,7 +70,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
 		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
-		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
+		fixup_pack_header_footer(the_hash_algo, fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
 		close(fd);
diff --git a/pack-write.c b/pack-write.c
index 98a8c0e7853d7b46b5ce9a9672e0249ff051b5f9..fc887850dfb9789132b8642733c6472944dbe32d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -380,7 +380,8 @@ off_t write_pack_header(struct hashfile *f, uint32_t nr_entries)
  * partial_pack_sha1 can refer to the same buffer if the caller is not
  * interested in the resulting SHA1 of pack data above partial_pack_offset.
  */
-void fixup_pack_header_footer(int pack_fd,
+void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
+			 int pack_fd,
 			 unsigned char *new_pack_hash,
 			 const char *pack_name,
 			 uint32_t object_count,
@@ -393,8 +394,8 @@ void fixup_pack_header_footer(int pack_fd,
 	char *buf;
 	ssize_t read_result;
 
-	the_hash_algo->init_fn(&old_hash_ctx);
-	the_hash_algo->init_fn(&new_hash_ctx);
+	hash_algo->init_fn(&old_hash_ctx);
+	hash_algo->init_fn(&new_hash_ctx);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
@@ -406,9 +407,9 @@ void fixup_pack_header_footer(int pack_fd,
 			  pack_name);
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
-	the_hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
+	hash_algo->update_fn(&old_hash_ctx, &hdr, sizeof(hdr));
 	hdr.hdr_entries = htonl(object_count);
-	the_hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
+	hash_algo->update_fn(&new_hash_ctx, &hdr, sizeof(hdr));
 	write_or_die(pack_fd, &hdr, sizeof(hdr));
 	partial_pack_offset -= sizeof(hdr);
 
@@ -423,7 +424,7 @@ void fixup_pack_header_footer(int pack_fd,
 			break;
 		if (n < 0)
 			die_errno("Failed to checksum '%s'", pack_name);
-		the_hash_algo->update_fn(&new_hash_ctx, buf, n);
+		hash_algo->update_fn(&new_hash_ctx, buf, n);
 
 		aligned_sz -= n;
 		if (!aligned_sz)
@@ -432,13 +433,12 @@ void fixup_pack_header_footer(int pack_fd,
 		if (!partial_pack_hash)
 			continue;
 
-		the_hash_algo->update_fn(&old_hash_ctx, buf, n);
+		hash_algo->update_fn(&old_hash_ctx, buf, n);
 		partial_pack_offset -= n;
 		if (partial_pack_offset == 0) {
 			unsigned char hash[GIT_MAX_RAWSZ];
-			the_hash_algo->final_fn(hash, &old_hash_ctx);
-			if (!hasheq(hash, partial_pack_hash,
-				    the_repository->hash_algo))
+			hash_algo->final_fn(hash, &old_hash_ctx);
+			if (!hasheq(hash, partial_pack_hash, hash_algo))
 				die("Unexpected checksum for %s "
 				    "(disk corruption?)", pack_name);
 			/*
@@ -446,7 +446,7 @@ void fixup_pack_header_footer(int pack_fd,
 			 * pack, which also means making partial_pack_offset
 			 * big enough not to matter anymore.
 			 */
-			the_hash_algo->init_fn(&old_hash_ctx);
+			hash_algo->init_fn(&old_hash_ctx);
 			partial_pack_offset = ~partial_pack_offset;
 			partial_pack_offset -= MSB(partial_pack_offset, 1);
 		}
@@ -454,9 +454,9 @@ void fixup_pack_header_footer(int pack_fd,
 	free(buf);
 
 	if (partial_pack_hash)
-		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
-	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
-	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
+		hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
+	hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
+	write_or_die(pack_fd, new_pack_hash, hash_algo->rawsz);
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
diff --git a/pack.h b/pack.h
index a8da0406299bf267205256aaa8efb215f2ff73be..6d9d477adc83e83d9e9175ccf699c100b4c147c6 100644
--- a/pack.h
+++ b/pack.h
@@ -91,7 +91,9 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offs
 int verify_pack_index(struct packed_git *);
 int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
 off_t write_pack_header(struct hashfile *f, uint32_t);
-void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
+void fixup_pack_header_footer(const struct git_hash_algo *, int,
+			      unsigned char *, const char *, uint32_t,
+			      unsigned char *, off_t);
 char *index_pack_lockfile(int fd, int *is_well_formed);
 
 struct ref;

-- 
2.47.0

