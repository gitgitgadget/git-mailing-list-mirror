Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552C5C38A2D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 04:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiJ0Epy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 00:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiJ0Epw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 00:45:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D3F4C037
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 21:45:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so3236503wmr.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EnegFuN5XaMy6ZTRb+rJBeGiKqjgzdEpXXwgWhB44oQ=;
        b=cjyDzfYkQYK9TMDOoZ26jAff3G0NEw6tTnGNFYmR8+oabNyaebVp44Y5F58i/u1kQJ
         ZVwFIDW9EzOEhWk71L6IuFCSFJDimsdefPTbfNmRGBZUxa99iVaSZeFHkGSsuoSvfaHJ
         xwHJ1jNhrxdkHNyfKzm/GPGphc5pXgndoci49FFHuTiXU6BhsqV5PV1knz3rQJgQWkBY
         VBO1zwnpc7GLgzow1OfOVTVlPjCEbussgLvjukBspJZW64ww+GvXnYAM+HqylRIypcix
         uJDWsoJ2vGq5kwjzba8T7kO5QUB757WiUBGautQHvV6zUuMdV7KCIL8XPY8TQtDu6bAj
         m5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnegFuN5XaMy6ZTRb+rJBeGiKqjgzdEpXXwgWhB44oQ=;
        b=OMhOPOu5js7NFhCF5tEDdQ+GwEPk2UnbOYG7p6YCvR+z04wO421N48YaF/w+W0mrbI
         qOsPk3twNw2SbSrhBe/w+ba+9/AvORGOXXjC5jWVNbajYuYEFI9/6OxFL2+gNTqVBjKr
         l8t7YiHGhJxgiT9VzbHX5zphegKWSlEDtaa4YM3t7VlG/hiatuIoe9LEoBgE66zmlS9s
         c078VQ4GAkI1UfY+zWsaXKMjCajyzmoBbOHmSbPoR5AqqgfYHRkSVeezliq/guWRKuMU
         Rm6CvBZv3UTbDGFwm/EBk72WBE89np1uXlx83EPbfa8LmGgSEv15k3/zhS/3ay97F2ge
         WMjg==
X-Gm-Message-State: ACrzQf2w0BbLUAJUWIgggDae+Lk+o113IrHfn4qJXxs5uN2vfyhtfUuM
        KwzRYcCLPj86PDR6NhAYgfMrL+dz1mQ=
X-Google-Smtp-Source: AMsMyM5ekOWOFcdca93+eVsN635yLAhhpwoeVV3jAXeXy8EpW6MvI1tpWR/zW+fkuyk/hTENxkr2EA==
X-Received: by 2002:a05:600c:4f81:b0:3c8:3424:8b9 with SMTP id n1-20020a05600c4f8100b003c8342408b9mr4288022wmq.149.1666845949166;
        Wed, 26 Oct 2022 21:45:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c501100b003b4fdbb6319sm2031126wmr.21.2022.10.26.21.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:45:48 -0700 (PDT)
Message-Id: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Oct 2022 04:45:47 +0000
Subject: [PATCH] Mention that password could be a personal access token.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

These days, the 'password' for a software forge might be personal access
token or OAuth access token.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Mention that password could be a personal access token.
    
    These days, the 'password' for a software forge might be personal access
    token or OAuth access token.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1396%2Fhickford%2Fmore-about-credentials-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1396/hickford/more-about-credentials-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1396

 Documentation/git-credential.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index f18673017f5..f3bf0bef54b 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -142,7 +142,9 @@ Git understands the following attributes:
 
 `password`::
 
-	The credential's password, if we are asking it to be stored.
+	The credential's password, if we are asking it to be stored. If the
+	host is a software forge, this could also be a personal access
+	token or OAuth access token.
 
 `url`::
 

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
