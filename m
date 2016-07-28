Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47831F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbcG1Q1R (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:27:17 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35053 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516AbcG1Q1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:27:16 -0400
Received: by mail-pa0-f65.google.com with SMTP id cf3so3776983pad.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:27:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=afmE4KcD69WMGfQCBzopz2yCnqmpP0rp1MK2uDVvsGE=;
        b=pjb7sVriDFycHItgaP5qisysySClpMiz3Wi1+bu933ktn7r9RD9KrOAR6u1hRLM7c3
         rnOZk3pkaVJSXChgAS/UE3pe3bZe4syCan3dnKgPHYD+DoykOB8RZjmc43J+aKZXmCxK
         mK7PV1fX8VUgJ7DaRJJ5UgSocFpeePZbLOTSjuS5VRyX7SxIXc2XUz/zAPGmWVeU22Ss
         SCBG12H8vDYMINdOxx0o0NCOiEX3+qrbyDSVZGysF0z82AoM8pqjhQ3E/PeVOMZFIkVr
         cGHWlQgRTCjhQWysWbRlcTJTG67CX6MNfyMTgInxdfU5tbw1sm5rwABq5Q3V+CVE4P56
         C64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=afmE4KcD69WMGfQCBzopz2yCnqmpP0rp1MK2uDVvsGE=;
        b=mtS2TEhHCP8uOecPUT4o+JKMmAujPQkMzNwGIbdk8uF3Y1DS+U70YS6qXRxs1UeQP8
         ffgqb8+EUDYtcGBeKFXOkQqsB7k1Cb9Xb+TuWGLyma43ozhTbvraqMx4zkvI7yZ4x/IC
         fsE8WTtmgyIPGmAOldHuKPy2OD2417CbkvlH0qiSNVYWa0nKrGq3e9dQL/YtKAyIZbZR
         jddgNvSZZVXD5EoYYqMj5fbg7lmS5pFeElGZwLOYsHMaak53Ge17X2o3P8BH36DTGB6i
         ACKb1TGrU3c/fl1bj1FV8G8I7arfyjpi5q8SO96nXZLCWhp1nO6qJtu+wROCDJzkhYhK
         A5Zw==
X-Gm-Message-State: AEkoouvIHlQRZ0OWL/iymXkjkyg/598SDMASpqDc5yONWxGOu0tr5W+To1uqH7Hg8D28zw==
X-Received: by 10.66.181.139 with SMTP id dw11mr61291466pac.2.1469723235228;
        Thu, 28 Jul 2016 09:27:15 -0700 (PDT)
Received: from tci.corp.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id u7sm18186488paz.45.2016.07.28.09.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:27:14 -0700 (PDT)
Date:	Thu, 28 Jul 2016 09:27:12 -0700
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	Jeff King <peff@peff.net>
Subject: [PATCH 0/3] diff-highlight: add support for git log --graph output.
Message-ID: <20160728162712.GA29220@tci.corp.yp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, I've been working with Jeff King on this patch, but he encouraged me to
email the list.

I recently learned about the diff-highlight tool and find it very helpful,
however, I frequently use the --graph option to git log which breaks the tool.
This patch looks to fix this.

I wanted to try and add some tests as well, but I was unsure what number to
pick for the second digit. As there were limited tests in the contrib directory
(only t93xx and one t7900) I just chose the next number in the 9xxx range.
Please let me know if I need to change it.

I'm also not super happy about my test case for the graph option. If anyone has
any better ideas, please let me know!

Brian Henderson (3):
  diff-highlight: add some tests.
  diff-highlight: add failing test for handling --graph output.
  diff-highlight: add support for --graph output.

 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/diff-highlight            |  13 +--
 contrib/diff-highlight/t/Makefile                |  19 ++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh |  76 ++++++++++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 111 +++++++++++++++++++++++
 5 files changed, 218 insertions(+), 6 deletions(-)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
 create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh

-- 
2.9.0


--VbJkn9YxBvnuCH5J
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-diff-highlight-add-some-tests.patch"

From f2468205f5f43b17bfd0398959a1ae66588a8f0d Mon Sep 17 00:00:00 2001
From: Brian Henderson <henderson.bj@gmail.com>
Date: Thu, 21 Jul 2016 09:43:54 -0700
Subject: [PATCH 1/3] diff-highlight: add some tests.

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


--VbJkn9YxBvnuCH5J
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-diff-highlight-add-failing-test-for-handling-graph-o.patch"

From 78cca284fb5d0c094dc47947cb4cc54c5a8c0f78 Mon Sep 17 00:00:00 2001
From: Brian Henderson <henderson.bj@gmail.com>
Date: Tue, 26 Jul 2016 07:49:45 -0700
Subject: [PATCH 2/3] diff-highlight: add failing test for handling --graph
 output.

---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 13 ++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 42 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index ca7605f..2fb4869 100644
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -60,4 +60,17 @@ test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
 
 # TODO add multi-byte test
 
+test_expect_success 'diff-highlight highlightes the beginning of a line' '
+  dh_graph_test \
+    "aaa\nbbb\nccc\n" \
+    "aaa\n0bb\nccc\n" \
+    "aaa\nb0b\nccc\n" \
+"
+ aaa
+-${CW}b${CR}bb
++${CW}0${CR}bb
+ ccc
+"
+'
+
 test_done
diff --git a/contrib/diff-highlight/t/test-diff-highlight.sh b/contrib/diff-highlight/t/test-diff-highlight.sh
index 9b26271..162a694 100644
--- a/contrib/diff-highlight/t/test-diff-highlight.sh
+++ b/contrib/diff-highlight/t/test-diff-highlight.sh
@@ -67,3 +67,45 @@ dh_commit_test() {
 
   diff commit.exp commit.act
 }
+
+dh_graph_test() {
+  local a="$1" b="$2" c="$3"
+
+  {
+    printf "$a" > file
+    git add file
+    git commit -m"Add a file"
+
+    printf "$b" > file
+    git commit -am"Update a file"
+
+    git checkout -b branch
+    printf "$c" > file
+    git commit -am"Update a file on branch"
+
+    git checkout master
+    printf "$a" > file
+    git commit -am"Update a file again"
+
+    git checkout branch
+    printf "$b" > file
+    git commit -am"Update a file similar to master"
+
+    git merge master
+    git checkout master
+    git merge branch --no-ff
+  } >/dev/null 2>&1
+
+  git log -p --graph --no-merges > graph.raw
+
+  # git log --graph orders the commits different than git log so we hack it by
+  # using sed to remove the graph part. We know from other tests, that CMD
+  # works without the graph, so there should be no diff when running it with
+  # and without.
+  < graph.raw sed -e 's"^\(*\|| \||/\)\+""' -e 's"^  ""' | $CMD > graph.exp
+  < graph.raw $CMD | sed -e 's"^\(*\|| \||/\)\+""' -e 's"^  ""' > graph.act
+
+  # ignore whitespace since we're using a hacky sed command to remove the graph
+  # parts.
+  diff -b graph.exp graph.act
+}
-- 
2.9.0


--VbJkn9YxBvnuCH5J
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-diff-highlight-add-support-for-graph-output.patch"

From 615451541643a07486e209f9f17edae9436b882c Mon Sep 17 00:00:00 2001
From: Brian Henderson <henderson.bj@gmail.com>
Date: Tue, 26 Jul 2016 07:51:07 -0700
Subject: [PATCH 3/3] diff-highlight: add support for --graph output.

---
 contrib/diff-highlight/diff-highlight | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..ec31356 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -20,6 +20,7 @@ my @NEW_HIGHLIGHT = (
 my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
+my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;
 
 my @removed;
 my @added;
@@ -32,12 +33,12 @@ $SIG{PIPE} = 'DEFAULT';
 while (<>) {
 	if (!$in_hunk) {
 		print;
-		$in_hunk = /^$COLOR*\@/;
+		$in_hunk = /^$GRAPH*$COLOR*\@/;
 	}
-	elsif (/^$COLOR*-/) {
+	elsif (/^$GRAPH*$COLOR*-/) {
 		push @removed, $_;
 	}
-	elsif (/^$COLOR*\+/) {
+	elsif (/^$GRAPH*$COLOR*\+/) {
 		push @added, $_;
 	}
 	else {
@@ -46,7 +47,7 @@ while (<>) {
 		@added = ();
 
 		print;
-		$in_hunk = /^$COLOR*[\@ ]/;
+		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
 	}
 
 	# Most of the time there is enough output to keep things streaming,
@@ -211,8 +212,8 @@ sub is_pair_interesting {
 	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
 	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
 
-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
+	return $prefix_a !~ /^$GRAPH*$COLOR*-$BORING*$/ ||
+	       $prefix_b !~ /^$GRAPH*$COLOR*\+$BORING*$/ ||
 	       $suffix_a !~ /^$BORING*$/ ||
 	       $suffix_b !~ /^$BORING*$/;
 }
-- 
2.9.0


--VbJkn9YxBvnuCH5J--
