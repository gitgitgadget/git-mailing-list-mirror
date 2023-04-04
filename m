Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD8C761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjDDBXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjDDBWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FC22D49
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y14so31163924wrq.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVa8TGY+H+t/NaKfh9R72LeG+5L0LeXEBerU/2UNCsk=;
        b=Vw1or3glWDlEKsX3Mj4yqKm5hCSX5iRXf6+/qMZlnOApMkh7U3558xpWstG/OzBSHN
         BK0BqzwfhhTXVf5EPNn4T+2fALz/xs9oZVD4To8f+GmcrUqGPTHLi8BgAt2rjF74A7Vc
         f+kpVk1klCUY20X6h/kCTe+RGcIHJ2gxJvI7se1FdZE8DiEv23jwlp1J6jKhlqCZDlJM
         ui7/mcIbPRzleoLN5IJWzNz+/LM03LhUsY3J2M0Lw6tMuOBjYnyg1hi6aibPDwgakmDP
         ovHk//HgreBpaTNeYbQ/Ie46WG7TW3QJs2qXRiTrZu99hNcL4DLvlQYyW6gJxpJwx+nx
         pDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVa8TGY+H+t/NaKfh9R72LeG+5L0LeXEBerU/2UNCsk=;
        b=35SPBcDC0HQHh67oLEbF2D1oYJR3v7GMgWU83myowpdnMnTDUQDitUfUaoky85mhXa
         nlIoaVw8p/Kv3kLbYShHeQUS5/qIBrNjTgAipVL0C8QjAWrpjp5I3F171LET5lGM1N1k
         g0e4z4CMSHdpVemhyncPmfVhdlOC69KLZuxYJGtZgVzEdK5WufvFXQyAUrc4J4OKJbEf
         sa33RnVrhttUdDg/FM+rCpT6I282GaeKF3UnFW9QyLbLBRYxsQMc04/AYR80A/54kFNC
         FyoPpx3Kt9VvzHnQrIb6LJafoyqRlChcH4Mhx0e0ds7jEpp7/sGXHL1gSdPrUnnjgmHm
         dEfw==
X-Gm-Message-State: AAQBX9cD6XlcLA4t2dG8hRWyizZncfbCWqQnVO9l/wp8c8mTF5auX7A+
        icE9g3sKOOhTNs34wmCSEMnTc6cGYKA=
X-Google-Smtp-Source: AKy350YA/EELgq2zzv7NMGgdgCrzCX0nvT9uAT3qEsqUiunHPoOqX54Hwwna1YE1pMrkeSj93xiCIg==
X-Received: by 2002:adf:ef4a:0:b0:2c7:ae57:5acc with SMTP id c10-20020adfef4a000000b002c7ae575accmr256756wrp.26.1680571361853;
        Mon, 03 Apr 2023 18:22:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020adfdc10000000b002e5ff05765esm10416275wri.73.2023.04.03.18.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:41 -0700 (PDT)
Message-Id: <54545bbb02cc1cc1f7148b5bb39ea16a8914ef61.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:14 +0000
Subject: [PATCH v2 10/24] git-zlib: move declarations for git-zlib functions
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Move functions from cache.h for zlib.c into a new header file.  Since
adding a "zlib.h" would cause issues with the real zlib, rename zlib.c
to git-zlib.c while we are at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile                 |  2 +-
 archive-tar.c            |  1 +
 archive-zip.c            |  1 +
 builtin/unpack-objects.c |  1 +
 cache.h                  | 25 +------------------------
 zlib.c => git-zlib.c     |  3 ++-
 git-zlib.h               | 28 ++++++++++++++++++++++++++++
 http-backend.c           |  1 +
 http.h                   |  3 +++
 9 files changed, 39 insertions(+), 26 deletions(-)
 rename zlib.c => git-zlib.c (99%)
 create mode 100644 git-zlib.h

diff --git a/Makefile b/Makefile
index 50ee51fde32..0c367881bff 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,6 +1036,7 @@ LIB_OBJS += fsmonitor.o
 LIB_OBJS += fsmonitor-ipc.o
 LIB_OBJS += fsmonitor-settings.o
 LIB_OBJS += gettext.o
