Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92F41F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeCCLhv (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33343 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeCCLhv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:51 -0500
Received: by mail-pg0-f67.google.com with SMTP id g12so4870172pgs.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ensloDOURfJkWUL+nHffZ1qAUgGXqw4QfbQKVaDY1Bg=;
        b=dY2Meubop4Hc3h0lPXPxvt/gmQRl+hD8Xny694EIH9FeBO0NyzcyJnSNxanrSzC6mY
         HnUWX/QB0jUKIQrNcUun59HiR4R81PXEPjleWwCaoR831y+/s404rtSNKsnmtPmUrikx
         UVa/rjWQM8J3yDwUmkfDBFu8ZtFWBDpp6vlqNpOlUTPsvMwGXiVy5ITFBJcwATiP3BJ1
         zXTYFqGWXX+UUuYxKrZNyzxWtWV2vaKAMv62r+zQYZcpU6K01wVnKDZsersXKt0OTYa7
         pcOUclT7q++tULcBHnj0uMpdOWhgFEKx4m9gF4RRtajNWLTgwiBA3vYzD/LXgSHYWaop
         2zWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ensloDOURfJkWUL+nHffZ1qAUgGXqw4QfbQKVaDY1Bg=;
        b=TmfYKlR5xNLEOOhfJxXof5TB+DQQpdZN808vQ1Kkmy4v6QIk1qtdM9qvQtmPeboHQX
         7YJetdSg6L/bWVOEeq0XPXRbKKR3rQN3mSsV0K12LsYKCH2fotBI6naT1L6jLOA/L7cI
         jlFr1jidTF3h/Xd10eDifrUJeBP5sJzHZT5YHNTJwvUZ3jcBtgIEMjFy6TXgws6+Xrq1
         5/YHXtgqxikgko7JsZfBfYpC5+J2OJt5h393mTxgZPj12M3vkugzM2So0k6VR0u+GUFK
         6HAVEkdawS5ixZsUtxMmtB+65XEfDbjRqBik8MsnVLBB3iInqkJvGXvehODMXNo0jpYE
         NYJA==
X-Gm-Message-State: APf1xPAxPHoTGdMI2fD+lKZjEfm8saHZtGojd/w+cVV24pxnDdojYZ7U
        vmTtbSI2dSgXYvfE4ur1bmAm0w==
X-Google-Smtp-Source: AG47ELus/89Ka+5nFHj0+RIm620jOhggDdEwgi1Dz1BP6L/3mBy/GJeskV087sPBwaIlBns1UflOnw==
X-Received: by 10.101.81.8 with SMTP id f8mr6967113pgq.13.1520077070361;
        Sat, 03 Mar 2018 03:37:50 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id i186sm17780765pfg.25.2018.03.03.03.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/44] pack: move approximate object count to object store
Date:   Sat,  3 Mar 2018 18:36:06 +0700
Message-Id: <20180303113637.26518-14-pclouds@gmail.com>
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

The approximate_object_count() function maintains a rough count of
objects in a repository to estimate how long object name abbreviates
should be.  Object names are scoped to a repository and the
appropriate length may differ by repository, so the object count
should not be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h |  8 ++++++++
 packfile.c     | 11 +++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/object-store.h b/object-store.h
index b954396615..56ed4bd9e9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -93,6 +93,14 @@ struct raw_object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
 	/*
 	 * Whether packed_git has already been populated with this repository's
 	 * packs.
diff --git a/packfile.c b/packfile.c
index caeab0f68c..ce4cd7d5c9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -802,8 +802,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -813,8 +811,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects.approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -824,8 +822,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects.approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects.approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -900,7 +899,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.16.1.435.g8f24da2e1a

