Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931171F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934538AbeFYOgC (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:36:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41901 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934437AbeFYOfD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:03 -0400
Received: by mail-qk0-f193.google.com with SMTP id d22-v6so1931193qkc.8
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jf3CP3LbaHCsR4PJ3kPVCbahRo/5azMJQmW+fr8qQfM=;
        b=pPhaf57pXQPQX23xqsEwNHVZf7sFkhMmPHyW9cmHNmmBtVGNnKqJkXc2W2svEhO6j4
         20Dh0GTZseQBk25UNaHGoehpXhr5tcO222bEoZf0C6sFTdVb37yrvcjsA/5C3sl+5Bfy
         KpiZBDRi79o8xw94lnx34Zqk5BOL38TwDBNhP+GYXbs2me3P7TV76PN6Sd9TvmeBayUa
         qmdgULJRxOgekFOI94xCUxll1iwycqIYBD3B89FhNkHq/xGhhqu//n5Wra1DF1y2ua0c
         Fx0tBTqLRXY0RgUnQQxYwof9T0uP66JEIiXBPe+ad4RkE44tif4+0KMmAZ3maSH08RWb
         E6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jf3CP3LbaHCsR4PJ3kPVCbahRo/5azMJQmW+fr8qQfM=;
        b=UQOU5Yl91grvaE7m2yM95mheJoi4hin49mOs6jdO+yPMJGOcw4efCWwXX8kEKyKtbG
         O2Bfu3UFCcZjYmmicKrKFW5NS9GOe7e7MMiQdLMLKbjSqsRE98WOIIhBcRIvmGc9lcR8
         TIqntmfNgY8XsgabsJxA0a57t+lfVZkyBThFgrTd7O0F7O4vlKpu7uCoe1x6EIw/Kf+0
         WMSxXDjlRddnlCaqlJn96yk9X13lso5LQNEPNHyEW1IIVVkaNrZthlcvKe9LqrLx/Cj7
         InqeOeVsMffIux0TrHkVs2a8xh+k91eEAEYy5EzcAG8gNDmHpD/8f//P81gFut/2pj9Y
         457g==
X-Gm-Message-State: APt69E30CZHyIm/zlR5dmfy6F4WKZN0Mx20lXaiXPoQFD6tGq/egPxhV
        K/JKvALXJDbAgJ8X+FRH2Lc1be7j
X-Google-Smtp-Source: ADUXVKL3/ybcydo4NlcsHHl/sqAf2oI52smSTQU1RPQ7XG0UA8iP9+sXdRvcJZafbz0Dix+OT99uCw==
X-Received: by 2002:a37:1328:: with SMTP id d40-v6mr10624724qkh.198.1529937302208;
        Mon, 25 Jun 2018 07:35:02 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:01 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 07/24] multi-pack-index: expand test data
Date:   Mon, 25 Jun 2018 10:34:17 -0400
Message-Id: <20180625143434.89044-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we build the multi-pack-index file format, we want to test the format
on real repoasitories. Add tests to t5319-multi-pack-index.sh that
create repository data including multiple packfiles with both version 1
and version 2 formats.

The current 'git multi-pack-index write' command will always write the
same file with no "real" data. This will be expanded in future commits,
along with the test expectations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 99 +++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 0372704c96..d533fd0dbc 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -13,9 +13,108 @@ midx_read_expect() {
 }
 
 test_expect_success 'write midx with no packs' '
+	test_when_finished rm pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
 	test_path_is_file pack/multi-pack-index &&
 	midx_read_expect
 '
 
+test_expect_success 'create objects' '
+	for i in `test_seq 1 5`
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 > wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
+		echo $iii >file_$iii &&
+		test-tool genrandom "$iii" 8192 >>file_$iii &&
+		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+		i=$(expr $i + 1) || return 1
+	done &&
+	{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
+	git update-index --add file_101 &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree </dev/null) && {
+	echo $tree &&
+	git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list &&
+	git update-ref HEAD $commit
+'
+
+test_expect_success 'write midx with one v1 pack' '
+	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
+	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'write midx with one v2 pack' '
+	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'Add more objects' '
+	for i in `test_seq 6 5`
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 > wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
+		echo $iii >file_$iii &&
+		test-tool genrandom "$iii" 8192 >>file_$iii &&
+		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+		i=$(expr $i + 1) || return 1
+	done &&
+	{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
+	git update-index --add file_101 &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree -p HEAD</dev/null) && {
+	echo $tree &&
+	git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list2 &&
+	git update-ref HEAD $commit
+'
+
+test_expect_success 'write midx with two packs' '
+	git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
+test_expect_success 'Add more packs' '
+	for j in `test_seq 1 10`
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 > wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
+		echo $iii >file_$iii &&
+		test-tool genrandom "$iii" 8192 >>file_$iii &&
+		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+		{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
+		git update-index --add file_101 &&
+		tree=$(git write-tree) &&
+		commit=$(git commit-tree $tree -p HEAD</dev/null) && {
+		echo $tree &&
+		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+		} >obj-list &&
+		git update-ref HEAD $commit &&
+		git pack-objects --index-version=2 test-pack <obj-list &&
+		i=$(expr $i + 1) || return 1 &&
+		j=$(expr $j + 1) || return 1
+	done
+'
+
+test_expect_success 'write midx with twelve packs' '
+	git multi-pack-index --object-dir=. write &&
+	midx_read_expect
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

