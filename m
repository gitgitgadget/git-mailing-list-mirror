Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC432C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C8C60F5B
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhKOGsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhKOGr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 01:47:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02803C061766
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 22:45:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so12195768pju.3
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOe7LOMSKw5/fdUcCPLEpJ5LLl+fChSONdkH1qBYj44=;
        b=qsfhhuS4rtJas/4aNwGAoqQtNA12k1k2+kcDhfgr5zu08DLvPIP8z4mlSDyQaVonhz
         AapLqTG5BUE3qSkFB6BJXNFg3nltfOIT3WBdH9pzcWrf1YBqTTA3oHSzBmr9GKD08asb
         ckoQ9tuiAnrS+blaid51MViPh7HjqXfvWLG3swCg3tUj/F95wo2s0OFMHtntPWYMWSj+
         S9FSFXbXqa82kOuqHTHNnTvu3l/eh2KZumtAGICqt8qCqbIJWVwepMoDuUTZiV5pBKAO
         469eEWx6idw17LodEacpgdNwicnK201y/d6xdFtOEnnHN/B5kQQ+YPmSInbYlfiNnqZT
         5lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOe7LOMSKw5/fdUcCPLEpJ5LLl+fChSONdkH1qBYj44=;
        b=Xd2qvQ353+1y1QEu2iOC7c25pNVGVJoLdLNaZ9OcIk6ZZ0M2YRf0jjwGxZxDLdAPyn
         ke3mwxaqrRX6aHEAuj+G+583X2o/Ym1JszM19cbGBFeVNbiMXm1EbHtYdu5Onv/tQnha
         NzcAl7ai3QemQm6z5LO507CzBKIkgB+3CoKhf26SnswoepOw27XzIn+4bkzoOkT4YElp
         iixy+QxIhGo2NipD9Cow+HIh2Zuarkd5HsgpN8x+5uzKLeMkDPhCQcF7bgbzhTtNxKwL
         ljP+B6dkMHHongYU4ee/rYCwWk1KCxd4eT/+KwCmtEE/dvl8jz4jylul9Rvfwl6A7iIh
         LI3w==
X-Gm-Message-State: AOAM530OCj8or/9e0AByxZrjj5jllCDvKIQ7XajU4ETuwxyhgSgGhOkZ
        t26JPVNQRNOGQlLUUzW29evIfX5nWAaX+w==
X-Google-Smtp-Source: ABdhPJxkPtmYhGDGMdooMYbNfXSCJj/2vdARf+Um6p2u+nGhmGZaqW4EYovtCN3X4RJEGYcWb60oJQ==
X-Received: by 2002:a17:902:f691:b0:142:2f7a:308e with SMTP id l17-20020a170902f69100b001422f7a308emr32485306plg.19.1636958700199;
        Sun, 14 Nov 2021 22:45:00 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id lw1sm18361922pjb.38.2021.11.14.22.44.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 22:44:59 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tanoku@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH] pack-bitmap.c: remove redundant SP in comments
Date:   Mon, 15 Nov 2021 14:44:44 +0800
Message-Id: <20211115064444.15523-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d999616c9e..5c4c09655e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -53,7 +53,7 @@ struct bitmap_index {
 	/*
 	 * Type indexes.
 	 *
-	 * Each bitmap marks which objects in the packfile  are of the given
+	 * Each bitmap marks which objects in the packfile are of the given
 	 * type. This provides type information when yielding the objects from
 	 * the packfile during a walk, which allows for better delta bases.
 	 */
-- 
2.33.1.dirty

