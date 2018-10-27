Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1DF1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeJ0PuO (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43525 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0PuO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id g26-v6so1902991lja.10
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xDyapWfwoqfEqSfPJe6Xohq4fxEOPqfhDua9vHp/Eg=;
        b=JM1P3AUyCeK50kGFYyToOmzsgbvOzFJHbNsckPghaIOVc6lKB752n0vanBPrr4N1Lo
         kM9XDq1YKCRuFls6pAUxCAYQLqBEB3k7WocyoJFMciitbo0czzBxzJshGGh8bLgn5VL+
         L7bQfyoen5EJP7M7zA8cO0Dkipsj5qoIK3wKfJa5hkEAJyQwL794wSbPzmyeMKRa/3jT
         8b3k6uOvGPCbvZHFdBbYzkjlIIkaLBiIhrYtC8eaQ+q+ShWNzjCLgg61kl/OtFND9msl
         Ygyu3CsZuEbGda5OegbFR8z2Aq9XYsLhF17hIJtZHBOhUWz2M1lPxIyWEowwEKeLWRwL
         KizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xDyapWfwoqfEqSfPJe6Xohq4fxEOPqfhDua9vHp/Eg=;
        b=IPHThW+KOCs+osxv50zz/af0I/J5kD4zare7ZfyW8T9+bsN9SYCm6i3PqAIumV/zqu
         pUc9qLHXaMDQN82AvYNs4f3H2w4UZE3+9tPngt1TfDCxDOMEynbcDbQS8K9K1q+IUpql
         KVuq2TFAVRtrBV3Lh6RTXYMS8u16vfoUdZYlnmoDo8ruPwk9rSdj/LEz2/3GdnJ5ZoLS
         4izVDw9CsNmbSQTpgCflhLqZJRkLeIZLvqHGQ3M2wScj32ceeviIi+GE9wuYAL0kMk7s
         p+jIhf+CEwDueg4c4/R3qCGFuZ5TqvLm5OcTF7FBMNtTESI0YHPQhWSHoXUzr2SFt8JR
         F92A==
X-Gm-Message-State: AGRZ1gIE7Z9661bHN7kcz9IQA97/H7h/FnEi5yRTYFJq9sbMUog65gXK
        I5p4WfUm9lC0EhFSR4eibK89NQ5X
X-Google-Smtp-Source: AJdET5fNIZB5Aophabj5fGNBE4qHWrs29yTox4l5ya9GcWFSBwtgvAQBL8OtnQjxzmTCwFtzJaVAIA==
X-Received: by 2002:a2e:719:: with SMTP id 25-v6mr4347477ljh.128.1540624211935;
        Sat, 27 Oct 2018 00:10:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/10] index-pack: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:09:55 +0200
Message-Id: <20181027071003.1347-3-pclouds@gmail.com>
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
 builtin/index-pack.c | 68 ++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 50 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2004e25da2..bbd66ca025 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -42,9 +42,7 @@ struct base_data {
 };
 
 struct thread_local {
-#ifndef NO_PTHREADS
 	pthread_t thread;
-#endif
 	struct base_data *base_cache;
 	size_t base_cache_used;
 	int pack_fd;
@@ -98,8 +96,6 @@ static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
 
-#ifndef NO_PTHREADS
-
 static struct thread_local *thread_data;
 static int nr_dispatched;
 static int threads_active;
@@ -179,26 +175,6 @@ static void cleanup_thread(void)
 	free(thread_data);
 }
 
-#else
-
-#define read_lock()
-#define read_unlock()
-
-#define counter_lock()
-#define counter_unlock()
-
-#define work_lock()
-#define work_unlock()
-
-#define deepest_delta_lock()
-#define deepest_delta_unlock()
-
-#define type_cas_lock()
-#define type_cas_unlock()
-
-#endif
-
-
 static int mark_link(struct object *obj, int type, void *data, struct fsck_options *options)
 {
 	if (!obj)
@@ -364,22 +340,20 @@ static NORETURN void bad_object(off_t offset, const char *format, ...)
 
 static inline struct thread_local *get_thread_data(void)
 {
-#ifndef NO_PTHREADS
-	if (threads_active)
-		return pthread_getspecific(key);
-	assert(!threads_active &&
-	       "This should only be reached when all threads are gone");
-#endif
+	if (HAVE_THREADS) {
+		if (threads_active)
+			return pthread_getspecific(key);
+		assert(!threads_active &&
+		       "This should only be reached when all threads are gone");
+	}
 	return &nothread_data;
 }
 
-#ifndef NO_PTHREADS
 static void set_thread_data(struct thread_local *data)
 {
 	if (threads_active)
 		pthread_setspecific(key, data);
 }
-#endif
 
 static struct base_data *alloc_base_data(void)
 {
@@ -1092,7 +1066,6 @@ static void resolve_base(struct object_entry *obj)
 	find_unresolved_deltas(base_obj);
 }
 
-#ifndef NO_PTHREADS
 static void *threaded_second_pass(void *data)
 {
 	set_thread_data(data);
@@ -1116,7 +1089,6 @@ static void *threaded_second_pass(void *data)
 	}
 	return NULL;
 }
-#endif
 
 /*
  * First pass:
@@ -1213,7 +1185,6 @@ static void resolve_deltas(void)
 		progress = start_progress(_("Resolving deltas"),
 					  nr_ref_deltas + nr_ofs_deltas);
 
-#ifndef NO_PTHREADS
 	nr_dispatched = 0;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
@@ -1229,7 +1200,6 @@ static void resolve_deltas(void)
 		cleanup_thread();
 		return;
 	}
-#endif
 
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
@@ -1531,11 +1501,11 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
-#ifdef NO_PTHREADS
-		if (nr_threads != 1)
-			warning(_("no threads support, ignoring %s"), k);
-		nr_threads = 1;
-#endif
+		if (!HAVE_THREADS) {
+			if (nr_threads != 1)
+				warning(_("no threads support, ignoring %s"), k);
+			nr_threads = 1;
+		}
 		return 0;
 	}
 	return git_default_config(k, v, cb);
@@ -1723,12 +1693,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				nr_threads = strtoul(arg+10, &end, 0);
 				if (!arg[10] || *end || nr_threads < 0)
 					usage(index_pack_usage);
-#ifdef NO_PTHREADS
-				if (nr_threads != 1)
-					warning(_("no threads support, "
-						  "ignoring %s"), arg);
-				nr_threads = 1;
-#endif
+				if (!HAVE_THREADS) {
+					if (nr_threads != 1)
+						warning(_("no threads support, "
+							  "ignoring %s"), arg);
+					nr_threads = 1;
+				}
 			} else if (starts_with(arg, "--pack_header=")) {
 				struct pack_header *hdr;
 				char *c;
@@ -1791,14 +1761,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (strict)
 		opts.flags |= WRITE_IDX_STRICT;
 
-#ifndef NO_PTHREADS
-	if (!nr_threads) {
+	if (HAVE_THREADS && !nr_threads) {
 		nr_threads = online_cpus();
 		/* An experiment showed that more threads does not mean faster */
 		if (nr_threads > 3)
 			nr_threads = 3;
 	}
-#endif
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
-- 
2.19.1.647.g708186aaf9

