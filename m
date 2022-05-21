Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A59C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355344AbiEUOtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355324AbiEUOt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E596C57E
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m20so3814285wrb.13
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dUX+CqJUEd3dcX/lC4M7Djb/lzbFu1ZfzGpJwYcOHS8=;
        b=RB5a6JMc3C+2nJZOi7oODwh5HTXyHC7+7vJlRIn6sg2Uw8JeQATLIz86FXiws5W7qY
         iSzOSkSpv3fwEAzOX3vbYpppeTdrCG+uR4tFQh4gTU9D3o7EvKRfHJupbCQCRKCUIq+M
         GMvcJJS4y/u0sqCMa/eNgLBqON5lk5Kbnmul400fb9OBOUSROm3nQ8igwj0M7KatHnmX
         2NR7xFYOQotAQPMBLaMdnQEuLm5gtp8YJ750tBg9UYGZ5nsqSMFurcEiRk/hNXMxWy0X
         GtpDr+RZOjpCS48FihN4iiCESjXmPQahEJ/oRoaN0XfjSJyfnjnXZyT0xDkmanIi1FFG
         63xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dUX+CqJUEd3dcX/lC4M7Djb/lzbFu1ZfzGpJwYcOHS8=;
        b=s+CBxds/n+a9g//Xbtszp69x7cXlvzPvjHHxAp1ZhqQ9j7+oeKcAP+T8n36odhJUGk
         jL5tlZSbinBexNtWLKpRXR2kNlIUW+cTedcClLb6uFugR0Z8Xa474y12uaiBy/nzSb5o
         SwlevUh6MkHjWJm8yX9p0SO1aP2FMP/YUCIg7B2TuFAxzXGk/Ev3qAETHCB/ticUm8F1
         q8Hj0ENxSICaWUzidHcL5zzrLbEFlVttgmV0C5sBbDgrvw9hw8E1gM/yBb1m7U3Spubf
         MGiix59Hl6lbZh98/+Yw7wV4XJe9cPdZ4aBBBiaemCorj5HdET2l4LHyLXLJAhrmpCsx
         aeBw==
X-Gm-Message-State: AOAM530uhW4U7Jkwxmwz16VlGjsR6TGsDxDE4f0jLVSZdYQB/ynWvL2u
        8u9SnSq3y/VbGv+OegiXPBxGUSa1hA0=
X-Google-Smtp-Source: ABdhPJziKThtg12tZ90C0q9zl8VW98Up0YKaJMfh2IaIJ42JaojpoW8MKD2NDHYr4wARa05/PKekbw==
X-Received: by 2002:a5d:6042:0:b0:20e:65c0:f69b with SMTP id j2-20020a5d6042000000b0020e65c0f69bmr12555658wrt.524.1653144560008;
        Sat, 21 May 2022 07:49:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c211100b003942a244f4fsm4387893wml.40.2022.05.21.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:19 -0700 (PDT)
Message-Id: <1236a7319033a67befe34ed892db0eb5200490fd.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:49:01 +0000
Subject: [PATCH v3 10/15] bisect--helper: return only correct exit codes in
 `cmd_*()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Exit codes cannot be negative, but `error()` returns -1.

Let's just go with the common pattern and call `die()` in
`cmd_bisect__helper()` when incorrect arguments were detected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 21a3b913ed3..824f84ae76f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1325,7 +1325,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_TERMS:
 		if (argc > 1)
-			return error(_("--bisect-terms requires 0 or 1 argument"));
+			die(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 		break;
 	case BISECT_SKIP:
@@ -1335,13 +1335,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_NEXT:
 		if (argc)
-			return error(_("--bisect-next requires 0 arguments"));
+			die(_("--bisect-next requires 0 arguments"));
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
 	case BISECT_RESET:
 		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
+			die(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case BISECT_VISUALIZE:
@@ -1350,18 +1350,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_REPLAY:
 		if (argc != 1)
-			return error(_("no logfile given"));
+			die(_("no logfile given"));
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
 	case BISECT_LOG:
 		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
+			die(_("--bisect-log requires 0 arguments"));
 		res = bisect_log();
 		break;
 	case BISECT_RUN:
 		if (!argc)
-			return error(_("bisect run failed: no command provided."));
+			die(_("bisect run failed: no command provided."));
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
 		break;
-- 
gitgitgadget

