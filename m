Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E4C54EAA
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 21:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjAZVVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjAZVVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 16:21:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F174571656
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 13:21:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k16so2112619wms.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQVQUgShsSeTCDFT2hsAIj8VCiYb+GtOCAkx60CCsTw=;
        b=hxxljC82Y2hVZEU+noSWkMIskeI7jlbrCKmr/g4ioAuWYaUCuJL0Mv14ODiAuh8PvP
         zG+w2+v8fu41zdIglbXJdk33mRwRBIMrbd7ZC98Co3wk+Dr2L59WSS0zEka+BBFW1+eQ
         pmlgFH4auq8DUCQFUkTCB1nPiU9uWGi6Fz6z9CCgBu4oLUU6UIgwF80ontNK4mvpPH3n
         /ApODjqd9/wL2m8Jhs9ARsduFYfORc+3NFAtBQJOK1S9sZl0BnmTF3Wv15SOFuUGBqXV
         /043K/MFKSHxihfVsmdtUQbMQmgIUORYO0r/+tNcUDcsd1w2Y7rG2YzIazdBVehZxCP4
         jgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQVQUgShsSeTCDFT2hsAIj8VCiYb+GtOCAkx60CCsTw=;
        b=UoT3PJAHL0Jdf8OvZVy0AnjRICtZB+85HsStMCGxQ69jhalCfF3SZA1INRdSLV/bDw
         7/TG2xibRRmruAvcuUl/Cpw9bAzRnrwQYF6P+iDs8gsiuoOAYXr+DYnMsQa9FNkGyMGP
         KS/PcOXsIVxKDKuGlUGfaoVbb+jKu8ozAjhp3B9r3HBvgx+67ywdpkI7KkaOzLAe/bg/
         qT/MXn2WI3qALxh/z28kvzi8iKpkqlyWiLxG/sBLAKquxUI5kCSC3Ve/bsbVfbK44Ysw
         sgQ7Pk520os0m5tgRUJgO5D8KMrUHGKd4/GX9dm5K3ujLBGHHazoGvdjelX1QX3dGLhp
         MpSw==
X-Gm-Message-State: AO0yUKXBI1Fmafcwq5KRS9AshtYkskGJ6az6I/B+pbwUsRgbgQ5BXg8K
        Lf+q8PE4CwyKNTk/2UnznvEBwgAvVSo=
X-Google-Smtp-Source: AK7set9fTdrBLLAIPJRZ3V6SAWPJeVOqNWuxRcD8LXzPuuwrHXSINj5umoKEv7JJ32W8h6Ossf5YhQ==
X-Received: by 2002:a05:600c:d7:b0:3dc:32f1:d99a with SMTP id u23-20020a05600c00d700b003dc32f1d99amr171132wmm.6.1674768109133;
        Thu, 26 Jan 2023 13:21:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d9fba3c7a4sm6098065wmq.16.2023.01.26.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:21:48 -0800 (PST)
Message-Id: <pull.1441.v3.git.git.1674768107941.gitgitgadget@gmail.com>
In-Reply-To: <pull.1441.v2.git.git.1674447742078.gitgitgadget@gmail.com>
References: <pull.1441.v2.git.git.1674447742078.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Jan 2023 21:21:47 +0000
Subject: [PATCH v3] attr: fix instructions on how to check attrs
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

The instructions in attr.h describing what functions to call to check
attributes is missing the index as the first argument to
git_check_attr(), as well as tree_oid as the second argument.

When 7a400a2c (attr: remove an implicit dependency on the_index,
2018-08-13) started passing an index_state instance to git_check_attr(),
it forgot to update the API documentation in
Documentation/technical/api-gitattributes.txt. Later, 3a1b3415
(attr: move doc to attr.h, 2019-11-17) moved the API documentation to
attr.h as a comment, but still left out the index_state as an argument.

In 47cfc9b (attr: add flag `--source` to work with tree-ish 2023-01-14)
added tree_oid as an optional parameter but was not added to the docs in
attr.h

Fix this to make the documentation in the comment consistent with the
actual function signature.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    attr: fix instructions on how to check attrs
    
    The instructions in attr.h describing what functions to call to check
    attributes is missing the index as the first argument to git_check_attr.
    
    Fix this to make it consistent with the actual function signature.
    
    Changes since V2:
    
     * updated with adding second argument after rebasing against master
    
    Changes since V1:
    
     * updated commit message to include some history
    
    Signed-off-by: John Cai johncai86@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1441%2Fjohn-cai%2Fjc%2Ffix-attr-docs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1441/john-cai/jc/fix-attr-docs-v3
Pull-Request: https://github.com/git/git/pull/1441

Range-diff vs v2:

 1:  8cfee55e48f ! 1:  cf6f456af47 attr: fix instructions on how to check attrs
     @@ Commit message
      
          The instructions in attr.h describing what functions to call to check
          attributes is missing the index as the first argument to
     -    git_check_attr().
     +    git_check_attr(), as well as tree_oid as the second argument.
      
          When 7a400a2c (attr: remove an implicit dependency on the_index,
          2018-08-13) started passing an index_state instance to git_check_attr(),
     @@ Commit message
          (attr: move doc to attr.h, 2019-11-17) moved the API documentation to
          attr.h as a comment, but still left out the index_state as an argument.
      
     +    In 47cfc9b (attr: add flag `--source` to work with tree-ish 2023-01-14)
     +    added tree_oid as an optional parameter but was not added to the docs in
     +    attr.h
     +
          Fix this to make the documentation in the comment consistent with the
          actual function signature.
      
     @@ attr.h
        *
        * setup_check();
      - * git_check_attr(path, check);
     -+ * git_check_attr(&the_index, path, check);
     ++ * git_check_attr(&the_index, tree_oid, path, check);
        * ------------
        *
        * - Act on `.value` member of the result, left in `check->items[]`:


 attr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.h b/attr.h
index 58a2bc1344f..9884ea2bc60 100644
--- a/attr.h
+++ b/attr.h
@@ -45,7 +45,7 @@
  * const char *path;
  *
  * setup_check();
- * git_check_attr(path, check);
+ * git_check_attr(&the_index, tree_oid, path, check);
  * ------------
  *
  * - Act on `.value` member of the result, left in `check->items[]`:

base-commit: 5dec958dcf965fc75e0f459f8e8ccf9c9f495b15
-- 
gitgitgadget
