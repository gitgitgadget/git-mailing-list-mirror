Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE036ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 11:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiIPLNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiIPLNt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 07:13:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F913EB4
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 04:13:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u15-20020a05600c19cf00b003b4acef34b1so3052544wmq.4
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=1tcNg4DbRvnNMn9EVjKkKgJB3r6b/3cc8RJgu/9srzw=;
        b=NTlibjHShKHaAQRynPaHPVnY8QVroGyeRfiLFr6UhlhIbocB+GZzJAX5E7nQpNLgjc
         pr7R8r0MFuvhvomV+LMw2+52cOFXpIgJ2XJHo3ajg0+wm6MPHVNEmYgh4vlYvhbyxz/C
         COCaI7OEwpq7+32tAOTU6/7qg3hnNdegwLSnyKAD83mmH8Ro9DpX5YoZguEYp6Pqph+T
         h/HnAToTlNlKHsmizxf1HzVg8OgZXcUnuKEoYhMm84BJqGEp/W5b6a3K816jMRBPmCv0
         XWCku1sBSjvGLM0IHknJWIvChbBQO3QS++R0tA9pFE/JlURdiNYmb9PCxrtrGyRkOk3o
         Spwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=1tcNg4DbRvnNMn9EVjKkKgJB3r6b/3cc8RJgu/9srzw=;
        b=j7tq303P16AW9ele3wCX1j0GuHouQf0Xn2GxAGvUlnq5DejvniEJ/Pj13AW5GVO9+R
         uzZmAJI/wIgHtmjtax96OTY7cFx+bwuLLh/jSb7ter+HmvboHS+juUB2r/brlNkTvQPD
         q9YYSbuiwZdGoBe80iqRdjV4QY/xIk/N6jg6rIQochmy6D5yAZ6D5Xl+KZvXydFhPby7
         Me++hGAhJeOwXZECvoeXiC9rEYbQKo4Ajzm7Pwp31U7HFhTzdJZwJdh77who628JwWI/
         AfSo6G+SZT3e56it34fIggOOX+d4f6QJsINxUH7+43P9LPAwTcJCmiEteH6DxIf01kN7
         WruQ==
X-Gm-Message-State: ACgBeo0ixILtG9NVMK63aS5LiVXuIm7KR6C7YvzsguQxqmdpQ3W0GemW
        2GwLMOT9IiEE8Nfa+OGI/yKgVGSN7w0=
X-Google-Smtp-Source: AA6agR57q7MBOJVo+Jm5J09XQB98AQtlOY0PWgGBq3M2gU0tVhG+eztLDVJRFJtTek2rmRBA8HOJ8w==
X-Received: by 2002:a05:600c:3d15:b0:3b4:8bd9:3905 with SMTP id bh21-20020a05600c3d1500b003b48bd93905mr9718586wmb.173.1663326824441;
        Fri, 16 Sep 2022 04:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c225500b003b4924493bfsm2486359wmm.9.2022.09.16.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 04:13:44 -0700 (PDT)
Message-Id: <pull.1329.git.git.1663326823401.gitgitgadget@gmail.com>
From:   "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 11:13:43 +0000
Subject: [PATCH] bugreport: add missing closing bracket in usage line
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fangyi Zhou <me@fangyi.io>, Fangyi Zhou <me@fangyi.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fangyi Zhou <me@fangyi.io>

Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
    bugreport: add missing closing bracket in usage line
    
    Signed-off-by: Fangyi Zhou me@fangyi.io

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1329%2Ffangyi-zhou%2Fbugreport-usage-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1329/fangyi-zhou/bugreport-usage-fix-v1
Pull-Request: https://github.com/git/git/pull/1329

 builtin/bugreport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 530895be55f..a4a5a88840d 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]"),
+	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>] [--diagnose[=<mode>]]"),
 	NULL
 };
 

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
