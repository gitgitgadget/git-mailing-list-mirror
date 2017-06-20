Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7958E1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbdFTBD1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:27 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33251 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbdFTBDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:25 -0400
Received: by mail-pf0-f170.google.com with SMTP id 83so61667501pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9zcqkfFB8U+2wTfzQj+JjVYPWh8PYQLklxr459DHjh0=;
        b=J18a0Gnst6/PDiOP/WCDAX9Jtfh5noUYbcPQskgVcg3OGl3yckVw/T8bo0S2zI2/2O
         7tj4zRKgsx+EnjIdpOr8LszMmwgwgpsfp6Lzkqssf2H4QtUsrSwnMF4M/pixgA1VVXBv
         0k7MhuxgMj4N1Hb1/DU5NthTthK1sAlt0UoUaDogMFMN//xow7XriqiHlr3M8uVUfTBh
         OCZ+oWYmh2gYV6iP0Wf70evh88kA4BH/RjrXh7F7x1AR4IsbmgpYDLGSRuAh2mLC07pR
         XSp5UlIjQcWNt/SnRlWbnhyRc2zQYxpq59y2IO3lHruRhbhgGzuSoWWQJPxOPCIbgUuQ
         8E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9zcqkfFB8U+2wTfzQj+JjVYPWh8PYQLklxr459DHjh0=;
        b=fF6xo6PuBx7KAtwYYx6sUYSljKC0gvmkSZZguqzgSZmG6eOM8UA8wx4RGpEmBVq023
         G+aWbcrCMYeIZBvyAAeV3wcHyMIuT/faIEHJ+khy12E8xfU3O8waZLkoJydtMlXQBtle
         6bPd07h4WPxpC67E8ruRtVj61RvqMg3/RBcCv6Ubka6TmtPESSqQkTI6L1B17N4WeQy2
         UVf8shQKEc3LoCOB1rxE7dwoDIOGZWVCMttGx6C3nefPaOpWg1kOC4SP3u/i9r2qK2xl
         HovOgGH0ROWD4xgWBo6E7SyTM7AVpt10vQGiozbGbKpm1vWI3VBqyP2ZdStjQyzRaZwN
         iluA==
X-Gm-Message-State: AKS2vOxAHNGahrAcOjCULgqH9nlft39M5RLIu2nJNib94tGd8QhQ+ofj
        9JgNhvflUIyEmWKCn8zoDg==
X-Received: by 10.84.131.78 with SMTP id 72mr4919574pld.43.1497920604384;
        Mon, 19 Jun 2017 18:03:24 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:22 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 2/8] sha1_file: rename LOOKUP_UNKNOWN_OBJECT
Date:   Mon, 19 Jun 2017 18:03:09 -0700
Message-Id: <93c459ee90fac0d040d262bef072188b7ea69af0.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The LOOKUP_UNKNOWN_OBJECT flag was introduced in commit 46f0344
("sha1_file: support reading from a loose object of unknown type",
2015-05-03) in order to support a feature in cat-file subsequently
introduced in commit 39e4ae3 ("cat-file: teach cat-file a
'--allow-unknown-type' option", 2015-05-03). Despite its name and
location in cache.h, this flag is used neither in
read_sha1_file_extended() nor in any of the lookup functions, but used
only in sha1_object_info_extended().

Therefore rename this flag to OBJECT_INFO_ALLOW_UNKNOWN_TYPE, taking the
name of the cat-file flag that invokes this feature, and move it closer
to the declaration of sha1_object_info_extended(). Also add
documentation for this flag.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/cat-file.c | 2 +-
 cache.h            | 3 ++-
 sha1_file.c        | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4bffd7a2d..209374b3c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -60,7 +60,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	const char *path = force_path;
 
 	if (unknown_type)
-		flags |= LOOKUP_UNKNOWN_OBJECT;
+		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (get_sha1_with_context(obj_name, GET_SHA1_RECORD_PATH,
 				  oid.hash, &obj_context))
diff --git a/cache.h b/cache.h
index 4d92aae0e..e2ec45dfe 100644
--- a/cache.h
+++ b/cache.h
@@ -1207,7 +1207,6 @@ extern char *xdg_cache_home(const char *filename);
 
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
-#define LOOKUP_UNKNOWN_OBJECT 2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1866,6 +1865,8 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT {NULL}
 
+/* Allow reading from a loose object file of unknown/bogus type */
+#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
diff --git a/sha1_file.c b/sha1_file.c
index a52b27541..ad04ea8e0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1964,7 +1964,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	 * we're obtaining the type using '--allow-unknown-type'
 	 * option.
 	 */
-	if ((flags & LOOKUP_UNKNOWN_OBJECT) && (type < 0))
+	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
 		type = 0;
 	else if (type < 0)
 		die("invalid object type");
@@ -2941,7 +2941,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return -1;
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
-	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
+	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
 		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
 			status = error("unable to unpack %s header with --allow-unknown-type",
 				       sha1_to_hex(sha1));
-- 
2.13.1.611.g7e3b11ae1-goog

