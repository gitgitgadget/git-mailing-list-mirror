Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4541F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfAXIaS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:30:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41552 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfAXIaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:30:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so2345180pgq.8
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZADBjJCY8s2VfF3t+tekGYSe/SqjmOaEwQVxp8CXR8=;
        b=nCiw2nyDl7cpI86T3yXSgCtCZOA1HB8OdXAV92zMFoFF8O2mK9c4JGVJ8Nh2KcEKQn
         tp76HJPR9lA9jt+8ZAA746pgrcriiFYPwPHyux+PxAS7q1S4DO8qCpjG2bMyuTisLENm
         TaYg2jXpO1DHEedE4TfQqGpHjghV4nLogbLigKsJRn4njJPd/XaZ28jb2xR3nmdlQCLF
         1tvAMBAvFSx4LZQiKicqFTX/HhZIH7jC7u/wQGOJvAq9ZgpuHJk55J3AQEWbKoP4DfSu
         Hu2VBl3oaOzvhhkcAiPtGkB74CIat+lMZ/sGYRt5wWuWMlhn/CqZZc/AoSCrWTXtOXnV
         PMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZADBjJCY8s2VfF3t+tekGYSe/SqjmOaEwQVxp8CXR8=;
        b=tNV2pKOwskFJjsOtl6eEhGUtUNF8DH1s+YOcU1U+5lTk59P12Wxyz8dPEtcdaDKyRW
         QolH770HLD3Sl72dgMygEo4GKAqKwCw8BMf8gm74YmkZ6F05P7wQH06A3Lg3aqLJ9BlI
         cct26dk33zDdWMkdVDkmt30dnVruo+TNI52D4ITF59H1hUokhaYU/7NA8AbhS2vcWmcG
         jkxv2rBTPsINxePxg51plIjI6d1Iw3+LkXxpGAmQ3auzAzVgTjT1rkdkFpC+UwbWCVaD
         mEPrlO1kF+N3NNR6oiAoCmgji7RqL6ukC7blxzSyGhnj0EppaiCDodUEjdgkzl3f/hM3
         9mqw==
X-Gm-Message-State: AJcUukcRDnxbryZgJSjCa75FS+QWtA7cj8MZw1jsOSZLkbRd9jMcAiJO
        yHOTvQTqyCqEaw4TkaHfC6JZcyQOzpk=
X-Google-Smtp-Source: ALg8bN5G8rgrHEHX51zKH8eKew//wH2LrkWcZbyTCHAm+aIQipK0d9Di8YBxm7yIxfVjdnpsPrieoA==
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr5200747pgf.302.1548318616862;
        Thu, 24 Jan 2019 00:30:16 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 78sm32942362pft.184.2019.01.24.00.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:30:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:30:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/11] cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
Date:   Thu, 24 Jan 2019 15:29:12 +0700
Message-Id: <20190124082912.24401-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From now on, by default index compat macros are off because they could
hide the_index dependency. Only those in builtin can use it (and even
so should be avoided if possible).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.c                               | 1 -
 builtin/add.c                        | 1 +
 builtin/am.c                         | 1 +
 builtin/blame.c                      | 3 ++-
 builtin/cat-file.c                   | 1 +
 builtin/check-attr.c                 | 1 +
 builtin/check-ignore.c               | 1 +
 builtin/checkout-index.c             | 1 +
 builtin/checkout.c                   | 1 +
 builtin/clean.c                      | 1 +
 builtin/clone.c                      | 1 +
 builtin/commit.c                     | 1 +
 builtin/describe.c                   | 1 +
 builtin/diff-files.c                 | 1 +
 builtin/diff-index.c                 | 1 +
 builtin/diff-tree.c                  | 1 +
 builtin/diff.c                       | 1 +
 builtin/difftool.c                   | 1 +
 builtin/fsck.c                       | 1 +
 builtin/grep.c                       | 1 +
 builtin/hash-object.c                | 3 ++-
 builtin/log.c                        | 1 +
 builtin/ls-files.c                   | 1 -
 builtin/merge-index.c                | 1 +
 builtin/merge-ours.c                 | 1 +
 builtin/merge-tree.c                 | 4 +++-
 builtin/merge.c                      | 1 +
 builtin/mv.c                         | 1 +
 builtin/pack-objects.c               | 2 +-
 builtin/pull.c                       | 1 +
 builtin/read-tree.c                  | 1 +
 builtin/rebase--interactive.c        | 1 +
 builtin/rebase.c                     | 1 +
 builtin/replace.c                    | 2 +-
 builtin/reset.c                      | 1 +
 builtin/rev-parse.c                  | 1 +
 builtin/rm.c                         | 1 +
 builtin/submodule--helper.c          | 1 +
 builtin/update-index.c               | 1 +
 builtin/write-tree.c                 | 1 +
 cache-tree.h                         | 2 +-
 cache.h                              | 6 +++---
 convert.c                            | 1 -
 dir.c                                | 1 -
 git.c                                | 4 ++--
 name-hash.c                          | 1 -
 pathspec.c                           | 1 -
 read-cache.c                         | 2 --
 repository.c                         | 6 ++++++
 submodule.c                          | 1 -
 t/helper/test-dump-fsmonitor.c       | 4 ++--
 t/helper/test-dump-untracked-cache.c | 1 +
 t/helper/test-tool.h                 | 1 +
 tree.c                               | 1 -
 unpack-trees.c                       | 1 -
 55 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/attr.c b/attr.c
