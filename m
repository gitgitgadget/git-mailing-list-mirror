Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99CC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 09:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJJJpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJJJpN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 05:45:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29257548
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 02:45:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so16128288wrb.13
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R7ItelmMpmBv0ccDPQRuXCZmFq0qB5ApcscElUeMA0o=;
        b=P6/BmERzopfrIbR7aCVlSAQq49c87qD/vbocj3mrewEoZFVkWwNDWJkxZpDFzdM48K
         fb/Q/omlQtZ7WEBTj5OlUlTlTShh9fQwjpbLOqqxbvIR487OsncCYwkEKsdvd6ZLNr89
         0Wx66lKmDz1PdtHzYVZfkS7wYezhXnHMJpQ6Npj4fo/+8GgPwy6ulDY08j2+hdaH4qCA
         cJkFnNJW/G93EL1+jwt6yBNut5ffX18u87oUqbqZAV9QBKvFBZehLwoHV1UzyUw08jGw
         mEBWQxMzEUd52kVP2OLDs81wnjSAognD9OnfmH5STxwzxYCvphNk5zPaYMJpaeVf1PG3
         FGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7ItelmMpmBv0ccDPQRuXCZmFq0qB5ApcscElUeMA0o=;
        b=njE3VMubz4sdJXYepeFjaOEcyJdTcNqXW+MXXRPywygy2oQpWx/WlBUnUQS6bJjbx0
         lH/5C7pzMtXGT0XoTVENs9+6ifFbglg0+SV8LXwSjuo8XxfI6gMo/LyqXzdW9abhbpWY
         4ooY4qKC9QT885Kh79+DwX6wSyRFLyONYCYsUcdAjKMzEpYwEV3dVwcejrftlkgV2YZu
         Np9Ex4UWGDnz9nd8qTWq5sSD/n0MAI6mUza+sjEeUg1pFxCbxVpAz3bWMC3844hFwASq
         Du1XohWdnVWw/GmSuLsP5k6AM8gllwK/Tl1//FnXGS9IaeHMt8XVTYFBBPTI5x4+cF7m
         FBvQ==
X-Gm-Message-State: ACrzQf3KcFC1+JcvHtcXNm+TpauqFmFsseE89MZou7ioiNYsZrULH6by
        4pflG8fiTv/qD4/lk+0JMgFxggrcw3g=
X-Google-Smtp-Source: AMsMyM5QsDlh7J/50gPpHWPdc+TM5Mprp4tVZ/h/yA3eYwYwm2TZ13QQznHMvrVD0yem34DpsZVwQw==
X-Received: by 2002:adf:e549:0:b0:230:6d12:fc84 with SMTP id z9-20020adfe549000000b002306d12fc84mr2974947wrm.64.1665395107861;
        Mon, 10 Oct 2022 02:45:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm8464974wrs.66.2022.10.10.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 02:45:07 -0700 (PDT)
Message-Id: <pull.1379.git.1665395106351.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 09:45:06 +0000
Subject: [PATCH] t3435: remove redundant test case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

rebase --preserve-merges no longer exists so there is no point in
carrying this failing test case.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    t3435: remove redundant test case
    
    test_expect_failure was covering up an unexpected failure.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1379%2Fphillipwood%2Fwip%2Frebase-remove-redundant-test-case-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1379/phillipwood/wip/rebase-remove-redundant-test-case-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1379

 t/t3435-rebase-gpg-sign.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 5f8ba2c7399..6aa2aeb628d 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -64,14 +64,6 @@ test_rebase_gpg_sign ! true  -i --no-gpg-sign
 test_rebase_gpg_sign ! true  -i --gpg-sign --no-gpg-sign
 test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-sign
 
-test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
-	test_when_finished "git clean -f" &&
-	git reset --hard merged &&
-	git config commit.gpgsign true &&
-	git rebase -p --no-gpg-sign --onto=one fork-point main &&
-	test_must_fail git verify-commit HEAD
-'
-
 test_expect_success 'rebase -r, merge strategy, --gpg-sign will sign commit' '
 	git reset --hard merged &&
 	test_unconfig commit.gpgsign &&

base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
-- 
gitgitgadget
