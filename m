Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9881F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbeCCLiW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:38:22 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38522 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLiV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:38:21 -0500
Received: by mail-pf0-f193.google.com with SMTP id d26so5143496pfn.5
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MOLPk4IqEforhiZPyFm3zo+vIDsy8uJcbKppljHt9k=;
        b=RuqYFimCMKNVktF3RdTS2gYPqBHMLdmwxUbe3RWdvFgC7ViVrXUL12uS9mQ9eD9/lS
         nmkWpVtnzBQyFXlgma8thjdDDtPill/LwN1C8blD8SbiuwhQ+8rGO5K1fMmOdTiEY/3u
         3gOlBO95QtRzYrU5Va6yvXOt1Ux/8peomNg1z6/hEdc0+oHtSPVhAKMW/mZ5PbCdr7BQ
         ZCu5TqxdFe533aj0SedQiiGLxIrV8QLFy5/sdUqh4tssngFFQcr4fuW0mQADjhT06p73
         B0Fgb7bMM1O/PHuLbbG2VfCt7w3Kyu4LqgKcBFhW8yh4EyNwGLu5AhdS6FrQvMrh6cjh
         PPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MOLPk4IqEforhiZPyFm3zo+vIDsy8uJcbKppljHt9k=;
        b=b/Z7fn8/fUFS95J87wMM6RV57bRhSQLBPQjaOyz6nMxW+0BdokDwhbAiSF82VLzBP4
         CnKtJaeMdECm//6A1iexFg6p8Tt9N5r/4G0zY4TcgMwKv8Uvompv9P5PhLiy++k7AZJ1
         paJBPjhMhVNwnCl5ySPZ2fgHHIjZvIxvccNepjlCMlPbVgGchks6/u/lpfB8DfeUlJ2/
         bC2d4SxlqbqbOm/LGgX7igl/6y1idRFd68MjEel/DmmRKYHSatcbL1w4W9UFEedeOgcv
         vaFr5VNwdtyk5YVk/WsqRqnAoHZkH1AsoLdj7TTfAWUvg558hpdyD8qcugn1xdNgewYD
         2QdA==
X-Gm-Message-State: APf1xPCTufmeNmvKxSlyPCJEe9x1hU7+6whA7bGqqDbe+DcMQt6hUmxj
        bv0LNCwdQWVHKy+aJupXC8LyqA==
X-Google-Smtp-Source: AG47ELvy8PELX8XDfwps2GGzqGo9tKJLUqlieWp6cVlVM98BmiB75v31aJXXmAqT8e7cXmDnGPJ/RQ==
X-Received: by 10.99.51.74 with SMTP id z71mr6939259pgz.272.1520077100422;
        Sat, 03 Mar 2018 03:38:20 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id b5sm18037639pfc.12.2018.03.03.03.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/44] sha1_file: allow link_alt_odb_entries to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:12 +0700
Message-Id: <20180303113637.26518-20-pclouds@gmail.com>
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
index 3d0f8a87cb..20ba136c1f 100644
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
index 027e0f3741..f34eb69e39 100644
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
 
-	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&r->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
@@ -428,12 +427,12 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
-	*the_repository->objects.alt_odb_tail = ent;
-	the_repository->objects.alt_odb_tail = &(ent->next);
+	*r->objects.alt_odb_tail = ent;
+	r->objects.alt_odb_tail = &(ent->next);
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
+	strbuf_add_absolute_path(&objdirbuf, r->objects.objectdir);
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
2.16.1.435.g8f24da2e1a

