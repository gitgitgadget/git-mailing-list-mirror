Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215361F404
	for <e@80x24.org>; Thu,  6 Sep 2018 02:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeIFHVt (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 03:21:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54533 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFHVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 03:21:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so9834494wmb.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 19:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYrvDJdOVAeZyyJFT26Mcu/ckzsskqhiWFlSvv6/xvo=;
        b=X+tGJoWNQb5GldZawSnAHSXkFMApT9sKOJdIfrdFzyyUctzVCmUeHp1pEQgqmemdOD
         wJ08CpA8Md41OIK2v4FLWarALIBOKXOUHRp5xC0bjG9j4WUbymbuZ4C6I5DmEpjM8XS8
         8Lyw+X1QkMZm1dx3wD1dMceOK5kWqusi4AjVzf3ryhkQMn+fthX7K+jZ206R3s7o6RX1
         LJizwAIGic1SxjI53Pe8wX/ogsysN3XiwrMBsqxMg7WgbOGj/OhXpHJUkvsClCdhp3sw
         DsyyUKIHDYRo5lHt0yLaTUuuQjrJQaVOeP8bRBuoGpuzrY/Zr2MB8+LkJavx53y/F2rd
         vv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYrvDJdOVAeZyyJFT26Mcu/ckzsskqhiWFlSvv6/xvo=;
        b=ZbzSFtOYVnwM3mMdTv5Lr20Vh13qq1YKnVNzX+vJLb9LMOX7F7axqRs8y5opZRktMz
         ibtxFRwMIaUeEroerGsXw9fTNKz5ExwWSpiKaCNQezwxhy3BYOPRAuLuSrbIdj3O+6ZS
         rafmRyqBmXXQOgDT5uHpBFNIy+xlvozMQGBUhkm9jvU8xiGXVLEI+R2PGdp6QWJHrAfa
         uoaW4x1m7NQpjVfzeDz3jvKFd6i6j+AS+OKWd97n5juYmrPMgZd10K+9EGNz//VDJl6J
         GyJE368EclW2LyGR8eCIZJwZn5NGgtxXQxXRbSYZqdMRtJqaCBJbJn8WGVsZ0TT3thxG
         igZg==
X-Gm-Message-State: APzg51COlZsIi5nEwR96E03m7pX/5OvVe7yX3qBD8cUiZ6rOr3KdGC2z
        /yxFXQI8li10+KrVYtNrUghe0GPINAA=
X-Google-Smtp-Source: ANB0VdaJYYdpjPpM+JqjKeC6TfcyBY3WdsU52qu4yES3zB8c9i2oQnC60HUlrfVxrX9RPtjUY+8P9A==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr619059wma.85.1536202120960;
        Wed, 05 Sep 2018 19:48:40 -0700 (PDT)
Received: from localhost.localdomain (x4db1b35b.dyn.telefonica.de. [77.177.179.91])
        by smtp.gmail.com with ESMTPSA id y10-v6sm3979999wrl.87.2018.09.05.19.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 19:48:40 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 4/5] t1700-split-index: date back files to avoid racy situations
Date:   Thu,  6 Sep 2018 04:48:09 +0200
Message-Id: <20180906024810.8074-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.188.g56c5ee2db1
In-Reply-To: <20180906024810.8074-1-szeder.dev@gmail.com>
References: <20180906024810.8074-1-szeder.dev@gmail.com>
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
index be22398a85..e7beef1e09 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -8,6 +8,13 @@ test_description='split index mode tests'
 sane_unset GIT_TEST_SPLIT_INDEX
 sane_unset GIT_FSMONITOR_TEST
 
+# Create a file named as $1 with content read from stdin.
+# Set the file's mtime to a few seconds in the past to avoid racy situations.
+create_file () {
+	cat >"$1" &&
+	test-tool chmtime =-5 "$1"
+}
+
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
@@ -31,7 +38,7 @@ test_expect_success 'enable split index' '
 '
 
 test_expect_success 'add one file' '
-	: >one &&
+	create_file one &&
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -83,7 +90,7 @@ test_expect_success 'enable split index again, "one" now belongs to base index"'
 '
 
 test_expect_success 'modify original file, base index untouched' '
-	echo modified >one &&
+	echo modified |create_file one &&
 	git update-index one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -102,7 +109,7 @@ test_expect_success 'modify original file, base index untouched' '
 '
 
 test_expect_success 'add another file, which stays index' '
-	: >two &&
+	create_file two &&
 	git update-index --add two &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -155,7 +162,7 @@ test_expect_success 'remove file in base index' '
 '
 
 test_expect_success 'add original file back' '
