Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D87C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA1863217
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhKOGgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhKOGge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 01:36:34 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502B2C061200
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 22:33:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p18so13534113plf.13
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 22:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag1XUVweZK3KqW6yz7xaidIz6xN5jKByy+RpEr1zVL4=;
        b=ayHnN1WHIQ4lsioVprwniCIQ7P/zhqksIjP9nY+YHrlYvIii7+ToTBsP0jGliMJWA1
         ibU/typz6gYHOot+vfb2p05hJmwlddyR8xddbI6HvK3Fj8yH17XB6SuaaLOrwSp9DKgS
         eTzShuTto0UrUEqIbaNbSbEb9PVqtbQgqIws31eE/5l4f3CgbRxX+thEUs/3ClL2WnI2
         aFVpCR/es79ufG89QJY65EREX2Z8hNJODp7UbNA3kWNrDkqjCaNi1ntnLTnx3I4fh/nC
         IQJtaLoQ14KmNATdGenl1izvPhIj9C/PI8tbnO5My1oOAA+IySO4wu97wGysBE6i4tki
         zxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag1XUVweZK3KqW6yz7xaidIz6xN5jKByy+RpEr1zVL4=;
        b=KE7Momr1JIZlekhBnIv3SLVwGGVX2u+6sYcKfZ0eioIK02CQgiKC5PEaVP+bAYW8lj
         6ZXEN9e0gacJVu2mXsucbOVUfi8zJa5SECUuPcjRWqjywOug7PIfKEAnwYsWDEDhGORR
         QOUaKJVyNhKSYpsdFmLN64iKXjujoJ58+Wsqrum0CzpcV/GgykYANUgqP1W+67C7LyWu
         RcLmvGCUbv6hi+v7FBXBhKn98oVs2g61slKsfSvydERTlH359elYbDELSo9MBsi7DIYV
         ppDJ3gw6RKGsuxD/xa5UYklS5U58mWFJa0gTlMCUx/idKifmEWdUtj5xOMLb9LeVr/zF
         Q63g==
X-Gm-Message-State: AOAM532WQHgPsLDyFrcyOkXvhXuBOew4zTaF4EaaLlO6T9c4Y3FiC/Q6
        uMwqDDS/TC6TWbSyIq83OW9B8rE88APVzA==
X-Google-Smtp-Source: ABdhPJyg+yaCjp8vLO60FfgnEQaYRXMINRYA3lK+CAXSjlaemE6ZAGdNu1HJXnXMjnCfYu40P07MNg==
X-Received: by 2002:a17:902:f24a:b0:141:c6fc:2e18 with SMTP id j10-20020a170902f24a00b00141c6fc2e18mr33161797plc.55.1636958018546;
        Sun, 14 Nov 2021 22:33:38 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id w5sm14627428pfu.219.2021.11.14.22.33.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 22:33:38 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH] midx: fix a formatting issue in "multi-pack-index.txt"
Date:   Mon, 15 Nov 2021 14:33:18 +0800
Message-Id: <20211115063318.14426-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/multi-pack-index.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index fb688976c4..6b2b48f4ef 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -20,8 +20,8 @@ and their offsets into multiple packfiles. It contains:
 - A list of packfile names.
 - A sorted list of object IDs.
 - A list of metadata for the ith object ID including:
-  - A value j referring to the jth packfile.
-  - An offset within the jth packfile for the object.
+  * A value j referring to the jth packfile.
+  * An offset within the jth packfile for the object.
 - If large offsets are required, we use another list of large
   offsets similar to version 2 pack-indexes.
 
-- 
2.33.1.dirty

