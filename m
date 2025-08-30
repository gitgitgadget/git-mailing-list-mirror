Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773F2E7647
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756589020; cv=none; b=lWHBglo/jW3LaMDrtDDv7G+hO9JvpMcZ4I+1gwohD9sXpQCaMULYXd248wZIZsyM8bm5eJQUkUiSflBIvfxPsIspBH7cgekUi34rEfxF68CrIFnO253lwjgTDBNGGaDHDUYpEkIsQawqpP80bsoIQ4WDNGIQjCrF/udaB233M18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756589020; c=relaxed/simple;
	bh=25BA0StLKx197HcW4B5YQukfFhZvDmkthAsHUMZ1MzA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fc/wx4SFz7vZX/7MKSk7ZQEYvqRrgpLZ+ubXjJNPOMpUeDRb0bVjcjqmAHCsi+bKM2NtmNfeQ7r2bxant8lK6djmWFB+oXRGFaDS7QAbGqKK42gdQS6qAe66/qfzwhRS6Oe8swnsJh6PXhnOzJo6mrMuAeul/8IIyn5ds5+e7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE37s2x7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE37s2x7"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-71241d44792so3736696d6.0
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756589017; x=1757193817; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3rICOWjRwhV9y11+50KykD6ObPcP6DvA9UxpXNOpuc=;
        b=EE37s2x7CSEHrPJ7X/LMq/rp1dG+8Kj1QUVXBjudpnn8z1pIfleInDrPzHccfc2d3+
         26x+fkD5aNCf5ecnr07V+DFk3t3C1Hr2hweKAeTcmHCxKtBJNfD6WKiXJN40q8kIE+iO
         ZN2uS37OB5lPRnkMB+rOZEd7JkT7Sqv8HuN5bHKRXXa0A7AJjqVZ5fn1pQx6ks7+V1WE
         +VeItqGesh2FZTwm16W5LBi7+BbFKTATI80eoI04DIkf+aHb/iKyL1FrpP3ANrmFVpRN
         dJylF8CiCwXuZlfgdYIjXZWObyv9bVEHscfNs+DTO18vGCm/3S0zl4zQEGmz6QIH10cn
         oyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756589017; x=1757193817;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3rICOWjRwhV9y11+50KykD6ObPcP6DvA9UxpXNOpuc=;
        b=qYH0LRF4UaGcwubxHTeRNVT/qGqjeQgjzcPHyJYnRRWAP8rYx1JM9E7rLeyrjG1Mq2
         CF49zXvPRfUJkYR7RtE+27uE1QuIzJomtBoyATcs5OLsD0opcAa+f5UVTN10kfUx244/
         8dDqbkD7NsD0FuxQtcui+61vQ98gZnze12dgqibIHauTb/tRPEVD7pggLOVbJJyyjKSU
         2bWmsEANcqM62u5tzw2t4M1JQwvB/W5GYyXrvtglL7Hu5YW4NRPt+nzBK1gc9KxspSx4
         9pVBl23qaTcXad0D8xljVbtfHAMsGOPe25OYwNi6p3mysgXyCXWfc0UaI602glTIgKlw
         cSwQ==
X-Gm-Message-State: AOJu0YyGiFJ6+NxcKXghYZjxaxI6DJ9w40riA39ejK8u6d7PNQ+muXCH
	wNKX5n5jOB4Rc557KroeFxhLIC195umYXMIpk/Pqb38BMuWiZrwocYK/Uvk6jx38
X-Gm-Gg: ASbGnctfYykEID4BJHYUIv3vA/8NzdWLFLJFsmNueQkwxQ+25VomjFPbT7vKRaHgpVa
	LhwaEeHGd/V3GFWQECbPKom+UeDSaHPDDg56PZ57kWNGfBjQW07uA75Lkgyj7iACVy9r2GJ3idm
	kPmb1N3rMvXspWjXgYj8d9ODLNG85spxD2F2hl9hSm4SGcDblB0/oUSUX6vkzphxSp38IcsrTGh
	z46/ZZRpyb0EIar7WQ0KByhU9gwAvrOWhwZK2+t1ozLnVaudBeAFzBZYpFGMwFTNxRYkjQiaOn0
	brS8uMjDAUEmbyX09LJ3/v2z1pTqR64iIhvjl2WApyNZBSAqA/4rsSCfzLTLLCwLzWJMXuo3UO4
	ZXrIqH1IXeHZ9IF2toF6hG8OrOG9oD6PyrSxUjScIJiwnfwE=
