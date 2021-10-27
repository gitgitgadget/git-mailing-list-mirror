Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF704C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF2E60F9B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbhJ0OIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242383AbhJ0OH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:07:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C34C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:05:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so2481955wmz.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1hd4Wzdyo2MFxkiEFBNgqevimO2o2g807Zr/39VN4NQ=;
        b=jo1ohR9qJNoWyficIUZrYIV8AuxIGZ1pp1L8cWD3ZAf8W1bvDxjxg0DbgCMMGKg7xN
         aL4aa0HVnr1LA1tX0z6Y6ma7p+nf+S646zkNk4okqSVZ5sX+A/O5HO07vuLLr5VW5kxF
         J960fqdBHNI6HbPrGN4tRaBa22DJZCrbeHZGnsYHvHwKtSUlkZglIzRYww9T++P+6iCF
         SVe4JkqULdq0Yr/A4Hrii7YSy2nLSwov5rhnwYKYctN6xCyaZZ+pVEXPbaaOICADSzgt
         XocvCWBsGGkpuX/kB0eCvuI2yDD5DMW4AwNQLvduCrq6WjwOUyhE90NWBqK/SXRG698h
         orqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1hd4Wzdyo2MFxkiEFBNgqevimO2o2g807Zr/39VN4NQ=;
        b=s7Gqcl/q3fWhpse06cFt2AqaNXlRuzz4/a9LzcYlVx7oyadhdHzJHwVauurkLks2yq
         bTT6V782wh4eEGKdvjGfmw0WOY2gLsCfKUBigldXCvnrSLRuGs8UMgTLzDJ5HJyj2+78
         traKJExQHqPkeYmYe4XU3rg6ZpLs/e3DxFyILcWIgVlFuL5WJm23TLQY+qwETd/3CAp5
         qn5qVB9qXpLEtZ+zmq8wkijhdtoLttVtJ9Zljk5IZ+XERrijsiozh+ZrneAwoxTtTFPR
         tzqA7vUVFhFUA1XEgvCfGgQv3p2q+Li2PZnKclK8QieFprsZ77V4Av42w4AU5dH4mJdh
         soCQ==
X-Gm-Message-State: AOAM5333siRPlBe2ZUmDncGn7JxKV0id5MPq8H2r1xTQKSwbIMgYFpHl
        PEMjpk41SP7po1LKmH4CBSzUTYR0XSY=
X-Google-Smtp-Source: ABdhPJzNnY1U0cefumMf8GnQwB5UI67/bkrnsq3kjHgBn+eO/YVvpDXBn/Bsoei0dj+t+ju5O5/pww==
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr5859688wmq.173.1635343532373;
        Wed, 27 Oct 2021 07:05:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm21764739wru.82.2021.10.27.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:05:32 -0700 (PDT)
Message-Id: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:05:29 +0000
Subject: [PATCH 0/2] fix up example code in MyFirstObjectWalk tutorial
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MyFirstObjectWalk tutorial was missing directives to add some header files.
Also fixes some initialization code.

John Cai (2):
  docs: fix places that break compliation in MyFirstObjectWalk
  docs: add headers in MyFirstObjectWalk

 Documentation/MyFirstObjectWalk.txt | 32 +++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)


base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1063%2Fjohn-cai%2Fjc-fix-my-first-object-walk-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1063/john-cai/jc-fix-my-first-object-walk-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1063
-- 
gitgitgadget
