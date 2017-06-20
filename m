Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217021FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbdFTBD3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:29 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35779 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdFTBD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:27 -0400
Received: by mail-pg0-f51.google.com with SMTP id 132so21906381pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=64bREs7Un6Ntl9LY43TrDijJGaEeY6D1zMXEqfCJpvg=;
        b=FvsjNjurZmc67k3gqNYc1cChyDLbc4sDf0iEcgDwXGp5hHf5OkGalk+E9L8NpquWp5
         L4hSIoXIh4o0RNWr7vtMZfigIJKBq04u2gRdVs3aIvCsZeZdLfVMu9ETGcRwCXxnsFdA
         1ZQ4QRGxEdvoZyL5yK6ZW5uaMaFaI+JZ8uZHWGsNe49/k9Fb0StZtg8o06S1MOW7KrWN
         AEVvdKRulLXWjYT44OOGle8+4LfiuLeAHkbMc5zcGg3bIfynYqNfDhgYoHIDjcaevmoG
         whmMKE2TYLrkkjW4z2w3HLCJFSI6V+fpYtNpRxXN3K9GZoRmv21CL39rjxtvTk77WpQF
         ndhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=64bREs7Un6Ntl9LY43TrDijJGaEeY6D1zMXEqfCJpvg=;
        b=m6Tluf+1XFEvpsUPf0BzVnBSdMbIwTNNaS1w8iT8Er6Mlzc64I8N6Rq2gWpCXXYptD
         AGixfac+aAgNNmT5oQRNIvmpC+SakcMJAVmkWPEuhKdOmxCfEfAawJ/+GXErpVAX/NYL
         JiFWn+MHVlGOrWG1Y1kOmyu06Aaxfxwvfgfo6DOvOdpEeJWBOZnEHE7+ceKiiSO+PgCs
         K3Kt1ag3xQ4QmgLtl36c6BDU7rL1M+XJC0L9+HbGqJnJhwypxAfMtNO5k2USxhNTWxb3
         m06y5LmwdIVv741+28xqAdv3LgxWfhcnWiREZBdwRPL9gJcWdPSQu7kHKMuk9ag6BDXd
         //Tw==
X-Gm-Message-State: AKS2vOwhjzBp6GWqfh2H83JKDWRDyui77FgH4eZZ1b+LjJ+Tk0KaAt/y
        T038UWVAPtUHDrxWWkNSFw==
X-Received: by 10.84.209.236 with SMTP id y99mr32866714plh.198.1497920606117;
        Mon, 19 Jun 2017 18:03:26 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:24 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 3/8] sha1_file: rename LOOKUP_REPLACE_OBJECT
Date:   Mon, 19 Jun 2017 18:03:10 -0700
Message-Id: <6f6e8237db12ec2cd8fb4c8e2951bfc867a656a2.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The LOOKUP_REPLACE_OBJECT flag controls whether the
lookup_replace_object() function is invoked by
sha1_object_info_extended(), read_sha1_file_extended(), and
lookup_replace_object_extended(), but it is not immediately clear which
functions accept that flag.

Therefore restrict this flag to only sha1_object_info_extended(),
renaming it appropriately to OBJECT_INFO_LOOKUP_REPLACE and adding some
documentation. Update read_sha1_file_extended() to have a boolean
parameter instead, and delete lookup_replace_object_extended().

parse_sha1_header() also passes this flag to
parse_sha1_header_extended() since commit 46f0344 ("sha1_file: support
reading from a loose object of unknown type", 2015-05-03), but that has
had no effect since that commit. Therefore this patch also removes this
flag from that invocation.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/cat-file.c |  5 +++--
 cache.h            | 17 ++++++-----------
 sha1_file.c        | 13 ++++++++-----
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 209374b3c..923786c00 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -56,7 +56,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_context obj_context;
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	unsigned flags = LOOKUP_REPLACE_OBJECT;
+	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
 	const char *path = force_path;
 
 	if (unknown_type)
@@ -337,7 +337,8 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->skip_object_info &&
-	    sha1_object_info_extended(data->oid.hash, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
+	    sha1_object_info_extended(data->oid.hash, &data->info,
+				      OBJECT_INFO_LOOKUP_REPLACE)) {
 		printf("%s missing\n",
 		       obj_name ? obj_name : oid_to_hex(&data->oid));
 		fflush(stdout);
diff --git a/cache.h b/cache.h
index e2ec45dfe..a3631b237 100644
--- a/cache.h
+++ b/cache.h
@@ -1205,12 +1205,12 @@ extern char *xdg_config_home(const char *filename);
  */
 extern char *xdg_cache_home(const char *filename);
 
-/* object replacement */
-#define LOOKUP_REPLACE_OBJECT 1
-extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
+extern void *read_sha1_file_extended(const unsigned char *sha1,
+				     enum object_type *type,
+				     unsigned long *size, int lookup_replace);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
-	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
+	return read_sha1_file_extended(sha1, type, size, 1);
 }
 
 /*
@@ -1232,13 +1232,6 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 	return do_lookup_replace_object(sha1);
 }
 
-static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
-{
-	if (!(flag & LOOKUP_REPLACE_OBJECT))
-		return sha1;
-	return lookup_replace_object(sha1);
-}
-
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
@@ -1865,6 +1858,8 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT {NULL}
 
+/* Invoke lookup_replace_object() on the given hash */
+#define OBJECT_INFO_LOOKUP_REPLACE 1
 /* Allow reading from a loose object file of unknown/bogus type */
 #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
diff --git a/sha1_file.c b/sha1_file.c
index ad04ea8e0..ae44b32f3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2002,7 +2002,7 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.sizep = sizep;
-	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
+	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
 static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
@@ -2969,7 +2969,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
-	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
+	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
+				    lookup_replace_object(sha1) :
+				    sha1;
 
 	co = find_cached_object(real);
 	if (co) {
@@ -3025,7 +3027,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (sha1_object_info_extended(sha1, &oi, LOOKUP_REPLACE_OBJECT) < 0)
+	if (sha1_object_info_extended(sha1, &oi, OBJECT_INFO_LOOKUP_REPLACE))
 		return -1;
 	return type;
 }
@@ -3107,13 +3109,14 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 void *read_sha1_file_extended(const unsigned char *sha1,
 			      enum object_type *type,
 			      unsigned long *size,
-			      unsigned flag)
+			      int lookup_replace)
 {
 	void *data;
 	const struct packed_git *p;
 	const char *path;
 	struct stat st;
-	const unsigned char *repl = lookup_replace_object_extended(sha1, flag);
+	const unsigned char *repl = lookup_replace ? lookup_replace_object(sha1)
+						   : sha1;
 
 	errno = 0;
 	data = read_object(repl, type, size);
-- 
2.13.1.611.g7e3b11ae1-goog

