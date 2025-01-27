Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77225A63A
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974222; cv=none; b=rDjMAbLSH73QIxAdcf2fjLmSLeThJls9ipnhE+Rk7wwNLt+SPf1bt3iByse8uM0I6hhpP3YD+4VEZps3jXpDOSGKKU7NxLBeaBPAHGHm0P+dR+y01pNjgDApCmMaDQwndCHPArnkEj6sMsvjGooq7H1+fplafPGLVYanApjIQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974222; c=relaxed/simple;
	bh=DVQ3P/MAbah0UZW+eCWmbLsWH5gKWVH6oIYO2fKOtrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L9gb026XB0Z5UnZS2Yv5TsPnhhk1Os+PlHSRDFRFvreTmtllUxsYbaOkNRYsFRAM982XKbYH1rFBlbqdcaCt5rwpNQzXos4tWjhsBlrrbEcv/wsHMy1mP4WaFDGUA9oL3dBEQavlgpF2nMNJNdGjOCWgX5EFbxQcyqHn/2EBPyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOSj8yKI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOSj8yKI"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so7247490a91.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 02:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737974220; x=1738579020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kONkaBMjVxMUHkh3kbPpA/t/cw7c4+7sksdFPhpzY1M=;
        b=VOSj8yKI1e2PT2gfqUSFMusOKkao5m8W5+E3sa9WexH0kaKuT3NPsVKGSD1I80T0i/
         2bXVV8ZFgpgV+iDfYCIw7vs2Rozs++pi6AV1s36Yp0Rtkn7d2cVuafm/u0lMlmAjtu3B
         n+ZYm/YywUXnl8RuQiPSMKhSwcmgMNODG1G3altzk9LC1jRvZ/woNOUNckGoOGR/3xd9
         9D13VOAgyOLIsfQG7rAdGy6f4/Rt649npGmvspgWOEAawuVT463Rcq0owiQmQdTkh/t2
         rveSmmDbpcUdzFwIx4IOmzEVGsVGvCGdbP6TbZPf4tCEyGCuAgeai1j6KfmcGYbhq5lQ
         oXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974220; x=1738579020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kONkaBMjVxMUHkh3kbPpA/t/cw7c4+7sksdFPhpzY1M=;
        b=f+JNCZu++C6f8yi5fu+z2kP4buJz74KN2dHRE6L8AnaTaWQEucKcpSIbUQHNatCh4X
         q3efnHJ9gaD1M4ecViYaNKcOMvq74j9J2dADB77Gmz5DSajtYkfsUTayiEYYuvG5aEdC
         r9CJ75rX28ZLPVh5bRtad6k/9559hAA3LS6MkE5YpZg1cOg1Kv1RiUgwt7KYtnVcErS5
         zeLXa1xk+NBszfTkYDQcDDR4L83avDEGfWoLqUAEHRkEiElYkGGfAgkYI0+az5YNOgqd
         5vqPALl1veg7/86oAHpwEwUXERVTZPGuHgRhBuCEPapf3Dr18XTiTbitIPA3Z/1u705e
         d24Q==
X-Gm-Message-State: AOJu0YztgC7oNyDw99EbMgl69bXZVewkKcrIGHBlUQ3V+eDMCy/l7eyB
	6m9KIsuSKaVarw140g+CAHsp0SgAT97LozCrgnQwkTYTFvBkqJKLXIWv2M0W
X-Gm-Gg: ASbGncsjeFNNIO0I9s5VEypydu3GIVl/TQAe2r/Xav6m/GXAljwgBgP6l1yIR44ZUSn
	9Sd54MJUG5sPQNRVhWi2KUOSKYFyqGuDo1xeQmZTM5R61HgsFqaYxY0N8e642lYg52x7u9yzJ65
	QYlOzRaO9oFlDA7nEGdRPhb8b7hu3YHaokBmWGmul0dvOwefDT0z9mNjntlFjFSyyQ7iF3nepOA
	9akcLpQVZfMj03grMyijdRItHlCt7JoLI9VSLXYcodoDOkR2da7qyhXfnpdfUC69MsRzrfMepA9
	aIc=
X-Google-Smtp-Source: AGHT+IHjWRUDcckRkPJNB/T0+KniQ1Jz46kR9MjBv3T33CgzYGrgb7/cxiAfnjrJwH1JjX56y0cckg==
X-Received: by 2002:a17:90b:264e:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-2f782c4c28bmr51862591a91.5.1737974219505;
        Mon, 27 Jan 2025 02:36:59 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa454f5sm6879439a91.1.2025.01.27.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:36:59 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Nipunn Koorapati <nipunn@dropbox.com>