index b63fe0fc0e..e4e4574857 100644
--- a/attr.c
+++ b/attr.c
@@ -7,7 +7,6 @@
  * an insanely large number of attributes.
  */
 
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "exec-cmd.h"
diff --git a/builtin/add.c b/builtin/add.c
index f65c172299..81df0d34de 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/am.c b/builtin/am.c
index a9ffc92eaa..ad913ef20e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -3,6 +3,7 @@
  *
  * Based on git-am.sh by Junio C Hamano.
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 6d798f9939..0074ed311c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1007,7 +1007,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		long bottom, top;
 		if (parse_range_arg(range_list.items[range_i].string,
 				    nth_line_cb, &sb, lno, anchor,
-				    &bottom, &top, sb.path, &the_index))
+				    &bottom, &top, sb.path,
+				    the_repository->index))
 			usage(blame_usage);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7622c502f0..a5ca47c697 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 30a2f84274..dd83397786 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index ec9a959e08..599097304b 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index eb74774cbc..345591bc4b 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2005 Linus Torvalds
  *
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a95ba2c6dc..0446cac05e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "checkout.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index bbcdeb2d9e..aaba4af3c2 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -6,6 +6,7 @@
  * Based on git-clean.sh by Pavel Roskin
  */
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 7c7f98c72c..ddb3230d21 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,6 +8,7 @@
  * Clone a repository into a different directory that does not yet exist.
  */
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index d3f1234bf0..2f4af02a27 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -5,6 +5,7 @@
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  */
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index bc97e50650..02ec56417a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 48cfcb935d..86ae474fbf 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index fcccd1f10d..93ec642423 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 42bc1eb41d..a90681bcba 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index ec78920ee2..74351a5757 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 544b0e8639..eeb9e370b9 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -11,6 +11,7 @@
  *
  * Copyright (C) 2016 Johannes Schindelin
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index bf5ddff43f..46f6ea9baa 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "repository.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index fc7a9a9283..39a8e9d4a3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index d6f06ea32f..e055c11103 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -40,7 +40,8 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 	if (fstat(fd, &st) < 0 ||
 	    (literally
 	     ? hash_literally(&oid, fd, type, flags)
-	     : index_fd(&the_index, &oid, fd, &st, type_from_string(type), path, flags)))
+	     : index_fd(the_repository->index, &oid, fd, &st,
+			type_from_string(type), path, flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
diff --git a/builtin/log.c b/builtin/log.c
index dbfb4e31ad..195ff0b471 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -4,6 +4,7 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "refs.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c70a9c7158..7cc7ec22c9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -5,7 +5,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c99443b095..38ea6ad6ca 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "run-command.h"
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 0b07263415..4594507420 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -7,6 +7,7 @@
  *
  * Pretend we resolved the heads, but declare our tree trumps everybody else.
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 70f6fc9167..53719e0b9d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
@@ -76,7 +77,8 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	their = NULL;
 	if (entry)
 		their = entry->blob;
-	return merge_blobs(&the_index, path, base, our, their, size);
+	return merge_blobs(the_repository->index, path,
+			   base, our, their, size);
 }
 
 static void *origin(struct merge_list *entry, unsigned long *size)
diff --git a/builtin/merge.c b/builtin/merge.c
index bc1aecfe70..e47d77baee 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -6,6 +6,7 @@
  * Based on git-merge.sh by Junio C Hamano.
  */
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "parse-options.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 80bb967a63..be15ba7044 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "pathspec.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24bba8147f..d9d3b90b23 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -970,7 +970,7 @@ static int no_try_delta(const char *path)
 
 	if (!check)
 		check = attr_check_initl("delta", NULL);
-	git_check_attr(&the_index, path, check);
+	git_check_attr(the_repository->index, path, check);
 	if (ATTR_FALSE(check->items[0].value))
 		return 1;
 	return 0;
diff --git a/builtin/pull.c b/builtin/pull.c
index 74808b9455..701d1473dc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -5,6 +5,7 @@
  *
  * Fetch one or more remote refs and merge it/them into the current HEAD.
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ac255ad2c2..9083dcfa28 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index dd2a55ab1d..6895322d61 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7124e66d00..b667837276 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2018 Pratik Karki
  */
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "run-command.h"
 #include "exec-cmd.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index affcdfb416..5b80b7f211 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -295,7 +295,7 @@ static int import_object(struct object_id *oid, enum object_type type,
 			close(fd);
 			return -1;
 		}
