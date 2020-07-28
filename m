Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6FC433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B586120809
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgG1UXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:23:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:40198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgG1UXn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:23:43 -0400
Received: (qmail 29719 invoked by uid 109); 28 Jul 2020 20:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 20:23:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28499 invoked by uid 111); 28 Jul 2020 20:23:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 16:23:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 16:23:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/11] strvec: rename files from argv-array to strvec
Message-ID: <20200728202339.GC1021513@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728202124.GA1021264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This requires updating #include lines across the code-base, but that's
all fairly mechanical, and was done with:

  git ls-files '*.c' '*.h' |
  xargs perl -i -pe 's/argv-array.h/strvec.h/'

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                      | 2 +-
 add-patch.c                   | 2 +-
 bisect.c                      | 2 +-
 builtin/add.c                 | 2 +-
 builtin/annotate.c            | 2 +-
 builtin/bisect--helper.c      | 2 +-
 builtin/bundle.c              | 2 +-
 builtin/describe.c            | 2 +-
 builtin/difftool.c            | 2 +-
 builtin/fetch.c               | 2 +-
 builtin/gc.c                  | 2 +-
 builtin/pack-objects.c        | 2 +-
 builtin/rebase.c              | 2 +-
 builtin/receive-pack.c        | 2 +-
 builtin/remote.c              | 2 +-
 builtin/repack.c              | 2 +-
 builtin/show-branch.c         | 2 +-
 builtin/stash.c               | 2 +-
 builtin/update-ref.c          | 2 +-
 builtin/upload-archive.c      | 2 +-
 builtin/worktree.c            | 2 +-
 bundle.c                      | 2 +-
 bundle.h                      | 2 +-
 diff.c                        | 2 +-
 environment.c                 | 2 +-
 exec-cmd.c                    | 2 +-
 graph.c                       | 2 +-
 http-backend.c                | 2 +-
 http-push.c                   | 2 +-
 line-log.c                    | 2 +-
 list-objects-filter-options.c | 2 +-
 ls-refs.c                     | 2 +-
 parse-options-cb.c            | 2 +-
 pathspec.c                    | 2 +-
 quote.c                       | 2 +-
 range-diff.c                  | 2 +-
 range-diff.h                  | 2 +-
 ref-filter.c                  | 2 +-
 refs.c                        | 2 +-
 refspec.c                     | 2 +-
 remote-curl.c                 | 2 +-
 remote-testsvn.c              | 2 +-
 remote.c                      | 2 +-
 revision.c                    | 2 +-
 run-command.c                 | 2 +-
 run-command.h                 | 2 +-
 sequencer.c                   | 2 +-
 serve.c                       | 2 +-
 argv-array.c => strvec.c      | 2 +-
 argv-array.h => strvec.h      | 6 +++---
 submodule.c                   | 2 +-
 t/helper/test-run-command.c   | 2 +-
 t/helper/test-trace2.c        | 2 +-
 tmp-objdir.c                  | 2 +-
 transport-helper.c            | 2 +-
 unpack-trees.c                | 2 +-
 unpack-trees.h                | 2 +-
 upload-pack.c                 | 2 +-
 wt-status.c                   | 2 +-
 59 files changed, 61 insertions(+), 61 deletions(-)
 rename argv-array.c => strvec.c (98%)
 rename argv-array.h => strvec.h (97%)

diff --git a/Makefile b/Makefile
index 372139f1f2..65f8cfb236 100644
--- a/Makefile
+++ b/Makefile
@@ -828,7 +828,6 @@ LIB_OBJS += apply.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += archive.o
-LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
@@ -986,6 +985,7 @@ LIB_OBJS += sigchain.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
+LIB_OBJS += strvec.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += sub-process.o
diff --git a/add-patch.c b/add-patch.c
index f899389e2c..09d00c5574 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -2,7 +2,7 @@
 #include "add-interactive.h"
 #include "strbuf.h"
 #include "run-command.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "pathspec.h"
 #include "color.h"
 #include "diff.h"
diff --git a/bisect.c b/bisect.c
index d5e830410f..3160e82e96 100644
--- a/bisect.c
+++ b/bisect.c
@@ -11,7 +11,7 @@
 #include "log-tree.h"
 #include "bisect.h"
 #include "oid-array.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "commit-slab.h"
 #include "commit-reach.h"
 #include "object-store.h"
diff --git a/builtin/add.c b/builtin/add.c
index 298e0114f9..6cd9a4cd77 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -18,7 +18,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "bulk-checkin.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
 
