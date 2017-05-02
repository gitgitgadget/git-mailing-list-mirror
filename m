Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E3D207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdEBWYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:34 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34032 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbdEBWXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:51 -0400
Received: by mail-pf0-f175.google.com with SMTP id e64so3513034pfd.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2/Bslc50+xupdcql1BOGy2Ak/IeEnFxVUgi6Jg5DEZI=;
        b=OAPHQtOz9ocGhQiGLEMLc8BECHDlHypypb4fj0bjQ/n9sCuYhekRaJTI2J2SduIf5N
         4QD9LJcqlinl5uQ+SRZ8Hg3zQ62kk5ZT1Gh6YoGnKdbIxoknv4rL/ZKWKsc9kDHwoiCd
         3x/mzQFmTJWV2pgyoG5FkLhPtoGz5aS9ilAETS9Fxib93KgIEr3/1yS692Qk9A1iR96y
         wsVROuXK0L0XKrsOpdXIc862UTThPlB4GoMa4WS41KjxImYi2lTdeQNZAsP419XnjMwj
         WwRMIkG1ij5B4iv9qemdm41R+5Zsdq3Nx0yOeHUsVNhC7b4nM5QwejPQKP8uqiZf/oPd
         BqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2/Bslc50+xupdcql1BOGy2Ak/IeEnFxVUgi6Jg5DEZI=;
        b=EP93/+v83wfsYDjqoT/C4dYagq8RxN+COzpZq889+XJMQ07Le6dbCsmrzvhIM1UMst
         P3kqg+mSthfQ+AsGMQR4ynbJO3GJ0IuvoIyHFH1mT11Laddgr693U61UJDoQ3SJoZ8V5
         DBIcBNh5c8E2LLnPkjSX6+WMz2rW51PbdTz6kjdG9Fuzv06eyyVpQ+yS+/VucC0QGKeO
         p/l4Q0nF07bXbhwuLKHniz85igKXC66C/AP6UVPanjmYhGcg+vQIcQxnWLNG+3bzSixo
         abotnQZadhBrvWz78oId2YcTgNEJTrhdOb6tQodxpK3mxvBg66xz1OoZa0s7TuU4/ASN
         9fOg==
X-Gm-Message-State: AN3rC/57wK67cLhpsRbi5s+6r3ar1cK9SVsmRf3KdyJzf/x/tQDpt/+m
        bsSR9vr2oE/lW2DB
X-Received: by 10.84.233.199 with SMTP id m7mr22958607pln.108.1493763830313;
        Tue, 02 May 2017 15:23:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id z5sm716699pfd.76.2017.05.02.15.23.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/24] cache.h: drop add_to_cache
Date:   Tue,  2 May 2017 15:23:16 -0700
Message-Id: <20170502222322.21055-19-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/commit.c | 2 +-
 cache.h          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fa962c4f86..ac4fe97d36 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -287,7 +287,7 @@ static void add_remove_files(struct string_list *list)
 			continue;
 
 		if (!lstat(p->string, &st)) {
-			if (add_to_cache(p->string, &st, 0))
+			if (add_to_index(&the_index, p->string, &st, 0))
 				die(_("updating files failed"));
 		} else
 			remove_file_from_index(&the_index, p->string);
diff --git a/cache.h b/cache.h
index 88c6f8a7df..bc49defc27 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define add_to_cache(path, st, flags) add_to_index(&the_index, (path), (st), (flags))
 #define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
-- 
2.13.0.rc1.39.ga6db8bfa24

