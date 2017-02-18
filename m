Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A092B201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbdBRNd0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:33:26 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34929 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbdBRNdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:33:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so157649pgz.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmRuWvfsI/Ve1eoimZTaQp8gb0ES5zkmWZNNtH8PVaY=;
        b=Gl+nGFslm+EtHw89gLt0eKkUpFj42kq1BbS17/w2Q1JesymLEfI2rNx7OjHnzP3we+
         JzMxNEgRzWaGEZ8RfKzZQd4om9aYkOYO5GsPXTtZgzJHs9zOmdvOzNG1zahVCtjmb/gr
         vwBZt4qV5NgwlX6wolGYltQrCJAOvMe2LqtfSsYDKfBF83NLyNyiT2Th+G9tpBGNT6cq
         yu7UrWUgnm46mXwStEYdVVG0FZiaFZwTfy57pl1WooexJHPefYXBJj+qIZ31YOGa9D/d
         j6nRzoShjyG4yak2oSwoqQ7HUGg0S/diV43KTRJeP3cuzXk0vGzJFnwxfas2bykHFpGc
         PheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmRuWvfsI/Ve1eoimZTaQp8gb0ES5zkmWZNNtH8PVaY=;
        b=qrjhhAn/lhBef9PD7jJ16S0Nrc4Jz2cLCC0AU+U8UOPAXQZ4OMkFYKW8Cvi/LQXjaO
         n1g4azWOOMVGgOjVBKvB8tnf22OKKmGBu4lKoQoybepg3Sqg5qKmh1HWbVwqjhgL6wna
         eFZ4e1dcdMUJUPStaL1BqDIgNfuMV2bIdK836kH7iJNKsqCbsG0n70Pm0ZFpv4rHJTAJ
         TF8wJK7NLk2xSDhVBTVusUbEkUY5nK9mcIlOOjpaUfld44LLpJgLJ3bmbse5+0Bm0VMY
         iwJ8E9LV5yHG8SeqFRz7wmNQMZ8/ZPlAMib3ie35GvwOA5nEjwXKYwVlGAQXdvHZHU0V
         160Q==
X-Gm-Message-State: AMke39l+i3wfFWFz1Xy+v775tBpmqT9Ap9ky4lJC8xzcgniwKvMrGik9rtQvK7NfXZw1QA==
X-Received: by 10.84.129.132 with SMTP id b4mr18209441plb.54.1487424805003;
        Sat, 18 Feb 2017 05:33:25 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id g2sm6347364pfg.105.2017.02.18.05.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:33:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:33:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 01/15] refs-internal.c: make files_log_ref_write() static
Date:   Sat, 18 Feb 2017 20:32:49 +0700
Message-Id: <20170218133303.3682-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
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
 refs/files-backend.c | 3 +++
 refs/refs-internal.h | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index db3bd42a9..1ebd59ec0 100644
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
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa93c9a32..f732473e1 100644
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

