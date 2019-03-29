Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0933D20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfC2Kj5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:39:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33585 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfC2Kj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:39:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so882987pfd.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dYICuZHxJa2UGqrJAsgZwTCvdrxtJIwWIcdMxQvIRwQ=;
        b=QWVeJyep8Xy1q4J3prgmTxKXNSQO9X++ycepM9TbFde2jye0OQ0Od3G30NZyD1uQ+l
         UCJ3SDkbUV+oG0jQshCeWDaxK7IxlKJaXkPvd/1o0V3Mgzlj9AhzC0W5oVxbyMVY9mzr
         Pm4KRlhVoAcrtBcCdA6/LZ/zWFh184/MgB9+myGtXTCWxwApk/H9Zy3izAuMksgdNarT
         aDU0PDdvFPhJOG/lWdUs+UxEdeGYK1tcsc9R0R/T08puZcG1/fkKnwDrHlPlbKFgKisa
         PaXSgP99bWg7H/FJxaaIC/wu6RON1RTY4AU1nAgtG479djtPYHky68NntApzYsrVQ4BM
         d3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dYICuZHxJa2UGqrJAsgZwTCvdrxtJIwWIcdMxQvIRwQ=;
        b=Bq3ldGx/6gKFFUycsW5mPgRUG6/pqdtDCuldQqS5aHuxpkoYepl5CD9shX5TJc2jV1
         nFKvJbWOJMMEcPp5qnRJR3zzWJGhmjVjPfVEKlM4HPd/IY2znZNxCXP5QB2ngkZnxCr+
         b0eBWwxnIsBZygE2t9r/WNk2qmFXL7B1vLMrkVIuGMWS76xj5UouubsiSw35Mpya2XNO
         i1MMUroXdsnM0Q5vqo4LOHhZJYeuIDeLYzUeHb504HIswdfBhh9bhFQCb6+Z8faw/E/E
         IkbBWL12SRegEWihubXF7Idj2jRS6ap6n6PAkYURqyYtHNRUJMwvmrGKZ0S5bhb1SvW8
         igQQ==
X-Gm-Message-State: APjAAAVKi6sm34g41P8jGLzIzDOmUQvp5sjgKflcSOHzoim5UC/JNnbg
        ZeIEbY0T2zS9ETKCCVxFGMI=
X-Google-Smtp-Source: APXvYqwGfTlKPYVexetwIE097p7GF2zu5PXunQMAHLiKyYFAzyRWYyTsPa8HH7gb1rOisEG0jSbCcA==
X-Received: by 2002:a63:df12:: with SMTP id u18mr44368241pgg.135.1553855995984;
        Fri, 29 Mar 2019 03:39:55 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id a17sm4958950pgd.30.2019.03.29.03.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:39:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:39:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 02/27] git-checkout.txt: fix one syntax line
Date:   Fri, 29 Mar 2019 17:38:54 +0700
Message-Id: <20190329103919.15642-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

