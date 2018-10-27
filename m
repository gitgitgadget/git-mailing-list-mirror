Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705661F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeJ0PuV (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37879 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeJ0PuU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id a82-v6so2523341lfa.4
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SF0N9DVdrmmyoJxDZIeToLkpdB5o/uj/ao+EU7EKPtg=;
        b=SgvVDmMCwOWhNaE4AB4siPe17ulBLXRHXIsBEN0kqkt/rn5A0L+U/3vb+O09zFxcZ0
         Ft+WUU28NHJUCUsqYA8MxgW2dCeW/h+2cPZgA2eTjisOXWaooAxwx/C8DLZbY1C5qgek
         fbxvwArWdN71Aex4ueuxndQMyfER9jJKer8KKc0UfewGKWtl8u/3sl/QipE+o+7NDDLl
         g5ZX9+P/NDpKZP6hIW3qa0np4f2Mz7xWvcFTcmXvkw4i9GMAqzGYsiNB543BDK+HoQvh
         IzPnL9iZlcjfaC6UyLP5Sou743m+VXD+0jmK/ERZRvgfjR5+ibxb8PyCVwSctdZBYivl
         Xwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SF0N9DVdrmmyoJxDZIeToLkpdB5o/uj/ao+EU7EKPtg=;
        b=o9LpPJj6FGeKozKiSl25oUgr0hh8aPN86rxuyFkD3IBel9OIcijTCHUYV65KHjGnI+
         tKxauKrP354Bfx0Z8KVYb1ok9z2jk9L5EJ/WUMdPyopxpyXVKEzzK69fhZMJULgBJ0c6
         bUJ4EBpwt3+N6S+vlh7nnbF4Ix8Sgw2ZWn7hEEHb3QpE33qNuWmZ8Ec7dY/E8SQMpvWk
         M2CPWzy2DdfP4saVyKAfRobUOueLemxaOQhyBnCPi/as22D5RA9h6qoB0OS1r0DGHv2W
         jC7UFcOa8Dewnv7hsUCbcYBI0lsTcG7C3xwWojYMgk4+JZ7HRPxr1qECkro6To4t86Ij
         yVdA==
X-Gm-Message-State: AGRZ1gK9yf9cVU9+G12R7fzz/Rtupidqn7OVb0XfmxHJwRKhh61PnuEo
        A+M794mSnN3zq4gQ71mzdVoJdPV8
X-Google-Smtp-Source: AJdET5ffhGOEW1riHtgtCV4Q16l+9+VKmyO4Vp9fHwKc6KuDKftgp6JCSbmelCUJzCUHorXjIa5FPw==
X-Received: by 2002:a19:54d7:: with SMTP id b84mr767770lfl.131.1540624218597;
        Sat, 27 Oct 2018 00:10:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/10] pack-objects: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:10:01 +0200
Message-Id: <20181027071003.1347-9-pclouds@gmail.com>
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
 builtin/pack-objects.c | 26 ++------------------------
 pack-objects.h         |  6 ------
 2 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b059b86aee..12edd6da16 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1953,8 +1953,6 @@ static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
 	return 0;
 }
 
-#ifndef NO_PTHREADS
-
 /* Protect access to object database */
 static pthread_mutex_t read_mutex;
 #define read_lock()		pthread_mutex_lock(&read_mutex)
@@ -1979,16 +1977,6 @@ static pthread_mutex_t progress_mutex;
  * ahead in the list because they can be stolen and would need
  * progress_mutex for protection.
  */
-#else
-
-#define read_lock()		(void)0
-#define read_unlock()		(void)0
-#define cache_lock()		(void)0
-#define cache_unlock()		(void)0
-#define progress_lock()		(void)0
-#define progress_unlock()	(void)0
-
-#endif
 
 /*
  * Return the size of the object without doing any delta
@@ -2347,8 +2335,6 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 	free(array);
 }
 
-#ifndef NO_PTHREADS
-
 static void try_to_free_from_threads(size_t size)
 {
 	read_lock();
@@ -2578,10 +2564,6 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	free(p);
 }
 
-#else
-#define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
-#endif
-
 static void add_tag_chain(const struct object_id *oid)
 {
 	struct tag *tag;
@@ -2734,12 +2716,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		if (delta_search_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    delta_search_threads);
-#ifdef NO_PTHREADS
-		if (delta_search_threads != 1) {
+		if (!HAVE_THREADS && delta_search_threads != 1) {
 			warning(_("no threads support, ignoring %s"), k);
 			delta_search_threads = 0;
 		}
-#endif
 		return 0;
 	}
 	if (!strcmp(k, "pack.indexversion")) {
@@ -3402,10 +3382,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
 
-#ifdef NO_PTHREADS
-	if (delta_search_threads != 1)
+	if (!HAVE_THREADS && delta_search_threads != 1)
 		warning(_("no threads support, ignoring --threads"));
-#endif
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
diff --git a/pack-objects.h b/pack-objects.h
index 2ca39cfcfe..3a42727c7d 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -145,9 +145,7 @@ struct packing_data {
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
 
-#ifndef NO_PTHREADS
 	pthread_mutex_t lock;
-#endif
 
 	/*
 	 * This list contains entries for bases which we know the other side
@@ -169,15 +167,11 @@ void prepare_packing_data(struct packing_data *pdata);
 
 static inline void packing_data_lock(struct packing_data *pdata)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&pdata->lock);
-#endif
 }
 static inline void packing_data_unlock(struct packing_data *pdata)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&pdata->lock);
-#endif
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-- 
2.19.1.647.g708186aaf9

