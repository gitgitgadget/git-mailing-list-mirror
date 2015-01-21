From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] Makefile: collect some Makefile variables instead of directly assignment
Date: Wed, 21 Jan 2015 14:49:21 +0600
Message-ID: <1421830161-27623-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDqyx-0003QO-QK
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 09:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbbAUItn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 03:49:43 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:64778 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbAUItl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 03:49:41 -0500
Received: by mail-la0-f50.google.com with SMTP id pn19so38866574lab.9
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 00:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/FeAlFRxv7qZs5AHJ8rfg4l6qWDF2JWD0CERR0ynBug=;
        b=xsW555wBl5WDbVKZE+HTN+MJ7fvDlZJC0jB+wlSlonOP2wdTMSaThq27/fLkFP8php
         KbEFZah8AbcsuXiJBLP90ReQU4ozBLvN/T9WYv+NU8RzmRudNXO6t4YJcHkXZF2kFS3Q
         xXks87YZpijEnPdz8M7l5bBFm6oBWUieARvrYhzfS1V/xhyRpce6tySOanpIniv1i0kv
         Sry5EwET24nIm2VxY0Dmok0zk/5wLIFH00t4iN6bs03KpnPBVpByOKFcpSqXRz8jNXQU
         98ajSjB1hZQd8eQ1tf3nVc+oKyTOm9VI/yROkIYYB4a2s5qF9RHIyqZ7wPeCUkSqiqxJ
         7E6Q==
X-Received: by 10.152.22.129 with SMTP id d1mr11378589laf.22.1421830179681;
        Wed, 21 Jan 2015 00:49:39 -0800 (PST)
Received: from localhost.localdomain ([147.30.53.164])
        by mx.google.com with ESMTPSA id ya4sm4718750lbb.32.2015.01.21.00.49.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 00:49:38 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262716>

Some of Makefile variables as TEST_PROGRAMS_NEED_X and BUILTIN_OBJS filled
directly by hand, let's collect it with the standard functions of 'make' util.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Makefile | 134 +--------------------------------------------------------------
 1 file changed, 2 insertions(+), 132 deletions(-)

