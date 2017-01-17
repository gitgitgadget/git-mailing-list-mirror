Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD1520756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdAQXfR (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:35:17 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34050 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdAQXfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:35:15 -0500
Received: by mail-pf0-f181.google.com with SMTP id e4so27050697pfg.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tm1lXmGMJLM5SVYDIfMqUE0Q/qSMkWx2zGcDO8YQmbo=;
        b=vubkYNCZhbvbUDfI8guOt8Nh/72DAlAxcdsgFMWyT4jyvXRh16EkxExJp8pabQDVyK
         qojKtYDuUgtBlS/FfCm7msU++2y2OQVL3fGDUMLPj58l1dMuh+u7z0J/ULX3b5HfMH9U
         +ZLvw2lZjbBVFy9Ep5sfOzWOhaqDbX858A4K020OshuVSWmna9UVhOyDNz2PBW8WCsid
         +vs4BSVdSMazqgoC8HIFSTm3nCzYfSoH/MQs1yWLz0ft7cuREEynCJ/V6QnvqxQitIHJ
         pmwgjAGxXgwqPwINkin8Nu2+AOo+nqGVmUemk/5mifUSoKKUBq77twcwSYLiTF+uxP65
         1Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tm1lXmGMJLM5SVYDIfMqUE0Q/qSMkWx2zGcDO8YQmbo=;
        b=Ck2b65+o4XUag4/nKtyMdnpIFdQlw+nQute1thSkTNAmDtw7wW0juvO+UQ9XBeKQBu
         m/I8o+TrAJgOu0JfvLaJyJ5k9dEveWq7eDAs5LLNtuUF8gwja9SSR+4hKX3aGlVITkt4
         LgoYgmWC8zlFAVB8mJKA0ucfs4rLdeUCuVy46UL0CZt/DPc3dCQ/s7IP3o2ZYA/7Sg/W
         bQsy9YDA3wIEPvnTQJ6QzsScTtR1pNgYGmzJl+xN/aFnz+lm62rXrNBCTF3TonDX6WW0
         JRwfBGpHb+LeCTWnWaGn872IB22HrxPG3PN4J6cWEdgDnSyrxn7cgTfzvpILFnkAIo+h
         smWw==
X-Gm-Message-State: AIkVDXKLYqRr2oMwjt9ziexX2d1ZXgZsmEPvb/at7AXSITukylYeFFHs22f1Ph/ooK7agK8z
X-Received: by 10.84.174.129 with SMTP id r1mr357436plb.19.1484696109491;
        Tue, 17 Jan 2017 15:35:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:871:ca27:8566:e7e])
        by smtp.gmail.com with ESMTPSA id x2sm58248672pfa.71.2017.01.17.15.35.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Jan 2017 15:35:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] document add_[file_]to_index
Date:   Tue, 17 Jan 2017 15:35:02 -0800
Message-Id: <20170117233503.27137-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170117233503.27137-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 26632065a5..acc639d6e0 100644
--- a/cache.h
+++ b/cache.h
@@ -605,13 +605,20 @@ extern int remove_index_entry_at(struct index_state *, int pos);
 
 extern void remove_marked_cache_entries(struct index_state *istate);
 extern int remove_file_from_index(struct index_state *, const char *path);
-#define ADD_CACHE_VERBOSE 1
-#define ADD_CACHE_PRETEND 2
-#define ADD_CACHE_IGNORE_ERRORS	4
-#define ADD_CACHE_IGNORE_REMOVAL 8
-#define ADD_CACHE_INTENT 16
+
+#define ADD_CACHE_VERBOSE 1		/* verbose */
+#define ADD_CACHE_PRETEND 2 		/* dry run */
+#define ADD_CACHE_IGNORE_ERRORS 4	/* ignore errors */
+#define ADD_CACHE_IGNORE_REMOVAL 8	/* do not remove files from index */
+#define ADD_CACHE_INTENT 16		/* intend to add later; stage empty file */
+/*
+ * Adds the given path the index, respecting the repsitory configuration, e.g.
+ * in case insensitive file systems, the path is normalized.
+ */
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+/* stat the file then call add_to_index */
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
+
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, unsigned int refresh_options);
 extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
-- 
2.11.0.299.g762782ba8a

