Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C91C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 02:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiLSC1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 21:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiLSC1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 21:27:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D046AE5C
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 18:26:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f18so7331452wrj.5
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 18:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8D34xtXHLsg3uRChwHnfTjNTnd/5x6kMqem+PWNCWQQ=;
        b=MA/OQ6MUIdkUlyWuaXEPCYvLYWbwB4++PSS47/sEe3uL2BdeV0CQBr8phInmwEIBmc
         rj9wk66dJ9ViRFWGpUr9dms2CKngj7A7kZacSnDneJ1jRURqFMwHhrHX8d7ug4vyzEfe
         aBohIVLihNCXE6O7kbRACjf0feQDi9vdj6XxcfRqit7/Qor2y56RMFZ4Nak6mWZo34zs
         2ATfFL14VymvzXvtom8eq1LQA4VI+aBsOoBdcvafvKvUoqA9qcViICDlsvUMW9PcG9dF
         56MufBinl70NtBS32dbt+lodJUAhOQXkkQf/dSv+rF8dWoNd1dar6NQHluH9n6FUVnKC
         Qg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8D34xtXHLsg3uRChwHnfTjNTnd/5x6kMqem+PWNCWQQ=;
        b=vw4IL7y3r891Xr9z5QhjeP8WBcWwfnb71yduFxjXmoDZTsrW4ESKSE3vLSKAGl4+3T
         WPYspPbhViBbyw4DF73Ki4SONiAD4Zsyqe0yaGvzhTK2lQyB1S38S7WxZCCO9ERyr1GP
         IWk12mIT0sUf9QST+GZ1kHtDvUAeCwZNTNprkCpQ8XovYzV169ILoZjYExrfUJeA29ih
         E77OYg2xx02po4ueYDX2lMwnqzPI7KnSEFF/6xY3IUU6LYbcPBImbdI/U7wd7ATIq54T
         Fo8R3h+AY5wgy00Q2P6vFTuqJysUrEtK7OHRZZTCuKmLeXinFVTC0Sk24BwAPjNAzFZ0
         H0qg==
X-Gm-Message-State: ANoB5plu8puEAsk81Fb8zikTmOk484k/P3LaA2v/URmmKPX7gJnZrNQM
        vFz9DoNKWi/nWkdwVKH//AZhDwjR+Lg=
X-Google-Smtp-Source: AA0mqf60uVpra+xG0KpBsGVnX8uPiy9CImqV3JJ+4LKuzbEZGUns8VOeHnnpbYPYbemU4mCFPo2T0g==
X-Received: by 2002:a5d:484e:0:b0:242:154e:5f14 with SMTP id n14-20020a5d484e000000b00242154e5f14mr26155816wrs.17.1671416811861;
        Sun, 18 Dec 2022 18:26:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs29-20020a056000071d00b002420d51e581sm3055320wrb.67.2022.12.18.18.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 18:26:51 -0800 (PST)
Message-Id: <pull.1393.git.git.1671416810927.gitgitgadget@gmail.com>
From:   "Sheepolution via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Dec 2022 02:26:50 +0000
Subject: [PATCH] Fix word "does" sticking to "not" by adding space
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Sheepolution <danielhaazen@hotmail.com>,
        =?UTF-8?q?Dani=C3=ABl=20Haazen?= <danielhaazen@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Dani=C3=ABl=20Haazen?= <danielhaazen@hotmail.com>

Signed-off-by: Daniël Haazen <danielhaazen@hotmail.com>
---
    git: fix word "does" sticking to "not" in message
    
    When a repository is on a FAT32 file system it will send a message to
    the user explaining they should use git config --global --add
    safe.directory. To prevent a long line in the file the message is made
    up of two string literals. In this change the first literal has a space
    added to it to fix the issue that the last and the first word of the two
    literals stick together like the example image below.
    
    image
    [https://user-images.githubusercontent.com/2232780/206909378-147775f8-e7f6-46e3-8746-17181cac69d2.png]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1393%2FSheepolution%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1393/Sheepolution/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1393

 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d614f156df1..af397e68a1d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2752,7 +2752,7 @@ int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 			/*
 			 * On FAT32 volumes, ownership is not actually recorded.
 			 */
-			strbuf_addf(report, "'%s' is on a file system that does"
+			strbuf_addf(report, "'%s' is on a file system that does "
 				    "not record ownership\n", path);
 		} else if (report) {
 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;

base-commit: 694cb1b2abfda78e60c8c74f1e761de6e852f0a2
-- 
gitgitgadget
