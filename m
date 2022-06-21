Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D50FC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiFUNur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiFUNuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:50:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8188C65AD
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:50:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w17so19030369wrg.7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KgqOVqajr9JaiNLzFxbEL/Por3UYpsF0FoA0gB/NHcs=;
        b=oPLvIeR395cqljpdzJyj0ZRlRdHQ6tCDenFcw4YcgT6Gwhatojq0Tf49YoqRPp/xEq
         +Odr4KX7KdlcScBIoCZKvR0RsT3N+X+6n3GdpaTk+9Wv7576c/yMTArHdz5rW+tDbnk2
         rbIuG0MS3eT3OxsMUaLqPy4MihTpnz6sL399qLQtlfB4iZRZbpTUYx9leqQ11IEisQT8
         Ropf3AUYUxrRTj5dw1wBk8cgv15r95cqXwPfzSkBoVYq+vY8vCgAoG7WiHH2SQPMXupn
         WmirGBHFmwgLH5FozQIhj2IhfenbcnxhuyHDH3QS7wpl1j53oufz8PWekKFyj+fnkad/
         zSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KgqOVqajr9JaiNLzFxbEL/Por3UYpsF0FoA0gB/NHcs=;
        b=8KY+Nwd6qX/6jhiHmfWhoFO3HWyBCgs+gsLUYEMypiUfhPh1EcXdC/azW5b4BV3WIw
         6zjWtMRED/fIDFAYXm9RXyoXA3WD14f4Y+GE2Kv8G8lcRFu4sMBe03g9vfRg0s8kVsMu
         Co2YDyaPRQGhT25V4ZuwXwd41UCI8kZqzLcF+Nrsv7eF8/dSCWkaSyd/wznDmQfAddpg
         PqrN82sG/sekXYoN0KRfZnZpfQVxwmPIIISKx6Yw7FEfR3dIs/kQQ+95PhPpqq0iGIZg
         dXdjGbXf9Lt5yzEU/3MPaPPgDC8TKB+GxSlauNXipnzxB26R9vIW9rPHhG7ZZowhmLUY
         HzIw==
X-Gm-Message-State: AJIora+HImrPXyr6GROt/LybW7wGkp18ZvjbEG+x4KjWRKD+aMPuZf4D
        4RzkzVRuXT4PUs3cXCv7w9McEbjmmcwldg==
X-Google-Smtp-Source: AGRyM1vpC8yNfo+oFTo0Qpdh5kkoF9esexs96i+Gbf7SdiWPPgqn+ORro6FWKyyfyJHrmooM2u21zw==
X-Received: by 2002:adf:ea43:0:b0:21b:9243:be8c with SMTP id j3-20020adfea43000000b0021b9243be8cmr7848465wrn.650.1655819442648;
        Tue, 21 Jun 2022 06:50:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12-20020a056000022c00b0021a3daef45esm16962459wrz.63.2022.06.21.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:50:41 -0700 (PDT)
Message-Id: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
From:   "Dimitriy Ryazantcev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jun 2022 13:50:39 +0000
Subject: [PATCH] l10n: mark message helpers prefix for translation.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>

Some messages prefixed like 'usage:'/'fatal:'/'warning:'/'error:'
were not translated.

Signed-off-by: Dimiytriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
    l10n: mark message helpers prefix for translation.
    
    Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:' were
    not translated.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1279%2FDJm00n%2Fl10n-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1279/DJm00n/l10n-fixes-v1
Pull-Request: https://github.com/git/git/pull/1279

 usage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index 56e29d6cd6a..5a7c6c346c1 100644
--- a/usage.c
+++ b/usage.c
@@ -33,7 +33,7 @@ static void vreportf(const char *prefix, const char *err, va_list params)
 
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
-	vreportf("usage: ", err, params);
+	vreportf(_("usage: "), err, params);
 
 	/*
 	 * When we detect a usage error *before* the command dispatch in
@@ -58,7 +58,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 static void die_message_builtin(const char *err, va_list params)
 {
 	trace2_cmd_error_va(err, params);
-	vreportf("fatal: ", err, params);
+	vreportf(_("fatal: "), err, params);
 }
 
 /*
@@ -78,14 +78,14 @@ static void error_builtin(const char *err, va_list params)
 {
 	trace2_cmd_error_va(err, params);
 
-	vreportf("error: ", err, params);
+	vreportf(_("error: "), err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
 {
 	trace2_cmd_error_va(warn, params);
 
-	vreportf("warning: ", warn, params);
+	vreportf(_("warning: "), warn, params);
 }
 
 static int die_is_recursing_builtin(void)

base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
-- 
gitgitgadget
