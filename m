Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D96C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiDFVaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiDFVaY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:30:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEEBD76C6
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 13:33:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i6-20020a1c3b06000000b0038e710da2dcso4385474wma.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEkoq9/+5EyKFhSL6rhewn4bj8nc3ARfwtiP1HR7OPY=;
        b=wzPcHKf3qiBeJuf8AnTbYQkixpMMyEM33JNgrzdfscc7CMrutTLFIpIFKvI0czfdp0
         BdZsr6ABlWkmZW8iR5sU820LcMN1Yw1Bi5m98jodu2dyk9odqsb6SGZVncQe3eKSstGX
         1iX8z5q6hD+oa12BTTYeLqziMr+vkjBIEMulw0LvL9zJcfE9tUCXnPKLidy8s5mn9+Mk
         sH5/zLANaQpUDIRZsNx11ig/a1v1ZTynsQQkWhuFqEmwpPNyzGzyTMDRSc5d0obNVZFx
         WfGXTaRmBh/rLQi+Tdn5z91e9fW8SupiFgERtjbfRSnvshf106GvYYWD8LJ7WVcK5LoS
         oKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEkoq9/+5EyKFhSL6rhewn4bj8nc3ARfwtiP1HR7OPY=;
        b=TUXXHhhFuzQslMrVbhnZeBKXrtpcOPcdtbnQjzx7Zs116MlxuIJVT+zIvOx9PK3IzQ
         jA01sRPmBi1MeH3LlV2O7BkgFsSqw5b9P4FvIu6UMsSDcGmF3ltQFNEYSXGdiQVRIY74
         bjSn9O3PrdLuDwryEYCd810teHAvawiiHVrASl4XdXQ7zG3ALZmbmGfxTa0mGZq+ao4C
         9YxNg/LEE4fzQ0mPak2kzrgFU+60CWgb3KTx41jr0Txj1HYq1yz8UqzwXhSwqmO5Nxo3
         MI7beCs6GIpUuTYKKowJKz/wlNNfPDYAgNwAILjVFWNWHhV/DjACAuXPJ2vmbdX2WDXs
         EiEw==
X-Gm-Message-State: AOAM533WYZz+qP6S6isdbmminqHrm2x8lMKOh2fL7cvJOdTl2m+0bqT8
        qfjLKo+1jJ5GwarYGTNv28bcgPQClF/9/8q3
X-Google-Smtp-Source: ABdhPJxrYr+M2HagOF324U9aptG+pIDpbn6v+vFoDnp56TIoy97r9AbW7tE02wLiM3UkEhNiV/5Jqg==
X-Received: by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id n65-20020a1c2744000000b00382a9b71c8amr8802510wmn.187.1649277192380;
        Wed, 06 Apr 2022 13:33:12 -0700 (PDT)
Received: from strength.. (cpc157871-brnt5-2-0-cust279.4-2.cable.virginm.net. [86.4.97.24])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d47ce000000b00203e0a21c16sm18842018wrc.3.2022.04.06.13.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:33:11 -0700 (PDT)
From:   Fangyi Zhou <me@fangyi.io>
To:     git@vger.kernel.org
Cc:     Fangyi Zhou <me@fangyi.io>
Subject: [PATCH] submodule-helper: Fix a missing space
Date:   Wed,  6 Apr 2022 21:32:57 +0100
Message-Id: <20220406203256.16100-1-me@fangyi.io>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The missing space at the end of the line makes the closing square
bracket sticking to the dash in the next line

Found during localisation v2.36.0 round 1

Signed-off-by: Fangyi Zhou <me@fangyi.io>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c3e0d4570f..0b8b226c8f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1902,7 +1902,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
-		   "[--single-branch] [--filter <filter-spec>]"
+		   "[--single-branch] [--filter <filter-spec>] "
 		   "--url <url> --path <path>"),
 		NULL
 	};
-- 
2.35.1

