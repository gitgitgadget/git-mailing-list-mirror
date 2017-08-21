Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB28D20899
	for <e@80x24.org>; Mon, 21 Aug 2017 00:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbdHUAAb (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:00:31 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57050 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753417AbdHUAAa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 20:00:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 90217280AE
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503273629;
        bh=VHdx+DsNFBSmZRFFJcfd2n8FbUqRyO1sWIh6S5/FIWc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cVMmF1bpaiXlVQ5BkwWirthZu2MR12IjphvPcdVNqE4NRqHpJGzXYg5w0ky9tDzmj
         tBYNsBgFsAdVGEzF5KUk0SbhbmuZ4KtszoTrl86IxEp1IFmvN485pP1QaAEbUolQ/t
         8T0xt2i0GoItCSEpVfkBd4ZAcvuyjMkbzLAU/dl5ilAFAC+L7fFhYQglWQ1bfoxQ9u
         qyl6VrB0opq4CSoO3hI0ihGflgqzvHwcQqPajNcXRaQYU7Ye1WGmgj2XKFipXlQVZ7
         Yiue5cXp4ngTdDbhyRosN9LuEBASKRIafF/KX3P4ddcesfuH83EPwEmQ6LO6X5HB+K
         eCq7JeZvOF5nPsk7dAIB/viN5+i6YgDbBuluuD+5HQkECO0nRChDUtTFUDN+iDOpEa
         pNCXbW9m5UieEq4jEf51Br7QV6BAW6H42q95z342tFFwfkpgAYKJcgmob6YoVaAOQH
         pTKsQZUlcBM30Vj4SMNQ5uHt6uw5oDj2ie6hVtBBCF2HmKIzIKE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/6] vcs-svn: remove unused prototypes
Date:   Mon, 21 Aug 2017 00:00:17 +0000
Message-Id: <20170821000022.26729-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20170821000022.26729-1-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Subversion code had prototypes for several functions which were not
ever defined or used.  These functions all had names starting with
"repo_", some of which conflict with those in repository.h.  To avoid
the conflict, remove those unused prototypes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 vcs-svn/repo_tree.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 889c6a3c95..d0f5690dca 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -10,14 +10,7 @@ struct strbuf;
 
 uint32_t next_blob_mark(void);
 void repo_copy(uint32_t revision, const char *src, const char *dst);
-void repo_add(const char *path, uint32_t mode, uint32_t blob_mark);
 const char *repo_read_path(const char *path, uint32_t *mode_out);
 void repo_delete(const char *path);
-void repo_commit(uint32_t revision, const char *author,
-		const struct strbuf *log, const char *uuid, const char *url,
-		long unsigned timestamp);
-void repo_diff(uint32_t r1, uint32_t r2);
-void repo_init(void);
-void repo_reset(void);
 
 #endif
