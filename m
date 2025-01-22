Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2861C1F27
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737532381; cv=none; b=KlkMsJhI69EUz1tLR/K+Pw3Mj9KOz7gHirFn+xGF2outeDcXXLx+/rzVXFRzyoXrWbEgfCS8VWmPo2FDcasPmyt9sm/pvJttMT6pgjEjiXJvh1z7bXHNrEh7jI19IGIGXsUcxq87sDBG+Yk1yXTr2h+kWofT1qsKHw+EYt8JEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737532381; c=relaxed/simple;
	bh=HlTQqT6mSg7y2tTmbsaijEx3ewXGv45+eLLcrEJBQ8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpnUsWoU4XZElrpIantD2feo3k4x7EGWHZDRZMSBHka4aSdCGOX00wQ2v4+0qX/h49xrOEK/vyCJY4HDSPOD6iJo1GDciDw+Ik9j8uq7+yedejOdgbZe17otGBbE3Uu7dI+fr4LLsrbqJCP1Z2akFWvPqWx9GuCamVOm97KCE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtllUqTg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtllUqTg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21a7ed0155cso106196005ad.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737532378; x=1738137178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxM0PfrEgSIO5fAbpftuW0vwVbj96S5P+kMWkRByfow=;
        b=YtllUqTgNPrla+lWrMGMBwFqep0NQdJbG68MVmZb1zkMgnd0/VpKL9CdjWrgkEsPj1
         OfrUR4c8SZDfcvXsecxnPmgLE02Ut1sGZLZ+FCBf2tQKS7PurXK9WIcKSUYYeFqQvjB2
         EllMM4vALXAHXDOYP/ACCkhXqIAMnX4NCV2jWgO3/886UNiAtRcS88RKVD8QYEsqGW6Y
         rzVKYN+MaGvsDlqO1wIZphwgZorqLiMudMjU/RAyF44fj02n/Rg8DfgISNNzJy4U31xN
         WnFaUm5FP2fswY2RvZfEWUPQoNq51v1DFaCSjKDPmcaY3TwPkK87phyiulP/GoZGNwhz
         O/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737532378; x=1738137178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxM0PfrEgSIO5fAbpftuW0vwVbj96S5P+kMWkRByfow=;
        b=YdZ6qpqT3l6iD/OfDI8SXQkPiI+h8RYf8HtNxrvpP1xxI5sWoyCcn/kYwFvR2CrV6B
         CMeDyvidxX3WKHkile/hxtD2inItPUMSsknmlaO45U7FUBfFMywmbCGgREE2KYFpcSHn
         WARdQtuKZe5HqCASJNMtYO0de8dp9qEq+nsUJiRwnV1LVK/kWOKWyP143EH7sJ+rnfps
         xuTOSexjHNsfi3Kb93mAsomIxJ+Sf+QwJ1elt+sTMQr/JVj0WazKRjPROJ5nl0LEzPSS
         TcpDvovSsV8shVq0VV65SIU3AAkyBcEy8HbMBiyFoNZSwKqXc1gIXAz1PiOBkYdu8WVR
         h9Tg==
X-Gm-Message-State: AOJu0Yzxr3Y/5oAdl1m7x6oZoNXSxeJOGukPGzRk6cVFu7ZU4NIZve34
	1XgBJQXzua9CQFW+mzXsXN2ta5c/ScIN39vi35u6F8oass6Yxpfng3rbklQ1FTk=
X-Gm-Gg: ASbGncs3qNd5wQP5Mzwi75obaWksHHD0QCk0TvKKtYa8UvEAJuR0fVKsgFCir90nIE1
	hwIhCNTTWHsGjnYqUuA0Rt782xgy8JijTSULU0amwOUmiBl61bdMT1fRqmR/mjwg1HnX+eoQSfl
	uh97Hlw9AsRnkVlRZcUCwHWuU2sIvQlhijzQ0HVq4Q3FqD687l5Ppflj0jgR5m7pLbHc+3Z0Kqu
	WZyl1wjDeavkdw+QLjKzTNOdn9mWfegDve7IqfQ9Z9yGcp6FInLaGbLttqZE/glMKln
X-Google-Smtp-Source: AGHT+IGWhIjyODzxsCgViF1hvLd0lGjSQBsYaHa6gldAZLmPpPu5iJFn4b0lkvSQOqCk/fciW1EvwA==
X-Received: by 2002:a17:902:f644:b0:211:8404:a957 with SMTP id d9443c01a7336-21c355f6aa9mr360933365ad.41.1737532378308;
        Tue, 21 Jan 2025 23:52:58 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acce3sm89284155ad.119.2025.01.21.23.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 23:52:57 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pavel Rappo <pavel.rappo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/3] refspec: relocate omit_name_by_refspec and related functions
