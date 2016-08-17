Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85BA31FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 15:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbcHQPcD (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:32:03 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35905 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbcHQPcC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:32:02 -0400
Received: by mail-pa0-f65.google.com with SMTP id ez1so7452778pab.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 08:32:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Yz3TYLa0JNwp1XMytFNilkn0KrqPakQT5m32vhW2YY8=;
        b=z1J1uB39UtLkKmz3QfLlwcKIev2CQjW3F76L2tY9a9nD0+FO79RvFuRMdMZQHK0YXW
         qd67HWtOwqRaogWKCAna0zt8zkpifDEMWdbCu26k3VTb/AzKbIUGhq0hCChab4qTPhaU
         jlm5BgoS1Mh6SdGQ7IiarxAYbBJhrWaAi8OVs8zn2L3HLKFEDYO+y1/K7WEiL4Eg746e
         36BiXouLtchyttgGUzkSr9i3QdXtGAYxQzn3SvExl9Z38/zmO++AONWqf75/joVxRA8P
         ldqHrGLCYVozOgkYksqWwRhomvqcoexR3mHY+3NVa6kKJO81ZtbKRvrSdd/6BTv3Zx8r
         gEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Yz3TYLa0JNwp1XMytFNilkn0KrqPakQT5m32vhW2YY8=;
        b=mQ2HFcN9fGdkQkcQAFiRs+SJg6r5jv9+e2uUklksmPFnD9uZ8lwqUJAkQEBd2IKwCF
         dA1esFOSYqWJm47g3eD8LttuMkJatQaem7iBjykNWtL6WTnLm/Z7Yf2opVnD2b06eAz/
         lWKeG/ozPaUrR81Hpk46ijboFJx4je28zLIVHDJNMr0FJgqJayvGcxsr/R+yRP694GXe
         GVY7E6Y1abcQ2nZkPmVMXPePqj6QYbTdmO87B8aBbuTbn0fgOys98KyY0Dve0uxmCdCM
         OVRcBNmf6XRgycicoFMbTiF4CiPbWxlj9g1DvwPnGyNeWuR6rlv9+9yrYRhlnHVpSR3T
         nGyg==
X-Gm-Message-State: AEkooutoRxi3Dp4ErCnKHVjvKeDJy8dyMuakmTHRR5VT11sbgpu/awd97mGe8lzV7JJyjw==
X-Received: by 10.66.237.71 with SMTP id va7mr11875106pac.124.1471447920955;
        Wed, 17 Aug 2016 08:32:00 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id fe8sm48311671pad.2.2016.08.17.08.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 08:32:00 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, e@80x24.org,
	Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v2 1/3] diff-highlight: add some tests.
Date:	Wed, 17 Aug 2016 08:31:22 -0700
Message-Id: <20160817153124.7770-2-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160817153124.7770-1-henderson.bj@gmail.com>
References: <20160817153124.7770-1-henderson.bj@gmail.com>
In-Reply-To: <20160810085635.GA1672@starla>
References: <20160810085635.GA1672@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/Makefile                  |  5 ++
 contrib/diff-highlight/t/Makefile                | 22 ++++++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 62 +++++++++++++++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 69 ++++++++++++++++++++++++
 4 files changed, 158 insertions(+)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh
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
index 0000000..5ff5275
--- /dev/null
+++ b/contrib/diff-highlight/t/Makefile
@@ -0,0 +1,22 @@
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+# copied from ../../t/Makefile
+SHELL_PATH ?= $(SHELL)
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
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
+	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+
+clean:
+	$(RM) -r 'trash directory'.*
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
new file mode 100755
index 0000000..8eff178
--- /dev/null
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='Test diff-highlight'
+
+. ./test-diff-highlight.sh
+. "$TEST_DIRECTORY"/test-lib.sh
+
+# PERL is required, but assumed to be present, although not necessarily modern
+# some tests require 5.8
+test_expect_success PERL 'name' 'true'
+
+test_expect_success 'diff-highlight highlights the beginning of a line' '
+	dh_test \
+		"aaa\nbbb\nccc\n" \
+		"aaa\n0bb\nccc\n" \
+"
+ aaa
+-${CW}b${CR}bb
++${CW}0${CR}bb
+ ccc
+"
+'
+
+test_expect_success 'diff-highlight highlights the end of a line' '
+	dh_test \
+		"aaa\nbbb\nccc\n" \
+		"aaa\nbb0\nccc\n" \
+"
+ aaa
+-bb${CW}b${CR}
++bb${CW}0${CR}
+ ccc
+"
+'
+
+test_expect_success 'diff-highlight highlights the middle of a line' '
+	dh_test \
+		"aaa\nbbb\nccc\n" \
+		"aaa\nb0b\nccc\n" \
+"
+ aaa
+-b${CW}b${CR}b
++b${CW}0${CR}b
+ ccc
+"
+'
+
+test_expect_success 'diff-highlight does not highlight whole line' '
+	dh_test \
+		"aaa\nbbb\nccc\n" \
+		"aaa\n000\nccc\n"
+'
+
+test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
+	dh_test \
+		"aaa\nbbb\n" \
+		"aaa\nb0b\nccc\n"
+'
+
+# TODO add multi-byte test
+
+test_done
diff --git a/contrib/diff-highlight/t/test-diff-highlight.sh b/contrib/diff-highlight/t/test-diff-highlight.sh
new file mode 100644
index 0000000..38323e8
--- /dev/null
+++ b/contrib/diff-highlight/t/test-diff-highlight.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+CURR_DIR=$(pwd)
+TEST_OUTPUT_DIRECTORY=$(pwd)
+TEST_DIRECTORY="$CURR_DIR"/../../../t
+DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight
+
+CW="\033[7m"
+CR="\033[27m"
+
+export TEST_OUTPUT_DIRECTORY TEST_DIRECTORY CW CR
+
+dh_test() {
+	dh_diff_test "$@" &&
+	dh_commit_test "$@"
+}
+
+dh_diff_test() {
+	a="$1" b="$2"
+
+	printf "$a" >file
+	git add file
+
+	printf "$b" >file
+	git diff file >diff.raw
+
+	if test $# -eq 3
+	then
+		# remove last newline
+		head -n5 diff.raw | test_chomp_eof >diff.exp
+		printf "$3" >>diff.exp
+	else
+		cat diff.raw >diff.exp
+	fi
+
+	<diff.raw "$DIFF_HIGHLIGHT" >diff.act &&
+	test -s diff.act &&
+	diff diff.exp diff.act
+}
+
+dh_commit_test() {
+	a="$1" b="$2"
+
+	printf "$a" >file
+	git add file
+	git commit -m"Add a file" >/dev/null
+
+	printf "$b" >file
+	git commit -am"Update a file" >/dev/null
+
+	git show >commit.raw
+
+	if test "$#" = 3
+	then
+		# remove last newline
+		head -n11 commit.raw | test_chomp_eof >commit.exp
+		printf "$3" >>commit.exp
+	else
+		cat commit.raw >commit.exp
+	fi
+
+	<commit.raw "$DIFF_HIGHLIGHT" >commit.act &&
+	test -s commit.act &&
+	test_cmp commit.exp commit.act
+}
+
+test_chomp_eof() {
+	perl -pe 'chomp if eof'
+}
-- 
2.9.0

