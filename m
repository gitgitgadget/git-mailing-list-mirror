Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4417BA3
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851736; cv=none; b=W8ji7VnhXxvdqfWqjmSBycBqFIilmQbeIQKdwfifyLS4ItvVtxQhkjwuD8vmd2bUvE5fM5KSmJTgtRfEIABz5jAamyqSYpy+3TXIwDF5WT7A+/3nm5VyzKQGr92TlKz6LegbE+6YGq7nbdWRWCn9hthtWi9pFqNti3CfgFSxJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851736; c=relaxed/simple;
	bh=aEzn0IKqVM6xY9ib7b3ZHZldvjnvDaD5hAz95NC6nv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DE25K/2sF99usNTBm9MimhtbTr9ZkscatlJmXrB7pTXTX8GrGR1zHeNXuvjI/O7vTYA394NUlMi6OtTydD4uzI5Ky2MRYuwk1fCgDTxC3q1qugCWzIU2QWYgNjQm9Uv3mwJORsTrIu501MirxJNnfDbSgOvUZism6Ge+lg64M+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2lQwb7+; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2lQwb7+"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-24456ce0b96so19450385ad.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755851734; x=1756456534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fNCT58k/my+QCdopiXS4QQfQM4qUwmIuE3uOP2SW2k=;
        b=A2lQwb7+eZDcGxvXgdugXO7KdU5slpt9WFsVR2otesGy+1hbAOGRWcm5bFTuIAjd9D
         pr/2Xbcu3WkNtPNoqVdQCkSsdlAud/IuPfFnLf8nZSUI/S4rv+7d4ntTwgX9ls3Gcdli
         gyyGsiZHAPtBteBKi7EhjxgkI2NdpMaA+JW6KK5ZzLUG8Ius4eanuwT1iMLLNufNXOTq
         UQm63rlzEc+1qdnbX/0mgAEEOS3nog0rApyDJ9FKQj9wctRfh6G2FcyADz1MyR1ZrcT+
         W5iQtwFbueI/pyzJuIEAik0p47T9L0MiG6Dkmoyk2M07oVk6N0touQNpvAAQsvRJJ1W3
         CBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851734; x=1756456534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fNCT58k/my+QCdopiXS4QQfQM4qUwmIuE3uOP2SW2k=;
        b=hJT3hKShCk3twIpO0LGIyodZ+PNdz9FlrUDE6K5lDqq2Ux7yhy1TOxYjtakNwju+iF
         fBUAHSph06Kw0rW6wn4t2v5YvPO4XW8ljpHggFmi9fNwP2cOmuA+Xc78MESZBK7pqJaA
         8QwIvtwL9DSyA3Al42usCv6Or1qXAFve+Qz1D43XS8nyt4f7Ae7rpPZN/bNe2ZRgPXEZ
         2AVEP8DE+pKFTklN3e4VUcgx7/zlyvJlOHR96WkzmPzZJE6Ry0b6N+6+5S0Q5RJX6t9Q
         qkYcior2giX8xffnPHbi6JicJEHLrrgyvdrVNw1bPxmL+k+TBbiX3s0W4tMpDPW7Ig4t
         MT3g==
X-Gm-Message-State: AOJu0Yx9jH14lNiKGx7mmfOT6vjSWws9cni+orp73sqv8sJaORIKCmWF
	79RFdAjEq/kPkqEI8RyGlInXRT+Mf0PgEN9jyUo07Id2wTXZEenvxiBidZFoUX/q
X-Gm-Gg: ASbGncsUrFkH2fDZwZZgr8MvQKbhS2yM4T06uwukiQArZVDgD7FJ9/Sqqf1ZVxg0v2T
	5+YBwasUJU5NYc4pM7i3i/2NdLz+E9IsRz1Q8sKDxqOxtIZ220Jv5ozy0zappt8zuvX0tYxRwum
	aOFjOYVV2XoA4DcTY2ygX/7BT9rtBxJiyRl8I5LCkEFbTB5K7JCyuwDtU/PuBfL+YQlNy7pglDW
	y83ucyX7YLx4bDu7qn6qg2bnsCvSEPRjOrkDTOwaSBtOrZsYYX7aL6/QlXN4Bae9JwkmmbPfekY
	DQWqZNsXoDoFby8c8asoOLxNVKc+BRSXBXvTV2uzquQxrSxg9f7TJTJlls0bt5nzaQEFQpejS0Q
	pPxjQep7Wz8F81BBRgektC+QIfz+V133S/A==
X-Google-Smtp-Source: AGHT+IHEKfmVyBTaa0HjmDfNi7MI+wt+q2UPfTJvFmrRUMukkUU0bDZ0Y1Q9lNrD5i6tKLC27cSKSQ==
X-Received: by 2002:a17:902:e888:b0:240:4d19:8774 with SMTP id d9443c01a7336-24633d6a31amr26625315ad.24.1755851734128;
        Fri, 22 Aug 2025 01:35:34 -0700 (PDT)
Received: from ayush-sharma.. ([103.196.213.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c745dsm76740675ad.73.2025.08.22.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:35:33 -0700 (PDT)
From: monarch <ayusharmagsoccontri@gmail.com>
X-Google-Original-From: monarch <ayushoffinfo17@gmail.com>
To: git@vger.kernel.org
Cc: monarch <ayushoffinfo17@gmail.com>
Subject: [PATCH] config: add "hostname" condition to includeIf
Date: Fri, 22 Aug 2025 14:05:05 +0530
Message-ID: <20250822083505.96187-1-ayushoffinfo17@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach "includeIf" to include configuration based on the machine's hostname,
as returned by gethostname(2).

Example:

    [includeIf "hostname:work-laptop"]
        path = ~/.gitconfig.work

    [includeIf "hostname:home-pc"]
        path = ~/.gitconfig.home

This allows users to write host-specific configuration without separate branches.

Signed-off-by: monarch <ayushoffinfo17@gmail.com>
---
 config.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index e0ff35d426..dbc1a2bc75 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 
 #include "git-compat-util.h"
+#include <unistd.h>
 #include "abspath.h"
 #include "date.h"
 #include "branch.h"
@@ -391,23 +392,47 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
+static int include_by_hostname(const char *cond, size_t cond_len)
+{
+    char actual_hostname[1024];
+    struct strbuf target_hostname = STRBUF_INIT;
+    int ret = 0;
+
+    // Make sure the call to gethostname is correct and its return value is checked.
+    if (gethostname(actual_hostname, sizeof(actual_hostname)) != 0)
+        return 0; // If it fails, the condition is false.
+
+    strbuf_add(&target_hostname, cond, cond_len);
+
+    // The core of the logic: strcmp returns 0 when strings are equal.
+    if (strcmp(actual_hostname, target_hostname.buf) == 0)
+        ret = 1; // Success, the hostnames match!
+
+    strbuf_release(&target_hostname);
+    return ret;
+}
+
 static int include_condition_is_true(const struct key_value_info *kvi,
-				     struct config_include_data *inc,
-				     const char *cond, size_t cond_len)
+	struct config_include_data *inc,
+	const char *cond, size_t cond_len)
 {
-	const struct config_options *opts = inc->opts;
+const struct config_options *opts = inc->opts;
+
+
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
 		return include_by_gitdir(kvi, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
-	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
+	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, cond_len))
 		return include_by_branch(inc, cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
-				   &cond_len))
+  &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &cond_len))
+		return include_by_hostname(cond, cond_len);
 
-	/* unknown conditionals are always false */
+/* unknown conditionals are always false */
 	return 0;
 }
 
-- 
2.43.0

