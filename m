Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5EC12E63
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6HRdNL8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3364c9ff8e1so2191038f8f.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351707; x=1703956507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7adU3kENGCi0YpiD5G7kn2upxi13jxvBZok/sMfWG0=;
        b=l6HRdNL8OZiIkLGxqkIiJljAxLFIY0up2SZEBOqFXTDnMCGXtHqiyvWVR/JdxwVHik
         K7PdFeaSjDBp5ef0RYuYhf77yk8C8E1hCgtcF/2Ruc2ZtXGF660NSX+8Dj5epkmESU1e
         IUwhliGc/4WJrv+cX2NEmxW2LN8C0RWevDaiC2lKtAI72MoTLO4Pdx+tcwBIYsDfLNDP
         djUct6gCcP1NiX0HRK0UwqwYOmGtVZlngSDuATgPyL/0vY/XpA9VvTLGczAoaqjpyrdF
         EQVvMK4v9CVZqkowz4RomQ1VfkfMxaf3qhcFNQuDLKnPdYjqn8TPougj4SQyEkHItgkx
         canA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351707; x=1703956507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7adU3kENGCi0YpiD5G7kn2upxi13jxvBZok/sMfWG0=;
        b=nk2OmVMzg9JX71aTYZdyTUIZ+3mcJPVzvyQSJHguZwW0P8Ql9Ir2XwxvYHPVxKZkCm
         e3TeEE+xwIWV6BFCq8AI4Gtpgu5yk2dvkzeWhG5vIL7yp6WVsS6KyYud8SeRRP2B/8if
         9dMYiv54P2YV8GpcgBAbJZ1gq+WuwrogB8mP+Hyrn19i3wHj+OldgSgemNfPaXfvHyBE
         B12I93aWH5/T9Z/nBIa9rBNM7/9aI+7cUZWWiNra8J1plHjrILk5NUrzadGC1gZA1SKP
         M96vAhF6SUkslM4n/BVv+fteJX8k4kDvqgioNMdYMSSFhiBPacl8UDkOvi7bDpSB2JwF
         Nt4A==
X-Gm-Message-State: AOJu0YzwfdgIbju4QrWPXiigX64GsivwLjmJcM3mYk5dxPwuV/2lfApc
	ch026vD2ecACdJXdFcygiQ1r9Eyi8rA=
X-Google-Smtp-Source: AGHT+IGGpT7YAkBpCekUx3wHk+7vYuLYlHr3s3InPvhrwsT/iCVg235PsgEtFRVwEq24iAiExHsnuQ==
X-Received: by 2002:a5d:51d1:0:b0:336:7d03:bc7b with SMTP id n17-20020a5d51d1000000b003367d03bc7bmr1960269wrv.15.1703351706019;
        Sat, 23 Dec 2023 09:15:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000101000b003366a9cb0d1sm6812939wrx.92.2023.12.23.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:05 -0800 (PST)
Message-ID: <4dcd52b117ebe54ef46fe5bd7e80507892eb243e.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:50 +0000
Subject: [PATCH v2 02/12] treewide: remove unnecessary includes in source
 files
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Each of these were checked with
   gcc -E -I. ${SOURCE_FILE} | grep ${HEADER_FILE}
to ensure that removing the direct inclusion of the header actually
resulted in that header no longer being included at all (i.e. that
no other header pulled it in transitively).

...except for a few cases where we verified that although the header
was brought in transitively, nothing from it was directly used in
that source file.  These cases were:
  * builtin/credential-cache.c
  * builtin/pull.c
  * builtin/send-pack.c

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-patch.c                   | 1 -
 apply.c                       | 1 -
 archive.c                     | 1 -
 bisect.c                      | 1 -
 blob.c                        | 1 -
 bloom.c                       | 1 -
 builtin/add.c                 | 3 ---
 builtin/am.c                  | 4 ----
 builtin/apply.c               | 1 -
 builtin/bisect.c              | 1 -
 builtin/blame.c               | 1 -
 builtin/branch.c              | 3 ---
 builtin/cat-file.c            | 1 -
 builtin/checkout-index.c      | 1 -
 builtin/checkout.c            | 3 ---
 builtin/clone.c               | 1 -
 builtin/commit-graph.c        | 1 -
 builtin/commit-tree.c         | 3 ---
 builtin/commit.c              | 8 --------
 builtin/credential-cache.c    | 2 --
 builtin/describe.c            | 2 --
 builtin/diff-files.c          | 1 -
 builtin/diff-index.c          | 2 --
 builtin/diff-tree.c           | 1 -
 builtin/diff.c                | 2 --
 builtin/difftool.c            | 1 -
 builtin/fast-export.c         | 1 -
 builtin/fetch.c               | 2 --
 builtin/for-each-ref.c        | 2 --
 builtin/fsck.c                | 2 --
 builtin/get-tar-commit-id.c   | 1 -
 builtin/grep.c                | 3 ---
 builtin/hash-object.c         | 1 -
 builtin/hook.c                | 1 -
 builtin/index-pack.c          | 2 --
 builtin/init-db.c             | 1 -
 builtin/log.c                 | 2 --
 builtin/ls-files.c            | 4 ----
 builtin/ls-remote.c           | 1 -
 builtin/ls-tree.c             | 2 --
 builtin/mailinfo.c            | 1 -
 builtin/merge-base.c          | 3 ---
 builtin/merge-recursive.c     | 3 ---
 builtin/merge-tree.c          | 1 -
 builtin/merge.c               | 4 ----
 builtin/mv.c                  | 1 -
 builtin/notes.c               | 2 --
 builtin/pack-objects.c        | 3 ---
 builtin/pull.c                | 5 -----
 builtin/push.c                | 1 -
 builtin/range-diff.c          | 1 -
 builtin/read-tree.c           | 2 --
 builtin/rebase.c              | 4 ----
 builtin/receive-pack.c        | 1 -
 builtin/repack.c              | 1 -
 builtin/rerere.c              | 1 -
 builtin/reset.c               | 3 ---
 builtin/rev-list.c            | 1 -
 builtin/revert.c              | 2 --
 builtin/rm.c                  | 1 -
 builtin/send-pack.c           | 4 ----
 builtin/show-ref.c            | 1 -
 builtin/sparse-checkout.c     | 4 ----
 builtin/stash.c               | 1 -
 builtin/submodule--helper.c   | 1 -
 builtin/tag.c                 | 1 -
 builtin/unpack-objects.c      | 4 ----
 builtin/update-ref.c          | 1 -
 builtin/verify-commit.c       | 2 --
 builtin/verify-tag.c          | 1 -
 bulk-checkin.c                | 1 -
 bundle-uri.c                  | 1 -
 cache-tree.c                  | 1 -
 combine-diff.c                | 1 -
 commit-graph.c                | 1 -
 commit-reach.c                | 1 -
 commit.c                      | 2 --
 config.c                      | 3 ---
 delta-islands.c               | 5 -----
 diff-lib.c                    | 1 -
 diff-no-index.c               | 3 ---
 diff.c                        | 2 --
 diffcore-break.c              | 1 -
 diffcore-delta.c              | 1 -
 dir.c                         | 1 -
 entry.c                       | 1 -
 exec-cmd.c                    | 1 -
 fetch-pack.c                  | 2 --
 fsck.c                        | 1 -
 gettext.c                     | 2 --
 gpg-interface.c               | 1 -
 grep.c                        | 1 -
 http-fetch.c                  | 1 -
 http-push.c                   | 2 --
 http-walker.c                 | 1 -
 http.c                        | 1 -
 imap-send.c                   | 2 --
 line-log.c                    | 2 --
 line-range.c                  | 1 -
 list-objects-filter-options.c | 5 -----
 list-objects-filter.c         | 5 -----
 ls-refs.c                     | 1 -
 merge-blobs.c                 | 2 --
 merge-ort.c                   | 2 --
 merge-recursive.c             | 5 -----
 merge.c                       | 3 ---
 negotiator/noop.c             | 1 -
 notes.c                       | 2 --
 object-file.c                 | 8 --------
 object-name.c                 | 2 --
 pack-bitmap-write.c           | 3 ---
 pack-check.c                  | 1 -
 pack-write.c                  | 1 -
 packfile.c                    | 1 -
 parse-options.c               | 2 --
 patch-ids.c                   | 1 -
 protocol-caps.c               | 1 -
 reachable.c                   | 1 -
 read-cache.c                  | 2 --
 ref-filter.c                  | 2 --
 reflog.c                      | 1 -
 refs/files-backend.c          | 2 --
 refs/packed-backend.c         | 1 -
 refs/ref-cache.c              | 1 -
 reftable/dump.c               | 2 --
 reftable/generic.c            | 1 -
 reftable/merged.c             | 1 -
 reftable/merged_test.c        | 1 -
 reftable/reader.c             | 1 -
 reftable/readwrite_test.c     | 1 -
 reftable/refname_test.c       | 1 -
 reftable/stack_test.c         | 1 -
 reftable/test_framework.c     | 1 -
 reftable/tree_test.c          | 2 --
 remote-curl.c                 | 1 -
 remote.c                      | 1 -
 rerere.c                      | 2 --
 reset.c                       | 1 -
 revision.c                    | 2 --
 run-command.c                 | 2 --
 send-pack.c                   | 2 --
 sequencer.c                   | 3 ---
 setup.c                       | 1 -
 shallow.c                     | 1 -
 shell.c                       | 1 -
 submodule.c                   | 3 ---
 t/helper/test-bundle-uri.c    | 2 --
 t/helper/test-reach.c         | 2 --
 t/helper/test-repository.c    | 1 -
 t/helper/test-simple-ipc.c    | 1 -
 tmp-objdir.c                  | 1 -
 trace2.c                      | 3 ---
 transport-helper.c            | 2 --
 transport.c                   | 3 ---
 tree.c                        | 3 ---
 upload-pack.c                 | 6 ------
 wrapper.c                     | 1 -
 xdiff-interface.c             | 2 --
 158 files changed, 293 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index bfe19876cd5..79eda168ebb 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -12,7 +12,6 @@
 #include "strvec.h"
 #include "pathspec.h"
 #include "color.h"
