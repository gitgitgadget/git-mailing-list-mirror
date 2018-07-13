Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B261F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeGMSGK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:06:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbeGMSGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id c4-v6so13235320wrs.12
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1RrOCBcbAT8t87DdoniJHG9WEeuW3yucMrO0epsDiI=;
        b=ClEcZTdtKZL+zX+wyY/t7agE0BdBSo7j7TR1sE40gN5TX1UXPvmbl4IM13+T28ZIz3
         o+8ahbxShEH8m3jlYNzwPqcRaM39UdxDVerUgLoA2IiQ6/K+mzajmmxVTp8bK3eCqqjy
         pNKbOyR8CUTlfOlwdjzO7q7NsPCFZuacfR6+OxtUo46UyMCERn78dsjdhVHy8WC42dzy
         avj2UtZKhEXn9PJjSE3dAO/jjk5JBNRXKL11ZzplqYr+myI3SVzy7Qp5EdpwWk1Lkqs2
         50CDYfILZgcu+qmivuDbUGeSeRhcMDDHEwmxH7bbxlSmE8yLDrn4HyjmTsUO+hpcnTS+
         gu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1RrOCBcbAT8t87DdoniJHG9WEeuW3yucMrO0epsDiI=;
        b=jcht0UAIi8n6aK+5fN3sJVE5VmHfMRHaxAyf7LXTCSJO1tzK4emlftml9JD/O56ydK
         5QRNYmZYBX9cBz+NhU0DAD6vKhigCTMnSurwuEUSRcjAs2mN/e1Z7vv/Uwum4m7wXEgk
         59Vnh35MMbBcvXmOKfEFcOu5zPVj6lVWsrakwuo6b4b0DQaBQJliCQnNKvn0ZwQbWHEG
         1P6bQrcyLcx5pn2KvpGAH5Ps38dwBWPdg25v5JAVAnB1KWwG8FNWfy60FwXy7ZCUTYNY
         k8reB5g34G0tvUW8F8ru7B+xDNLbfi+ub/B3DSYPDsNgdB8bqAuI87siYk6wAETxoijO
         ZANQ==
X-Gm-Message-State: AOUpUlEKTE3NL8OWqRI3UgUT1YPBpy8ri7O1Axn7FbS/efutOhFUyvLo
        xRSo4k+6z2Xu4kRBkSf2yGU6jNB0
X-Google-Smtp-Source: AAOMgpcvMkqivbICAMhocWqRVQx8qItSrTPqFY+zGVDRswmvnto8gpENc6Jjr214gHh7AphG/RG7xA==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr6135544wrj.212.1531504230151;
        Fri, 13 Jul 2018 10:50:30 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 8/9] t0410: test fetching from many promisor remotes
Date:   Fri, 13 Jul 2018 19:49:58 +0200
Message-Id: <20180713174959.16748-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
In-Reply-To: <20180713174959.16748-1-chriscool@tuxfamily.org>
References: <20180713174959.16748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0410-partial-clone.sh | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 71a9b9a3e8..9d513ebf57 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -170,8 +170,30 @@ test_expect_success 'fetching of missing objects' '
 	git verify-pack --verbose "$IDX" | grep "$HASH"
 '
 
+test_expect_success 'fetching of missing objects from another odb remote' '
+	git clone "file://$(pwd)/server" server2 &&
+	test_commit -C server2 bar &&
+	git -C server2 repack -a -d --write-bitmap-index &&
+	HASH2=$(git -C server2 rev-parse bar) &&
+
+	git -C repo remote add server2 "file://$(pwd)/server2" &&
+	git -C repo config odb.magic2.promisorRemote server2 &&
+	git -C repo cat-file -p "$HASH2" &&
+
+	git -C repo fetch server2 &&
+	rm -rf repo/.git/objects/* &&
+	git -C repo cat-file -p "$HASH2" &&
+
+	# Ensure that the .promisor file is written, and check that its
+	# associated packfile contains the object
+	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
+	git verify-pack --verbose "$IDX" | grep "$HASH2"
+'
+
 test_expect_success 'rev-list stops traversal at missing and promised commit' '
-	rm -rf repo &&
+	rm -rf repo server server2 &&
 	test_create_repo repo &&
 	test_commit -C repo foo &&
 	test_commit -C repo bar &&
-- 
2.18.0.171.ge260395bfe

