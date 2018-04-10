Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BDF1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeDJV0k (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:26:40 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:39167 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJV0h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:26:37 -0400
Received: by mail-pl0-f46.google.com with SMTP id e7-v6so6330480plt.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VX15SeDt0B/n7hM7mul2Y8Kqt0mhx0TI/NFoYrki8Y8=;
        b=Q5c6yDOyWhArLFlL20V3yi1v8OCD/CeOY3qNnWViww/9RTP5IYhK5V0TilcS5EeFBl
         YdlBjbhw4kAkymU8gHNc9qBvBAOZE8xVjpTSdhSTmJELjmQsYr9XMx6Mq0A+Qdjdbvs7
         ntvn7+5VGe4O/eIUGMMzygwHby8Wa+P8J8BqLMnJ0JkrlNtiKGUsaqd9LYUx6i51sKTi
         S5G6fTX4ppO11mKB9knRdp2cGBuX9XaKBHCxeT53FfxNFLIapXTP60fO0Sx9HkzioL3B
         PF0gMI9ryBE/XbfrmNNvvVassT7fpsbradtVOXPOwhe3puj2wUqcPSYaJWjx99pSvhnD
         8IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VX15SeDt0B/n7hM7mul2Y8Kqt0mhx0TI/NFoYrki8Y8=;
        b=LjFGSWIhRBq2Zhs+kFvIjEvwJCKUj2ZvD+VYS46kL/Wx2Ap6XaA9KLUq+d3aHnSFSR
         nREgn0f9NoVpoiS8GMuM7y7XqT/vved+TQGncJtUMxGKdLjuDh0JpxwQC1bDOinaPeYE
         NDibaJs+JnxPhg63+ptI9XHLnrJTFUx0mU3EieoydsAx17wACZENeSJ0UneYSKd7BJn2
         KJe/wyeTwdXuVQ3ez3FpIQdlCfsgsFFXg/dg5IVDyD8J9E/Pjdp+hJ92enNPb+jqSr0/
         9fmwNLe2O/y+rx9kDxS+Gm30KhIroLG56tg8caJS4igI8Ht3nlVex9FC/f3PUvKsV+zc
         uTHg==
X-Gm-Message-State: ALQs6tAexnXbISraD3VJ99MqZeFFUiAmqP7MkUcRa4edpOpgncb7WJTg
        lugEPGdf31ssia0THga8etItLg==
X-Google-Smtp-Source: AIpwx49enb3AYV3O4x52sDs47mu+c/5PDGm4agRmdUg/kZiGePSxyG9wPen3l4eKujw/MA9+bh9dJw==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8-v6mr2089731plp.29.1523395596708;
        Tue, 10 Apr 2018 14:26:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f12sm6425154pfn.47.2018.04.10.14.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:26:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com,
        l.s.r@web.de, pclouds@gmail.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 3/6] exec_cmd: rename to use dash in file name
Date:   Tue, 10 Apr 2018 14:26:18 -0700
Message-Id: <20180410212621.259409-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180410212621.259409-1-sbeller@google.com>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com>
 <20180410212621.259409-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more consistent with the project style. The majority of Git's
source files use dashes in preference to underscores in their file names.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile                 | 6 +++---
 attr.c                   | 2 +-
 builtin/add.c            | 2 +-
 builtin/am.c             | 2 +-
 builtin/describe.c       | 2 +-
 builtin/difftool.c       | 2 +-
 builtin/hash-object.c    | 2 +-
 builtin/help.c           | 2 +-
 builtin/index-pack.c     | 2 +-
 builtin/init-db.c        | 2 +-
 builtin/merge-tree.c     | 2 +-
 builtin/notes.c          | 2 +-
 builtin/pull.c           | 2 +-
 builtin/receive-pack.c   | 2 +-
 common-main.c            | 2 +-
 config.c                 | 2 +-
 exec_cmd.c => exec-cmd.c | 2 +-
 exec_cmd.h => exec-cmd.h | 0
 fetch-pack.c             | 2 +-
 git.c                    | 2 +-
 help.c                   | 2 +-
 http-backend.c           | 2 +-
 http-fetch.c             | 2 +-
 http-push.c              | 2 +-
 imap-send.c              | 2 +-
 remote-curl.c            | 2 +-
 remote-testsvn.c         | 2 +-
 run-command.c            | 2 +-
 sequencer.c              | 2 +-
 shell.c                  | 2 +-
 upload-pack.c            | 2 +-
 31 files changed, 32 insertions(+), 32 deletions(-)
 rename exec_cmd.c => exec-cmd.c (99%)
 rename exec_cmd.h => exec-cmd.h (100%)

