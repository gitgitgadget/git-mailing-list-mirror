Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7BA1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeJ0PuX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33091 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeJ0PuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id w16-v6so2547660lfc.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Qk+6dxMRf1uSVCWaRLkgpXbfUTW045jwm0hjrNlab0=;
        b=KNwGxpWP+j+Uy89vTmi2OfXLFJ9iK/BhZ3AGZ2GwMi1BzqFG6LrwOj9PTWC5DUaCkq
         CKnDSYiNfWkMMG30OoRpUQGNqVJ0Qw0EZrjsI6G3gf2qsSHF2KvFqmgrdzpTK1U4fjTx
         SCqZN+S69bzqaMsuPsB/NLM/3NIwAmtRJSdFs9HAAwbGNxg9x6Fuz0l0uUOEiJ9EwOWP
         m/ZOyL8w6ztdht52wAe9TXCGpPXJ5hh0lqBJC6ERcrc0kY0ow8aYSeLzYuWRLB+HlIIL
         s7IquuuSxsYPMR3ga9W3jILWnYi4lNLSBHRc4wbumlnb8kUPKCaQW1aIYdId027LmTEN
         48kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Qk+6dxMRf1uSVCWaRLkgpXbfUTW045jwm0hjrNlab0=;
        b=NA6TJWDhtLksCP7at+CrANCHxZhlwgfzZp/piCLFy+nAxTLkUAo8g5oEQTWT4kL187
         hv1e4TZDYkByAvWjIYLK32ausE11f/t7hfoh/Q9YtZZnoU7MtSJJ6DAG12+LDPkIPY2j
         OD7UF3ZkW8RQJVQnGEXteqvWxfJ9mKX6YlN5PJEZJ7khBuG+3j/JWfWjmXGMzYIVPP22
         OL0BxOUtC8OgdRViU+0mt3+KuMt4iRzJxdU/S/+jBYp+N+PWYTW+XjE3sjNBIhIhdNAd
         Q4K9lmvvBY7nUG7CLx2EDzIqii6fxqqa9oBokmceTr4AW7VOu5W6ODjb9JfsiLyLSlFu
         FpLA==
X-Gm-Message-State: AGRZ1gJD+To4Yg769c6c4u9yKAdwvYZr9Tjlk42p7EfseBAr6VtOyvBw
        +1OJYdddUuY7bweyEJcrOi6tVZJn
X-Google-Smtp-Source: AJdET5dfzCRyvJNylybm+mSiVIR7HIu2+z/ynbnd/aCR00aII380WWOEBg14Hm7pZudGGDdspPCuiw==
X-Received: by 2002:a19:5154:: with SMTP id f81mr4093331lfb.96.1540624220686;
        Sat, 27 Oct 2018 00:10:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/10] Clean up pthread_create() error handling
Date:   Sat, 27 Oct 2018 09:10:03 +0200
Message-Id: <20181027071003.1347-11-pclouds@gmail.com>
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

Normally pthread_create() rarely fails and sometimes error handling
can be neglected. But with new pthreads wrapper, pthread_create() will
return ENOSYS on a system without thread support.

Threaded code _is_ protected by HAVE_THREADS and pthread_create()
should never run in the first place. But the situation could change in
the future and bugs may sneak in. Make sure that all pthread_create()
checks and handles the result.

While at there, mark these strings for translation if they aren't.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 name-hash.c     | 16 ++++++++++------
 preload-index.c |  8 ++++++--
 run-command.c   |  2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index b3c9ac791d..623ca6923a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -494,6 +494,7 @@ static inline void lazy_update_dir_ref_counts(
 static void threaded_lazy_init_name_hash(
 	struct index_state *istate)
 {
+	int err;
 	int nr_each;
 	int k_start;
 	int t;
@@ -526,8 +527,9 @@ static void threaded_lazy_init_name_hash(
 		if (k_start > istate->cache_nr)
 			k_start = istate->cache_nr;
 		td_dir_t->k_end = k_start;
-		if (pthread_create(&td_dir_t->pthread, NULL, lazy_dir_thread_proc, td_dir_t))
-			die("unable to create lazy_dir_thread");
+		err = pthread_create(&td_dir_t->pthread, NULL, lazy_dir_thread_proc, td_dir_t);
+		if (err)
+			die(_("unable to create lazy_dir thread: %s"), strerror(err));
 	}
 	for (t = 0; t < lazy_nr_dir_threads; t++) {
 		struct lazy_dir_thread_data *td_dir_t = td_dir + t;
@@ -547,13 +549,15 @@ static void threaded_lazy_init_name_hash(
 	 */
 	td_name->istate = istate;
 	td_name->lazy_entries = lazy_entries;
-	if (pthread_create(&td_name->pthread, NULL, lazy_name_thread_proc, td_name))
-		die("unable to create lazy_name_thread");
+	err = pthread_create(&td_name->pthread, NULL, lazy_name_thread_proc, td_name);
+	if (err)
+		die(_("unable to create lazy_name thread: %s"), strerror(err));
 
 	lazy_update_dir_ref_counts(istate, lazy_entries);
 
-	if (pthread_join(td_name->pthread, NULL))
-		die("unable to join lazy_name_thread");
+	err = pthread_join(td_name->pthread, NULL);
+	if (err)
+		die(_("unable to join lazy_name thread: %s"), strerror(err));
 
 	cleanup_dir_mutex();
 
diff --git a/preload-index.c b/preload-index.c
index 0e24886aca..ddca1c216e 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -121,6 +121,8 @@ static void preload_index(struct index_state *index,
 
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
+		int err;
+
 		p->index = index;
 		if (pathspec)
 			copy_pathspec(&p->pathspec, pathspec);
@@ -129,8 +131,10 @@ static void preload_index(struct index_state *index,
 		if (pd.progress)
 			p->progress = &pd;
 		offset += work;
-		if (pthread_create(&p->pthread, NULL, preload_thread, p))
-			die("unable to create threaded lstat");
+		err = pthread_create(&p->pthread, NULL, preload_thread, p);
+
+		if (err)
+			die(_("unable to create threaded lstat: %s"), strerror(err));
 	}
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
diff --git a/run-command.c b/run-command.c
index 84b883c213..26154ba257 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1213,7 +1213,7 @@ int start_async(struct async *async)
 	{
 		int err = pthread_create(&async->tid, NULL, run_thread, async);
 		if (err) {
-			error_errno("cannot create thread");
+			error(_("cannot create async thread: %s"), strerror(err));
 			goto error;
 		}
 	}
-- 
2.19.1.647.g708186aaf9

