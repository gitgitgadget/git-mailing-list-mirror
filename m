From: David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH 3/3] core: improve header dependencies
Date: Sun, 31 Aug 2014 13:11:33 -0700
Message-ID: <1409515893-48017-3-git-send-email-davvid@gmail.com>
References: <1409515893-48017-1-git-send-email-davvid@gmail.com>
 <1409515893-48017-2-git-send-email-davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 22:10:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOBSk-0007zl-85
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 22:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbaHaUKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 16:10:53 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32916 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaHaUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 16:10:46 -0400
Received: by mail-pd0-f175.google.com with SMTP id ft15so4399648pdb.20
        for <git@vger.kernel.org>; Sun, 31 Aug 2014 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=vY5+Pn1D9WhyYxzCcNClKrleRdKhDObYPwaZ8FHwLOc=;
        b=ZY8PFjz5nCjCRWvho94B0P1J2RhtNwru4sMRIMbbwjWO62LCEeSYWa2gNqTMn3AtBq
         kDj3WhGUu0uXiP9rcGUcsZoNPWX7iaKcpVhbxcbdY7T0do2xftV7Wnja0JTUL/nR9BQt
         aTJ93jgYencyYnQ2S0W3Dx1BwwA5EMGc3aOLbVceXEGAUebih68/vKJWmypfcANJJMr/
         zixNg+DiI7f+HiLw88vDXgtSuMKWYKak3W1iJs11UZjkR+MqXbVicw3p2fh0XXyVe9R5
         Pi9AALtiiaDDU3ta7/6NXNpBpvkz0guth/GOLlfIFF9sc35+xeV418NE9rhsIn31QDof
         QhLA==
X-Received: by 10.66.240.197 with SMTP id wc5mr33825714pac.87.1409515845518;
        Sun, 31 Aug 2014 13:10:45 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ps1sm8947446pdb.73.2014.08.31.13.10.44
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 31 Aug 2014 13:10:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g0bdc89a
In-Reply-To: <1409515893-48017-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256297>

Remove includes that have already been included by another header.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch is the culmination of the previous patches and
is a pure removal.

 builtin/add.c           | 3 ---
 builtin/blame.c         | 4 ----
 builtin/branch.c        | 4 ----
 builtin/checkout.c      | 4 ----
 builtin/diff-files.c    | 3 ---
 builtin/diff-index.c    | 3 ---
 builtin/diff.c          | 3 ---
 builtin/fast-export.c   | 7 -------
 builtin/fmt-merge-msg.c | 5 -----
 builtin/log.c           | 6 ------
 builtin/merge-base.c    | 4 ----
 builtin/merge.c         | 5 -----
 builtin/pack-objects.c  | 4 ----
 builtin/prune.c         | 4 ----
 builtin/reflog.c        | 3 ---
 builtin/rev-list.c      | 3 ---
 builtin/rev-parse.c     | 4 ----
 builtin/revert.c        | 3 ---
 builtin/shortlog.c      | 5 -----
 builtin/tag.c           | 4 ----
 bundle.c                | 4 ----
 combine-diff.c          | 3 ---
 commit.c                | 5 -----
 diff-lib.c              | 3 ---
 diff-no-index.c         | 4 ----
 graph.c                 | 3 ---
 http-push.c             | 3 ---
 line-log.c              | 7 -------
 list-objects.c          | 4 ----
 pack-bitmap-write.c     | 3 ---
 pack-bitmap.c           | 3 ---
 pretty.c                | 5 -----
 reachable.c             | 3 ---
 reflog-walk.c           | 4 ----
 remote.c                | 4 ----
 revision.c              | 6 ------
 sequencer.c             | 4 ----
 shallow.c               | 3 ---
 submodule.c             | 4 ----
 test-revision-walking.c | 3 ---
 transport-helper.c      | 4 ----
 upload-pack.c           | 5 -----
 wt-status.c             | 5 -----
 43 files changed, 173 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4baf3a5..3e898d2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,15 +3,12 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-#include "cache.h"
 #include "builtin.h"
 #include "dir.h"
 #include "pathspec.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
 #include "run-command.h"
-#include "parse-options.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "bulk-checkin.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 17d30d0..84e44ff 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -8,19 +8,15 @@
 #include "cache.h"
 #include "builtin.h"
 #include "blob.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "cache-tree.h"
-#include "string-list.h"
 #include "mailmap.h"
 #include "mergesort.h"
-#include "parse-options.h"
 #include "prio-queue.h"
 #include "utf8.h"
 #include "userdiff.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 0591b22..f4adb93 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -8,14 +8,10 @@
 #include "cache.h"
 #include "color.h"
 #include "refs.h"
