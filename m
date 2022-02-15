Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD1EC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 20:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbiBOUwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:52:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiBOUwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 15:52:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B31A39C
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:52:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e3so156468wra.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 12:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SLtlPwQLGYdWeqHh71UNdWO/QwfC0blkUQ1Q3x1az5E=;
        b=eiLmiif0Jr9vRQyEp9XUiHaGIHZK4lm4VW11cHY0V+JF5vQsAkaMXIADEUAP0+2lIi
         O3A77WWXX1BtOPCHUTyxsXfw2P1SFIBQWJIpMzraJMovk2wMkfXlq62rglaFC0RZZHVV
         6ne5q/lFRF3D9oHLNJgu4DYwPzcdxYT9B300Q5gmMelIXyYr3iTBsL4bXCs3x0ejLSeK
         AHDC6S4ac2PFQ0IPCitHwwBBEWDsi7pFlzHlR2XjsReIQlBTOqM4yoS1gENftikkKZqX
         FWnAloRBX/8h1GXX25y/Mcgw+DLFZvsWQNdfcfqsb2JqXp10R5yaH0sNMkjWDFOxcg2C
         AiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SLtlPwQLGYdWeqHh71UNdWO/QwfC0blkUQ1Q3x1az5E=;
        b=4pzNOA4FjhY8QYNGIED1sE6n2oNRouDFXdbKoOaLuj5u+WOOHX/tpmrWqaAVASEoZE
         egrCOqI7S0X+XvTqdzBae3y1Tb+wSeUcgZuughIR7Loxc5rEpnlUqAN+ssGlm1J7gAaT
         Hu1UR6cV7lf4KmkwVGuPMlQpO8nIpunF91/fKAuSWgjdbRIXbWY0gS3kHOuxvr+J66mc
         sSANTP31owejCki2Nh+i/Rm2dwaTJhBxtkKxroWirNR0qBov8EdZZSO4YirNIppsgncL
         6wBm4kTlYg4e2wUyPTPA35/fKjdIHZSfZxI/lS///QT4urc+Cjm0FDbWKwWSRZfUncXz
         PiwQ==
X-Gm-Message-State: AOAM532MEVXlJymwR0PoA0LNJcgsPVwvcNATQYv8EcTZphD0Z1w99Q6I
        ILUAFJCYRTQ6qEGYD26dPnkAZu+VoOU=
X-Google-Smtp-Source: ABdhPJyNm/OEWAYU6q5RiYoNuEvG3Sre+WBt61nSdCfUd5fpI7GTkggxCAwvlGClIFvh0b9d0V9CTw==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr555373wrr.535.1644958328566;
        Tue, 15 Feb 2022 12:52:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm3515585wrq.102.2022.02.15.12.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:52:08 -0800 (PST)
Message-Id: <pull.1216.git.git.1644958327302.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 20:52:07 +0000
Subject: [PATCH] name-rev: replace --stdin with --annotate-stdin in synopsis
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

d9976b184596 added --annotate-stdin to replace --stdin as a clearer flag
name. Since --stdin is to be deprecated, we should replace --stdin in
the synopsis.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    name-rev: replace --stdin with --annotate-stdin in synopsis
    
    There was an oversight when we added --annotate-stdin to
    git-name-rev(1). This patch corrects it by making the appropriate change
    in the synopsis of git-name-rev(1)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1216%2Fjohn-cai%2Fjc-update-name-rev-synopsis-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1216/john-cai/jc-update-name-rev-synopsis-v1
Pull-Request: https://github.com/git/git/pull/1216

 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 138e3c30a2b..929591269dd 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -473,7 +473,7 @@ static void show_name(const struct object *obj,
 static char const * const name_rev_usage[] = {
 	N_("git name-rev [<options>] <commit>..."),
 	N_("git name-rev [<options>] --all"),
-	N_("git name-rev [<options>] --stdin"),
+	N_("git name-rev [<options>] --annotate-stdin"),
 	NULL
 };
 

base-commit: b80121027d1247a0754b3cc46897fee75c050b44
-- 
gitgitgadget
