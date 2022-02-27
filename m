Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE83C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiB0T54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiB0T5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:57:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E4633A1B
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j22so12286034wrb.13
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZAL+o4PsgaP8WOiuJBQHaoO5N1tG0oZKAYZiJZAIgi4=;
        b=ayxhFB5A8N3p7pNjp+FDfxyNywxOLKQj8eA3mgnKoWPzCOgMwUuEU9MBAykQ8dkaZP
         /TzBySJJzrEBnYde5CjR+x243fCRNZXQBNmgwHkTFMOAx/H0779CdqzkfM/iJZX09KQg
         QdZiF07+IXxhk/DGA7KeN3GrzrCM+D9qj0LIGhVNCy/NtiJ5oWhKrgQyZJ58hxNdjgVr
         sCZoIQv3vTvdHcgkFPX7wd7Tqq9jdDcwYFkQQesRVoxrTsebrjUkM9G76OjAWrhu508Q
         9U/lP/4STEpC+mIlaQ5HRLw8Wei9sr55JvCVWFGYZtb0qe+5oNi5HMS9yI8SP0qT3oaA
         UyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZAL+o4PsgaP8WOiuJBQHaoO5N1tG0oZKAYZiJZAIgi4=;
        b=RJnnDMeBFuKENknJD9yjIgPHQQUeHxrx2NYyd8L+d6FURDRjF2enB9/4Oib5TEqfpb
         5L+IeYcNHyw/GMQL2+2RFRFfAFW1LB/g1jkzeB/4BNdSMCYUNLL2pWdjZ3028ojgYRpZ
         MDRN2kBvFpCLAxl4HWRsFGJIpg/10dQXmPhbmX6bAEERnvybgQjd7424L3GA3CVhgNx9
         BaTLi2+hUvMZ5C9KsQVwc1sueYuaqNI909hG3hZkoD5+WsYXBpw2aIypMo+ryXisvv5+
         HJmMqu4cakdoo3MY/j/nGl+xq/1FlzQW37xsSorhE1NvZqAbzwgGhtCJzN/07dk46Ps+
         XWMg==
X-Gm-Message-State: AOAM533aYcwfykcZSe0o4+05hI/5SGoo87VfpLkVrczFS2TeY67vtH7M
        GRza555OPSHdXn2ty9wGKxwaImezCTE=
X-Google-Smtp-Source: ABdhPJxXCNS1WuP/8AZFmuYE27puAfE3M+ZpE0Lt4dmz5ThHuJ2AmP0QXfrKdOQ87v0ZebsuJTCJHw==
X-Received: by 2002:a5d:56c8:0:b0:1ef:89f4:ae56 with SMTP id m8-20020a5d56c8000000b001ef89f4ae56mr5442562wrw.444.1645991833617;
        Sun, 27 Feb 2022 11:57:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm12253018wmj.42.2022.02.27.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 11:57:13 -0800 (PST)
Message-Id: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 19:57:08 +0000
Subject: [PATCH v2 0/4] In PS1 prompt, make upstream state indicators consistent with other state
 indicators
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Justin Donnelly <justinrdonnelly@gmail.com>
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

----------------------------------------------------------------------------

Changes since v1:

 * Added __git_ps1 examples and before/after tables to commit messages where
   applicable. This should make it clearer what the behavior is for other
   (not upstream) state indicators, and how the patches make the upstream
   state indicator more consistent.
 * Removed some extraneous information about long state indicators from
   patch 2 commit message. This wasn't really helpful, and was a
   distraction.

----------------------------------------------------------------------------

Justin Donnelly (4):
  git-prompt: rename `upstream` to `upstream_type`
  git-prompt: make upstream state indicator location consistent
  git-prompt: make long upstream state indicator consistent
  git-prompt: put upstream comments together

 contrib/completion/git-prompt.sh | 59 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 29 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1162%2Fjustinrdonnelly%2Fgit-prompt-upstream-consistency-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1162/justinrdonnelly/git-prompt-upstream-consistency-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1162

