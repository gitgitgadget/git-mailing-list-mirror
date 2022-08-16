Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B0C32771
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 23:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiHPX6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbiHPX6P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 19:58:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658982DABF
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so14434518wrp.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Rk5t5lMQh6qkJp4x6uWUKkap5JFyvSIX3ER9vz73ThE=;
        b=dAcxBsSXZ6IiG2T5sYPgCwLMlAd+kjnuu299EQC2T+EZLZsXiStxpAu7MWhusto1/i
         sWm1qn3piJgLbJWgLrsKW1NH9lr9YGFViO04W8X3VbeU1PDn2QYjigVuKDf37sRUZOOO
         pKqGJBX4NYAvocyiztbZP+/SktrHzmO34zS+fUt/730Mzb1kpcy4KtL89GKl75BfUwkV
         5ZOAXXvt+y1VkyQPs7MtS3QffIgLujCbjrbCn4PuGlQclt2T34u0573m7/Reb9mjV5GH
         4zCl48f42bgXA0ysmqoyg/91+0B3rTllhQccwGx12kDkp9q5eo0Grhq8+hWieKyqB4F8
         DhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Rk5t5lMQh6qkJp4x6uWUKkap5JFyvSIX3ER9vz73ThE=;
        b=K+1LU/pVRXcOek1i05GJwO7FoYhGhbYtPwjWzbyuC+84Qxry2Ld6ddAqpzF6f0T+zg
         2fpuhwJImbz9e9zka58vrEc1xhWdr8c502wRR1QtoIQuVpYTRK+gyNn/QcP4lkjmT5Q5
         yp7X7ue59BXBKAm8iF32iUsDTXmF9a+f2D1i859jlv2IXEtNodMC7BKU0N/ILyoYn8TA
         /szUHX7mhJigOrPgkFdcX25JgUE5jFNs7R0koyGCRj4051hO1KLwKCItHTVFZHfyM8qD
         6Ree6WIhIKaKNNH1WJv+ukgtqNz4jxGnvWtXT+AjXjWe8nFABRQhAl6AqFCuOkQh/gox
         OPxg==
X-Gm-Message-State: ACgBeo2TWHqKW9/0cgrWjDzBi9w5qk9eD7cTSSh2ptyihbv6+/gu5ikJ
        SU1LQBZhuGzUuGpqy2m5VkNt/wtFOrU=
X-Google-Smtp-Source: AA6agR4+CSYGQTFnLPZqZcuEQx1jg+sSVvDOZz4IBIAYN9ogveB4ExV2LlzUPhch1h1o0Aqs7XuEpQ==
X-Received: by 2002:a05:6000:811:b0:220:6262:ac66 with SMTP id bt17-20020a056000081100b002206262ac66mr12245034wrb.529.1660694292750;
        Tue, 16 Aug 2022 16:58:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c191400b003a5c1e916c8sm5273888wmq.1.2022.08.16.16.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:58:12 -0700 (PDT)
Message-Id: <4bacf8bce8acb1a21bad0648055cd480c81c6b07.1660694290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 23:58:06 +0000
Subject: [PATCH v2 2/5] scalar-[un]register: clearly indicate source of error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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
index e888fa5408e..6025cd71604 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -238,15 +238,16 @@ static int add_or_remove_enlistment(int add)
 
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
@@ -254,10 +255,10 @@ static int unregister_dir(void)
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

