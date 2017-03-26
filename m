Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E98320969
	for <e@80x24.org>; Sun, 26 Mar 2017 02:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdCZCnD (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:43:03 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36271 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZCnC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:43:02 -0400
Received: by mail-pg0-f65.google.com with SMTP id 81so4658705pgh.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2Gj8JV/SQlZjtT7mInmBke1gAn0+j6zG9Ujlqm4jK8=;
        b=MKNRg7E1t1/xjc9WjlO/L6rzpy9KuzYHq0ymgEommHRfAUYfCINRmQVkwqzpnon7xj
         IAH4yawASBGks+i6QAPCBwVXiT9DlcK3cjUNW61CgNDfA8/H2rt0x2osqlvgTb4dxlb+
         F9YTm6tEimLnFpZOpQXNSzbke/0W1VG3a0y20RrQY+5DAjm7poZwnLNWzR/tMdN5KsP5
         SPv9ucRUNnjr3m9o3/nXL4fQzslQDwjD2o4evCRu6NcccsWNEClraSmePJXP9uxYpoqn
         pThm4x3Vkhfy2IsNrZsg151C0uozAxYjov27k8cQXqWD38ZBIbffxTgu1Nj8Ik+kxz0q
         Z6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2Gj8JV/SQlZjtT7mInmBke1gAn0+j6zG9Ujlqm4jK8=;
        b=fsLkW/vUt97cFbZJMgcYmVbiRIybXqdV6PBqimjJP27MOU/Bo3H2cL5Briqx6Ugd1T
         RT0kjTZpX9HiGRsk/L9pa/LW9BitxjBzntQlMAKWD77VCTIyfIEAIUd5TuwfS06QOUlz
         Xeyn101jEZv0q6FiIvH91ka/ZzCcW9Fg6TNTJ/ZQ1QxCLAhEgwJ6sm9DKhLRJPstFUyN
         KOJWwwUn5kde8bgafg8/ls6aCIzuLIksZ+vxZ1nY0MkVrL0TXtx+GWDadL3EaWh14vwB
         EYlvke9uATWIwoOpUSRahuxMicVZ41Rz01vEgo1bW1z9HzZ0hNqKxq0pW/JDtcnI3RXs
         WVfQ==
X-Gm-Message-State: AFeK/H0n5ZrZfrpxjpQox065FIcMKXmZWYDD4GWO+8mLXOSlqT4eNfiQxBQhqIsRqO6E3A==
X-Received: by 10.99.246.83 with SMTP id u19mr16968356pgj.205.1490496181517;
        Sat, 25 Mar 2017 19:43:01 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id f81sm12823239pfe.61.2017.03.25.19.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:43:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:42:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 02/28] files-backend: make files_log_ref_write() static
Date:   Sun, 26 Mar 2017 09:42:15 +0700
Message-Id: <20170326024241.31984-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
but probably never used outside refs-internal.c

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 9 ++++++---
 refs/refs-internal.h | 4 ----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50188e92f9..42c0cc14f3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
+static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			       const unsigned char *new_sha1, const char *msg,
+			       int flags, struct strbuf *err);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2831,9 +2834,9 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err)
+static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			       const unsigned char *new_sha1, const char *msg,
+			       int flags, struct strbuf *err)
 {
 	int logfd, result;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa93c9a32e..f732473e1d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -228,10 +228,6 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err);
-
 /*
  * Check for entries in extras that are within the specified
  * directory, where dirname is a reference directory name including
-- 
2.11.0.157.gd943d85

