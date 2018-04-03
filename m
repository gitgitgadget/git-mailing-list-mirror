Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131251F404
	for <e@80x24.org>; Tue,  3 Apr 2018 17:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeDCRaT (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 13:30:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39899 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeDCRaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 13:30:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id f125so36693575wme.4
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrbIEyzYsnTUFE91DRu3oqvYR7T7jViP09v/mUdGpC0=;
        b=Dzxs/+TSnU2D6t43TAOXVLnX5FlSLwDH1Q5b74h9Hs+cejDGvflgkTNKw+einFl3hm
         PfITub43XnBNkWsYMm5iEV8fsKh0KiL8cds4weP/h9sjSDTxQWwpRPy2aJORT8/2PpH1
         XPXhXc72IOijw4B0ytKxfljccgGZcB/9EaNXUqLbsPB7Dgwc2MiOi3UPcujB9YZ/TakQ
         S9CQHZFxfA/vMq/FEGMvaKj1oUG5RL+KwPOncNbVAfZy8WvdoPimrnwEqvgLVN0HPxS5
         rEcPNU0QdlvuwWm+mnzW7D1efKkJ5r47i16EqHZQAYu8I9Ka8DUirChuyomRV2IzCAD2
         G+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrbIEyzYsnTUFE91DRu3oqvYR7T7jViP09v/mUdGpC0=;
        b=ENa/Dl382MSVVnwg/tR4jqHYDKQBs6JDG2it0vDPjD1kvi3m0KDSghQfzfP+UredBZ
         OH5VoQuxPhkWa3LLdyIMWVPTFyWj4YDxbMjFbue0xqBKVqwM8cejeVYnBuSfR/oO8D6Y
         T0plj/VUWrPta7fa8SW2HSSAVJZW/6p4R/br6zGCpIAOeQyM6U4SlKIyz9Lro2qK98FR
         QyqIkVu1QmW9iyH0RBd9XDLLzsKwhjzR0u4wSRijb+7f3ooVkqwLr1johYsY1e9Kuz72
         mF5GClxiajduOauKpU8uEQ9BCtQ3G64lprCzc40raRvDOIrrbK98w74LfPq5f+sGn+mc
         zqIw==
X-Gm-Message-State: AElRT7FY+O0Wcib15TE0iExic9oKfxtNsk4uw9tsKH8ZdaobdefxAE8V
        rmDJsMxEN9Cnyb/2KEoIlbY=
X-Google-Smtp-Source: AIpwx4996WHCdfOmEHKOZsDTyKNJ2TU96jExfacrTTavuve79pa+d26j1mk7PD3x/2IOOblzcwECpQ==
X-Received: by 10.80.163.177 with SMTP id s46mr17454924edb.271.1522776617868;
        Tue, 03 Apr 2018 10:30:17 -0700 (PDT)
Received: from localhost (cable-94-139-5-172.cust.telecolumbus.net. [94.139.5.172])
        by smtp.gmail.com with ESMTPSA id d18sm2344887edb.68.2018.04.03.10.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 10:30:16 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: TEAMS: remove inactive de team members
Date:   Tue,  3 Apr 2018 19:30:14 +0200
Message-Id: <20180403173014.4844-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your contributions!

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/TEAMS | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/po/TEAMS b/po/TEAMS
index 065771cfe..762879550 100644
--- a/po/TEAMS
+++ b/po/TEAMS
@@ -13,12 +13,8 @@ Members:	Alex Henrie <alexhenrie24@gmail.com>
 Language:	de (German)
 Repository:	https://github.com/ralfth/git-po-de
 Leader:		Ralf Thielow <ralf.thielow@gmail.com>
-Members:	Thomas Rast <tr@thomasrast.ch>
-		Jan Krüger <jk@jk.gs>
-		Christian Stimming <stimming@tuhh.de>
+Members:	Matthias Rüster <matthias.ruester@gmail.com>
 		Phillip Szelat <phillip.szelat@gmail.com>
-		Matthias Rüster <matthias.ruester@gmail.com>
-		Magnus Görlitz <magnus.goerlitz@googlemail.com>
 
 Language:	es (Spanish)
 Repository:	https://github.com/ChrisADR/git-po
-- 
2.17.0.484.g0c8726318