+LIB_OBJS += git-zlib.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
@@ -1196,7 +1197,6 @@ LIB_OBJS += write-or-die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
-LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
diff --git a/archive-tar.c b/archive-tar.c
index 497dad0b3af..4cd81d8161e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -5,6 +5,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
diff --git a/archive-zip.c b/archive-zip.c
index e6f5c10a14f..ef538a90df4 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "archive.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f2c1323e661..ddbdb3dd226 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "object-store.h"
 #include "object.h"
diff --git a/cache.h b/cache.h
index 21db5da39a5..c06778b69cd 100644
--- a/cache.h
+++ b/cache.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
+#include "git-zlib.h"
 #include "hashmap.h"
 #include "list.h"
 #include "gettext.h"
@@ -14,30 +15,6 @@
 #include "repository.h"
 #include "statinfo.h"
 
-typedef struct git_zstream {
-	z_stream z;
-	unsigned long avail_in;
-	unsigned long avail_out;
-	unsigned long total_in;
-	unsigned long total_out;
-	unsigned char *next_in;
-	unsigned char *next_out;
-} git_zstream;
-
-void git_inflate_init(git_zstream *);
-void git_inflate_init_gzip_only(git_zstream *);
-void git_inflate_end(git_zstream *);
-int git_inflate(git_zstream *, int flush);
-
-void git_deflate_init(git_zstream *, int level);
-void git_deflate_init_gzip(git_zstream *, int level);
-void git_deflate_init_raw(git_zstream *, int level);
-void git_deflate_end(git_zstream *);
-int git_deflate_abort(git_zstream *);
-int git_deflate_end_gently(git_zstream *);
-int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
-
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
 #else
diff --git a/zlib.c b/git-zlib.c
similarity index 99%
rename from zlib.c
rename to git-zlib.c
index d594cba3fc9..d43bbeb6daa 100644
--- a/zlib.c
+++ b/git-zlib.c
@@ -2,7 +2,8 @@
  * zlib wrappers to make sure we don't silently miss errors
  * at init time.
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "git-zlib.h"
 
 static const char *zerr_to_string(int status)
 {
diff --git a/git-zlib.h b/git-zlib.h
new file mode 100644
index 00000000000..d8a670aff9f
--- /dev/null
+++ b/git-zlib.h
@@ -0,0 +1,28 @@
+#ifndef GIT_ZLIB_H
+#define GIT_ZLIB_H
+
+typedef struct git_zstream {
+	z_stream z;
+	unsigned long avail_in;
+	unsigned long avail_out;
+	unsigned long total_in;
+	unsigned long total_out;
+	unsigned char *next_in;
+	unsigned char *next_out;
+} git_zstream;
+
+void git_inflate_init(git_zstream *);
+void git_inflate_init_gzip_only(git_zstream *);
+void git_inflate_end(git_zstream *);
+int git_inflate(git_zstream *, int flush);
+
+void git_deflate_init(git_zstream *, int level);
+void git_deflate_init_gzip(git_zstream *, int level);
+void git_deflate_init_raw(git_zstream *, int level);
+void git_deflate_end(git_zstream *);
+int git_deflate_abort(git_zstream *);
+int git_deflate_end_gently(git_zstream *);
+int git_deflate(git_zstream *, int flush);
+unsigned long git_deflate_bound(git_zstream *, unsigned long);
+
+#endif /* GIT_ZLIB_H */
diff --git a/http-backend.c b/http-backend.c
index 89aad1b42c7..d41b3b9e1e7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/http.h b/http.h
index 77c042706c6..783b2b09b8b 100644
--- a/http.h
+++ b/http.h
@@ -1,7 +1,10 @@
 #ifndef HTTP_H
 #define HTTP_H
 
+struct packed_git;
+
 #include "cache.h"
+#include "git-zlib.h"
 
 #include <curl/curl.h>
 #include <curl/easy.h>
-- 
gitgitgadget

