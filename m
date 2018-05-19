Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410191F51C
	for <e@80x24.org>; Sat, 19 May 2018 04:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeESE2e (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 00:28:34 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46814 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeESE2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 00:28:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id z27-v6so602669lfg.13
        for <git@vger.kernel.org>; Fri, 18 May 2018 21:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qyeYV5fWuyisDlL7IEUatsvILGYsiM1HSSjbFZdDBs=;
        b=Q4QvaGIcgujL3VFhInxGrKNx90VHCH88PSuSgElRLmA2uPOL4b6/gFgYkD8RU53Na6
         5VHGX4s1PRdl/g9XiuLwtVf1oqeKTe+PWMxWWWJ+TFrxF5e28MXMT3w4WXz2n+ozxaXr
         m5P81vFpV+dS+5ORHWnMADDNwPTzqF0rvBM+tiZEpqNiCBf4reF93CsrBgFLB6aoqgfL
         eTe0oCfvB+N5s+AOHWwOutpI5fzxWOx1PIS+e21aOLyeBm2oZN032DKUXuGi80WpSWdj
         +i+vWHASwapbBK7T9gPllZgyqI5f3ZfzWNmsTaoaOVEbvi8MaWphZDXfKqDVrdLIpTtd
         rljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qyeYV5fWuyisDlL7IEUatsvILGYsiM1HSSjbFZdDBs=;
        b=fpdE1t4pYr8KviQ6V9GxXXiuZ2Q6T1KYEOijYjyoHvwOCCMI8Ui5PMJnf/eTwS3GLS
         AKiC62Dq8Iecev1Ss51M/84rjUXOpoaoDzLSObB3S1KNJTdgKgKGJKeyhCnwaBOsLwnT
         B5qVsT015yZmh7xdvII2JW/1BCu7WNMCfNjDVCxdlqLGRv3GanPvtrp1myagqANOdpNV
         2tffkH2TpxkTQ022fI58Fvkqmo/25RA2ug98c91s7YL2T5nJAyzo+IOhx/SO6ZZtQFVd
         As4x96noybUWTOvq8zVCzJR+jelN4JbdgmItGupsrPmvV7BkLFt24y2hl4C9Gw40ro35
         X5TA==
X-Gm-Message-State: ALKqPwfTlLrmJ7x+7mmDbKfjuNbHpXuB28gqtXVWg644I9pSyCubpDCS
        cRarDHfkWHuh8r7O4bLW+KTIwg==
X-Google-Smtp-Source: AB8JxZotrgY9rHyMYNVKLfPYrRh4yh6KI+4BnhwH/CGuv4uHY6cDPnl2OLNfuOe3YUcjR1sLxAEOkw==
X-Received: by 2002:a2e:9158:: with SMTP id q24-v6mr7134211ljg.73.1526704089072;
        Fri, 18 May 2018 21:28:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1960309lfi.14.2018.05.18.21.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 21:28:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/14] command-list.txt: documentation and guide line
Date:   Sat, 19 May 2018 06:27:49 +0200
Message-Id: <20180519042752.8666-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519042752.8666-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
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

