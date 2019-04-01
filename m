Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D1220380
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfDAQlg (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34318 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQlf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so12953432wrq.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1x8uNGx+JGD7TkXaud87aiR6haI6KNGdh9Zlyne/c0I=;
        b=WEMdw9Bp2g3sb+Ez+ZsRbwgun5cBw3OR5bmAzHDDmER/qv2CjNuGktWPmw2ih3zJW1
         /E5s1WDML9HLW3SG3pf7GZExk5Xu29tyloGjthTUTSGDj0LGVfRRbrXHQnGOK/XKeLft
         Tk9MyiJ/rYL+U3UCdTcx7AzxhaDe0MW/Lp6GjTWTuIUACrcGQwHFxqZpnxjAJ+aydn2o
         WuI1iGiDj618tJcFR/YJcG3hq4KJwRtRN2e1t03tk/pSZ7tVt70u6rXhkeDW/vFVNyCb
         YSxJGfkg3vkrSYXOweTgu4dWJCMSuAEiPXZfGvWW8j0nlM9kQx4sJbCCcU0NjPQAHGRL
         nu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1x8uNGx+JGD7TkXaud87aiR6haI6KNGdh9Zlyne/c0I=;
        b=XTdeNZCIEaHu5j1PORoop9STEPi386o6nK+UPJJzk2bnBs6PTFWXX3yo2YeSSBPQFP
         lHmQGaOo8k1tDqCpc2EJX1njBBdxwSqaW7V+c3wbvf/8PnAHcybGbKLCgROiIYJHUm3y
         rMirwJSkQBiX9Cyf6ObejPfll1nA7dGLrotmY3b7yEABgEQSEPx1H0+lJxcZr+4g/Kcx
         UVDG9blUouNdQPC4ApdYQprKCPkHKuv2WnHNzHUizQIqWJ6+FbCzzY+/O1hFJv0PVaNF
         ZA/iurebS8SwXwloFZq0QMtr+CPDSE52NGJfurT1ZiGdE66qJp92O1rkiPanR4PvfHcP
         KyJg==
X-Gm-Message-State: APjAAAVkFmHAyzp7P5NoVnzqlTy/Lpbt1efkJMCC6iQ26YR5zkcbliN0
        2ZVi0ReuuOgqfg8SN1lJAuQKfXlJ
X-Google-Smtp-Source: APXvYqyFCvqGHW0CeMXntsz9Zus3BYppMdljZ1+7UCvxTlNEj8KsrQ50nE5/AXMSYpfsXS2WUi1Ikg==
X-Received: by 2002:a5d:684e:: with SMTP id o14mr43792155wrw.138.1554136893845;
        Mon, 01 Apr 2019 09:41:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:33 -0700 (PDT)
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
Subject: [PATCH v4 11/11] remote: add promisor and partial clone config to the doc
Date:   Mon,  1 Apr 2019 18:40:45 +0200
Message-Id: <20190401164045.17328-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/remote.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 6c4cad83a2..a8e6437a90 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -76,3 +76,11 @@ remote.<name>.pruneTags::
 +
 See also `remote.<name>.prune` and the PRUNING section of
 linkgit:git-fetch[1].
+
+remote.<name>.promisor::
+	When set to true, this remote will be used to fetch promisor
+	objects.
+
+remote.<name>.partialclonefilter::
+	The filter that will be applied when fetching from this
+	promisor remote.
-- 
2.21.0.203.gd44fa53258

