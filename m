Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADF12A177
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738392195; cv=none; b=Sq42UXK0qfOqVodLBKbG/U6vCSTKlyL62Uqlix/MAiYQ/wrYw0f9D+Keb6jTGT70VSv3Ux4qLoJpYfCYqbnFwUXXFf2iMEe2fEi3KufYAtVJoTIPJBoFoi329bgBfkIKFEMkxNJXDPNjSJ5siVVdiK1G1j9a4tUM4Rz/3MlFLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738392195; c=relaxed/simple;
	bh=9oe7U1bnGRovoJa1j0cg+CxSP1kElBQkGxLGSNsWGJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQ6M1uzYs6NG92lpJYYRwjPTfoPwNeOrVfZ2GT/QXqBPIx1mZ4LVMkOYo3ehhwnrUY/kM7JLnQ4i+aJrq+3wK+ud7jWJUcc6PiMbEiLsOGuPCwU6zV9MzxUK4zo+wnqhpeTaIu/ZYFCDC7/mGndxnClnarTb+FHwn3ooPavfcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpU6hqqp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpU6hqqp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so47088755ad.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738392191; x=1738996991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/csq2zKAIsVOcBaweCao3H8BZrt1Q8jMq2sWK2Q9axw=;
        b=GpU6hqqpH5zKFNXmq7hITbevbXj9Lu9oBRNznAVqbvOGYOjcuSo8wtOyRqRuCsaHST
         soRCbaNWiMzgOkX1Tbee9hExXnnoZiBkGN/DaStZeKDENYQZD+cB8GossShcsW1bTbJp
         pW0CsdbeWmF8IumY32lCFyBq1dN45bwDd26bhhuRsaeITfJrboJGjrYkLgJcG5WM3F1d
         uaOjuVpMQ1T8dOUhYd0hD4r+R4fuuKZ8pwwZikVaXaXisZcJ8RCQ8N01910RPz0QiLfd
         HNUB/n45eKNo7hCQSXf0MK+1YgPilQ9nCWcmcKcdOlRjaiAqMY60pz+R8YV2MM1XwjvH
         JDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738392191; x=1738996991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/csq2zKAIsVOcBaweCao3H8BZrt1Q8jMq2sWK2Q9axw=;
        b=hy0maT4pU6cQ74e7ZUMDHe6V3DHIulnD3VfrpPrAQwZolPQePTYL+obpZldrDiNocC
         XT/UZumtvloSiGqHSNhBU4JkJA381RFtWcnCBCP4GLUHJwX4bbxNvhlX8aw6KD7lt00+
         uRZGR6CFG6/bU/LBu2lID6K43jowOX5A6EmevxJZc9Ybs9spkMfLgjZu9kDNjWigD5nr
         0mDI/wLAVFansRqD9inhRpc431qF+5+8f3bZrVS37giN2wKu2B42eBePr+QuUYAdWRhy
         WIXzzSIYZNR0blGJmu+7KuuiUiDJPWbQOBt6M1H2sxPtcmfLf2hcgkQkvmu3q44yFKRJ
         iP+A==
X-Gm-Message-State: AOJu0YyJVmHD8X1NEBus4yMUEALabMW7IeKV6Cb9UB4VEgp1aPerY5wT
	XbRr2Hc+G0n3yU9VpTUDL8Vvj/PSL62i5myzHgemXk6rLlO6hd3bMcuTRA0P
X-Gm-Gg: ASbGncu0PX34dmbBpyUCPvUPjQQrHvSI0l9wtgohmHc/a45RSjMd0h+aSzgeXQ5oKbL
	41n6Ao9MWs++67hiQ+EfIKPcVwjWiOXN99LRvPXJuGA7q9lomQPHDYqjxhjSH+Va3fQhGMv13mt
	iBiY5P7XywA6p05VeTLXX9kQxNJat15zvex0S52+mVKzE+Lbbtl5gNbKaHou6Wo1q4rl0UFb3X4
	sb8qbiLUg0QQDjcb77juo5BqQDYvs59OqKRScTG0QsTpf7stVQHAj8WpxxFrjn61nuxokirx4up
	IZSpIKLQlRmc6A==
