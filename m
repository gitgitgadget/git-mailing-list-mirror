Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96A671F461
	for <e@80x24.org>; Fri, 19 Jul 2019 23:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbfGSXJY (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 19:09:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37566 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfGSXJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 19:09:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so24484198qkl.4
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99i+L1MaHyEi3yva2pcCTnYL8bEWw7gen/n8t+J7Bcg=;
        b=ia9/gxfWZH7NaLFgMPLquyywyKhwx1tqk7buKrFKJArEcgo13fAGfBAF1jsO5M3jJ4
         sRVSK4xA61EHv8OQt3fqNmTk0nZq3uDwsJowOhDViA3fkhVUV5frvLRp/9BIm1Gop0g3
         ALImoibjqDiOJEaEid4pAfeWd9Bqd1yjqHfVCaVs63zBxuzkF01ywaozhW1J77FaojxJ
         Uamgxp3c187t6LFhoN6LUj/8FnfXDytYHWWWoY+L1dnaNb08N7m3TVkeSyZkrnqJgkn6
         1xiOhJ1NgoDmDjkNzq888oCLhefcLqIH4xm7ZIKRi7t44r7g1bh3unx5lE2oBjM3wz32
         9BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99i+L1MaHyEi3yva2pcCTnYL8bEWw7gen/n8t+J7Bcg=;
        b=Ji8g1qgRoBPFaCrop/mQNqpWAGZ+QG2361vw4+9lT6cFkCZEHPYwHN+PolZIM2o20x
         svLYRhjpNC9Ue6Kz6yBkNuU4yF4vdr6bVcd+X7QdKM/bojsCWlVwZ/4U81KUZAHX0ges
         Eeyb/odSUxTRmu1J0UHGvvXt6F2DwmAIIxhmcQmxFanQe7tE6jU2Nw5EjXmuAvlWlyEG
         mrA/MrpMkvLzJqLjOTfQ3VsLfjeE4SG5Cf5WmW+vzhlijbcCA5ynrjj8Cc6JF63n57u+
         P4EYn9wrGHWOLA3jXzP4SiNnxIDZEZ8SSbCex8/OuhfZ3+5XSHxtpLEeH5iWoEfaTebk
         X28g==
X-Gm-Message-State: APjAAAUCdMi28rE4ijVJ1D9fkkSnCLkoD3Y+Ulk/rDTEJdaLaP8qBEd4
        avIMus3amoH7GudSW4v/+CcrP5pQnKM=
X-Google-Smtp-Source: APXvYqyf53J2L+oQn4Y+0pceRUGmRLlOOzpmGrGJgoWNedcqBMsalxW2NDARFwsTyF/O3+3nY8vxPg==
X-Received: by 2002:a05:620a:632:: with SMTP id 18mr38915489qkv.205.1563577763302;
        Fri, 19 Jul 2019 16:09:23 -0700 (PDT)
Received: from localhost.localdomain ([170.82.202.216])
        by smtp.gmail.com with ESMTPSA id s127sm14469035qkd.107.2019.07.19.16.09.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 16:09:22 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [GSoC][RFC WIP PATCH 2/3] grep: remove locks on object reading operations
Date:   Fri, 19 Jul 2019 20:08:53 -0300
Message-Id: <10005e2838ef3bc219b4a775de522339046db318.1563570204.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563570204.git.matheus.bernardino@usp.br>
References: <cover.1563570204.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-grep has locks around the object reading operations it performs. But
these have an internal lock now, which can be enabled through
enable_obj_read_lock(). So let's use it and drop git-grep's ones.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 18 +++---------------
 grep.c         |  3 ---
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 580fd38f41..682e2461d0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -206,6 +206,7 @@ static void start_threads(struct grep_opt *opt)
 	pthread_cond_init(&cond_write, NULL);
 	pthread_cond_init(&cond_result, NULL);
 	grep_use_locks = 1;
+	enable_obj_read_lock();
 
 	for (i = 0; i < ARRAY_SIZE(todo); i++) {
 		strbuf_init(&todo[i].out, 0);
@@ -263,6 +264,7 @@ static int wait_all(void)
 	pthread_cond_destroy(&cond_write);
 	pthread_cond_destroy(&cond_result);
 	grep_use_locks = 0;
+	disable_obj_read_lock();
 
 	return hit;
 }
@@ -295,16 +297,6 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
-static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
-{
-	void *data;
-
-	grep_read_lock();
-	data = read_object_file(oid, type, size);
-	grep_read_unlock();
-	return data;
-}
-
 static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		     const char *filename, int tree_name_len,
 		     const char *path)
@@ -457,10 +449,8 @@ static int grep_submodule(struct grep_opt *opt,
 
 		object = parse_object_or_die(oid, oid_to_hex(oid));
 
-		grep_read_lock();
 		data = read_object_with_reference(&object->oid, tree_type,
 						  &size, NULL);
-		grep_read_unlock();
 
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&object->oid));
@@ -585,7 +575,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_oid_file(&entry.oid, &type, &size);
+			data = read_object_file(&entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
 				    oid_to_hex(&entry.oid));
@@ -622,10 +612,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		struct strbuf base;
 		int hit, len;
 
-		grep_read_lock();
 		data = read_object_with_reference(&obj->oid, tree_type,
 						  &size, NULL);
-		grep_read_unlock();
 
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
diff --git a/grep.c b/grep.c
index f7c3a5803e..984a9e99cf 100644
--- a/grep.c
+++ b/grep.c
@@ -2109,10 +2109,7 @@ static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
 
-	grep_read_lock();
 	gs->buf = read_object_file(gs->identifier, &type, &gs->size);
-	grep_read_unlock();
-
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
-- 
2.22.0

