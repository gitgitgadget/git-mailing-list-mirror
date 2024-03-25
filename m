Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F976401
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387473; cv=none; b=XRMZCYFonYe8UrknKqOV/usxveXuh6Ayx1h5N+BvbUEjX6IE0qkReF8xGLJ+gED7Ld1xxG1bwJcrjMg1IakSXobugJTXoDXothh/kREbP2IGPuu/oA45N+/PTICpVxylXaZuhOJqSWdvsDT9xKgEApdZSkMYntp1Mr1jNWB3ekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387473; c=relaxed/simple;
	bh=AXRDKhbjrUfF2C16tSYWGrrQk3n2EAeoCXOpGNpYRfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz0wrWDS7n3vQZla5pfLrfJOcEpLwvZvgXhYqFda6Bs/2k9JvgoGP0SFOMShyLXldF/lkhDy5wJvf5M5WoVo74jE07Zx7yDUXTtuQtidIZPLs/1G7l6TBh9woHxtOgoLL6wwm1uhHRBc1PtqoREBInMzUiQCZPsj2SmCnJ6QvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jldTHH6G; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jldTHH6G"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c396fec63aso1593586b6e.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387470; x=1711992270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUx7jtVOi+jb3D65FVk3x9l97YapyQi7TjNwuh00bo8=;
        b=jldTHH6GdQ2wGsemCQoH9847byEowVMfsBmh0ktNWPbyg1YOHgLPymrY/eVRkXt9AO
         3UzoR29IW6zcez+esayg57+eTOcK6f74cs+j/BezxNIMzY8fw7YAB5EbpWh79rShu1o1
         icVLFChOrBvOuZIiZlkmum5i+5Ws1uPkIpGDFtfySK9S9ZKHU3G3rPnZP2IeGBGHNSYR
         PjjvwkVfeBgjl3WITVlXl1jekGVwz4jk5nTKkKPGExrwMa+pfTP9N5rinog6Wb3YRXEy
         WxxApCOPFRPVQ3e6mPO3djZ+Y23XsK8K9cH6hB9VZXZyw+IctXKsWmfS3+jab/b6ahEu
         iUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387470; x=1711992270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUx7jtVOi+jb3D65FVk3x9l97YapyQi7TjNwuh00bo8=;
        b=LGkC8MQU5EmDe5qryFNyf1/cQ2SI+aBRNVF891bvR95FijN+3BhfW8ACqmxnHdC4Fl
         +OJS9fb2UgZoFeD0PMDMvIukviUkIQ6DQOmaSQSGVTX6Ov7mafg6M9N27JDkb0HyzOrt
         pU2c+H8bzNssY8u7yzTbtwQQNetGbzxOpOF4vj0LJ050AWOft9UDUqKLCR4l1+vWBMix
         Oq9QmpI6C/X4XNr/qmvl5l8iTo0MEKfUpgkQtDiGG6PSeD3szRjEDYY+DAu7U6eqWnJo
         FSm18uGsQV7j0oudI9ExKGvVkW3EaJ6gEMsHkP/thlNH8T5S2HBbKUMSvwfWPk3UJghB
         mSqg==
X-Gm-Message-State: AOJu0YzOuNvjGci0mrKoxKqJEZ4bQ8HJm+1aJrO4udbKyX8eT56kZLC5
	RJkdFcdcfhVXddP3BcaHqD4XnggY9ZRHIy8Sad1vtLbFSsys9YnjLdJiJlE6xD1bBJy88pc+6wN
	R7Bc=
X-Google-Smtp-Source: AGHT+IFONp5umqcdFhAWcKpinArVF+jOnjAedHVBj+y5WzLVkLqh9QxOJU4a1/KZl1iNGRuj+jBlhA==
X-Received: by 2002:a05:6808:ec8:b0:3c2:39d1:f111 with SMTP id q8-20020a0568080ec800b003c239d1f111mr531992oiv.48.1711387470432;
        Mon, 25 Mar 2024 10:24:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id he37-20020a05622a602500b00430bad81704sm2779940qtb.52.2024.03.25.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:30 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/11] midx: move `expire_midx_packs` to midx-write.c
