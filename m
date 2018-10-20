Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE641F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeJTUuM (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36459 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJTUuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id l1-v6so7359293lfc.3
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5rsne6amo62+etPNbiXJZoWBUZpPcXUqOElssLrFfYg=;
        b=G2wwZ0iJxInbJJH19kfGZxU9AmmLtenTWWxQn73CGnwHZZknlzYBoPHy2GxNbT9PiA
         IAi7r9oaukx30c8cAZpVHnHGMmgMIcb9tewNzGRHnMIPosbVSowTX5q01w9/s1bnU9UG
         fM/gasY4jy3LvayPhwQdEgTjQy0IY0zwjvF/oEVgEhdKO9NaUaO5ZsY7ssLNBg41Yt06
         p65qoVdyi8pwlbtNA8rziXy4Wc1AZrlyDnPJC54Z1w+ZSxTw4bx1OxEMh7DAbVZnNr4u
         pi/Zo3qm99KgWIl0aJqjikjy8qlKncHW/y3uiYrar6H0yEML/u1dkm9hIJls7tt1b1y7
         IV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rsne6amo62+etPNbiXJZoWBUZpPcXUqOElssLrFfYg=;
        b=EU5uXoieOxiRRe5zEUfUUlukj+XzZuz1E9k37ev9H3jIZhC7b3X71b5ZmixMTQ6PLS
         BhSQbCbiFJtRhPoTZK09Ym6kZojfmUpWRFK0M87InLVAd4/aLNDxaeEZQFcwoAPGkMRO
         RlzOqSYaBAIrVnGkeiIaQkhnFNXW5QrjHdxw54pgl2mRzwwE3uZ7QSUIxZo7f6coyUK0
         CEYmQQIeSpqV6uRXSLSbMd+I7D+O9j/UxAgVOzJwdqP/psVq+evazm1FqWfviGhcZNwj
         HgMAoxEMSWvzQOdQ5TBQOgROJm5UKecSJLtjBIccciL08L79ywVsioeamsQBo/TpSCFh
         DKmQ==
X-Gm-Message-State: ABuFfoiiXy0f6RO3ZqhpFmVcoBROv4dVH/h4qqnNxNDDiCV+eBoVMPxp
        G8WTV7f/qaER0Nogo/aZqXLYp0jT
X-Google-Smtp-Source: ACcGV617SzxbflyajdP+ZQ15XP8j5w9G/EqJc3dhPo2JEX+8PZoWES/ZR2z0Io/1ItBj8tQtEcEveg==
X-Received: by 2002:a19:f89:: with SMTP id 9mr5247419lfp.10.1540039189832;
        Sat, 20 Oct 2018 05:39:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 34/59] config.txt: move mailinfo.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:23 +0200
Message-Id: <20181020123848.2785-35-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt          | 7 +------
 Documentation/mailinfo-config.txt | 6 ++++++
 2 files changed, 7 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/mailinfo-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8d9423beca..ca178e2651 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -616,12 +616,7 @@ include::interactive-config.txt[]
 
 include::log-config.txt[]
 
-mailinfo.scissors::
-	If true, makes linkgit:git-mailinfo[1] (and therefore
-	linkgit:git-am[1]) act by default as if the --scissors option
-	was provided on the command-line. When active, this features
-	removes everything from the message body before a scissors
-	line (i.e. consisting mainly of ">8", "8<" and "-").
+include::mailinfo-config.txt[]
 
 mailmap.file::
 	The location of an augmenting mailmap file. The default
diff --git a/Documentation/mailinfo-config.txt b/Documentation/mailinfo-config.txt
new file mode 100644
index 0000000000..3854d4ae37
--- /dev/null
+++ b/Documentation/mailinfo-config.txt
@@ -0,0 +1,6 @@
+mailinfo.scissors::
+	If true, makes linkgit:git-mailinfo[1] (and therefore
+	linkgit:git-am[1]) act by default as if the --scissors option
+	was provided on the command-line. When active, this features
+	removes everything from the message body before a scissors
+	line (i.e. consisting mainly of ">8", "8<" and "-").
-- 
2.19.1.647.g708186aaf9

