Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D812E11DC
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589017; cv=none; b=YnqAqZEd44ki1c9WpMRGN7l0pGvgZLWoh9ITkJqAtS9XdkMfVpyKkskG69jryCgPDMmL6q7hNSEMYJ7prQMqGv4FZASBRD/sIiredIOtZ9FSGhzv5l2RWqV97Ke/RMA2Su8F2JFOHhsrjLQmp3uT9m1l2enYTsgCV/TkYFunkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589017; c=relaxed/simple;
	bh=Wm0ZGz4C6SHWHB0ba1bldlFV0AjbZSb4mg5swBPJcco=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PO1fhIMJB9PHqsfcfGJcEQZdjTu4uESHtvcmF3XRmze0+KW09qVhyv5Q/sb7PwKLzOKq9rdlZE52yeUfz+dAqL0hH5buVp6huchcAKrnD1uqG1pn4E29kjHXYmA3ao+cLDsFSm5bkUuI1UBj/TVjB1nZGTn853nrZhr6y2LgpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7m5uqec; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7m5uqec"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109a95f09so22904021cf.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756589015; x=1757193815; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/dJRlDyh9Zlk1EuBm1NFEXvlY6D9fq0soc+ltz2Eeg=;
        b=f7m5uqectg6kfL/CFhrAUP6WVbgQeKzBWhHK7fKSWZUkdsWY5e7n9DFlclAwmQG2F0
         56PJXhmHKUYv90rTsg06uXdQgqBNF6Wb+Ok+GtvKYMfthA3JI1Onlh73Nl9E50IWt3Zs
         qCUmK+TRGE6fyrYPk/1L/hXUy4IPdFbgzLu887YJcr8Rm/lA02CSRjuKJs5UbPT4M7Gc
         Haa8Q08ZORD10dZc28eaA8Hc8XFKP7HB6+Onay6QfASYAetdMIrsalNV5As5Aw8MqcCt
         7VrQLcRQkW4az6WddQ1+c3Uhsv81PQP1QczD2z4pML0CJfqow1oqIoG0Pl/NjvOinFjo
         204Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756589015; x=1757193815;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/dJRlDyh9Zlk1EuBm1NFEXvlY6D9fq0soc+ltz2Eeg=;
        b=rGM7XNT61H9wYMRYPHnTF/1kKZ14NDFyQLM5aKnoW/KDkoyPv7qMKanaaORBvgVd74
         BZaNssVCV0Xajv8d5Xq5NBmjqLud/BG88OavsKbOsTGf5D066n/a9PC7+c4Yw0SGTUbn
         o5oOFzKXBg1LDEKYLyOuYs/RgXkX9Y0R6FAR64wXJ+QkgvqlfUEbjCfr3TvlmPwEoPdv
         BvKEWa6FN3hjIFnveRfky3TqWlcvUwsf2L5vJEPx47hHRbammQoA+uIqEX+UKJ7cPz1w
         yU6ohsOPczwhXGpW4mHKQmzmtYvXvzGefWy+5DoZNHf5QsIg90xnW9dfAdDMoY0VbE6t
         UNyA==
X-Gm-Message-State: AOJu0Yz5wPQmv3axYE/cI6AIpizJxKa8Ydfh71YNK2QrT7flk+zeMt2I
	Mdc5VXmy0WMrYeQa9ycrnB+p5J5xA3gvjqER5lVMiwIk7CXmCow+CCkjoYgIs28b
X-Gm-Gg: ASbGncuU/wcLf7bC0D3WLnEttiqMgcqCWeutMJnm9kDehDhHqaKgFTklmw0rJ5Db94O
	jtaTpIvjcX/ItazU17yTHwvZmJHbaKFzyOum7uO3Tu2VqzcA3UtGaBS7N5F1mHJJAF6DWHgLGz7
	tk5tbEaPe2WqCOXs2FOzFd90Q1wWuRJmKWI3C8FHwPKIvocRvetKfeg7QdSzSSVN0J+TdrSVKi9
	o9J8fL7ObU77GZKK1ZEdMOX9HSf6X2rmh1WN6WtnKQyPKVUvOmeUDtBaepzfTPCMxXy6r4UvI6V
	ZOaMwtVJ39jZqq2wzU/l5U2fwVRUHduelPzsfUJUpMfEMLBpWH53HMYwHmEO2k3ADkx3Xj/w/ev
	rPW0eL6DgyzsQQybUBmB/LtuHT85qmnJ4MLxY
