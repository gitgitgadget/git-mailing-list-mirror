Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013A51F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeCCLkL (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:40:11 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37721 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeCCLkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:40:09 -0500
Received: by mail-pg0-f65.google.com with SMTP id y26so4869829pgv.4
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u93NYINk0dEmrGI73wQT/Gb0FMMYy/NORImMO0N/AAI=;
        b=ldHU2Bz4W4HUeBM10cyud3h9yP/z2XhpQBMOlW/xj0WCl0LDjcbeeSFqQHtzg2oiVh
         pjrlKTcaaxm77g2Mja80i4z2/otBMv+mOEjqIjbSD2LI3M0REIGoxJh/kK8Fdi1sLweJ
         kUEfQ/VuFDgF18xVVLKXjk+Cwyasi1dT4I3epq7xdPsCKCdlscYWg3gtpoRQhbQCaA0+
         XXkXDL0JPQk0ewxOsJoi7wZi6juqL9k3peqCjsJJ6g8AwaINybNXVRWQLJbsJe8WOmMg
         JeSoVk4XrmIu4CvXoKn4WZSMD4GMZJhK0L1T8h6yXO3nmoQOltn71vgHMKh9WoHEPC7b
         ALXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u93NYINk0dEmrGI73wQT/Gb0FMMYy/NORImMO0N/AAI=;
        b=PwthpONWw1nopHfb5nZwIYkvpD2Bq1f/45Z50dywSivEJdmmO6bVeMrvkWknx5M37W
         fQ3FrelCcOvAAHo9wCh0vZeM3NNPmft+UG6fX3DxFK9QRjHVVUdzi3N11DAcxuJXObgh
         R33/V8ZOuVDaXiQw7wwc09fczKNHyHYwNjBFtEe/VeyEl1pMgr4noMExhlLf/NEpXJ0t
         VtdjiwI2hEFdV0ajWf3paKm+emDk5YHgegEwvuywjPL/8JspDbwhRlNJJYbovLQtde55
         O4rj2PM+k7EgeNXMgv+A+bqUOcKPbOAD6Z+u+VduP820uFP7Zb2+z6nNcON7jXIbg7QA
         lf0g==
X-Gm-Message-State: APf1xPDAdtR8grRdCX0fKNxhGWwbdPBjyaKmBE44FMuDmjRhUWs8XHFf
        NbOPZGB6HpAQ6bnQfBKYduTc8g==
X-Google-Smtp-Source: AG47ELtQbVsJFU29eiufX0N5pt8EZGiswUKZuhYvQiyqHTKbSqZR2JIrUvBrbyaxsntg/jfCY49o+Q==
X-Received: by 10.99.141.200 with SMTP id z191mr6979408pgd.418.1520077208871;
        Sat, 03 Mar 2018 03:40:08 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id j23sm3782458pfi.78.2018.03.03.03.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:40:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:40:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 41/44] packfile: allow reprepare_packed_git to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:34 +0700
Message-Id: <20180303113637.26518-42-pclouds@gmail.com>
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
 packfile.c | 8 ++++----
 packfile.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 2276e2ad26..fbf5d56754 100644
--- a/packfile.c
+++ b/packfile.c
@@ -897,11 +897,11 @@ void prepare_packed_git(struct repository *r)
 	r->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git_the_repository(void)
+void reprepare_packed_git(struct repository *r)
 {
-	the_repository->objects.approximate_object_count_valid = 0;
-	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git(the_repository);
+	r->objects.approximate_object_count_valid = 0;
+	r->objects.packed_git_initialized = 0;
+	prepare_packed_git(r);
 }
 
 struct packed_git *get_packed_git(struct repository *r)
diff --git a/packfile.h b/packfile.h
index 3fd9092472..ee6da3a9ae 100644
--- a/packfile.h
+++ b/packfile.h
@@ -35,8 +35,7 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(struct repository *r);
-#define reprepare_packed_git(r) reprepare_packed_git_##r()
-extern void reprepare_packed_git_the_repository(void);
+extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
-- 
2.16.1.435.g8f24da2e1a