Date: Wed, 22 Jan 2025 13:21:52 +0530
Message-Id: <20250122075154.5697-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122075154.5697-1-meetsoni3017@gmail.com>
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `omit_name_by_refspec()`, `refspec_match()`, and
`match_name_with_pattern()` from `remote.c` to `refspec.c`. These
functions focus on refspec matching, so placing them in `refspec.c`
aligns with the separation of concerns. Keep refspec-related logic in
`refspec.c` and remote-specific logic in `remote.c` for better code
organization.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h |  8 ++++++++
 remote.c  | 48 ------------------------------------------------
 remote.h  |  6 ------
 4 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/refspec.c b/refspec.c
index 6d86e04442..66989a1d75 100644
--- a/refspec.c
+++ b/refspec.c
@@ -276,3 +276,51 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		}
 	}
 }
+
+int match_name_with_pattern(const char *key, const char *name,
+				   const char *value, char **result)
+{
+	const char *kstar = strchr(key, '*');
+	size_t klen;
+	size_t ksuffixlen;
+	size_t namelen;
+	int ret;
+	if (!kstar)
+		die(_("key '%s' of pattern had no '*'"), key);
+	klen = kstar - key;
+	ksuffixlen = strlen(kstar + 1);
+	namelen = strlen(name);
+	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
+		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
+	if (ret && value) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *vstar = strchr(value, '*');
+		if (!vstar)
+			die(_("value '%s' of pattern has no '*'"), value);
+		strbuf_add(&sb, value, vstar - value);
+		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
+		strbuf_addstr(&sb, vstar + 1);
+		*result = strbuf_detach(&sb, NULL);
+	}
+	return ret;
+}
+
+static int refspec_match(const struct refspec_item *refspec,
+			 const char *name)
+{
+	if (refspec->pattern)
+		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+
+	return !strcmp(refspec->src, name);
+}
+
+int omit_name_by_refspec(const char *name, struct refspec *rs)
+{
+	int i;
+
+	for (i = 0; i < rs->nr; i++) {
+		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
+			return 1;
+	}
+	return 0;
+}
diff --git a/refspec.h b/refspec.h
index 69d693c87d..9556d08bd5 100644
--- a/refspec.h
+++ b/refspec.h
@@ -71,4 +71,12 @@ struct strvec;
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes);
 
+/*
+ * Check whether a name matches any negative refspec in rs. Returns 1 if the
+ * name matches at least one negative refspec, and 0 otherwise.
+ */
+int omit_name_by_refspec(const char *name, struct refspec *rs);
+int match_name_with_pattern(const char *key, const char *name,
+				   const char *value, char **result);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 0f6fba8562..40c2418065 100644
--- a/remote.c
+++ b/remote.c
@@ -907,54 +907,6 @@ void ref_push_report_free(struct ref_push_report *report)
 	}
 }
 
-static int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result)
-{
-	const char *kstar = strchr(key, '*');
-	size_t klen;
-	size_t ksuffixlen;
-	size_t namelen;
-	int ret;
-	if (!kstar)
-		die(_("key '%s' of pattern had no '*'"), key);
-	klen = kstar - key;
-	ksuffixlen = strlen(kstar + 1);
-	namelen = strlen(name);
-	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
-		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
-	if (ret && value) {
-		struct strbuf sb = STRBUF_INIT;
-		const char *vstar = strchr(value, '*');
-		if (!vstar)
-			die(_("value '%s' of pattern has no '*'"), value);
-		strbuf_add(&sb, value, vstar - value);
-		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
-		strbuf_addstr(&sb, vstar + 1);
-		*result = strbuf_detach(&sb, NULL);
-	}
-	return ret;
-}
-
-static int refspec_match(const struct refspec_item *refspec,
-			 const char *name)
-{
-	if (refspec->pattern)
-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
-
-	return !strcmp(refspec->src, name);
-}
-
-int omit_name_by_refspec(const char *name, struct refspec *rs)
-{
-	int i;
-
-	for (i = 0; i < rs->nr; i++) {
-		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
-			return 1;
-	}
-	return 0;
-}
-
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 {
 	struct ref **tail;
diff --git a/remote.h b/remote.h
index bda10dd5c8..0d109fa9c9 100644
--- a/remote.h
+++ b/remote.h
@@ -261,12 +261,6 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-/*
- * Check whether a name matches any negative refspec in rs. Returns 1 if the
- * name matches at least one negative refspec, and 0 otherwise.
- */
-int omit_name_by_refspec(const char *name, struct refspec *rs);
-
 /*
  * Remove all entries in the input list which match any negative refspec in
  * the refspec list.
-- 
2.34.1

