Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E35C25B0C
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiHGCts (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHGCtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:46 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D14BF75
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:45 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10ec41637b3so7082671fac.4
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zZpqACFldo2pD9SlKaCMJ9v0K0tK2SODRtjZtRwDNoY=;
        b=jk7/pRfhRD5N8lVW36b+JEBwUcGPWNa2Xk8kE6pFXJoYQDjNpGLSAnoR7Y9+uWXtSS
         fH4ONL+NHlJQcjd3MZIAsXbiHKZMQQk2hoAlpgkEvdO9f+7+uV9UEsoQOZtr1Kt9vSqE
         bHZ5R1RVm5NvbXo/Ztr19V5H/EVnS9eZaHc51kvqUIjD3LkhgiiUNnG0/lEaBvpq/vv/
         T94O/tH1Ymb7EdbOu/Y2wCi3pfOWjr9tSUFnxYlOgAT9Iwe47csGjdYb4iv7H/6OWtj7
         RxRDetklWzPGzWw+i763KWnUG9rWWRcB5aa3xAi34RhG53f2AN2JJBeBN8fkwG1ivU/O
         LZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zZpqACFldo2pD9SlKaCMJ9v0K0tK2SODRtjZtRwDNoY=;
        b=qA6D8Vce3fx6OQPYjNsmLReh3h0Wp4QH7MOc++Xj2M9h9V4LcgPPyW8i+VnEpVTbKr
         m/7RNr+pVb9+JXxYx1uaHyO326qQj+mxoaV4vYT94WNZThiVtOt18VbpsKVKgsg2RKTk
         D4hZu31VquTr3fJwC8uN169MpR8xEI5AYum0hAYtV9tp0J9PEzxMX2sImr08bYOnkVHz
         JzUu18JwUgeUPQ+dzrymwxXxCrh9LTKb9nAF2JZ9HfWivGHRoh8VRpmJvHJx8cJ673ri
         4rSPbkTGBvfiDRJXw+2PciEP21kxHBOleQjcYXAdIyNfByXMEhxzgvoTwzlCfhNhZQ5/
         IwQw==
X-Gm-Message-State: ACgBeo3qG+sHUZ2lOa2Nusanl1N6ucTVe3zsi2LI2sBdy8COGmCO2f/s
        pelahIpikGyImX/ReDR94lmwKnhCGzc=
X-Google-Smtp-Source: AA6agR5gshB1M2vtrctAvL4CLvJV14ROinDQE/RJLybr4SU120lVKCHxSO1wUlt41nkSgpGdKAsfHw==
X-Received: by 2002:a05:6870:4344:b0:10b:8499:395d with SMTP id x4-20020a056870434400b0010b8499395dmr9258395oah.214.1659840584166;
        Sat, 06 Aug 2022 19:49:44 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s4-20020a4ae544000000b0035eb4e5a6cesm1477972oot.36.2022.08.06.19.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/9] mergetools: vimdiff: fix comment
Date:   Sat,  6 Aug 2022 21:49:33 -0500
Message-Id: <20220807024941.222018-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name of the variable is wrong, and it can be set to anything, like
1.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f770b8fe24..ea416adcaa 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -29,8 +29,8 @@
 ################################################################################
 
 debug_print () {
-	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF is set
-	# to "true"
+	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF_DEBUG
+	# is set.
 
 	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
 	then
-- 
2.37.1.378.g3f95da6bac

