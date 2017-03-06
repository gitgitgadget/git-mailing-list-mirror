Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9791FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbdCFJv3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:51:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36010 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbdCFJvW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:22 -0500
Received: by mail-wm0-f67.google.com with SMTP id v190so12761476wme.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VwQT7WBb3aEnBrEAyCsQONAnwYLABwR/OgSjctj/ICk=;
        b=Lvw481oTtzLU8jrRIAIyXO2Q7NHkAlQb7etRgl29C9DLlfSU2JzOb0qcbPUh0tHxzA
         BX69xop+w+V40qpItI6TjPh/n5vb4XbYMPINecy0aZYt4uDSKhgDQPsw6/G65gzD9Xrq
         llG03MAYRfEE4NrOOWWwW/6JN+Syv/ZzCMjJV5nR40cyCM1XSk9x0+kN96Qw7kzIy91R
         jvEPmDKhoLAtxTMITVHg3+6h5KDZ+hkPAtcHrynNIXFvtXNWx0ULnxCGlRPbGtVTy203
         I1iyuWHkttqmgZQDKLwRg0yOQQSlZiZ0CkI1aCBLbEpRLjzhFqH23TiagXB5+0p8YITR
         P0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VwQT7WBb3aEnBrEAyCsQONAnwYLABwR/OgSjctj/ICk=;
        b=dMOtHlsaI3DWtN9W3cKEHv/z+cmv4+5vvSaYgGxZUHxySOKlUnwlyexPckhWQpFLsH
         gVF1iZYOt41oweV0ppuuiGgnTU4vzB31FO7pHA20grHyFlO5+lN4i8+YBQXZl5rdB+UP
         LMA9Ru93KwIfJRSEgxrBVPkm4ly07ET3N6t5mWbVM6EKFUGZYpuzI+NyeGZhlEVdBYM3
         fT0gLsXhs3/rz4mr1gjaAWaHo+hunRRVcVlCadLHEBd//YwlQNePteBHHwSVX6ew+xPE
         qxtHJDyotRA81rA4SIYII3+KNQFs/KCkiJtJ3uwnn+9sFR80SLERKr+PeBZmHw4gptvq
         R3FA==
X-Gm-Message-State: AMke39mFoJEzNnXw6AB94BMZt6rJ66XPH9TDy6bb0qYPpUn8NBvpZHfwiD4QmBEiYISwSQ==
X-Received: by 10.28.51.205 with SMTP id z196mr12979731wmz.22.1488793355991;
        Mon, 06 Mar 2017 01:42:35 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:35 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 13/22] Documentation/config: add splitIndex.maxPercentChange
Date:   Mon,  6 Mar 2017 10:41:54 +0100
Message-Id: <20170306094203.28250-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f102879261..b64aa7db2d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2851,6 +2851,19 @@ showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
 
+splitIndex.maxPercentChange::
+	When the split index feature is used, this specifies the
+	percent of entries the split index can contain compared to the
+	total number of entries in both the split index and the shared
+	index before a new shared index is written.
+	The value should be between 0 and 100. If the value is 0 then
+	a new shared index is always written, if it is 100 a new
+	shared index is never written.
+	By default the value is 20, so a new shared index is written
+	if the number of entries in the split index would be greater
+	than 20 percent of the total number of entries.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.12.0.206.g74921e51d6.dirty

