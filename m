Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED17513B2A8
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310319; cv=none; b=tR2DYJlzLkn7ro2YoNKUZK9r/cSU3uGq1PfgysPHQxV9t5Nc8+Y7GN1g0a+zknhyhcjldiOC5gdnBkpDwIhImz5hzPb5HSnjALaxeyF91zsl5ZZsM0fBsKhoYc1nELQMWsZRoT91xlAFPKk5QJBxMu/+kspzKCn8d4g6kyrsk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310319; c=relaxed/simple;
	bh=V2R1W56YQOOFHiKmSrR/5oGXKXtfIjztXxp4vLTOaoQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JJidHOescUq9uKNWmRQMYvp5OyKdlqkcZFegJqhAAP8b6SrgHoQlhhsv4IWV5ysXJl2t0lWpkeJWg0+OcJQEWsELIeWdAluFlKr16dn3PfJot7uinIWJ9AJYX/4MSKL+eD7sGZwOrdrcUeSqlaDf756OYHostrezvl/z0Cfnfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSmnF3Qr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSmnF3Qr"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f225ac23bso1417194f8f.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310316; x=1718915116; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q6K6UOmFxkhSBQjcEH3QUR/miq8F8IOpZkyX3XHOyg=;
        b=hSmnF3QrSS0y2egvZN/b/9PuaLlOLsKp89ilqclnBiNZi4fGNJLacIA59G4BFfJfdG
         RajO//q10xEkj3+UA1DX9nln+fHgN3bKeGrfRwZPwqr8covBiUTFSSPBaTw9nbPlrdzR
         fWkAqaBX1KLJrIaoAMysXbTaRdMsPutxM0k4F2bKb4fnA/l7Sk9EW9G+4i4Q2TXgNRTR
         0edUPhM3YkjZEn08WBtyuM+im0AbxdSTkTjt32ulULvJ6h/Wo4m86T/w4iAKnQ2SBSFb
         Fm9zNYw+ZEbDEcFQkyw2sFWouHQyPjND3UIRIWvVtebb9zuTXhdyLmguwTPHokyKOOSU
         99Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310316; x=1718915116;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q6K6UOmFxkhSBQjcEH3QUR/miq8F8IOpZkyX3XHOyg=;
        b=VKeW/Y/HlzGo0Bs1yk8Wj3hFM2N+QP885ArELGXQvL1OWmyiFM08A8S55aogLChF+T
         8vXSBcqsLKwLF79B9v73+W0yR55EAvPUCLtQq80OOdFR30UHUpNOdUFDeldY9Uoo1LrF
         2PuVEW0Y4Y/1DzSMEmX40z2T9UCaJ4IfH47Q27vBAmXiw4MtFi15bkxk/gkccXikbM2G
         evmxGVHPgEe9aLQ9sR4rZp8jA7dV1IzuMrf/Fr/dSZ1ns3VklritcI3D+GQ46jlMQuZF
         k7gz9ILVdZjxHccMMQr2FhWwuq6gIXlEm1kb2aiPYOpe5Hdu/0iQiVxGKrYg0tWj/Clb
         XfYQ==
X-Gm-Message-State: AOJu0Ywu5aRwwsfYyy4HvMsF2jIdKW5mdJ3WrbLEHNzdwTucpzrrXVBD
	rIfKxAdiNDN+40yqX8Skhmctq54+EanLco6klvjOGXChYik4ZF3gb0NsZQ==
X-Google-Smtp-Source: AGHT+IE+qaRzYwwde2SIfNoCv3yR9y/QH3HnJryhzvfBEzVbIhGFgxyS/CA2hN77Yn5zmdkQ8JlP1g==
X-Received: by 2002:a5d:4d08:0:b0:35f:2363:e4fc with SMTP id ffacd0b85a97d-3607a7606b3mr735274f8f.17.1718310315865;
        Thu, 13 Jun 2024 13:25:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c86dsm2611169f8f.40.2024.06.13.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:14 -0700 (PDT)