X-Google-Smtp-Source: AGHT+IFxv+ZNqWpIJGjAyqGkkjhrE0KR4g2pWKOSlkHW1NONXXXrBsMWp/J2COF0gwg6TwUTUNpxJQ==
X-Received: by 2002:ad4:5de9:0:b0:70d:e88f:ec36 with SMTP id 6a1803df08f44-70fac9467damr38485126d6.60.1756589016724;
        Sat, 30 Aug 2025 14:23:36 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb2633a7dsm11663076d6.24.2025.08.30.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 14:23:36 -0700 (PDT)
Message-Id: <7be25cf5349c389cf2887ab5b852779fc364bd7e.1756589007.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Aug 2025 21:23:27 +0000
Subject: [PATCH v2 6/6] midx-write: simplify error cases
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

The write_midx_internal() method uses gotos to jump to a cleanup section to
clear memory before returning 'result'. Since these jumps are more common
for error conditions, initialize 'result' to -1 and then only set it to 0
before returning with success. There are a couple places where we return
with success via a jump.

This has the added benefit that the method now returns -1 on error instead
of an inconsistent 1 or -1.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 14a0947c46..047ffdcdbf 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1046,7 +1046,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	int bitmapped_packs_concat_len = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
-	int result = 0;
+	int result = -1;
 	const char **keep_hashes = NULL;
 	struct chunkfile *cf;
 
@@ -1099,14 +1099,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 				error(_("could not load reverse index for MIDX %s"),
 				      hash_to_hex_algop(get_midx_checksum(m),
 							m->repo->hash_algo));
-				result = 1;
 				goto cleanup;
 			}
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
 	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
-		result = 1;
 		goto cleanup;
 	}
 
@@ -1142,12 +1140,16 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			 */
 			if (!want_bitmap)
 				clear_midx_files_ext(object_dir, "bitmap", NULL);
+
+			result = 0;
 			goto cleanup;
 		}
 	}
 
-	if (ctx.incremental && !ctx.nr)
+	if (ctx.incremental && !ctx.nr) {
+		result = 0;
 		goto cleanup; /* nothing to do */
+	}
 
 	if (preferred_pack_name) {
 		ctx.preferred_pack_idx = NO_PREFERRED_PACK;
@@ -1221,7 +1223,6 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		if (!preferred->num_objects) {
 			error(_("cannot select preferred pack %s with no objects"),
 			      preferred->pack_name);
-			result = 1;
 			goto cleanup;
 		}
 	}
@@ -1260,10 +1261,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			}
 		}
 
-		if (missing_drops) {
-			result = 1;
+		if (missing_drops)
 			goto cleanup;
-		}
 	}
 
 	/*
@@ -1309,7 +1308,6 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
-		result = 1;
 		goto cleanup;
 	}
 
@@ -1329,14 +1327,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		incr = mks_tempfile_m(midx_name.buf, 0444);
 		if (!incr) {
 			error(_("unable to create temporary MIDX layer"));
-			result = -1;
 			goto cleanup;
 		}
 
 		if (adjust_shared_perm(r, get_tempfile_path(incr))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(incr));
-			result = -1;
 			goto cleanup;
 		}
 
@@ -1414,7 +1410,6 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 				      midx_hash, &pdata, commits, commits_nr,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
-			result = 1;
 			clear_packing_data(&pdata);
 			free(commits);
 			goto cleanup;
@@ -1440,21 +1435,17 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
-			result = -1;
 			goto cleanup;
 		}
 
-		if (link_midx_to_chain(ctx.base_midx) < 0) {
-			result = -1;
+		if (link_midx_to_chain(ctx.base_midx) < 0)
 			goto cleanup;
-		}
 
 		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
 					    object_dir, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
-			result = -1;
 			goto cleanup;
 		}
 
@@ -1487,6 +1478,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	clear_midx_files(r, object_dir, keep_hashes,
 			 ctx.num_multi_pack_indexes_before + 1,
 			 ctx.incremental);
+	result = 0;
 
 cleanup:
 	for (size_t i = 0; i < ctx.nr; i++) {
-- 
gitgitgadget
