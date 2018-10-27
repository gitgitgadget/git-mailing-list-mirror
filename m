Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B08C1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeJ0PuS (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33087 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeJ0PuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id w16-v6so2547605lfc.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMdBbkG8MyBAK38GN4xKX/1Er6iknpslCmJoKDCEZbc=;
        b=i8fCV4uoyKwWyXVj0I59Wcz07YGZRRabnoEgq9clAyJQX79xmL7bHXZGxN9PGWoCvE
         X9pt5D+I5bKxRlxWRAZMlojz4u2oyHu2jIMixELfhFW4wOcH+r8FGEFSxpRafI9MqVAF
         tu3U9VU6VPFirvsLU2iCmfgeCvP8YXyU72FQyMfuQ9aCOs3GoCvx4jU3HlO80zFVHY2H
         IxEw5wniDyPEXRzKsYpEBNmhqeCFiag0pueyEUHGgZC2dfnf0uRosk5uztuM4p1Ayvzz
         gnjssYZnctB0tu2SfziU1tST9+oXtjIZJlNQQfR1y21pYRe92RDuMkriV/7hQTG7Plkm
         xOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMdBbkG8MyBAK38GN4xKX/1Er6iknpslCmJoKDCEZbc=;
        b=UEechPwGcXwhLbA/nkTz5jC7HBXQRp2qcyS4qjDvrT6QKxpigWGWgnFg2mKPfG8TMK
         dS05rGlRrCX4C75E3z7F4FaDmJh1xak1jpzkBNn+4EtKkijvq/yxXsKCDdoajSxyqG++
         l04OeaTVdz44QYbonoqYKer9wmgKL+Y2e1H6MMgbx1NusuyQKdbjOCHkRO0Qz8SHpClP
         HOacCRdQ43Fe/kaATzgVywFfZt3/gY/LsoEC6nG8GZbHNdkJFCiS7lzM1peyPw6eWYgH
         aeXDrBA0VfyiwxSg5ClCEFdhd7dbUG5OPKYIyYCXRK8etoKGL0LBCY18hhU4n2I7PC/6
         VMaw==
X-Gm-Message-State: AGRZ1gInH6FqSuY0blkEP65pzdnD3agBfBXRcokTcml1YNej4QoW6CT0
        1aFaG08l6taLpOcP4FLABkrxZQuZ
X-Google-Smtp-Source: AJdET5e+uSOyHNmMJqcDw+RxpurWaWmGyY3lxHDXJEh3l7NnkRS9f5Xz68sV9ZE5LTVPQ5YE2j8LSQ==
X-Received: by 2002:a19:1019:: with SMTP id f25mr3820894lfi.54.1540624216412;
        Sat, 27 Oct 2018 00:10:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/10] grep: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:09:59 +0200
Message-Id: <20181027071003.1347-7-pclouds@gmail.com>
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
 builtin/grep.c | 58 +++++++++++++++++---------------------------------
 grep.c         |  6 ------
 grep.h         |  6 ------
 3 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d8508ddf79..29221e1003 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -34,7 +34,6 @@ static int recurse_submodules;
 #define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
 
-#ifndef NO_PTHREADS
 static pthread_t *threads;
 
 /* We use one producer thread and THREADS consumer
@@ -265,13 +264,6 @@ static int wait_all(void)
 
 	return hit;
 }
-#else /* !NO_PTHREADS */
-
-static int wait_all(void)
-{
-	return 0;
-}
-#endif
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
@@ -284,8 +276,7 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
-#ifdef NO_PTHREADS
-		else if (num_threads && num_threads != 1) {
+		else if (!HAVE_THREADS && num_threads && num_threads != 1) {
 			/*
 			 * TRANSLATORS: %s is the configuration
 			 * variable for tweaking threads, currently
@@ -294,7 +285,6 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 			warning(_("no threads support, ignoring %s"), var);
 			num_threads = 0;
 		}
-#endif
 	}
 
 	if (!strcmp(var, "submodule.recurse"))
@@ -330,17 +320,14 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 
 		hit = grep_source(opt, &gs);
@@ -363,17 +350,14 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 	strbuf_release(&buf);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		/*
 		 * add_work() copies gs and thus assumes ownership of
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
 		return 0;
-	} else
-#endif
-	{
+	} else {
 		int hit;
 
 		hit = grep_source(opt, &gs);
@@ -1038,20 +1022,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
-#ifndef NO_PTHREADS
-	if (list.nr || cached || show_in_pager)
-		num_threads = 0;
-	else if (num_threads == 0)
-		num_threads = GREP_NUM_THREADS_DEFAULT;
-	else if (num_threads < 0)
-		die(_("invalid number of threads specified (%d)"), num_threads);
-	if (num_threads == 1)
+	if (HAVE_THREADS) {
+		if (list.nr || cached || show_in_pager)
+			num_threads = 0;
+		else if (num_threads == 0)
+			num_threads = GREP_NUM_THREADS_DEFAULT;
+		else if (num_threads < 0)
+			die(_("invalid number of threads specified (%d)"), num_threads);
+		if (num_threads == 1)
+			num_threads = 0;
+	} else {
+		if (num_threads)
+			warning(_("no threads support, ignoring --threads"));
 		num_threads = 0;
-#else
-	if (num_threads)
-		warning(_("no threads support, ignoring --threads"));
-	num_threads = 0;
-#endif
+	}
 
 	if (!num_threads)
 		/*
@@ -1062,15 +1046,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		 */
 		compile_grep_patterns(&opt);
 
-#ifndef NO_PTHREADS
-	if (num_threads) {
+	if (HAVE_THREADS && num_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
 		    && (opt.pre_context || opt.post_context ||
 			opt.file_break || opt.funcbody))
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
-#endif
 
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
@@ -1121,7 +1103,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, &list);
 	}
 
-	if (num_threads)
+	if (HAVE_THREADS && num_threads)
 		hit |= wait_all();
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
diff --git a/grep.c b/grep.c
index f6bd89e40b..4db1510d16 100644
--- a/grep.c
+++ b/grep.c
@@ -1513,7 +1513,6 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	}
 }
 
-#ifndef NO_PTHREADS
 int grep_use_locks;
 
 /*
@@ -1539,11 +1538,6 @@ static inline void grep_attr_unlock(void)
  */
 pthread_mutex_t grep_read_mutex;
 
-#else
-#define grep_attr_lock()
-#define grep_attr_unlock()
-#endif
-
 static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bol, char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
diff --git a/grep.h b/grep.h
index 1a57d12b90..fb04893721 100644
--- a/grep.h
+++ b/grep.h
@@ -229,7 +229,6 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs);
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
 
-#ifndef NO_PTHREADS
 /*
  * Mutex used around access to the attributes machinery if
  * opt->use_threads.  Must be initialized/destroyed by callers!
@@ -250,9 +249,4 @@ static inline void grep_read_unlock(void)
 		pthread_mutex_unlock(&grep_read_mutex);
 }
 
-#else
-#define grep_read_lock()
-#define grep_read_unlock()
-#endif
-
 #endif
-- 
2.19.1.647.g708186aaf9

