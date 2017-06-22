Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5461FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbdFVSoV (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:21 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36661 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753591AbdFVSoO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:14 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so11319140pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ofQZGTN9ko6JzrNZ8wqqW4oRyGTvDjuAiyh7zbSh/jM=;
        b=WSZg105vwQ46GA/9lr0wl2gT6BI+Vjcof/ApsAWKY3fd0sMh8S/4S33XBRXu+b3uPd
         kdgZhSRnkRURfamnfqt8PmkG7ybtpnb149JqMKIODGu2Dv5BZFZhJ3ohmlgFAu/c+g0L
         rsCpoLIQTKfZzRMfJSxqmiLq4Qe/AEBBYTNW9Gb270TtEL5oFg5MSWRA7LozTDLhVpvO
         L1bGBeCYIcjFn83xec4zYHhlAxaPmLqFW2HmWSa5yHNXQ0pZYQ6Yl1YyNke8UblRgfJH
         oNJaJfgASdqF2p1zVKpNKZZk07Oly8kdPxdFTXnpRylzl9HEVUpQ+I5y9RqBCqpayOc0
         Xucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ofQZGTN9ko6JzrNZ8wqqW4oRyGTvDjuAiyh7zbSh/jM=;
        b=Bh9iBsvOTXdfbl4PqtOwSQUOdL0RvNeqiRmw60+KYxPnC/PHv5TsFM7zYahPTX0vvz
         vjsPihz2cZxwdsSUW7cg6vwDeEq4D9PBWPqfrZD7NwQGZKp5kheML/iENIHXyELGoB+z
         Z556KNcvf2CpN1TCfNTkd/wzx4QT/tRMeDQT5TrWpksjBN+w1LJQgU1Fy/J/WBbXiezB
         0i46weK50crethKxbfNixqBsn8SXKxglok1A+UVAHRpg8NebYbHYSmb93MdQ5eTm+vM4
         XfoEygFQBJ0uCcOSxat6GsWLWW3i6lUeYjbyK4e0n3EEZihb0BQW1esKilWDRkSbFHmL
         5CpA==
X-Gm-Message-State: AKS2vOx4o0+BS2f2CY1NWmbS5CzQ1kMVbIXp/tRNcwVAaWaMZv2UlLN2
        lmPRPiiXCnOjmHPXrPoBVg==
X-Received: by 10.101.70.193 with SMTP id n1mr4037836pgr.249.1498157052924;
        Thu, 22 Jun 2017 11:44:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 07/20] path: create path.h
Date:   Thu, 22 Jun 2017 11:43:35 -0700
Message-Id: <20170622184348.56497-8-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all path related declarations from cache.h to a new path.h header
file.  This makes cache.h smaller and makes it easier to add new path
related functions.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h | 59 +----------------------------------------------------------
 path.c  |  1 +
 path.h  | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 58 deletions(-)
 create mode 100644 path.h

diff --git a/cache.h b/cache.h
index cd64cbc81..c958fc3ce 100644
--- a/cache.h
+++ b/cache.h
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
+#include "path.h"
 
 #ifndef platform_SHA_CTX
 /*
@@ -892,64 +893,6 @@ extern void check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/*
- * Return a statically allocated filename, either generically (mkpath), in
- * the repository directory (git_path), or in a submodule's repository
- * directory (git_path_submodule). In all cases, note that the result
- * may be overwritten by another call to _any_ of the functions. Consider
- * using the safer "dup" or "strbuf" formats below (in some cases, the
- * unsafe versions have already been removed).
- */
-extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_common_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-
-extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
-extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-extern void strbuf_git_common_path(struct strbuf *sb, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
-				     const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
-extern char *git_pathdup(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-extern char *mkpathdup(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-
-extern void report_linked_checkout_garbage(void);
-
-/*
- * You can define a static memoized git path like:
- *
- *    static GIT_PATH_FUNC(git_path_foo, "FOO");
- *
- * or use one of the global ones below.
- */
-#define GIT_PATH_FUNC(func, filename) \
-	const char *func(void) \
-	{ \
-		static char *ret; \
-		if (!ret) \
-			ret = git_pathdup(filename); \
-		return ret; \
-	}
-
-const char *git_path_cherry_pick_head(void);
-const char *git_path_revert_head(void);
-const char *git_path_squash_msg(void);
-const char *git_path_merge_msg(void);
-const char *git_path_merge_rr(void);
-const char *git_path_merge_mode(void);
-const char *git_path_merge_head(void);
-const char *git_path_fetch_head(void);
-const char *git_path_shallow(void);
-
 /*
  * Return the name of the file in the local object database that would
  * be used to store a loose object with the specified sha1.  The
diff --git a/path.c b/path.c
index e4abea083..41c861c96 100644
--- a/path.c
+++ b/path.c
@@ -8,6 +8,7 @@
 #include "dir.h"
 #include "worktree.h"
 #include "submodule-config.h"
+#include "path.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
diff --git a/path.h b/path.h
new file mode 100644
index 000000000..522cd029b
--- /dev/null
+++ b/path.h
@@ -0,0 +1,62 @@
+#ifndef PATH_H
+#define PATH_H
+
+/*
+ * Return a statically allocated filename, either generically (mkpath), in
+ * the repository directory (git_path), or in a submodule's repository
+ * directory (git_path_submodule). In all cases, note that the result
+ * may be overwritten by another call to _any_ of the functions. Consider
+ * using the safer "dup" or "strbuf" formats below (in some cases, the
+ * unsafe versions have already been removed).
+ */
+extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *git_common_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+
+extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern void strbuf_git_common_path(struct strbuf *sb, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
+				     const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+extern char *git_pathdup(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+extern char *mkpathdup(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
+extern void report_linked_checkout_garbage(void);
+
+/*
+ * You can define a static memoized git path like:
+ *
+ *    static GIT_PATH_FUNC(git_path_foo, "FOO");
+ *
+ * or use one of the global ones below.
+ */
+#define GIT_PATH_FUNC(func, filename) \
+	const char *func(void) \
+	{ \
+		static char *ret; \
+		if (!ret) \
+			ret = git_pathdup(filename); \
+		return ret; \
+	}
+
+const char *git_path_cherry_pick_head(void);
+const char *git_path_revert_head(void);
+const char *git_path_squash_msg(void);
+const char *git_path_merge_msg(void);
+const char *git_path_merge_rr(void);
+const char *git_path_merge_mode(void);
+const char *git_path_merge_head(void);
+const char *git_path_fetch_head(void);
+const char *git_path_shallow(void);
+
+#endif /* PATH_H */
-- 
2.13.1.704.gde00cce3c-goog

