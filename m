Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C371F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJTUuG (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40863 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbeJTUuE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id r83-v6so33087031ljr.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o63APg7EZKXH+AvNp27WhscBQoDdXKSOyP3CVKuPLs8=;
        b=CzAgdk416QNPzNca+O43fKoDKnxALEU6r8x76WDA0E4cDGXm2DUVNhMFBVqn8ZpEiz
         XCzllWhvp2vg5VM3o9dLGQL69Y+x8IBezFixhoCOhtxet6IwyXMyuLcsbU3pT5JiVipE
         b0f8pdzdXiuo8gmThTISmvZ2tp0J+vjHphZuHMg7eYG7jpvYysz5hKcZmyAYUPziStOi
         JeZvxbumeUEbv2mJoqQeep/AQ3cwiQDMJD8sdUwOxOwsY8DRNpG2yGabJlxzFlvnjI/j
         4Jc2G/LbEYs2XLPeIGabfJkzTBgrKYNBpRS7uazYaMFZvtxNmLKphmf5NKtFVeGZLT3u
         60bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o63APg7EZKXH+AvNp27WhscBQoDdXKSOyP3CVKuPLs8=;
        b=O5Pa7gUqU1UeCzoXeBd4ichBysd6efDP0sjvaWuUHgd6/dmJuEDn+AC2doHHo8oKbd
         hCtddki3U53XOv4HE1WnUggzpY6Wz+qSljozeWvdxHm+H9DghMD2fa/5y3XIJ7dopFD4
         IVtslXgIpkGLpFhEzi2wnYv80Tp3D6K9/gv+AoGqbeAf0wlMl8s4GzobROSSZLpR4wxJ
         +yJXVg0dxxLPiZ3OUJetcCmbWg1YxcAQqF23y9wQ+1P+0sHgdJ0bY1MO93gJiWwfT/Pg
         pJeolROVEtwveoFUNMXTTvKOty04fqUQFhxS6tzdgaXPXHZGKivMBVKfyOUyRH4wjMZw
         XrcQ==
X-Gm-Message-State: ABuFfog27lMphs8XtWbbwRLl48By+n7zA5PEMNAcRdnZlvLawCTTthSp
        J+ysAGnBjt+49PmIiLab4LYeXpbf
X-Google-Smtp-Source: ACcGV62pI1GN/IiVUkE4t4E8lR60EQgpGwfd1q8kpjCB8gSY6d+p9EnUv4WFYIkbtJTChlZqWTGN9A==
X-Received: by 2002:a2e:8184:: with SMTP id e4-v6mr22460677ljg.138.1540039182316;
        Sat, 20 Oct 2018 05:39:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/59] config.txt: move init.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:19 +0200
Message-Id: <20181020123848.2785-31-pclouds@gmail.com>
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
 Documentation/config.txt      | 4 +---
 Documentation/init-config.txt | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/init-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5ba7975837..c91dc2ceef 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -608,9 +608,7 @@ imap::
 
 include::index-config.txt[]
 
-init.templateDir::
-	Specify the directory from which templates will be copied.
-	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+include::init-config.txt[]
 
 instaweb.browser::
 	Specify the program that will be used to browse your working
diff --git a/Documentation/init-config.txt b/Documentation/init-config.txt
new file mode 100644
index 0000000000..46fa8c6a08
--- /dev/null
+++ b/Documentation/init-config.txt
@@ -0,0 +1,3 @@
+init.templateDir::
+	Specify the directory from which templates will be copied.
+	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
-- 
2.19.1.647.g708186aaf9

