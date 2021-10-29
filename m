Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED7C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE3B60524
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJ2VSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJ2VR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:17:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5DCC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i5so10952253wrb.2
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qbHSVj/U7oFgIvvMGD4C+LLQFHHGlSj4PtHqPQSORws=;
        b=cYXMGgZtRiiIRl5csC3tvUXoGjiawCueWDyBGdb3iD091xMhwlWITqIQlnaIK90wn1
         64HLMoC5iufwqeGuWpQOGAMKUojhr/FuVjVV3P2lzDRBPKfpLW4UIga4brarZKKdYw26
         f8BLllAlZDlNFIFrN10U0Fg9gPRnrYWdS+XIvnxNGQWh/s2YMa5HyTMypt5WLHumeUMG
         /bikvzyhKiXDBjOSua9vf1JZFJl8u6BoQbKrIpUau5zcIDOnG94/xC4v6B3JdZQbiW3t
         /mwIDXE+pWQsDLhQjnz9Cz8KeOd9JBVZybHqKKAQ/NFq0VjBPJKAX+fLm9pix4brnoZh
         nxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qbHSVj/U7oFgIvvMGD4C+LLQFHHGlSj4PtHqPQSORws=;
        b=AehDvN5CFfWMPsPDlEHFBFpymJPKLfYXmTsVXbUj2Aa67X2evJmQOGtoHJyNH1MMZc
         OKuizOpJw/dzGXtoCuyPJbCMNtgG1letReq6fdNJ7KwCQmi6M93tCBck7g83qLiiDj2m
         qyus/ihISBEKzfLpGaw+sGf6HXvtMSvZC8cbcN3lYIGenmmu7CV1Fi5EHo44ayJEU0D0
         X1NoT+EMCtU5+wD6hxys4AWFZ/+Tq5SjLzAWt+KhvLTOcs46wZ315A33bLTuFIhhQGMH
         OMnDDA5N8GEGJV2aTLjn7p+ra8QhwHiOk97XqwQTn7cDyfRx6zC0qwMKHPbr35oFrKMN
         bATw==
X-Gm-Message-State: AOAM531ExNqq2KU27o76l3+4HXvNSNarTR0WH12Ivy42pKFmDUUKCgyM
        oewaK0rx2fKe5p1+rpcj9jibFuaDpGzovg==
X-Google-Smtp-Source: ABdhPJwCQRE2NZVQdqB1CWbLsklWC1tH1POlAiirrKaE10xNP7lIWsaAUfQ/DbgavOUahYbwSdJlLg==
X-Received: by 2002:a05:600c:19cd:: with SMTP id u13mr21707064wmq.148.1635542128983;
        Fri, 29 Oct 2021 14:15:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9sm344033wrx.24.2021.10.29.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:15:28 -0700 (PDT)
Message-Id: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 21:15:23 +0000
Subject: [PATCH 0/4] Flag to add a newline after decorations for --oneline log output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a flag --newlineafter to be able to pass in "decorations" to enable a
nicer format for the --oneline output so the commit subjects are aligned
when decorations are printed.

0b96396ef5ff7a3a01e137b3735893c970759dfa (HEAD -> jc/two-line-pretty-decoration, john-cai/jc/two-line-pretty-decoration)
                                         Improve UX for oneline with decorations
e9e5ba39a78c8f5057262d49e261b42a8660d5b9 (origin/master, origin/HEAD, master)
                                         The fifteenth batch
c6fc44e9bf85dc02f6d33b11d9b5d1e10711d125 Merge branch 'ab/test-lib-diff-cleanup'
63ec2297d26155adb0e38745bf2284cd663add8e Merge branch 'ab/fix-make-lint-docs'


original thread in
https://lore.kernel.org/git/CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com/T/#t

John Cai (4):
  oneline: parse --newlineafter flag
  oneline: print newline after decorations if flag provided
  oneline: test for --newlineafter feature
  doc: add docs for newlineafter flag

 Documentation/pretty-options.txt |  4 ++++
 builtin/log.c                    | 25 +++++++++++++++++++++++++
 log-tree.c                       | 20 ++++++++++++++++----
 log-tree.h                       |  7 +++++--
 pretty.c                         |  4 ++--
 revision.h                       |  4 ++++
 t/t4205-log-pretty-formats.sh    | 10 ++++++++++
 7 files changed, 66 insertions(+), 8 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1065%2Fjohn-cai%2Fjc%2Ftwo-line-pretty-decoration-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1065/john-cai/jc/two-line-pretty-decoration-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1065
-- 
gitgitgadget