-#include "commit.h"
 #include "builtin.h"
 #include "remote.h"
-#include "parse-options.h"
 #include "branch.h"
-#include "diff.h"
 #include "revision.h"
-#include "string-list.h"
 #include "column.h"
 #include "utf8.h"
 #include "wt-status.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f71e745..bc53824 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,9 +1,6 @@
 #include "cache.h"
 #include "builtin.h"
-#include "parse-options.h"
 #include "refs.h"
-#include "commit.h"
-#include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
@@ -11,7 +8,6 @@
 #include "run-command.h"
 #include "merge-recursive.h"
 #include "branch.h"
-#include "diff.h"
 #include "revision.h"
 #include "remote.h"
 #include "blob.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 9200069..d538a38 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,9 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
-#include "diff.h"
-#include "commit.h"
 #include "revision.h"
 #include "builtin.h"
 #include "submodule.h"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index ce15b23..7e998b0 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,6 +1,3 @@
-#include "cache.h"
-#include "diff.h"
-#include "commit.h"
 #include "revision.h"
 #include "builtin.h"
 #include "submodule.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 0f247d2..aad7b98 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -3,12 +3,9 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-#include "cache.h"
 #include "color.h"
-#include "commit.h"
 #include "blob.h"
 #include "tag.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 92b4624..71c4309 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -4,18 +4,11 @@
  * Copyright (C) 2007 Johannes E. Schindelin
  */
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
-#include "object.h"
 #include "tag.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "log-tree.h"
 #include "revision.h"
-#include "decorate.h"
-#include "string-list.h"
 #include "utf8.h"
-#include "parse-options.h"
 #include "quote.h"
 #include "remote.h"
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 79df05e..85a2ba1 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,13 +1,8 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "tag.h"
-#include "string-list.h"
 #include "branch.h"
 #include "fmt-merge-msg.h"
-#include "gpg-interface.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	N_("git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]"),
diff --git a/builtin/log.c b/builtin/log.c
index 4389722..ab1f11f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -4,10 +4,7 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
-#include "cache.h"
 #include "color.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
@@ -17,14 +14,11 @@
 #include "run-command.h"
 #include "shortlog.h"
 #include "remote.h"
-#include "string-list.h"
-#include "parse-options.h"
 #include "line-log.h"
 #include "branch.h"
 #include "streaming.h"
 #include "version.h"
 #include "mailmap.h"
-#include "gpg-interface.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0ecde8d..08b9ba5 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,10 +1,6 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
 #include "refs.h"
-#include "diff.h"
 #include "revision.h"
-#include "parse-options.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
diff --git a/builtin/merge.c b/builtin/merge.c
index ce82eb2..4f15ae6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -6,13 +6,9 @@
  * Based on git-merge.sh by Junio C Hamano.
  */
 
-#include "cache.h"
-#include "parse-options.h"
 #include "builtin.h"
 #include "run-command.h"
-#include "diff.h"
 #include "refs.h"
-#include "commit.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "unpack-trees.h"
@@ -27,7 +23,6 @@
 #include "resolve-undo.h"
 #include "remote.h"
 #include "fmt-merge-msg.h"
-#include "gpg-interface.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b59f5d8..a0422a0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,9 +1,6 @@
 #include "builtin.h"
-#include "cache.h"
 #include "attr.h"
-#include "object.h"
 #include "blob.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree.h"
 #include "delta.h"
@@ -11,7 +8,6 @@
 #include "pack-revindex.h"
 #include "csum-file.h"
 #include "tree-walk.h"
-#include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "pack-objects.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 144a3bd..c7c3472 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,10 +1,6 @@
-#include "cache.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "builtin.h"
 #include "reachable.h"
-#include "parse-options.h"
 #include "progress.h"
 #include "dir.h"
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index e8a8fb1..6a55904 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,10 +1,7 @@
-#include "cache.h"
 #include "builtin.h"
-#include "commit.h"
 #include "refs.h"
 #include "dir.h"
 #include "tree-walk.h"
-#include "diff.h"
 #include "revision.h"
 #include "reachable.h"
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..7165d4d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -1,6 +1,3 @@
-#include "cache.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "pack.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d85e08c..959d316 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,13 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
-#include "commit.h"
 #include "refs.h"
 #include "quote.h"
 #include "builtin.h"
-#include "parse-options.h"
-#include "diff.h"
 #include "revision.h"
 #include "split-index.h"
 
diff --git a/builtin/revert.c b/builtin/revert.c
index f9ed5bd..51e78a6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,7 +1,4 @@
-#include "cache.h"
 #include "builtin.h"