Subject: [PATCH v2 2/3] refspec: relocate query related functions
Date: Mon, 27 Jan 2025 16:06:43 +0530
Message-Id: <20250127103644.36627-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127103644.36627-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `query_refspecs()`, `query_refspecs_multiple()` and
`query_matches_negative_refspec()` from `remote.c` to `refspec.c`. These
functions focus on querying refspecs, so centralizing them in `refspec.c`
improves code organization by keeping refspec-related logic in one place.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |  16 +++++++
 remote.c  | 122 -----------------------------------------------------
 remote.h  |   1 -
 4 files changed, 139 insertions(+), 123 deletions(-)

diff --git a/refspec.c b/refspec.c
index 66989a1d75..72b3911110 100644
--- a/refspec.c
+++ b/refspec.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
+#include "string-list.h"
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
@@ -324,3 +325,125 @@ int omit_name_by_refspec(const char *name, struct refspec *rs)
 	}
 	return 0;
 }
+
+static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
+{
+	int i, matched_negative = 0;
+	int find_src = !query->src;
+	struct string_list reversed = STRING_LIST_INIT_DUP;
+	const char *needle = find_src ? query->dst : query->src;
+
+	/*
+	 * Check whether the queried ref matches any negative refpsec. If so,
+	 * then we should ultimately treat this as not matching the query at
+	 * all.
+	 *
+	 * Note that negative refspecs always match the source, but the query
+	 * item uses the destination. To handle this, we apply pattern
+	 * refspecs in reverse to figure out if the query source matches any
+	 * of the negative refspecs.
+	 *
+	 * The first loop finds and expands all positive refspecs
+	 * matched by the queried ref.
+	 *
+	 * The second loop checks if any of the results of the first loop
+	 * match any negative refspec.
+	 */
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
+		char *expn_name;
+
+		if (refspec->negative)
+			continue;
+
+		/* Note the reversal of src and dst */
+		if (refspec->pattern) {
+			const char *key = refspec->dst ? refspec->dst : refspec->src;
+			const char *value = refspec->src;
+
+			if (match_name_with_pattern(key, needle, value, &expn_name))
+				string_list_append_nodup(&reversed, expn_name);
+		} else if (refspec->matching) {
+			/* For the special matching refspec, any query should match */
+			string_list_append(&reversed, needle);
+		} else if (!refspec->src) {
+			BUG("refspec->src should not be null here");
+		} else if (!strcmp(needle, refspec->src)) {
+			string_list_append(&reversed, refspec->src);
+		}
+	}
+
+	for (i = 0; !matched_negative && i < reversed.nr; i++) {
+		if (omit_name_by_refspec(reversed.items[i].string, rs))
+			matched_negative = 1;
+	}
+
+	string_list_clear(&reversed, 0);
+
+	return matched_negative;
+}
+
+void query_refspecs_multiple(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results)
+{
+	int i;
+	int find_src = !query->src;
+
+	if (find_src && !query->dst)
+		BUG("query_refspecs_multiple: need either src or dst");
+
+	if (query_matches_negative_refspec(rs, query))
+		return;
+
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
+		const char *key = find_src ? refspec->dst : refspec->src;
+		const char *value = find_src ? refspec->src : refspec->dst;
+		const char *needle = find_src ? query->dst : query->src;
+		char **result = find_src ? &query->src : &query->dst;
+
+		if (!refspec->dst || refspec->negative)
+			continue;
+		if (refspec->pattern) {
+			if (match_name_with_pattern(key, needle, value, result))
+				string_list_append_nodup(results, *result);
+		} else if (!strcmp(needle, key)) {
+			string_list_append(results, value);
+		}
+	}
+}
+
+int query_refspecs(struct refspec *rs, struct refspec_item *query)
+{
+	int i;
+	int find_src = !query->src;
+	const char *needle = find_src ? query->dst : query->src;
+	char **result = find_src ? &query->src : &query->dst;
+
+	if (find_src && !query->dst)
+		BUG("query_refspecs: need either src or dst");
+
+	if (query_matches_negative_refspec(rs, query))
+		return -1;
+
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
+		const char *key = find_src ? refspec->dst : refspec->src;
+		const char *value = find_src ? refspec->src : refspec->dst;
+
+		if (!refspec->dst || refspec->negative)
+			continue;
+		if (refspec->pattern) {
+			if (match_name_with_pattern(key, needle, value, result)) {
+				query->force = refspec->force;
+				return 0;
+			}
+		} else if (!strcmp(needle, key)) {
+			*result = xstrdup(value);
+			query->force = refspec->force;
+			return 0;
+		}
+	}
+	return -1;
+}
diff --git a/refspec.h b/refspec.h
index 891d50b159..d0788de782 100644
--- a/refspec.h
+++ b/refspec.h
@@ -30,6 +30,8 @@ struct refspec_item {
 	char *raw;
 };
 
+struct string_list;
+
 #define REFSPEC_FETCH 1
 #define REFSPEC_PUSH 0
 
@@ -84,4 +86,18 @@ int omit_name_by_refspec(const char *name, struct refspec *rs);
 int match_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result);
 
