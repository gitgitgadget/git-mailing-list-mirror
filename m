Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4711F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeJ0PuV (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34508 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeJ0PuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id g8-v6so274245ljk.1
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLCcqTzF++H24RbkSBiziTtVjx4je/Bxw9RWY3pqi9k=;
        b=L7sQ5hvAJUa6h1AGH5UQGZLw3GpZj8f3TTuio2uDvpZoWXVs7zNE8n7aRKbkX7OtOa
         su5BwLg2ICUI9CKaJ/NWZkCNmT4fnEK7f90RdZ1clCgTTih1KKca5XY75k08pgESxcEZ
         19FR5Yb+XL5RJ3ozdMlCMkB4wO9YniJfTPolytZBmrjOK67ZfL4EDBtq99rF7cFRadZ2
         tCuQWzCm9JbCRcNljfbixaehn5gPgy04GbQapshzT8diLG9vo2Bor65uhVV8Ha7tnLGJ
         PQj5SH+hdMnehUQLPZrLUoTHfJcy7GJAfYEEpU4IY3fHhlI87sD5LqoxHd4sN5m/Kq1E
         w39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLCcqTzF++H24RbkSBiziTtVjx4je/Bxw9RWY3pqi9k=;
        b=DhBYCDsvX6Q2JivTVQQ3Rm4XVNyq5dJi9ukc8LWbRawioM5OXCeIyxTDFdGGbD1hmI
         2+2hp+x07Qo3fhcCFELjDPg6X4wjbrNHSuUaMJOQFQTtWSZ2uU7LOUN4kXTFD9Tosy2S
         3bB10MRa42BwN0W9Czw3MATiCwFqsuBkTeXrQdxZpwB2c+sBbRzCUZhbpYZcA6wPIZVT
         pJztTuT0XvfzVnrcvJCSnCpRG1wegEvoeQ9EbwGEM9JFk1vajebSN27A7kA1Zr3992uM
         eaVAapPLmR9d0aSpaJTUjvfLedKL2KyRUj+vs+SuXx9hRJjh/5aaviaT9Fyq9Xv6UpDx
         xFcg==
X-Gm-Message-State: AGRZ1gJt8lu84+qU7wHbuZ+RsoB0YucQ6Mysa7uaYZ6pvC01AHDKszbS
        uy3kayLfwBadXnG+1SsYsOde9VSJ
X-Google-Smtp-Source: AJdET5ch1+YlXHJ91Z36StEwDOgOXPLxKeituMM8MkjfFxCUOUQRBI4Uosz73oRC9YIbTO5HPKxfsw==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr1356315ljb.177.1540624219611;
        Sat, 27 Oct 2018 00:10:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/10] read-cache.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:10:02 +0200
Message-Id: <20181027071003.1347-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027071003.1347-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 49 ++++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d57958233e..ba870bc3fd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1920,19 +1920,15 @@ struct index_entry_offset_table
 	struct index_entry_offset entries[FLEX_ARRAY];
 };
 
-#ifndef NO_PTHREADS
 static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset);
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
-#endif
 
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
 
 struct load_index_extensions
 {
-#ifndef NO_PTHREADS
 	pthread_t pthread;
-#endif
 	struct index_state *istate;
 	const char *mmap;
 	size_t mmap_size;
@@ -2010,8 +2006,6 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
 	return consumed;
 }
 
-#ifndef NO_PTHREADS
-
 /*
  * Mostly randomly chosen maximum thread counts: we
  * cap the parallelism to online_cpus() threads, and we want
@@ -2122,7 +2116,6 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 
 	return consumed;
 }
-#endif
 
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
@@ -2135,10 +2128,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	size_t mmap_size;
 	struct load_index_extensions p;
 	size_t extension_offset = 0;
-#ifndef NO_PTHREADS
 	int nr_threads, cpus;
 	struct index_entry_offset_table *ieot = NULL;
-#endif
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -2181,15 +2172,18 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	src_offset = sizeof(*hdr);
 
-#ifndef NO_PTHREADS
-	nr_threads = git_config_get_index_threads();
+	if (HAVE_THREADS) {
+		nr_threads = git_config_get_index_threads();
 
-	/* TODO: does creating more threads than cores help? */
-	if (!nr_threads) {
-		nr_threads = istate->cache_nr / THREAD_COST;
-		cpus = online_cpus();
-		if (nr_threads > cpus)
-			nr_threads = cpus;
+		/* TODO: does creating more threads than cores help? */
+		if (!nr_threads) {
+			nr_threads = istate->cache_nr / THREAD_COST;
+			cpus = online_cpus();
+			if (nr_threads > cpus)
+				nr_threads = cpus;
+		}
+	} else {
+		nr_threads = 1;
 	}
 
 	if (nr_threads > 1) {
@@ -2219,21 +2213,16 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	} else {
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
 	}
-#else
-	src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
-#endif
 
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	/* if we created a thread, join it otherwise load the extensions on the primary thread */
-#ifndef NO_PTHREADS
-	if (extension_offset) {
+	if (HAVE_THREADS && extension_offset) {
 		int ret = pthread_join(p.pthread, NULL);
 		if (ret)
 			die(_("unable to join load_index_extensions thread: %s"), strerror(ret));
 	}
-#endif
 	if (!extension_offset) {
 		p.src_offset = src_offset;
 		load_index_extensions(&p);
@@ -2756,8 +2745,11 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-#ifndef NO_PTHREADS
-	nr_threads = git_config_get_index_threads();
+	if (HAVE_THREADS)
+		nr_threads = git_config_get_index_threads();
+	else
+		nr_threads = 1;
+
 	if (nr_threads != 1) {
 		int ieot_blocks, cpus;
 
@@ -2787,7 +2779,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
 		}
 	}
-#endif
 
 	offset = lseek(newfd, 0, SEEK_CUR);
 	if (offset < 0) {
@@ -2871,8 +2862,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * strip_extensions parameter as we need it when loading the shared
 	 * index.
 	 */
-#ifndef NO_PTHREADS
-	if (ieot) {
+	if (HAVE_THREADS && ieot) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_ieot_extension(&sb, ieot);
@@ -2883,7 +2873,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-#endif
 
 	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb = STRBUF_INIT;
@@ -3469,7 +3458,6 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 	strbuf_add(sb, hash, the_hash_algo->rawsz);
 }
 
-#ifndef NO_PTHREADS
 #define IEOT_VERSION	(1)
 
 static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
@@ -3542,4 +3530,3 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
 	       strbuf_add(sb, &buffer, sizeof(uint32_t));
        }
 }
-#endif
-- 
2.19.1.647.g708186aaf9

