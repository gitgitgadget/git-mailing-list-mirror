Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492691F404
	for <e@80x24.org>; Mon,  3 Sep 2018 23:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIDDsL (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 23:48:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726951AbeIDDsL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Sep 2018 23:48:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5B45960756;
        Mon,  3 Sep 2018 23:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536017147;
        bh=60jgctvAD/VioyALbIsfSndn/ncAHQApucEDJCHVNW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PwnDE7sOBJg3hrCrC56aSKl+GrC3O2NFFPNnp39Nz5Vt1hKk7oxvHFlj0Z5d2mk6N
         Mc1GjRa+ePCKxkcI0Yrkxkwy0fGS2kWo3O6E2Oiue59HQIE+FXfGqCY+bM5GlaH9Pj
         0nY2eghMsmq26r9voqQxC7x+kmw3sKHkduZ2T/IaefOvODyjvmPac9mvpZ1Sk/WALc
         kxoIlGIJCAtOFmxzdKipV2elOyI2jRMxYEjIaefZGtL8uAY2ecNTMYEX7fT5S7UI9V
         N49ZxW66lEYbt2o4SsOhJc1bZA9vTc3TSORzZoiyuX5E0BUdnGyxxAAijoQJottMtR
         +H2/YB6P8hnQ+EfrDO55fOH1g33+ua+lt9CRBCKHMj8rBcfKpnO2IJi2UTf0PhS+Jh
         63vdxTftbVOGEuNvE03Q6P9ZxhKsbfZknEmB8HDzzQ8Gc2bSz0s/SjNaTRZH0U2k9c
         NMgLAS+S94khEjcm+pjvvHiV13qTN1hyeK63dKyWxD9heNe53wS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 12/12] t5318: use test_oid for HASH_LEN
Date:   Mon,  3 Sep 2018 23:25:15 +0000
Message-Id: <20180903232515.336397-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180903232515.336397-1-sandals@crustytoothpaste.net>
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <stolee@gmail.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5318-commit-graph.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3c1ffad491..d286516f0e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -8,7 +8,8 @@ test_expect_success 'setup full repo' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git init &&
 	git config core.commitGraph true &&
-	objdir=".git/objects"
+	objdir=".git/objects" &&
+	test_oid_init
 '
 
 test_expect_success 'verify graph with no graph file' '
@@ -273,7 +274,7 @@ test_expect_success 'git commit-graph verify' '
 
 NUM_COMMITS=9
 NUM_OCTOPUS_EDGES=2
-HASH_LEN=20
+HASH_LEN="$(test_oid rawsz)"
 GRAPH_BYTE_VERSION=4
 GRAPH_BYTE_HASH=5
 GRAPH_BYTE_CHUNK_COUNT=6
