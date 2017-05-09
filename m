Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6051FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbdEITSk (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:40 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33915 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbdEITSg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:36 -0400
Received: by mail-pf0-f181.google.com with SMTP id e64so4553540pfd.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4g7VzQExKzSwIRPYNUMA3Qn0iYIgUxEEFuMFSXPhP0g=;
        b=quMYV3JKIdKQuMMT3DKHvSoeRvYjaA49ZmBGgwhepCNiP+AjjYrhOZWVHt48Oz5MWo
         qGlHeG/01FozNK2tHlBXeHCwPLXZx7uGqAX4cGwRHzA68NWfvT5OMi7/LNWtzd1eSL5v
         UWKE+tazMCC3dhdosP4gFeG7r8IInq0OiRmX+9HDGJ0Ol55a58kc6oZTp9vyLoHyQ/Xi
         gmW8qvAejb1Y2vRMbfOt3xfUi0m8WJUbvjBxCVi4u6oMLWkUC01UjSbhdISDry7sY3wS
         Ttqj7LXkDFG7jf/7oTnR24cLI4BJ2K8txlO7TfybJWi0dUzIt6Q0QKifGoe2fheB3CPW
         1Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4g7VzQExKzSwIRPYNUMA3Qn0iYIgUxEEFuMFSXPhP0g=;
        b=rzv3IsNaljYHPhvFXJpARSTj4nqNat2P5VtOWEeHLIWmXKpKQcbLvsNuG2u4ch+8lT
         NEvgr9+83EyG8mWO5a6oXGvx/G/yRK8P0pp8jajIgD5PB22hXxVKo6C0yeEZ2fbSszPC
         gLFPqRNQtMSrUMsgygebdJV8Bk4uNLwehmmU6+TD1G+wZZhOloMO5ewworipSz4JOX3E
         EaR4ReB5RDXWBoEnVAmKQdO8Y6v6l2RttBnrW+CqJDVpOE+ytHx8jx7WP0Y72SVErNGM
         xGZqDkBg9sZ4c5nWW8jubD2UKJNqj/O3dRQzkB9ALSHAscaBsIno3AqPTo49x+XlOt2w
         QLnA==
X-Gm-Message-State: AODbwcAfqjywNsSBTL7ndkURCZlpuCRZIM9qtpuoyXbe6mwD6mArxBGf
        fqWufEhPbciFbo4k
X-Received: by 10.98.64.221 with SMTP id f90mr1664953pfd.123.1494357510053;
        Tue, 09 May 2017 12:18:30 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 4/8] pathspec: rename PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
Date:   Tue,  9 May 2017 12:18:01 -0700
Message-Id: <20170509191805.176266-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that there is only a single flag which strips a submodule slash,
rename PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP to
PATHSPEC_STRIP_SUBMODULE_SLASH.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c               | 2 +-
 builtin/check-ignore.c      | 2 +-
 builtin/ls-files.c          | 2 +-
 builtin/reset.c             | 2 +-
 builtin/rm.c                | 2 +-
 builtin/submodule--helper.c | 2 +-
 pathspec.c                  | 6 +++---
 pathspec.h                  | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 2aa9aeab9..51d7a5506 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -389,7 +389,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_SYMLINK_LEADING_PATH |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH |
 		       PATHSPEC_SUBMODULE_LEADING_PATH,
 		       prefix, argv);
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 73237b2b1..694e4c61b 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -88,7 +88,7 @@ static int check_ignore(struct dir_struct *dir,
 		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
 		       PATHSPEC_SYMLINK_LEADING_PATH |
 		       PATHSPEC_SUBMODULE_LEADING_PATH |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH |
 		       PATHSPEC_KEEP_ORDER,
 		       prefix, argv);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db..e9dee2e41 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -618,7 +618,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       PATHSPEC_STRIP_SUBMODULE_SLASH,
 		       prefix, argv);
 
 	/*
diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c4..529f2f9be 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -236,7 +236,7 @@ static void parse_args(struct pathspec *pathspec,
 
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
 		       prefix, argv);
 }
diff --git a/builtin/rm.c b/builtin/rm.c
index fb79dcab1..8fe12d0a7 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -272,7 +272,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       PATHSPEC_STRIP_SUBMODULE_SLASH,
 		       prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85aafe46a..69149b557 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -234,7 +234,7 @@ static int module_list_compute(int argc, const char **argv,
 	char *ps_matched = NULL;
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       PATHSPEC_STRIP_SUBMODULE_SLASH,
 		       prefix, argv);
 
 	if (pathspec->nr)
diff --git a/pathspec.c b/pathspec.c
index f37d5769d..a1297ca02 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -386,7 +386,7 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 		return parse_short_magic(magic, elem);
 }
 
-static void strip_submodule_slash_cheap(struct pathspec_item *item)
+static void strip_submodule_slash(struct pathspec_item *item)
 {
 	if (item->len >= 1 && item->match[item->len - 1] == '/') {
 		int i = cache_name_pos(item->match, item->len - 1);
@@ -496,8 +496,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		item->original = xstrdup(elt);
 	}
 
-	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
-		strip_submodule_slash_cheap(item);
+	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH)
+		strip_submodule_slash(item);
 
 	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
diff --git a/pathspec.h b/pathspec.h
index 93a819cbf..dd6456d5d 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -59,7 +59,7 @@ struct pathspec {
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything */
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
 /* strip the trailing slash if the given path is a gitlink */
-#define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
+#define PATHSPEC_STRIP_SUBMODULE_SLASH (1<<3)
 /* die if a symlink is part of the given path's directory */
 #define PATHSPEC_SYMLINK_LEADING_PATH (1<<4)
 /*
-- 
2.13.0.rc2.291.g57267f2277-goog

