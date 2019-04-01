Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D29D20379
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfDAQl0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33163 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfDAQl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so12949493wrp.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bZvtaGY+8FOPSRVBeNMEfbpzbaMtxjtD9btOaHkWdc=;
        b=mmVDlpAcZKubxm4KWFqXTo9YnBEEALlVcrgGlCRL5qgC+py8oB2GgXGlcXSh/6IiAC
         ZzlvBsrjGGc4elbBvP0P0a8ZT0kV0L1EGKSsyeBncZ+Btv2K9S+HE1xxBke0YFR5MEzM
         TUTy/gSUFkAM7z0zW1ZtxrxIZq8p5F+nxFW8UjCQ5a1ij3pJASGnbgQ29I8Ftp3nTJhb
         3apMOThvQRlfxmDF2ExdZO6RVcdADgy/H1Y6ODki2uKfDGJQ0aT3q+uc0J/nBXpjRYY5
         7LWajhYuytT4MiinlTd+sTxMmu4gwq0Y74n7F5JV2eqaRre6VA7XYSNIITV6bpWxxRyW
         /geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bZvtaGY+8FOPSRVBeNMEfbpzbaMtxjtD9btOaHkWdc=;
        b=ZhzRd0BOj5UOpVaHlXoGrQitenWdWhlteZ+SorYK2oWpOzq+SdInT0Bv2pMF1UCDF6
         Yx/uL9isl0X8ZeHbYP5nSiEcfzz0BqmB/C1D6erLCyxeg0LHq81+wim52AeBDLR+VD7g
         9bP/XhoBvy31n/ogCozG/dGd6kE9VHQs0jN0VqRWvWrAlfP1uWMJBIar0x8rDMGHInPt
         GTwfRUe+6jEOfBxSbhrMMiXlwfggXTibxV0NDV+y/886mDkclhMSQ0H5gRQymGc1ncao
         kCiAEuQNhz31uEbeUnvZ+yXZWb4jc0/EiowYyp/eDrjy7M/z5zwahSsZHNM29CfLM/xQ
         Tn+A==
X-Gm-Message-State: APjAAAWFG9DI840K4DrKarR8aA+tJXtFGoPHbRMOsjUA5q4iwjMDVwX7
        wXcRjygbycfaghTTu0DUYp98D87i
X-Google-Smtp-Source: APXvYqxW8Z+w78oumIGbvAWpqE1dGKnePa4sXDHtFAhscWX30CIQ0L5CaZij4rjygCIzQj5874sF6Q==
X-Received: by 2002:adf:f344:: with SMTP id e4mr40074433wrp.77.1554136884548;
        Mon, 01 Apr 2019 09:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 08/11] builtin/fetch: remove unique promisor remote limitation
Date:   Mon,  1 Apr 2019 18:40:42 +0200
Message-Id: <20190401164045.17328-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the infrastructure for more than one promisor remote
has been introduced in previous patches, we can remove
code that forbids the registration of more than one
promisor remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 13d8133130..5657d054ec 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1465,26 +1465,16 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 		return;
 
 	/*
-	 * If this is the FIRST partial-fetch request, we enable partial
-	 * on this repo and remember the given filter-spec as the default
-	 * for subsequent fetches to this remote.
+	 * If this is a partial-fetch request, we enable partial on
+	 * this repo if not already enabled and remember the given
+	 * filter-spec as the default for subsequent fetches to this
+	 * remote.
 	 */
-	if (!has_promisor_remote() && filter_options.choice) {
+	if (filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
 
-	/*
-	 * We are currently limited to only ONE promisor remote and only
-	 * allow partial-fetches from the promisor remote.
-	 */
-	if (!promisor_remote_find(remote->name)) {
-		if (filter_options.choice)
-			die(_("--filter can only be used with the remote "
-			      "configured in extensions.partialClone"));
-		return;
-	}
-
 	/*
 	 * Do a partial-fetch from the promisor remote using either the
 	 * explicitly given filter-spec or inherit the filter-spec from
-- 
2.21.0.203.gd44fa53258

