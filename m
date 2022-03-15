Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A7CC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 00:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343987AbiCOAxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 20:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiCOAxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 20:53:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0264F427D5
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 17:52:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso536907wmz.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 17:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dsg24yq2gWj4NqAZX1n0pboJ/KeWSsSblaFmSOVvGF8=;
        b=ob+Avs9dDaRpgqtBzHB/wMJJDUVQgaywwT07KUU1D8sxsKukc8JWl6Q0za5BXQ3lK9
         +mw8pDSnEWRKqeFBHRHwUN3OboM3zTlnFVkenHG5UG5ty/ueyfNu3OUXUnFLrrokRrBn
         v9Sxh90TwDizJmL/cx+VIgih5OlaF7iiPpBTpo6qfAEUosDmluosQki0SsACAHqF8ngl
         U6BMmDpJZDSajGNtxbphpP7C/grdf4WoxDT0vbU5Xj2sZQKDuEltjimeP0xi3Gyo3T7W
         RZWxanqRW3SM29HCoe18h5ZHqxz0HolnD8sTLwX7xSHdbD3639ReqMlmDduizRb1YCVa
         sB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dsg24yq2gWj4NqAZX1n0pboJ/KeWSsSblaFmSOVvGF8=;
        b=Qv7d0S0bVNvvss0aJVZai3Li1f0fj0DvRHed9F5fzOuhzuCZK9ov3dhKmdj+1No1RR
         ou1zQZbbmpciGI6ucYAhdp58Ig9ssXJWdhOcKSbgi4sAEwYFZBtmXC2YN4Y7rfI1eWzg
         X8sfGWxXt2mFPJwmv4bASgdNcgP6FUpT9u3ul5oXFVK0qJDmqp7t4ulrvKXjotVv5Cy+
         U048fkFivuOt4BI3adbeVYcWHRF3khSZ1+003B7A5vp2zwspHSNyXi2sFthSf8mfbkhl
         HcoK+pdN7XUsL9+gOOPsifNInk1ebw2ub2DT1JKlRsNLiht5LBQ5cfslqc4D5WBwbuYM
         c1bQ==
X-Gm-Message-State: AOAM533/HuiGSUjhzP4Jehk7vdXuIYluHofoJvNdnqOOJA/IZg8rlHfK
        xQ2/MhYY3JZir7YHONLBa860PVh7EZw=
X-Google-Smtp-Source: ABdhPJxJjYhZ6n5gfXO+HwYs4tnIeOx9vtjNCfb2N/AaL7PJkg4zmHE7fQZpWpqqBIHAXxtRlZDCUg==
X-Received: by 2002:a7b:cb46:0:b0:37b:dd79:e1c4 with SMTP id v6-20020a7bcb46000000b0037bdd79e1c4mr1249341wmj.39.1647305548484;
        Mon, 14 Mar 2022 17:52:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b00389f80668cesm811363wma.28.2022.03.14.17.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:52:28 -0700 (PDT)
Message-Id: <pull.1227.v2.git.git.1647305547.gitgitgadget@gmail.com>
In-Reply-To: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
From:   "David Cantrell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 00:52:25 +0000
Subject: [PATCH v2 0/2] Improved bash tab completion for 'git restore' - adds support for
 auto-completing filenames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Cantrell <david@cantrell.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds tab-completion of filenames to the bash completions for git
restore.

David Cantrell (2):
  tab completion of filenames for 'git restore'
  if a file has been staged we don't want to list it

 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1227%2FDrHyde%2Ffilename-completion-for-git-restore-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1227/DrHyde/filename-completion-for-git-restore-v2
Pull-Request: https://github.com/git/git/pull/1227

Range-diff vs v1:

 1:  2bb8f1cb1c4 = 1:  2bb8f1cb1c4 tab completion of filenames for 'git restore'
 -:  ----------- > 2:  16aa4d0b2e4 if a file has been staged we don't want to list it

-- 
gitgitgadget
