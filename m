Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE4E20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCLhj (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32989 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCLhj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so8022482pfd.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKjJIvSfH8MGf6h4/kuMUZwGHNx2sxD8tRhAQUc8aZA=;
        b=klwp09bGu5XuUgu9xXjUMXoNR0wnvh/7Z8aodbTsRg1xHc88Cf7R+JdvX6nEYT33DH
         sMg3Kf42BdFIVLfyOzkzB6RtlZduJfLWO4cYqGlN/daPY1RYidJRYkNEckZppHthYDv4
         OTHHxfMpzwu10tCGjCji510DoWFEqfMIsc2UZGTaRA9b/JVKElOA3xLhjUujdYejaG7M
         Sfy/B/ZhUoiXQQVwvHDI8e2VJ30xByzVecr+ivOGLIHVcpTIMHXxmh7c4kxg2sTyMxoU
         dXMOtyxXkV5x4sn1104xSt+IRGh+zUqBq4yXwC6qnGUNbgR6ULaOo3J5NyWZ0CzvkVCI
         ck4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKjJIvSfH8MGf6h4/kuMUZwGHNx2sxD8tRhAQUc8aZA=;
        b=e7ZIvVKtYMy6sSN52g1vyGmO4nbbFzumhhhfdWMt+8r36Pb4pjf2YWjyFfjE/EuA9C
         kRoiCeb52ey/HhsKZKImDhd3FwjSdKxnl+UpRUbwjHhylsvO7dKGK60FqBotTDMQhETG
         VVk7G2f1UFn/izm6wkHu1d09U1u2eCeT9P6sDO+aRfxR4HHvme0V5AU03OOg3bxMUaWH
         xhKUD/3KIaQMW9/UZRSxtaImzL0HuAR3FcBy9uLaVxv58/n7RTyaHCq9TdvmrR7JnU32
         izcJn3x2MBE6IIChBpik4NmAc5OTC/R8kFrqihA0CY7hDrDDaFjswEr//ZfuIK8C7Heu
         AXTQ==
X-Gm-Message-State: APjAAAWeer+iSUAm6WZTzB4GVFea/w91IwG0EkWlOwtEZUNlS/TxRMNu
        MDR0fujR9Df7W2//LlRVphEad/Bu
X-Google-Smtp-Source: APXvYqxaLxgx+E5rYmgQjNp8jTcHhZi29jAPue5QfKOVv50NPmw7mLMip4stn5MfwMDgVz5aqxn9Ew==
X-Received: by 2002:a63:6cc7:: with SMTP id h190mr39345609pgc.350.1554291458966;
        Wed, 03 Apr 2019 04:37:38 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id e184sm24525887pfc.143.2019.04.03.04.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:38 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:37:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 28/32] sha1-name.c: add repo_get_oid()
Date:   Wed,  3 Apr 2019 18:34:53 +0700
Message-Id: <20190403113457.20399-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     | 3 ++-
 sha1-name.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2149dc4f56..f6e87194d0 100644
--- a/cache.h
+++ b/cache.h
@@ -1380,7 +1380,8 @@ enum get_oid_result {
 		       */
 };
 
-extern int get_oid(const char *str, struct object_id *oid);
+int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index 64a50d1291..953df0d692 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1573,10 +1573,10 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
  * This is like "get_oid_basic()", except it allows "object ID expressions",
  * notably "xyz^" for "parent of xyz"
  */
-int get_oid(const char *name, struct object_id *oid)
+int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository, name, 0, oid, &unused);
+	return get_oid_with_context(r, name, 0, oid, &unused);
 }
 
 
-- 
2.21.0.479.g47ac719cd3

