Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F238420229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756408AbcJWJ1j (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34102 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756350AbcJWJ1b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id d199so5246359wmd.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOZURUJ3dKSHdqZl58xrJmBKozFwSO3zMtnrbUJkBCM=;
        b=sUYo6ZqqXwJWoRpKnP2c7uaZyfE06YyiSxK+6kHiGEqCPAmyZ0Vs/Rulrn3IOnk1XA
         DUD+RLSVETsmSmjtMb2mRYe2lnR6lijeEbLiD2zPemkO3BV9Qcf+kzPspj8O5mkO+KGM
         mvYfM6t6Hlwf3Da6jqj3lmus+U9XKUtdaHkvRD0YOEZDr+gnm0OD071LYeRDwV5aJxuB
         2GlMd6hv1UWQRI49rYGAb2wBnaBlfhta2PT3Lws3jctB3hCH0L6BqQWE9gV//pE9wBA1
         Isgox90McQpPDOwkDzdmAdd0Eh028YBL0/v0f3wEBSzUvf9iG7HBFsXPQsHkbsPMlM5L
         6eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOZURUJ3dKSHdqZl58xrJmBKozFwSO3zMtnrbUJkBCM=;
        b=YN/lTCwgRSgkQA5GrwzPirWyAK5TpAEEE6jZtkBMmkl4cTQeQ5oRzs4ruVNYYg5BHq
         31K+/JcF8NVDKG66tXvyue72lQsCmSw67QlQ4gZKQAq3y/coG98zGbIUlvQStIMRFO+y
         BUOPDXYEib0kyy5TS9ST0b1Xnm5oZ/Br+K1kmtFEc3BhLaTy+poYoT18Ek7rFMywFwVK
         nQKuJPTEjF/NsVzOslWWkTgrdUpKKhtMxRO77srPosYQBd409b1fbnfOEJ8StGlx2K4s
         kSe32L8xZLD6ZRwSNlz1YZRs7EoYQumIxGbx+koD3trdrNVK3HTN2lAvqY84BQuA3sf1
         hnSw==
X-Gm-Message-State: AA6/9RlkUqRco9ZDf35a2K9DUY0brfRFxsKgt64cOacKRz5Ept+HgQIyMoj7TnW7AWbsXw==
X-Received: by 10.28.57.84 with SMTP id g81mr9891771wma.91.1477214849968;
        Sun, 23 Oct 2016 02:27:29 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 18/19] Documentation/config: add splitIndex.sharedIndexExpire
Date:   Sun, 23 Oct 2016 11:26:47 +0200
Message-Id: <20161023092648.12086-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 380eeb8..5212a97 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2776,6 +2776,17 @@ splitIndex.maxPercentChange::
 	than 20 percent of the total number of entries.
 	See linkgit:git-update-index[1].
 
+splitIndex.sharedIndexExpire::
+	When the split index feature is used, shared index files with
+	a mtime older than this time will be removed when a new shared
+	index file is created. The value "now" expires all entries
+	immediately, and "never" suppresses expiration altogether.
+	The default value is "one.week.ago".
+	Note that each time a new split-index file is created, the
+	mtime of the related shared index file is updated to the
+	current time.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.10.1.462.g7e1e03a

