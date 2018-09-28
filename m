Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175C41F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeI1Wtv (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:49:51 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34142 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Wtv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:49:51 -0400
Received: by mail-wr1-f52.google.com with SMTP id z4-v6so5648870wrb.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4hLYmfGM/uZkhkAVWkLpxfoedUVeqp0hMsc7LIAMns=;
        b=A5jzpYTHDhiKOGMMrcn70QbwdUGURJ8gLul+Ek6JqXqLDSMUBHCN/0K4+d09/nSDPM
         b4j8+No7Pda0ULTvG7cKx8DAbyFJYlVVvcvZeRVB5jyqd2DoAeButft9LjQT+jHhUJG8
         lgL2ycWge4zSy0dY0i+gvLX/o/pTnf7hM9TmVMDmC00lTXVGhafJIFIy+JQdeGdiiUpQ
         0RVZCTiX++9wehYxYRAhbrnyYbCVSMY/uvLivgN8cczybS76qgUK5RYGcEQuJ7JrpA6v
         RAVxPBNinuHd4xCw+XMETsvlz7fplbzVavvlkxoTmP2oIPUCc/hoUFcia/lZLujjmVRc
         vvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4hLYmfGM/uZkhkAVWkLpxfoedUVeqp0hMsc7LIAMns=;
        b=OZG9bzUTj7wCmL+1dNzGCOTgDH+4GyEeDaAP9VMSkzx5LkjcjTwZc+c2FnTDDhplli
         gZ27oe/HIdq97yVHv+pDwPggljrSRqwqvxTt0WJ9quaeEGHnzpeLyxk3HcBZtOGgcLuV
         fr4o6nd5OFkYddMmT/0Fcu21jWQASb/OLOrm1EJbzt6MEnOzVKdLhb9BTEeRRzlDDWg2
         IUgFS8Xwstg7WMkUQ1WndhvsrqbpEPK4rxsyGHzOiT/6w1Uaj4vvRwduKAYuFNyum6HC
         2VM2iS8wjPhcRvHRpAc+Qq65qQPOWlaC327DcSs+i9iJXeGenwe771oO7CSfIcwJb2Om
         C+vQ==
X-Gm-Message-State: ABuFfogoX9JfgsEQyhbNCxNViTYiwLANDp0sMFKeKq/jq7bjmLpKw59g
        fv/TOt+arBBAWbuSKsGOpTJ0t4Z3
X-Google-Smtp-Source: ACcGV639wb9zKcDpVhzLeC8XxPqivI+veBJ1N2SvY4fE7k3fbMJAEsBkzH1cDTm4gcoYN2hPXs3GgA==
X-Received: by 2002:adf:f291:: with SMTP id k17-v6mr13210972wro.263.1538151918348;
        Fri, 28 Sep 2018 09:25:18 -0700 (PDT)
Received: from localhost.localdomain (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id s24-v6sm1628247wmc.7.2018.09.28.09.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 09:25:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/6] Fix the racy split index problem
Date:   Fri, 28 Sep 2018 18:24:53 +0200
Message-Id: <20180928162459.17138-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.361.gafc87ffe72
In-Reply-To: <20180927124434.30835-1-szeder.dev@gmail.com>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Third round of fixing occasional test failures when run with
'GIT_TEST_SPLIT_INDEX=yes', with only two rather minor changes since the
previous version; just look at the trivial interdiff below.

SZEDER Gábor (6):
  t1700-split-index: document why FSMONITOR is disabled in this test
    script
  split-index: add tests to demonstrate the racy split index problem
  t1700-split-index: date back files to avoid racy situations
  split-index: count the number of deleted entries
  split-index: don't compare stat data of entries already marked for
    split index
  split-index: smudge and add racily clean cache entries to split index

 cache.h                     |   2 +
 read-cache.c                |   2 +-
 split-index.c               | 121 +++++++++++++++++---
 t/t1700-split-index.sh      |  52 +++++----
 t/t1701-racy-split-index.sh | 214 ++++++++++++++++++++++++++++++++++++
 5 files changed, 351 insertions(+), 40 deletions(-)
 create mode 100755 t/t1701-racy-split-index.sh

Interdiff:
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index c8acbc50d0..f053bf83eb 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,6 +6,9 @@ test_description='split index mode tests'
 
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
+# A couple of tests expect the index to have a specific checksum,
+# but the presence of the optional FSMN extension would interfere
+# with those checks, so disable it in this test script.
 sane_unset GIT_FSMONITOR_TEST
 
 # Create a file named as $1 with content read from stdin.
diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
index 7f16f5f7a3..5dc221ef38 100755
--- a/t/t1701-racy-split-index.sh
+++ b/t/t1701-racy-split-index.sh
@@ -9,7 +9,7 @@ test_description='racy split index'
 
 test_expect_success 'setup' '
 	# Only split the index when the test explicitly says so.
-	sane_unset GIT_TEST_SPLIT_INDEX GIT_FSMONITOR_TEST &&
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	git config splitIndex.maxPercentChange 100 &&
 
 	echo "cached content" >racy-file &&
-- 
2.19.0.361.gafc87ffe72