-#include "parse-options.h"
-#include "diff.h"
 #include "revision.h"
 #include "rerere.h"
 #include "dir.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 4b7e536..4a20169 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,13 +1,8 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
-#include "diff.h"
-#include "string-list.h"
 #include "revision.h"
 #include "utf8.h"
 #include "mailmap.h"
 #include "shortlog.h"
-#include "parse-options.h"
 
 static char const * const shortlog_usage[] = {
 	N_("git shortlog [<options>] [<revision range>] [[--] [<path>...]]"),
diff --git a/builtin/tag.c b/builtin/tag.c
index 19eb747..4776499 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -6,15 +6,11 @@
  * Based on git-tag.sh and mktag.c by Linus Torvalds.
  */
 
-#include "cache.h"
 #include "builtin.h"
 #include "refs.h"
 #include "tag.h"
 #include "run-command.h"
-#include "parse-options.h"
-#include "diff.h"
 #include "revision.h"
-#include "gpg-interface.h"
 #include "sha1-array.h"
 #include "column.h"
 
diff --git a/bundle.c b/bundle.c
index 71a21a6..bd14989 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,8 +1,4 @@
-#include "cache.h"
 #include "bundle.h"
-#include "object.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
diff --git a/combine-diff.c b/combine-diff.c
index 60cb4f8..98d2f0b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,7 +1,4 @@
-#include "cache.h"
-#include "commit.h"
 #include "blob.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "quote.h"
 #include "xdiff-interface.h"
diff --git a/commit.c b/commit.c
index 4de6be4..0c311c4 100644
--- a/commit.c
+++ b/commit.c
@@ -1,12 +1,7 @@
-#include "cache.h"
 #include "tag.h"
-#include "commit.h"
 #include "pkt-line.h"
 #include "utf8.h"
-#include "diff.h"
 #include "revision.h"
-#include "notes.h"
-#include "gpg-interface.h"
 #include "mergesort.h"
 #include "commit-slab.h"
 #include "prio-queue.h"
diff --git a/diff-lib.c b/diff-lib.c
index 875aff8..9816d7e 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -1,10 +1,7 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
-#include "cache.h"
 #include "quote.h"
-#include "commit.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "cache-tree.h"
diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..1bbca98 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -4,17 +4,13 @@
  * Copyright (c) 2008 by Junio C Hamano
  */
 
-#include "cache.h"
 #include "color.h"
-#include "commit.h"
 #include "blob.h"
 #include "tag.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
-#include "string-list.h"
 #include "dir.h"
 
 static int read_directory_contents(const char *path, struct string_list *list)
diff --git a/graph.c b/graph.c
index 6404331..cffaf2f 100644
--- a/graph.c
+++ b/graph.c
@@ -1,8 +1,5 @@
-#include "cache.h"
-#include "commit.h"
 #include "color.h"
 #include "graph.h"
-#include "diff.h"
 #include "revision.h"
 
 /* Internal API */
diff --git a/http-push.c b/http-push.c
index 952f8ed..4877efe 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,10 +1,7 @@
-#include "cache.h"
-#include "commit.h"
 #include "tag.h"
 #include "blob.h"
 #include "http.h"
 #include "refs.h"
-#include "diff.h"
 #include "revision.h"
 #include "exec_cmd.h"
 #include "remote.h"
diff --git a/line-log.c b/line-log.c
index 1008e72..a026ce0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,15 +1,8 @@
-#include "git-compat-util.h"
 #include "line-range.h"
-#include "cache.h"
 #include "tag.h"
 #include "blob.h"
-#include "tree.h"
-#include "diff.h"
-#include "commit.h"
-#include "decorate.h"
 #include "revision.h"
 #include "xdiff-interface.h"
-#include "strbuf.h"
 #include "log-tree.h"
 #include "graph.h"
 #include "userdiff.h"
diff --git a/list-objects.c b/list-objects.c
index 3595ee7..7f1a55e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,9 +1,5 @@
-#include "cache.h"
 #include "tag.h"
-#include "commit.h"
-#include "tree.h"
 #include "blob.h"
-#include "diff.h"
 #include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5f1791a..f2530df 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,7 +1,4 @@
-#include "cache.h"
-#include "commit.h"
 #include "tag.h"
-#include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "progress.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 91e4101..a250c6e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,7 +1,4 @@
-#include "cache.h"
-#include "commit.h"
 #include "tag.h"
-#include "diff.h"
 #include "revision.h"
 #include "progress.h"
 #include "list-objects.h"
diff --git a/pretty.c b/pretty.c
index 3a1da6f..fde24ab 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,15 +1,10 @@
-#include "cache.h"
-#include "commit.h"
 #include "utf8.h"
-#include "diff.h"
 #include "revision.h"
-#include "string-list.h"
 #include "mailmap.h"
 #include "log-tree.h"
 #include "notes.h"
 #include "color.h"
 #include "reflog-walk.h"
-#include "gpg-interface.h"
 
 static char *user_format;
 static struct cmt_fmt_map {
diff --git a/reachable.c b/reachable.c
index 654a8c5..819de18 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,9 +1,6 @@
-#include "cache.h"
 #include "refs.h"
 #include "tag.h"
-#include "commit.h"
 #include "blob.h"
-#include "diff.h"
 #include "revision.h"
 #include "reachable.h"
 #include "cache-tree.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index 0e5174b..a21529a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,9 +1,5 @@
-#include "cache.h"
-#include "commit.h"
 #include "refs.h"
-#include "diff.h"
 #include "revision.h"
-#include "string-list.h"
 #include "reflog-walk.h"
 
 struct complete_reflogs {
diff --git a/remote.c b/remote.c
index 3d6c86a..682901e 100644
--- a/remote.c
+++ b/remote.c
@@ -1,12 +1,8 @@
-#include "cache.h"
 #include "remote.h"
 #include "refs.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "dir.h"
 #include "tag.h"
-#include "string-list.h"
 #include "mergesort.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
diff --git a/revision.c b/revision.c
index 2571ada..5de4299 100644
--- a/revision.c
+++ b/revision.c
@@ -1,18 +1,12 @@
-#include "cache.h"
 #include "tag.h"
 #include "blob.h"
-#include "tree.h"
-#include "commit.h"
-#include "diff.h"
 #include "refs.h"
 #include "revision.h"
 #include "graph.h"
 #include "grep.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
-#include "decorate.h"
 #include "log-tree.h"
-#include "string-list.h"
 #include "line-log.h"
 #include "mailmap.h"
 #include "commit-slab.h"
diff --git a/sequencer.c b/sequencer.c
index 3c060e0..c051d6c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,14 +1,10 @@
-#include "cache.h"
 #include "sequencer.h"
 #include "dir.h"
-#include "object.h"
-#include "commit.h"
 #include "tag.h"
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "utf8.h"
 #include "cache-tree.h"
-#include "diff.h"
 #include "revision.h"
 #include "rerere.h"
 #include "merge-recursive.h"
diff --git a/shallow.c b/shallow.c
index de07709..3a0b0be 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,11 +1,8 @@
-#include "cache.h"
-#include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
 #include "remote.h"
 #include "refs.h"
 #include "sha1-array.h"
-#include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
 #include "sigchain.h"
diff --git a/submodule.c b/submodule.c
index c3a61e7..0ef37bf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,13 +1,9 @@
-#include "cache.h"
 #include "submodule.h"
 #include "dir.h"
-#include "diff.h"
-#include "commit.h"
 #include "revision.h"
 #include "run-command.h"
 #include "diffcore.h"
 #include "refs.h"
-#include "string-list.h"
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "blob.h"
diff --git a/test-revision-walking.c b/test-revision-walking.c
index 3ade02c..5e25896 100644
--- a/test-revision-walking.c
+++ b/test-revision-walking.c
@@ -8,9 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-#include "cache.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 
 static void print_commit(struct commit *commit)
diff --git a/transport-helper.c b/transport-helper.c
index 3d8fe7d..02ecc9f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1,13 +1,9 @@
-#include "cache.h"
 #include "transport.h"
 #include "quote.h"
 #include "run-command.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "quote.h"
 #include "remote.h"
-#include "string-list.h"
 #include "thread-utils.h"
 #include "sigchain.h"
 #include "argv-array.h"
diff --git a/upload-pack.c b/upload-pack.c
index 01de944..b4e6565 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,19 +1,14 @@
-#include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "tag.h"
-#include "object.h"
-#include "commit.h"
 #include "exec_cmd.h"
-#include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
 #include "connect.h"
 #include "sigchain.h"
 #include "version.h"
-#include "string-list.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
diff --git a/wt-status.c b/wt-status.c
index 27da529..37bc32e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,10 +1,6 @@
-#include "cache.h"
 #include "pathspec.h"
 #include "wt-status.h"
-#include "object.h"
 #include "dir.h"
-#include "commit.h"
-#include "diff.h"
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
@@ -14,7 +10,6 @@
 #include "refs.h"
 #include "submodule.h"
 #include "column.h"
-#include "strbuf.h"
 #include "utf8.h"
 
 static const char cut_line[] =
-- 
2.1.0.30.g0bdc89a