diff --git a/Makefile b/Makefile
index b5b4cee..055db4b 100644
--- a/Makefile
+++ b/Makefile
@@ -563,38 +563,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
-TEST_PROGRAMS_NEED_X += test-chmtime
-TEST_PROGRAMS_NEED_X += test-ctype
-TEST_PROGRAMS_NEED_X += test-config
-TEST_PROGRAMS_NEED_X += test-date
-TEST_PROGRAMS_NEED_X += test-delta
-TEST_PROGRAMS_NEED_X += test-dump-cache-tree
-TEST_PROGRAMS_NEED_X += test-dump-split-index
-TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
-TEST_PROGRAMS_NEED_X += test-genrandom
-TEST_PROGRAMS_NEED_X += test-hashmap
-TEST_PROGRAMS_NEED_X += test-index-version
-TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-match-trees
-TEST_PROGRAMS_NEED_X += test-mergesort
-TEST_PROGRAMS_NEED_X += test-mktemp
-TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-path-utils
-TEST_PROGRAMS_NEED_X += test-prio-queue
-TEST_PROGRAMS_NEED_X += test-read-cache
-TEST_PROGRAMS_NEED_X += test-regex
-TEST_PROGRAMS_NEED_X += test-revision-walking
-TEST_PROGRAMS_NEED_X += test-run-command
-TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
-TEST_PROGRAMS_NEED_X += test-sha1
-TEST_PROGRAMS_NEED_X += test-sha1-array
-TEST_PROGRAMS_NEED_X += test-sigchain
-TEST_PROGRAMS_NEED_X += test-string-list
-TEST_PROGRAMS_NEED_X += test-submodule-config
-TEST_PROGRAMS_NEED_X += test-subprocess
-TEST_PROGRAMS_NEED_X += test-svn-fe
-TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
-TEST_PROGRAMS_NEED_X += test-wildmatch
+TEST_PROGRAMS_NEED_X = $(patsubst %.c,%, $(wildcard test-*.c))
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
@@ -811,105 +780,7 @@ LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
-BUILTIN_OBJS += builtin/add.o
-BUILTIN_OBJS += builtin/annotate.o
-BUILTIN_OBJS += builtin/apply.o
-BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
-BUILTIN_OBJS += builtin/blame.o
-BUILTIN_OBJS += builtin/branch.o
-BUILTIN_OBJS += builtin/bundle.o
-BUILTIN_OBJS += builtin/cat-file.o
-BUILTIN_OBJS += builtin/check-attr.o
-BUILTIN_OBJS += builtin/check-ignore.o
-BUILTIN_OBJS += builtin/check-mailmap.o
-BUILTIN_OBJS += builtin/check-ref-format.o
-BUILTIN_OBJS += builtin/checkout-index.o
-BUILTIN_OBJS += builtin/checkout.o
-BUILTIN_OBJS += builtin/clean.o
-BUILTIN_OBJS += builtin/clone.o
-BUILTIN_OBJS += builtin/column.o
-BUILTIN_OBJS += builtin/commit-tree.o
-BUILTIN_OBJS += builtin/commit.o
-BUILTIN_OBJS += builtin/config.o
-BUILTIN_OBJS += builtin/count-objects.o
-BUILTIN_OBJS += builtin/credential.o
-BUILTIN_OBJS += builtin/describe.o
-BUILTIN_OBJS += builtin/diff-files.o
-BUILTIN_OBJS += builtin/diff-index.o
-BUILTIN_OBJS += builtin/diff-tree.o
-BUILTIN_OBJS += builtin/diff.o
-BUILTIN_OBJS += builtin/fast-export.o
-BUILTIN_OBJS += builtin/fetch-pack.o
-BUILTIN_OBJS += builtin/fetch.o
-BUILTIN_OBJS += builtin/fmt-merge-msg.o
-BUILTIN_OBJS += builtin/for-each-ref.o
-BUILTIN_OBJS += builtin/fsck.o
-BUILTIN_OBJS += builtin/gc.o
-BUILTIN_OBJS += builtin/get-tar-commit-id.o
-BUILTIN_OBJS += builtin/grep.o
-BUILTIN_OBJS += builtin/hash-object.o
-BUILTIN_OBJS += builtin/help.o
-BUILTIN_OBJS += builtin/index-pack.o
-BUILTIN_OBJS += builtin/init-db.o
-BUILTIN_OBJS += builtin/interpret-trailers.o
-BUILTIN_OBJS += builtin/log.o
-BUILTIN_OBJS += builtin/ls-files.o
-BUILTIN_OBJS += builtin/ls-remote.o
-BUILTIN_OBJS += builtin/ls-tree.o
-BUILTIN_OBJS += builtin/mailinfo.o
-BUILTIN_OBJS += builtin/mailsplit.o
-BUILTIN_OBJS += builtin/merge.o
-BUILTIN_OBJS += builtin/merge-base.o
-BUILTIN_OBJS += builtin/merge-file.o
-BUILTIN_OBJS += builtin/merge-index.o
-BUILTIN_OBJS += builtin/merge-ours.o
-BUILTIN_OBJS += builtin/merge-recursive.o
-BUILTIN_OBJS += builtin/merge-tree.o
-BUILTIN_OBJS += builtin/mktag.o
-BUILTIN_OBJS += builtin/mktree.o
-BUILTIN_OBJS += builtin/mv.o
-BUILTIN_OBJS += builtin/name-rev.o
-BUILTIN_OBJS += builtin/notes.o
-BUILTIN_OBJS += builtin/pack-objects.o
-BUILTIN_OBJS += builtin/pack-redundant.o
-BUILTIN_OBJS += builtin/pack-refs.o
-BUILTIN_OBJS += builtin/patch-id.o
-BUILTIN_OBJS += builtin/prune-packed.o
-BUILTIN_OBJS += builtin/prune.o
-BUILTIN_OBJS += builtin/push.o
-BUILTIN_OBJS += builtin/read-tree.o
-BUILTIN_OBJS += builtin/receive-pack.o
-BUILTIN_OBJS += builtin/reflog.o
-BUILTIN_OBJS += builtin/remote.o
-BUILTIN_OBJS += builtin/remote-ext.o
-BUILTIN_OBJS += builtin/remote-fd.o
-BUILTIN_OBJS += builtin/repack.o
-BUILTIN_OBJS += builtin/replace.o
-BUILTIN_OBJS += builtin/rerere.o
-BUILTIN_OBJS += builtin/reset.o
-BUILTIN_OBJS += builtin/rev-list.o
-BUILTIN_OBJS += builtin/rev-parse.o
-BUILTIN_OBJS += builtin/revert.o
-BUILTIN_OBJS += builtin/rm.o
-BUILTIN_OBJS += builtin/send-pack.o
-BUILTIN_OBJS += builtin/shortlog.o
-BUILTIN_OBJS += builtin/show-branch.o
-BUILTIN_OBJS += builtin/show-ref.o
-BUILTIN_OBJS += builtin/stripspace.o
-BUILTIN_OBJS += builtin/symbolic-ref.o
-BUILTIN_OBJS += builtin/tag.o
-BUILTIN_OBJS += builtin/unpack-file.o
-BUILTIN_OBJS += builtin/unpack-objects.o
-BUILTIN_OBJS += builtin/update-index.o
-BUILTIN_OBJS += builtin/update-ref.o
-BUILTIN_OBJS += builtin/update-server-info.o
-BUILTIN_OBJS += builtin/upload-archive.o
-BUILTIN_OBJS += builtin/var.o
-BUILTIN_OBJS += builtin/verify-commit.o
-BUILTIN_OBJS += builtin/verify-pack.o
-BUILTIN_OBJS += builtin/verify-tag.o
-BUILTIN_OBJS += builtin/write-tree.o
+BUILTIN_OBJS = $(patsubst %.c,%.o, $(wildcard builtin/*.c))
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
@@ -2520,4 +2391,3 @@ cover_db: coverage-report
 
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
-
-- 
2.3.0-rc1