-		if (index_fd(&the_index, oid, fd, &st, type, NULL, flags) < 0)
+		if (index_fd(the_repository->index, oid, fd, &st, type, NULL, flags) < 0)
 			return error(_("unable to write object to database"));
 		/* index_fd close()s fd for us */
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 59898c972e..4d18a461fa 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,6 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 910a71ed8b..f8bbe6d47e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 17086d3d97..db85b33982 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b45514be31..9c832fc606 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "repository.h"
 #include "cache.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e19da77edc..02ace602b9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index cdcbf8264e..3d46d22ee5 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "cache.h"
 #include "config.h"
diff --git a/cache-tree.h b/cache-tree.h
index 326209198b..757bbc48bc 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -51,7 +51,7 @@ void prime_cache_tree(struct repository *, struct index_state *, struct tree *);
 
 int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
 
-#ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
+#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
 static inline int write_cache_as_tree(struct object_id *oid, int flags, const char *prefix)
 {
 	return write_index_as_tree(oid, &the_index, get_index_file(), flags, prefix);
diff --git a/cache.h b/cache.h
index 326e73f391..962eb127d3 100644
--- a/cache.h
+++ b/cache.h
@@ -338,8 +338,6 @@ struct index_state {
 	struct mem_pool *ce_mem_pool;
 };
 
-extern struct index_state the_index;
-
 /* Name hashing */
 extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
 extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
@@ -401,7 +399,9 @@ struct cache_entry *dup_cache_entry(const struct cache_entry *ce, struct index_s
  */
 void validate_cache_entries(const struct index_state *istate);
 
-#ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
+#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
+extern struct index_state the_index;
+
 #define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
 #define active_alloc (the_index.cache_alloc)
diff --git a/convert.c b/convert.c
index e0848226d2..df8c6a0bf8 100644
--- a/convert.c
+++ b/convert.c
@@ -1,4 +1,3 @@
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "object-store.h"
diff --git a/dir.c b/dir.c
index ab6477d777..80e07441f7 100644
--- a/dir.c
+++ b/dir.c
@@ -7,7 +7,6 @@
  * Copyright (C) Linus Torvalds, 2005-2006
  *		 Junio Hamano, 2005-2006
  */
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
diff --git a/git.c b/git.c
index 4d53a3d50d..0c2b269797 100644
--- a/git.c
+++ b/git.c
@@ -417,9 +417,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	trace_argv_printf(argv, "trace: built-in: git");
 
-	validate_cache_entries(&the_index);
+	validate_cache_entries(the_repository->index);
 	status = p->fn(argc, argv, prefix);
-	validate_cache_entries(&the_index);
+	validate_cache_entries(the_repository->index);
 
 	if (status)
 		return status;
diff --git a/name-hash.c b/name-hash.c
index 623ca6923a..b4861bc7b0 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -5,7 +5,6 @@
  *
  * Copyright (C) 2008 Linus Torvalds
  */
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "thread-utils.h"
 
diff --git a/pathspec.c b/pathspec.c
index 6f005996fd..f1505cfd0a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,4 +1,3 @@
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
diff --git a/read-cache.c b/read-cache.c
index 2549477ed2..b3865d6884 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "diff.h"
@@ -95,7 +94,6 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
 	return *pool_ptr;
 }
 
-struct index_state the_index;
 static const char *alternate_index_output;
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
diff --git a/repository.c b/repository.c
index 9411c4baee..36a3b52d70 100644
--- a/repository.c
+++ b/repository.c
@@ -1,3 +1,8 @@
+/*
+ * not really _using_ the compat macros, just make sure the_index
+ * declaration matches the definition in this file.
+ */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "repository.h"
 #include "object-store.h"
@@ -9,6 +14,7 @@
 /* The main repository */
 static struct repository the_repo;
 struct repository *the_repository;
+struct index_state the_index;
 
 void initialize_the_repository(void)
 {
diff --git a/submodule.c b/submodule.c
index 6415cc5580..4208a50260 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,3 @@
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 
 #include "cache.h"
 #include "repository.h"
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 08e3684aff..2786f47088 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -3,11 +3,11 @@
 
 int cmd__dump_fsmonitor(int ac, const char **av)
 {
-	struct index_state *istate = &the_index;
+	struct index_state *istate = the_repository->index;
 	int i;
 
 	setup_git_directory();
-	if (do_read_index(istate, get_index_file(), 0) < 0)
+	if (do_read_index(istate, the_repository->index_file, 0) < 0)
 		die("unable to read index file");
 	if (!istate->fsmonitor_last_update) {
 		printf("no fsmonitor\n");
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 52870ebbb3..cf0f2c7228 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,3 +1,4 @@
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "test-tool.h"
 #include "cache.h"
 #include "dir.h"
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 042f12464b..f4fb3b9861 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -1,6 +1,7 @@
 #ifndef TEST_TOOL_H
 #define TEST_TOOL_H
 
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "git-compat-util.h"
 
 int cmd__chmtime(int argc, const char **argv);
diff --git a/tree.c b/tree.c
index 215d3fdc7c..181a3778f3 100644
--- a/tree.c
+++ b/tree.c
@@ -1,4 +1,3 @@
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "cache-tree.h"
 #include "tree.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 6d53cbfc86..40f554814d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,3 @@
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "argv-array.h"
 #include "repository.h"
-- 
2.20.1.560.g70ca8b83ee

