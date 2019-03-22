Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF3620248
	for <e@80x24.org>; Fri, 22 Mar 2019 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfCVO1e (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 10:27:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39770 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfCVO1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 10:27:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id t124so2380427wma.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=337vsPRyoCkVyhE/avejWWA2mmxBLbDrfLv5Yqpuras=;
        b=stskLjEailnEZ0LPABuOb/DrBg/iDRGRKDoLST7WXFQ5UXHd4kCgR0Kb95j2CPnvzI
         QNKeOCRZTDujQ/tum4dmp/00Pewr2SeyTbzD4lOfHAIJ6f111haoKM4Ypa/jUu+Ia0/X
         2yTMVMfpp0qL7Vk6xWkQ7VLK44P2cJC/cj5xoFHuwGMqX+j0gBYsN6NXiySIOkRIlr7u
         7BUzy5Ztw3foiIDUmcPdHsNLG1KkDcOcBPTnMWlzVaqwiWOjleNejxwkk+163Qqj7buD
         RFUDK8vSLAdsEg2v5/5/SOZpFVs7bbgdcRvS2J0JV7IoONxNUq9IRjOeuQ8wk7AuCzgc
         ejjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=337vsPRyoCkVyhE/avejWWA2mmxBLbDrfLv5Yqpuras=;
        b=fSUj7xL2uKUd31vKTXsdhdxCyhEGODLRFukyziikdoA7zpNVLurRxhHw75uyK8OL6J
         B1IgmkaFmAaBcrcU6YQrV/ofXDVlhzC+cRs6QxYDMSjDkiRTfE0INUn+MhgexoVTPv0q
         QZOFycXG7NY/kdEXg3Roryyo+GJV/wnTjWnOnozyRVrF8M9ott0Xp2D9nPy9VbfYAQsq
         9tbwH9lcBQoGmVVncmANaZJXVdd5vSD4R82qVBePnzrbcYxWRW8dedR2761HWwTjuI9h
         M1u5of7LFGlDSCmBSZNFcj1m5WAILfPwBFMbpWveEbRunm/FAd8rELccfVN0a84fAqOl
         WIaw==
X-Gm-Message-State: APjAAAW9qptUtRPei13T6ibbbDs++2+A04tFgwajWuXpeeOYKpxV8/ur
        UqJ4NcgTxjGxDNeWJUQR6pY=
X-Google-Smtp-Source: APXvYqwSrvSzcI+fCcwGroRvwXTijYKDf+VhXOFcvUp3v95lrSUCIR1QHJRLWe7G9uLBz1rh+NcUtA==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr3144124wmh.19.1553264852889;
        Fri, 22 Mar 2019 07:27:32 -0700 (PDT)
Received: from localhost.localdomain (x4db501f9.dyn.telefonica.de. [77.181.1.249])
        by smtp.gmail.com with ESMTPSA id s14sm8403915wmc.7.2019.03.22.07.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Mar 2019 07:27:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5318-commit-graph: remove unused variable
Date:   Fri, 22 Mar 2019 15:27:25 +0100
Message-Id: <20190322142725.768-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a remnant from early versions of the commit-graph patch series
[1], when 'git commit-graph --write' printed the hash of the created
commit-graph file, and tests did look at the command's output, because
the commit-graph file's name included that hash as well.

[1] https://public-inbox.org/git/1517348383-112294-6-git-send-email-dstolee@microsoft.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5318-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 561796f280..069e4e28e4 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -75,7 +75,7 @@ graph_read_expect() {
 
 test_expect_success 'write graph' '
 	cd "$TRASH_DIRECTORY/full" &&
-	graph1=$(git commit-graph write) &&
+	git commit-graph write &&
 	test_path_is_file $objdir/info/commit-graph &&
 	graph_read_expect "3"
 '
-- 
2.21.0.539.g07239c3a71.dirty