diff --git a/builtin/annotate.c b/builtin/annotate.c
index da413ae0d1..4353448712 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -5,7 +5,7 @@
  */
 #include "git-compat-util.h"
 #include "builtin.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 int cmd_annotate(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ec4996282e..e929315b38 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,7 +4,7 @@
 #include "bisect.h"
 #include "refs.h"
 #include "dir.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "run-command.h"
 #include "prompt.h"
 #include "quote.h"
diff --git a/builtin/bundle.c b/builtin/bundle.c
index f049d27a14..51fc6d9739 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "parse-options.h"
 #include "cache.h"
 #include "bundle.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 21d2cb9e57..32ad6822f7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -12,7 +12,7 @@
 #include "revision.h"
 #include "diff.h"
 #include "hashmap.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "run-command.h"
 #include "object-store.h"
 #include "list-objects.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index c280e682b2..c0608a78d9 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -18,7 +18,7 @@
 #include "run-command.h"
 #include "exec-cmd.h"
 #include "parse-options.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "strbuf.h"
 #include "lockfile.h"
 #include "object-store.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82ac4be8a5..b183b55ee9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -19,7 +19,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "connected.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "utf8.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 8e0b9cf41b..27951ee061 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -18,7 +18,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "sigchain.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "commit.h"
 #include "commit-graph.h"
 #include "packfile.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7016b28485..5f18f0ee9d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -27,7 +27,7 @@
 #include "delta-islands.h"
 #include "reachable.h"
 #include "oid-array.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "list.h"
 #include "packfile.h"
 #include "object-store.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 37ba76ac3d..38145a66ed 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -8,7 +8,7 @@
 #include "builtin.h"
 #include "run-command.h"
 #include "exec-cmd.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "dir.h"
 #include "packfile.h"
 #include "refs.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d43663bb0a..1285631481 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -15,7 +15,7 @@
 #include "string-list.h"
 #include "oid-array.h"
 #include "connected.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "version.h"
 #include "tag.h"
 #include "gpg-interface.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index e8377994e5..a9f35ba855 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -10,7 +10,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-store.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "commit-reach.h"
 
 static const char * const builtin_remote_usage[] = {
diff --git a/builtin/repack.c b/builtin/repack.c
index df287739d9..8bccb38a28 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -7,7 +7,7 @@
 #include "sigchain.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "midx.h"
 #include "packfile.h"
 #include "prune-packed.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7e52ee9126..f0a70538c3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -4,7 +4,7 @@
 #include "refs.h"
 #include "builtin.h"
 #include "color.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "parse-options.h"
 #include "dir.h"
 #include "commit-slab.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 0c52a3b849..1acf216254 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -7,7 +7,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "merge-recursive.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "run-command.h"
 #include "dir.h"
 #include "rerere.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index b74dd9a69d..8a2df4459c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "quote.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [<options>] -d <refname> [<old-val>]"),
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 018879737a..7fc8e0e82d 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -7,7 +7,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 static const char upload_archive_usage[] =
 	"git upload-archive <repo>";
diff --git a/builtin/worktree.c b/builtin/worktree.c
index f0cbdef718..35945096f6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "dir.h"
 #include "parse-options.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "branch.h"
 #include "refs.h"
 #include "run-command.h"
diff --git a/bundle.c b/bundle.c
index 2a0d744d3f..d46a387e66 100644
--- a/bundle.c
+++ b/bundle.c
@@ -10,7 +10,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 #include "refs.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
diff --git a/bundle.h b/bundle.h
index 2dc9442024..2cf1270092 100644
--- a/bundle.h
+++ b/bundle.h
@@ -1,7 +1,7 @@
 #ifndef BUNDLE_H
 #define BUNDLE_H
 
-#include "argv-array.h"
+#include "strvec.h"
 #include "cache.h"
 
 struct ref_list {
diff --git a/diff.c b/diff.c
index d24aaa3047..ee008155e4 100644
--- a/diff.c
+++ b/diff.c
@@ -20,7 +20,7 @@
 #include "hashmap.h"
 #include "ll-merge.h"
 #include "string-list.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "graph.h"
 #include "packfile.h"
 #include "parse-options.h"
diff --git a/environment.c b/environment.c
index aaca0e91ac..75fe5f4c56 100644
--- a/environment.c
+++ b/environment.c
@@ -14,7 +14,7 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "object-store.h"
 #include "chdir-notify.h"
 #include "shallow.h"
diff --git a/exec-cmd.c b/exec-cmd.c
index 7deeab3039..bb24c2f3bc 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "exec-cmd.h"
 #include "quote.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 #if defined(RUNTIME_PREFIX)
 
diff --git a/graph.c b/graph.c
index 4cd9915075..96af8f605a 100644
--- a/graph.c
+++ b/graph.c
@@ -4,7 +4,7 @@
 #include "color.h"
 #include "graph.h"
 #include "revision.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 /* Internal API */
 
diff --git a/http-backend.c b/http-backend.c
index ec3144b444..6a42badf33 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -9,7 +9,7 @@
 #include "run-command.h"
 #include "string-list.h"
 #include "url.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "protocol.h"
diff --git a/http-push.c b/http-push.c
index 1ff1883cdd..3a47921cc3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -11,7 +11,7 @@
 #include "remote.h"
 #include "list-objects.h"
 #include "sigchain.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "commit-reach.h"
diff --git a/line-log.c b/line-log.c
index c53692834d..05d077b8e7 100644
--- a/line-log.c
+++ b/line-log.c
@@ -14,7 +14,7 @@
 #include "graph.h"
 #include "userdiff.h"
 #include "line-log.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "bloom.h"
 
 static void range_set_grow(struct range_set *rs, size_t extra)
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 3553ad7b0a..3667766f29 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -2,7 +2,7 @@
 #include "commit.h"
 #include "config.h"
 #include "revision.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
diff --git a/ls-refs.c b/ls-refs.c
index 50d86866c6..98fb19092a 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -2,7 +2,7 @@
 #include "repository.h"
 #include "refs.h"
 #include "remote.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "ls-refs.h"
 #include "pkt-line.h"
 #include "config.h"
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 86cd393013..7cba96454c 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -4,7 +4,7 @@
 #include "commit.h"
 #include "color.h"
 #include "string-list.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "oid-array.h"
 
 /*----- some often used options -----*/
diff --git a/pathspec.c b/pathspec.c
index 8243e06eab..57c9b58418 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -3,7 +3,7 @@
 #include "dir.h"
 #include "pathspec.h"
 #include "attr.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "quote.h"
 
 /*
diff --git a/quote.c b/quote.c
index bcc0dbc50d..dac8b4e55e 100644
--- a/quote.c
+++ b/quote.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "quote.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 int quote_path_fully = 1;
 
diff --git a/range-diff.c b/range-diff.c
index 40af086281..b4d1d56445 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -2,7 +2,7 @@
 #include "range-diff.h"
 #include "string-list.h"
 #include "run-command.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "hashmap.h"
 #include "xdiff-interface.h"
 #include "linear-assignment.h"
diff --git a/range-diff.h b/range-diff.h
index e11976dc81..916f18bcd7 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -2,7 +2,7 @@
 #define RANGE_DIFF_H
 
 #include "diff.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
 
diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..81c4399da9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -22,7 +22,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "hashmap.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 static struct ref_msg {
 	const char *gone;
diff --git a/refs.c b/refs.c
index 639cba93b4..0067926262 100644
--- a/refs.c
+++ b/refs.c
@@ -15,7 +15,7 @@
 #include "tag.h"
 #include "submodule.h"
 #include "worktree.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "repository.h"
 #include "sigchain.h"
 
diff --git a/refspec.c b/refspec.c
index 9a9bf21934..f9fb67d295 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
 
diff --git a/remote-curl.c b/remote-curl.c
index 5cbc6e5002..05fb794ddd 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -10,7 +10,7 @@
 #include "pkt-line.h"
 #include "string-list.h"
 #include "sideband.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "credential.h"
 #include "oid-array.h"
 #include "send-pack.h"
diff --git a/remote-testsvn.c b/remote-testsvn.c
index cde39b94fb..809b290d45 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -8,7 +8,7 @@
 #include "run-command.h"
 #include "vcs-svn/svndump.h"
 #include "notes.h"
-#include "argv-array.h"
+#include "strvec.h"
 
 static const char *url;
 static int dump_from_file;
diff --git a/remote.c b/remote.c
index bc46413e6a..ba1a386d98 100644
--- a/remote.c
+++ b/remote.c
@@ -11,7 +11,7 @@
 #include "tag.h"
 #include "string-list.h"
 #include "mergesort.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "commit-reach.h"
 #include "advice.h"
 
diff --git a/revision.c b/revision.c
index 6aa7f4f567..07e16ed44b 100644
--- a/revision.c
+++ b/revision.c
@@ -23,7 +23,7 @@
 #include "bisect.h"
 #include "packfile.h"
 #include "worktree.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "prio-queue.h"
diff --git a/run-command.c b/run-command.c
index a735e380a9..8f57661d96 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,7 +2,7 @@
 #include "run-command.h"
 #include "exec-cmd.h"
 #include "sigchain.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "thread-utils.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/run-command.h b/run-command.h
index ef3071a565..f5e05d38d2 100644
--- a/run-command.h
+++ b/run-command.h
@@ -3,7 +3,7 @@
 
 #include "thread-utils.h"
 
-#include "argv-array.h"
+#include "strvec.h"
 
 /**
  * The run-command API offers a versatile tool to run sub-processes with
diff --git a/sequencer.c b/sequencer.c
index fd7701c88a..9e7f868b00 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -16,7 +16,7 @@
 #include "rerere.h"
 #include "merge-recursive.h"
 #include "refs.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "quote.h"
 #include "trailer.h"
 #include "log-tree.h"
diff --git a/serve.c b/serve.c
index fbd2fcdfb5..8d9a345b3d 100644
--- a/serve.c
+++ b/serve.c
@@ -3,7 +3,7 @@
 #include "config.h"
 #include "pkt-line.h"
 #include "version.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "ls-refs.h"
 #include "serve.h"
 #include "upload-pack.h"
diff --git a/argv-array.c b/strvec.c
similarity index 98%
rename from argv-array.c
rename to strvec.c
index b7461c47e4..9e76ab9295 100644
--- a/argv-array.c
+++ b/strvec.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "strbuf.h"
 
 const char *empty_strvec[] = { NULL };
diff --git a/argv-array.h b/strvec.h
similarity index 97%
rename from argv-array.h
rename to strvec.h
index ca66a338ad..4be39c8a48 100644
--- a/argv-array.h
+++ b/strvec.h
@@ -1,5 +1,5 @@
-#ifndef ARGV_ARRAY_H
-#define ARGV_ARRAY_H
+#ifndef STRVEC_H
+#define STRVEC_H
 
 /**
  * The argv-array API allows one to dynamically build and store
@@ -99,4 +99,4 @@ const char **strvec_detach(struct strvec *);
 #define argv_array_clear strvec_clear
 #define argv_array_detach strvec_detach
 
-#endif /* ARGV_ARRAY_H */
+#endif /* STRVEC_H */
diff --git a/submodule.c b/submodule.c
index e2ef5698c8..874db5c4b2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -13,7 +13,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "oid-array.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "blob.h"
 #include "thread-utils.h"
 #include "quote.h"
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 1646aa25d8..8d3f6d5a5e 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -12,7 +12,7 @@
 #include "git-compat-util.h"
 #include "cache.h"
 #include "run-command.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "strbuf.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 197819c872..823f33ceff 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -1,6 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "run-command.h"
 #include "exec-cmd.h"
 #include "config.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 91c00567f4..06924a7875 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -4,7 +4,7 @@
 #include "sigchain.h"
 #include "string-list.h"
 #include "strbuf.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "quote.h"
 #include "object-store.h"
 
diff --git a/transport-helper.c b/transport-helper.c
index c6b753bfae..441763fd7c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -9,7 +9,7 @@
 #include "string-list.h"
 #include "thread-utils.h"
 #include "sigchain.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
 #include "transport-internal.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 4be5fc3075..65c3395f0f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,5 +1,5 @@
 #include "cache.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
diff --git a/unpack-trees.h b/unpack-trees.h
index 9c2f08277e..f8a904a05b 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -2,7 +2,7 @@
 #define UNPACK_TREES_H
 
 #include "cache.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "string-list.h"
 #include "tree-walk.h"
 
diff --git a/upload-pack.c b/upload-pack.c
index 951a2b23aa..b435dae62f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -18,7 +18,7 @@
 #include "sigchain.h"
 #include "version.h"
 #include "string-list.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "prio-queue.h"
 #include "protocol.h"
 #include "quote.h"
diff --git a/wt-status.c b/wt-status.c
index c560cbe860..9817161da4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,7 +8,7 @@
 #include "diffcore.h"
 #include "quote.h"
 #include "run-command.h"
-#include "argv-array.h"
+#include "strvec.h"
 #include "remote.h"
 #include "refs.h"
 #include "submodule.h"
-- 
2.28.0.rc2.475.g53c7e1c7f4

