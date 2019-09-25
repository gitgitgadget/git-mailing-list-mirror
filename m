Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42F31F463
	for <e@80x24.org>; Wed, 25 Sep 2019 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbfIYK1J (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 06:27:09 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45677 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389749AbfIYK1I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 06:27:08 -0400
Received: by mail-pg1-f176.google.com with SMTP id 4so2935010pgm.12
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ucONfj4AdB/ejkTR+TtMFfSYEJn2gM2Il8jG9MsHE/s=;
        b=f6fBiqtMtW6sFXHFDnQ3nYLk+tkghdo/sVyqkdtPQ+qz9B3liYjYECu5wZvdU6Jf8h
         0yH9ipLerjZFGihIKYQmKoWGi5KkCeNzrFKCFrQyQ+5DwOtTbPrqZPZu7Udt1Y675mvU
         y0X6AzFAPXWUWL3R4JLeW0Qw4CjwO0eZU/KjePDf4dTJmVOzW7ljZ8mHcZdyq431lSZh
         9F+AgSy2oB8l1CO93tbrdHTxI5lrVf9mk1ft0T13Aw0MTfIDIw1kZjrXQm2aLPuWwxLI
         un3npLayxkec6GPYnYftDo4fFyuKmEXtcbSr0PDRPpNu/FG5a2BvDj5XvYJGJ7Fz9WAS
         GYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ucONfj4AdB/ejkTR+TtMFfSYEJn2gM2Il8jG9MsHE/s=;
        b=gcEuR2Da4VfaS64r4CrZ1DL16ZAGIaf/orj4p3/kEZd012YdlCbqxE6Ze2vM0BBwi0
         LYpDFRwMqQiHfTJVzxZ9QIA5pKNeqwRx4i+NMNNlCOFoSTnG0fTURILozGrJZe/lvwXL
         f3Y8TISezGg7jdEW3In04bnbxiC66RnxamTr2MM+sTx1X54Xi/C+zb6iyM4wvXBfVKRu
         HQeSq3DimRjGf8y5/Apg9MPced6Y/NcPFNkTW5+1m5E4la2ycKasa1QNej4KDiQu8n47
         cr5zddsWI6vYIgrEY+ALkuUzFyuzVrKWPJc3kGVXyLDTuB6VCtVcz0rkLGqtjl+APgVE
         nyyw==
X-Gm-Message-State: APjAAAX5cbzuPDmcIb1xiy60OWHvuRzXetpGlmva+odIPeigMMpi6w3Q
        g7WO/E4YCF7Gr9ZwMjUULrmXl1nz
X-Google-Smtp-Source: APXvYqzteHsJCawstkxElzknS00jbQ1QLLwTc0bmi9GSTCH0/lNplPbYdWbIcbCrWvjhoDiAW7WGJQ==
X-Received: by 2002:a62:1603:: with SMTP id 3mr9054983pfw.0.1569407227503;
        Wed, 25 Sep 2019 03:27:07 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id 18sm5527321pfp.100.2019.09.25.03.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:27:06 -0700 (PDT)
Date:   Wed, 25 Sep 2019 03:27:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [BUG/PATCH 3/5] t4214: generate expect in their own test cases
Message-ID: <c09f761185859998d33c4944fe3a7317e3a8c987.1569407150.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569407150.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the expect files of the test case were being generated in the
setup method. However, it would make more sense to generate these files
within the test cases that actually use them so that it's obvious to
future readers where the expected values are coming from.

Move the generation of the expect files in their own respective test
cases.

While we're at it, we want to establish a pattern in this test suite
that, firstly, a non-colored test case is given then, immediately after,
the colored version is given.

Switch test cases "log --graph with tricky octopus merge, no color" and
"log --graph with tricky octopus merge with colors" so that the "no
color" version appears first.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4214-log-graph-octopus.sh | 42 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index f6e22ec825..16776e347c 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -5,6 +5,20 @@ test_description='git log --graph of skewed left octopus merge.'
 . ./test-lib.sh
 
 test_expect_success 'set up merge history' '
+	test_commit initial &&
+	for i in 1 2 3 4 ; do
+		git checkout master -b $i || return $?
+		# Make tag name different from branch name, to avoid
+		# ambiguity error when calling checkout.
+		test_commit $i $i $i tag$i || return $?
+	done &&
+	git checkout 1 -b merge &&
+	test_merge octopus-merge 1 2 3 4 &&
+	git checkout 1 -b L &&
+	test_commit left
+'
+
+test_expect_success 'log --graph with tricky octopus merge, no color' '
 	cat >expect.uncolored <<-\EOF &&
 	* left
 	| *---.   octopus-merge
@@ -19,6 +33,13 @@ test_expect_success 'set up merge history' '
 	|/
 	* initial
 	EOF
+	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
+	sed "s/ *\$//" actual.raw >actual &&
+	test_cmp expect.uncolored actual
+'
+
+test_expect_success 'log --graph with tricky octopus merge with colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	cat >expect.colors <<-\EOF &&
 	* left
 	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
@@ -33,32 +54,11 @@ test_expect_success 'set up merge history' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	test_commit initial &&
-	for i in 1 2 3 4 ; do
-		git checkout master -b $i || return $?
-		# Make tag name different from branch name, to avoid
-		# ambiguity error when calling checkout.
-		test_commit $i $i $i tag$i || return $?
-	done &&
-	git checkout 1 -b merge &&
-	test_merge octopus-merge 1 2 3 4 &&
-	git checkout 1 -b L &&
-	test_commit left
-'
-
-test_expect_success 'log --graph with tricky octopus merge with colors' '
-	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
 	git log --color=always --graph --date-order --pretty=tformat:%s --all >actual.colors.raw &&
 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
 	test_cmp expect.colors actual.colors
 '
 
-test_expect_success 'log --graph with tricky octopus merge, no color' '
-	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
-'
-
 # Repeat the previous two tests with "normal" octopus merge (i.e.,
 # without the first parent skewing to the "left" branch column).
 
-- 
2.23.0.248.g3a9dd8fb08

