Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056D41F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 15:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcG3PMd (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 11:12:33 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35021 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbcG3PMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 11:12:19 -0400
Received: by mail-pa0-f68.google.com with SMTP id cf3so6844910pad.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 08:12:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3i9fdQPsBt6WbWAE+mFYGEFAJiq84j8ysRW80CRBEUI=;
        b=wBauSW2FrGrDQS5l6BvuOZzGaYmllABOrB8+AW9lyrslvimeLFh5wVVTQoipdxnP19
         JcXcjQR9obDeytXOKu4bLETkwt65SZqLvV/FNTj84YpWrWdsQsCDSw/hmkg98DBOKoaB
         kmGzXtZa2LEo5n14FLmgFotoO1nH0STJMP/T5lJ5ek8wDKT/xNXDpr3UGLTF4MAxo4Bb
         G3Z1golSSxXySdSaZC5vJt2Ib62TszNhIgLL6WK1p17zLya8Vnvdxbdoe+MK23wPEKby
         +sLxoDABGRjqb1/XbDgNx5r0X1ZunS400cUbyUcYdir9T0LEgnap/RY2vmgGUYF/EIMA
         p2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3i9fdQPsBt6WbWAE+mFYGEFAJiq84j8ysRW80CRBEUI=;
        b=je2IcBoox3k4KA5GXSDQ29c4HM7VbP5Aa4RVGqa8C3eYw66DVTtbYRSsvbP6dL7+2j
         rzYfnnFeTs1AMRdhY7rInY5kpX1Po8ROXhAT49nOw6R7v+bTJDdz85dKW7Bv3oZLb+sX
         y/3kqNbx4mOmt6VOU8bLqDP+bvnvRfNN9zZjv0XZkdB6a6huAHpIdGG2/lPE+pTBdCpJ
         EMa/LhXlTtVs2+Ja+axlyt3rpaoEmlOe4OfzusD17BjiliB03CHTGYBjbK4taV/ZzAxo
         7LqU4LVi019qLD9OkPOxK1qRJ1qglmeOQQ1E3uNQhRzz01/VOGqUwPiMW90DaOjKlaVt
         TrNQ==
X-Gm-Message-State: AEkoous6jg0AxcyY8aZ9IisB99N3Cqc+hvIE/yfcpeEPBTaGrSca1U/0x0UyrVdTDHMlPQ==
X-Received: by 10.66.41.133 with SMTP id f5mr79861548pal.70.1469891538404;
        Sat, 30 Jul 2016 08:12:18 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id x184sm33113398pfd.70.2016.07.30.08.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 08:12:18 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH 1/3] diff-highlight: add some tests.
Date:	Sat, 30 Jul 2016 08:11:47 -0700
Message-Id: <20160730151149.15980-2-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160730151149.15980-1-henderson.bj@gmail.com>
References: <20160730151149.15980-1-henderson.bj@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
 contrib/diff-highlight/Makefile                  |  5 ++
 contrib/diff-highlight/t/Makefile                | 19 +++++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 63 ++++++++++++++++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 69 ++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
 create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh

diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
new file mode 100644
index 0000000..b866259
--- /dev/null
+++ b/contrib/diff-highlight/Makefile
@@ -0,0 +1,5 @@
+# nothing to build
+all:;
+
+test:
+	$(MAKE) -C t
diff --git a/contrib/diff-highlight/t/Makefile b/contrib/diff-highlight/t/Makefile
new file mode 100644
index 0000000..ac81fc0
--- /dev/null
+++ b/contrib/diff-highlight/t/Makefile
@@ -0,0 +1,19 @@
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
+
+all: test
+test: $(T)
+
+.PHONY: help clean all test $(T)
+
+help:
+	@echo 'Run "$(MAKE) test" to launch test scripts'
+	@echo 'Run "$(MAKE) clean" to remove trash folders'
+
+$(T):
+	@echo "*** $@ ***"; sh $@ $(GIT_TEST_OPTS)
+
+clean:
+	$(RM) -r 'trash directory'.*
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
new file mode 100644
index 0000000..ca7605f
--- /dev/null
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Copyright (C) 2016
+
+test_description='Test diff-highlight'
+
+. ./test-diff-highlight.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+# PERL is required, but assumed to be present, although not necessarily modern
+# some tests require 5.8
+
+test_expect_success 'diff-highlight highlightes the beginning of a line' '
+  dh_test \
+    "aaa\nbbb\nccc\n" \
+    "aaa\n0bb\nccc\n" \
+"
+ aaa
+-${CW}b${CR}bb
++${CW}0${CR}bb
+ ccc
+"
+'
+
+test_expect_success 'diff-highlight highlightes the end of a line' '
+  dh_test \
+    "aaa\nbbb\nccc\n" \
+    "aaa\nbb0\nccc\n" \
+"
+ aaa
+-bb${CW}b${CR}
++bb${CW}0${CR}
+ ccc
+"
+'
+
+test_expect_success 'diff-highlight highlightes the middle of a line' '
+  dh_test \
+    "aaa\nbbb\nccc\n" \
+    "aaa\nb0b\nccc\n" \
+"
+ aaa
+-b${CW}b${CR}b
++b${CW}0${CR}b
+ ccc
+"
+'
+
+test_expect_success 'diff-highlight does not highlight whole line' '
+  dh_test \
+    "aaa\nbbb\nccc\n" \
+    "aaa\n000\nccc\n"
+'
+
+test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
+  dh_test \
+    "aaa\nbbb\n" \
+    "aaa\nb0b\nccc\n"
+'
+
+# TODO add multi-byte test
+
+test_done
diff --git a/contrib/diff-highlight/t/test-diff-highlight.sh b/contrib/diff-highlight/t/test-diff-highlight.sh
new file mode 100644
index 0000000..9b26271
--- /dev/null
+++ b/contrib/diff-highlight/t/test-diff-highlight.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (C) 2016
+
+CURR_DIR=$(pwd)
+TEST_OUTPUT_DIRECTORY=$(pwd)
+TEST_DIRECTORY="$CURR_DIR"/../../../t
+cmd=diff-highlight
+CMD="$CURR_DIR"/../$cmd
+
+CW="\033[7m"
+CR="\033[27m"
+
+export TEST_OUTPUT_DIRECTORY TEST_DIRECTORY CW CR
+
+dh_test() {
+  dh_diff_test "$@"
+  dh_commit_test "$@"
+}
+
+dh_diff_test() {
+  local a="$1" b="$2"
+
+  printf "$a" > file
+  git add file
+
+  printf "$b" > file
+
+  git diff file > diff.raw
+
+  if test "$#" = 3
+  then
+    # remove last newline
+    head -n5 diff.raw | head -c -1 > diff.act
+    printf "$3" >> diff.act
+  else
+    cat diff.raw > diff.act
+  fi
+
+  < diff.raw $CMD > diff.exp
+
+  diff diff.exp diff.act
+}
+
+dh_commit_test() {
+  local a="$1" b="$2"
+
+  printf "$a" > file
+  git add file
+  git commit -m"Add a file" >/dev/null
+
+  printf "$b" > file
+  git commit -am"Update a file" >/dev/null
+
+  git show > commit.raw
+
+  if test "$#" = 3
+  then
+    # remove last newline
+    head -n11 commit.raw | head -c -1 > commit.act
+    printf "$3" >> commit.act
+  else
+    cat commit.raw > commit.act
+  fi
+
+  < commit.raw $CMD > commit.exp
+
+  diff commit.exp commit.act
+}
-- 
2.9.0

