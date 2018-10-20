Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED661F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJTUt2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40825 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeJTUt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so33086207ljr.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIauzukfnhacbmfz6JWPibbV9XMllbqB5RfI/vMeMqI=;
        b=lBIzvY4p9sfVjRgtWOn/nyHeZDEWaKHeFs4I2TaX697Wrpc4Ptt3gSLsl5LmrB0x2B
         G+I/q1d/lcoAHCrjqBvw/3Cm5IeRX5NPPkErSaoGXsG4tND0KliqpJLpuqsggD5PndIP
         SAIqnnhr2gnnkkJ79c5ataLgNuHgdvofIM9C7RWQOVBCFAUVMgeYkNLS1jkClRngwd9N
         erJZ8AJw6k0qwr3g1VP4ZJeM7RFwH0dk+W3UVcID6IiamLO48Hv8YvJeSOkPGY6oMWGs
         Z60LkIv0kEf5k7gw5RYjHaW25BPYYbKpVuJIV+AqNHKiSCZZE3w03/RqyJo+qlh4KAu1
         AEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIauzukfnhacbmfz6JWPibbV9XMllbqB5RfI/vMeMqI=;
        b=UOrgRsK4EIwt6BI/FeA4G91uhuX/4TCxmW8tDXuToBoVt8jMfiOM6VlHzdFINAuUBS
         ShV7BW7LCvvjos0myzpQFA8AvBww4R3LNTmK1dBB+HlLzyO1NYOv0IVu7a+JNmfWfKG6
         x6gr2T30MDg8Rdwaht9dIkebjLPQW+psZ28Rp52pjIFapqbkgvsNbeIpld6tB9rq6Qvp
         9GEXZYwW06ozsWjKt1SxzffzNrfOXjKxQgJ4hLtLY4UFjazSo0RQYz0HVPLbMLnXfBDd
         ygD81MPdv6h0USoIeK+EKrTkN+2V5WQv1bzRjMrrUow2xhZbdDHwDFh4CFTMvSJQU2ws
         jadA==
X-Gm-Message-State: ABuFfoiG0b2u0bSkyW9NGbJ/sQkMG90ZA68EB8hec4WDjmxbmILLC72b
        sygnTTtsiq5EY1ih+T0V6jVi8M5R
X-Google-Smtp-Source: ACcGV60r7W+4XAtlnGY/po7Ifb0YY6EqzRi6o9qhrAobOqCoXKuY5Pw8NbxB0mgm5c++Tmbsq1iG9Q==
X-Received: by 2002:a2e:8146:: with SMTP id t6-v6mr25366170ljg.32.1540039144273;
        Sat, 20 Oct 2018 05:39:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/59] config.txt: move blame.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:56 +0200
Message-Id: <20181020123848.2785-8-pclouds@gmail.com>
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
 Documentation/blame-config.txt | 21 +++++++++++++++++++++
 Documentation/config.txt       | 22 +---------------------
 2 files changed, 22 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/blame-config.txt

diff --git a/Documentation/blame-config.txt b/Documentation/blame-config.txt
new file mode 100644
index 0000000000..67b5c1d1e0
--- /dev/null
+++ b/Documentation/blame-config.txt
@@ -0,0 +1,21 @@
+blame.blankBoundary::
+	Show blank commit object name for boundary commits in
+	linkgit:git-blame[1]. This option defaults to false.
+
+blame.coloring::
+	This determines the coloring scheme to be applied to blame
+	output. It can be 'repeatedLines', 'highlightRecent',
+	or 'none' which is the default.
+
+blame.date::
+	Specifies the format used to output dates in linkgit:git-blame[1].
+	If unset the iso format is used. For supported values,
+	see the discussion of the `--date` option at linkgit:git-log[1].
+
+blame.showEmail::
+	Show the author email instead of author name in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.showRoot::
+	Do not treat root commits as boundaries in linkgit:git-blame[1].
+	This option defaults to false.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index db259129b0..910dcf1c25 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -299,27 +299,7 @@ include::am-config.txt[]
 
 include::apply-config.txt[]
 
-blame.blankBoundary::
-	Show blank commit object name for boundary commits in
-	linkgit:git-blame[1]. This option defaults to false.
-
-blame.coloring::
-	This determines the coloring scheme to be applied to blame
-	output. It can be 'repeatedLines', 'highlightRecent',
-	or 'none' which is the default.
-
-blame.date::
-	Specifies the format used to output dates in linkgit:git-blame[1].
-	If unset the iso format is used. For supported values,
-	see the discussion of the `--date` option at linkgit:git-log[1].
-
-blame.showEmail::
-	Show the author email instead of author name in linkgit:git-blame[1].
-	This option defaults to false.
-
-blame.showRoot::
-	Do not treat root commits as boundaries in linkgit:git-blame[1].
-	This option defaults to false.
+include::blame-config.txt[]
 
 branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
-- 
2.19.1.647.g708186aaf9