-	: >one &&
+	create_file one &&
 	git update-index --add one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -174,7 +181,7 @@ test_expect_success 'add original file back' '
 '
 
 test_expect_success 'add new file' '
-	: >two &&
+	create_file two &&
 	git update-index --add two &&
 	git ls-files --stage >actual &&
 	cat >expect <<-EOF &&
@@ -218,7 +225,7 @@ test_expect_success 'rev-parse --shared-index-path' '
 
 test_expect_success 'set core.splitIndex config variable to true' '
 	git config core.splitIndex true &&
-	: >three &&
+	create_file three &&
 	git update-index --add three &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
@@ -253,9 +260,9 @@ test_expect_success 'set core.splitIndex config variable to false' '
 	test_cmp expect actual
 '
 
-test_expect_success 'set core.splitIndex config variable to true' '
+test_expect_success 'set core.splitIndex config variable back to true' '
 	git config core.splitIndex true &&
-	: >three &&
+	create_file three &&
 	git update-index --add three &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -265,7 +272,7 @@ test_expect_success 'set core.splitIndex config variable to true' '
 	deletions:
 	EOF
 	test_cmp expect actual &&
-	: >four &&
+	create_file four &&
 	git update-index --add four &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
@@ -279,7 +286,7 @@ test_expect_success 'set core.splitIndex config variable to true' '
 
 test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 	git config --unset splitIndex.maxPercentChange &&
-	: >five &&
+	create_file five &&
 	git update-index --add five &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -289,7 +296,7 @@ test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 	deletions:
 	EOF
 	test_cmp expect actual &&
-	: >six &&
+	create_file six &&
 	git update-index --add six &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
@@ -303,7 +310,7 @@ test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 
 test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 	git config splitIndex.maxPercentChange 0 &&
-	: >seven &&
+	create_file seven &&
 	git update-index --add seven &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -313,7 +320,7 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 	deletions:
 	EOF
 	test_cmp expect actual &&
-	: >eight &&
+	create_file eight &&
 	git update-index --add eight &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -326,17 +333,17 @@ test_expect_success 'check splitIndex.maxPercentChange set to 0' '
 '
 
 test_expect_success 'shared index files expire after 2 weeks by default' '
-	: >ten &&
+	create_file ten &&
 	git update-index --add ten &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_under_2_weeks_ago=$((5-14*86400)) &&
 	test-tool chmtime =$just_under_2_weeks_ago .git/sharedindex.* &&
-	: >eleven &&
+	create_file eleven &&
 	git update-index --add eleven &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_2_weeks_ago=$((-1-14*86400)) &&
 	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
-	: >twelve &&
+	create_file twelve &&
 	git update-index --add twelve &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
@@ -344,12 +351,12 @@ test_expect_success 'shared index files expire after 2 weeks by default' '
 test_expect_success 'check splitIndex.sharedIndexExpire set to 16 days' '
 	git config splitIndex.sharedIndexExpire "16.days.ago" &&
 	test-tool chmtime =$just_over_2_weeks_ago .git/sharedindex.* &&
-	: >thirteen &&
+	create_file thirteen &&
 	git update-index --add thirteen &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	just_over_16_days_ago=$((-1-16*86400)) &&
 	test-tool chmtime =$just_over_16_days_ago .git/sharedindex.* &&
-	: >fourteen &&
+	create_file fourteen &&
 	git update-index --add fourteen &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
@@ -358,13 +365,13 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	git config splitIndex.sharedIndexExpire never &&
 	just_10_years_ago=$((-365*10*86400)) &&
 	test-tool chmtime =$just_10_years_ago .git/sharedindex.* &&
-	: >fifteen &&
+	create_file fifteen &&
 	git update-index --add fifteen &&
 	test $(ls .git/sharedindex.* | wc -l) -gt 2 &&
 	git config splitIndex.sharedIndexExpire now &&
 	just_1_second_ago=-1 &&
 	test-tool chmtime =$just_1_second_ago .git/sharedindex.* &&
-	: >sixteen &&
+	create_file sixteen &&
 	git update-index --add sixteen &&
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
@@ -379,7 +386,7 @@ do
 		# Create one new shared index file
 		git config core.sharedrepository "$mode" &&
 		git config core.splitIndex true &&
-		: >one &&
+		create_file one &&
 		git update-index --add one &&
 		echo "$modebits" >expect &&
 		test_modebits .git/index >actual &&
-- 
2.19.0.rc0.188.g56c5ee2db1