Range-diff vs v1:

 1:  1db836bb309 = 1:  1db836bb309 git-prompt: rename `upstream` to `upstream_type`
 2:  b503cac5ae3 ! 2:  4bf120b1bf8 git-prompt: make upstream state indicator location consistent
     @@ Commit message
          git-prompt: make upstream state indicator location consistent
      
          Make upstream state indicator location more consistent with similar
     -    state indicators (e.g. sparse). Group the short state indicator (`=`,
     -    `<`, `>`, or `<>`) with other short state indicators immediately after
     -    the branch name. Group the long state indicator (e.g. `u+2-1
     -    origin/main`) with other long state indicators after the short state
     -    indicators. Previously short and long upstream state indicators appeared
     -    after all other state indicators.
     +    state indicators (e.g. sparse). Group the short upstream state indicator
     +    (`=`, `<`, `>`, or `<>`) with other short state indicators immediately
     +    after the branch name. Previously short and long upstream state
     +    indicators appeared after all other state indicators.
      
          Use a separator (`SP` or `GIT_PS1_STATESEPARATOR`) between branch name
          and short upstream state indicator. Previously the short upstream state
          indicator would sometimes appear directly adjacent to the branch name
     -    (e.g. `(main=)`) instead of being separated (e.g. `(main =)`).
     +    instead of being separated.
     +
     +    For comparison, `__git_ps1` examples without upstream state indicator:
     +    (main)
     +    (main %)
     +    (main *%)
     +    (main|SPARSE)
     +    (main %|SPARSE)
     +    (main *%|SPARSE)
     +    (main|SPARSE|REBASE 1/2)
     +    (main %|SPARSE|REBASE 1/2)
     +
     +    Note that if there are short state indicators, they appear together
     +    after the branch name and separated from it by `SP` or
     +    `GIT_PS1_STATESEPARATOR`.
     +
     +    Before/after examples with short upstream state indicator:
     +    | Before           | After            |
     +    | ---------------- | ---------------- |
     +    | (main=)          | (main =)         |
     +    | (main|SPARSE=)   | (main =|SPARSE)  |
     +    | (main %|SPARSE=) | (main %=|SPARSE) |
      
          Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
      
 3:  83766e33614 ! 3:  0af083413b8 git-prompt: make long upstream state indicator consistent
     @@ Metadata
       ## Commit message ##
          git-prompt: make long upstream state indicator consistent
      
     -    Use a pipe as a delimiter between short state indicators and long
     -    upstream state indicator (e.g. `(main *|u+2-1 origin/main)` instead of
     -    `(main * u+2-1 origin/main)`) . This is consistent with long state
     -    indicators for sparse and in-progress operations (e.g. merge).
     +    Use a pipe as a separator before long upstream state indicator. This is
     +    consistent with long state indicators for sparse and in-progress
     +    operations (e.g. merge).
     +
     +    For comparison, `__git_ps1` examples without upstream state indicator:
     +    (main)
     +    (main %)
     +    (main *%)
     +    (main|SPARSE)
     +    (main %|SPARSE)
     +    (main *%|SPARSE)
     +    (main|SPARSE|REBASE 1/2)
     +    (main %|SPARSE|REBASE 1/2)
     +
     +    Note that if there are long state indicators, they appear after short
     +    state indicators if there are any, or after the branch name if there are
     +    no short state indicators. Each long state indicator begins with a pipe
     +    (`|`) as a separator.
     +
     +    Before/after examples with long upstream state indicator:
     +    | Before                          | After                           |
     +    | ------------------------------- | ------------------------------- |
     +    | (main u=)                       | (main|u=)                       |
     +    | (main u= origin/main)           | (main|u= origin/main)           |
     +    | (main u+1)                      | (main|u+1)                      |
     +    | (main u+1 origin/main)          | (main|u+1 origin/main)          |
     +    | (main % u=)                     | (main %|u=)                     |
     +    | (main % u= origin/main)         | (main %|u= origin/main)         |
     +    | (main % u+1)                    | (main %|u+1)                    |
     +    | (main % u+1 origin/main)        | (main %|u+1 origin/main)        |
     +    | (main|SPARSE u=)                | (main|SPARSE|u=)                |
     +    | (main|SPARSE u= origin/main)    | (main|SPARSE|u= origin/main)    |
     +    | (main|SPARSE u+1)               | (main|SPARSE|u+1)               |
     +    | (main|SPARSE u+1 origin/main)   | (main|SPARSE|u+1 origin/main)   |
     +    | (main %|SPARSE u=)              | (main %|SPARSE|u=)              |
     +    | (main %|SPARSE u= origin/main)  | (main %|SPARSE|u= origin/main)  |
     +    | (main %|SPARSE u+1)             | (main %|SPARSE|u+1)             |
     +    | (main %|SPARSE u+1 origin/main) | (main %|SPARSE|u+1 origin/main) |
      
          Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
      
 4:  58ff3d8affe = 4:  06e51dc5093 git-prompt: put upstream comments together

-- 
gitgitgadget