+/*
+ * Queries a refspec for a match and updates the query item.
+ * Returns 0 on success, -1 if no match is found or negative refspec matches.
+ */
+int query_refspecs(struct refspec *rs, struct refspec_item *query);
+
+/*
+ * Queries a refspec for all matches and appends results to the provided string
+ * list.
+ */
+void query_refspecs_multiple(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 40c2418065..2c46611821 100644
--- a/remote.c
+++ b/remote.c
@@ -925,128 +925,6 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	return ref_map;
 }
 
-static int query_matches_negative_refspec(struct refspec *rs, struct refspec_item *query)
-{
-	int i, matched_negative = 0;
-	int find_src = !query->src;
-	struct string_list reversed = STRING_LIST_INIT_DUP;
-	const char *needle = find_src ? query->dst : query->src;
-
-	/*
-	 * Check whether the queried ref matches any negative refpsec. If so,
-	 * then we should ultimately treat this as not matching the query at
-	 * all.
-	 *
-	 * Note that negative refspecs always match the source, but the query
-	 * item uses the destination. To handle this, we apply pattern
-	 * refspecs in reverse to figure out if the query source matches any
-	 * of the negative refspecs.
-	 *
-	 * The first loop finds and expands all positive refspecs
-	 * matched by the queried ref.
-	 *
-	 * The second loop checks if any of the results of the first loop
-	 * match any negative refspec.
-	 */
-	for (i = 0; i < rs->nr; i++) {
-		struct refspec_item *refspec = &rs->items[i];
-		char *expn_name;
-
-		if (refspec->negative)
-			continue;
-
-		/* Note the reversal of src and dst */
-		if (refspec->pattern) {
-			const char *key = refspec->dst ? refspec->dst : refspec->src;
-			const char *value = refspec->src;
-
-			if (match_name_with_pattern(key, needle, value, &expn_name))
-				string_list_append_nodup(&reversed, expn_name);
-		} else if (refspec->matching) {
-			/* For the special matching refspec, any query should match */
-			string_list_append(&reversed, needle);
-		} else if (!refspec->src) {
-			BUG("refspec->src should not be null here");
-		} else if (!strcmp(needle, refspec->src)) {
-			string_list_append(&reversed, refspec->src);
-		}
-	}
-
-	for (i = 0; !matched_negative && i < reversed.nr; i++) {
-		if (omit_name_by_refspec(reversed.items[i].string, rs))
-			matched_negative = 1;
-	}
-
-	string_list_clear(&reversed, 0);
-
-	return matched_negative;
-}
-
-static void query_refspecs_multiple(struct refspec *rs,
-				    struct refspec_item *query,
-				    struct string_list *results)
-{
-	int i;
-	int find_src = !query->src;
-
-	if (find_src && !query->dst)
-		BUG("query_refspecs_multiple: need either src or dst");
-
-	if (query_matches_negative_refspec(rs, query))
-		return;
-
-	for (i = 0; i < rs->nr; i++) {
-		struct refspec_item *refspec = &rs->items[i];
-		const char *key = find_src ? refspec->dst : refspec->src;
-		const char *value = find_src ? refspec->src : refspec->dst;
-		const char *needle = find_src ? query->dst : query->src;
-		char **result = find_src ? &query->src : &query->dst;
-
-		if (!refspec->dst || refspec->negative)
-			continue;
-		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result))
-				string_list_append_nodup(results, *result);
-		} else if (!strcmp(needle, key)) {
-			string_list_append(results, value);
-		}
-	}
-}
-
-int query_refspecs(struct refspec *rs, struct refspec_item *query)
-{
-	int i;
-	int find_src = !query->src;
-	const char *needle = find_src ? query->dst : query->src;
-	char **result = find_src ? &query->src : &query->dst;
-
-	if (find_src && !query->dst)
-		BUG("query_refspecs: need either src or dst");
-
-	if (query_matches_negative_refspec(rs, query))
-		return -1;
-
-	for (i = 0; i < rs->nr; i++) {
-		struct refspec_item *refspec = &rs->items[i];
-		const char *key = find_src ? refspec->dst : refspec->src;
-		const char *value = find_src ? refspec->src : refspec->dst;
-
-		if (!refspec->dst || refspec->negative)
-			continue;
-		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result)) {
-				query->force = refspec->force;
-				return 0;
-			}
-		} else if (!strcmp(needle, key)) {
-			*result = xstrdup(value);
-			query->force = refspec->force;
-			return 0;
-		}
-	}
-	return -1;
-}
-
 char *apply_refspecs(struct refspec *rs, const char *name)
 {
 	struct refspec_item query;
diff --git a/remote.h b/remote.h
index 0d109fa9c9..f3da64dc41 100644
--- a/remote.h
+++ b/remote.h
@@ -267,7 +267,6 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
  */
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
 
-int query_refspecs(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
 int check_push_refs(struct ref *src, struct refspec *rs);
-- 
2.34.1