X-Google-Smtp-Source: AGHT+IGKAo5g0h6jEE0zBzn7SZnrEUQb3JLtakhxmOVwQ3zykkuv2VAO0jdSL38bfMNGR4u5a7hDaw==
X-Received: by 2002:a17:903:247:b0:216:3dc5:1240 with SMTP id d9443c01a7336-21dd7dd5339mr210936965ad.45.1738392190853;
        Fri, 31 Jan 2025 22:43:10 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0e8ef61sm4058592a12.78.2025.01.31.22.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 22:43:10 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Nipunn Koorapati <nipunn@dropbox.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/5] refspec: relocate matching related functions
Date: Sat,  1 Feb 2025 12:12:01 +0530
Message-Id: <20250201064202.76116-5-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201064202.76116-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250201064202.76116-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `find_refspec_match()`, `find_all_refspec_matches()`
and `find_negative_refspec_match()` from `remote.c` to `refspec.c`.
These functions focus on matching refspecs, so centralizing them in
`refspec.c` improves code organization by keeping refspec-related logic
in one place.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |  16 +++++++
 remote.c  | 122 -----------------------------------------------------
 3 files changed, 139 insertions(+), 122 deletions(-)

diff --git a/refspec.c b/refspec.c
index b447768304..6634e7765d 100644
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
@@ -324,3 +325,125 @@ int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
 	}
 	return 0;
 }
+
+static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
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
+		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
+			matched_negative = 1;
+	}
+
+	string_list_clear(&reversed, 0);
+
+	return matched_negative;
+}
+
+void find_all_refspec_matches(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results)
+{
+	int i;
+	int find_src = !query->src;
+
+	if (find_src && !query->dst)
+		BUG("find_all_refspec_matches: need either src or dst");
+
+	if (find_negative_refspec_match(rs, query))
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
+int find_refspec_match(struct refspec *rs, struct refspec_item *query)
+{
+	int i;
+	int find_src = !query->src;
+	const char *needle = find_src ? query->dst : query->src;
+	char **result = find_src ? &query->src : &query->dst;
+
+	if (find_src && !query->dst)
+		BUG("find_refspec_match: need either src or dst");
+
+	if (find_negative_refspec_match(rs, query))
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
index 584d9c9eb5..0393643bc8 100644
--- a/refspec.h
+++ b/refspec.h
@@ -30,6 +30,8 @@ struct refspec_item {
 	char *raw;
 };
 
+struct string_list;
+
 #define REFSPEC_FETCH 1
 #define REFSPEC_PUSH 0
 
@@ -80,4 +82,18 @@ int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
 int match_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result);
 
+/*
+ * Queries a refspec for a match and updates the query item.
+ * Returns 0 on success, -1 if no match is found or negative refspec matches.
+ */
+int find_refspec_match(struct refspec *rs, struct refspec_item *query);
+
+/*
+ * Queries a refspec for all matches and appends results to the provided string
+ * list.
+ */
+void find_all_refspec_matches(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 4654bce5d4..858ab39471 100644
--- a/remote.c
+++ b/remote.c
@@ -925,128 +925,6 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	return ref_map;
 }
 
-static int find_negative_refspec_match(struct refspec *rs, struct refspec_item *query)
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
-		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
-			matched_negative = 1;
-	}
-
-	string_list_clear(&reversed, 0);
-
-	return matched_negative;
-}
-
-static void find_all_refspec_matches(struct refspec *rs,
-				    struct refspec_item *query,
-				    struct string_list *results)
-{
-	int i;
-	int find_src = !query->src;
-
-	if (find_src && !query->dst)
-		BUG("find_all_refspec_matches: need either src or dst");
-
-	if (find_negative_refspec_match(rs, query))
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
-int find_refspec_match(struct refspec *rs, struct refspec_item *query)
-{
-	int i;
-	int find_src = !query->src;
-	const char *needle = find_src ? query->dst : query->src;
-	char **result = find_src ? &query->src : &query->dst;
-
-	if (find_src && !query->dst)
-		BUG("find_refspec_match: need either src or dst");
-
-	if (find_negative_refspec_match(rs, query))
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
-- 
2.34.1