Message-ID: <e2b6459aa8f4ecedf9a7b1df3e7e56739254a8d1.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

Move `expire_midx_packs()`, the main function which implements the
sub-command 'git multi-pack-index expire' into midx-write.c.

Similar to the previous patch, this patch does not introduce any
behavioral changes and is best viewed with `--color-moved`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.c       | 57 ---------------------------------------------------
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 6dd58be7e0..d679e0a131 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "packfile.h"
 #include "midx.h"
+#include "progress.h"
 #include "run-command.h"
 #include "pack-bitmap.h"
 #include "revision.h"
@@ -17,6 +18,63 @@ extern int write_midx_internal(const char *object_dir,
 extern struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir);
 
+int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
+{
+	uint32_t i, *count, result = 0;
+	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
+	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
+	struct progress *progress = NULL;
+
+	if (!m)
+		return 0;
+
+	CALLOC_ARRAY(count, m->num_packs);
+
+	if (flags & MIDX_PROGRESS)
+		progress = start_delayed_progress(_("Counting referenced objects"),
+					  m->num_objects);
+	for (i = 0; i < m->num_objects; i++) {
+		int pack_int_id = nth_midxed_pack_int_id(m, i);
+		count[pack_int_id]++;
+		display_progress(progress, i + 1);
+	}
+	stop_progress(&progress);
+
+	if (flags & MIDX_PROGRESS)
+		progress = start_delayed_progress(_("Finding and deleting unreferenced packfiles"),
+					  m->num_packs);
+	for (i = 0; i < m->num_packs; i++) {
+		char *pack_name;
+		display_progress(progress, i + 1);
+
+		if (count[i])
+			continue;
+
+		if (prepare_midx_pack(r, m, i))
+			continue;
+
+		if (m->packs[i]->pack_keep || m->packs[i]->is_cruft)
+			continue;
+
+		pack_name = xstrdup(m->packs[i]->pack_name);
+		close_pack(m->packs[i]);
+
+		string_list_insert(&packs_to_drop, m->pack_names[i]);
+		unlink_pack_path(pack_name, 0);
+		free(pack_name);
+	}
+	stop_progress(&progress);
+
+	free(count);
+
+	if (packs_to_drop.nr)
+		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
+
+	string_list_clear(&packs_to_drop, 0);
+
+	return result;
+}
+
 struct repack_info {
 	timestamp_t mtime;
 	uint32_t referenced_objects;
diff --git a/midx.c b/midx.c
index 3bd8c58642..5936bc5b9e 100644
--- a/midx.c
+++ b/midx.c
@@ -1998,60 +1998,3 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	return verify_midx_error;
 }
-
-int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
-{
-	uint32_t i, *count, result = 0;
-	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
-	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
-	struct progress *progress = NULL;
-
-	if (!m)
-		return 0;
-
-	CALLOC_ARRAY(count, m->num_packs);
-
-	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Counting referenced objects"),
-					  m->num_objects);
-	for (i = 0; i < m->num_objects; i++) {
-		int pack_int_id = nth_midxed_pack_int_id(m, i);
-		count[pack_int_id]++;
-		display_progress(progress, i + 1);
-	}
-	stop_progress(&progress);
-
-	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Finding and deleting unreferenced packfiles"),
-					  m->num_packs);
-	for (i = 0; i < m->num_packs; i++) {
-		char *pack_name;
-		display_progress(progress, i + 1);
-
-		if (count[i])
-			continue;
-
-		if (prepare_midx_pack(r, m, i))
-			continue;
-
-		if (m->packs[i]->pack_keep || m->packs[i]->is_cruft)
-			continue;
-
-		pack_name = xstrdup(m->packs[i]->pack_name);
-		close_pack(m->packs[i]);
-
-		string_list_insert(&packs_to_drop, m->pack_names[i]);
-		unlink_pack_path(pack_name, 0);
-		free(pack_name);
-	}
-	stop_progress(&progress);
-
-	free(count);
-
-	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
-
-	string_list_clear(&packs_to_drop, 0);
-
-	return result;
-}
-- 
2.44.0.290.g736be63234b

