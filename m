Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CFC20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfC3LVN (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42680 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfC3LVN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so2248070pfn.9
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swfM3Ce7DzBzcK6f0IRnRqVMGoBZxgK3ndAeGWegqo4=;
        b=rPcB/1VFz2CuP4KyG1N+EnDNZ7ELlR/VmgGRlqfVMwsnsUB+TF7Qik6hieUlJMqyZY
         yGCdt0MNWLI7FuOGYZw4hFaoeN8lmeZsG5RM0XXidNxtf4oFrUvVar4FGgjIglpyH5+P
         ikADnlp2vwiXwxcewSOwJ2lhhkp6B9QBnpofXMEUw+Uq1mYGLdb5ITtPHsS5mi/IQi2r
         DVQ964mSMGcRLBrc6g4nLPgfKBreJTp3D+4twrauttVVuToFbuEnZvP7vpVxdyA8ZgAk
         5xe4O2WiHKe9GV47GiHqt406lz+vRT9fQTQRny2DRd5Ii/4JwhSdd4CvrvjSrywTLuaV
         h48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swfM3Ce7DzBzcK6f0IRnRqVMGoBZxgK3ndAeGWegqo4=;
        b=Gks4k0Kbm7NcalF3okXW55B7J0NQhDcW9J/8R3nwm73zTGAhlEv4yl5XBzJM4I8nFZ
         WuJmjkqrSUvcLxqS5mAvbiYUjSTRONK3mPliozHF8n6aH/LRqUU2RHvrbgi0n2Vx4PRc
         0YoMS58PGfdgQ+DxNu+hXc/+T3g5tzfs7dtE3lfKs8MgQPZucORdUzNHNK7nfCJLVIwN
         e27NaqqF1MaFlr0ZQS5gxQjHypmAs55NaRlS9waenYyV64t0Mdfh0c80JvwAvXcjp7hw
         FIvRneE+T29Ugm/od8PBvKfZbUnq+yuso1uiCvD091jkBp6qkRAi35IgO9TJtbwV4ZEI
         NlFQ==
X-Gm-Message-State: APjAAAWCV5xr2cWca0Q0K1ltXyrZ5azkts9jV3Omqg/QkSowzemVBEuE
        UmgTc2n6lbOOgwnio0AWxkRMBW5x
X-Google-Smtp-Source: APXvYqz3uGAvfb7HhB905V2HuwzZ0J0B8Syw7Qm+/5zPbH4/3+s+e5t7rmSpxHR6NPnjPkAOQxOurg==
X-Received: by 2002:a62:fb10:: with SMTP id x16mr52438005pfm.5.1553944872407;
        Sat, 30 Mar 2019 04:21:12 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id n5sm5777831pgp.80.2019.03.30.04.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/31] commit.c: add repo_get_commit_tree()
Date:   Sat, 30 Mar 2019 18:19:05 +0700
Message-Id: <20190330111927.18645-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.c | 5 +++--
 commit.h | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index a5333c7ac6..f0a5506f04 100644
--- a/commit.c
+++ b/commit.c
@@ -340,7 +340,8 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 	}
 }
 
-struct tree *get_commit_tree(const struct commit *commit)
+struct tree *repo_get_commit_tree(struct repository *r,
+				  const struct commit *commit)
 {
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
@@ -348,7 +349,7 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
 
-	return get_commit_tree_in_graph(the_repository, commit);
+	return get_commit_tree_in_graph(r, commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
diff --git a/commit.h b/commit.h
index 42728c2906..b576201be8 100644
--- a/commit.h
+++ b/commit.h
@@ -143,7 +143,8 @@ void repo_unuse_commit_buffer(struct repository *r,
  */
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
-struct tree *get_commit_tree(const struct commit *);
+struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
+#define get_commit_tree(c) repo_get_commit_tree(the_repository, c)
 struct object_id *get_commit_tree_oid(const struct commit *);
 
 /*
-- 
2.21.0.479.g47ac719cd3

