Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDFDC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiBYLoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiBYLol (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:44:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB041E1120
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so4823570wmj.1
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SgPTNZ8iITWi9FWWzeQPkVZ0XNidtSNTaGCIO1fbJGI=;
        b=GRtKUdSR1D9afQ/PNKnISFQU7vAD3PW/RZHnEOqfzaH6CbGiyxApqCa/oWIRCUSxXr
         Df9E/WyMnM1HkOsBh7y8cYj1ZEjKP10sRIjcNJVbna+ZGLkHl5jVJLS8SM30YnhQvZ0w
         bgWGp628Ynt8qMQVt9nFrhbDfRbtszbgfToh6NsJicYBfjMoMlEujr2DLhKXs1Q7wLpG
         FOWY/u3M6QiTd9GjjMGc0xxWx9TiK9FBSlUYv39qm0LdPvgQffpEo0PZ+KPT408LjddG
         3k9gsa05lzggBb4KOzc8Wrk9Tb9JHL0S72+wYBPAIwq+BAg3sHHOklOke2wdnUWgyTXg
         XPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SgPTNZ8iITWi9FWWzeQPkVZ0XNidtSNTaGCIO1fbJGI=;
        b=JltgDjogLzmm47cmqDsB6hJTxPvXTDSuXYvcEY6Yzsocj2MhkAIw2yE7Rri+lgmc3V
         8eMfG5YcQ8SGRqv3Lkorc2tACVZi8y59qHKUkBqOBOJuTtUgYTLzBpC3p4EkE+7q5qUn
         1GHzNMUofDQSKFBhOfz7+REz9mR1t87a+rvEjnTRnQ+Dc/k1Fm6veyMNpN2UynaKFLSz
         wCKvvslGK+Wb/DsEo7Zgm/MPq4fCLmcCzSFNotwqTkO/BXrz2Mj0u4bhRqaYpeRUbJGm
         ZhCQasNV0jTlW3nuXl3nX9pcrlOYkTCQJJF8qcB80uyy6LmvRrYrABvWE1vWrI71crSg
         4bLA==
X-Gm-Message-State: AOAM530Y4l6dRhqAFZ78JUDygNdBFI58lIPsZJSJdlyyjCb7Dan44zOG
        XCWGRFgcgoZyCnYqL8JwTQOmrSOrTj4=
X-Google-Smtp-Source: ABdhPJw1wGDXze35r/oSqcVQtBTyVLGzbUb9BjUPRrWqs1gKJEBPCU5MGvbdcZV91HDE/IS3gi0Pwg==
X-Received: by 2002:a7b:cd96:0:b0:381:201e:ba06 with SMTP id y22-20020a7bcd96000000b00381201eba06mr2411695wmj.78.1645789447412;
        Fri, 25 Feb 2022 03:44:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b001edc00dbeeasm1910820wrw.69.2022.02.25.03.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:44:07 -0800 (PST)
Message-Id: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:44:02 +0000
Subject: [PATCH 0/4] In PS1 prompt, make upstream state indicators consistent with other state
 indicators
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are about the characters and words that can be configured to
display in the PS1 prompt after the branch name. I've been unable to find a
consistent terminology. I refer to them as follows: [short | long] [type]
state indicator where short is for characters (e.g. ?), long is for words
(e.g. |SPARSE), and type is the type of indicator (e.g. sparse or upstream).
I'd be happy to change the commit messages to a different terminology if
that's preferred.

There are a few inconsistencies with the PS1 prompt upstream state indicator
(GIT_PS1_SHOWUPSTREAM).

 * With GIT_PS1_SHOWUPSTREAM="auto", if there are no other short state
   indicators (e.g. + for staged changes, $ for stashed changes, etc.), the
   upstream state indicator appears adjacent to the branch name (e.g.
   (main=)) instead of being separated by SP or GIT_PS1_STATESEPARATOR (e.g.
   (main =)).
 * If there are long state indicators (e.g. |SPARSE), a short upstream state
   indicator (i.e. GIT_PS1_SHOWUPSTREAM="auto") is to the right of the long
   state indicator (e.g. (main +|SPARSE=)) instead of with the other short
   state indicators (e.g. (main +=|SPARSE)).
 * The long upstream state indicator (e.g. GIT_PS1_SHOWUPSTREAM="verbose")
   is separated from other (short or long) state indicators by a hard-coded
   SP. Other long state indicators are separated by a hard-coded pipe (|).

These patches are to make the upstream state indicators more consistent with
other state indicators.

Justin Donnelly (4):
  git-prompt: rename `upstream` to `upstream_type`
  git-prompt: make upstream state indicator location consistent
  git-prompt: make long upstream state indicator consistent
  git-prompt: put upstream comments together

 contrib/completion/git-prompt.sh | 59 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 29 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1162%2Fjustinrdonnelly%2Fgit-prompt-upstream-consistency-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1162/justinrdonnelly/git-prompt-upstream-consistency-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1162
-- 
gitgitgadget
