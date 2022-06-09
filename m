Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D38CC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 13:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiFINzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiFINzc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 09:55:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BF3CFF2
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 06:55:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so32576602wrb.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=d2MflH0gzDhYeX1eKlzyV0/v0Il9kPbI4BbOxmALWVk=;
        b=Ctv3WYghpSPERjKcRCpH6UW9k6bRlqSJYuiBavMe1/uw/Exj88Xc2OsfIIHWcJwsJT
         sGEGTT2G8t32gXmvpd9N8JSwJlXekK1nVLAvr++6cnx1pldx/q73r43GEnKIRcxQ5Iog
         ZHlhyfqnIeghH9vwdE0NTB3gDtt188YDxzAbH9/7S4+v1cOG0/pATxzP2ZZawTtuGM6F
         51w21e2iu1Mq6Z3xFSL/9ozxT4ka2tE25Cs0HRQxpjZz0ZWpjihXWuht1KgOmaB0SAS4
         0RxzuE55M5sA/DpXZzT2Lb+cBBLL9p7uyzA/wzEiMAs5GkcaUS82/EiDLZtdfGRDSGSN
         6gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d2MflH0gzDhYeX1eKlzyV0/v0Il9kPbI4BbOxmALWVk=;
        b=YFT/MtWonjveMKz291IeAwGkEGqC4VVhzz3qTmmc/sooEDhdT7ZOr7eQMvCW9FMiaY
         hLhn7CgGL4MLwO73CuT6Ng46W1hjy+siJFKE1H6MtzKR9Xn1JDdTWLnsERerCRN7/mTh
         ZIJJzup150SmUoNnhE3hzKq3DUh4+Q0D9jBlFq4KKUJhki7DvSobKvOp0i+S6XvYuIi1
         YdlmVGUB6Wbi7yoqsWu4wKSiRaSvhQl0xXQt5G1yPebahv+HTLeDC3tDOKZI6S+NVyiK
         FfnTKFCzJSkFanXjYrcricJUfaETyB6KO9QfMdfwisHqIDl+/90x4ZGBpFdZjzGI3Fap
         TBpQ==
X-Gm-Message-State: AOAM530dHTsm6TWoJyNBNUJPpTgorY3YF0OpiYh7npOv/QNpDQxwcSk9
        ApzSLCv6Nzrd/Do/U6aX9QoMfczRc1STdnZs
X-Google-Smtp-Source: ABdhPJxYYRK6/txT9+GPMyH24zv6Y32ceulLFK8kKK6HQlhp4YUe2U+mUmW3+MAHyNe1oVlz51O6CQ==
X-Received: by 2002:a5d:5956:0:b0:217:77da:c27a with SMTP id e22-20020a5d5956000000b0021777dac27amr25183404wri.230.1654782921654;
        Thu, 09 Jun 2022 06:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b0039c5fb1f592sm7749257wms.14.2022.06.09.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:55:21 -0700 (PDT)
Message-Id: <pull.1255.git.1654782920256.gitgitgadget@gmail.com>
From:   "Cleber Rosa via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jun 2022 13:55:20 +0000
Subject: [PATCH] setup: fix function name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Cleber Rosa <crosa@redhat.com>, Cleber Rosa <crosa@redhat.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cleber Rosa <crosa@redhat.com>

The reference given to users when the result of
setup_git_directory_gently_1() is unexpected is incorrect.

This fixes the name of the function when presenting the BUG message.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
    setup: fix function name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1255%2Fclebergnu%2Ffix_function_name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1255/clebergnu/fix_function_name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1255

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index faf5095e44d..b5a537258d2 100644
--- a/setup.c
+++ b/setup.c
@@ -1402,7 +1402,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		 * find a repository.
 		 */
 	default:
-		BUG("unhandled setup_git_directory_1() result");
+		BUG("unhandled setup_git_directory_gently_1() result");
 	}
 
 	/*

base-commit: 9c897eef06347cc5a3eb07c3ae409970ab1052c8
-- 
gitgitgadget
