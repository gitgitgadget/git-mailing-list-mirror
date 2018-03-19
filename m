Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18231F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeCSNcn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46213 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933178AbeCSNcg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id s10so5770455wra.13
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhR//F8UP5b6U6NRkWF0EKs7kccmiO0iVcApF8mRD9U=;
        b=AD6ltqfVxO7YeCXLsE6mxGy9H9H0nd4AA6IyD4wpjxSfWT65SGeTnh5ihLPS/n8/A8
         oiK1whRlvgMdSQwmbf2OqrJFno2GThXcX9A4lsjLzCfBjULoURBPtTul1RrbY3tmCNii
         STAgox8Jch+HpfJpJglJ19BhHLT1i84YRRgYCVaSpU1P1vqKDJ9Ye3pRVaWkMmgUacyI
         krwyiNHdM+xsyOj8N7gqfEiDp/Pzc+488ZP0zBLaOjJeqFrNTbTZtKLZATWRmUR55WI9
         3J04yY77RvvyAS3VgkgWWZebuOX9iGexUPlM1Bb+h0cQjFOLP/ivjRTT18ORii/BQ0jn
         N+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhR//F8UP5b6U6NRkWF0EKs7kccmiO0iVcApF8mRD9U=;
        b=Xgr3LZ5H2w3ijxdgo1fXoqpDajCs48IxhygP7vwpCTK1s4su/F509VT+Z74k1jcu6Y
         0A2S9rX3MFe20b6bDhwgwogK0JlXqkF/fHiNaoSdYZGE4Bi1W/QM+znSDfMciMcuO4Ln
         M0vnO1u109SWsJNnTmzNJ6+6PwzRrJFIj7XmpaUu8F4grc+U5f/QAaTgC4b/z1ihWjRQ
         rzUGo/ajItsnuJP2c/7h5sbustViIbJrrAWQw+Yf4kCYDoCQLHzqTuPrFXfliIiXQEPL
         C8FRXj2w6XdiVulf4fN6fpbiGzTVLVTCtFWxe8JAbRIi73t2ScCjAs5X8c3t2IJMeVhq
         mShA==
X-Gm-Message-State: AElRT7FxL4HYX0a7J0tKHLSFY49JimVxJW08IgGM3DI4JIeCAnP+D+N8
        TGiWrxd1oJYPlyZWGE3YgkAFmToC
X-Google-Smtp-Source: AG47ELulzARnZglaaI0Xbyuqwvt3RdEOw73DpFCb1C857kh20KdcP4RS+R4M1imUMwKGKpAQhKDIAw==
X-Received: by 10.223.143.86 with SMTP id p80mr10336334wrb.31.1521466354652;
        Mon, 19 Mar 2018 06:32:34 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:34 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 19/36] t0500: add test for external odb write support
Date:   Mon, 19 Mar 2018 14:31:30 +0100
Message-Id: <20180319133147.15413-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0500-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0500-external-odb.sh b/t/t0500-external-odb.sh
index 4ccca1e965..f924de870f 100755
--- a/t/t0500-external-odb.sh
+++ b/t/t0500-external-odb.sh
@@ -69,4 +69,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.scriptCommand "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(git -C alt-repo show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.17.0.rc0.37.g8f476fabe9