Message-Id: <71391b18c1a711fee1f5aff6eedbd3f631d37ded.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:06 +0000
Subject: [PATCH 6/7] merge-ort: upon merge abort, only show messages causing
 the abort
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When something goes wrong enough that we need to abort early and not
even attempt merging the remaining files, it probably does not make
sense to report conflicts messages for the subset of files we processed
before hitting the fatal error.  Instead, only show the messages
associated with paths where we hit the fatal error.  Also, print these
messages to stderr rather than stdout.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 76 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 462bc6fb6e1..5410dec2b4f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -543,10 +543,24 @@ enum conflict_and_info_types {
 	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
 	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
 	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
-	CONFLICT_SUBMODULE_CORRUPT,
+
+	/* INSERT NEW ENTRIES HERE */
+
+	/*
+	 * Keep this entry after all regular conflict and info types; only
+	 * errors (failures causing immediate abort of the merge) should
+	 * come after this.
+	 */
+	NB_REGULAR_CONFLICT_TYPES,
+
+	/*
+	 * Something is seriously wrong; cannot even perform merge;
+	 * Keep this group _last_ other than NB_CONFLICT_TYPES
+	 */
+	ERROR_SUBMODULE_CORRUPT,
 
 	/* Keep this entry _last_ in the list */
-	NB_CONFLICT_TYPES,
+	NB_TOTAL_TYPES,
 };
 
 /*
@@ -597,8 +611,10 @@ static const char *type_short_descriptions[] = {
 		"CONFLICT (submodule may have rewinds)",
 	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =
 		"CONFLICT (submodule lacks merge base)",
-	[CONFLICT_SUBMODULE_CORRUPT] =
-		"CONFLICT (submodule corrupt)"
+
+	/* Something is seriously wrong; cannot even perform merge */
+	[ERROR_SUBMODULE_CORRUPT] =
+		"ERROR (submodule corrupt)",
 };
 
 struct logical_conflict_info {
@@ -762,7 +778,8 @@ static void path_msg(struct merge_options *opt,
 
 	/* Sanity checks */
 	assert(omittable_hint ==
-	       !starts_with(type_short_descriptions[type], "CONFLICT") ||
+	       (!starts_with(type_short_descriptions[type], "CONFLICT") &&
+		!starts_with(type_short_descriptions[type], "ERROR")) ||
 	       type == CONFLICT_DIR_RENAME_SUGGESTED);
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
 		return; /* Do not record mere hints in headers */
@@ -1817,9 +1834,9 @@ static int merge_submodule(struct merge_options *opt,
 	/* check whether both changes are forward */
 	ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_a);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -1828,9 +1845,9 @@ static int merge_submodule(struct merge_options *opt,
 	if (ret2 > 0)
 		ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_b);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -1848,7 +1865,7 @@ static int merge_submodule(struct merge_options *opt,
 	/* Case #1: a is contained in b or vice versa */
 	ret2 = repo_in_merge_bases(&subrepo, commit_a, commit_b);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s "
 			   "(repository corrupt)"),
@@ -1867,9 +1884,9 @@ static int merge_submodule(struct merge_options *opt,
 	}
 	ret2 = repo_in_merge_bases(&subrepo, commit_b, commit_a);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -1901,9 +1918,9 @@ static int merge_submodule(struct merge_options *opt,
 					 &merges);
 	switch (parent_count) {
 	case -1:
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -4646,6 +4663,7 @@ void merge_display_update_messages(struct merge_options *opt,
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 	struct string_list olist = STRING_LIST_INIT_NODUP;
+	FILE *o = stdout;
 
 	if (opt->record_conflict_msgs_as_headers)
 		BUG("Either display conflict messages or record them as headers, not both");
@@ -4662,6 +4680,10 @@ void merge_display_update_messages(struct merge_options *opt,
 	}
 	string_list_sort(&olist);
 
+	/* Print to stderr if we hit errors rather than just conflicts */
+	if (result->clean < 0)
+		o = stderr;
+
 	/* Iterate over the items, printing them */
 	for (int path_nr = 0; path_nr < olist.nr; ++path_nr) {
 		struct string_list *conflicts = olist.items[path_nr].util;
@@ -4669,25 +4691,31 @@ void merge_display_update_messages(struct merge_options *opt,
 			struct logical_conflict_info *info =
 				conflicts->items[i].util;
 
+			/* On failure, ignore regular conflict types */
+			if (result->clean < 0 &&
+			    info->type < NB_REGULAR_CONFLICT_TYPES)
+				continue;
+
 			if (detailed) {
-				printf("%lu", (unsigned long)info->paths.nr);
-				putchar('\0');
+				fprintf(o, "%lu", (unsigned long)info->paths.nr);
+				fputc('\0', o);
 				for (int n = 0; n < info->paths.nr; n++) {
-					fputs(info->paths.v[n], stdout);
-					putchar('\0');
+					fputs(info->paths.v[n], o);
+					fputc('\0', o);
 				}
-				fputs(type_short_descriptions[info->type],
-				      stdout);
-				putchar('\0');
+				fputs(type_short_descriptions[info->type], o);
+				fputc('\0', o);
 			}
-			puts(conflicts->items[i].string);
+			fputs(conflicts->items[i].string, o);
+			fputc('\n', o);
 			if (detailed)
-				putchar('\0');
+				fputc('\0', o);
 		}
 	}
 	string_list_clear(&olist, 0);
 
-	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+	if (result->clean >= 0)
+		print_submodule_conflict_suggestion(&opti->conflicted_submodules);
 
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
-- 
gitgitgadget

