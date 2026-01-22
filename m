Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73202D73B9
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102159; cv=none; b=NvHVXRyIJfT2bJtD3ZWbTvBGon6e3vD1ucFOKbZLhkH7rJVl/tu55EGiaKhPOFqr/KsafjUC+IPfgOVOAGSxCvsBip+cOKcM94uZuSOTSr4MW+/8WTlYF8FBbk8+U3I04f4JLDDJT2MfaTRV5qvbdaFekK6bp0g1IlJib8jFLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102159; c=relaxed/simple;
	bh=/bYTUJfXLBxlzxqpMzisSJ15aZC/akYkWrDitqrl93E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM/ndfs0n/11Wz0JPKvPE0j+dTVC4muhV7fwLxiIKgbMiG8prY265u0+HGjvL0BiFptGPMge68qo9QZW2JdGfBUx1Pn9BhkRFuVmC61VQHFw18QcfIxiC4YVHhYMqMQOPAo14balH5Po5oGd2Z9VwRpQbmwb6isEW5VrwZSWUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3VDjt2C; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3VDjt2C"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7bced39cfso12037095ad.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769102149; x=1769706949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUTh2fPZT9jgaD8fFTDOXq2xo+M7fK6h4QL46IIcHYM=;
        b=G3VDjt2Cv48nVGR6YiQREeuThnFkOsxQP9lnptEuxAgV2xMzqok1H25fQTMeUKaHsF
         XWPuXNdNrzn4gl1jozt/U670rCEDEKCYUOpjQLshlRaZNvzgt/RD4ogOBSPEtajd2xW9
         V11h/LRXsRfDW1DeY0qzcZpKaKPSqK+nFHnke4ay6LNdPFfLeLLSBkeeCS4k9htZdka7
         dVWLPs0sRUN4JRqVVeV0sYRcQmIwFgk20Vj5POSrszFncYsrec2q95O/gUUX0q0vKu5G
         LJqKzbi1iCdzOZ2LCGeirn+Htoyb9n7yTBmYsiZ7ENATNNcdewX18IlWsmH87tuorNaP
         gFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102149; x=1769706949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUTh2fPZT9jgaD8fFTDOXq2xo+M7fK6h4QL46IIcHYM=;
        b=Ghz6VfgkmfeqGfKFX4qqsOqDOrGgN3Fhble+A5yzgiaz65hy65N7u6KwTa3mi7WX5x
         5/I9VRy6kDJuv6x6F15DQQz2ZeE9gXp3+IAsO8etGXmazgcqxlJs4rZzpIEwJ1YpBkDS
         TpBJO6VbawUk0gcIJv164iJuY2a/SqPsJGQ5G92zRlcev29C7wl2Uzc/Ea/CIaWz6tHn
         xov6T78oYMjyO8YNnlrdD3BUd+4dto7t9X3QKNKhVxhx8ULjUc3C6ngL7aT4Mm0/9IJV
         k4oTb/QkR9M+uD3BGQKZjwxkYgGlzsJGcFVSNXMHCEknJO58lZf1f3T7QWXvUAwb2N1R
         GN6Q==
X-Gm-Message-State: AOJu0YySrYfWfmZ8BGltztvSS0eE4SBsFMfKXppyZUWTo2nZJzMA//o9
	91iHoWcXUPP5CbAmOjk4iMWiT2eTljwCi+yE7EtY3vHn4OLD/e2KldE0Kpxes1uQ
X-Gm-Gg: AZuq6aJkPHdgEKB8yRK0Yu/xXsi0KkXSh/j66kChR/Xn8HV8NwX72e7tuULybfQmpeM
	VQMJbYEYVpbQs25D0Wub8Ec8tPyRCK2udbZrqsGcCBkJ82Zm16seEFtnM5/Mb3ivBeM0MONMcIe
	fNSqBLSvidrIxBfH74wRokj2bJJeK3a6fDykHN/loe2gxQMUtx3rjDsDxQGupQ5iIOnlw3x3a6h
	Y4/2ebkr+WmGsaRTsOLJXoTDMNswATdbw3A7QyaCY4vqqPCMTSw0gITgbic2NBNroxJU0/x0/Yk
	5fFpLBjo96jK09JpJtyh0R6IsmvPLyq62wzDOMJAfNlJA6cPMySLtdJfaRB1q5rqGpMbxw6/9MS
	RJ58cXSUSnRJHTPEYD6ny/m/kfcDvinJI7dX+AXmC9f9djJN7RzAXKK/sRFlRXXRNxxcKYD2tdZ
	EwV7whunCFQwIB20Ku2Vbv8hblv8jchY7Eu0i+RXaP+zMnbEPEQ0JDJJ8NLOGisi+UZYE8
