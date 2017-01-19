Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5520E1F89C
	for <e@80x24.org>; Thu, 19 Jan 2017 03:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbdASDTI (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 22:19:08 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33689 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdASDTE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 22:19:04 -0500
Received: by mail-pg0-f51.google.com with SMTP id 204so9947523pge.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 19:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeF0Vdb6h/jxGcdgSUDB17d/ff2D7q+4md2lfbNGjlM=;
        b=l4K2zyZ/NI6Hv3veEf4/3EQeExOzqJGEwpZfsj0OMLETRjzGBy/MVqMv0ToV6rH7mp
         IUMslsUvSY/4VjPkJ6/0q2Ncqp+s0Yiia526IgSKmddCJBOVAIevfWETeX8MUcASsCaK
         kPkxs/dJjfypilD9eGvdB6LQB8MtH6xWicJ1bWE/Ya4zX5OWgbUigximSIR2woCbCBZ1
         DWpFtR0jXlRDRsa4pWHnlFL5CXs9HTQvyC6J4w9KRy19pEebWvXHaM69K6Bxat3kByMe
         I6Yndn5UMDpsAuMwdUbo+AbxSWAevPKaJ/PVvS8zY6YZHOXnG98xaIxX8zS5yMZU350s
         X+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeF0Vdb6h/jxGcdgSUDB17d/ff2D7q+4md2lfbNGjlM=;
        b=iONr6Ru5XOiqM53faLEmOwcNHsUCDu3p9YExNhBvaniCDcMQ/gjxQKd4fUQejq25LD
         fobXqI4aRqarTX0b3B7UZdmNdeaLwtPtaxYcD2A1Lq1R3PxOcBodTvTHmk5X4Lcu947X
         PLnAAd2wvXe8/pDppSv/F1TbPSaqJCdzfrrBVA17Z67OIkjXAoLbGQ3Wb813LaPJzlaD
         ntJava+hRUlqtiZV+4he4u4xkAMprFYYpGEqTyOkYz9K7vTJaL/Ndnq2QiBnrbKircYE
         k6KfSMHfqILaWIr2o8hNrpJIlVoMHIeNcOVqBuej9DzVWMjAJTG6Rj6pVxz32xudueOK
         p2aQ==
X-Gm-Message-State: AIkVDXLPcK21B2ZCksb0BdS9yuOjsa4pu9bNSotyRnF/eL6F0m+USeYlvO0a7avfkutoTkwq
X-Received: by 10.98.34.130 with SMTP id p2mr7408465pfj.11.1484795943309;
        Wed, 18 Jan 2017 19:19:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id b66sm3895448pgc.20.2017.01.18.19.19.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 19:19:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/4] cache.h: document add_[file_]to_index
Date:   Wed, 18 Jan 2017 19:18:53 -0800
Message-Id: <20170119031854.4570-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170119031854.4570-1-sbeller@google.com>
References: <20170118232145.31606-2-sbeller@google.com>
 <20170119031854.4570-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/cache.h b/cache.h
index 929474d7a9..12394eb541 100644
--- a/cache.h
+++ b/cache.h
@@ -614,8 +614,18 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+/*
+ * These two are used to add the contents of the file at path
+ * to the index, marking the working tree up-to-date by storing
+ * the cached stat info in the resulting cache entry.  A caller
+ * that has already run lstat(2) on the path can call
+ * add_to_index(), and all others can call add_file_to_index();
+ * the latter will do necessary lstat(2) internally before
+ * calling the former.
+ */
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
+
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
-- 
2.11.0.299.g762782ba8a

