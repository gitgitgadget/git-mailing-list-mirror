Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8B81F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeJ0PEp (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42947 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PEo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id f3-v6so3106475ljk.9
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnutxFTPztpuDxLWY4Pw6IBjznFL6q3e38gmIB5TEno=;
        b=mojxbsaJ7sR6friWBvDdjZ5fQaoVHHGtHRueOc2CiuT0/JtA2GFc8wc0knjVE53lBI
         NvyC/IXcBbo6L/ZZVCM6TLRWswV3ZZuQ/RCpfI2HNDsMIFLEifwTWm4iRo0adWEkZN2W
         gHGSdXE6A5Ilz5wlUToOTCn2eljOInQAxczI2l5XFssf/rLXRAWdx3ixKYGQlpGaIgVg
         DFvo9S6ellhJ5Q5EdR2YPxgP90Rn+958NoCtnsu4qt33e4QAX6DKfRFRJdmmR7MBz90q
         O5Xgk7pDdo3g1D1xr5ZbtjUVxtptq6D6EsHDKF8k0LQTRQZt2h+uwpq09tDOVVzh5eTZ
         JH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnutxFTPztpuDxLWY4Pw6IBjznFL6q3e38gmIB5TEno=;
        b=koSOvvy3ZkPCxH5iZzZmMtlXawah0p8DTCrfQSr30KMTwIVyCtlwb+CHrXbg37uaAP
         CV8G3zHzQauo2StEoapdjA6gjk3NjG14Yr86RkSpOg2MbPJQCyBmg4iP3WR8Yu7siSNz
         /EgzccVvn69tMXUSMhQfWzAwvBgZ815KDHRSCSYETymjKvPUCy76dzdL95DHbVnfQu/e
         7tct7LLw8wsPK/aL1LfVin+/c+yuM8kVT/lyFQqPKDRKazbjSeDN/5KDGthMid/4fzRL
         72/JvuZiTQ8IllmGbk+5bpoN7gEXrd4dAoGLeXTHDonUNIFy/8JhndImYKTDdrfaTg3n
         7DSQ==
X-Gm-Message-State: AGRZ1gLFEtTR6DcUGeUyfOECQoRIr6yfSnKW1aIEpgb5BK2AWTHiQxfl
        VBgjlCtJfBsNKf1mwtLykF1axITc
X-Google-Smtp-Source: AJdET5d7KpKd/+iFzmYGQ8CGwZ088AwsyavytbyeYRjc8yCoF4KFT1gbHNCCZYoqVnB/MSOhadU7Hw==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr4177557lji.144.1540621488746;
        Fri, 26 Oct 2018 23:24:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 45/78] config.txt: move man.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:18 +0200
Message-Id: <20181027062351.30446-46-pclouds@gmail.com>
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
 Documentation/config.txt     | 13 +------------
 Documentation/config/man.txt | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/config/man.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff9c8797a6..c3c92bc269 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -369,18 +369,7 @@ include::config/mailinfo.txt[]
 
 include::config/mailmap.txt[]
 
-man.viewer::
-	Specify the programs that may be used to display help in the
-	'man' format. See linkgit:git-help[1].
-
-man.<tool>.cmd::
-	Specify the command to invoke the specified man viewer. The
-	specified command is evaluated in shell with the man page
-	passed as argument. (See linkgit:git-help[1].)
-
-man.<tool>.path::
-	Override the path for the given tool that may be used to
-	display help in the 'man' format. See linkgit:git-help[1].
+include::config/man.txt[]
 
 include::merge-config.txt[]
 
diff --git a/Documentation/config/man.txt b/Documentation/config/man.txt
new file mode 100644
index 0000000000..a727d987a8
--- /dev/null
+++ b/Documentation/config/man.txt
@@ -0,0 +1,12 @@
+man.viewer::
+	Specify the programs that may be used to display help in the
+	'man' format. See linkgit:git-help[1].
+
+man.<tool>.cmd::
+	Specify the command to invoke the specified man viewer. The
+	specified command is evaluated in shell with the man page
+	passed as argument. (See linkgit:git-help[1].)
+
+man.<tool>.path::
+	Override the path for the given tool that may be used to
+	display help in the 'man' format. See linkgit:git-help[1].
-- 
2.19.1.647.g708186aaf9

