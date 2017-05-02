Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B89E207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdEBWXy (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:54 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36096 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdEBWXl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:41 -0400
Received: by mail-pg0-f49.google.com with SMTP id t7so67987056pgt.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iLyqmSbLCpxd5hVo/Z0DPGFVfX0QNOKndA5YhPNd0sE=;
        b=Mv+vsOmFj3vdihavMP748Gw3xJfGE4ZPRQ7WMPLyEp56Fgiuaxxqfbd3jd85eBRYSB
         xmHHpdccrtIVkBi4BEHaShsktopAzsKjFyu++emMfYozLNVS6hXRe5rbqXQNsmvPqqeP
         FKxBcjeMho7ca/HtO8q4Eoau9TB3B6oxuceJQ6BtW/qhu2LYbRWsanKKfi9yuPDkLgm+
         qANnriZDgfOU6qBzzcYVHuql+gXekXWIMJEdLrMU/a/5PGoTtQn19/DZWDs80dFpJzf+
         ZrIMBMTyU79z4wIppUm6rn14ojb9gti9Z4ChJpuChzHLUymWBwXE1RCP+XG3I1eQwUqW
         3ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iLyqmSbLCpxd5hVo/Z0DPGFVfX0QNOKndA5YhPNd0sE=;
        b=V2ZSHg/FQ1/6tGCYeWXOUHNjl/lUYpG24tJhenvQZllCQgjqguyV13MP84fnKbWOqb
         Jv2DP6Qeibc8Yg+QwWLfOP5ZHtFnDVqapGit3L+J6I9w2VwWbSPYfpPSFsCY+6ngmHAm
         S8b4cz4Xrm9qDPAsXGEKmnMmsb6H4oUQnv/sUHbwgROtBFUqBCHHnpcPpZnDDCCP0rYb
         yf4SIW/JcouUjX5rvWTadkSZF9fb6w3BnXH7wf+7PJ1Q/4oWQoj/i4DO+Yd1VNmrRwIo
         vy4vaFH+hubkU5+kJLRtqw9lcg08F/RmOriV1MQKIHaAaizS+V9XxhU4C4nMKsyp8c00
         qjvg==
X-Gm-Message-State: AN3rC/4RHP+bGXQRTbPkd9sMQC+aC7hwE8VBz1RdgS+NF0iHd+ncCuL8
        /xvNBCpEII8Qby2r
X-Received: by 10.84.230.229 with SMTP id e92mr44781956plk.2.1493763821023;
        Tue, 02 May 2017 15:23:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id 29sm734022pfo.9.2017.05.02.15.23.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/24] cache.h: drop cache_name_is_other
Date:   Tue,  2 May 2017 15:23:08 -0700
Message-Id: <20170502222322.21055-11-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clean.c    | 2 +-
 builtin/ls-files.c | 2 +-
 cache.h            | 1 -
 dir.c              | 2 +-
 wt-status.c        | 4 ++--
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 9bdefca6dc..c6aacbb0f0 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -938,7 +938,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		struct stat st;
 		const char *rel;
 
-		if (!cache_name_is_other(ent->name, ent->len))
+		if (!index_name_is_other(&the_index, ent->name, ent->len))
 			continue;
 
 		if (pathspec.nr)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index edcad6e8e1..6f7ecec1b0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -114,7 +114,7 @@ static void show_other_files(struct dir_struct *dir)
 
 	for (i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
-		if (!cache_name_is_other(ent->name, ent->len))
+		if (!index_name_is_other(&the_index, ent->name, ent->len))
 			continue;
 		show_dir_entry(tag_other, ent);
 	}
diff --git a/cache.h b/cache.h
index abf1474034..5de8ab4e69 100644
--- a/cache.h
+++ b/cache.h
@@ -370,7 +370,6 @@ extern void free_name_hash(struct index_state *istate);
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
-#define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #endif
 
 enum object_type {
diff --git a/dir.c b/dir.c
index 8abad1b969..d5e1c462bb 100644
--- a/dir.c
+++ b/dir.c
@@ -1244,7 +1244,7 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (!cache_name_is_other(pathname, len))
+	if (!index_name_is_other(&the_index, pathname, len))
 		return NULL;
 
 	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);
diff --git a/wt-status.c b/wt-status.c
index 750ed28b49..ff0e70a25a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -669,7 +669,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
+		if (index_name_is_other(&the_index, ent->name, ent->len) &&
 		    dir_path_match(ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
@@ -677,7 +677,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
-		if (cache_name_is_other(ent->name, ent->len) &&
+		if (index_name_is_other(&the_index, ent->name, ent->len) &&
 		    dir_path_match(ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
-- 
2.13.0.rc1.39.ga6db8bfa24

