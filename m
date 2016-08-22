Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD991F859
	for <e@80x24.org>; Mon, 22 Aug 2016 16:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754022AbcHVQNJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 12:13:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33799 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbcHVQLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 12:11:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id g202so6610370pfb.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROCSfu9B7AVy5miJWKXzNWuLal4k9OWod8EVECbbtdE=;
        b=NkFnEohSrbEoQa6QR522ELZhBA8nUHYr/wFXjnz02KMjR1KNUk/ba3qsICV3EblnW4
         hn2nVSzSyCxdvEcGb8Oj0Ch0v0AEUKWsmX+T0sIViZmCm8v3r/KbdIV5UGKXC7n9DqRS
         zphFXqh3ZC0NOJGoQDhqNmSe65xO0PdYqG5gZvP2d4n2yz5CkTW1GHuENlWaOW8295Fu
         s43C8G0Hq1kCC/P3gK6SK3FF3GFqJFWGX9qbd+Xjp/DWqEepd0M3S8yWgge4sCxf7bjK
         sJu9ooflnMHnuJa5a3vkAG5wJjLcWIeqbwZbtY67/7+Z9To1Z/PTFzWySYPJiDsURyRB
         3Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROCSfu9B7AVy5miJWKXzNWuLal4k9OWod8EVECbbtdE=;
        b=lzjSgDgsCSzy724F1RE7tOLZ/41cXb03GmbnGrFpKBPy0brN79RDrH7mQo+RthLg77
         m6B0KGPK0vwre4i2glCLtifFl3TUJvAbjKfuuA/NHXfmtpJfNNah9YvNZsbCr6gwpQpS
         qWIhCxELLlxX4rOvb9fdQzcJTNrxjo4yTjEX9nGewUOXFuVDDjwB0rojeAsl2TMBAkW0
         8bj2wrbiq9Z/3PRI1CLK4XxLaI6rhgCOu3d5ZvCnCcTeBNzgF+AbhxJn0A/C9P65uvXo
         +RN3TzWz9Jx7xOKw10qBvi+CJxH9uxDhwfjf0BXbOBmtVgatdC35y0Z+dGOGq5Jr6LSq
         BdNw==
X-Gm-Message-State: AEkoouv7e0BTI2m+4WqaeDUmiuD/XvIHEfxYbZBAm9lo8pwfauEwFs8/P3bbbK2RcrjifQ==
X-Received: by 10.98.79.27 with SMTP id d27mr44143184pfb.127.1471881356382;
        Mon, 22 Aug 2016 08:55:56 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id c82sm28224869pfb.72.2016.08.22.08.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Aug 2016 08:55:55 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH] diff-highlight: add some tests.
Date:   Mon, 22 Aug 2016 08:55:39 -0700
Message-Id: <20160822155539.25350-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <xmqqeg5kz8zq.fsf@gitster.mtv.corp.google.com>
References: <xmqqeg5kz8zq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff, I love your idea. how's this looking?

Junio, I wasn't meaning to be stubborn, although definitely a fault of mine. I
understand a lot better now, thanks for your patience.

---
 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/t/Makefile                |  22 +++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 163 +++++++++++++++++++++++
 3 files changed, 190 insertions(+)
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
index 0000000..7c303f7
--- /dev/null
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+
+test_description='Test diff-highlight'
+
+CURR_DIR=$(pwd)
+TEST_OUTPUT_DIRECTORY=$(pwd)
+TEST_DIRECTORY="$CURR_DIR"/../../../t
+DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight
+
+CW="$(printf "\033[7m")"	# white
+CR="$(printf "\033[27m")"	# reset
+
+. "$TEST_DIRECTORY"/test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping diff-highlight tests; perl not available'
+	test_done
+fi
+
+# dh_test is a test helper function which takes 3 file names as parameters. The
+# first 2 files are used to generate diff and commit output, which is then
+# piped through diff-highlight. The 3rd file should contain the expected output
+# of diff-highlight (minus the diff/commit header, ie. everything after and
+# including the first @@ line).
+dh_test () {
+	a="$1" b="$2" &&
+
+	cat >patch.exp &&
+
+	{
+		cat "$a" >file &&
+		git add file &&
+		git commit -m "Add a file" &&
+
+		cat "$b" >file &&
+		git diff file >diff.raw &&
+		git commit -am "Update a file" &&
+		git show >commit.raw
+	} >/dev/null &&
+
+	"$DIFF_HIGHLIGHT" <diff.raw | test_strip_patch_header >diff.act &&
+	"$DIFF_HIGHLIGHT" <commit.raw | test_strip_patch_header >commit.act &&
+	test_cmp patch.exp diff.act &&
+	test_cmp patch.exp commit.act
+}
+
+test_strip_patch_header () {
+	sed -n '/^@@/,$p' $*
+}
+
+test_expect_success 'diff-highlight highlights the beginning of a line' '
+	cat >a <<-\EOF &&
+		aaa
+		bbb
+		ccc
+	EOF
+
+	cat >b <<-\EOF &&
+		aaa
+		0bb
+		ccc
+	EOF
+
+	dh_test a b <<-EOF
+		@@ -1,3 +1,3 @@
+		 aaa
+		-${CW}b${CR}bb
+		+${CW}0${CR}bb
+		 ccc
+	EOF
+'
+
+test_expect_success 'diff-highlight highlights the end of a line' '
+	cat >a <<-\EOF &&
+		aaa
+		bbb
+		ccc
+	EOF
+
+	cat >b <<-\EOF &&
+		aaa
+		bb0
+		ccc
+	EOF
+
+	dh_test a b <<-EOF
+		@@ -1,3 +1,3 @@
+		 aaa
+		-bb${CW}b${CR}
+		+bb${CW}0${CR}
+		 ccc
+	EOF
+'
+
+test_expect_success 'diff-highlight highlights the middle of a line' '
+	cat >a <<-\EOF &&
+		aaa
+		bbb
+		ccc
+	EOF
+
+	cat >b <<-\EOF &&
+		aaa
+		b0b
+		ccc
+	EOF
+
+	dh_test a b <<-EOF
+		@@ -1,3 +1,3 @@
+		 aaa
+		-b${CW}b${CR}b
+		+b${CW}0${CR}b
+		 ccc
+	EOF
+'
+
+test_expect_success 'diff-highlight does not highlight whole line' '
+	cat >a <<-\EOF &&
+		aaa
+		bbb
+		ccc
+	EOF
+
+	cat >b <<-\EOF &&
+		aaa
+		000
+		ccc
+	EOF
+
+	dh_test a b <<-EOF
+		@@ -1,3 +1,3 @@
+		 aaa
+		-bbb
+		+000
+		 ccc
+	EOF
+'
+
+test_expect_failure 'diff-highlight highlights mismatched hunk size' '
+	cat >a <<-\EOF &&
+		aaa
+		bbb
+	EOF
+
+	cat >b <<-\EOF &&
+		aaa
+		b0b
+		ccc
+	EOF
+
+	dh_test a b <<-EOF
+		@@ -1,3 +1,3 @@
+		 aaa
+		-b${CW}b${CR}b
+		+b${CW}0${CR}b
+		+ccc
+	EOF
+'
+
+# TODO add multi-byte test
+
+test_done
-- 
2.9.0

