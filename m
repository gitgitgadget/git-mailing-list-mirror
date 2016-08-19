Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539B61F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755315AbcHSUTL (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:19:11 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35173 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbcHSUTK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:19:10 -0400
Received: by mail-pa0-f68.google.com with SMTP id cf3so3848556pad.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDqwdy4CQm0fzkJnGQLFtKG4Z1zKdIT0zaLb6EoHNL0=;
        b=UOQoQNaRPXD5dyUhITNuk+htnmidSrkUkd9EuYtShvFRA/jQStdvJyI7/PmQ94qw+1
         yM/YzIyJ56B2lMEJJnwYPZuxAE7licbxPt/yUgXogfSIiqKLgLQwMilDoyTTOk9K+jp3
         3xghqcs1kysqXDyFdJC/7wyZCM9Qb3qejE5n+qbPqbglprb/w92RJ91InxqDMbLbO9zb
         sZZ26O1LmZFFzZsf1hDtVwHnInI3Qus3vdsCuoN/l9a9vQwXBCYhtl9GKdaMOuH1y3mn
         bKcA36Pu0SrBbAsqHOTBWQxFX2bnXqHJC165Dl7mbrdvvMhH8VMeWIOavZVxYx0503/Q
         Eyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDqwdy4CQm0fzkJnGQLFtKG4Z1zKdIT0zaLb6EoHNL0=;
        b=aeqw7fECw9EdIV2Vpwg1OMuHYB7yWm4P40k3H0lF+mFET8pZG84R/GbwZGucgeoEW2
         asMlt3TwgoWFy+b/YytW7XriD3O3FX0mt/ZKZuNUNHOBGK76yv2tepQzqSIlO/w0cjNx
         8XlapDPRAb2YitbuvC7kU+B1o1xEur1MpsnVJcldLPgrltrWSX+DxtuvlTLpYYaocZkf
         g6X6mer/mO4OSgxuS5383/82lu4SZb5tvGkjgJDbPVD6jKZrHv/CjA+TqliY7OzPEOqv
         3RmfAZBWKP44b96HS30U6Rt7Hs0s572w2ySJxaiAf4QxvvNLj51QVCyv5EQjvD5oc7pF
         dl5A==
X-Gm-Message-State: AEkoousvzqUni+jDOAAL4G/b+CSy1As/bLIR30w9Itp6CSELZjprw/COARD9fiKbXqcqag==
X-Received: by 10.66.132.11 with SMTP id oq11mr17055500pab.4.1471637919747;
        Fri, 19 Aug 2016 13:18:39 -0700 (PDT)
Received: from tci.corp.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id n80sm8594622pfi.19.2016.08.19.13.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 13:18:39 -0700 (PDT)
Date:   Fri, 19 Aug 2016 13:18:37 -0700
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com
Subject: [PATCH] diff-highlight: add some tests.
Message-ID: <20160819201837.GA18918@tci.corp.yp.com>
References: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, how does this look?

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/t/Makefile                |  22 ++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 122 +++++++++++++++++++++++
 3 files changed, 149 insertions(+)
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
index 0000000..3c04116
--- /dev/null
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -0,0 +1,122 @@
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
+# that through diff-highlight.
+# The optional 3rd parameter is the expected output of diff-highlight minus the
+# diff/commit header. This parameter is given directly to printf as the format
+# string (in order to properly handle ascii escape codes; CW, CR), so any '%'
+# need to be doubled to protect it.
+# Don't include a 3rd parameter if diff-highlight is supposed to leave the
+# input unmodified.
+# For convienence, the 3rd parameter can begin with a newline which will be
+# stripped.
+dh_test () {
+	a="$1" b="$2" &&
+
+	{
+		printf "$a" >file &&
+		git add file &&
+		git commit -m "Add a file" &&
+
+		printf "$b" >file &&
+		git diff file >diff.raw &&
+		git commit -am "Update a file" &&
+		git show >commit.raw
+	} >/dev/null &&
+
+	if test $# -ge 3
+	then
+		# strip optional beginning newline
+		printf "$3" | perl -pe 's/^\n//'
+	else
+		test_strip_patch_header diff.raw
+	fi >patch.exp &&
+
+	"$DIFF_HIGHLIGHT" <diff.raw | test_strip_patch_header >diff.act &&
+	"$DIFF_HIGHLIGHT" <commit.raw | test_strip_patch_header >commit.act &&
+	test_cmp patch.exp diff.act &&
+	test_cmp patch.exp commit.act
+}
+
+test_strip_patch_header () {
+	sed -e '1,/^@@/d' "$@"
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

