Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FD38DD8
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511592; cv=none; b=VE+O0YoyOUMrEyIjQdyDeW9KD4UvnyKmoJrMQnoT3o1+fvB7AxJu+5kyv0Ezw5dtgnFoYskPftYtxtTz0Q0qA5TJ1c39v2W2hqCbJeGqrDSlWIxQSVemYpb/2BfFYCDkA4UvJR38i3HRH3Nr2uhhv3/6FF4nmlQobiqV5T2SnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511592; c=relaxed/simple;
	bh=c7wJA+untbzD1blbqM+BzwC8wIJegh6KZUxgZNmFYEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gPiHsxD453YqO/66w9/7pq6dRZY5Oqe78q4TysBDg0TDnq2dMol/7LSFAmim9MtuBzGnDCA5INx1cah6aDOOff184oIu21JPprX/ZmnOPYLZvo+sIx/h8i768gZ6iOcQtBBE4vhTMcoNcIoh3RCzHu+wq4uCDkcZ/Qy7MHz6wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaXelyzq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaXelyzq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220bff984a0so29455835ad.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 21:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739511589; x=1740116389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWgRLYwFqE7g4PjZm/KAww84OjNghEVSO09Nm6YF8Ww=;
        b=SaXelyzqba7cPiYag8CuDngeKkEMELvtlaVdFdsJv27OrcCWGu7h35UlNAJnANdLov
         HUd2U21jePWEtD6YcSpMuSFdUWLurgQn3VaCpiMyNxjZ+q7g9W7iMkWiylVkbEDkGUdx
         fZ7IvNodoKCwLwWgIbtyF1N2mKUhlJM/u3scaFTDzormSbSOw9pykPiurMbTbSL0ybK7
         s8M+YgvxINoJTcCKMOO6H0JTvCvJ23xTG5HdaJzLwfmuKy8PWIGQsz61LA5xhJWAmp3g
         1+ywr+d6+OLF7a3M3NHawpKJO28BGCnTF5vZIT2fHzmVA6bXwBNSO9zvq8EywDwT8cSe
         DOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739511589; x=1740116389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWgRLYwFqE7g4PjZm/KAww84OjNghEVSO09Nm6YF8Ww=;
        b=UD2zkiIBbxwUzsfSH1TaO3LJCYeZ7L+wbO3OzWOJ4EOu+Rgg9CLGgycxjVC2i5RM6p
         3fbtHQit3BY2NLetuZj4tirDqJocplk3cgffIv4/GKgtV0RvURQtHhUNRE5Ul15iapDd
         MDPTSefBswRixUpQJu8HX4RWE1hXRie1F1CfcjwXWHtNLNKc0RnjeCvECYMptyFy2HSr
         S4P1P+Oe88LUo51RG8bdx0ID+5hMjEskgKlyJD48uWZeqzVroGsuXAAmksZ6U3i6tUb+
         Yeh6wEZyzhdZcnpGMNq10vI3aGSrSif6fg1xGckRY/jxxC3kTap7ensCE2WeKGKi8TUZ
         0W4Q==
X-Gm-Message-State: AOJu0YxdliEbCTTjL9hvfThQTCzd8ibd3TvdrLOZnS1LtWrfxn6OE8/R
	q0FYFd5iF0sjygEWeGE8Mhl21hLu2rtxaoOTYCSZem+qgRjZKUcLefzylA==
X-Gm-Gg: ASbGnctjlZEfo7/rWsAOyI6LyIsP8UQqyAwMYpe0eaSSK3xgVhGBP8EXhZ1aFJvX08U
	iRNEmOJI7IPWOP29YrbcjHDuV3tTXA6ROPy8p8GucVuPHzz5/uBScTS6vuXDWjveYhWxUjlFV8l
	tUWVfjqQ552JgHBa9miU2/ZFHR28Kpj+q44MZmRrBGZIw0+ftjymEsSfvdIIDOPloE/9T8H1mmd
	nq9xhD3Tyaa3W2tX5NcKwLnBIswGLUdLAsz+M3Ovpx6VKLmvcFXKgeJ72a9gLz4enlCW+Rfb2yG
	LxJNrjk5XsEWNg==
X-Google-Smtp-Source: AGHT+IEuU3osAv9kRKBXFco7oec5wi08dgnFLjSSSK/dxmWZ8VKvzJTNgmPQ6rUiMytncpz8f6uJsQ==
X-Received: by 2002:a05:6a21:a8e:b0:1ee:6a20:1778 with SMTP id adf61e73a8af0-1ee6b36035fmr10397352637.20.1739511589424;
        Thu, 13 Feb 2025 21:39:49 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb588fa764sm2078537a12.34.2025.02.13.21.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 21:39:49 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH] refspec: clarify function naming and documentation
Date: Fri, 14 Feb 2025 11:09:38 +0530
Message-Id: <20250214053938.26807-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename `match_name_with_pattern()` to `match_refname_with_pattern()` to
better reflect its purpose and improve documentation comment clarity.
The previous function name and parameter names were inconsistent, making
it harder to understand their roles in refspec matching.

- Rename parameters:
  - `key` -> `src_pattern` (source globbing pattern)
  - `name` -> `refname` (refname to check)
  - `value` -> `dst_pattern` (destination mapping pattern)

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
This change was previously discussed in an earlier patch series [1], where
Junio suggested making this update after the dust settled there.

