Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE701F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeI1Wt5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:49:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52528 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Wt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:49:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so2506105wmw.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKsyACZO6pkucPD2O8QsWo3No+bf/ZiGnDFvA0S1erc=;
        b=J2PQ+F+/bD8r9I6VimH2OOB4IjrPCUGKpWv1AXQ1CUYObibi5gDSekAd8mVlto1HXB
         ZKLOtPDI4af1bKs5Mlie43KoiK/tEHha4jYPt54sLhkodVJTXuLlku8jIBsj4W2mjP6j
         C7dcgUZsgA2MJTdSikDB47ehOZD8OzpDnw8oqOrj5aVVedPLsth1N6ahTVmkbz7KFRaQ
         qD9P5C3Igni+PIYWK8xrJvDy5uK822mqrV5GzKt7abQUlz41c2on+vhwe1OZ6PnezQu2
         nIzOKqkfgEA2njKpRHC3mNHaagnhx1M58n1Vc8a2EENzQZBB7N/yJWc5F3cFcxuCQxPv
         huXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKsyACZO6pkucPD2O8QsWo3No+bf/ZiGnDFvA0S1erc=;
        b=eaL9QjysWNB0H/3zWuJ7hILabPNUYpo0GXcSwJgkbOLcMolB5/VHC5qJ96om/9hkVJ
         ewYXUbLa5Uuovt6SabzXKyAeMbeEn7aLvHy6l23X4xeVlNOdBWMLS5MfHKn+SNDy3JPt
         iq0G17QacaZj6bzZ51ftPGFsZAZoIg/RPJXjvxuM/TT261bsrl/7s1ZvwZZ1t7v7vgai
         gw0pcg+QM/l63vPetkUygRoI/b6Ize1W0NX/Ccv39LWfrgccUXKMi0jKWnCOCHpB3O8a
         eyJaSUohSPi7A31YQvV5ewBISMAr0iYzbJqepsxqdzJiuh/nrvjtJPJITXk7Hgcod6CK
         nJMA==
X-Gm-Message-State: ABuFfogYuri20zmPS7nyaTYSbQCz1mNTYCYQ2v4GyjYp1L7kKsJYgepF
        dsUWHGMryfdu1DaYwsVzg/I=
X-Google-Smtp-Source: ACcGV63E2HI4sHvzaKW+qsHOKfjcFOY5CZstYJFCJ+GerTl9vPbPLSgeBHN2ZGmi39dymwmUV7GUnA==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr2231129wma.139.1538151923348;
        Fri, 28 Sep 2018 09:25:23 -0700 (PDT)
