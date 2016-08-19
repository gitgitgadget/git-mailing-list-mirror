Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D585E2018E
	for <e@80x24.org>; Fri, 19 Aug 2016 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbcHSRIu (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 13:08:50 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36393 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755423AbcHSRIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 13:08:48 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so3684569pab.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=R5fEVKpNWeXmiYpmVUuJS5xroffrVZh671chikQMNLY=;
        b=PmgzzAQTiaw2vSFdrxgRkayAkvoc8jhjQRMYdSVTFpG8/+jcr5jNwwJl3kzmC8iptI
         gpatZWp7Yr3ehld+mvFrjFrCKUwZTCT2jB1Ir04o4ep5g9Pvv0rAuaFtVqzUl3zM2jYv
         /PlvuQe4n95FI5tIpFiQXVkWFbG/qXlz43PDd5MSxn7a2TwPwtXY1GpbcXxcMUT5+a4M
         69bJ+ot5Uw0yGvmGZOelHUQeoH5T2uSDNK1/Gu6pVPqaeHYh9f4bWe5ZUBRhTS2W9GyY
         E9PPhndgSW5d8BurtLCLvd6TTCtCni0xnynKXIog7j5RYV+F7kxbeZkFO48o8g7KvhVh
         9HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=R5fEVKpNWeXmiYpmVUuJS5xroffrVZh671chikQMNLY=;
        b=hGoMuTY1bBIKKoyoTO/HVJjIDAQ7nUdJaGbu1H5ek8bvJ5XzW/jP+MbNSzu9whC7d7
         kMsmz88689tzp2+xT8StSIC735ritjiagUh+0gErZaDZa3RLxCBYfHkcj6FhW339SA+W
         Bq3JjbSVif266JZ8MUG2M615QOXgajaPNsOVfnxR2Qf6iYEQe875yfE8DlVfKGqgHVV6
         RZ02P6iHmsgDZu8p4ZK133utzVsjmHi/n8EvgkL3mt7qe6i36Sd97FFwZM9Xia83FzVh
         Dp7pZ9S7JKR/uJDqR+MptdBvAIqFpFerNyhsNCY0nnlwxc2jC7XTE7DUMjx7iLnl2XDm
         2ydQ==
X-Gm-Message-State: AEkoouuz6+aofvJbMJITn+aEYP5y2g3nTddBqVIvcco1xBkyWhVHbClkpTbg2usPZ4ovng==
X-Received: by 10.66.66.233 with SMTP id i9mr15592664pat.45.1471626505071;
        Fri, 19 Aug 2016 10:08:25 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id m128sm7930676pfm.42.2016.08.19.10.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Aug 2016 10:08:24 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v3 1/3] diff-highlight: add some tests.
Date:   Fri, 19 Aug 2016 10:08:10 -0700
Message-Id: <20160819170812.1676-2-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160819170812.1676-1-henderson.bj@gmail.com>
References: <20160819170812.1676-1-henderson.bj@gmail.com>
In-Reply-To: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
References: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/t/Makefile                |  22 ++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 150 +++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh

diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
new file mode 100644
index 0000000..9018724
--- /dev/null
+++ b/contrib/diff-highlight/Makefile
@@ -0,0 +1,5 @@
+# nothing to build
+all:
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
index 0000000..6b8a461
--- /dev/null
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+
+test_description='Test diff-highlight'
+
+CURR_DIR=$(pwd)
+TEST_OUTPUT_DIRECTORY=$(pwd)
+TEST_DIRECTORY="$CURR_DIR"/../../../t
+DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight
+
+CW="\033[7m"	# white
+CR="\033[27m" # reset
+
+. "$TEST_DIRECTORY"/test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping diff-highlight tests; perl not available'
+	test_done
+fi
+
+# dh_test is a test helper function which takes 1) some file data, 2) some
+# change of the file data, creates a diff and commit of the changes and passes
+# that through diff-highlight. The optional 3rd parameter is the expected
+# output of diff-highlight minus the diff/commit header. Don't include a 3rd
+# parameter if diff-highlight is stupposed to leave the input unmodified.
+dh_test () {
+	dh_diff_test "$@" &&
+	dh_commit_test "$@"
+}
+
+# see dh_test for usage
+dh_diff_test () {
+	a="$1" b="$2"
+
+	printf "$a" >file
+	git add file
+
+	printf "$b" >file
+	git diff file >diff.raw
+
+	if test $# -ge 3
+	then
+		# Add the diff header to the expected file
+		# we remove the trailing newline to make the test a little more readable
+		# this means $3 should start with a newline
+		head -n5 diff.raw | test_chomp_eof >diff.exp
+		printf "$3" >>diff.exp
+	else
+		cat diff.raw >diff.exp
+	fi
+
+	"$DIFF_HIGHLIGHT" <diff.raw >diff.act &&
+	# check that at least one of the files is not empty (any of the above
+	# commands could have failed resulting in an empty file)
+	test -s diff.act &&
+	test_cmp diff.exp diff.act
+}
+
+# see dh_test for usage
+dh_commit_test () {
+	a="$1" b="$2"
+
+	printf "$a" >file
+	git add file
+	git commit -m "Add a file" >/dev/null
+
+	printf "$b" >file
+	git commit -am "Update a file" >/dev/null
+
+	git show >commit.raw
+
+	if test $# -ge 3
+	then
+		# same as dh_diff_test
+		head -n11 commit.raw | test_chomp_eof >commit.exp
+		printf "$3" >>commit.exp
+	else
+		cat commit.raw >commit.exp
+	fi
+
+	"$DIFF_HIGHLIGHT" <commit.raw >commit.act &&
+	# check that at least one of the files is not empty (any of the above
+	# commands could have failed resulting in an empty file)
+	test -s commit.act &&
+	test_cmp commit.exp commit.act
+}
+
+test_chomp_eof () {
+	"$PERL_PATH" -pe 'chomp if eof'
+}
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
+test_expect_failure 'diff-highlight highlights mismatched hunk size' '
+	dh_test \
+		"aaa\nbbb\n" \
+		"aaa\nb0b\nccc\n" \
+"
+ aaa
+-b${CW}b${CR}b
++b${CW}0${CR}b
++ccc
+"
+'
+
+# TODO add multi-byte test
+
+test_done
+
+# vim: set noet
-- 
2.9.0

