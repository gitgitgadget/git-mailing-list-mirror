Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD46207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbdEBWYa (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:30 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34859 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdEBWXx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:53 -0400
Received: by mail-pg0-f50.google.com with SMTP id o3so62836057pgn.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vJu+ZOwH/ebuxftngWopR3vYbJ2rF/HNQmZsewiUOAc=;
        b=FNbaiWnyokonSlLM2QD7o0Tj9P6UgcROe1UXav2PjgINH7gwI+5sTJ4tR+JVyFUOc0
         AEB2qzcA9ycEap1rG50Xe5P6tTIGidJIVDKhjgNzel8O/n5N/VY/xhU3LvdJCCVRj5q8
         hmXlzphbmGwt/Az7x1ohsgXPkyUmlsVik4HmgXROsJ0u89LipzN3MQ4CEGY04Yg4T6/d
         8d1J3m0Ifv2B6fLGQ/Qo2xT7B9DWDxj1U75G4iatv8jylY8wCp7p0CtuK87htgPrfksB
         lMfi3GUmZcI3mzRwFCEekitIDdoHcIBU36AlJzfYrOV4aCet8+m+9H9Zsz2NSxZx8dXV
         xblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vJu+ZOwH/ebuxftngWopR3vYbJ2rF/HNQmZsewiUOAc=;
        b=nQ9NShF3KjcSwq7gODPbqj/Zo6QLvZf601Q75GyeKYRrlodXIJhN1H5VyqwRRFIJK+
         XDta+ZXDC4HjRhhL/vihgfzhRyGCNKgCBqs7u0XwqRdrkYMSsiO4rpj5uAUV43k5lRon
         5uh3jwsnRhpT/8khMPIv48khVoI58VFo4uufpioT3U07T7tOTkmkskKI36IRyw6L4MEe
         o+FJeOz+Iv09sLEWotOo/GCzGJRkRE7+wsaifoX1roRoflGVd3nrp3zXEpZhMFK98lL7
         7X6DPtCByIGmEti24yX+LitnebCyIPYfup8BgrkRJ0u6kU53RFSzmsp/CBQJeRO/6GHd
         3+Ow==
X-Gm-Message-State: AN3rC/6lER0TAYMb0VXNiEsbNiSyHSQmyhstrVGmxBc769vk1RStgIb5
        XZZxzuPhYIzbFYWk
X-Received: by 10.84.174.197 with SMTP id r63mr44715747plb.67.1493763832468;
        Tue, 02 May 2017 15:23:52 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id n7sm768631pfn.0.2017.05.02.15.23.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 19/24] cache.h: drop add_file_to_cache
Date:   Tue,  2 May 2017 15:23:17 -0700
Message-Id: <20170502222322.21055-20-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h     | 1 -
 rerere.c    | 2 +-
 submodule.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index bc49defc27..a9b059913e 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define add_file_to_cache(path, flags) add_file_to_index(&the_index, (path), (flags))
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
diff --git a/rerere.c b/rerere.c
index b6d84b8461..0ada0ef247 100644
--- a/rerere.c
+++ b/rerere.c
@@ -712,7 +712,7 @@ static void update_paths(struct string_list *update)
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
-		if (add_file_to_cache(item->string, 0))
+		if (add_file_to_index(&the_index, item->string, 0))
 			exit(128);
 		fprintf(stderr, "Staged '%s' using previous resolution.\n",
 			item->string);
diff --git a/submodule.c b/submodule.c
index 148194831d..6587bc0d84 100644
--- a/submodule.c
+++ b/submodule.c
@@ -119,7 +119,7 @@ int remove_path_from_gitmodules(const char *path)
 
 void stage_updated_gitmodules(void)
 {
-	if (add_file_to_cache(".gitmodules", 0))
+	if (add_file_to_index(&the_index, ".gitmodules", 0))
 		die(_("staging updated .gitmodules failed"));
 }
 
-- 
2.13.0.rc1.39.ga6db8bfa24

