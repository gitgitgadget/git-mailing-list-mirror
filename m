Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387061F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeCCLkP (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:40:15 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40376 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeCCLkO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:40:14 -0500
Received: by mail-pg0-f66.google.com with SMTP id g8so213742pgv.7
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaXDfUUZlXRTwfP9tRQlBKWxUoA0RH2YglWQEfULoDA=;
        b=nrb60xidtq10WPTSXHwmbSPttW1ZSyz+jAQtrKfqTWnLd/U03VQanCQneh6RfxCLiN
         2q3gNCrFFkB3kdSwcPriYfxvQ6uxHfo9TUnsItXKgoJ7guHowIKpmhaEL/Kib8JKP5Rl
         vYH9mIb0H4o49CZnbgsTfPWSij0kvXHzEanNcbwDLdmGaDR7dqiKdlnk6C2df77vYnMb
         PfK2BvINSNYaJjzuSE+OYEfRGy11Qb5qb6XvVhGIwVovKCJwawi0j9/b1VPCNC6hUbjr
         N7PS1YZOoSM/YF3Q50HBrDBAY77G2UlCroMI95qoXjFIsAirek43K9cx7JMn6iTxOJWg
         YJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CaXDfUUZlXRTwfP9tRQlBKWxUoA0RH2YglWQEfULoDA=;
        b=UJiaCPYoqeaJHSviGHtM7/Sgu6jNpDCt621CU332NhQM6nw8JyKtbB9HeM/FDv6WNg
         x1XqtVCZONRQGUAOiwthy2bDhjFy8fKp3hxuf6cMz+ey9HSBmUcY20UgsvN5QLbkqgSG
         i4fVcI8W50WjbgyxsuRXN+GQn2HOGatC9GHwMKQAjjTAyp39VrYYkvZN/amA4q7Vnjrr
         0a4a+/5i/bi2jG8qCQ4HpOiQM/zVPUtXq3xn1/e2QkuL+/rJCCF2dNoFdg58QUw5vNSU
         H1epwWh+dy4C7W4fF75G9x5o0iGUAHxwgqViGShS+NFz/bvhsE2ihSq3QbuNoTXljRH0
         PXaA==
X-Gm-Message-State: APf1xPDApmQTRZaG6xo+K0uvVLBg57u44r2HYdYsyaY1eKwBAOPPpNTm
        IB8pXzLt3PLU66WvzOP1BAPuCg==
X-Google-Smtp-Source: AG47ELsy1n9D7nQ6HXutp5tAsdhSBOD9gxW6sLEWoeD1W7n0Kw9F+mLD52UAZsI83BjkbZ5g/ExDfg==
X-Received: by 10.98.12.149 with SMTP id 21mr8842838pfm.118.1520077213663;
        Sat, 03 Mar 2018 03:40:13 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id i4sm18799531pfa.40.2018.03.03.03.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:40:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:40:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 42/44] packfile: add repository argument to find_pack_entry
Date:   Sat,  3 Mar 2018 18:36:35 +0700
Message-Id: <20180303113637.26518-43-pclouds@gmail.com>
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

While at it move the documentation to the header and mention which pack
files are searched.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c  | 8 ++------
 packfile.h  | 7 ++++++-
 sha1_file.c | 6 +++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index fbf5d56754..7388debbb2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1844,11 +1844,7 @@ static int fill_pack_entry(const unsigned char *sha1,
 	return 1;
 }
 
-/*
- * Iff a pack file contains the object named by sha1, return true and
- * store its location to e.
- */
-int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
+int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct list_head *pos;
 
@@ -1870,7 +1866,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 int has_sha1_pack(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e);
+	return find_pack_entry(the_repository, sha1, &e);
 }
 
 int has_pack_index(const unsigned char *sha1)
diff --git a/packfile.h b/packfile.h
index ee6da3a9ae..e68f790ea7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -123,7 +123,12 @@ extern int packed_object_info(struct packed_git *pack, off_t offset, struct obje
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
-extern int find_pack_entry(const unsigned char *sha1, struct pack_entry *e);
+/*
+ * Iff a pack file in the given repository contains the object named by sha1,
+ * return true and store its location to e.
+ */
+#define find_pack_entry(r, s, e) find_pack_entry_##r(s, e)
+extern int find_pack_entry_the_repository(const unsigned char *sha1, struct pack_entry *e);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 
diff --git a/sha1_file.c b/sha1_file.c
index be84f84373..ba47963e63 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1266,7 +1266,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	}
 
 	while (1) {
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(the_repository, real, &e))
 			break;
 
 		/* Most likely it's a loose object. */
@@ -1275,7 +1275,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git(the_repository);
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(the_repository, real, &e))
 			break;
 
 		/* Check if it is a missing object */
@@ -1655,7 +1655,7 @@ static int freshen_loose_object(const unsigned char *sha1)
 static int freshen_packed_object(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	if (!find_pack_entry(sha1, &e))
+	if (!find_pack_entry(the_repository, sha1, &e))
 		return 0;
 	if (e.p->freshened)
 		return 1;
-- 
2.16.1.435.g8f24da2e1a

