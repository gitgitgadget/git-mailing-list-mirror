Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6A136353
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738392200; cv=none; b=E8riQ9YycGVJA1NGbcH+N7cLPe7IGYv1LC/e9BK6oeLL/yGtm9GNxNCdb/66qw6AD0s4QKviwdH5smvOz7PxXbruwMwCbLrOImUQ1YedRNtaCZMz9sIal/USqJtU94Zj1WtDYww5NuWChA5MHAiJOfFkTtQaKrY59mh9YIp7K0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738392200; c=relaxed/simple;
	bh=4mCqh4v2rAK/MCHKGPkxoJWMb5pUUE4ddEthQN3orUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b5RgeK3Zba3UZe7pX+htfiFNAOwXUtA23MxuWJ7GCRzzfWtR8NAEZYnV6cO1OnaLlJXKzv7sYxnVzADF+gwFbnS6Etj5IoeKptbnypdVFWrkuEZBi37HN7QhqVd5WZz+yO4TnkaLFpcCUcpVSqbTZhb+qIQABMx+xcV2Jfd1EnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D63sriu4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D63sriu4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2165448243fso45552855ad.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738392196; x=1738996996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8YKgcgmOUMbJxDoRpIidv/VEbqNHTX/3NXuyu7CVpI=;
        b=D63sriu4cK+Hfa84AZLPQf4YWYhguiGQnMs8qs4CbKIFVx51SqgVSalQNVdCbzMsGF
         PP5dAAvm7Xuppj10FZCz5mPGz6eopaWUJWzV87Y6E0P90G2BEKFVVuo3kuTsj7NCEcC4
         LVIbdRdMGZmMaqmSfrjOfAh06y62P1P8Ih/skP+cDdn4JG+1RsBgJYYRape/g3ZKQc8i
         zuhszEya9ncVnngNl8ygQJzbmHKIeE865dZHqwortGvkaRYA0cvF3vfi1LT6euWE3LWu
         RMVudfT62SktNQvNQ5li5LGOa6HkyBJN/U4Y+06nhNQ/xWFvPnwOQzgfHk80Ez6Wx0JB
         KAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738392196; x=1738996996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8YKgcgmOUMbJxDoRpIidv/VEbqNHTX/3NXuyu7CVpI=;
        b=Y0HDrFPTtuyoOWN3rcs9Mgs4rFVHIOicSqb7wuvAoog7wbRSnsYJMc0q6DFy52HYd5
         ZTXZmDFSSQ/Lp1i2jVMP0sDPtGStPNIsh/OHvlOk9c6eItlK2gXSB6lMHamUsLEGKGAj
         s1j1eBmYXb1CQC/OkUOmlt6I4i+XIc0GKaK79a4sH0fLlfO/81nv9tZXIJxQlbdrcWqo
         V/B+GAufeCMelFeUkAOMVnvVsarH7DuEfTUFL7vaZbSFMWSTAiImWPLXIjBvxCyHJUpB
         r0JrXhKeKg2oRltLZchtC3onIwv0nX/lRuOn9uSSRcHRIbNaaNozanc7pFwPm5Hr1klc
         DgSQ==
X-Gm-Message-State: AOJu0YxcwEDuep28PPoIkfiIq/aKgKV7c7k7oNWeSewlz8mL/mjjy5Nx
	a3Atyjfy2o9p9l/79Zw6rlD/1A2W+Rb/CP5bifToectPb3Or0ppRPHT46fO+IWY=
X-Gm-Gg: ASbGncsylLhLmezlzp8xPTeWI1osUKPPlbiRyacmNhheQwNnpKA1X+uPklhrmpKwO2c
	myRCbPuUVPV/t+KkoBrElxs+kTHmuNgPO939HhIHCvXcyR0RQAFNW3uMzvhVgkLrrRZ5YzOBnXm
	v4gg9fmm4JaHd0TJFa8yfCAt45Wq5VZnhbjo6DA5R8laV0101XmPlUr6xgexi44htve7uN58A9i
	j+jiCq0tug9GcsGgJiv9nnzmSxMw1Kej2P9nGdSiwnfT2/qUUiw2QZ82ySvSNyfFjhdK3Spf1RR
	oeXDUxbVZ0gNUg==
