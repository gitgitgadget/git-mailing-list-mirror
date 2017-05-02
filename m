Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BBD207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbdEBWXt (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:49 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33243 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdEBWXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:38 -0400
Received: by mail-pf0-f170.google.com with SMTP id q20so3539989pfg.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=swvrQTq6WZ/wItSaiTScVgQA9g7gPjB8Pkvv6lDJYOE=;
        b=h+TgjlF+kbKjv4LI9UDyM5DnGX4sei+hzcLTzckZkSNAaqjEX7oWuRDPJ8Xeu/FD5U
         3WhzLixlAWzwNZz7hJWO8+y58fIRm+HMU0OX9dHIBJM7bH2xu4Ck+0PUdsSD0jUUjHx+
         aPtO1Z7uiOzWlG8yLzRW28+TJ++qwL2tRX+r8T408KgYoo/Avz+no5dUnzA22ah/FZof
         O98BSy2tAq2T2TWAu4xg8qSovc3LHcEDbzWdszD1HNAGt1cw1XVamDz7Fl59c6MW6j2g
         uOj/Y19QP+f2eGzNKMQ1Jo63XHh22BQM1LBRp9amoYrHhaaGJhzu1ENKcXL+9eyGnG+Y
         wqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=swvrQTq6WZ/wItSaiTScVgQA9g7gPjB8Pkvv6lDJYOE=;
        b=ahppq/4YDsk5jviO2IpUt94R5+k0s5iT/+xtmAwFIocNcBOu6ifrn6RcxzIQaMtgyi
         oWJ0F8Eh4ypFzj1otjdU1TtU3AUAcJkJEzCgmqZ33b1fDTwwnwDyJnLvf1Jew7xfjIU8
         /Jo2KhyvEMfQ/Y8B3lCYC9DMqP72n0cWBrOZkNdlYL7bkSQLWPBcd7Ei+yQrfadaXK49
         YCZx30iUs5f8482NJw4rgkdJ6CCQnGVGxuXOo4wqaU4uEye9PYtJq5AJgtdCjnwMK21V
         FmUKjmLdoR1hTGq2v98Hq4cPHv7DGIY1vtVxIDXxKce/GodA1ZWVvK3P9jR32Rj87l0w
         cGfQ==
X-Gm-Message-State: AN3rC/61AhgC5XPFWL+qLbY31bOabSaAxW7lCCbvvA51W6KRIsZu2f7b
        oNMH0+LiC4Ascv4DBtdQhg==
X-Received: by 10.84.168.131 with SMTP id f3mr45134532plb.160.1493763817756;
        Tue, 02 May 2017 15:23:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id o62sm702856pfj.87.2017.05.02.15.23.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/24] cache.h: drop read_blob_data_from_cache
Date:   Tue,  2 May 2017 15:23:05 -0700
Message-Id: <20170502222322.21055-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was done without cocinelle, as we only have 2 occurrences.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h   | 1 -
 convert.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 9b94339573..d078e88c3f 100644
--- a/cache.h
+++ b/cache.h
@@ -374,7 +374,6 @@ extern void free_name_hash(struct index_state *istate);
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
-#define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #endif
 
 enum object_type {
diff --git a/convert.c b/convert.c
index 8d652bf27c..cf29280ae1 100644
--- a/convert.c
+++ b/convert.c
@@ -137,7 +137,7 @@ const char *get_cached_convert_stats_ascii(const char *path)
 {
 	const char *ret;
 	unsigned long sz;
-	void *data = read_blob_data_from_cache(path, &sz);
+	void *data = read_blob_data_from_index(&the_index, path, &sz);
 	ret = gather_convert_stats_ascii(data, sz);
 	free(data);
 	return ret;
@@ -222,7 +222,7 @@ static int has_cr_in_index(const char *path)
 	void *data;
 	int has_cr;
 
-	data = read_blob_data_from_cache(path, &sz);
+	data = read_blob_data_from_index(&the_index, path, &sz);
 	if (!data)
 		return 0;
 	has_cr = memchr(data, '\r', sz) != NULL;
-- 
2.13.0.rc1.39.ga6db8bfa24