X-Google-Smtp-Source: AGHT+IHlnqgaTJI2MC1hAwwdkzsZu6+NFu+uCMFp97NHIDoP4CVRFpeL7O5mv9DdB5dE1XSAhjWMOg==
X-Received: by 2002:ac8:5941:0:b0:4b2:f469:28b0 with SMTP id d75a77b69052e-4b31da18025mr35949391cf.48.1756589014525;
        Sat, 30 Aug 2025 14:23:34 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6abc60sm37856641cf.37.2025.08.30.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:23:34 -0700 (PDT)
Message-Id: <2290e27ded03866cb816be5fb6e08b83a75a6f07.1756589007.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 21:23:25 +0000
Subject: [PATCH v2 4/6] midx-write: use uint32_t for preferred_pack_idx
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

midx-write.c has the DISABLE_SIGN_COMPARE_WARNINGS macro defined for a
few reasons, but the biggest one is the use of a signed
preferred_pack_idx member inside the write_midx_context struct. The code
currently uses -1 to indicate an unset preferred pack but pack int ids
are normally handled as uint32_t. There are also a few loops that search
for the preferred pack by name and those iterators will need updates to
uint32_t in the next change.

For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
equality check. The macro stores the max value of a uint32_t, so we
cannot store a preferred pack that appears last in a list of 2^32 total
packs, but that's expected to be unreasonable already. This improves the
range from 2^31 already.

There are some careful things to worry about with initializing the
preferred pack in the struct and using that value when searching for a
preferred pack that was already incorrect but accidentally working when
the index was initialized to zero.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index cb0211289d..1822268ce2 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -24,6 +24,7 @@
 #define BITMAP_POS_UNKNOWN (~((uint32_t)0))
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
+#define NO_PREFERRED_PACK (~((uint32_t)0))
 
 extern int midx_checksum_valid(struct multi_pack_index *m);
 extern void clear_midx_files_ext(const char *object_dir, const char *ext,
@@ -104,7 +105,7 @@ struct write_midx_context {
 	unsigned large_offsets_needed:1;
 	uint32_t num_large_offsets;
 
-	int preferred_pack_idx;
+	uint32_t preferred_pack_idx;
 
 	int incremental;
 	uint32_t num_multi_pack_indexes_before;
@@ -260,7 +261,7 @@ static void midx_fanout_sort(struct midx_fanout *fanout)
 static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					struct multi_pack_index *m,
 					uint32_t cur_fanout,
-					int preferred_pack)
+					uint32_t preferred_pack)
 {
 	uint32_t start = m->num_objects_in_base, end;
 	uint32_t cur_object;
@@ -274,7 +275,7 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
-		if ((preferred_pack > -1) &&
+		if ((preferred_pack != NO_PREFERRED_PACK) &&
 		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {
 			/*
 			 * Objects from preferred packs are added
@@ -364,7 +365,8 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 						    preferred, cur_fanout);
 		}
 
-		if (-1 < ctx->preferred_pack_idx && ctx->preferred_pack_idx < start_pack)
+		if (ctx->preferred_pack_idx != NO_PREFERRED_PACK &&
+		    ctx->preferred_pack_idx < start_pack)
 			midx_fanout_add_pack_fanout(&fanout, ctx->info,
 						    ctx->preferred_pack_idx, 1,
 						    cur_fanout);
@@ -1040,7 +1042,9 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct tempfile *incr;
-	struct write_midx_context ctx = { 0 };
+	struct write_midx_context ctx = {
+		.preferred_pack_idx = NO_PREFERRED_PACK,
+	 };
 	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -1148,7 +1152,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		goto cleanup; /* nothing to do */
 
 	if (preferred_pack_name) {
-		ctx.preferred_pack_idx = -1;
+		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 
 		for (i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
@@ -1158,12 +1162,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			}
 		}
 
-		if (ctx.preferred_pack_idx == -1)
+		if (ctx.preferred_pack_idx == NO_PREFERRED_PACK)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
 	} else if (ctx.nr &&
 		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
-		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
+		struct packed_git *oldest = ctx.info[0].p;
 		ctx.preferred_pack_idx = 0;
 
 		/*
@@ -1199,17 +1203,17 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 * objects to resolve, so the preferred value doesn't
 			 * matter.
 			 */
-			ctx.preferred_pack_idx = -1;
+			ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 		}
 	} else {
 		/*
 		 * otherwise don't mark any pack as preferred to avoid
 		 * interfering with expiration logic below
 		 */
-		ctx.preferred_pack_idx = -1;
+		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
 	}
 
-	if (ctx.preferred_pack_idx > -1) {
+	if (ctx.preferred_pack_idx != NO_PREFERRED_PACK) {
 		struct packed_git *preferred = ctx.info[ctx.preferred_pack_idx].p;
 
 		if (open_pack_index(preferred))
-- 
gitgitgadget

