Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8301F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933298AbeCSNc1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34297 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932989AbeCSNcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id a20so12721244wmd.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+58cWlVdtXxUrT+aVtA9eLR2k03A0/E9uuvfCvOXSHI=;
        b=pOgy2gb6Ad4OQyDIb2u+3db1Tj9Dyn+t1m+i952ZXzoswuu+MDt6IzV10uh42aORfS
         rcLdYaRvCXTm1uTFJ6+ELvWEwmAQ0pdJNNNzArqHtrZ10jhN0F7InvCs5Zi96Fd06Ewm
         oPw3G1WaCpT9OSxx2TRTGcXGji7EhFeAgBCqy4QcWzvntb5bYccDsAE3oyFc4441mD5L
         7WfJFSvWHR+8EnwfZYJQPaitMHB1dk7TNyUpuKF/fuQGCKvpQNFjDuqE16EewajFNOv5
         +IwvM+A8Y6TB2E0xMUTObhXqrSBjznvQI4PF88nIiflHMWa0kOCplTMg3MtOTp1BA8cz
         YakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+58cWlVdtXxUrT+aVtA9eLR2k03A0/E9uuvfCvOXSHI=;
        b=a44Cxdoa+LR1m6lilVx5uIbzHlCBfCBRq5hVBtz9YDItwgdUznhN8AtmyY456ncovY
         txihkZBnpGG/Oid+XeCl4WwgE5Ijr2+JUpNpNDf0mNAVykqazkiGwoyiNwWmd5lUj5Tw
         Qm4nUzBYH10N3c/vM1Oazzv/hlRz+G+W+31oFofVWSfkhw7BGRPSJkQ+zJXYlZ14ECiP
         8OjPmUc7r+p2tL/TWAyYnSlZCfENVpvEBdeaWZF+R/JMtr4syhUSh+6rVG8o4tstcf4x
         mt4O9KmAO+rlfedLY1v/zeoFUbkTdnENIbCWxmmejtYoJhvNeNWUgbDFN6pDJbXab7LR
         2gXA==
X-Gm-Message-State: AElRT7H1+8HZeJj0x89ErgtTydiYqmsYivrv1lP0fBD791MqmqZ8vm0B
        DMBnuous4y1JT74Dcg4ewT/ID3dp
X-Google-Smtp-Source: AG47ELuWXjClx16ljsuQ6NFff5wqncKb+38C2NMw1wr7i+5ZdwUzlu66LSUwt+gCDJ2C/nGinMTzGw==
X-Received: by 10.28.146.71 with SMTP id u68mr9393321wmd.107.1521466333857;
        Mon, 19 Mar 2018 06:32:13 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:13 -0700 (PDT)
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
Subject: [PATCH v2 04/36] external-odb: add has_external_odb()
Date:   Mon, 19 Mar 2018 14:31:15 +0100
Message-Id: <20180319133147.15413-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used to check if the external odb
mechanism is actually used.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 7 +++++++
 external-odb.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 390958dbfe..d26e63d8b1 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -50,6 +50,13 @@ static void external_odb_init(void)
 	git_config(external_odb_config, NULL);
 }
 
+int has_external_odb(void)
+{
+	external_odb_init();
+
+	return !!helpers;
+}
+
 const char *external_odb_root(void)
 {
 	static const char *root;
diff --git a/external-odb.h b/external-odb.h
index ae2b228792..9a3c2f01b3 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -1,6 +1,7 @@
 #ifndef EXTERNAL_ODB_H
 #define EXTERNAL_ODB_H
 
+extern int has_external_odb(void);
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
 
-- 
2.17.0.rc0.37.g8f476fabe9

