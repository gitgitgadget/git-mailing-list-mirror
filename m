Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE11DFE3
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183355; cv=none; b=N2poFNdfBmV4OOXgGMS8r9BZbRkOpc8VSZvcOjn0SjgN9aMCSqjABioRUE9zFz2Ov/ANkwBc4sjbGURDwAnF224PzeHXOxmYKOccmIebu6Cpj2ZLFAYIPqvXdMBOQM4EN5DK3SftJw0Khj1sPSTtSXSPOYV2RwSXdcojPbdgEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183355; c=relaxed/simple;
	bh=xbdWzH6NzhcNDu7uPdgs5I9UU71FaaC54uZybJMdxuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZMNAiubZsOBV+6Oe3GgdLEiavABarPgr6NPbtssj5Bzx015pBTfcV6eE/akzGV392x+mnGDRW6yszWC5lU4zT0iSLxoJ8oGtHFJMcLekJ1I746WTVn0f3ms828c0k5hZKhlnantE1gVzS2BTeEEEkM1Qav9bYoJ+xFXKlAu4RyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4E5YV+/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4E5YV+/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso70850915e9.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727183352; x=1727788152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJWMpEzQ7j+WlghGgTWAZxs7uwmf/XwviKdrEoOoPNs=;
        b=l4E5YV+/iC3qpYEePXTzULppnutnTzP2+/yPuv12xsAzHaxuF0kr+4MUPOGZxjwIKK
         Q/8Q6G1utfKl3o85banK3Mj4dhv77/FHGfpRChg+BICwjtdhNET5wYLLRpH5Iv+5Hpl4
         cpop1hOmqiDuUEGLI6ja5SlfQPGm0E4i4rN24UiM9fya654FTguZ2eja8Y4pnu2tJ9AI
         2c7PLkTAsfGbWhx+dcu3CfY3hY9CzY1WOSiYDDr4j+oabr4p0Iix+8UDac+3uQbdt3x6
         UUz61eJNvbrdlu3VGUsLanIgHsPZ7e2LtnjEaj4Fwkm+jgSUhitppzenPRo1ILLTnZGu
         fsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727183352; x=1727788152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJWMpEzQ7j+WlghGgTWAZxs7uwmf/XwviKdrEoOoPNs=;
        b=R/O6YHObR2EA/MEOOXkdGY4hweQkbEAwJttzRedFH3yvMBYsQGA8pkOPNnxkgLKJQX
         9SCVMorG8aIHqWEfdPrHshuUd9up2qhtKWcYE/pkx2w9GJpnKCg5x6pKz0zTWge28Wmb
         iOdMcEGdcjnedt/VVd0XEqn5ROWuZSKUQH6y/InKgtNTZrBgEI3HQQkdSeLZBSq0O9wf
         q0V+iVdCd4XOBRb2LgWiyjlJwPYLyjvEzN8oxyeTQKgvqgtHuy6aB/0Do2tQqc0vFJLn
         IXZHs5zKpoTi7KI1pBlWNsAglqagYcQBeihD5/SJmiMX9qYyBgd2mKsPh2WAQKhGCL1Q
         HwKw==
X-Gm-Message-State: AOJu0YzLwHOExNtsDhjGFD7wuBs1HhkIzvGriIwCiiWVToZtoe9E622o
	P+Uo4LkJEuw65jQLqexb2PNypeeJE16/vmiPIaznh3a266WMjkA52ShiJMHC
X-Google-Smtp-Source: AGHT+IElKcQOQDR4viW3YT6MBs+AY+dDW+9Hu6nSKRHya5CUVwCLpsTkzCYQpMPkf2O4Jm9AGyKc/g==
X-Received: by 2002:a05:600c:1987:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-42e7ac2f2a5mr158417595e9.13.1727183351251;
        Tue, 24 Sep 2024 06:09:11 -0700 (PDT)
Received: from void.void ([141.226.8.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c5c92sm158728495e9.41.2024.09.24.06.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:09:11 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] builtin: fix typos
Date: Tue, 24 Sep 2024 16:09:06 +0300
Message-Id: <20240924130906.21392-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 builtin/help.c         | 2 +-
 builtin/ls-files.c     | 2 +-
 builtin/name-rev.c     | 2 +-
 builtin/receive-pack.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 9c4cfe11d9..a509241a80 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -542,7 +542,7 @@ static void open_html(const char *path)
 
 static void show_html_page(const char *page)
 {
-	struct strbuf page_path; /* it leaks but we exec bellow */
+	struct strbuf page_path; /* it leaks but we exec below */
 
 	get_html_page_path(&page_path, page);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6aaba08e30..e016b0415d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -507,7 +507,7 @@ static int get_common_prefix_len(const char *common_prefix)
 	common_prefix_len = strlen(common_prefix);
 
 	/*
-	 * If the prefix has a trailing slash, strip it so that submodules wont
+	 * If the prefix has a trailing slash, strip it so that submodules won't
 	 * be pruned from the index.
 	 */
 	if (common_prefix[common_prefix_len - 1] == '/')
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 7f08c38629..765eb20a93 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -65,7 +65,7 @@ static void set_commit_cutoff(struct commit *commit)
 static void adjust_cutoff_timestamp_for_slop(void)
 {
 	if (cutoff) {
-		/* check for undeflow */
+		/* check for underflow */
 		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
 			cutoff = cutoff - CUTOFF_DATE_SLOP;
 		else
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c4b766c613..5bbbebbd8b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1325,7 +1325,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 }
 
 /*
- * NEEDSWORK: we should consolidate various implementions of "are we
+ * NEEDSWORK: we should consolidate various implementations of "are we
  * on an unborn branch?" test into one, and make the unified one more
  * robust. !get_sha1() based check used here and elsewhere would not
  * allow us to tell an unborn branch from corrupt ref, for example.
-- 
2.39.5

