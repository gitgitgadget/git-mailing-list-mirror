Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499FBECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 13:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiIPNFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIPNFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 09:05:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEEE8E0C8
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:05:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g3so15036573wrq.13
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=b1lMb5sKyKApjiiup+kIAEaa4o6/CbrcVDvfkYStmeE=;
        b=QoJPXSCsCY63gfdrtfC8hvcFOXcvAdtBCh1pOii+hYacVG8oJlnTMByaSn3jKQNTqV
         6KnjE0bXlgjFZexexGlBa9rGT8zWJOwATUDFxFsZTTMlnpNsx3U9iEfudF7Vd/uTfbCu
         lspnc2kHYBuHkmzRvGyWENTkCyO9oaPrIoIeTHB8u0d0iM/krz85fb0OBhfPy63bkU3H
         yr8V+vy3RqLN8NtbqRqHuephpfTKXTpVY93uIJgeXF5GKTK/348M0M06wYDC9ZJHFx0U
         KweWBdhLGv3cJGlEyH0f79GU2lqdr6JkIiaM+bX93XuSsMdgk/Wxjsbu+M6kb+x8KVEG
         8f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=b1lMb5sKyKApjiiup+kIAEaa4o6/CbrcVDvfkYStmeE=;
        b=mvCgvwj/0DmMoOQj6S0jZ09dqrajA2XYY32aQR2Q1KNI9yE7zy8JduLMFL0bDrI/je
         YVC/2/hJS/ETGTJygEVzMfTKW7CE3S6ZS8Tii/i6AeOb0XYeBNC76K+Sr7Q6qRrsqBr6
         oPUIg2qYoBPdZyqkeLB9JhcyFgIKdRiv3hlSN+q1m+UbztkvkXMLzyb7VdpP4kmL0j0s
         4eJIcI0TcwxW9es2f23EBSa6slG1U73o4obUTSOhX83BeA70BhdDHhureFwsrrxUiyvl
         ONgJQZevulC+9OXi2qdclRiJInhG4e4BI94UXff4dQZDobVK3w8YSb3VAphxO5e6fr8v
         jKhw==
X-Gm-Message-State: ACrzQf0NFtor5Py7js4kdPOdO61tR1RaOFbF0+GovKcHQ8kkm8RyiPaD
        /SKqlhbJsF4ff/CWQfm8ESuEipjsrEo=
X-Google-Smtp-Source: AMsMyM4o8WzyKPK9wAsWY+x+Pwvxvm5Ek96Dabach+U4bTGSc9CSUFJcB0/7JL1I7POWJBABVNhHeg==
X-Received: by 2002:a05:6000:184:b0:22a:cb6f:bb52 with SMTP id p4-20020a056000018400b0022acb6fbb52mr2735795wrx.500.1663333530789;
        Fri, 16 Sep 2022 06:05:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7-20020adfa747000000b0022878c0cc5esm4876590wrd.69.2022.09.16.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:05:30 -0700 (PDT)
Message-Id: <pull.1330.git.git.1663333529294.gitgitgadget@gmail.com>
From:   "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 13:05:29 +0000
Subject: [PATCH] help: reword explanation line for developer interfaces
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
    help: reword explanation line for developer interfaces
    
    Signed-off-by: Fangyi Zhou me@fangyi.io

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1330%2Ffangyi-zhou%2Fhelp-doc-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1330/fangyi-zhou/help-doc-fix-v1
Pull-Request: https://github.com/git/git/pull/1330

 help.c          | 2 +-
 t/t0012-help.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index ec670d5f68b..d04542d8261 100644
--- a/help.c
+++ b/help.c
@@ -39,7 +39,7 @@ static struct category_description main_categories[] = {
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
 	{ CAT_userinterfaces, N_("User-facing repository, command and file interfaces") },
-	{ CAT_developerinterfaces, N_("Developer-facing file file formats, protocols and interfaces") },
+	{ CAT_developerinterfaces, N_("Developer-facing file formats, protocols and other interfaces") },
 	{ 0, NULL }
 };
 
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 4ed2f242eb2..dbfc5c82676 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -231,7 +231,7 @@ test_expect_success "'git help -a' section spacing" '
 
 	User-facing repository, command and file interfaces
 
-	Developer-facing file file formats, protocols and interfaces
+	Developer-facing file formats, protocols and other interfaces
 	EOF
 	test_cmp expect actual
 '

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