Received: from localhost.localdomain (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id s24-v6sm1628247wmc.7.2018.09.28.09.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 09:25:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 3/6] t1700-split-index: date back files to avoid racy situations
Date:   Fri, 28 Sep 2018 18:24:56 +0200
Message-Id: <20180928162459.17138-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
In-Reply-To: <20180928162459.17138-1-szeder.dev@gmail.com>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't1700-split-index.sh' checks that the index was split correctly under
various circumstances and that all the different ways to turn the
split index feature on and off work correctly.  To do so, most of its
tests use 'test-tool dump-split-index' to see which files have their
cache entries in the split index.  All these tests assume that all
cache entries are written to the shared index (called "base"
throughout these tests) when a new shared index is created.  This is
an implementation detail: most git commands (basically all except 'git
update-index') don't care or know at all about split index or whether
a cache entry is stored in the split or shared index.

As demonstrated in the previous patch, refreshing a split index is
prone to a variant of the classic racy git issue.  The next patch will
fix this issue, but while doing so it will also slightly change this
behaviour: only cache entries with mtime in the past will be written
only to the newly created shared index, but racily clean cache entries
will be written to the new split index (with smudged stat data).

While this upcoming change won't at all affect any git commands, it
will violate the above mentioned assumption of 't1700's tests.  Since
these tests create or modify files and create or refresh the split
index in rapid succession, there are plenty of racily clean cache
entries to be dealt with, which will then be written to the new split
indexes, and, ultimately, will cause several tests in 't1700' to fail.

Let's prepare 't1700-split-index.sh' for this upcoming change and
modify its tests to avoid racily clean files by backdating the mtime
of any file modifications (and since a lot of tests create or modify
files, encapsulate it into a helper function).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1700-split-index.sh | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 822257ff7d..f053bf83eb 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -11,6 +11,13 @@ sane_unset GIT_TEST_SPLIT_INDEX
 # with those checks, so disable it in this test script.
 sane_unset GIT_FSMONITOR_TEST
 
+# Create a file named as $1 with content read from stdin.
+# Set the file's mtime to a few seconds in the past to avoid racy situations.
+create_non_racy_file () {
+	cat >"$1" &&
+	test-tool chmtime =-5 "$1"
+}
+
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
@@ -34,7 +41,7 @@ test_expect_success 'enable split index' '
 '
 
 test_expect_success 'add one file' '
-	: >one &&
+	create_non_racy_file one &&
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -86,7 +93,7 @@ test_expect_success 'enable split index again, "one" now belongs to base index"'
 '
 
 test_expect_success 'modify original file, base index untouched' '
-	echo modified >one &&
+	echo modified | create_non_racy_file one &&
 	git update-index one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -105,7 +112,7 @@ test_expect_success 'modify original file, base index untouched' '
 '
 
 test_expect_success 'add another file, which stays index' '
-	: >two &&
+	create_non_racy_file two &&
 	git update-index --add two &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -158,7 +165,7 @@ test_expect_success 'remove file in base index' '
 '
 
 test_expect_success 'add original file back' '
-	: >one &&
+	create_non_racy_file one &&
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -177,7 +184,7 @@ test_expect_success 'add original file back' '
 '
 
 test_expect_success 'add new file' '
-	: >two &&
+	create_non_racy_file two &&
 	git update-index --add two &&
 	git ls-files --stage >actual &&
 	cat >expect <<-EOF &&
@@ -221,7 +228,7 @@ test_expect_success 'rev-parse --shared-index-path' '
 
 test_expect_success 'set core.splitIndex config variable to true' '
 	git config core.splitIndex true &&
-	: >three &&
+	create_non_racy_file three &&
 	git update-index --add three &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -256,9 +263,9 @@ test_expect_success 'set core.splitIndex config variable to false' '
 	test_cmp expect actual
 '
 
-test_expect_success 'set core.splitIndex config variable to true' '
+test_expect_success 'set core.splitIndex config variable back to true' '
 	git config core.splitIndex true &&
-	: >three &&
+	create_non_racy_file three &&
 	git update-index --add three &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -268,7 +275,7 @@ test_expect_success 'set core.splitIndex config variable to true' '
 	deletions:
 	EOF
 	test_cmp expect actual &&
-	: >four &&
+	create_non_racy_file four &&
 	git update-index --add four &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
@@ -282,7 +289,7 @@ test_expect_success 'set core.splitIndex config variable to true' '
 
 test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 	git config --unset splitIndex.maxPercentChange &&
-	: >five &&
+	create_non_racy_file five &&
 	git update-index --add five &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -292,7 +299,7 @@ test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 	deletions:
 	EOF
 	test_cmp expect actual &&
-	: >six &&
+	create_non_racy_file six &&
 	git update-index --add six &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
@@ -306,7 +313,7 @@ test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 
 test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 	git config splitIndex.maxPercentChange 0 &&
-	: >seven &&
+	create_non_racy_file seven &&
 	git update-index --add seven &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -316,7 +323,7 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 	deletions:
 	EOF
 	test_cmp expect actual &&
-	: >eight &&
+	create_non_racy_file eight &&
 	git update-index --add eight &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -329,17 +336,17 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 '
 
 test_expect_success 'shared index files expire after 2 weeks by default' '
-	: >ten &&
+	create_non_racy_file ten &&
 	git update-index --add ten &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_under_2_weeks_ago=$((5-14*86400)) &&
 	test-tool chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
-	: >eleven &&
+	create_non_racy_file eleven &&
 	git update-index --add eleven &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_2_weeks_ago=$((-1-14*86400)) &&
 	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
-	: >twelve &&
+	create_non_racy_file twelve &&
 	git update-index --add twelve &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
@@ -347,12 +354,12 @@ test_expect_success 'shared index files expire after 2 weeks by default' '
 test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
 	git config splitIndex.sharedIndexExpire "16.days.ago" &&
 	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
-	: >thirteen &&
+	create_non_racy_file thirteen &&
 	git update-index --add thirteen &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_16_days_ago=$((-1-16*86400)) &&
 	test-tool chmtime =$just_over_16_days_ago .git/sharedindex.* &&
-	: >fourteen &&
+	create_non_racy_file fourteen &&
 	git update-index --add fourteen &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
@@ -361,13 +368,13 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	git config splitIndex.sharedIndexExpire never &&
 	just_10_years_ago=$((-365*10*86400)) &&
 	test-tool chmtime =$just_10_years_ago .git/sharedindex.* &&
-	: >fifteen &&
+	create_non_racy_file fifteen &&
 	git update-index --add fifteen &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	git config splitIndex.sharedIndexExpire now &&
 	just_1_second_ago=-1 &&
 	test-tool chmtime =$just_1_second_ago .git/sharedindex.* &&
-	: >sixteen &&
+	create_non_racy_file sixteen &&
 	git update-index --add sixteen &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
@@ -382,7 +389,7 @@ do
 		# Create one new shared index file
 		git config core.sharedrepository "$mode" &&
 		git config core.splitIndex true &&
-		: >one &&
+		create_non_racy_file one &&
 		git update-index --add one &&
 		echo "$modebits" >expect &&
 		test_modebits .git/index >actual &&
-- 
2.19.0.361.gafc87ffe72

