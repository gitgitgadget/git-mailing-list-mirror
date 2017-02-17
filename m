Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE20120136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934090AbdBQOFE (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:05:04 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34894 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbdBQOFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:05:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id y6so3937977pgy.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo3vDQk7f011U6wKVRvDwPig6hJtnp6rHHRthhhM0E0=;
        b=db2SP8BTkI/wcrLscybQybb1IwdAtcgxuJAaR+52124VSnPPbrSMVgS4jitK3jg+lA
         WVdyIFY839eAlM5cwU03cX49x7ac42ThmhPQhLDT2HMfk/NpYlnazWe+8j2lasHxjdwZ
         BCUEo1SGqL4TiWfp6Q7JYdGjvoaoeGyfsYSBgZj0eiZYLeD0GVJlBAg+LWLj2ctYr0h6
         F0xoPNDMKbhXwCWfHxI+X1qzRpMryxF/cqWpmGJjfw/yTkMkEv56cm7N9JlpTIAasKXE
         uYSCSQLL/h3VKonHZdf7DEkDEzergVfJblNABIhwrZ1DukoOI1pVm0+qXx0W62/QHWRe
         WHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo3vDQk7f011U6wKVRvDwPig6hJtnp6rHHRthhhM0E0=;
        b=DTWRgdIjKX0z8BVY9Y6Jg2uBOUaVOlWjRPIKEDp+6v9jVLMZuzshFoKlEOdSCVXfjz
         O7IMU7XV/qNIzUr2QFD0PGwzUW4uYpCpDJZQ7xNtwj82jwqRayZAEw9Ixs4z8rbfZYqb
         PRYL9lnKEmqoEvKY03e/WaAsaAlyjgLkDDMFjpFglH1OeGaH59NyTa6XjvbqPbQT1vfO
         Tv/tHnlJI2P+NUq4hBnG2b27UGm1+OuVE8+E2pTFEkUEePJh8ZgQXt59sMv6K8UHyzWn
         RoVGqny0M2tP0rx8IUAkszHU9eZ60JLKWT68s2ayGPR1dcAeMUbJVcU96Y9KIyyzdlLi
         0xOg==
X-Gm-Message-State: AMke39lJYwPIbiLo/dreVeNR4AAkMitdxXzAluDVxq6/1PYnUAbEAk4UpvPfXTRTmbvDBQ==
X-Received: by 10.99.172.88 with SMTP id z24mr6383381pgn.12.1487340300834;
        Fri, 17 Feb 2017 06:05:00 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t185sm20124902pgb.32.2017.02.17.06.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:05:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:04:55 +0700
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
Subject: [PATCH v3 01/16] refs-internal.c: make files_log_ref_write() static
Date:   Fri, 17 Feb 2017 21:04:21 +0700
Message-Id: <20170217140436.17336-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
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
index cdb6b8ff5..75565c3aa 100644
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
index 33adbf93b..59e65958a 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -222,10 +222,6 @@ struct ref_transaction {
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

