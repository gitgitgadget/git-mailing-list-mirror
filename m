Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFAF120989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbcJKAVd (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:33 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33769 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcJKAVa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:30 -0400
Received: by mail-pa0-f52.google.com with SMTP id vu5so3982803pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kymFS+dEGLihpcSYLdhFf8/29Afk1Lrq6KOv6DmeFdw=;
        b=lDXs1RZRtRVx1uVz8GJez1kPwpo5kXVYSD3DEjSBjW0d4zXRFE+cj8F5aEgTPC9Jk7
         c5FCmqzVd7e3iskFw7Nntupz4hdRF/B6YESWNaI78bD5WH1wTVJ3uFje3LP7gyBoxG/6
         LieZxb79AF+laYezXIpHFWWHxnTHCSnmW11OI1DtLvEXg2ieZoVaCvdfQZ5Hk233HEIW
         5F6/hBqokqY/58UAip6Yda+iUbwzu8dCq+pg/NDjxEhi3QrdJrxNRxD3Hdy7daYzCpLs
         T3ItODXg4BVHt1uOuGlbBkTMDW6g7K2OwiGq+eNNmmXm5ykiciYKyCjh3mzVQoN6hRCK
         Dm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kymFS+dEGLihpcSYLdhFf8/29Afk1Lrq6KOv6DmeFdw=;
        b=XGKsn2M+pUUeTUp6nwTZ4rcIWqqwWR3qmepQJ+3QHBmLTPasIfFxQ0ta1fuusdoXQd
         3V9B5B/E3fut29Brk+5pGmNt/uuLInR/ERwUM/vizOJvBaHT3gz7ZiqdWC13zIO/5Zeq
         3CAFLeCkjypdvdukf9zhlHkHXcs3ia2aK/2oYz78Yz4k+7rlL3U+SmshWSsD6wNldJ96
         tS0/ncN/VjEclZLASGgVbjfY9RRUGbHQq1EAXY8pD/x2MEJKuRb+lcITTBcRToWw/aE9
         fJulRZYJrDn336prgqPHMXWL0TrojMsOF/Y8mxrfhMA6UR2NQ//cdTTgWnLEZ/NLAOeC
         tQYw==
X-Gm-Message-State: AA6/9Rl4egm5pVrgtr7uj8qJUN+9bDDROHTYDn+Orfoz/gM5o7acrfvSAm/OVQeA42h08ay1
X-Received: by 10.66.163.227 with SMTP id yl3mr1803599pab.0.1476145289624;
        Mon, 10 Oct 2016 17:21:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id m62sm539532pfi.10.2016.10.10.17.21.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/28] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date:   Mon, 10 Oct 2016 17:20:51 -0700
Message-Id: <20161011002115.23312-5-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 4ae7801..05db667 100644
--- a/attr.c
+++ b/attr.c
@@ -183,6 +183,12 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
+		/*
+		 * As this function is always called twice, once with
+		 * e == NULL in the first pass and then e != NULL in
+		 * the second pass, no need for invalid_attr_name()
+		 * check here.
+		 */
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
-- 
2.10.1.382.ga23ca1b.dirty

