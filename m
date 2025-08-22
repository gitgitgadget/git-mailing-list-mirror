Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B713A3F7
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852559; cv=none; b=QgHg1a+Y1XTvCpoa0mJRolOQhqTfQYuWV5xDeQ5N3EUTfMzeX+4DdnWRMpzn8dBzlGMLStsYoYwiDtqMOXEpatk3VkCtndRGcr/zg34EOilSNFjG83SJQy+gr/yoPfrLyB7vRYZhqLGct4su0kefSiZ2XMQVqqVyJASECXMSKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852559; c=relaxed/simple;
	bh=aEzn0IKqVM6xY9ib7b3ZHZldvjnvDaD5hAz95NC6nv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuF/k9zbHASBAAVb9f0j3jZvJIHguHojwxwfhHQFy6tH4wCy1K5Hlv5+TywlK1LqPo2pJ5ooos3NeYd8qZ3R01tP8oLQBZ8HQRNJF8RSJoxo0zpkfc6VYtXYIO7Rmb/SPUXJ9Kpz0az2eK+Y908WnURGpH5qFWecKHu2g6RIiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNcOlN5s; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNcOlN5s"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471754c159so1241872a12.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755852557; x=1756457357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fNCT58k/my+QCdopiXS4QQfQM4qUwmIuE3uOP2SW2k=;
        b=XNcOlN5sVEz+kHvX4LIVht1Bxf5KTEOe6DGtyfgWT4NWJOxXSnyy8vGGydS/v0ciO+
         jE2GTl/eSCNivvPKcV69VChWRMcdZmOcb9PMYv3NVvzJQIiwjoYMZG6kzuconl7Pxxe7
         TrSLrpe+a1eLhmBSrYKSFnBRqVubO0dKuhUDEbo/q6riVR5I6RXnNxz+mp4Yan7U9e/N
         ZWXJv1D+BflbcvZXGCOZr4hocVeIkHtbP0MUdiZ+IhFA/Y5wzQy/kRll5H11jafF3sCS
         ahzoOvaDDyg6yl9q9oBUOMdod5nKEsurvauashk76uSo9+8DxWYpM0InqVGg5NqyOi2Z
         80eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852557; x=1756457357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fNCT58k/my+QCdopiXS4QQfQM4qUwmIuE3uOP2SW2k=;
        b=QamkmjF20RLFp/2kjan31IkELKnjBWC4/7A7v7CUJQebx5/UR5GZ4Ba7IfKhMJQpEA
         7fVkKcW+jbGWZN8a0Vv6cMcLXzg0DPr2jn4mZe0oyNND5xJy+hn+0PAu8x1Giir/W1DR
         vxymLzX1OR1eFeY4kls0AvocnTc18KxLGJ73t/X9o4lmZlQBTBRSjFI453ex0DvQfRTx
         4ybKx7Wia4nBzLKe1a30XHwTx0wmdDJ/4+jXmH2851I4UThUv66FjG01mLfyYL6bcmzp
         tNwfEJM/EWf2R22qcKqlBcantMhCo94EFHcjtrR60YucymK7iFQmqN8RdVdoLljxuDds
         oAUg==
X-Gm-Message-State: AOJu0YwxW0CzRD/bCLxnQ5i5/rlUCjHf41i0FMSwjDcQYbajb2xSjGVr
	/le3tewt/rgH/SHZ1P0UnTdLwe6aAIDyc1rtIFYExGd8fOtCWur4zErb/5HuojHNa80=
X-Gm-Gg: ASbGncv3kIvgBmKV73IqGr7QCYb+Yezl8kZ3i8JLr3hmjuMpdUtA+82UQvIQWGb4f+l
	uQnfXNREZA7vbmXLVyfJegoTIHb/Z1CCGoQ2WgeD6BRaAyL0RAveH7i+wpB/fjd6BDVDDupyxRt
	aEOUXI2JSKqwUjXGpjb57qQ0MKbnelxX/ME7oRw6cDMMyFfXD9/uuOj1cZ/osaumVr1UYMK2eQ7
	rVVTFfz1hj3MEbfxI8T8X9/0TXSBjuoqecz1BTT2tSVNPl4xpoT8gb4usINzq3YFP3Edu9lTaVH
	UGtUvVw/iBw4Zi5rEratmmJP+M15jy4TNm7Jf5egKO5cXcuo3oDFQB9tv/eE/FAvgAGJDx2L5+G
	ypEq1cI/1BBqydfK5HF10dQH+Y4mJAg50kA==
X-Google-Smtp-Source: AGHT+IHJfNqMLLHGqaMPjJfw2FvRMijPadJN5npGW4v89bcwGjf0O923DRfIhvMFPQx4aWQVgmzSug==
X-Received: by 2002:a17:902:d4cd:b0:240:1ec4:61fe with SMTP id d9443c01a7336-2462ef4ca85mr30038975ad.28.1755852556654;
        Fri, 22 Aug 2025 01:49:16 -0700 (PDT)
Received: from ayush-sharma.. ([103.196.213.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33a79asm77740625ad.6.2025.08.22.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:49:16 -0700 (PDT)
From: monarch <ayushoffinfo17@gmail.com>
To: git@vger.kernel.org
Cc: monarch <ayushoffinfo17@gmail.com>
Subject: [PATCH] config: add "hostname" condition to includeIf
Date: Fri, 22 Aug 2025 14:19:09 +0530
Message-ID: <20250822084910.98308-1-ayushoffinfo17@gmail.com>
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

