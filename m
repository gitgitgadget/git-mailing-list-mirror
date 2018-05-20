Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261741F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeETSky (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40779 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeETSke (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id u140-v6so8493310lff.7
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qyeYV5fWuyisDlL7IEUatsvILGYsiM1HSSjbFZdDBs=;
        b=jpn6J64AhDMyUQSssBh5CbZFA9GXlt7SE7IQOAyLuD2fR17qYln/veGm5LOYTmjyQ0
         Gby8FvtF8V7wV9HuBRfOm93uMJ6ont4a6IrftbMIXrOwzciabwJ7/Hw1Vb4LRVlO5NNi
         qc4qUY95RGUkob6HpW2ggaSwwZ5zxcKsglWrRiOTmnoEPVajt1DhHuWwd2RGTNJ3FoCQ
         erj8s9fC45zmd6u/rkf6W0rYyzbnFTdGGoHke0CiQgvmuKA4s1rcBzqTTyNer3ZASSnM
         ClBHr26hlc2fipb4U5O3dA1Qz1IEly3c+M4ApN+sgpFQ8D3mZVRhreT15F1/WksmPxbL
         uNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qyeYV5fWuyisDlL7IEUatsvILGYsiM1HSSjbFZdDBs=;
        b=GwW0h67dpnsvBAWVXTDO1+bmiVRTXhhHnkXAjAAaElhIGsxcRankAymsAFEYr9Iv+0
         PMGD/Q7uGO3+yq5u/TSkuA68VnJN5mMfNlKzILgI/OPznHh0OIsRzcscraG7u9YEJI9X
         m45pR5RppwBljAK4mmDMd4VXTdB8GeI83tckjmm1zt+JnuKM2bfxbw9/YSE6HYBFN59c
         dAai/4WZGmwV7TuhA4qOeIhrrYj4BOeczXPBaAHKFumVnzSbDQsiRdGmFzvHqS2b8Sym
         CBe2UCw41zsTpFlQUjzJXtCrnwPTObOel0tjcfFFisolNWAqCm28nVer6MQDdvspaYo2
         2/sQ==
X-Gm-Message-State: ALKqPwdKPHDjtsTWUllXuqx1qLhIReaGZHBCtOcAzf6gHHK4pJ2QZYUQ
        qg+OORWTJ+V8luM4zvvxFqunSw==
X-Google-Smtp-Source: AB8JxZrcFJpM8r5jONy5BtyLh4ChhxU4ft97/JIelTI2SgfAED7D3HU5vRWffO8irJPknZRW4w8gTA==
X-Received: by 2002:a19:4f4c:: with SMTP id a12-v6mr25183914lfk.97.1526841632622;
        Sun, 20 May 2018 11:40:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 11/17] command-list.txt: documentation and guide line
Date:   Sun, 20 May 2018 20:40:03 +0200
Message-Id: <20180520184009.976-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is intended to help anybody who needs to update command-list.txt.
It gives a brief introduction of all attributes a command can take.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 command-list.txt | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/command-list.txt b/command-list.txt
index 99ddc231c1..a2f360eab9 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,48 @@
+# Command classification list
+# ---------------------------
+# All supported commands, builtin or external, must be described in
+# here. This info is used to list commands in various places. Each
+# command is on one line followed by one or more attributes.
+#
+# The first attribute group is mandatory and indicates the command
+# type. This group includes:
+#
+#   mainporcelain
+#   ancillarymanipulators
+#   ancillaryinterrogators
+#   foreignscminterface
+#   plumbingmanipulators
+#   plumbinginterrogators
+#   synchingrepositories
+#   synchelpers
+#   purehelpers
+#
+# The type names are self explanatory. But if you want to see what
+# command belongs to what group to get a better picture, have a look
+# at "git" man page, "GIT COMMANDS" section.
+#
+# Commands of type mainporcelain can also optionally have one of these
+# attributes:
+#
+#   init
+#   worktree
+#   info
+#   history
+#   remote
+#
+# These commands are considered "common" and will show up in "git
+# help" output in groups. Uncommon porcelain commands must not
+# specify any of these attributes.
+#
+# "complete" attribute is used to mark that the command should be
+# completable by git-completion.bash. Note that by default,
+# mainporcelain commands are completable so you don't need this
+# attribute.
+#
+# As part of the Git man page list, the man(5/7) guides are also
+# specified here, which can only have "guide" attribute and nothing
+# else.
+#
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
-- 
2.17.0.705.g3525833791