X-Google-Smtp-Source: AGHT+IHtJPn1ER+DJeo1vT4wAWif6Atyw/ZcJkqtwfg2r4nru02vq3sCg+uJ6XL/Lgfe7nJhjV0huQ==
X-Received: by 2002:a05:6a20:4394:b0:1e0:d575:8d4f with SMTP id adf61e73a8af0-1ed7a61ca8fmr24364392637.37.1738392196076;
        Fri, 31 Jan 2025 22:43:16 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0e8ef61sm4058592a12.78.2025.01.31.22.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 22:43:15 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Pavel Rappo <pavel.rappo@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Matthew Rogers <mattr94@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Elijah Newren <newren@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 5/5] refspec: relocate apply_refspecs and related funtions
Date: Sat,  1 Feb 2025 12:12:02 +0530
Message-Id: <20250201064202.76116-6-meetsoni3017@gmail.com>
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

Move the functions `apply_refspecs()` and `apply_negative_refspecs()`
from `remote.c` to `refspec.c`. These functions focus on applying
refspecs, so centralizing them in `refspec.c` improves code organization
by keeping refspec-related logic in one place.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 32 ++++++++++++++++++++++++++++++++
 refspec.h | 12 ++++++++++++
 remote.c  | 31 -------------------------------
 remote.h  | 11 -----------
 4 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/refspec.c b/refspec.c
index 6634e7765d..47974e86f0 100644
--- a/refspec.c
+++ b/refspec.c
@@ -9,6 +9,7 @@
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
+#include "remote.h"
 #include "strbuf.h"
 
 /*
@@ -447,3 +448,34 @@ int find_refspec_match(struct refspec *rs, struct refspec_item *query)
 	}
 	return -1;
 }
+
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
+{
+	struct ref **tail;
+
+	for (tail = &ref_map; *tail; ) {
+		struct ref *ref = *tail;
+
+		if (refname_matches_negative_refspec_item(ref->name, rs)) {
+			*tail = ref->next;
+			free(ref->peer_ref);
+			free(ref);
+		} else
+			tail = &ref->next;
+	}
+
+	return ref_map;
+}
+
+char *apply_refspecs(struct refspec *rs, const char *name)
+{
+	struct refspec_item query;
+
+	memset(&query, 0, sizeof(struct refspec_item));
+	query.src = (char *)name;
+
+	if (find_refspec_match(rs, &query))
+		return NULL;
+
+	return query.dst;
+}
diff --git a/refspec.h b/refspec.h
index 0393643bc8..5cbdc5f622 100644
--- a/refspec.h
+++ b/refspec.h
@@ -96,4 +96,16 @@ void find_all_refspec_matches(struct refspec *rs,
 				    struct refspec_item *query,
 				    struct string_list *results);
 
+/*
+ * Remove all entries in the input list which match any negative refspec in
+ * the refspec list.
+ */
+struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
+
+/*
+ * Search for a refspec that matches the given name and return the
+ * corresponding destination (dst) if a match is found, NULL otherwise.
+ */
+char *apply_refspecs(struct refspec *rs, const char *name);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 858ab39471..ad16d2493d 100644
--- a/remote.c
+++ b/remote.c
@@ -907,37 +907,6 @@ void ref_push_report_free(struct ref_push_report *report)
 	}
 }
 
-struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
-{
-	struct ref **tail;
-
-	for (tail = &ref_map; *tail; ) {
-		struct ref *ref = *tail;
-
-		if (refname_matches_negative_refspec_item(ref->name, rs)) {
-			*tail = ref->next;
-			free(ref->peer_ref);
-			free(ref);
-		} else
-			tail = &ref->next;
-	}
-
-	return ref_map;
-}
-
-char *apply_refspecs(struct refspec *rs, const char *name)
-{
-	struct refspec_item query;
-
-	memset(&query, 0, sizeof(struct refspec_item));
-	query.src = (char *)name;
-
-	if (find_refspec_match(rs, &query))
-		return NULL;
-
-	return query.dst;
-}
-
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
 	return find_refspec_match(&remote->fetch, refspec);
diff --git a/remote.h b/remote.h
index f109310eda..b4bb16af0e 100644
--- a/remote.h
+++ b/remote.h
@@ -261,17 +261,6 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
-
-/*
- * Remove all entries in the input list which match any negative refspec in
- * the refspec list.
- */
-struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs);
-
-int find_refspec_match(struct refspec *rs, struct refspec_item *query);
-char *apply_refspecs(struct refspec *rs, const char *name);
-
 int check_push_refs(struct ref *src, struct refspec *rs);
 int match_push_refs(struct ref *src, struct ref **dst,
 		    struct refspec *rs, int flags);
-- 
2.34.1

