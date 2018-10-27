Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CBF1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeJ0PFG (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41813 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeJ0PFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so3100948lja.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2YUnGPIkbWa0q009C75PtprE9UNT4Ovxf+EaXt4Yi0=;
        b=pGYf2WQnVKLcUYKSg2AM1glgugjAfheu9y0pkEg9UGcOqGWJvxZvJvSUBio0G7ngOB
         LOMo15qyWqzLBTuRzPB/OqhqVH5U/+C6MWbMkg84J+OlqEcZMLPjh51xKboHKpATPsFH
         ceLktuJ/IXzmfb6OyIERFNTK79TMqwsVaxV05l2OWe2O/qN3cH1afIV3x68xJ9VQ7liw
         aBBNQm8BXL8i8m9r14JQgVkSMwVWA+YWfdK+hCoks63HzD0ylcFIHCdVKk972uUvWEvt
         0WHMz3vgP4vkZp8kNqzGvTVbqnRvD0q4y2xz9aAkp/xnv960f9wUperajQCJKg0KpRYI
         ZOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2YUnGPIkbWa0q009C75PtprE9UNT4Ovxf+EaXt4Yi0=;
        b=Y/JUZZc5+LlM31DxnKz1cvvVQc03bQNudGxkfgAvfWQflKq+5rvT0bcVWpzROJVITg
         jN+d/yoqQbSG99K32QBKopgswyzpC/AH72i6RDzSF22oxMRwmTos5giBJENx7OtNQjXE
         0CxgAjr7eo37xS2za1hcOjejpPsJtoZwy1sRcBR2+aC3jOFv3+zvVbEyUNha+o/Yl1iS
         joWzPa960/e0Br+pMFQECOZJ0nw41C8+VYwHjO413WcrQDXKHsxlOPTY6H+MAeUIt378
         HAZFTChT/8KAZaqmPRLewQmZg8BjMb0xJWe01bWk0V+30lpfcp+nP+ESmNq1yw4FRxE5
         VYMw==
X-Gm-Message-State: AGRZ1gJLzsDiJBSE/R83ukzIfbKyF4HjnjRMFvy/L+gsByrRxY4r9i2J
        7ze3+0rBsShmO9MV7XlnAovCQWBh
X-Google-Smtp-Source: AJdET5eV7SXapuM0LEMTyT5cKskT+w0ZPZulciYBo9RUE6GT1EQkLv97FoTm6m9GxryVP/WKjqmlkA==
X-Received: by 2002:a2e:529d:: with SMTP id n29-v6mr4112169lje.54.1540621509682;
        Fri, 26 Oct 2018 23:25:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 64/78] config.txt: move showBranch.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:37 +0200
Message-Id: <20181027062351.30446-65-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt            | 4 +---
 Documentation/config/showbranch.txt | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/showbranch.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab504eaba2..56cfe3e857 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -407,9 +407,7 @@ include::config/sendemail.txt[]
 
 include::config/sequencer.txt[]
 
-showBranch.default::
-	The default set of branches for linkgit:git-show-branch[1].
-	See linkgit:git-show-branch[1].
+include::config/showbranch.txt[]
 
 splitIndex.maxPercentChange::
 	When the split index feature is used, this specifies the
diff --git a/Documentation/config/showbranch.txt b/Documentation/config/showbranch.txt
new file mode 100644
index 0000000000..e79ecd9ee9
--- /dev/null
+++ b/Documentation/config/showbranch.txt
@@ -0,0 +1,3 @@
+showBranch.default::
+	The default set of branches for linkgit:git-show-branch[1].
+	See linkgit:git-show-branch[1].
-- 
2.19.1.647.g708186aaf9

