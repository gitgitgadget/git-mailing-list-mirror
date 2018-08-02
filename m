Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E029E208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeHBIFe (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36566 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeHBIFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so883845wro.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8e9We9exRdRKSX087+9V7EIgA9zKmaIQwMoQNo0KM4=;
        b=L/LY+jRnD2YCPCXKDoWKlEhRxsODehcJlm+vCELiwnDqgGjfxGzjxFdQWFmFJZzrkE
         RsVxtVaBDm3a/GSm8z8MDJjwY1EJFwhiGcDGq9AbsMZc74lHuawYCfaUGKlewE+YYm3x
         z+yxaP9jRmNGAEp3xXBooAgDqK0+7JU9rEfU1Bl3AYlBNpwWz+o+JnRMNMOqv37THBbd
         bxlVA17GFzd98WZXf1tOARzZp1mKd94ZcTq6Ajk0g4WxCUBRSyJyz996HlUaivFr46ge
         Gq4RtIgk59TdmySq30d+SrVjVohOTSh9AUhwhGRtfLznmMMgtSVMkhXc18t47+2ClKB1
         5L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8e9We9exRdRKSX087+9V7EIgA9zKmaIQwMoQNo0KM4=;
        b=cm05UBrKHAXswwOEZihDEEPm17t1uvVtYK8NhQEIhbAsSlojsK6OmFITELANXyCyPj
         t4T3MaQW7cC7JCD1uaNdKWAivQWkmpEYyndyzstISAYQmLAjfIQ+F3Z2d1Z3Y0vEHswy
         ofqiuJQ04u2SxGm3Iu7LAOvmYNCErRX9zCeeWJ788NdBuRCD55njd0BHSLboU6nxLwA4
         Ra1glk59fBjPBVBlhyhpD+iNX7L9pbgsfd7QDyaSez5avbAUZfvOOvDl+zq1j53x7PTG
         uDaiqYexcCqgxYQvC/FTosvqD1p2ALM7EwUQ154vN2r93X77n2hxLTLd7eVXlMTV6Zq6
         xW3Q==
X-Gm-Message-State: AOUpUlHfSGROme7y+d833BYLRZ2NA6rvNJQSMh8COSextDhLBFMMIZi5
        kCELiN0ykgfADacexJSu28F78SK6
X-Google-Smtp-Source: AAOMgpfjEVSllwddHO+vhBK62i5a0S5LAHrrF4+VIeEcFQqLVJ3dMkwsTCJCnsLK8O3k7OxLP3RqPg==
X-Received: by 2002:adf:f507:: with SMTP id q7-v6mr399421wro.241.1533190561316;
        Wed, 01 Aug 2018 23:16:01 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:16:00 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 8/9] t0410: test fetching from many promisor remotes
Date:   Thu,  2 Aug 2018 08:15:04 +0200
Message-Id: <20180802061505.2983-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.18.0.330.g17eb9fed90

