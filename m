Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60F71FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbdCFJwd (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:52:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35302 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753873AbdCFJvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:40 -0500
Received: by mail-wm0-f68.google.com with SMTP id z63so10569680wmg.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UEax+7GbaUAr2wiGbVh1Gxrws8D44BsRCu/e+R9eEw4=;
        b=jrCY7zWev9uCdL9eANdkcZbE6MdoCRV8uirFa21kKEYksbNGh6MnRRZN9qEnqljt53
         QSPFwDSEavhUhGvSyhP+8aFNRsqhrDOMfZEXiw39853G825gTN93SVjahrTHLNRaQq4F
         SjMM638UBEpNUz9Rx4T1hFM9VQofjD85koyUc0cENxB3OAdFepVs4G+FEyNHRTTaPoNi
         yXR7lcUHMljJBvKHa7vpNXdI4X/gplmEiK3L06Ym5GTCFp2VgXocQFyUM1bx2ivNK9sN
         uVrXQHgiw7t4+avOV2GyN/2g7mFUnImo/VbEoz5VSD9bncIoyFIiUKRfH2P8xvQRV+1B
         E4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UEax+7GbaUAr2wiGbVh1Gxrws8D44BsRCu/e+R9eEw4=;
        b=N6PPbj4oONxel3SwIYcNAGzwqywvLE5znSPamxCf3MJP2FDMxxln4Ui0ptwIHIcsGI
         ocsnmSyQEWY2tkEPbQYZwG/cMBr+v1Nv/FIw0WjDpiZLdniiMI/wpkz2G9oINv6xbBCZ
         QGidekzFip2rRdN8ExTHAv+ov8zZjh4Bb8ASyZqCXEpMaBIpP56Bf6GQP/0n95Q1SlUy
         HolslDlDC1E+3BJBZZC6pOYkAkDm2MEz/tt4GNlv+hi2OObT2Y1rx+gpFzsVk0/nfnKE
         ANxDmVmLMQPcEtfnWYfHT3BCRxzpEG0qB1G2rsJ8E98kVqXqBmtYMl0F/gHU1jRUA6yr
         L7yA==
X-Gm-Message-State: AMke39kMXfPeADp5LZEi6FwTtU6dhwi9NOYLzPY12BTu75kxYJvS7JAXevuC0QHGPPsDCQ==
X-Received: by 10.28.198.132 with SMTP id w126mr12855111wmf.69.1488793348429;
        Mon, 06 Mar 2017 01:42:28 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:27 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 08/22] Documentation/config: add information for core.splitIndex
Date:   Mon,  6 Mar 2017 10:41:49 +0100
Message-Id: <20170306094203.28250-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 47603f5484..f102879261 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -334,6 +334,10 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.splitIndex::
+	If true, the split-index feature of the index will be used.
+	See linkgit:git-update-index[1]. False by default.
+
 core.untrackedCache::
 	Determines what to do about the untracked cache feature of the
 	index. It will be kept, if this variable is unset or set to
-- 
2.12.0.206.g74921e51d6.dirty

