Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED97920248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCQMtv (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:49:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46857 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMtu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:49:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id s23so9385809pfe.13
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eca9ZsFwoVUCY2bG0QWY2+9Ai9feDkocqdnb1aXm9PY=;
        b=gQ0Pp0d8GgMX4veSmcmjfNY1P5yXH9dUP2+xESIwrlKouPftg+FOp5DWHzSh/tiUnw
         4NA8FXuNUTR+ggqE2WUX++aPe7ZhfAZ+yRQcCI4oNYmON41ODL9Jg0s+KGcUuTt9Rv8T
         EFn1eiT2nowguqrLlPCuqQUNGmR7UDkc/PJbUAKL0hFkAnXDO7VvMHdJKLNmlPEdH2Vn
         ZyvFfSZ2QlyFKW2EVDU9TFlHqhkw50bn7IwxCA9fdtHBkKszdEcc7JnANTanw7of1kMo
         xFTC/GB8zE7JWADbYUrTWCYFV+ZmPTmtT+7yqu+30CRaVTM/HhmICcN5h8RmXdUORVC3
         /g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eca9ZsFwoVUCY2bG0QWY2+9Ai9feDkocqdnb1aXm9PY=;
        b=PwRxHb0HbUI4ebcx1W40F3wI3Q3KsHxcAk9y5s5wySLTkf9qK0Yef5yeUHm8jt5I6D
         Bq7OQr6ATXoJ6Fp+9lbXD8eXPnmlHdlQ6quv6s/xJbqJu6buk5YDJmT4AmFSSik8dbIf
         wP+8V+gmMokknTGhzjbxXr/BPZD9cYoHvCKXCBgckOH8EjkPh2fg6hVRPwglojTvCHLI
         gqAcqksiAYUAQel1M0Cch84f5rC87qtacK2Ia8nnZBMtisJYCIr72cTL51ZDdbqWBaAR
         XTMzZaa/5aHMeis9MQo38/K/YMibTL4SPDyZ86kurjFHaXwpt5hXexBlOsK2Ou6cPQ65
         p+0g==
X-Gm-Message-State: APjAAAV4t8X2XuTGQBKtnSnBhaDE21CfS2JVJdlsibrB8JgbR3bIVpPg
        PrzYAq+LuH66zeZB9xaijlU=
X-Google-Smtp-Source: APXvYqw+WO1tNCZJKuCMk9dGuZG627+h0oAFxFjxU3ZxpuODjbtHyQ6K+Z6yVxOTWVHtHn1uavzUmQ==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr2419305pld.220.1552826989890;
        Sun, 17 Mar 2019 05:49:49 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id q86sm19726990pfi.171.2019.03.17.05.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:49:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:49:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 02/26] git-checkout.txt: fix one syntax line
Date:   Sun, 17 Mar 2019 19:49:02 +0700
Message-Id: <20190317124926.17137-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<branch> can be omitted in this syntax, and it's actually documented a
few paragraphs down:

  You could omit <branch>, in which case the command degenerates to
  "check out the current branch", which is a glorified no-op with
  rather expensive side-effects to show only the tracking information,
  if exists, for the current branch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 99c8c0dc0f..28817cfa41 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -23,7 +23,7 @@ or the specified tree.  If no paths are given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' <branch>::
+'git checkout' [<branch>]::
 	To prepare for working on <branch>, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	HEAD at the branch. Local modifications to the files in the
-- 
2.21.0.548.gd3c7d92dc2

