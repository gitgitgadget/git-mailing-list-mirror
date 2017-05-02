Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E01207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdEBWYS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:18 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33299 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdEBWYB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:24:01 -0400
Received: by mail-pf0-f177.google.com with SMTP id q20so3542752pfg.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PTSnCKpNV2UHrXNWcdYHLGGeeFSC3b+zQUGaA7A15po=;
        b=Q4pd/VSO34c+A46Y29VpRyE7SY9ASHNEQbvxkc0/g+bv3HXXPnPOFMiSmPrOslAIhC
         WEkUEEITKsCsm166UZlYLNuBG5GhMIYl7v/O35LhoJukD2ST5o5VC4HrX0VPqnnpZCh5
         dgZaAwUngC+0dyFEm2E91JhF/lOIqKbxkhbs4EZMspiOy34wz2qbsZ3M0QiciBb4IYBn
         D2bU1ME8NkEvpCrLuzHDOBn4oXUy4AMVmvBHuQQGBM1TO3e9R4CGL+7Dd6Jvdago6rtO
         AqBrhFyNsq2R2a+wsje6TjHUytYJ0hGnABnO6Do37HiIYZljuO5CuxhFnWeFpGlqAeyp
         wf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PTSnCKpNV2UHrXNWcdYHLGGeeFSC3b+zQUGaA7A15po=;
        b=KIEoybCL1qmssxtzUepqpRsikTh50oHZWcGEstbmjsRH9Vig0ekBTWatqF6O7zdejF
         bbb5b6xAB8kPpV+QjyBeMeW482h06NhFhWmIgo4Ai7DLvBH0/EFsQGYQosepqXbZ9/VE
         2ea2IPPEjCnWRGDD9U/j7EsAhm9VlpqQYyjaN+b1KHZvVD16C73/HkQWmNj3mvnF21As
         gz3chCnVO1vpPFoCNC4m+6tuek5PBpXcc5Q/guvRzrsav7EUxeOinveA9pR98dW2c2s4
         ypHhc3iAhCnmNgVGO6ZJp58tkHTcGz8DrltYRAyDGwwLpA9lVkJ3D7lxW7BcPM1yP3W0
         1kAQ==
X-Gm-Message-State: AN3rC/5debVFgnqFbJ8WA8wGXts7Yre5V5+7Fq7XdyEw7yQdmhCXW18M
        1lGW7s4H9XyrlYaY
X-Received: by 10.98.10.147 with SMTP id 19mr1344851pfk.193.1493763835783;
        Tue, 02 May 2017 15:23:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id n126sm29600404pgn.32.2017.05.02.15.23.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 22/24] cache.h: drop ce_modified
Date:   Tue,  2 May 2017 15:23:20 -0700
Message-Id: <20170502222322.21055-23-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/ls-files.c | 2 +-
 cache.h            | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3507490d3e..89fac7ddf5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -369,7 +369,7 @@ static void show_files(struct dir_struct *dir)
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
 				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
+			if (show_modified && ie_modified(&the_index, ce, &st, 0))
 				show_ce_entry(tag_modified, ce);
 		}
 	}
diff --git a/cache.h b/cache.h
index 23c9c1697c..c34fc4fd40 100644
--- a/cache.h
+++ b/cache.h
@@ -355,7 +355,6 @@ extern void free_name_hash(struct index_state *istate);
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
-#define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #endif
 
 enum object_type {
-- 
2.13.0.rc1.39.ga6db8bfa24

