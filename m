Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CFAC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiFUN6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiFUN6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:58:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3B4DB9
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:58:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g27so12433777wrb.10
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=an4xyPanMt89msCxcBwiu3btNGhorwoYh9BpFOc7SrA=;
        b=A++RamipVMfqr2H/xemE3f2aXsct2OlzQAfIzN/Byt71SVqYbNFvvXcevSVppKh9L7
         BBykaKMo2Uya4UMnRxeopzxAiLFbjXKP3ff8DwHk05tN2nlszFxRqZceMKg7Yu+zqvJU
         C1Saf+LHMDBEbT0pA+lmuhzyqNUsueA2S2tmKDbEAJ39mJPJLLI2cvWWPJaxD0PhSJo3
         C83CQqxnKjE1prO/mcATnqq2yk2wzfMKRpMACiXnp/VN62QSApiqPN6ADn5DCis92xUj
         NSr9GftsYniQv3fgaWWGvn2NVtPYAFmLRB/Y/DLcHSHDEzk2sPz+xLHtCSf3jdLo/UrK
         rxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=an4xyPanMt89msCxcBwiu3btNGhorwoYh9BpFOc7SrA=;
        b=rxs2/U/7SBw0QqqKaLcRHRAlofdW2hQP6AbBHfA7t9tJjJhd7GgNd+eocn/Ekobuzo
         Yyqw2IQ5aMWswaTaqdXjemaWoJOpHkCmGlPmnSz8aVncJrf4OC70/OUuR9AqZaWFDBFb
         7R8jzWbmo86Bjl1jxHr8S4Xl5PKFJkxHiDG1/qbHKE3QYlgnHYcujeaCtsU7aazHkTlY
         nrx2APfbwzDNoDEshXRFqR3mfmrHU7vYlOdDggEh6AeR9+VKgk9h53+KHyHPsXXe4VpK
         w8vJFPEDp1uwddSgKeEPRJNDgfkaygnH29OMbrHcW+NzV8KqSUnfRhbCCBEAolbMITff
         A6RQ==
X-Gm-Message-State: AJIora9PV4njtKajG3yy4PGs3Q8QAHSU1mA+xpvqvHJbYzqsaFaCDszk
        8uneyi2cAzNpOcMWxgZX1XdHY3/rzZrBdQ==
X-Google-Smtp-Source: AGRyM1t+seCWtqmcZknL2HMDJ5iuEGNTJdSySqU54cnQeJBW80MqTLPmU0A32U3bWg9J8NpTfO7wxA==
X-Received: by 2002:a05:6000:983:b0:21b:90e1:220c with SMTP id by3-20020a056000098300b0021b90e1220cmr9416796wrb.232.1655819879100;
        Tue, 21 Jun 2022 06:57:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n125-20020a1c2783000000b003974cb37a94sm22057577wmn.22.2022.06.21.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:57:58 -0700 (PDT)
Message-Id: <pull.1279.v2.git.git.1655819877758.gitgitgadget@gmail.com>
In-Reply-To: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
References: <pull.1279.git.git.1655819439775.gitgitgadget@gmail.com>
From:   "Dimitriy Ryazantcev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jun 2022 13:57:57 +0000
Subject: [PATCH v2] i18n: mark message helpers prefix for translation
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

Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:'
were not translated.

Signed-off-by: Dimiytriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
    i18n: mark message helpers prefix for translation
    
    Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:' were
    not translated.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1279%2FDJm00n%2Fl10n-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1279/DJm00n/l10n-fixes-v2
Pull-Request: https://github.com/git/git/pull/1279

Range-diff vs v1:

 1:  efcf217b361 ! 1:  6f389468631 l10n: mark message helpers prefix for translation.
     @@ Metadata
      Author: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
      
       ## Commit message ##
     -    l10n: mark message helpers prefix for translation.
     +    i18n: mark message helpers prefix for translation
      
     -    Some messages prefixed like 'usage:'/'fatal:'/'warning:'/'error:'
     +    Some messages prefixes like 'usage:'/'fatal:'/'warning:'/'error:'
          were not translated.
      
          Signed-off-by: Dimiytriy Ryazantcev <dimitriy.ryazantcev@gmail.com>


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
