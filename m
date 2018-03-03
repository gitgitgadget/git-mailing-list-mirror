Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9B2A1F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeCCLhW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:22 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36616 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLhV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:21 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so5139286pfx.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qw2H8n4gDKcZk/5EJGSAZ3eCeJVEZge+ol33oRAHFP8=;
        b=JFyu669FhHMYwlov0YCJNj605tn29dYvjn4H1xx3ri6Q/X1cghAYY2bAgOgqx5CCYY
         MQK2OjXwNSX56N/GwnCk3+M/HAFR3Iuhv+t8TNOSe2ZXFBbhUFjUMwk3WsWLK4yjCYMW
         DacZVWf5mAEW2dAwqH5FXPANqaM8SXk1zXXHNCyua6zq89H7212S2FM1ETydzRwcW8zU
         82cZjPEPSwM2d22B5lpoqIthXIGpI5gzp+YszBfy2RYXihSxaZrDDdhA6W5hDSnWEQl+
         G7y3ptC0Dtjl0eUorY1r2S4nxuTSSlZztvsePOVnM0ayXU1CYe6oD/y6md3X2wyjm07K
         gKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qw2H8n4gDKcZk/5EJGSAZ3eCeJVEZge+ol33oRAHFP8=;
        b=gRXw1+YmNlxX1QCTsseEkiIl9Ld8Yuh/THfjj77W405xQwUe7cwJxtGxo9iPmBxrZy
         xzb/dv5BnTrsoxvFC68jkKR8XYXEV/Cl34wnP1HA2UIOLZQqX/poCxmuepnQlOMDqGQy
         yqdN7PP5PAqsEC10n8aEh3K+jnza1ki+IKhHM2fI9zSTFuRWmZx+HrL+FS09hc+03o9X
         BaeIuFfJqDBPIosxAsf+Vdn1RwFnxefyDY0rIqqBBTcqfqUfNnDd4ISvup0HvoIlZoSL
         NYXUk1mOOEYZOLpEbMhEet9wG9Bd7DDd0TxfJDj01Xu6815e6mSPPwyUvrFELAvg+NG1
         D7ng==
X-Gm-Message-State: APf1xPBCjQ/AL50zZ/BGsE3JyS9X7m0hhTWrndV94JzKfcPbVwLh7OTl
        qSpFU+/a98z8GPBpejytp6ZcQg==
X-Google-Smtp-Source: AG47ELt0ncq+OlCjdNgxSPreueMtMh1SeF/0punC6RS1MnoNYNfjwvvM4Vkjt+RZFE4sjF+JqmNVDg==
X-Received: by 10.99.63.139 with SMTP id m133mr6998898pga.174.1520077040171;
        Sat, 03 Mar 2018 03:37:20 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e23sm16601775pfi.76.2018.03.03.03.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/44] object-store: migrate alternates struct and functions from cache.h
Date:   Sat,  3 Mar 2018 18:36:00 +0700
Message-Id: <20180303113637.26518-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Migrate the struct alternate_object_database and all its related
functions to the object store as these functions are easier found in
that header. The migration is just a verbatim copy, no need to
include the object store header at any C file, because cache.h includes
repository.h which in turn includes the object-store.h

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h        | 51 --------------------------------------------------
 object-store.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/cache.h b/cache.h
index 41ba67cc16..41530d5d16 100644
--- a/cache.h
+++ b/cache.h
@@ -1576,57 +1576,6 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
-extern struct alternate_object_database {
-	struct alternate_object_database *next;
-
-	/* see alt_scratch_buf() */
-	struct strbuf scratch;
-	size_t base_len;
-
-	/*
-	 * Used to store the results of readdir(3) calls when searching
-	 * for unique abbreviated hashes.  This cache is never
-	 * invalidated, thus it's racy and not necessarily accurate.
-	 * That's fine for its purpose; don't use it for tasks requiring
-	 * greater accuracy!
-	 */
-	char loose_objects_subdir_seen[256];
-	struct oid_array loose_objects_cache;
-
-	char path[FLEX_ARRAY];
-} *alt_odb_list;
-extern void prepare_alt_odb(void);
-extern char *compute_alternate_path(const char *path, struct strbuf *err);
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
-extern int foreach_alt_odb(alt_odb_fn, void*);
-
-/*
- * Allocate a "struct alternate_object_database" but do _not_ actually
- * add it to the list of alternates.
- */
-struct alternate_object_database *alloc_alt_odb(const char *dir);
-
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-extern void add_to_alternates_file(const char *dir);
-
-/*
- * Add the directory to the in-memory list of alternates (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-extern void add_to_alternates_memory(const char *dir);
-
-/*
- * Returns a scratch strbuf pre-filled with the alternate object directory,
- * including a trailing slash, which can be used to access paths in the
- * alternate. Always use this over direct access to alt->scratch, as it
- * cleans up any previous use of the scratch buffer.
- */
-extern struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
-
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/object-store.h b/object-store.h
index 69bb5ac065..505f123976 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,6 +1,57 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
+extern struct alternate_object_database {
+	struct alternate_object_database *next;
+
+	/* see alt_scratch_buf() */
+	struct strbuf scratch;
+	size_t base_len;
+
+	/*
+	 * Used to store the results of readdir(3) calls when searching
+	 * for unique abbreviated hashes.  This cache is never
+	 * invalidated, thus it's racy and not necessarily accurate.
+	 * That's fine for its purpose; don't use it for tasks requiring
+	 * greater accuracy!
+	 */
+	char loose_objects_subdir_seen[256];
+	struct oid_array loose_objects_cache;
+
+	char path[FLEX_ARRAY];
+} *alt_odb_list;
+void prepare_alt_odb(void);
+char *compute_alternate_path(const char *path, struct strbuf *err);
+typedef int alt_odb_fn(struct alternate_object_database *, void *);
+int foreach_alt_odb(alt_odb_fn, void*);
+
+/*
+ * Allocate a "struct alternate_object_database" but do _not_ actually
+ * add it to the list of alternates.
+ */
+struct alternate_object_database *alloc_alt_odb(const char *dir);
+
+/*
+ * Add the directory to the on-disk alternates file; the new entry will also
+ * take effect in the current process.
+ */
+void add_to_alternates_file(const char *dir);
+
+/*
+ * Add the directory to the in-memory list of alternates (along with any
+ * recursive alternates it points to), but do not modify the on-disk alternates
+ * file.
+ */
+void add_to_alternates_memory(const char *dir);
+
+/*
+ * Returns a scratch strbuf pre-filled with the alternate object directory,
+ * including a trailing slash, which can be used to access paths in the
+ * alternate. Always use this over direct access to alt->scratch, as it
+ * cleans up any previous use of the scratch buffer.
+ */
+struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
+
 struct raw_object_store {
 	/*
 	 * Path to the repository's object store.
-- 
2.16.1.435.g8f24da2e1a

