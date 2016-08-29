Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7BE1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbcH2ReG (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:34:06 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33290 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbcH2ReF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:34:05 -0400
Received: by mail-pa0-f68.google.com with SMTP id vy10so9267664pac.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WGPF/N2a9xNitKssuGGU83uF9zaturjmPK+hgdkeU+E=;
        b=wvtk88K/bnHD/DXpHdnX03qZUEVJ0hoOKgEyQteLjQZKACq4CikKA2BvjVSPwSEJhp
         NxGOAE0bGuQVs6YjGbq1G1YZYrM/dJynq07xW9i1qr/MMsRvHNZRPY9OaQt5Re34UhGO
         UUpuaHk/82wHoyzrFX/P1c2lpnmtS1hfQaJXk3ywN48nDVDO8dWdXBDKB4SZoLL0kfOi
         Dq5+zpBGfI5AvS/9TAYseyDR6ewc2081O6qLcSZPUcToeB90pG7Pn8+wufYP+7+NbwSJ
         KPu0cZrZdlbQYPAHcNY7S0w3z+c2wYA5xrttCjDn+gclHtdEDvZtl5Hv/q1y8wyp5zL+
         u/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WGPF/N2a9xNitKssuGGU83uF9zaturjmPK+hgdkeU+E=;
        b=bkzzf2BJzC16JGJTN9GXaI7uvQatdUk0EarcqUmR1bAEogXdH8SoskEU8eIqocutd2
         cuFCA5RjijAMD9BkfsY8Cb+e75yY06OI/nMcDt1OTLR7lcaPKxQoyJKuqnPYOQvAzOQU
         76i1qlPLg/gy9oKVQyJ1ipsV/TJ6d7g8W1Kbe3ZNT6qadex0j4/eaS1rB+jz536DevoY
         7Pv/6OqXsMLpNYksEC8Rx/vpLzBav0f/Ln+87o7xGA5uYh16dDehQpd9eStTW6MrxOgn
         WHo8KwZ/BiWSSmTZDsqYcKcjI7flZ2bczdACZ8urEpgRV47iD9oPgZHxJDKogUTLFbDw
         ctqQ==
X-Gm-Message-State: AE9vXwOZu18PrJvRoT87n9BgLH6RAKEsgdjLyPIIpggGyaXJh4NTQ1XFSMyT8EVwnomO1g==
X-Received: by 10.66.148.202 with SMTP id tu10mr34446433pab.52.1472492044164;
        Mon, 29 Aug 2016 10:34:04 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id h125sm50721234pfg.54.2016.08.29.10.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 10:34:02 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v4 1/3] diff-highlight: add some tests.
Date:   Mon, 29 Aug 2016 10:33:45 -0700
Message-Id: <20160829173347.454-2-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160829173347.454-1-henderson.bj@gmail.com>
References: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
 <20160829173347.454-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.9.3

