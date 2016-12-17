Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588931FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757575AbcLQO4R (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:17 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36501 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756968AbcLQO4N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so10562023wma.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aO/AcQvqO5do8JadPDzcKbTabOP+L8Mbt52njCXR7zQ=;
        b=CErsIr+88Z8+aMFMPkjAUq/p8b6nQc3869Z/ap39FqcdTkP9bflH2ndPt0LSxX2AhN
         +0epblwozYLTzI2PrdEUQKn6Cw8DhFlgQOzCjHFvDAX+UONN/4Y+W/MSK5i6b1idofS1
         ZHu7yyIDEB0fD2YaK30FC7PhR/7DaUbJRWA5bZf9qXts2FCk7KeSlkGCKUg3PE2KGMzo
         6BKMy/Qvjg40UbLDTH6/4EXsTugZ3ZRXxehyeVJVwK4y63elVhlqm7zS25ckdGrnA0eP
         DIOisxmmIZVnowucVEFI4cBel3XVyMe02zqN0iSYvuzBrfxjvLeWYAkIR+OrVKUgonCI
         JaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aO/AcQvqO5do8JadPDzcKbTabOP+L8Mbt52njCXR7zQ=;
        b=YgYd5ylIVELB0i88ln04NTqQtBksmEQxhFEBKU+V86v3+wCDWnxvPAeuOARwEwGOtX
         F8hmL1XFIrJqcjnwGBbUA6iQ0uPQKFXkq908bviwRhVMBqQ6vioATjiwrqm3P+f0Gzjs
         4mvMGaJs6IlckEFCb7Pjki1r6++5XR+JfzrzhuW6o0PpjGSUmek2Ztf6N74GgCbfwyPH
         tlvY2kWHhQzZLI8LZO6cxh/qUw6mHRFsof/beHD3anHW8/7mTYHhDyupIAY5GmZU9zC3
         Z+6Pn3rfEZC1ApDonWJc7MxEjucPYye93Q6e/c9Hs5DOGg/DCFBbn16OJolZerMK6N0X
         IxsA==
X-Gm-Message-State: AIkVDXI/xi7dYvadrHGwVjHemAtsFRZ49gPrwixNzFl+grF2fZHzF/chAqg4da6v8qtAZw==
X-Received: by 10.28.227.215 with SMTP id a206mr7855712wmh.84.1481986572144;
        Sat, 17 Dec 2016 06:56:12 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:11 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/21] Documentation/git-update-index: talk about core.splitIndex config var
Date:   Sat, 17 Dec 2016 15:55:34 +0100
Message-Id: <20161217145547.11748-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7386c93162..e091b2a409 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -171,6 +171,12 @@ may not support it yet.
 	given again, all changes in $GIT_DIR/index are pushed back to
 	the shared index file. This mode is designed for very large
 	indexes that take a significant amount of time to read or write.
++
+These options take effect whatever the value of the `core.splitIndex`
+configuration variable (see linkgit:git-config[1]). But a warning is
+emitted when the change goes against the configured value, as the
+configured value will take effect next time the index is read and this
+will remove the intended effect of the option.
 
 --untracked-cache::
 --no-untracked-cache::
-- 
2.11.0.49.g2414764.dirty