-#include "diff.h"
 #include "compat/terminal.h"
 #include "prompt.h"
 
diff --git a/apply.c b/apply.c
index 3d69fec836d..7608e3301ca 100644
--- a/apply.c
+++ b/apply.c
@@ -12,7 +12,6 @@
 #include "base85.h"
 #include "config.h"
 #include "object-store-ll.h"
-#include "blob.h"
 #include "delta.h"
 #include "diff.h"
 #include "dir.h"
diff --git a/archive.c b/archive.c
index ca11db185b1..4562a69a0cc 100644
--- a/archive.c
+++ b/archive.c
@@ -17,7 +17,6 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
-#include "dir.h"
 #include "quote.h"
 
 static char const * const archive_usage[] = {
diff --git a/bisect.c b/bisect.c
index 1be8e0a2711..8487f8cd1bd 100644
--- a/bisect.c
+++ b/bisect.c
@@ -9,7 +9,6 @@
 #include "refs.h"
 #include "list-objects.h"
 #include "quote.h"
-#include "hash-lookup.h"
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
diff --git a/blob.c b/blob.c
index 888e28a5594..3fb2922b1ae 100644
--- a/blob.c
+++ b/blob.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "blob.h"
-#include "repository.h"
 #include "alloc.h"
 
 const char *blob_type = "blob";
diff --git a/bloom.c b/bloom.c
index 1474aa19fa5..e529f7605ca 100644
--- a/bloom.c
+++ b/bloom.c
@@ -2,7 +2,6 @@
 #include "bloom.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "revision.h"
 #include "hashmap.h"
 #include "commit-graph.h"
 #include "commit.h"
diff --git a/builtin/add.c b/builtin/add.c
index 5126d2ede3d..2151c45fbf0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -12,14 +12,11 @@
 #include "dir.h"
 #include "gettext.h"
 #include "pathspec.h"
-#include "exec-cmd.h"
-#include "cache-tree.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
 #include "diff.h"
-#include "diffcore.h"
 #include "read-cache.h"
 #include "repository.h"
 #include "revision.h"
diff --git a/builtin/am.c b/builtin/am.c
index 9f084d58bc7..d1990d7edcb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -10,7 +10,6 @@
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
-#include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
@@ -24,7 +23,6 @@
 #include "refs.h"
 #include "commit.h"
 #include "diff.h"
-#include "diffcore.h"
 #include "unpack-trees.h"
 #include "branch.h"
 #include "object-name.h"
@@ -35,11 +33,9 @@
 #include "log-tree.h"
 #include "notes-utils.h"
 #include "rerere.h"
-#include "prompt.h"
 #include "mailinfo.h"
 #include "apply.h"
 #include "string-list.h"
-#include "packfile.h"
 #include "pager.h"
 #include "path.h"
 #include "repository.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index c18b7ea5d3d..861a01910ca 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "gettext.h"
-#include "parse-options.h"
 #include "repository.h"
 #include "apply.h"
 
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 35938b05fd1..7d5faedfabf 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -7,7 +7,6 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
-#include "dir.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "oid-array.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 9c987d65675..e9ea190baf6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -25,7 +25,6 @@
 #include "userdiff.h"
 #include "line-range.h"
 #include "line-log.h"
-#include "dir.h"
 #include "progress.h"
 #include "object-name.h"
 #include "object-store-ll.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index e7ee9bd0f15..6e30d5eac53 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -17,13 +17,10 @@
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
-#include "diff.h"
 #include "path.h"
-#include "revision.h"
 #include "string-list.h"
 #include "column.h"
 #include "utf8.h"
-#include "wt-status.h"
 #include "ref-filter.h"
 #include "worktree.h"
 #include "help.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ea8ad601ecc..7d4899348a3 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,7 +15,6 @@
 #include "parse-options.h"
 #include "userdiff.h"
 #include "streaming.h"
-#include "tree-walk.h"
 #include "oid-array.h"
 #include "packfile.h"
 #include "object-file.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 3b68b476153..2e086a204dc 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -7,7 +7,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
-#include "dir.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "quote.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f02434bc155..12a46da89a8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,7 +1,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "advice.h"
-#include "blob.h"
 #include "branch.h"
 #include "cache-tree.h"
 #include "checkout.h"
@@ -27,10 +26,8 @@
 #include "remote.h"
 #include "resolve-undo.h"
 #include "revision.h"
-#include "run-command.h"
 #include "setup.h"
 #include "submodule.h"
-#include "submodule-config.h"
 #include "symlinks.h"
 #include "trace2.h"
 #include "tree.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index c6357af9498..8e9c055533b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -19,7 +19,6 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "parse-options.h"
-#include "fetch-pack.h"
 #include "refs.h"
 #include "refspec.h"
 #include "object-file.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 45d035af600..c5684342ecf 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,7 +1,6 @@
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
-#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 02625e71761..1bb78198392 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -11,9 +11,6 @@
 #include "object-store-ll.h"
 #include "repository.h"
 #include "commit.h"
-#include "tree.h"
-#include "utf8.h"
-#include "gpg-interface.h"
 #include "parse-options.h"
 
 static const char * const commit_tree_usage[] = {
diff --git a/builtin/commit.c b/builtin/commit.c
index 781af2e206c..ca2d18532ad 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -16,17 +16,12 @@
 #include "editor.h"
 #include "environment.h"
 #include "diff.h"
-#include "diffcore.h"
 #include "commit.h"
 #include "gettext.h"
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
-#include "hook.h"
-#include "refs.h"
-#include "log-tree.h"
 #include "strbuf.h"
-#include "utf8.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "path.h"
@@ -35,9 +30,6 @@
 #include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
-#include "quote.h"
-#include "submodule.h"
-#include "gpg-interface.h"
 #include "column.h"
 #include "sequencer.h"
 #include "sparse-index.h"
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 43b9d0e5b16..bba96d4ffd6 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -7,8 +7,6 @@
 
 #ifndef NO_UNIX_SOCKETS
 
-#include "credential.h"
-#include "string-list.h"
 #include "unix-socket.h"
 #include "run-command.h"
 
diff --git a/builtin/describe.c b/builtin/describe.c
index fb6b0508f32..d6c77a714f4 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -7,9 +7,7 @@
 #include "lockfile.h"
 #include "commit.h"
 #include "tag.h"
-#include "blob.h"
 #include "refs.h"
-#include "exec-cmd.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index f38912cd407..018011f29ea 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -11,7 +11,6 @@
 #include "preload-index.h"
 #include "repository.h"
 #include "revision.h"
-#include "submodule.h"
 
 static const char diff_files_usage[] =
 "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 220f341ffa2..3e05260ac0e 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -7,8 +7,6 @@
 #include "repository.h"
 #include "revision.h"
 #include "setup.h"
-#include "sparse-index.h"
-#include "submodule.h"
 
 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] [--merge-base] "
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 86be6342861..a8e68ce8ef6 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -6,7 +6,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "log-tree.h"
-#include "submodule.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "revision.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index 55e7d21755a..6e196e0c7d2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -10,7 +10,6 @@
 #include "lockfile.h"
 #include "color.h"
 #include "commit.h"
-#include "blob.h"
 #include "gettext.h"
 #include "tag.h"
 #include "diff.h"
@@ -21,7 +20,6 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "setup.h"
-#include "submodule.h"
 #include "oid-array.h"
 #include "tree.h"
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 0f5eae9cd41..a3c72b8258e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -18,7 +18,6 @@
 #include "copy.h"
 #include "run-command.h"
 #include "environment.h"
-#include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 70aff515acb..f18f0809f9c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -25,7 +25,6 @@
 #include "quote.h"
 #include "remote.h"
 #include "blob.h"
-#include "commit-slab.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [<rev-list-opts>]"),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fd134ba74d9..72d735589a3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -26,7 +26,6 @@
 #include "connected.h"
 #include "strvec.h"
 #include "utf8.h"
-#include "packfile.h"
 #include "pager.h"
 #include "path.h"
 #include "pkt-line.h"
@@ -38,7 +37,6 @@
 #include "shallow.h"
 #include "trace.h"
 #include "trace2.h"
-#include "worktree.h"
 #include "bundle-uri.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 350bfa6e811..6235d72f9d3 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,13 +1,11 @@
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
-#include "refs.h"
 #include "object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
 #include "strbuf.h"
 #include "strvec.h"
-#include "commit-reach.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 611925905e4..9317b7b841d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -13,10 +13,8 @@
 #include "tree-walk.h"
 #include "fsck.h"
 #include "parse-options.h"
-#include "dir.h"
 #include "progress.h"
 #include "streaming.h"
-#include "decorate.h"
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 20d0dfe9cf1..66a7389f9f4 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -4,7 +4,6 @@
 #include "builtin.h"
 #include "commit.h"
 #include "tar.h"
-#include "quote.h"
 
 static const char builtin_get_tar_commit_id_usage[] =
 "git get-tar-commit-id";
diff --git a/builtin/grep.c b/builtin/grep.c
index fe78d4c98b1..f076cc705b4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -9,9 +9,6 @@
 #include "hex.h"
 #include "repository.h"
 #include "config.h"
-#include "blob.h"
-#include "tree.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
 #include "parse-options.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 5ffec99dcea..82ca6d2bfdc 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -14,7 +14,6 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
-#include "exec-cmd.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "write-or-die.h"
diff --git a/builtin/hook.c b/builtin/hook.c
index 09b51a6487c..5234693a94b 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -3,7 +3,6 @@
 #include "gettext.h"
 #include "hook.h"
 #include "parse-options.h"
-#include "strbuf.h"
 #include "strvec.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dda94a9f46d..0841b6940a3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -8,11 +8,9 @@
 #include "csum-file.h"
 #include "blob.h"
 #include "commit.h"
-#include "tag.h"
 #include "tree.h"
 #include "progress.h"
 #include "fsck.h"
-#include "exec-cmd.h"
 #include "strbuf.h"
 #include "streaming.h"
 #include "thread-utils.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index cb727c826f5..b89814a6f87 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -5,7 +5,6 @@
  */
 #include "builtin.h"
 #include "abspath.h"
-#include "config.h"
 #include "environment.h"
 #include "gettext.h"
 #include "object-file.h"
diff --git a/builtin/log.c b/builtin/log.c
index ba775d7b5cf..cec7ce46f1c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -26,7 +26,6 @@
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
-#include "run-command.h"
 #include "shortlog.h"
 #include "remote.h"
 #include "string-list.h"
@@ -36,7 +35,6 @@
 #include "streaming.h"
 #include "version.h"
 #include "mailmap.h"
-#include "gpg-interface.h"
 #include "progress.h"
 #include "commit-slab.h"
 #include "repository.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a0229c32778..92f94e65bf0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,19 +14,15 @@
 #include "gettext.h"
 #include "object-name.h"
 #include "strbuf.h"
-#include "tree.h"
-#include "cache-tree.h"
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "path.h"
 #include "pathspec.h"
 #include "read-cache.h"
-#include "run-command.h"
 #include "setup.h"
 #include "sparse-index.h"
 #include "submodule.h"
-#include "submodule-config.h"
 #include "object-store.h"
 #include "hex.h"
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fc765754305..2975ea4082f 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,6 @@
 #include "pkt-line.h"
 #include "ref-filter.h"
 #include "remote.h"
-#include "refs.h"
 #include "parse-options.h"
 #include "wildmatch.h"
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 209d2dc0d59..e4a891337c3 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -9,9 +9,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "object-store-ll.h"
-#include "blob.h"
 #include "tree.h"
-#include "commit.h"
 #include "path.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 53b55dd71c0..53a22645da5 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -6,7 +6,6 @@
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
-#include "utf8.h"
 #include "strbuf.h"
 #include "mailinfo.h"
 #include "parse-options.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e68b7fe45d7..d26e8fbf6f7 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -3,9 +3,6 @@
 #include "commit.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
-#include "diff.h"
-#include "revision.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "repository.h"
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 3366699657c..c2ce044a201 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,13 +1,10 @@
 #include "builtin.h"
 #include "advice.h"
-#include "commit.h"
 #include "gettext.h"
 #include "hash.h"
-#include "tag.h"
 #include "merge-recursive.h"
 #include "object-name.h"
 #include "repository.h"
-#include "xdiff-interface.h"
 
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index a35e0452d66..f3c46691010 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -13,7 +13,6 @@
 #include "parse-options.h"
 #include "repository.h"
 #include "blob.h"
-#include "exec-cmd.h"
 #include "merge-blobs.h"
 #include "quote.h"
 #include "tree.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index d748d46e135..5b788546637 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -31,8 +31,6 @@
 #include "unpack-trees.h"
 #include "cache-tree.h"
 #include "dir.h"
-#include "utf8.h"
-#include "log-tree.h"
 #include "color.h"
 #include "rerere.h"
 #include "help.h"
@@ -42,10 +40,8 @@
 #include "resolve-undo.h"
 #include "remote.h"
 #include "fmt-merge-msg.h"
-#include "gpg-interface.h"
 #include "sequencer.h"
 #include "string-list.h"
-#include "packfile.h"
 #include "tag.h"
 #include "alias.h"
 #include "branch.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index c596515ad05..22e64fc2900 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -15,7 +15,6 @@
 #include "pathspec.h"
 #include "lockfile.h"
 #include "dir.h"
-#include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
 #include "read-cache-ll.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 9f38863dd50..e65cae0bcf7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -9,7 +9,6 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "alloc.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
@@ -19,7 +18,6 @@
 #include "object-store-ll.h"
 #include "path.h"
 #include "repository.h"
-#include "blob.h"
 #include "pretty.h"
 #include "refs.h"
 #include "exec-cmd.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 89a8b5a9768..ab1c9de9815 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -6,10 +6,8 @@
 #include "config.h"
 #include "attr.h"
 #include "object.h"
-#include "blob.h"
 #include "commit.h"
 #include "tag.h"
-#include "tree.h"
 #include "delta.h"
 #include "pack.h"
 #include "pack-revindex.h"
@@ -18,7 +16,6 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
-#include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "pack-objects.h"
 #include "progress.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index be2b2c9ebc9..73a68b75b06 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -14,7 +14,6 @@
 #include "merge.h"
 #include "object-name.h"
 #include "parse-options.h"
-#include "exec-cmd.h"
 #include "run-command.h"
 #include "oid-array.h"
 #include "remote.h"
@@ -24,15 +23,11 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
-#include "revision.h"
 #include "submodule.h"
 #include "submodule-config.h"
-#include "tempfile.h"
-#include "lockfile.h"
 #include "wt-status.h"
 #include "commit-reach.h"
 #include "sequencer.h"
-#include "packfile.h"
 
 /**
  * Parses the value of --rebase. If value is a false value, returns
diff --git a/builtin/push.c b/builtin/push.c
index 2e708383c24..23e841d5b54 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -7,7 +7,6 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "refs.h"
 #include "refspec.h"
 #include "run-command.h"
 #include "remote.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e455a4795cc..f02cbac087d 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -5,7 +5,6 @@
 #include "range-diff.h"
 #include "config.h"
 #include "repository.h"
-#include "revision.h"
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8196ca9dd85..20e7db19737 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -16,14 +16,12 @@
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
-#include "dir.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "resolve-undo.h"
 #include "setup.h"
 #include "sparse-index.h"
 #include "submodule.h"
-#include "submodule-config.h"
 
 static int nr_trees;
 static int read_empty;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 043c65dccd9..d338b4053da 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -11,14 +11,10 @@
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
-#include "exec-cmd.h"
 #include "strvec.h"
 #include "dir.h"
-#include "packfile.h"
 #include "refs.h"
-#include "quote.h"
 #include "config.h"
-#include "cache-tree.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
 #include "object-file.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8c4f0cb90a9..401d93b675f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -22,7 +22,6 @@
 #include "connected.h"
 #include "strvec.h"
 #include "version.h"
-#include "tag.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "fsck.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index edaee4dbec7..fc10570d06b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,7 +8,6 @@
 #include "path.h"
 #include "run-command.h"
 #include "server-info.h"
-#include "sigchain.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 07a9d37275c..b2efc6f640e 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "config.h"
-#include "dir.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "repository.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 4b018d20e3b..8390bfe4c48 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -16,10 +16,8 @@
 #include "hash.h"
 #include "hex.h"
 #include "lockfile.h"
-#include "tag.h"
 #include "object.h"
 #include "pretty.h"
-#include "run-command.h"
 #include "refs.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -33,7 +31,6 @@
 #include "setup.h"
 #include "sparse-index.h"
 #include "submodule.h"
-#include "submodule-config.h"
 #include "trace.h"
 #include "trace2.h"
 #include "dir.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 181353dcf51..460ba7cbaa7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -7,7 +7,6 @@
 #include "hex.h"
 #include "revision.h"
 #include "list-objects.h"
-#include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "object.h"
 #include "object-name.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index e6f9a1ad267..89821bab957 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
 #include "diff.h"
@@ -7,7 +6,6 @@
 #include "repository.h"
 #include "revision.h"
 #include "rerere.h"
-#include "dir.h"
 #include "sequencer.h"
 #include "branch.h"
 
diff --git a/builtin/rm.c b/builtin/rm.c
index dff819ae509..fd130cea2d2 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -9,7 +9,6 @@
 #include "config.h"
 #include "lockfile.h"
 #include "dir.h"
-#include "cache-tree.h"
 #include "gettext.h"
 #include "hash.h"
 #include "tree-walk.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index cd6d9e41129..395f2e490d4 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,8 +1,6 @@
 #include "builtin.h"
 #include "config.h"
-#include "commit.h"
 #include "hex.h"
-#include "refs.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
@@ -11,9 +9,7 @@
 #include "send-pack.h"
 #include "quote.h"
 #include "transport.h"
-#include "version.h"
 #include "oid-array.h"
-#include "gpg-interface.h"
 #include "gettext.h"
 #include "protocol.h"
 #include "parse-options.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7aac525a878..f102f6f6131 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -6,7 +6,6 @@
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "object.h"
-#include "tag.h"
 #include "string-list.h"
 #include "parse-options.h"
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5c8ffb1f759..80227f3df17 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,14 +8,10 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "repository.h"
-#include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
-#include "cache-tree.h"
 #include "lockfile.h"
-#include "resolve-undo.h"
 #include "unpack-trees.h"
-#include "wt-status.h"
 #include "quote.h"
 #include "setup.h"
 #include "sparse-index.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 4a6771c9f4c..b2813c614cb 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -26,7 +26,6 @@
 #include "sparse-index.h"
 #include "log-tree.h"
 #include "diffcore.h"
-#include "exec-cmd.h"
 #include "reflog.h"
 #include "add-interactive.h"
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cce46450abe..fda50f2af1e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -22,7 +22,6 @@
 #include "remote.h"
 #include "refs.h"
 #include "refspec.h"
-#include "connect.h"
 #include "revision.h"
 #include "diffcore.h"
 #include "diff.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 3918eacbb57..358b3086161 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -18,7 +18,6 @@
 #include "object-store-ll.h"
 #include "path.h"
 #include "tag.h"
-#include "run-command.h"
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index fef74234488..e0a701f2b38 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -10,12 +10,8 @@
 #include "delta.h"
 #include "pack.h"
 #include "blob.h"
-#include "commit.h"
 #include "replace-object.h"
 #include "strbuf.h"
-#include "tag.h"
-#include "tree.h"
-#include "tree-walk.h"
 #include "progress.h"
 #include "decorate.h"
 #include "fsck.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index c0c4e65e6fb..61338a01ecf 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -7,7 +7,6 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "repository.h"
-#include "strvec.h"
 
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [<options>] -d <refname> [<old-val>]"),
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 9680b587013..0d2b9aea2ae 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -9,10 +9,8 @@
 #include "config.h"
 #include "gettext.h"
 #include "object-name.h"
-#include "object-store-ll.h"
 #include "repository.h"
 #include "commit.h"
-#include "run-command.h"
 #include "parse-options.h"
 #include "gpg-interface.h"
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index d8753270ebe..c731e2f87b4 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -9,7 +9,6 @@
 #include "config.h"
 #include "gettext.h"
 #include "tag.h"
-#include "run-command.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "gpg-interface.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6ce62999e58..eb46b886379 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -11,7 +11,6 @@
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
-#include "string-list.h"
 #include "tmp-objdir.h"
 #include "packfile.h"
 #include "object-file.h"
diff --git a/bundle-uri.c b/bundle-uri.c
index 8492fffd2f7..ca32050a78f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -4,7 +4,6 @@
 #include "copy.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-store-ll.h"
 #include "refs.h"
 #include "run-command.h"
 #include "hashmap.h"
diff --git a/cache-tree.c b/cache-tree.c
index 641427ed410..64678fe1993 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -11,7 +11,6 @@
 #include "read-cache-ll.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
-#include "sparse-index.h"
 #include "trace.h"
 #include "trace2.h"
 
diff --git a/combine-diff.c b/combine-diff.c
index f90f4424829..db94581f724 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -2,7 +2,6 @@
 #include "object-store-ll.h"
 #include "commit.h"
 #include "convert.h"
-#include "blob.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "environment.h"
diff --git a/commit-graph.c b/commit-graph.c
index ee66098e077..5bfee53e87b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -8,7 +8,6 @@
 #include "commit.h"
 #include "object.h"
 #include "refs.h"
-#include "revision.h"
 #include "hash-lookup.h"
 #include "commit-graph.h"
 #include "object-file.h"
diff --git a/commit-reach.c b/commit-reach.c
index a868a575ea1..ecc913fc99b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -4,7 +4,6 @@
 #include "decorate.h"
 #include "hex.h"
 #include "prio-queue.h"
-#include "tree.h"
 #include "ref-filter.h"
 #include "revision.h"
 #include "tag.h"
diff --git a/commit.c b/commit.c
index 8405d7c3fce..f6342d7deb5 100644
--- a/commit.c
+++ b/commit.c
@@ -8,7 +8,6 @@
 #include "repository.h"
 #include "object-name.h"
 #include "object-store-ll.h"
-#include "pkt-line.h"
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
@@ -23,7 +22,6 @@
 #include "advice.h"
 #include "refs.h"
 #include "commit-reach.h"
-#include "run-command.h"
 #include "setup.h"
 #include "shallow.h"
 #include "tree.h"
diff --git a/config.c b/config.c
index b330c7adb4a..cdc39cf3693 100644
--- a/config.c
+++ b/config.c
@@ -30,15 +30,12 @@
 #include "pager.h"
 #include "path.h"
 #include "utf8.h"
-#include "dir.h"
 #include "color.h"
-#include "replace-object.h"
 #include "refs.h"
 #include "setup.h"
 #include "strvec.h"
 #include "trace2.h"
 #include "wildmatch.h"
-#include "worktree.h"
 #include "ws.h"
 #include "write-or-die.h"
 
diff --git a/delta-islands.c b/delta-islands.c
index 5de5759f3f1..ee2318d45a1 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,18 +1,13 @@
 #include "git-compat-util.h"
-#include "attr.h"
 #include "object.h"
-#include "blob.h"
 #include "commit.h"
 #include "gettext.h"
 #include "hex.h"
 #include "tag.h"
 #include "tree.h"
-#include "delta.h"
 #include "pack.h"
 #include "tree-walk.h"
 #include "diff.h"
-#include "revision.h"
-#include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
 #include "khash.h"
diff --git a/diff-lib.c b/diff-lib.c
index 0e9ec4f68af..8fde93d7cac 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -2,7 +2,6 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "git-compat-util.h"
-#include "quote.h"
 #include "commit.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/diff-no-index.c b/diff-no-index.c
index e7041b89e38..3a8965672c5 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -8,13 +8,10 @@
 #include "abspath.h"
 #include "color.h"
 #include "commit.h"
-#include "blob.h"
-#include "tag.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
 #include "revision.h"
-#include "log-tree.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "dir.h"
diff --git a/diff.c b/diff.c
index 2c602df10a3..587341805c2 100644
--- a/diff.c
+++ b/diff.c
@@ -16,12 +16,10 @@
 #include "hex.h"
 #include "xdiff-interface.h"
 #include "color.h"
-#include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
 #include "object-store-ll.h"
 #include "userdiff.h"
-#include "submodule-config.h"
 #include "submodule.h"
 #include "hashmap.h"
 #include "mem-pool.h"
diff --git a/diffcore-break.c b/diffcore-break.c
index f57ece2757d..49ba38aa7c0 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -2,7 +2,6 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "git-compat-util.h"
-#include "diff.h"
 #include "diffcore.h"
 #include "hash.h"
 #include "object.h"
diff --git a/diffcore-delta.c b/diffcore-delta.c
index c30b56e983b..4927ab8fb0c 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "diff.h"
 #include "diffcore.h"
 
 /*
diff --git a/dir.c b/dir.c
index 16fdb03f2a5..3e75c126edf 100644
--- a/dir.c
+++ b/dir.c
@@ -16,7 +16,6 @@
 #include "object-file.h"
 #include "object-store-ll.h"
 #include "path.h"
-#include "attr.h"
 #include "refs.h"
 #include "wildmatch.h"
 #include "pathspec.h"
diff --git a/entry.c b/entry.c
index 076e97eb89c..f918a3a78e8 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "blob.h"
 #include "object-store-ll.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/exec-cmd.c b/exec-cmd.c
index 1d597e84ea7..909777f61f4 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -4,7 +4,6 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "path.h"
-#include "quote.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "trace.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 26999e3b659..b0373bd87c4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -10,7 +10,6 @@
 #include "pkt-line.h"
 #include "commit.h"
 #include "tag.h"
-#include "exec-cmd.h"
 #include "pack.h"
 #include "sideband.h"
 #include "fetch-pack.h"
@@ -18,7 +17,6 @@
 #include "run-command.h"
 #include "connect.h"
 #include "trace2.h"
-#include "transport.h"
 #include "version.h"
 #include "oid-array.h"
 #include "oidset.h"
diff --git a/fsck.c b/fsck.c
index 6a0bbc50877..9fce4c9628f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -16,7 +16,6 @@
 #include "refs.h"
 #include "url.h"
 #include "utf8.h"
-#include "decorate.h"
 #include "oidset.h"
 #include "packfile.h"
 #include "submodule-config.h"
diff --git a/gettext.c b/gettext.c
index f27e94407b4..57facbc21ec 100644
--- a/gettext.c
+++ b/gettext.c
@@ -7,9 +7,7 @@
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
-#include "strbuf.h"
 #include "utf8.h"
-#include "config.h"
 
 #ifndef NO_GETTEXT
 #	include <libintl.h>
diff --git a/gpg-interface.c b/gpg-interface.c
index 48f43c5a21d..636475f598f 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -12,7 +12,6 @@
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
-#include "environment.h"
 
 static int git_gpg_config(const char *, const char *,
 			  const struct config_context *, void *);
diff --git a/grep.c b/grep.c
index fc2d0c837a3..5f23d1a50ca 100644
--- a/grep.c
+++ b/grep.c
@@ -9,7 +9,6 @@
 #include "xdiff-interface.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "commit.h"
 #include "quote.h"
 #include "help.h"
 
diff --git a/http-fetch.c b/http-fetch.c
index fffda592670..93695a440ad 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
 #include "http.h"
diff --git a/http-push.c b/http-push.c
index a704f490fdb..329513270c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -6,10 +6,8 @@
 #include "tag.h"
 #include "blob.h"
 #include "http.h"
-#include "refs.h"
 #include "diff.h"
 #include "revision.h"
-#include "exec-cmd.h"
 #include "remote.h"
 #include "list-objects.h"
 #include "setup.h"
diff --git a/http-walker.c b/http-walker.c
index 78d99f7c4b0..b395ef13279 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "repository.h"
-#include "commit.h"
 #include "hex.h"
 #include "walker.h"
 #include "http.h"
diff --git a/http.c b/http.c
index 8f71bf00d89..a64005ceb80 100644
--- a/http.c
+++ b/http.c
@@ -15,7 +15,6 @@
 #include "trace.h"
 #include "transport.h"
 #include "packfile.h"
-#include "protocol.h"
 #include "string-list.h"
 #include "object-file.h"
 #include "object-store-ll.h"
diff --git a/imap-send.c b/imap-send.c
index 996651e4f80..904cb23cf57 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -24,12 +24,10 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "credential.h"
-#include "exec-cmd.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "setup.h"
-#include "strbuf.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif
diff --git a/line-log.c b/line-log.c
index 24a1ecb6779..a878cb7810a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -2,7 +2,6 @@
 #include "line-range.h"
 #include "hex.h"
 #include "tag.h"
-#include "blob.h"
 #include "tree.h"
 #include "diff.h"
 #include "commit.h"
@@ -12,7 +11,6 @@
 #include "xdiff-interface.h"
 #include "strbuf.h"
 #include "log-tree.h"
-#include "graph.h"
 #include "userdiff.h"
 #include "line-log.h"
 #include "setup.h"
diff --git a/line-range.c b/line-range.c
index 47bf0d6f1a2..60f0e5ada81 100644
--- a/line-range.c
+++ b/line-range.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "line-range.h"
 #include "xdiff-interface.h"
-#include "strbuf.h"
 #include "userdiff.h"
 
 /*
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 8a08b7af49c..c5f363ca6f7 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,11 +1,6 @@
 #include "git-compat-util.h"
-#include "commit.h"
 #include "config.h"
 #include "gettext.h"
-#include "revision.h"
-#include "strvec.h"
-#include "list-objects.h"
-#include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "promisor-remote.h"
 #include "trace.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 9327ccd5057..da287cc8e0d 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -2,14 +2,9 @@
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
-#include "tag.h"
 #include "commit.h"
-#include "tree.h"
-#include "blob.h"
 #include "diff.h"
-#include "tree-walk.h"
 #include "revision.h"
-#include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "oidmap.h"
diff --git a/ls-refs.c b/ls-refs.c
index 0e49b932c30..819cbefee3d 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -5,7 +5,6 @@
 #include "hex.h"
 #include "repository.h"
 #include "refs.h"
-#include "remote.h"
 #include "strvec.h"
 #include "ls-refs.h"
 #include "pkt-line.h"
diff --git a/merge-blobs.c b/merge-blobs.c
index 9293cbf75c8..2f659fd0143 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -1,6 +1,4 @@
 #include "git-compat-util.h"
-#include "run-command.h"
-#include "xdiff-interface.h"
 #include "merge-ll.h"
 #include "blob.h"
 #include "merge-blobs.h"
diff --git a/merge-ort.c b/merge-ort.c
index 6491070d965..2a0be468505 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -19,7 +19,6 @@
 
 #include "alloc.h"
 #include "attr.h"
-#include "blob.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -42,7 +41,6 @@
 #include "revision.h"
 #include "sparse-index.h"
 #include "strmap.h"
-#include "submodule-config.h"
 #include "submodule.h"
 #include "trace2.h"
 #include "tree.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index e3beb0801b1..a0c3e7a2d91 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -6,10 +6,7 @@
 #include "git-compat-util.h"
 #include "merge-recursive.h"
 
-#include "advice.h"
 #include "alloc.h"
-#include "attr.h"
-#include "blob.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -32,8 +29,6 @@
 #include "revision.h"
 #include "sparse-index.h"
 #include "string-list.h"
-#include "submodule-config.h"
-#include "submodule.h"
 #include "symlinks.h"
 #include "tag.h"
 #include "tree-walk.h"
diff --git a/merge.c b/merge.c
index b60925459c2..ca89b312d17 100644
--- a/merge.c
+++ b/merge.c
@@ -1,6 +1,4 @@
 #include "git-compat-util.h"
-#include "diff.h"
-#include "diffcore.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
@@ -13,7 +11,6 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
-#include "dir.h"
 
 static const char *merge_argument(struct commit *commit)
 {
diff --git a/negotiator/noop.c b/negotiator/noop.c
index de39028ab7f..65e3c200084 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -1,6 +1,5 @@
 #include "git-compat-util.h"
 #include "noop.h"
-#include "../commit.h"
 #include "../fetch-negotiator.h"
 
 static void known_common(struct fetch_negotiator *n UNUSED,
diff --git a/notes.c b/notes.c
index 1ef2a331ce9..fed1eda80cd 100644
--- a/notes.c
+++ b/notes.c
@@ -5,8 +5,6 @@
 #include "notes.h"
 #include "object-name.h"
 #include "object-store-ll.h"
-#include "blob.h"
-#include "tree.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
diff --git a/object-file.c b/object-file.c
index 7c7afe57936..619f039ebc7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -15,24 +15,16 @@
 #include "hex.h"
 #include "string-list.h"
 #include "lockfile.h"
-#include "delta.h"
 #include "pack.h"
-#include "blob.h"
 #include "commit.h"
 #include "run-command.h"
-#include "tag.h"
-#include "tree.h"
-#include "tree-walk.h"
 #include "refs.h"
-#include "pack-revindex.h"
-#include "hash-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
 #include "replace-object.h"
 #include "streaming.h"
 #include "dir.h"
 #include "list.h"
-#include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
 #include "object-file.h"
diff --git a/object-name.c b/object-name.c
index 0bfa29dbbfe..3a2ef5d6800 100644
--- a/object-name.c
+++ b/object-name.c
@@ -8,7 +8,6 @@
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
-#include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
 #include "remote.h"
@@ -21,7 +20,6 @@
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
-#include "submodule.h"
 #include "midx.h"
 #include "commit-reach.h"
 #include "date.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f4ecdf8b0e3..be4733e3bdc 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -4,12 +4,9 @@
 #include "hex.h"
 #include "object-store-ll.h"
 #include "commit.h"
-#include "tag.h"
 #include "diff.h"
 #include "revision.h"
-#include "list-objects.h"
 #include "progress.h"
-#include "pack-revindex.h"
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "hash-lookup.h"
diff --git a/pack-check.c b/pack-check.c
index 977f619618e..25104d5b14c 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -3,7 +3,6 @@
 #include "hex.h"
 #include "repository.h"
 #include "pack.h"
-#include "pack-revindex.h"
 #include "progress.h"
 #include "packfile.h"
 #include "object-file.h"
diff --git a/pack-write.c b/pack-write.c
index b19ddf15b28..80ecfa544c5 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -7,7 +7,6 @@
 #include "remote.h"
 #include "chunk-format.h"
 #include "pack-mtimes.h"
-#include "oidmap.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
 #include "path.h"
diff --git a/packfile.c b/packfile.c
index 9cc0a2e37a8..84a005674d8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -9,7 +9,6 @@
 #include "mergesort.h"
 #include "packfile.h"
 #include "delta.h"
-#include "streaming.h"
 #include "hash-lookup.h"
 #include "commit.h"
 #include "object.h"
diff --git a/parse-options.c b/parse-options.c
index e0c94b0546b..6054a3ca5ae 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -2,8 +2,6 @@
 #include "parse-options.h"
 #include "abspath.h"
 #include "parse.h"
-#include "commit.h"
-#include "color.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "string-list.h"
diff --git a/patch-ids.c b/patch-ids.c
index c3e1a0dd216..a5683b462c6 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -2,7 +2,6 @@
 #include "diff.h"
 #include "commit.h"
 #include "hash.h"
-#include "hash-lookup.h"
 #include "hex.h"
 #include "patch-ids.h"
 
diff --git a/protocol-caps.c b/protocol-caps.c
index 808a68c974a..75f4cbb0a70 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -3,7 +3,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "pkt-line.h"
-#include "strvec.h"
 #include "hash-ll.h"
 #include "hex.h"
 #include "object.h"
diff --git a/reachable.c b/reachable.c
index 0ce8f83e56a..f29b06a5d05 100644
--- a/reachable.c
+++ b/reachable.c
@@ -2,7 +2,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
-#include "tag.h"
 #include "commit.h"
 #include "blob.h"
 #include "diff.h"
diff --git a/read-cache.c b/read-cache.c
index 080bd39713b..08970caff7c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -20,7 +20,6 @@
 #include "oid-array.h"
 #include "tree.h"
 #include "commit.h"
-#include "blob.h"
 #include "environment.h"
 #include "gettext.h"
 #include "mem-pool.h"
@@ -31,7 +30,6 @@
 #include "read-cache.h"
 #include "resolve-undo.h"
 #include "revision.h"
-#include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
 #include "varint.h"
diff --git a/ref-filter.c b/ref-filter.c
index e4d3510e28e..96959a3762c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -22,12 +22,10 @@
 #include "ref-filter.h"
 #include "revision.h"
 #include "utf8.h"
-#include "version.h"
 #include "versioncmp.h"
 #include "trailer.h"
 #include "wt-status.h"
 #include "commit-slab.h"
-#include "commit-graph.h"
 #include "commit-reach.h"
 #include "worktree.h"
 #include "hashmap.h"
diff --git a/reflog.c b/reflog.c
index 9ad50e7d93e..0a1bc35e8cd 100644
--- a/reflog.c
+++ b/reflog.c
@@ -6,7 +6,6 @@
 #include "revision.h"
 #include "tree.h"
 #include "tree-walk.h"
-#include "worktree.h"
 
 /* Remember to update object flag allocation in object.h */
 #define INCOMPLETE	(1u<<10)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index db5c0c7a724..922e65e0d9c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,5 +1,4 @@
 #include "../git-compat-util.h"
-#include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -19,7 +18,6 @@
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
-#include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 #include "../revision.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 59c78d7941f..5963e67c14c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,5 +1,4 @@
 #include "../git-compat-util.h"
-#include "../alloc.h"
 #include "../config.h"
 #include "../gettext.h"
 #include "../hash.h"
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 6e3b725245c..a372a00941f 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -1,5 +1,4 @@
 #include "../git-compat-util.h"
-#include "../alloc.h"
 #include "../hash.h"
 #include "../refs.h"
 #include "../repository.h"
diff --git a/reftable/dump.c b/reftable/dump.c
index ce936b4e188..26e0393c7db 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -11,14 +11,12 @@ https://developers.google.com/open-source/licenses/bsd
 
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
-#include "reftable-merged.h"
 #include "reftable-record.h"
 #include "reftable-tests.h"
 #include "reftable-writer.h"
 #include "reftable-iterator.h"
 #include "reftable-reader.h"
 #include "reftable-stack.h"
-#include "reftable-generic.h"
 
 #include <stddef.h>
 #include <stdio.h>
diff --git a/reftable/generic.c b/reftable/generic.c
index 57f8032db94..b9f1c7c18a2 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -6,7 +6,6 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "basics.h"
 #include "constants.h"
 #include "record.h"
 #include "generic.h"
diff --git a/reftable/merged.c b/reftable/merged.c
index 5ded470c086..9191f3addd1 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -11,7 +11,6 @@ https://developers.google.com/open-source/licenses/bsd
 #include "constants.h"
 #include "iter.h"
 #include "pq.h"
-#include "reader.h"
 #include "record.h"
 #include "generic.h"
 #include "reftable-merged.h"
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index d08c16abefb..0d6e0d4bf57 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -12,7 +12,6 @@ https://developers.google.com/open-source/licenses/bsd
 
 #include "basics.h"
 #include "blocksource.h"
-#include "constants.h"
 #include "reader.h"
 #include "record.h"
 #include "test_framework.h"
diff --git a/reftable/reader.c b/reftable/reader.c
index b4db23ce188..8b7a27781c3 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -16,7 +16,6 @@ https://developers.google.com/open-source/licenses/bsd
 #include "record.h"
 #include "reftable-error.h"
 #include "reftable-generic.h"
-#include "tree.h"
 
 uint64_t block_source_size(struct reftable_block_source *source)
 {
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 469ab79a5ad..f0d468be394 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -11,7 +11,6 @@ https://developers.google.com/open-source/licenses/bsd
 #include "basics.h"
 #include "block.h"
 #include "blocksource.h"
-#include "constants.h"
 #include "reader.h"
 #include "record.h"
 #include "test_framework.h"
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
index 8645cd93bbd..699e1aea412 100644
--- a/reftable/refname_test.c
+++ b/reftable/refname_test.c
@@ -9,7 +9,6 @@ https://developers.google.com/open-source/licenses/bsd
 #include "basics.h"
 #include "block.h"
 #include "blocksource.h"
-#include "constants.h"
 #include "reader.h"
 #include "record.h"
 #include "refname.h"
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d0b717510fa..d1b2908fa36 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -13,7 +13,6 @@ https://developers.google.com/open-source/licenses/bsd
 #include "reftable-reader.h"
 #include "merged.h"
 #include "basics.h"
-#include "constants.h"
 #include "record.h"
 #include "test_framework.h"
 #include "reftable-tests.h"
diff --git a/reftable/test_framework.c b/reftable/test_framework.c
index 84ac972cad0..04044fc1a0f 100644
--- a/reftable/test_framework.c
+++ b/reftable/test_framework.c
@@ -9,7 +9,6 @@ https://developers.google.com/open-source/licenses/bsd
 #include "system.h"
 #include "test_framework.h"
 
-#include "basics.h"
 
 void set_test_hash(uint8_t *p, int i)
 {
diff --git a/reftable/tree_test.c b/reftable/tree_test.c
index ac3a045ad4a..6961a657adb 100644
--- a/reftable/tree_test.c
+++ b/reftable/tree_test.c
@@ -9,8 +9,6 @@ https://developers.google.com/open-source/licenses/bsd
 #include "system.h"
 #include "tree.h"
 
-#include "basics.h"
-#include "record.h"
 #include "test_framework.h"
 #include "reftable-tests.h"
 
diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca57..204feebabe4 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -8,7 +8,6 @@
 #include "strbuf.h"
 #include "walker.h"
 #include "http.h"
-#include "exec-cmd.h"
 #include "run-command.h"
 #include "pkt-line.h"
 #include "string-list.h"
diff --git a/remote.c b/remote.c
index abb24822beb..6bef95316af 100644
--- a/remote.c
+++ b/remote.c
@@ -15,7 +15,6 @@
 #include "diff.h"
 #include "revision.h"
 #include "dir.h"
-#include "tag.h"
 #include "setup.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/rerere.c b/rerere.c
index 09e19412859..ca7e77ba68c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -12,12 +12,10 @@
 #include "dir.h"
 #include "resolve-undo.h"
 #include "merge-ll.h"
-#include "attr.h"
 #include "path.h"
 #include "pathspec.h"
 #include "object-file.h"
 #include "object-store-ll.h"
-#include "hash-lookup.h"
 #include "strmap.h"
 
 #define RESOLVED 0
diff --git a/reset.c b/reset.c
index 48da0adf851..0f2ff0fe315 100644
--- a/reset.c
+++ b/reset.c
@@ -6,7 +6,6 @@
 #include "object-name.h"
 #include "refs.h"
 #include "reset.h"
-#include "run-command.h"
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
diff --git a/revision.c b/revision.c
index 00d5c29bfce..51c056adbe1 100644
--- a/revision.c
+++ b/revision.c
@@ -21,12 +21,10 @@
 #include "reflog-walk.h"
 #include "patch-ids.h"
 #include "decorate.h"
-#include "log-tree.h"
 #include "string-list.h"
 #include "line-log.h"
 #include "mailmap.h"
 #include "commit-slab.h"
-#include "dir.h"
 #include "cache-tree.h"
 #include "bisect.h"
 #include "packfile.h"
diff --git a/run-command.c b/run-command.c
index a558042c876..0e7435718a5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -14,9 +14,7 @@
 #include "quote.h"
 #include "config.h"
 #include "packfile.h"
-#include "hook.h"
 #include "compat/nonblock.h"
-#include "alloc.h"
 
 void child_process_init(struct child_process *child)
 {
diff --git a/send-pack.c b/send-pack.c
index 89aca9d829e..37f59d4f66b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -4,7 +4,6 @@
 #include "date.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
 #include "object-store-ll.h"
 #include "pkt-line.h"
 #include "sideband.h"
@@ -12,7 +11,6 @@
 #include "remote.h"
 #include "connect.h"
 #include "send-pack.h"
-#include "quote.h"
 #include "transport.h"
 #include "version.h"
 #include "oid-array.h"
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed9..fab88e4efcb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -15,10 +15,8 @@
 #include "pager.h"
 #include "commit.h"
 #include "sequencer.h"
-#include "tag.h"
 #include "run-command.h"
 #include "hook.h"
-#include "exec-cmd.h"
 #include "utf8.h"
 #include "cache-tree.h"
 #include "diff.h"
@@ -39,7 +37,6 @@
 #include "notes-utils.h"
 #include "sigchain.h"
 #include "unpack-trees.h"
-#include "worktree.h"
 #include "oidmap.h"
 #include "oidset.h"
 #include "commit-slab.h"
diff --git a/setup.c b/setup.c
index fc592dc6dd5..c5d3efe1964 100644
--- a/setup.c
+++ b/setup.c
@@ -13,7 +13,6 @@
 #include "string-list.h"
 #include "chdir-notify.h"
 #include "path.h"
-#include "promisor-remote.h"
 #include "quote.h"
 #include "trace2.h"
 #include "worktree.h"
diff --git a/shallow.c b/shallow.c
index ac728cdd778..7711798127e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -7,7 +7,6 @@
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
-#include "remote.h"
 #include "refs.h"
 #include "oid-array.h"
 #include "path.h"
diff --git a/shell.c b/shell.c
index 5c67e7bd97e..2ece8b16e2e 100644
--- a/shell.c
+++ b/shell.c
@@ -4,7 +4,6 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "alias.h"
-#include "prompt.h"
 
 #define COMMAND_DIR "git-shell-commands"
 #define HELP_COMMAND COMMAND_DIR "/help"
diff --git a/submodule.c b/submodule.c
index e603a19a876..213da79f661 100644
--- a/submodule.c
+++ b/submodule.c
@@ -17,10 +17,8 @@
 #include "string-list.h"
 #include "oid-array.h"
 #include "strvec.h"
-#include "blob.h"
 #include "thread-utils.h"
 #include "path.h"
-#include "quote.h"
 #include "remote.h"
 #include "worktree.h"
 #include "parse-options.h"
@@ -30,7 +28,6 @@
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
-#include "shallow.h"
 #include "trace2.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 475058592d1..09dc78733c0 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -5,9 +5,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "transport.h"
-#include "ref-filter.h"
 #include "remote.h"
-#include "refs.h"
 
 enum input_mode {
 	KEY_VALUE_PAIRS,
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 3e173399a00..1e159a754db 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,11 +1,9 @@
 #include "test-tool.h"
 #include "commit.h"
 #include "commit-reach.h"
-#include "config.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "parse-options.h"
 #include "ref-filter.h"
 #include "setup.h"
 #include "string-list.h"
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 4cd8a952e5c..c925655c648 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -1,7 +1,6 @@
 #include "test-tool.h"
 #include "commit-graph.h"
 #include "commit.h"
-#include "config.h"
 #include "environment.h"
 #include "hex.h"
 #include "object-store-ll.h"
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 941ae7e3bcf..fb5927775da 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -4,7 +4,6 @@
 
 #include "test-tool.h"
 #include "gettext.h"
-#include "strbuf.h"
 #include "simple-ipc.h"
 #include "parse-options.h"
 #include "thread-utils.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 5f9074ad1c0..3509258be53 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -6,7 +6,6 @@
 #include "environment.h"
 #include "object-file.h"
 #include "path.h"
-#include "sigchain.h"
 #include "string-list.h"
 #include "strbuf.h"
 #include "strvec.h"
diff --git a/trace2.c b/trace2.c
index 6dc74dff4c7..d961f0e3a84 100644
--- a/trace2.c
+++ b/trace2.c
@@ -1,12 +1,9 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "json-writer.h"
-#include "quote.h"
 #include "repository.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "thread-utils.h"
-#include "version.h"
 #include "trace.h"
 #include "trace2.h"
 #include "trace2/tr2_cfg.h"
diff --git a/transport-helper.c b/transport-helper.c
index 49811ef176d..e34a8f47cfb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -3,13 +3,11 @@
 #include "quote.h"
 #include "run-command.h"
 #include "commit.h"
-#include "diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
 #include "repository.h"
-#include "revision.h"
 #include "remote.h"
 #include "string-list.h"
 #include "thread-utils.h"
diff --git a/transport.c b/transport.c
index 219af8fd50e..bd7899e9bf5 100644
--- a/transport.c
+++ b/transport.c
@@ -10,9 +10,7 @@
 #include "remote.h"
 #include "connect.h"
 #include "send-pack.h"
-#include "walker.h"
 #include "bundle.h"
-#include "dir.h"
 #include "gettext.h"
 #include "refs.h"
 #include "refspec.h"
@@ -26,7 +24,6 @@
 #include "transport-internal.h"
 #include "protocol.h"
 #include "object-name.h"
-#include "object-store-ll.h"
 #include "color.h"
 #include "bundle-uri.h"
 
diff --git a/tree.c b/tree.c
index 990f9c9854e..508e5fd76fd 100644
--- a/tree.c
+++ b/tree.c
@@ -1,12 +1,9 @@
 #include "git-compat-util.h"
-#include "cache-tree.h"
 #include "hex.h"
 #include "tree.h"
 #include "object-name.h"
 #include "object-store-ll.h"
-#include "blob.h"
 #include "commit.h"
-#include "tag.h"
 #include "alloc.h"
 #include "tree-walk.h"
 #include "repository.h"
diff --git a/upload-pack.c b/upload-pack.c
index ea234ab6a45..2537affa907 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -9,13 +9,10 @@
 #include "repository.h"
 #include "object-store-ll.h"
 #include "oid-array.h"
-#include "tag.h"
 #include "object.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
-#include "list-objects.h"
-#include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "run-command.h"
 #include "connect.h"
@@ -24,11 +21,8 @@
 #include "string-list.h"
 #include "strvec.h"
 #include "trace2.h"
-#include "prio-queue.h"
 #include "protocol.h"
-#include "quote.h"
 #include "upload-pack.h"
-#include "serve.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
diff --git a/wrapper.c b/wrapper.c
index 7da15a56da6..eeac3741cf1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,7 +5,6 @@
 #include "abspath.h"
 #include "parse.h"
 #include "gettext.h"
-#include "repository.h"
 #include "strbuf.h"
 #include "trace2.h"
 
diff --git a/xdiff-interface.c b/xdiff-interface.c
index adcea109fa9..b39ffb1f718 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -6,8 +6,6 @@
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
-#include "xdiff/xemit.h"
-#include "xdiff/xmacros.h"
 #include "xdiff/xutils.h"
 
 struct xdiff_emit_state {
-- 
gitgitgadget