X-Received: by 2002:a17:903:2305:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a7fe571fa4mr1327935ad.21.1769102148447;
        Thu, 22 Jan 2026 09:15:48 -0800 (PST)
Received: from localhost.localdomain ([115.98.234.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a773d4e5basm81557205ad.94.2026.01.22.09.15.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 09:15:48 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	amisha <amishhhaaaa@gmail.com>
Subject: [RFC PATCH 2/2] Replacing calls of string_list_sort and string_list_remove_duplicates with the combined variant string_list_u.
Date: Thu, 22 Jan 2026 22:45:23 +0530
Message-ID: <20260122171523.94234-3-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122171523.94234-1-amishhhaaaa@gmail.com>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/clone.c           | 3 +--
 builtin/fast-export.c     | 3 +--
 builtin/pack-objects.c    | 6 ++----
 builtin/sparse-checkout.c | 6 ++----
 help.c                    | 3 +--
 notes.c                   | 3 +--
 6 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b06..f05364c268 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1136,8 +1136,7 @@ int cmd_clone(int argc,
 		int val;
 
 		/* remove duplicates */
-		string_list_sort(&option_recurse_submodules);
-		string_list_remove_duplicates(&option_recurse_submodules, 0);
+		string_list_sort_u(&option_recurse_submodules, 0);
 
 		/*
 		 * NEEDSWORK: In a multi-working-tree world, this needs to be
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b90da5e616..0c5d2386d8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1118,8 +1118,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			free(full_name);
 	}
 
-	string_list_sort(&extra_refs);
-	string_list_remove_duplicates(&extra_refs, 0);
+	string_list_sort_u(&extra_refs, 0);
 }
 
 static void handle_tags_and_duplicates(struct string_list *extras)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca44b7894f..649dab4ed0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3849,10 +3849,8 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 		strbuf_reset(&buf);
 	}
 
-	string_list_sort(&include_packs);
-	string_list_remove_duplicates(&include_packs, 0);
-	string_list_sort(&exclude_packs);
-	string_list_remove_duplicates(&exclude_packs, 0);
+	string_list_sort_u(&include_packs, 0);
+	string_list_sort_u(&exclude_packs, 0);
 
 	repo_for_each_pack(the_repository, p) {
 		const char *pack_name = pack_basename(p);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..25de7692c9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -292,8 +292,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 			string_list_insert(&sl, pe->pattern);
 	}
 
-	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
+	string_list_sort_u(&sl, 0);
 
 	fprintf(fp, "/*\n!/*/\n");
 
@@ -316,8 +315,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 
 	strbuf_release(&parent_pattern);
 
-	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
+	string_list_sort_u(&sl, 0);
 
 	for (i = 0; i < sl.nr; i++) {
 		char *pattern = escaped_pattern(sl.items[i].string);
diff --git a/help.c b/help.c
index 20e114432d..2070095b6f 100644
--- a/help.c
+++ b/help.c
@@ -420,8 +420,7 @@ void list_cmds_by_config(struct string_list *list)
 	if (repo_config_get_string_tmp(the_repository, "completion.commands", &cmd_list))
 		return;
 
-	string_list_sort(list);
-	string_list_remove_duplicates(list, 0);
+	string_list_sort_u(list, 0);
 
 	while (*cmd_list) {
 		struct strbuf sb = STRBUF_INIT;
diff --git a/notes.c b/notes.c
index 8e00fd8c47..090c48bbd5 100644
--- a/notes.c
+++ b/notes.c
@@ -921,8 +921,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 	if (string_list_add_note_lines(&sort_uniq_list, new_oid))
 		goto out;
 	string_list_remove_empty_items(&sort_uniq_list, 0);
-	string_list_sort(&sort_uniq_list);
-	string_list_remove_duplicates(&sort_uniq_list, 0);
+	string_list_sort_u(&sort_uniq_list, 0);
 
 	/* create a new blob object from sort_uniq_list */
 	if (for_each_string_list(&sort_uniq_list,
-- 
2.51.0

