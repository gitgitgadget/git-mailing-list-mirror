Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E893A1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeCWRWJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35734 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeCWRV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:59 -0400
Received: by mail-lf0-f68.google.com with SMTP id t132-v6so19393812lfe.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMX4ltxMnrzuUcItxcrzty4g8h+ES70tKWqrRNz68jo=;
        b=YBFE+5bNB41ECrCcUW8Vm6czUPToqkojDVWQvtXVMZ7Z/wznc16Thk5mKVKI2RCKpR
         fGdLaPNImXnQTx1psr/jmukOqDk+FpSNarT2mcdtFj/ktifYjo6rJG2XMYnpBblsNNFR
         2PdQxb3aquM6V6tcYwnBGmyBYv+Fy3KQUiW+YnIn+E7JuDnUpZoLK9jKDACgRWvvgFAw
         1P+LchJlvX/TZTSZMv0GYLk0/VB/lcfKrdgtRbfJwweKLxjPtFbkXoj54F+h4xcIcrSi
         Zyo9zKQm/pee2F5QbPsmpLDOLc+pz1eApMfkJTyNhUkaRaGvMMuOMr5ERLtDfKqufwmf
         G45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMX4ltxMnrzuUcItxcrzty4g8h+ES70tKWqrRNz68jo=;
        b=iCf4JJ8bM5kQchRE3my6z1EwxKsJKDLKAp2fl2gMWJSKhdYgnEnrJp3zkWmXI1CdOE
         +p9rzzLXqpWYcTUzJ5a+RrfleGSyblBbHN6AqTek1mcyYuUC5aT+oMxz+qiqPafDwJr4
         5x4z3YEvBKqA7FiOs4rfa5/vEhvF0EyaTY3hC1YSEciytaS8wSgbA7jRzi6M0vvr03O7
         qz22rQokp85V8tn4gW7kq7ZvXx3wjxQS7wmIWtT+Dt0EQff3EZKVu1Qx3ulZF6B4AV1c
         Oy+qzNUbScntz+e46jpwuA6h0uSYQx73QvOkEm7UnXvpjBznDsWEpaOh0hSkSXmtarjh
         u+BQ==
X-Gm-Message-State: AElRT7FsIaXCgNI4aUhE21Jrg77CPGttCgDOZtitQrFTeF1XDE0SmU+q
        xqOXUMCccnVERZi2ew+nGmQ=
X-Google-Smtp-Source: AG47ELtlBelyeExWXgRdcKZeNUSe/yuPV8xV84BXSknb/5gE+VWDClWVGfRIzeOI/LtQQt2OTbnh6g==
X-Received: by 2002:a19:fc0d:: with SMTP id a13-v6mr16463665lfi.136.1521825718145;
        Fri, 23 Mar 2018 10:21:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/27] sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
Date:   Fri, 23 Mar 2018 18:21:08 +0100
Message-Id: <20180323172121.17725-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Actually this also allows read_info_alternates and link_alt_odb_entry to
handle arbitrary repositories, but link_alt_odb_entries is the most
interesting function in this set of functions, hence the commit subject.

These functions span a strongly connected component in the function
graph, i.e. the recursive call chain might look like

  -> link_alt_odb_entries
    -> link_alt_odb_entry
      -> read_info_alternates
        -> link_alt_odb_entries

That is why we need to convert all these functions at the same time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h |  4 ++++
 sha1_file.c    | 36 ++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/object-store.h b/object-store.h
index 79de470639..3fc461a463 100644
--- a/object-store.h
+++ b/object-store.h
@@ -18,6 +18,10 @@ struct alternate_object_database {
 	char loose_objects_subdir_seen[256];
 	struct oid_array loose_objects_cache;
 
+	/*
+	 * Path to the alternative object store. If this is a relative path,
+	 * it is relative to the current working directory.
+	 */
 	char path[FLEX_ARRAY];
 };
 #define prepare_alt_odb(r) prepare_alt_odb_##r()
diff --git a/sha1_file.c b/sha1_file.c
index 0fac75bd31..d38f5cdb0e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -390,11 +390,10 @@ static int alt_odb_usable(struct raw_object_store *o,
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-#define read_info_alternates(r, rb, d) read_info_alternates_##r(rb, d)
-static void read_info_alternates_the_repository(const char *relative_base,
-						int depth);
-#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
-static int link_alt_odb_entry_the_repository(const char *entry,
+static void read_info_alternates(struct repository *r,
+				 const char *relative_base,
+				 int depth);
+static int link_alt_odb_entry(struct repository *r, const char *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
@@ -420,7 +419,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(the_repository->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -428,12 +427,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*the_repository->objects->alt_odb_tail = ent;
-	the_repository->objects->alt_odb_tail = &(ent->next);
+	*r->objects->alt_odb_tail = ent;
+	r->objects->alt_odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
+	read_info_alternates(r, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -468,12 +467,8 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-#define link_alt_odb_entries(r, a, s, rb, d) \
-	link_alt_odb_entries_##r(a, s, rb, d)
-static void link_alt_odb_entries_the_repository(const char *alt,
-						int sep,
-						const char *relative_base,
-						int depth)
+static void link_alt_odb_entries(struct repository *r, const char *alt,
+				 int sep, const char *relative_base, int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -487,7 +482,7 @@ static void link_alt_odb_entries_the_repository(const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, get_object_directory());
+	strbuf_add_absolute_path(&objdirbuf, r->objects->objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die("unable to normalize object directory: %s",
 		    objdirbuf.buf);
@@ -496,15 +491,16 @@ static void link_alt_odb_entries_the_repository(const char *alt,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(the_repository, entry.buf,
+		link_alt_odb_entry(r, entry.buf,
 				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates_the_repository(const char *relative_base,
-						int depth)
+static void read_info_alternates(struct repository *r,
+				 const char *relative_base,
+				 int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -516,7 +512,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

