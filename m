Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14301FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbdCFJvo (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:44 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35828 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbdCFJvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id z63so10564937wmg.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QShWkvtukpOWrzT/9m32+cG1edcYf9RhBqZa0D84bdo=;
        b=HeKXuV34TzpAqIGdp1na593Dw8+80DyTrECq0AZXtJL0wnrslOgkji3PfUXgewfJRd
         T969PE0G212PDb20T1aIpwPJBtF4c4gZybdHJ0aXYaq6aWR5/y2yKFDyosyheBhNLX4l
         fTq0JiKAkoAPrfBKecMKTjQnlVcz77hPBClpYqUm1SbvOdJ2kbNbz8pGATlU93r3jScx
         ddMBDe0hYk3dmeJwapZBQ7BSAjxelC6KJBIlW1wB2moexO36++chjUvffbrRW74FAIC4
         Yr7vH/aJ9JGzDe83EWUhfm/b5erFWFOw+jCx1zF49MHDC4tWIbsV57jyHybKyqEg9kNx
         itVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QShWkvtukpOWrzT/9m32+cG1edcYf9RhBqZa0D84bdo=;
        b=Yh/88wfnKCzjR19sPw5VP+IIaE7bfjarYSGcf5rRhWC6iauH6KKIbUFLuOGMsWVhev
         XqU80oizMauCGIbvV34JafBFhqts0jifLXoTcOVgJAGkaoAeB+/+/9FiUje3+t4yf4L5
         8GjDnFenkPOuoB15xGAxPlBq8DYjXTnqBz4RHRGVWmhAIXUbqMMLeyWZ4e4n1VSDRmkh
         JU1Dt3DTVfbGKMak6zrB3rFrEqdgipIvV8j4Z8pr1cV1QVdCyazARpLAvWPEiBa1T2Kp
         X8Zm7SfOS8fwCjHfnOXI5bJ/CPFdZTd6iM5nDYRh83buk5iP0NOuiQB3XfrlP47RnvKR
         /0Tg==
X-Gm-Message-State: AMke39nq/4J2v6hreHmiEiJptDAz8MU05sWIm7OFck5ipE9pUdA1ggHMbbx+yHhIwcqZ1A==
X-Received: by 10.28.169.87 with SMTP id s84mr12336780wme.77.1488793366096;
        Mon, 06 Mar 2017 01:42:46 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:45 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 21/22] Documentation/config: add splitIndex.sharedIndexExpire
Date:   Mon,  6 Mar 2017 10:42:02 +0100
Message-Id: <20170306094203.28250-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b64aa7db2d..2afd5d982b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2864,6 +2864,18 @@ splitIndex.maxPercentChange::
 	than 20 percent of the total number of entries.
 	See linkgit:git-update-index[1].
 
+splitIndex.sharedIndexExpire::
+	When the split index feature is used, shared index files that
+	were not modified since the time this variable specifies will
+	be removed when a new shared index file is created. The value
+	"now" expires all entries immediately, and "never" suppresses
+	expiration altogether.
+	The default value is "2.weeks.ago".
+	Note that a shared index file is considered modified (for the
+	purpose of expiration) each time a new split-index file is
+	created based on it.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.12.0.206.g74921e51d6.dirty

