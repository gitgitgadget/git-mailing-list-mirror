Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713B41F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeCCLkG (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:40:06 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39926 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbeCCLkE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:40:04 -0500
Received: by mail-pl0-f68.google.com with SMTP id s13-v6so7191132plq.6
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4wPCejp1vO1FY06i/KLbjMI08tv0RQ7QSeLVkOaOZg=;
        b=rnGKZwWQn0YOsFp5YhNV2ne/+3knoIxU+dJUPKAnPPyehb8KftsRwOUOW2ZohCgdUx
         xLwqoOFQ/WDFT9mtMxkL+y/ZqG9ytnCwCWvjoSF4QiRqXrO3M2LkydNO6k03+Bs477oc
         p3y5Fww7kWrCq7BEUx35g4nBT4nd5LwXVXLQow3+GZoh77FXz3g8c7Xmq1eCTnfbLZ8o
         DYR8VimNJoGu2QnSJyFSsjGYWMTXTivPbViExuJ8EaqhI1Diqci1zCC80oanW1IvHmJZ
         xh7nB2W/3pHaZfuEnmqpPEHmnQ3bipdYLKdexGYPpY0ZSLXA3LWHm+0BX3DblAYHRJna
         c3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4wPCejp1vO1FY06i/KLbjMI08tv0RQ7QSeLVkOaOZg=;
        b=UB4WFk/KxftXBwPIJw5wli97fba92lUy7l+jAv86rMfVNGhAikCymYwphgx19vtdW+
         tgv34f6WmyIuIZMHvzmcLabNwhwi0FQrbgfN2tPB6I+sI9qMpy8CfVc+dGbD4qe1t3Ki
         0gjPBwh21DHc5cJ2yRUZ8STs8SanwcZyd+io0jsWGth4WAPfAHxgb97wpF4HTazxE7y9
         MkSY8RI7B/YWK5ma2PpuS8/iLEXgwz6TuWwDO94gxMjMqKrOKrza8wMvc9vYZqX4Cnvg
         eflRpwe8wanhYqfiXlmpcBqiRBE8P0DiR+OawmLTyXW8BL+5TRltHTs6cs1A+nOca6dS
         4xfA==
X-Gm-Message-State: APf1xPA03g6wuOgwkZ0ENVNb9dEGUZJB7gz7CxjaW507yZbgaCEvo2Yg
        zndZoAMLfEDMyJVeP2lVQyjv2A==
X-Google-Smtp-Source: AG47ELvRfw2uU91dIUrOXc/gKP01BJw/+QVpkvTur/oHrRTDamITfF0SJ8MlxGkCDwlQhJc08ykQcw==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12-v6mr7849858plt.363.1520077204157;
        Sat, 03 Mar 2018 03:40:04 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id h15sm15867808pfi.56.2018.03.03.03.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:40:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 40/44] packfile: allow prepare_packed_git to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:33 +0700
Message-Id: <20180303113637.26518-41-pclouds@gmail.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 18 +++++++++---------
 packfile.h |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index 52febba932..2276e2ad26 100644
--- a/packfile.c
+++ b/packfile.c
@@ -882,19 +882,19 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
-void prepare_packed_git_the_repository(void)
+void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
-	if (the_repository->objects.packed_git_initialized)
+	if (r->objects.packed_git_initialized)
 		return;
-	prepare_packed_git_one(the_repository, get_object_directory(), 1);
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(the_repository, alt->path, 0);
-	rearrange_packed_git(the_repository);
-	prepare_packed_git_mru(the_repository);
-	the_repository->objects.packed_git_initialized = 1;
+	prepare_packed_git_one(r, get_object_directory(), 1);
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(r, alt->path, 0);
+	rearrange_packed_git(r);
+	prepare_packed_git_mru(r);
+	r->objects.packed_git_initialized = 1;
 }
 
 void reprepare_packed_git_the_repository(void)
diff --git a/packfile.h b/packfile.h
index ab5046938c..3fd9092472 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,8 +34,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-#define prepare_packed_git(r) prepare_packed_git_##r()
-extern void prepare_packed_git_the_repository(void);
+extern void prepare_packed_git(struct repository *r);
 #define reprepare_packed_git(r) reprepare_packed_git_##r()
 extern void reprepare_packed_git_the_repository(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
-- 
2.16.1.435.g8f24da2e1a

