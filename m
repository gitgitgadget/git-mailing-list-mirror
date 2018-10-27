Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645021F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeJ0PFJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45821 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeJ0PFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so3090479ljc.12
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1DWVhdTbs7EftDOkUC6OD1jGimFf7nbLgSf+PGKnaM=;
        b=s4A/6LyGZOYKgfhWfgoPXWj5h8OI+55YpiW77PWhKk+7lbRQwCNBXx7IU41CNYDNdc
         e5V1YyUtQbxiUheOoh3jmwydyiLEpYJTdN6A+LE4tcrdU+h2gt/97b4K9rgxejJezeIJ
         w+MU0ns8uZVArlev2gB987P/VJKZMS/4VJY8WiDA0VlCRjdicAUMfWfhQqSPw0S/4g4Q
         6Cdpd/SimiCVXnTcSVaGzM6jhfMLHUyjQQ8+wOOdJgTr8v9P/z+euvpcmY3OrbSlu4JV
         wuRsR2bNQC9qbSpQAQ+SRsNM8DKcuk/OEl4HGNqNYN3eKMWkiv1h7J9eD3CeGYbJeHvn
         tB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1DWVhdTbs7EftDOkUC6OD1jGimFf7nbLgSf+PGKnaM=;
        b=iZXWz150QcpoNWzZdDyJ0QjjFH6iBaF8WlbDwqrGj9Eu8RQ9+krLWoz+QTDzE8/yXh
         MItQOG1Y0RabaaPaS4KpT3p/KRB8c+aWx/6rPVmA12LaLru5LbCU3LoHTwjfuzfKfMA3
         QWFhvZdlsJfAyv71LbNSU2wYFMa+9Ir70tJgCuP81bqOu8cY4bTje/taZcFqLhkQBEtv
         BCQ2hYHtUfBeXDbZM2hBFGQrYff4bCfURSKHmJgi9HeVfCvPQPsj1YfitzrlXQwvkIoa
         vWEJ2zOCTBHpJEnDfV/BHcm8MwTAE3KW4NCV6b5ay0AKHkv4gSN50jYVMmCYWI2d/3Oa
         XPaw==
X-Gm-Message-State: AGRZ1gKDGBDcpqNmKiVg35G1uk3AU2D4nnEFMwp09Odyx2b/6fvAaJj7
        i1MmCQymteh6iuGezUn4zS2pd+lF
X-Google-Smtp-Source: AJdET5f+gldsRIq+d8h+q/bMmCBjsMeujdcgl03ttoX2LeCOOukpUnCfa7smX4SK0nFEe2sppQic9w==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr4020669lje.81.1540621513133;
        Fri, 26 Oct 2018 23:25:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 67/78] config.txt: move stash.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:40 +0200
Message-Id: <20181027062351.30446-68-pclouds@gmail.com>
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
 Documentation/config.txt       | 10 +---------
 Documentation/config/stash.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/stash.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5e9fc20c41..aedc73f4eb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -415,15 +415,7 @@ include::config/ssh.txt[]
 
 include::config/status.txt[]
 
-stash.showPatch::
-	If this is set to true, the `git stash show` command without an
-	option will show the stash entry in patch form.  Defaults to false.
-	See description of 'show' command in linkgit:git-stash[1].
-
-stash.showStat::
-	If this is set to true, the `git stash show` command without an
-	option will show diffstat of the stash entry.  Defaults to true.
-	See description of 'show' command in linkgit:git-stash[1].
+include::config/stash.txt[]
 
 include::submodule-config.txt[]
 
diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
new file mode 100644
index 0000000000..c583d46d6b
--- /dev/null
+++ b/Documentation/config/stash.txt
@@ -0,0 +1,9 @@
+stash.showPatch::
+	If this is set to true, the `git stash show` command without an
+	option will show the stash entry in patch form.  Defaults to false.
+	See description of 'show' command in linkgit:git-stash[1].
+
+stash.showStat::
+	If this is set to true, the `git stash show` command without an
+	option will show diffstat of the stash entry.  Defaults to true.
+	See description of 'show' command in linkgit:git-stash[1].
-- 
2.19.1.647.g708186aaf9

