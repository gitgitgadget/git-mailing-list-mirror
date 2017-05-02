Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E03B207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbdEBWYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:02 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34634 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdEBWXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:43 -0400
Received: by mail-pg0-f42.google.com with SMTP id v1so68092981pgv.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P5Shn3f1ghDE8LLiZIf70izeq7eU+Wd0dQGmxiDZrhg=;
        b=TbF8hwYjAHQqe+/XFbrLNfd8I9PmsHr7TtWe5xXZNh1Jv4BwFvZBgaZ01jjcucKXzU
         Qp/ZcSnBxX/SU8uoSa7aa51dwk0uyjPZvbRlgqL9Cvozogib6g2olJX4wmqg6G5bSlzq
         qKhOoQZKv2IzSXx4YlguSLfyvwcQPoHHeus03oWXg0kgdvthZNPRt8OZa4RvBKZ0z5QK
         kt1iMJ1EtED6QEsdxXakuhNtpeqUFBORvhcFxwTJczpA3b0gB7iT/u2lN5syI0IEpu9r
         n2mVfuD6cG1N350VT7IEe6y4TTIECo1aTSvKQdO34c98vNyra0kmXcMa+YlVcSY7hQsh
         dNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P5Shn3f1ghDE8LLiZIf70izeq7eU+Wd0dQGmxiDZrhg=;
        b=sYZ86/vc8F6IUgRo0qsvluG3NtkehP7xtv+as0eYe//rFw1UtHbsav5ZSpYjDY7oHq
         +0eOykxSBX/0lFyVtM2IBkweWze1rTYBmU/LS0cWMDSaMh92uE7BIEkr0rwAcv+T5M4+
         /8w5kseycgnZpt4bxqpzUW3hS0l/yOTCxZR1HZ0qyYIZSX3ecmCB+fYJV2WPO9TqSpus
         jTzuspxo49ObcIhETOX2qSfmGSkE+SwkyXw14j4V25JUwqsS6bicG3r/097b3xNfk7vh
         ZLWLFmVGhLTd5EdsgxeLgCLc5yNA98vauW34GeTdt8mZbxyZkdv7zzlf/XKuEsG0daJY
         SA/g==
X-Gm-Message-State: AN3rC/67+alWUvbYlCKnZEKvcTkMN8az93+G6JzV3aPXQB3eeQjd22A/
        9XwIxF62d5QxgxvF
X-Received: by 10.98.20.207 with SMTP id 198mr1395580pfu.70.1493763822216;
        Tue, 02 May 2017 15:23:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id m24sm663703pfi.129.2017.05.02.15.23.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/24] cache.h: drop cache_file_exists
Date:   Tue,  2 May 2017 15:23:09 -0700
Message-Id: <20170502222322.21055-12-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c           | 2 +-
 cache.h           | 1 -
 dir.c             | 9 +++++----
 merge-recursive.c | 3 ++-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index 159e039a18..eb8eaeabec 100644
--- a/apply.c
+++ b/apply.c
@@ -3810,7 +3810,7 @@ static int path_is_beyond_symlink_1(struct apply_state *state, struct strbuf *na
 		if (state->check_index) {
 			struct cache_entry *ce;
 
-			ce = cache_file_exists(name->buf, name->len, ignore_case);
+			ce = index_file_exists(&the_index, name->buf, name->len, ignore_case);
 			if (ce && S_ISLNK(ce->ce_mode))
 				return 1;
 		} else {
diff --git a/cache.h b/cache.h
index 5de8ab4e69..85a85f8b96 100644
--- a/cache.h
+++ b/cache.h
@@ -369,7 +369,6 @@ extern void free_name_hash(struct index_state *istate);
 #define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
-#define cache_file_exists(name, namelen, igncase) index_file_exists(&the_index, (name), (namelen), (igncase))
 #endif
 
 enum object_type {
diff --git a/dir.c b/dir.c
index d5e1c462bb..0327832e53 100644
--- a/dir.c
+++ b/dir.c
@@ -1235,7 +1235,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (cache_file_exists(pathname, len, ignore_case))
+	if (index_file_exists(&the_index, pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -1269,7 +1269,7 @@ static enum exist_status directory_exists_in_index_icase(const char *dirname, in
 	if (cache_dir_exists(dirname, len))
 		return index_directory;
 
-	ce = cache_file_exists(dirname, len, ignore_case);
+	ce = index_file_exists(&the_index, dirname, len, ignore_case);
 	if (ce && S_ISGITLINK(ce->ce_mode))
 		return index_gitdir;
 
@@ -1460,7 +1460,7 @@ static int get_index_dtype(const char *path, int len)
 	int pos;
 	const struct cache_entry *ce;
 
-	ce = cache_file_exists(path, len, 0);
+	ce = index_file_exists(&the_index, path, len, 0);
 	if (ce) {
 		if (!ce_uptodate(ce))
 			return DT_UNKNOWN;
@@ -1522,7 +1522,8 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
-	int has_path_in_index = !!cache_file_exists(path->buf, path->len, ignore_case);
+	int has_path_in_index = !!index_file_exists(&the_index, path->buf,
+						    path->len, ignore_case);
 
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, path->buf, path->len);
diff --git a/merge-recursive.c b/merge-recursive.c
index 57ca250c88..b8b3a153f1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -623,7 +623,8 @@ static int remove_file(struct merge_options *o, int clean,
 	if (update_working_directory) {
 		if (ignore_case) {
 			struct cache_entry *ce;
-			ce = cache_file_exists(path, strlen(path), ignore_case);
+			ce = index_file_exists(&the_index, path,
+					       strlen(path), ignore_case);
 			if (ce && ce_stage(ce) == 0)
 				return 0;
 		}
-- 
2.13.0.rc1.39.ga6db8bfa24

