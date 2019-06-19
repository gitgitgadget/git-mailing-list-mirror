Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F7B1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfFSJ71 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39538 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbfFSJ7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so9377578pgc.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HoroAp5zJ/0rEl8i1rbsApCagkWrjHIBXfNIneeXe8c=;
        b=Ooo6APnO4ox9icuuG+pou+H6bW8hWHEOhQ8oZZyToYF9IzL7S4XoUGElN2Nzhyc0mx
         99tvjkDFEDLpGRNuIDPdrMIyFAi5o4JoSZZogYiDCAPp0pQs8cCZo/YxbjRfb/cU9GIi
         yDIkvFsNCKvuMR3KWyb8t475+41W0gA1GG9+dkzjc9CxKUWxGhl8eGOyRUeW0X3fZE/+
         e4kFtDwu+c0nZMdwHdobY93C6urZw/bdsqsTY3aSypxV94i8aeGGim8VyEzrNgdQlght
         GduI8o02WHqVOdMsVRzcEujaetxj+Hz5L4C1SqIDWOm1lOx7Tb8sZ44SfU/6B9ZKchzF
         IDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HoroAp5zJ/0rEl8i1rbsApCagkWrjHIBXfNIneeXe8c=;
        b=R/VS9YQcnaTGPYuWexLxsT/9T3IuBrJTCgxPPikmzJPTmp34vK9qn1kggo15gDLcCQ
         hfjX+RdIEULcJ6M4vbH5SRPWIMVXk86jtGVZPh2HqAr2UxeUb26WuhjL6fq79WMhjXW+
         nym5SARSUqnpCEf6gaLPfuVYPg0ab4RgGAEE4KTAn5YQI5jF6cndr5v3FqNoQAwzdN8r
         eJx5XtZ5HpLWSaMbhpKYL8famu9BRjrqH88fN9mnRQ5xyhUD97PSxjT6f6D5Efi5RP97
         q6J7/rc8XrR/cL3xyzCs4CUabapW17SqTbUvEhdMtZyLeGRdGFoIkYdaaMX8B/sIXgPE
         KnXQ==
X-Gm-Message-State: APjAAAX14ZpUoOanzQVtgLKmM4gbrl/8H9zOD5RF6H7jjdAlrZAPLhC9
        sxDwvMoslgbj1OEUKflyeAeGoM3I
X-Google-Smtp-Source: APXvYqw9l9pSz017OaQQeaCQUspUQt5eo/pY0m45/oGdYntOOb38dMa/ulvcbhhgRIh+gTqlRlqHVw==
X-Received: by 2002:aa7:8d4d:: with SMTP id s13mr9855347pfe.259.1560938363812;
        Wed, 19 Jun 2019 02:59:23 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id w132sm17717751pfd.78.2019.06.19.02.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/8] resolve-undo.c: dump "REUC" extension as json
Date:   Wed, 19 Jun 2019 16:58:54 +0700
Message-Id: <20190619095858.30124-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c   |  2 +-
 resolve-undo.c | 36 +++++++++++++++++++++++++++++++++++-
 resolve-undo.h |  4 +++-
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index eec030b3bb..3b5c63f53a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1701,7 +1701,7 @@ static int read_index_extension(struct index_state *istate,
 		istate->cache_tree = cache_tree_read(data, sz);
 		break;
 	case CACHE_EXT_RESOLVE_UNDO:
-		istate->resolve_undo = resolve_undo_read(data, sz);
+		istate->resolve_undo = resolve_undo_read(data, sz, istate->jw);
 		break;
 	case CACHE_EXT_LINK:
 		if (read_link_extension(istate, data, sz))
diff --git a/resolve-undo.c b/resolve-undo.c
index 236320f179..999020bc40 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "json-writer.h"
 #include "resolve-undo.h"
 #include "string-list.h"
 
@@ -49,7 +50,8 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
 	}
 }
 
-struct string_list *resolve_undo_read(const char *data, unsigned long size)
+struct string_list *resolve_undo_read(const char *data, unsigned long size,
+				      struct json_writer *jw)
 {
 	struct string_list *resolve_undo;
 	size_t len;
@@ -59,6 +61,11 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 
 	resolve_undo = xcalloc(1, sizeof(*resolve_undo));
 	resolve_undo->strdup_strings = 1;
+	if (jw) {
+		jw_object_inline_begin_object(jw, "resolve-undo");
+		jw_object_intmax(jw, "ext-size", size);
+		jw_object_inline_begin_array(jw, "entries");
+	}
 
 	while (size) {
 		struct string_list_item *lost;
@@ -94,6 +101,33 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 			size -= rawsz;
 			data += rawsz;
 		}
+
+		if (jw) {
+			struct strbuf sb = STRBUF_INIT;
+
+			jw_array_inline_begin_object(jw);
+			jw_object_string(jw, "path", lost->string);
+
+			jw_object_inline_begin_array(jw, "mode");
+			for (i = 0; i < 3; i++) {
+				strbuf_addf(&sb, "%06o", ui->mode[i]);
+				jw_array_string(jw, sb.buf);
+				strbuf_reset(&sb);
+			}
+			jw_end(jw);
+
+			jw_object_inline_begin_array(jw, "oid");
+			for (i = 0; i < 3; i++)
+				jw_array_string(jw, oid_to_hex(&ui->oid[i]));
+			jw_end(jw);
+
+			jw_end(jw);
+			strbuf_release(&sb);
+		}
+	}
+	if (jw) {
+		jw_end(jw);	/* entries */
+		jw_end(jw);	/* resolve-undo */
 	}
 	return resolve_undo;
 
diff --git a/resolve-undo.h b/resolve-undo.h
index 2b3f0f901e..46b4e93a7e 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -3,6 +3,8 @@
 
 #include "cache.h"
 
+struct json_writer;
+
 struct resolve_undo_info {
 	unsigned int mode[3];
 	struct object_id oid[3];
@@ -10,7 +12,7 @@ struct resolve_undo_info {
 
 void record_resolve_undo(struct index_state *, struct cache_entry *);
 void resolve_undo_write(struct strbuf *, struct string_list *);
-struct string_list *resolve_undo_read(const char *, unsigned long);
+struct string_list *resolve_undo_read(const char *, unsigned long, struct json_writer *);
 void resolve_undo_clear_index(struct index_state *);
 int unmerge_index_entry_at(struct index_state *, int);
 void unmerge_index(struct index_state *, const struct pathspec *);
-- 
2.22.0.rc0.322.g2b0371e29a

