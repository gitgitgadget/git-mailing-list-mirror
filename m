Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A42207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdEBWX5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:57 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35947 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdEBWXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:44 -0400
Received: by mail-pf0-f169.google.com with SMTP id q66so3481398pfi.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eOTbAbooHk/vPmWOtSrbl1V50j2ZIKGuRx5JBKlrSG4=;
        b=sWPCOI1WXT2qCNfU7nj0GDdWsqdQLbGrrX88BGkrlNETopbWlHU6fjOPZg76jGgL6o
         yjrDvD/nlCc86rgVT+nTwn6H3XG/yOKgHfVEpCoJ53hMVa8C8vS69UjbUgrLApC7umYp
         svfmZ4GUtJn/sQv4RV319bkgm3z9LJJGOZpscjg8BhihZwsd1wSvLE80JAAkaCI6AOgv
         ip8bMCCA7SmJeNaKxFjQ2t3OWtKuVNay52dAYVPiS3zEv+aEYN5aG2BJPt77+90TE4Ch
         hiB3INcUNBzkrPX9DWnQ5yChIbe+emPajQUyv6zxjfwNA3KiLWFJkvIejsitZOWyi3fk
         DS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eOTbAbooHk/vPmWOtSrbl1V50j2ZIKGuRx5JBKlrSG4=;
        b=MCON/7YKbus9k+pozzYgEnWOhUV4Na9begM/DZ9CeIgLc1XGCjtNwZ8gNkyusRHHhd
         dqzJ75wWCvWKuWvS/RIISuc2yoXFOkR2QjCgseqDiPvox0yC84/91ioBOZwDt+pVHLqw
         yUVdikYs0yuVVa+OYCkiWESmaV4JaT2G5SkuaZrqfTBnF/QSoLgw7yro1wUBvvXzfD0t
         njyP4jgbpV48Q3iw4gev+YCbHerl/TTztv954OUcJJ+BuD1j+8OORlwYpOxxc+h1yPSZ
         91OqoWgSB5uNinW1IGngy/UCjI1rP6/C3aDSI+xfvjnOUacj+VOMrj5MrH2ACLQ6lPvD
         nSrw==
X-Gm-Message-State: AN3rC/78g146e3qvtGtQn3a3h09APO7bDSXCXX6efdRzoKnaEJfNwrHc
        N+pwB5t2Gkkr2VGfG2qEKA==
X-Received: by 10.98.147.202 with SMTP id r71mr1376868pfk.43.1493763823302;
        Tue, 02 May 2017 15:23:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id p16sm39434178pgc.4.2017.05.02.15.23.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/24] cache.h: drop cache_dir_exists
Date:   Tue,  2 May 2017 15:23:10 -0700
Message-Id: <20170502222322.21055-13-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h | 1 -
 dir.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 85a85f8b96..4b8e8c31fe 100644
--- a/cache.h
+++ b/cache.h
@@ -368,7 +368,6 @@ extern void free_name_hash(struct index_state *istate);
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
-#define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #endif
 
 enum object_type {
diff --git a/dir.c b/dir.c
index 0327832e53..63edaec2ef 100644
--- a/dir.c
+++ b/dir.c
@@ -1266,7 +1266,7 @@ static enum exist_status directory_exists_in_index_icase(const char *dirname, in
 {
 	struct cache_entry *ce;
 
-	if (cache_dir_exists(dirname, len))
+	if (index_dir_exists(&the_index, dirname, len))
 		return index_directory;
 
 	ce = index_file_exists(&the_index, dirname, len, ignore_case);
-- 
2.13.0.rc1.39.ga6db8bfa24