diff --git a/Makefile b/Makefile
index be4ac5b2a6..f608c592b7 100644
--- a/Makefile
+++ b/Makefile
@@ -815,7 +815,7 @@ LIB_OBJS += ewah/bitmap.o
 LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
-LIB_OBJS += exec_cmd.o
+LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
@@ -2152,8 +2152,8 @@ else
 $(OBJECTS): $(LIB_H)
 endif
 
-exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
-exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
+exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
+exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
diff --git a/attr.c b/attr.c
index dfc3a558d8..03a678fa9b 100644
--- a/attr.c
+++ b/attr.c
@@ -10,7 +10,7 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "attr.h"
 #include "dir.h"
 #include "utf8.h"
diff --git a/builtin/add.c b/builtin/add.c
index 9ef7fb02d5..c9e2619a9a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -9,7 +9,7 @@
 #include "lockfile.h"
 #include "dir.h"
 #include "pathspec.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "cache-tree.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/builtin/am.c b/builtin/am.c
index 1bcc3606c5..269743ff76 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -6,7 +6,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "parse-options.h"
 #include "dir.h"
 #include "run-command.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index de840f96a4..b5afc45846 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -6,7 +6,7 @@
 #include "blob.h"
 #include "refs.h"
 #include "builtin.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "parse-options.h"
 #include "revision.h"
 #include "diff.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index ee8dce019e..aad0e073ee 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -15,7 +15,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "run-command.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "parse-options.h"
 #include "argv-array.h"
 #include "strbuf.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 526da5c185..a9a3a198c3 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -9,7 +9,7 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 
 /*
  * This is to create corrupt objects for debugging and as such it
diff --git a/builtin/help.c b/builtin/help.c
index 598867cfea..2d51071429 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -4,7 +4,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "column.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 657a5dda06..e89c039b56 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -9,7 +9,7 @@
 #include "tree.h"
 #include "progress.h"
 #include "fsck.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packfile.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 68ff4ad75a..2542c5244e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -7,7 +7,7 @@
 #include "config.h"
 #include "refs.h"
 #include "builtin.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "parse-options.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 32736e0b10..bf01e05808 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -2,7 +2,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "merge-blobs.h"
 
 static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
diff --git a/builtin/notes.c b/builtin/notes.c
index 921e08d5bf..e5bf80eef1 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -14,7 +14,7 @@
 #include "blob.h"
 #include "pretty.h"
 #include "refs.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index e32d6cd5b4..71aac5005e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -9,7 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "run-command.h"
 #include "sha1-array.h"
 #include "remote.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2bf7f2d1a3..3bbb7097aa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -6,7 +6,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "commit.h"
 #include "object.h"
 #include "remote.h"
diff --git a/common-main.c b/common-main.c
index 7d716d5a54..b989e136b5 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "attr.h"
 
 /*
diff --git a/config.c b/config.c
index c698988f5e..e2b87b4764 100644
--- a/config.c
+++ b/config.c
@@ -9,7 +9,7 @@
 #include "config.h"
 #include "repository.h"
 #include "lockfile.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "strbuf.h"
 #include "quote.h"
 #include "hashmap.h"
diff --git a/exec_cmd.c b/exec-cmd.c
similarity index 99%
rename from exec_cmd.c
rename to exec-cmd.c
index ce192a2d64..8a8261746a 100644
--- a/exec_cmd.c
+++ b/exec-cmd.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "quote.h"
 #include "argv-array.h"
 #define MAX_ARGS	32
diff --git a/exec_cmd.h b/exec-cmd.h
similarity index 100%
rename from exec_cmd.h
rename to exec-cmd.h
diff --git a/fetch-pack.c b/fetch-pack.c
index 52932b37f8..1c8b60c434 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -5,7 +5,7 @@
 #include "pkt-line.h"
 #include "commit.h"
 #include "tag.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "pack.h"
 #include "sideband.h"
 #include "fetch-pack.h"
diff --git a/git.c b/git.c
index 3a89893712..f598fae7b7 100644
--- a/git.c
+++ b/git.c
@@ -1,6 +1,6 @@
 #include "builtin.h"
 #include "config.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "help.h"
 #include "run-command.h"
 
diff --git a/help.c b/help.c
index 60071a9bea..a4feef2ffe 100644
--- a/help.c
+++ b/help.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "run-command.h"
 #include "levenshtein.h"
 #include "help.h"
diff --git a/http-backend.c b/http-backend.c
index f3dc218b2a..7f62efcd89 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -4,7 +4,7 @@
 #include "pkt-line.h"
 #include "object.h"
 #include "tag.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "run-command.h"
 #include "string-list.h"
 #include "url.h"
diff --git a/http-fetch.c b/http-fetch.c
index 8af380050c..885e471501 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "config.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "http.h"
 #include "walker.h"
 
diff --git a/http-push.c b/http-push.c
index ff82b63133..fcd3a6ce83 100644
--- a/http-push.c
+++ b/http-push.c
@@ -6,7 +6,7 @@
 #include "refs.h"
 #include "diff.h"
 #include "revision.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "remote.h"
 #include "list-objects.h"
 #include "sigchain.h"
diff --git a/imap-send.c b/imap-send.c
index ffb0a6eca8..3573cbfb0f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -24,7 +24,7 @@
 #include "cache.h"
 #include "config.h"
 #include "credential.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "run-command.h"
 #include "parse-options.h"
 #ifdef NO_OPENSSL
diff --git a/remote-curl.c b/remote-curl.c
index a7c4c9b5ff..8d2ffaf8de 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -4,7 +4,7 @@
 #include "strbuf.h"
 #include "walker.h"
 #include "http.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "run-command.h"
 #include "pkt-line.h"
 #include "string-list.h"
diff --git a/remote-testsvn.c b/remote-testsvn.c
index c4bb9a8ba9..444d98059f 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -3,7 +3,7 @@
 #include "remote.h"
 #include "strbuf.h"
 #include "url.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "run-command.h"
 #include "vcs-svn/svndump.h"
 #include "notes.h"
diff --git a/run-command.c b/run-command.c
index 84899e423f..12c94c1dbe 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "sigchain.h"
 #include "argv-array.h"
 #include "thread-utils.h"
diff --git a/sequencer.c b/sequencer.c
index 667f35ebdf..6d631d25c6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -7,7 +7,7 @@
 #include "sequencer.h"
 #include "tag.h"
 #include "run-command.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "utf8.h"
 #include "cache-tree.h"
 #include "diff.h"
diff --git a/shell.c b/shell.c
index 234b2d4f16..0200d10796 100644
--- a/shell.c
+++ b/shell.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "quote.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "strbuf.h"
 #include "run-command.h"
 
diff --git a/upload-pack.c b/upload-pack.c
index 4a82602be5..6261d4fab3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -6,7 +6,7 @@
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
-#include "exec_cmd.h"
+#include "exec-cmd.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
-- 
2.17.0.484.g0c8726318c-goog

