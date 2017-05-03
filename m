Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54137207B3
	for <e@80x24.org>; Wed,  3 May 2017 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbdECD37 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 23:29:59 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32773 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdECD3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 23:29:48 -0400
Received: by mail-yw0-f195.google.com with SMTP id 203so13362297ywe.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 20:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sgUm+CMdZvYKEcO8VoBhxfRgenpy2wqKG9fG/GDD10c=;
        b=BblrDh5HRURyDfv6xa39MVWrEU9NZI41KfV0kYLJkV6of8MpCsyyaJGYAXNA0A77ic
         ChaijlZwEIPqNd99SnVuk3ndFtcsOzN0dwQzHejmNFXRj4YdYnIrNGmEgcqkrerGHKkD
         bVpX531XkC0T/DFatjdicv8U5vCfEiDFhBRmGWh7wQkCCLax1zdbFr0C5Zydfu2mRuFu
         TDbSj0T4huY0SlmygDWGnXMPkC8G9Nv8zenNnbEU8ElFWEeU1HjsacfGCOm6WDY6h1Ch
         ZMq+4tTW6uW+1V7+NUAZBxVJEwod9LmWD7yBofDsr6amhwYJE+ymelaElm10H9RBqRrM
         0bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sgUm+CMdZvYKEcO8VoBhxfRgenpy2wqKG9fG/GDD10c=;
        b=gItP/bLbSqQ9xi9w5mRuDsr6ZUUmr1abnI77Ci7ewP5kJbGvYkj57GlLtX+mrBB09P
         azU5PSpjgn7BLv4uBKt6sOHax7IHbXQ2pRKYIukuAfVxysJ9k9nQW3ZXgzCTIiPQJoB6
         cqfgjdFDQO0erisfySZkTcK0C2FjqCj4Ap9PaqbnWi1Xre0NkCT6uNgrgg8hNDfL45rX
         uVOQWanPmNzMBHLI4rv9DjTyz67gU2M6jPZzMAdjEtI+O2bPkXibE/2OUhnRjcbndcQU
         Yfkr1L39Z33nEqu9x/3zYFf09bi6ZjJcoGLQ/VydChxmcH2wavwuRj3wCx3sUPteBn9h
         AbVg==
X-Gm-Message-State: AN3rC/5lwsqPDLoYfuQXS771++2rcH7wUKMfwOgo/HodKosXzGluHwMj
        ypsQlziZ7AkG4w==
X-Received: by 10.129.177.72 with SMTP id p69mr1084498ywh.184.1493782187167;
        Tue, 02 May 2017 20:29:47 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.23])
        by smtp.gmail.com with ESMTPSA id v3sm11329586ywi.79.2017.05.02.20.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 20:29:46 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH 5/7] dir: change linkage of cmp_name() and check_contains()
Date:   Tue,  2 May 2017 22:29:30 -0500
Message-Id: <20170503032932.16043-6-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com>
 <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 dir.c | 4 ++--
 dir.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index f0ddb4608..91103b561 100644
--- a/dir.c
+++ b/dir.c
@@ -1844,7 +1844,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	return dir_state;
 }
 
-static int cmp_name(const void *p1, const void *p2)
+int cmp_name(const void *p1, const void *p2)
 {
 	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
 	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
@@ -1853,7 +1853,7 @@ static int cmp_name(const void *p1, const void *p2)
 }
 
 // check if *out lexically contains *in
-static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+int check_contains(const struct dir_entry *out, const struct dir_entry *in)
 {
 	return (out->len < in->len) &&
 			(out->name[out->len - 1] == '/') &&
diff --git a/dir.h b/dir.h
index bf23a470a..1ddd8b611 100644
--- a/dir.h
+++ b/dir.h
@@ -326,6 +326,9 @@ static inline int dir_path_match(const struct dir_entry *ent,
 			      has_trailing_dir);
 }
 
+int cmp_name(const void *p1, const void *p2);
+int check_contains(const struct dir_entry *out, const struct dir_entry *in);
+
 void untracked_cache_invalidate_path(struct index_state *, const char *);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
-- 
2.12.2

