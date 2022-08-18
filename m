Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E3C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbiHRVlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347042AbiHRVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:41:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854CBD28E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e20so2655543wri.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=tO6ZbNs8LLi+N880DSRDbPP1BK3ZQOfn9Rv9llB5YB8=;
        b=cnIxuYUWgqYULgjeB5eq7Ebhef8Ho5ehdAags91PlRjctgGO2oEme34LXBFDKjyMMd
         m2LLMnc3NG2lYUUbfflB494Rf0mzqSf5wpmt0Qn0TkDr2+EH5hI1bXsbKUvnMezTp3ib
         VUY9FhD303O0AhvBl5E6oLimgFgeFarcewhmLICj7sXN9F6G5e4hAvRnWHbPcmlsg+Nl
         qWoUOSaTSwu8qwx2gLm4tCDIRTqhFkmrRzKBHsvsv6Wze1iDe7QHiOUk0OgFFezsyZri
         qp2pcit9l7TW2zEt7Wb7zwE4fGx/4ymfqwhmADUdxA/G1Lmtmj7WIG3M4pfYzOgzxNQi
         GVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=tO6ZbNs8LLi+N880DSRDbPP1BK3ZQOfn9Rv9llB5YB8=;
        b=1BMfdaB29jn0vifWbsC2dbFrO8thdPu76E5bS/vLcb/+rUHAiYZ6E6wmk4nG+Bdt2o
         EnItSGy3k6BrulJdiEpaNx5ClUp64O7NWQtMGusFjd3qjV72pzcBTNgxbt30qUlkWvqo
         dktvKG8EMu2HVx/nu/LuvdWDaaFRS8nAKISN1HGaOFhKgW9I2RNDDJZOSoc9XRy+OyE2
         2jij5JtpCgHAYqQlYsIiAXI1ABLNUEcctqVmfY7H767AcxrAWzI88WYTvY1LJ43ggLa4
         0eVBKdePTxFSAI1E24YD0NwE3bzNTD4Qkk+FFgHvpG78TC5w0I5zM61jRYSGwY181HNB
         bJxQ==
X-Gm-Message-State: ACgBeo2L1gig0oEXFBUhsz4sp1YgJHvgSGIOChUJ+ovf7n6gEnSrdM1g
        uAHlSjZxzPMo6llio7gX39MJprViCBw=
X-Google-Smtp-Source: AA6agR45YWCKNyjRyqPbl3MfiP6lT36nT1Sy2WxjXQZ87sEM29/CgVu6iK5IxzZSO/rB8sucUYTwiw==
X-Received: by 2002:a5d:4204:0:b0:225:382f:a8be with SMTP id n4-20020a5d4204000000b00225382fa8bemr265896wrq.379.1660858858187;
        Thu, 18 Aug 2022 14:40:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c3b0400b003a5ffec0b91sm3353599wms.30.2022.08.18.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:40:57 -0700 (PDT)
Message-Id: <aea8723e7181e99437f880f5d1578078e3fd350c.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:48 +0000
Subject: [PATCH v3 3/8] scalar-[un]register: clearly indicate source of error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When a step in 'register_dir()' or 'unregister_dir()' fails, indicate which
step failed with an error message, rather than silently assigning a nonzero
return code.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 8ef8dd55041..7be2a938b0c 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -208,15 +208,16 @@ static int add_or_remove_enlistment(int add)
 
 static int register_dir(void)
 {
-	int res = add_or_remove_enlistment(1);
+	if (add_or_remove_enlistment(1))
+		return error(_("could not add enlistment"));
 
-	if (!res)
-		res = set_recommended_config(0);
+	if (set_recommended_config(0))
+		return error(_("could not set recommended config"));
 
-	if (!res)
-		res = toggle_maintenance(1);
+	if (toggle_maintenance(1))
+		return error(_("could not turn on maintenance"));
 
-	return res;
+	return 0;
 }
 
 static int unregister_dir(void)
@@ -224,10 +225,10 @@ static int unregister_dir(void)
 	int res = 0;
 
 	if (toggle_maintenance(0))
-		res = -1;
+		res = error(_("could not turn off maintenance"));
 
 	if (add_or_remove_enlistment(0))
-		res = -1;
+		res = error(_("could not remove enlistment"));
 
 	return res;
 }
-- 
gitgitgadget

