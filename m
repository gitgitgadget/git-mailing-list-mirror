Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE5C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E696103C
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhJYWb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhJYWb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:31:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EC4C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:29:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5so2389553wmb.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=nnF4+seBVebl8v+pBIggsvRdROqDjOMd8L5YZFqaRlY=;
        b=e9w6G3Ioj9mXwieOWUQonkJO2dgEVN3+gi8+gtSIeo7WTsE+RCHgs4FY1EUQgrlSEO
         BSH0aneC8VK9wLBtzDxq0pQV+ylaRb1m9Cm8wMLSxIzWaxYI4WogW2y3DfWeXN+8O87v
         yA7/UdJS6uRK9fW+rfJ9hUV8UOnfTJMiM4UFlwBLs3ZF2wfWj479MXBFhnlDc3eZMxNH
         Iqv8QjHdR9TQN+B2KF1VGSuueQmvQnWFYL7I65F8tS0u+tRjpO+383Cp8geBSkiEtQNX
         pZA7/PmvC3naXkWd282ZgYGu5MZEcbkKrwWFus/zHSkfGfG3fGIbLhSsJBgBuV6eNFif
         sdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=nnF4+seBVebl8v+pBIggsvRdROqDjOMd8L5YZFqaRlY=;
        b=eQZHCDqrs/ILZxTpLxxfygjXseptcyeh7GaKZ/LdBkbiZT3PiC4K5X7PiPe0d4iPzA
         x87f75Rs7jChukp+C4687jJL5zprUhIV+IIt0Tw/5VDVFvyl3ZrteQDTuFOjS86MV1Lx
         0GqPpRXh29aqu4evY1asGrYmrin0OxpUrulkGDT+sdrJsz7rnRdLTjMIHTJzs7PAuuVN
         cqgGX8bMxU4upDsH1IcyMYjIvGsOfxiG6nD2fundLBMurLSOK8FTGojx1NGO3W2yEBBO
         hMpWmJYmS2364ilgl0e0TNrGcmha9fifK2HIXdv8/Ha8jx+idOwqBGBfUi0FU6eCxX56
         o8dA==
X-Gm-Message-State: AOAM532xq7f2GlJjekmLOPQdwcM3SzAPSw8XgCK7Ep89vJoBIPtilUp4
        uPxE4nwBq8eGRWn3f1MMssCm+SoSrPs=
X-Google-Smtp-Source: ABdhPJzDO1XZTf7ZKW7jV1hcTD1QvzSAZA3iLS+ue87bIhKG6ot6MoFz+XlFJR/RVgrZ6MWyfgy9yQ==
X-Received: by 2002:a05:600c:35cd:: with SMTP id r13mr2802370wmq.24.1635200974294;
        Mon, 25 Oct 2021 15:29:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm12599209wrt.8.2021.10.25.15.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:29:34 -0700 (PDT)
Message-Id: <pull.1096.v2.git.git.1635200973354.gitgitgadget@gmail.com>
In-Reply-To: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Oct 2021 22:29:33 +0000
Subject: [PATCH v2] completion: fix incorrect bash/zsh string equality check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Estelle <robertestelle@gmail.com>,
        Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

In the basic `[`/`test` command, the string equality operator is a
single `=`. The `==` operator is only available in `[[`, which is a
bash-ism also supported by zsh.

This mix-up was causing the following completion error in zsh:
> __git_ls_files_helper:7: = not found

(That message refers to the extraneous symbol in `==` ← `=`).

This updates that comparison to use a single `=` inside the
basic `[ … ]` test conditional.

Although this fix is inconsistent with the other comparisons in this
file, which use `[[ … == … ]]`, and the two expressions are functionally
identical in this context, that approach was rejected due to a
preference for `[`.

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
    completion: Fix incorrect bash/zsh string equality check
    
    v2: This updates the comparison to remove the extraneous = symbol in ==,
    and use the [ … ] conditional instead.
    
    v1: (rejected) updated that comparison to use the extended [[ … ]]
    conditional for consistency with the other checks in this file.
    
    This fixes an error in contrib/completion/git-completion.bash caused by
    the incorrect use of == (vs. single =) inside a basic [/test command.
    Double-equals == should only be used with the extended [[ comparison.
    
    This was causing the following completion error in zsh:
    
    > __git_ls_files_helper:7: = not found
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1096%2Frwe%2Ffix-completion-sh-eq-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1096/rwe/fix-completion-sh-eq-v2
Pull-Request: https://github.com/git/git/pull/1096

Range-diff vs v1:

 1:  6fd09347385 ! 1:  eee166c8c99 completion: fix incorrect bash/zsh string equality check
     @@ Commit message
      
          (That message refers to the extraneous symbol in `==` ← `=`).
      
     -    This updates that comparison to use the extended `[[ … ]]` conditional
     -    for consistency with the other checks in this file.
     +    This updates that comparison to use a single `=` inside the
     +    basic `[ … ]` test conditional.
     +
     +    Although this fix is inconsistent with the other comparisons in this
     +    file, which use `[[ … == … ]]`, and the two expressions are functionally
     +    identical in this context, that approach was rejected due to a
     +    preference for `[`.
      
          Signed-off-by: Robert Estelle <robertestelle@gmail.com>
      
     @@ contrib/completion/git-completion.bash: __gitcomp_file ()
       __git_ls_files_helper ()
       {
      -	if [ "$2" == "--committable" ]; then
     -+	if [[ "$2" == "--committable" ]]; then
     ++	if [ "$2" = "--committable" ]; then
       		__git -C "$1" -c core.quotePath=false diff-index \
       			--name-only --relative HEAD -- "${3//\\/\\\\}*"
       	else


 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4bdd27ddc87..8ca9b15f21d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -515,7 +515,7 @@ __gitcomp_file ()
 # argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
-	if [ "$2" == "--committable" ]; then
+	if [ "$2" = "--committable" ]; then
 		__git -C "$1" -c core.quotePath=false diff-index \
 			--name-only --relative HEAD -- "${3//\\/\\\\}*"
 	else

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
