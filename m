Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7511F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeJ0PuT (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42672 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeJ0PuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id f3-v6so3165380ljk.9
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34AlMYInjUJvKBJ83Ba7wlLqRcceLi+ycsU6IviV8ho=;
        b=rgfgzMCZJLmM/Cp/LqUuJ5PgDmYBXj4bD4jTIh4+2DVkFmTaNpQYahiyfI99vHf92L
         +PIjSZHYXh1/OIOOfhSVJ4fZabipj9C9d3DpXHoAzdFm23Qdb6LYVPC0Zq5kyoShrNt+
         pUnGuXm+r7Gm5fH3ef3WwqV8tFAi9izvRAwjFYAt1SzQcn9tSpBINHJPG2unfsEw0WxT
         biizS3VReKTLErYHd8VxfAlFH9x3h67h41XLOKTC0eYnchZreq79/lfi+gJ9/VXjMnSM
         XFL2k1kBHgvoS9miDVvWEPZfQm+EXNodspgc+FOrpVRoeqnlFrQPT8UCJZ8iOaKpo+Nk
         NQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34AlMYInjUJvKBJ83Ba7wlLqRcceLi+ycsU6IviV8ho=;
        b=N/KqHa4accu7yi/X1hQO+EZpQfjEvB9GAN1sevJyRX4G1nxcOUrQyaF9N2JkT20ejY
         eYjkSvv43K0tnnCRLNGwdYoR06U9f+XjQ/naTKyj3ObWiEjyXKqsJKicDP3CoDd1JxSz
         EGNQzFitdJseKZq0BEfQ+Jc4ZsEkae4zRN70OfJBCrXW7iltO8QtWLDd/JGCWF+4l0za
         UCZ1TKOK03kfVyX14ebJjGIPHDK/B+qSvJgy8QY1pG26sWxAsdAlVXuxXOv276GZ0Q05
         JwxjNEKJj+55Otn73IgCxkc84GvUjUwnRJy0DlvK2amUQ8rA/WCx2bPXoZTcEil8yy6m
         Gv/w==
X-Gm-Message-State: AGRZ1gLFOH5DwrwaD3Yo9FFI+GUtWA1pGTHExObX96r8+v4+H1oie3Fz
        8r+9M7ri+rKwyGe0prEvbdaqIVyp
X-Google-Smtp-Source: AJdET5dB+laE+wme4gPJcZjsOZnEB1gOn/7sk0YoH+3S+kU/G0iXWSUw10EHEQhlPuRvclIQgqqy8g==
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr3321555ljb.153.1540624217396;
        Sat, 27 Oct 2018 00:10:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/10] preload-index.c: remove #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:10:00 +0200
Message-Id: <20181027071003.1347-8-pclouds@gmail.com>
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
 preload-index.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index 9e7152ab14..0e24886aca 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -7,17 +7,7 @@
 #include "fsmonitor.h"
 #include "config.h"
 #include "progress.h"
-
-#ifdef NO_PTHREADS
-static void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec,
-			  unsigned int refresh_flags)
-{
-	; /* nothing */
-}
-#else
-
-#include <pthread.h>
+#include "thread-utils.h"
 
 /*
  * Mostly randomly chosen maximum thread counts: we
@@ -108,7 +98,7 @@ static void preload_index(struct index_state *index,
 	struct thread_data data[MAX_PARALLEL];
 	struct progress_data pd;
 
-	if (!core_preload_index)
+	if (!HAVE_THREADS || !core_preload_index)
 		return;
 
 	threads = index->cache_nr / THREAD_COST;
@@ -151,7 +141,6 @@ static void preload_index(struct index_state *index,
 
 	trace_performance_leave("preload index");
 }
-#endif
 
 int read_index_preload(struct index_state *index,
 		       const struct pathspec *pathspec,
-- 
2.19.1.647.g708186aaf9

