Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C18F20401
	for <e@80x24.org>; Thu, 22 Jun 2017 00:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdFVAkg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 20:40:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36619 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdFVAkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 20:40:35 -0400
Received: by mail-pf0-f180.google.com with SMTP id q86so866826pfl.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 17:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZusLP1A+keG87RxOlHuSpJt65Tw4DQQPwYDkY7v3JeU=;
        b=WiYfgZerYfMJOsTQvfO5zmYrNCoq5uuBG1rqrXAzizNnwtbSoWc4+JIVfrKbRjCWX2
         8hXrgcwry6ZDhzG7CUSgw3TIJ5MiaPDbX80YMZ6c2aQ/IyylmPDESUa4L5r5LImBrgxv
         LBn3EbJAJwsdfIlUrm6PFOqJYmyUIZfsGZA5hJ/arBFBHEpdB0VCBFZMrk75feObhggo
         pWdyc+0F0DXXDWnrVw4qat7c+NpdJwM1TNKQeYe2pPHDlL109KF4j/cGgF+7m7p3/1ed
         v6vsqpUfYNMS49Lk7kKmpjkaJXvX/O6i3XgoBh8SSu2I5thOz/S5DmcNoyOFEjITW5kN
         0wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZusLP1A+keG87RxOlHuSpJt65Tw4DQQPwYDkY7v3JeU=;
        b=hsCVZ6jdne0AIQSVnp83bLT/vBsS5SQAr8LINuhfJa+xxHmPtHggtA+fnCxw+32Zoi
         QSE8+tdlWxp/GVW7ze8cTPkkuG2D6Xe8+JgP2945eWRiCPvRh61wSINSwMW4Z75t1hUN
         mRoGBrDnXwuXdFYppSuDNAf6ThMIuYu49WhmexpUXDQwnvt3rGWobP3aHyHjK2Hxx18Q
         jt5KAIDhJC+g1VP59qwOdoLbk9hbxMgpkKkdgXe8eytuCErjEYeZmQrncNetGQItta3m
         ufaW7deNLfVSqM2LRofCNOMKKVuS0tdV1YmqzLEGNjflhbLwUh9djaikwlj7V+g5HtOY
         XINg==
X-Gm-Message-State: AKS2vOwlmBVuRvMvqzZWl0IcLVK1qG7UI3xCRMqf9iSjMb8pVeF9dMl4
        tfUI55zptVPqqGU5TKG4+Q==
X-Received: by 10.84.236.6 with SMTP id q6mr45998615plk.146.1498092033868;
        Wed, 21 Jun 2017 17:40:33 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c205sm34658213pfb.74.2017.06.21.17.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 17:40:31 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v5 2/8] sha1_file: rename LOOKUP_UNKNOWN_OBJECT
Date:   Wed, 21 Jun 2017 17:40:18 -0700
Message-Id: <87f05a9575974b091922b1bc234b177e862ea222.1498091579.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1498091579.git.jonathantanmy@google.com>
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1498091579.git.jonathantanmy@google.com>
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

OBJECT_INFO_ALLOW_UNKNOWN_TYPE is defined to 2, not 1, to avoid
conflicting with LOOKUP_REPLACE_OBJECT. Avoidance of this conflict is
necessary because sha1_object_info_extended() supports both flags.

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

