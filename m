Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7404C208D0
	for <e@80x24.org>; Tue, 22 Aug 2017 23:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbdHVXil (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:38:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36509 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbdHVXik (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:38:40 -0400
Received: by mail-pg0-f66.google.com with SMTP id y129so159075pgy.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PqrCEsc3wQfvrq2PR7OxFXzM3FxvWmsoJIbyKYvixVw=;
        b=WvVLYab236xuisSIQAD8BNIQeT9jrs1WP7KHmROjqve+w9YUFI/k6tkXbjsaxo30FP
         zgmgusxyM0N6J8JIeZZsaoNjVj5Kusb5iNWQzTl0jNXeRQqslh89CxJ6nGIxd+gsbHBg
         /1p/zXsvsma3VrMWGBiq4gNieAwQXpzXWEE+SXYWfMKQFvaBGimyLcG5AJtrjoUfGx2E
         qOgA+X9X2YLUkSUA2ufZYUIATCBs3zMYGfyTPfE+BjyNkGXG7lJImTnckF7TS0+Bj6IV
         kQDy1uYGnrNY+8N8U8KLRTA8tABpj2uMnn/prWZ4Os6lPTseum9AMke/hz0i25djs3ia
         cGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PqrCEsc3wQfvrq2PR7OxFXzM3FxvWmsoJIbyKYvixVw=;
        b=on8D63cWEWpxx/K8amqXhnXzYfGdFlcpR9D0MOxNxE6AZ+MZCn+MbGmTMr1lz/M+zG
         zXyNOxwQwqqvRgmZCOQQ+gQ+X06mNuLGEwa5PvEhmHKsg9y/yd+J39TB8T2wN7Jx9T7d
         BR9CqMX2ZtRmlhLTPeMmzxbg5B0I8FOkrAlC9Fzls8cycr/Eq5G/HBakRAV3uwZUg6Yq
         LvDl4sspX0U5o2z/rxo6nLU4hkEBv+Rwi8zt3AUubssMhvJjrXU5Y4tVqD9xJFK0VLun
         A3pQ2yju71iUWJmhWaf5sz8eYHdFEMY+OTFlFhitOPBhud1acdCvDI8/W4NLjBL/Yxfw
         gTGA==
X-Gm-Message-State: AHYfb5iD/HOFpW6gzfHRKWvQLT8SlocOUlauHOay3emvQkgPLd0Ewk2p
        6ojZqD63O07h1JPWKpw=
X-Received: by 10.98.113.9 with SMTP id m9mr760272pfc.263.1503445119448;
        Tue, 22 Aug 2017 16:38:39 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id l2sm138232pfe.168.2017.08.22.16.38.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 16:38:38 -0700 (PDT)
Date:   Tue, 22 Aug 2017 16:38:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] vcs-svn: remove prototypes for missing functions
Message-ID: <20170822233837.GY13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822233732.GX13924@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to remove these prototypes when removing these functions in
v1.7.10-rc0~118^2~4^2~5^2~4 (vcs-svn: eliminate repo_tree structure,
2010-12-10).

Noticed by building a new file that included both repo_tree.h and
repository.h ("error: conflicting types for 'repo_init'").

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Reported-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 889c6a3c95..6c2f5f8a00 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -1,23 +1,13 @@
 #ifndef REPO_TREE_H_
 #define REPO_TREE_H_
 
-struct strbuf;
-
 #define REPO_MODE_DIR 0040000
 #define REPO_MODE_BLB 0100644
 #define REPO_MODE_EXE 0100755
 #define REPO_MODE_LNK 0120000
 
-uint32_t next_blob_mark(void);
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
-- 
2.14.1.342.g6490525c54

