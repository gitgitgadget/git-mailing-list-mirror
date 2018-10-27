Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC0C1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeJ0PEG (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35004 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeJ0PEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id o14-v6so3123182ljj.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6O7CjRSTiAGDw93L0z/CG/RNhdSqIUTfhxPWifkud0=;
        b=WycLQnjMTHzcUWMmqYM9PDOfbQrFePfqs5frJQeix8LlK4choKsqX41spzDsWWgdPy
         jBZCPThUfl5lZWvP78rSxvd9X1Nxsm9yERv+KmRD7Q6ytxHWIu3i2pTHDV5v3eqbRH27
         MgFqHYLZLEbs5kHU9Ll7kxX2J0vB1EZ8Lq+6yJGb8dqAk+KOtexQzh95PgRJEM27MDwL
         QpABio/29PFMabWckCiI94zdk8VSm/BIDSDqZ8/RpRnJaDNPFjRrvpn/n42Lpes2xScI
         HTVOmAV3xOorbwU4Po59pffucsXPauZcn7zXaXaItV2IAyMbPWuIu3q8P2Gsnw91EnC0
         gk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6O7CjRSTiAGDw93L0z/CG/RNhdSqIUTfhxPWifkud0=;
        b=P+c7QQiQ0R5yHL/t1QlId8hRwdAhnVjYT0HkUA5Slgux4i63at0pZ4A41MJUOb0p8n
         MYoguIsQ2yOiMCvbyTyMl43AOsqxWAfz02ae0+bmr9VxN+rqjSu7mBHqyGagfXdVC7P2
         c0nw7OLZ5WIQr75ZF/46KOeo60uQql3AVA9FumTJGnTyLrfKFKY49ubwanOgOBQKUNNv
         t5m73EJAu6BUyRNhyvFX+o9XOjWsg6RyTKY4yGf2ZiGxhVc27yV3bqHtCbnPaEm+zEio
         g+Tu26bILkOfWjX8wZtS53TU2cqkP6vHC5TJZbY0cIdPQtbDkv7pQ19crNoXTJF95axZ
         Dt8Q==
X-Gm-Message-State: AGRZ1gIkD99YLbcRkDhchz/CqNYmsukmgS2VNkqWsuugf65hiy0FUKBJ
        piAxCrRjzcahF8/+vwajfHh5HWHN
X-Google-Smtp-Source: AJdET5fdUfQOFw7XgtnXTpanYULc3XQ72ySbOSF3VXApE7lMEoLsVmAWl6vkrfsaGerztKIZ9ntgHw==
X-Received: by 2002:a2e:809a:: with SMTP id i26-v6mr2119895ljg.100.1540621449572;
        Fri, 26 Oct 2018 23:24:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/78] config.txt: move clean.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:45 +0200
Message-Id: <20181027062351.30446-13-pclouds@gmail.com>
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
 Documentation/config.txt       | 4 +---
 Documentation/config/clean.txt | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/clean.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a473ddc3c3..b5efac8cc5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -307,9 +307,7 @@ include::config/browser.txt[]
 
 include::config/checkout.txt[]
 
-clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f,
-	-i or -n.   Defaults to true.
+include::config/clean.txt[]
 
 color.advice::
 	A boolean to enable/disable color in hints (e.g. when a push
diff --git a/Documentation/config/clean.txt b/Documentation/config/clean.txt
new file mode 100644
index 0000000000..a807c925b9
--- /dev/null
+++ b/Documentation/config/clean.txt
@@ -0,0 +1,3 @@
+clean.requireForce::
+	A boolean to make git-clean do nothing unless given -f,
+	-i or -n.   Defaults to true.
-- 
2.19.1.647.g708186aaf9

