Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676061F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeJ0PES (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43521 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbeJ0PES (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id u18so2472915lff.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkmNsLywQvc6NV5uIoPjysMpop1iRJQCdovCxQMyAOg=;
        b=PPEROrXKrU0hxKCBOSEFij56lTeKudDjOtypo55rZbZzV2cae1JX8tRpbcgoxgfKaM
         HrZ3E6c/SIcASyr3FdwXwPPNdtsC3685/xt2g74L4wAQ7sPKi+r8Uhcipa1qJDoMG7gY
         17Izk2sWh5S7crwkuV/9CxRwHlY4LWCoqcYg30w368Al+vm9VZde/MjoaeMBN9vvmm2U
         5fLC1/SDOKqgse482qoR1Dy/W6Je9cBG95lzoRJQfe+lRWqmQjHp+cfo7CZg6A7mef1x
         WXw6kSMrFUpL5F39mS/PJOS/Yu8YrpPtXSjEYiUj7JRmocNjsyrIiFCQ8Ar8X70APgxF
         Bhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkmNsLywQvc6NV5uIoPjysMpop1iRJQCdovCxQMyAOg=;
        b=nJ1JYBmvovX0XRDVJlF4uIN6kCQzTlp5YovG6cAP00OJH20fnHT579R5EvGHyKMnqD
         oLTDmxUFRYB6mM42U9KGwP4d8DuMcSy0/gVwupw93c10+thj7ojX24e9v7DBo0aOjBh2
         SMiFT5746lxcYb2/x/0Pb0I2hlepp/bcXGQsTGUKLPgaOAOU06IY1OM+zU7z/ItzjKvK
         Zzt/LtfTfRxgMCxAy3PqoaWNwFhtpvkI4NlF8Q1OwP59/LnOZWwvEjV2atJm0eHXUU93
         v5LfF1DVn18t4necqA2OnlK0+Qp0n4SAlpnvoyNvcwDzclo4yHFrkKuqCdZYTldmfc04
         TvuQ==
X-Gm-Message-State: AGRZ1gLvyIG62SccpmtTOGyAURZ9r1Kz7Yw3e/joeq2Hk0XCrb0WgBPV
        r65MdICsObyv+HOwtdfP0De+FGhp
X-Google-Smtp-Source: AJdET5fDC+fG4WUnUJO37u/ajdwJq7NooHxq4JU/WNgyZNWFXJaOhjMjP82p1uWuhgIo9mmkGjioZA==
X-Received: by 2002:a19:5402:: with SMTP id i2mr3706695lfb.128.1540621462598;
        Fri, 26 Oct 2018 23:24:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/78] config.txt: move filter.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:55 +0200
Message-Id: <20181027062351.30446-23-pclouds@gmail.com>
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
 Documentation/config.txt        | 10 +---------
 Documentation/config/filter.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/filter.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f85014f803..a225dc530f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -329,15 +329,7 @@ include::config/fetch.txt[]
 
 include::format-config.txt[]
 
-filter.<driver>.clean::
-	The command which is used to convert the content of a worktree
-	file to a blob upon checkin.  See linkgit:gitattributes[5] for
-	details.
-
-filter.<driver>.smudge::
-	The command which is used to convert the content of a blob
-	object to a worktree file upon checkout.  See
-	linkgit:gitattributes[5] for details.
+include::config/filter.txt[]
 
 fsck.<msg-id>::
 	During fsck git may find issues with legacy data which
diff --git a/Documentation/config/filter.txt b/Documentation/config/filter.txt
new file mode 100644
index 0000000000..90dfe0ba5a
--- /dev/null
+++ b/Documentation/config/filter.txt
@@ -0,0 +1,9 @@
+filter.<driver>.clean::
+	The command which is used to convert the content of a worktree
+	file to a blob upon checkin.  See linkgit:gitattributes[5] for
+	details.
+
+filter.<driver>.smudge::
+	The command which is used to convert the content of a blob
+	object to a worktree file upon checkout.  See
+	linkgit:gitattributes[5] for details.
-- 
2.19.1.647.g708186aaf9

