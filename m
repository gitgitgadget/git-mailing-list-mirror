Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218F420248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfC3LUc (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:20:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34175 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbfC3LUb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so2443530pgq.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Hh1qjhIYgsEJ1RAvKb6URhIj4fZF8d7gLklPr6lwvk=;
        b=UGijZ6CVxz6Pv/Sf5AsB9sx6vY05vsBWB2NqyxQ9EbnM/BojiLWozYJe1P+uACon9c
         /qPVzp4LZNycO25CJZVLEJg8QPeaKYlJMynfLIDlY21/TZrnF87x/SQQ5UCJ4oyCMaKV
         M8kI61w3+BSk9awPr56CbBK3IBoeFD05JkfmQ/+bN7zJSQMKrsyHeF7GQ4oEdCHJbgJQ
         ufocfZMXNZ2tABqB7EsONnr8sEeFTu7QK5FF6AUEuGWlzYNEcVeD71Mlq/kg4oBlWVyg
         eVJT+Y+r9Auu2RqAck58Hvbx3PdxcSzfj+Z67q0BNZpzdQQfnTMqPqkZ5fMMmt9olI/y
         hXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Hh1qjhIYgsEJ1RAvKb6URhIj4fZF8d7gLklPr6lwvk=;
        b=bJ8MqUONjpYXg8KNZvfyYLDL/MJUGjgV9vcOGXiiVq2WT2mJOcVC2T7drAoNbB0cDr
         9WUHaeVwOIcXV2RqnGk/YyNshGG6D3sFhhBej0GCHRXHubf2Vkc6dK//Tb0kA3P02jpD
         OtkFPYeR0vpaPT0E///LRTiOHOD/Yug3X/o+sacQ1WZQGj0zUFFWIk9PUaHO7js9bTFB
         srtCYTKH8ccMtbC9x9U6jDeH2vnlq+tii9u8JfF2gQV79tKQOdcpIthmerQp34YFBCff
         0PNkykLzkOJz+8SeCX+q5IEl93IFacHLS/qYGRO3uBYVkoWRhDv0mTnxYhVQqJLnX5U0
         Bqjg==
X-Gm-Message-State: APjAAAWs4iZBTpYnGzC+9U8tk3nTt5naC1E/+7OVbOPTCmD3g12py7fu
        XLIkxr418l2cLDJjapO00WMFoKQj
X-Google-Smtp-Source: APXvYqxvGj7G//lRSm0/a3lO3df3+K8826rky0SjtC1C2sx+tQUtqsp4mUWe//DaxKy6s1sgx2kLWA==
X-Received: by 2002:a62:2fc4:: with SMTP id v187mr54080582pfv.147.1553944830651;
        Sat, 30 Mar 2019 04:20:30 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id 10sm6973775pft.83.2019.03.30.04.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:20:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/31] packfile.c: add repo_approximate_object_count()
Date:   Sat, 30 Mar 2019 18:18:57 +0700
Message-Id: <20190330111927.18645-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 14 +++++++-------
 packfile.h |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/packfile.c b/packfile.c
index 16bcb75262..2ad4fab2f8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -893,25 +893,25 @@ static void prepare_packed_git(struct repository *r);
  * all unreachable objects about to be pruned, in which case they're not really
  * interesting as a measure of repo size in the first place.
  */
-unsigned long approximate_object_count(void)
+unsigned long repo_approximate_object_count(struct repository *r)
 {
-	if (!the_repository->objects->approximate_object_count_valid) {
+	if (!r->objects->approximate_object_count_valid) {
 		unsigned long count;
 		struct multi_pack_index *m;
 		struct packed_git *p;
 
-		prepare_packed_git(the_repository);
+		prepare_packed_git(r);
 		count = 0;
-		for (m = get_multi_pack_index(the_repository); m; m = m->next)
+		for (m = get_multi_pack_index(r); m; m = m->next)
 			count += m->num_objects;
-		for (p = the_repository->objects->packed_git; p; p = p->next) {
+		for (p = r->objects->packed_git; p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
 		}
-		the_repository->objects->approximate_object_count = count;
+		r->objects->approximate_object_count = count;
 	}
-	return the_repository->objects->approximate_object_count;
+	return r->objects->approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
diff --git a/packfile.h b/packfile.h
index d70c6d9afb..f04440f984 100644
--- a/packfile.h
+++ b/packfile.h
@@ -57,7 +57,8 @@ struct packed_git *get_all_packs(struct repository *r);
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.
  */
-unsigned long approximate_object_count(void);
+unsigned long repo_approximate_object_count(struct repository *r);
+#define approximate_object_count() repo_approximate_object_count(the_repository)
 
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
-- 
2.21.0.479.g47ac719cd3

