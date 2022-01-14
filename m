Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A379C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiANRuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 12:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiANRuS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 12:50:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F3EC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 09:50:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so7053424wme.0
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Lx0qUS6UaQO4TW3AiFpKTCr9Mj7BmqnsS8Dy3Wzn+Ps=;
        b=YRk8XRuqizaoIe87mKVmaL1nIREJxshMqwa64uofsxzZf92GrYGsKvOM9USZ1d2+dR
         trG4UnUBKQWMLU+L7TmrjBavPdILPhKNVM2Sa8UsQh4HMn+MqJYn2jIrBNeOlMK+E42o
         4Fsy6AjBVA0Y4XRUs9SsY+DaS3ueeLNWHplT2sB8HOMGWcdtOKx16QWX4NU0flzKBUNm
         F+6wXrytLkYkTFxQ9ucKt96gRV2L6QAF39L/h/PGKknpXimoVO39u5vTH9bfMNBWsEUv
         kpSWBAd8kBBH/zXaKsvhjc8stSa8qnw4c1pX/n8Feq1vlgTfaxVo9BW7jPVYehaABvQL
         1OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lx0qUS6UaQO4TW3AiFpKTCr9Mj7BmqnsS8Dy3Wzn+Ps=;
        b=ZqKWkef8OVCAvr5ZipLeFkKWPCFQxaYEgwmsrdcGcPoGlMbTt6eWNnt3/0A7SzGcN4
         avqGympMcacODu21BOeACY7JqvocAo7s6xN7AY8f1MNE6o/m5g9UtcyXfir44jdC+e8a
         WqJmhiu28jQrxAdvne+pI5Q27g/8X+eaNRo/4nImI5pqR0jfvwdYRYIQkt98l9hKloxP
         S72K+o7QFEJCEcva6UV16oNrKPTkgiETODckcvJgNVK+ZqiXKUl/VXjxblZ7WhrfGGVB
         VT/Ajso5P1It/tKss8s/TBMiBQrWeCBiGvyNTQ1GqFFYCuG74YzWezfY/orHA3ZA/OrU
         rtug==
X-Gm-Message-State: AOAM533lMwS81Z9P2cybo6/4HAy4Yp/K6niNQZ/RIAiOoxuRic7i4Sqd
        TWzOeL/+cgPdLwppgWDn8OdZl28liiM=
X-Google-Smtp-Source: ABdhPJwWiB8Gs/32sU+BdkQhcVfDLSbJtGCQQ9q3XroxnkcGvGdaOUxI1RKioNz+YmSfOHWERP7Hxg==
X-Received: by 2002:a05:6000:1002:: with SMTP id a2mr8949698wrx.157.1642182616268;
        Fri, 14 Jan 2022 09:50:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm1670295wrt.37.2022.01.14.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 09:50:15 -0800 (PST)
Message-Id: <pull.1115.git.1642182615339.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jan 2022 17:50:15 +0000
Subject: [PATCH] README.md: add CodingGuidelines and a link for Translators
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Also space out the list joining instructions and clarify the subscription
via the majordomo address.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
    README.md: add CodingGuidelines and a link for Translators
    
    Also space out the list joining instructions and clarify the
    subscription via the majordomo address.
    
    Signed-off-by: Philip Oakley philipoakley@iee.email

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1115%2FPhilipOakley%2FReadme-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1115/PhilipOakley/Readme-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1115

 README.md | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index f6f43e78deb..5c956dea6e0 100644
--- a/README.md
+++ b/README.md
@@ -32,10 +32,16 @@ installed).
 The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
 requests, comments and patches to git@vger.kernel.org (read
-[Documentation/SubmittingPatches][] for instructions on patch submission).
+[Documentation/SubmittingPatches][] for instructions on patch submission
+and [Documentation/CodingGuidelines]() ).
+
+Those wishing to help with error message translation (localization L10)
+should see [po/README.md]()
+(a `po` file is a portable object file for the translations).
+
 To subscribe to the list, send an email with just "subscribe git" in
-the body to majordomo@vger.kernel.org. The mailing list archives are
-available at <https://lore.kernel.org/git/>,
+the body to majordomo@vger.kernel.org (not the list). The mailing list
+archives are available at <https://lore.kernel.org/git/>,
 <http://marc.info/?l=git> and other archival sites.
 
 Issues which are security relevant should be disclosed privately to

base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
-- 
gitgitgadget
