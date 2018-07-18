Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83CAE1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbeGRQvi (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:38 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34255 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbeGRQvi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id n96-v6so3877081lfi.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZliiRpHJ86v8RrLRFJ7yL3pEqMKL76HofHFA5qgGmM=;
        b=U17+Go9MHN6G7qH0e+YOY2bfBQXnUS8qomoVx/oSjTbLgnIqVMYGJU8umTchoKo6Wl
         HB92jD+tHfxFm310WFhHsA5u9QPNzQd1CJ537i/DWZl9eETzMxnA37X5w+sfY0uwIWAM
         Itrbq/hsGGO+EkwmlwsxMRP4Baom0p/IJyEZOC4eFA/ZuCHbbNb1o/XyZBVcuumvpLs0
         2Rk8lntSLFHj5xQMPPOB733bliMydpYJ9Zq+ezsmyAmdCZwSqHqp23JCfgroMQa/qB3y
         hdH3xBNW+lyHpeOp/nloJd2Fh3liVBVHbLfvT2ZeGaM32kSika1X0ZjVZUWPaTJYGzq+
         Uvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZliiRpHJ86v8RrLRFJ7yL3pEqMKL76HofHFA5qgGmM=;
        b=QTVWkF6ZTYYo8t70wndiC0EsYQfZew0mq4tNH2EIGhMr1KdGVpmCOhzWdRbLE9rh5h
         Zt40/btDO9Wr5Wg4/tQhg3zMQ5qML9jdGb/LmHjBArd6MEnY/LPhJNJxBTmb1v8WVTFW
         nqJPQlnoLYNXAnCQmhUKk24fMj0fN9h35KV/bw9vTb26O06ckLOWiahdWBF5kgPzRBcL
         dtp3GwbFrjGs1Ojigrxd2n99WI5a6ve5+fMR8rrfza40fvqowUDCVVxSl1YYYjeoWJvw
         GufPUJxT5CFQtMYqEZgUxY/Mz7SuYI/65Mr9oUqPMoj1+j86vi1QXT6ItboGqGig+29f
         +3Pg==
X-Gm-Message-State: AOUpUlFuM6y2QSKZ+JnffEhENClYVs8vNBgEeS7oK+ieubNU7FfyDY5y
        DLT3FEnh/5xO2V8tyWgWfUU0VQ==
X-Google-Smtp-Source: AAOMgpcHL72JNzY4FbzpdPUqgAt5CHZFnsHejBaUXXAcHAuXGMLOMf+BFEWHUHAnA9gpN8YINxZGIA==
X-Received: by 2002:a19:5509:: with SMTP id n9-v6mr4616769lfe.133.1531930380332;
        Wed, 18 Jul 2018 09:13:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/23] exec-cmd.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:52 +0200
Message-Id: <20180718161101.19765-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 exec-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec-cmd.c b/exec-cmd.c
index 02d31ee897..4f81f44310 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -358,7 +358,7 @@ int execl_git_cmd(const char *cmd, ...)
 	}
 	va_end(param);
 	if (MAX_ARGS <= argc)
-		return error("too many args to run %s", cmd);
+		return error(_("too many args to run %s"), cmd);
 
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
-- 
2.18.0.rc2.476.g39500d3211

