Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE62A1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758282AbcLQO4e (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:34 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35459 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758163AbcLQO42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:28 -0500
Received: by mail-wj0-f193.google.com with SMTP id he10so18053697wjc.2
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRxhZKcy3z0qXR8IwoCi/OZahR+sb0KV1NQnjxN0HqQ=;
        b=luSDV00lGDGaxw1M31kJf5qd+tEZk4phUD72wZmltx78yR8CAGQ6Ysjshz9B4UPmWW
         7PZl2IZkUIQwrZE0Q1mTZNw4Wc7Ow/d/RQBdukhgNPa4wDAYqpGLArS4zbJi7LA/ySex
         YAIF9yR+WmheWk0J6llvPvcYG7VAYMhR1gzaVMkSbecfDqlJc7C3dHFWWvcSQ2FRfzbj
         YT7tpBiZj6kiASOHW4dI06Qcxi8URW85+bbd7ivKCztGGxa+r/7T8EM6L1XiliI5TwNl
         uJU/eSdV5MfyB6p8niMwG93n4WGB+XfNhBLxkxqa4ou2b+VBnFLCeuTZ12unFVfB22nY
         nUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRxhZKcy3z0qXR8IwoCi/OZahR+sb0KV1NQnjxN0HqQ=;
        b=rjd9pvPmDikMbqDrl20piKPptj3X8mSVMIc++b9qGxCc3K+fax2A6xbH1pnbPENCGK
         mhaOx5KwBGgMA+5bGDmKimNRtDLHk9W4GwDCPZ9NuzBkXvlnUjkjRwooUapqPdBfZ4fs
         HZNBOZNVqpLoIoyvRZNNfghp/scVSEG7Kutq/GLafV970yZZVwR2d7hSKM/6DAhMdSYS
         aTvfYVwYTXtYA3oRuVfjUCA0bVjf6uLm8rl6sAcOPKDX1kx5HRMBEDNZP9GwnFs0Npbg
         rG3gE55zGb9kWYPhfqQ1aSmpS7cwIfZHNHvGNRWGD4a1Bk2wKiBVq5bCXR0R9KSsAhzH
         B0/Q==
X-Gm-Message-State: AIkVDXJ+AyGzh/nSsAxZVVBcfM+QmsWNBZqRvJFDqQXc2ofMs+zNPHhl7aZDy3/FdjYh+Q==
X-Received: by 10.194.177.197 with SMTP id cs5mr8103960wjc.6.1481986586656;
        Sat, 17 Dec 2016 06:56:26 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:25 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 20/21] Documentation/config: add splitIndex.sharedIndexExpire
Date:   Sat, 17 Dec 2016 15:55:46 +0100
Message-Id: <20161217145547.11748-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 08f638c65c..8fbef25cb1 100644
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
2.11.0.49.g2414764.dirty

