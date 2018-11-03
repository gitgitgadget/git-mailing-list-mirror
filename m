Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9671F453
	for <e@80x24.org>; Sat,  3 Nov 2018 05:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeKCOY2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 10:24:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35820 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKCOY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 10:24:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7-v6so2699871lfi.2
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 22:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRhLipQTdTg1TEo6+335G/XKJEymwiTWhlzrIJMbE1E=;
        b=N8Y+FX1BJXG9C5YfjzreJJLnf/mxibL+IYYT8hj6rMdk8aDMP1EFXaOejPOwf0Rag/
         7hrt5YnBzZ8atNLw5Ahl+HVAN7MHOsdUjk7SeJ9nOJCkH3jOR8orIyJE80FM9ISjtBIc
         TEyjbx7QxuqAPp6C5EVDNCfy1J3nZVFlCY4tAkJ7mNcRF+78XX8pbP+6iSobcsp1JXx9
         8ZisZq58vRnOZ7DcKfaFLdNgOxgEQPJfxHehzsa4K0PAHdKYsN8fFlWnm0MhllaLL4QE
         hoZMdIm2uw1b8ZrJi1CLhumupyxm6yuXIaP0si7fvUQQU1h3/BL3ScjxXqsfQGB+iNDF
         1YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRhLipQTdTg1TEo6+335G/XKJEymwiTWhlzrIJMbE1E=;
        b=jjgLxvhxsd5UjCzqqGNJfMzsqI42vfMhx1E0jwDTkjx3XxXW64p9o1nA3RB+zBgC4k
         J5fgcEgyUayejPbKCYDkF7xuHTlQjYxENcL65Ar/UDX/lcbmm4t6V8li74UggAKEnsR0
         f31PPFjFgrAf53jb6Ysc4KA1kpZ8G+NmLJqCGWr3STAaLRoVFcBlRjAa1afrbxxcmg2+
         OTN0afIbA8tLbmGVNnlJkONaXI1Y8b56TZWJ/Md0dodPv0R1qFt2OcQDjnt1P9QJl49E
         9hd17/VSAL1dYZi6taXAVlpV87ZeX11t/HO6KdKAvBi4HNgMpGzQz7Om16fSlJiCNVCX
         msPw==
X-Gm-Message-State: AGRZ1gIKLIFtqvLkdFpQ0n/zKPHnCvnHcyhsMZ98RhLC7deEddax7iQD
        SAGnWCVSDe5gmHsLa2ybjTqVa8aR
X-Google-Smtp-Source: AJdET5cXmf3nzVGuClWH9+CWBybzfrkjL+xLtiZfB0DKkHkRfG45oNOlDoLzvF34SF3M03WVgJBJKg==
X-Received: by 2002:a19:702:: with SMTP id 2mr5397517lfh.144.1541222064018;
        Fri, 02 Nov 2018 22:14:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x16sm2723712lff.26.2018.11.02.22.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 22:14:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] git-worktree.txt: correct linkgit command name
Date:   Sat,  3 Nov 2018 06:14:18 +0100
Message-Id: <20181103051418.13697-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noticed-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 On top of nd/per-worktree-ref-iteration

 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 9117e4fb50..69d55f1350 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -230,7 +230,7 @@ GIT_COMMON_DIR/worktrees/foo/HEAD and
 GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
 
 To access refs, it's best not to look inside GIT_DIR directly. Instead
-use commands such as linkgit:git-revparse[1] or linkgit:git-update-ref[1]
+use commands such as linkgit:git-rev-parse[1] or linkgit:git-update-ref[1]
 which will handle refs correctly.
 
 DETAILS
-- 
2.19.1.1005.gac84295441