[1]: https://lore.kernel.org/git/xmqqa5bctbnx.fsf@gitster.g/

 refspec.c | 34 +++++++++++++++++-----------------
 refspec.h |  9 +++++----
 remote.c  |  6 +++---
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/refspec.c b/refspec.c
index 3d6cf4dc92..329de7bb18 100644
--- a/refspec.c
+++ b/refspec.c
@@ -269,28 +269,28 @@ void refspec_ref_prefixes(const struct refspec *rs,
 	}
 }
 
-int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result)
+int match_refname_with_pattern(const char *src_pattern, const char *refname,
+				   const char *dst_pattern, char **result)
 {
-	const char *kstar = strchr(key, '*');
+	const char *kstar = strchr(src_pattern, '*');
 	size_t klen;
 	size_t ksuffixlen;
 	size_t namelen;
 	int ret;
 	if (!kstar)
-		die(_("key '%s' of pattern had no '*'"), key);
-	klen = kstar - key;
+		die(_("source pattern '%s' has no '*'"), src_pattern);
+	klen = kstar - src_pattern;
 	ksuffixlen = strlen(kstar + 1);
-	namelen = strlen(name);
-	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
-		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
-	if (ret && value) {
+	namelen = strlen(refname);
+	ret = !strncmp(refname, src_pattern, klen) && namelen >= klen + ksuffixlen &&
+		!memcmp(refname + namelen - ksuffixlen, kstar + 1, ksuffixlen);
+	if (ret && dst_pattern) {
 		struct strbuf sb = STRBUF_INIT;
-		const char *vstar = strchr(value, '*');
+		const char *vstar = strchr(dst_pattern, '*');
 		if (!vstar)
-			die(_("value '%s' of pattern has no '*'"), value);
-		strbuf_add(&sb, value, vstar - value);
-		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
+			die(_("destination pattern '%s' has no '*'"), dst_pattern);
+		strbuf_add(&sb, dst_pattern, vstar - dst_pattern);
+		strbuf_add(&sb, refname + klen, namelen - klen - ksuffixlen);
 		strbuf_addstr(&sb, vstar + 1);
 		*result = strbuf_detach(&sb, NULL);
 	}
@@ -301,7 +301,7 @@ static int refspec_match(const struct refspec_item *refspec,
 			 const char *name)
 {
 	if (refspec->pattern)
-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+		return match_refname_with_pattern(refspec->src, name, NULL, NULL);
 
 	return !strcmp(refspec->src, name);
 }
@@ -352,7 +352,7 @@ static int refspec_find_negative_match(struct refspec *rs, struct refspec_item *
 			const char *key = refspec->dst ? refspec->dst : refspec->src;
 			const char *value = refspec->src;
 
-			if (match_name_with_pattern(key, needle, value, &expn_name))
+			if (match_refname_with_pattern(key, needle, value, &expn_name))
 				string_list_append_nodup(&reversed, expn_name);
 		} else if (refspec->matching) {
 			/* For the special matching refspec, any query should match */
@@ -397,7 +397,7 @@ void refspec_find_all_matches(struct refspec *rs,
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result))
+			if (match_refname_with_pattern(key, needle, value, result))
 				string_list_append_nodup(results, *result);
 		} else if (!strcmp(needle, key)) {
 			string_list_append(results, value);
@@ -426,7 +426,7 @@ int refspec_find_match(struct refspec *rs, struct refspec_item *query)
 		if (!refspec->dst || refspec->negative)
 			continue;
 		if (refspec->pattern) {
-			if (match_name_with_pattern(key, needle, value, result)) {
+			if (match_refname_with_pattern(key, needle, value, result)) {
 				query->force = refspec->force;
 				return 0;
 			}
diff --git a/refspec.h b/refspec.h
index f62f83a7ee..6cec985b07 100644
--- a/refspec.h
+++ b/refspec.h
@@ -75,11 +75,12 @@ void refspec_ref_prefixes(const struct refspec *rs,
 int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
 
 /*
- * Checks whether a name matches a pattern and optionally generates a result.
- * Returns 1 if the name matches the pattern, 0 otherwise.
+ * Checks if a refname matches a globbing refspec pattern.
+ * If dst_pattern is provided, computes the mapped destination refname.
+ * Returns 1 if refname matches src_pattern, 0 otherwise.
  */
-int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result);
+int match_refname_with_pattern(const char *src_pattern, const char *refname,
+				   const char *dst_pattern, char **result);
 
 /*
  * Queries a refspec for a match and updates the query item.
diff --git a/remote.c b/remote.c
index 5574b6a00f..5d3d1773dc 100644
--- a/remote.c
+++ b/remote.c
@@ -1322,9 +1322,9 @@ static char *get_ref_match(const struct refspec *rs, const struct ref *ref,
 			const char *dst_side = item->dst ? item->dst : item->src;
 			int match;
 			if (direction == FROM_SRC)
-				match = match_name_with_pattern(item->src, ref->name, dst_side, &name);
+				match = match_refname_with_pattern(item->src, ref->name, dst_side, &name);
 			else
-				match = match_name_with_pattern(dst_side, ref->name, item->src, &name);
+				match = match_refname_with_pattern(dst_side, ref->name, item->src, &name);
 			if (match) {
 				matching_refs = i;
 				break;
@@ -1942,7 +1942,7 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
-		if (match_name_with_pattern(refspec->src, ref->name,
+		if (match_refname_with_pattern(refspec->src, ref->name,
 					    refspec->dst, &expn_name) &&
 		    !ignore_symref_update(expn_name, &scratch)) {
 			struct ref *cpy = copy_ref(ref);

base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
-- 
2.34.1

