Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ED6C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjBWIFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjBWIFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82B64344D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i11so3745414wrp.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHKMijW1eUPMPRyg2Q0Jq29ImqY0YEZawbk+GyMBAH4=;
        b=LUFSGsUH4LZSAfKPs5u/0hoJ0DjlczR9hgp9AJjGl3PQE3A0yVuwa2UAaU1wOqXoH0
         2fcVRgY8LqxntYJAjiD0KsW/zI0D/lgX5oxT4i6nesrSzl9Ryb4vJItfzD2MLBY9pWbY
         YMrLXlSRJ8wdX7Rb8byS/xsRKui5sSQnZgaVkaAkVbzXhJUBTiNucd6ZQCvIzZmYYKZG
         27f6euQvVpcHi8N9Krj8txS7XD8hFPsMaHHfzg4CPGNnYcbXTTg6F24ngPR44uuqDDnM
         vuE91OgnaRJmT0An4BWZgKMlUJOMgbr13g4923f8SkAft4wS3VPKMOT/zyiTjioZfIlM
         vb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHKMijW1eUPMPRyg2Q0Jq29ImqY0YEZawbk+GyMBAH4=;
        b=e/4fO09AlYu3GBApgDwrjAD6lX2UK0fxy1jGYl24fs4POYpBq8SNvyG2mE4+VR/caU
         +CCB1sgA0c64g39bz6ySbaTV8aFr09O1FnkJh0QuJxeed+eOncuht4pftspusUOWeTjQ
         CY6OAQhVyYOrs6K1z3p0UA5xsAkwdSsVsvNk0efhYM8Pbx2+6o6qjDaqQu9bRFk1uU/5
         yFxdzNzHJNF1Jk8a/dnVsuvQpVUuezERg+wXm5uRtZuP5p7IQ403tXH/sUG4Vhit5svO
         hP0hJYCm8sJvA29KUrle6K0V3PgcTPbmiWvYptOrgZuiHZKynk7VOHXNEJr++jQTLNHC
         TxqA==
X-Gm-Message-State: AO0yUKWIfqgxoFpVAskKBBoV0vhZE/APHg9INBmplLTU0aNS18TyrMAZ
        fNZrQrmhKevLvEvghlZ8BCj2UqTKRsg=
X-Google-Smtp-Source: AK7set/16vn7dL0o5KTwRNfIsnjNnWv4swVvRJ7llXQrIf/cYDyYtA2V8julLxtud1iE2aa0h5TIUA==
X-Received: by 2002:a5d:5912:0:b0:2c5:58aa:35cb with SMTP id v18-20020a5d5912000000b002c558aa35cbmr10054344wrd.47.1677139528161;
        Thu, 23 Feb 2023 00:05:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b002be099f78c0sm9762597wrv.69.2023.02.23.00.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:27 -0800 (PST)
Message-Id: <9f78f0f215595d55ead4d82d20e1d0c9892171ec.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:11 +0000
Subject: [PATCH 06/16] hash.h: move some oid-related declarations from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

These defines and enum are all oid-related and as such seem to make
more sense being included in hash.h.  Further, moving them there
allows us to remove some includes of cache.h in other files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h                                      | 34 --------------------
 diffcore.h                                   |  4 ++-
 hash.h                                       | 34 ++++++++++++++++++++
 line-log.h                                   |  1 +
 submodule-config.h                           |  1 -
 t/helper/test-submodule-nested-repo-config.c |  1 +
 tree-walk.h                                  |  4 ++-
 7 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/cache.h b/cache.h
index 0f1f9dde56b..daf6150bb3c 100644
--- a/cache.h
+++ b/cache.h
@@ -1363,40 +1363,6 @@ struct object_context {
 	char *path;
 };
 
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
-
-#define GET_OID_DISAMBIGUATORS \
-	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
-	GET_OID_TREE | GET_OID_TREEISH | \
-	GET_OID_BLOB)
-
-enum get_oid_result {
-	FOUND = 0,
-	MISSING_OBJECT = -1, /* The requested object is missing */
-	SHORT_NAME_AMBIGUOUS = -2,
-	/* The following only apply when symlinks are followed */
-	DANGLING_SYMLINK = -4, /*
-				* The initial symlink is there, but
-				* (transitively) points to a missing
-				* in-tree file
-				*/
-	SYMLINK_LOOP = -5,
-	NOT_DIR = -6, /*
-		       * Somewhere along the symlink chain, a path is
-		       * requested which contains a file as a
-		       * non-final element.
-		       */
-};
-
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);
diff --git a/diffcore.h b/diffcore.h
index 9b588a1ee15..1701ed50b9c 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,9 +4,11 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct diff_options;
+struct mem_pool;
+struct oid_array;
 struct repository;
 struct strintmap;
 struct strmap;
diff --git a/hash.h b/hash.h
index 351afc2ce3b..d39f73618cb 100644
--- a/hash.h
+++ b/hash.h
@@ -123,6 +123,40 @@ struct object_id {
 	int algo;	/* XXX requires 4-byte alignment */
 };
 
+#define GET_OID_QUIETLY           01
+#define GET_OID_COMMIT            02
+#define GET_OID_COMMITTISH        04
+#define GET_OID_TREE             010
+#define GET_OID_TREEISH          020
+#define GET_OID_BLOB             040
+#define GET_OID_FOLLOW_SYMLINKS 0100
+#define GET_OID_RECORD_PATH     0200
+#define GET_OID_ONLY_TO_DIE    04000
+#define GET_OID_REQUIRE_PATH  010000
+
+#define GET_OID_DISAMBIGUATORS \
+	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
+	GET_OID_TREE | GET_OID_TREEISH | \
+	GET_OID_BLOB)
+
+enum get_oid_result {
+	FOUND = 0,
+	MISSING_OBJECT = -1, /* The requested object is missing */
+	SHORT_NAME_AMBIGUOUS = -2,
+	/* The following only apply when symlinks are followed */
+	DANGLING_SYMLINK = -4, /*
+				* The initial symlink is there, but
+				* (transitively) points to a missing
+				* in-tree file
+				*/
+	SYMLINK_LOOP = -5,
+	NOT_DIR = -6, /*
+		       * Somewhere along the symlink chain, a path is
+		       * requested which contains a file as a
+		       * non-final element.
+		       */
+};
+
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
diff --git a/line-log.h b/line-log.h
index 82ae8d98a40..adff361b1bc 100644
--- a/line-log.h
+++ b/line-log.h
@@ -5,6 +5,7 @@
 
 struct rev_info;
 struct commit;
+struct string_list;
 
 /* A range [start,end].  Lines are numbered starting at 0, and the
  * ranges include start but exclude end. */
diff --git a/submodule-config.h b/submodule-config.h
index 28a8ca6bf46..c2045875bbb 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -1,7 +1,6 @@
 #ifndef SUBMODULE_CONFIG_CACHE_H
 #define SUBMODULE_CONFIG_CACHE_H
 
-#include "cache.h"
 #include "config.h"
 #include "hashmap.h"
 #include "submodule.h"
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index dc1c14bde37..a3848a8b668 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,4 +1,5 @@
 #include "test-tool.h"
+#include "cache.h"
 #include "submodule-config.h"
 
 static void die_usage(const char **argv, const char *msg)
diff --git a/tree-walk.h b/tree-walk.h
index 6305d531503..25fe27e3529 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,7 +1,9 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
-#include "cache.h"
+#include "hash.h"
+
+struct index_state;
 
 #define MAX_TRAVERSE_TREES 8
 
-- 
gitgitgadget

