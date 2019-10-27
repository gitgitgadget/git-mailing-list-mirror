Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712821F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 17:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfJ0RQ3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 13:16:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52472 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfJ0RQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 13:16:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so7056000wmg.2
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hlHU5Uq5qWrp/mLktMGXihHfEYX9dKl7YGeV7KJDmqo=;
        b=sIFYWi2fH6KPecA0fMFt7BfYX2pizb1Vt2WQrF5seponQmq9PbSSx1P45FNudXFxsd
         JOPrRoinmMWDftJ4+Ot9V753Oh9/Z6YYaQe9PCATJijBUXlXFJCxv6x/FTjT1PHR7rNp
         fuz7I8xvKs2G/6SzyyKnBi5G43A/MRBskaGLMQNg1WGiA6pzc2J9aigbFjg4k+Kc61tX
         1+TkxyzUVYnsZLKiWOL5722Fiuh4zD0/QdNOGZhF7J5rHpc/uBBwW6zN7QW3a2na5HfC
         CXsed0lblTnxCIa3zFeaa9+Y9cNEVyXSl9nMoifGtFZpAatbZ/FCsEeTl1jcXxb1Fn1f
         qh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hlHU5Uq5qWrp/mLktMGXihHfEYX9dKl7YGeV7KJDmqo=;
        b=sNW04i2JtFVSVo08MeAYAXkIlhmCV/hVKLplGZnaPptg35jMPFjvQqSi+XMfpwFcvT
         Yg8u7SsxXNCmz7is2kl5Z0b8GHlglv4xvF1iDZuDXPPrpwDQA3fBbTJh3MadiWKtwhKQ
         mnVmLSAwVYifnQNdq/w6Iqg0c5XzTcTGwxocS9Wa8Fy0ee+z4e9OYlsdjlJhukOfyHK0
         qwd7UK1r1iYrrre3Y4ZjD6Ny6DCwwo7KnDZCruGHiRDTt6SJ6rCCO/ks+XAl/Wsy2vu9
         b0LOVmh9Qhu6aFYN3tWWqW52OVIeFhtTZSdUHLsE24+B5rH0qSKtule8n6GdXhedtqud
         AQ6Q==
X-Gm-Message-State: APjAAAU8rZDvphx+UbjlkFk8kaqsEgjhvpuRyOU6Mkv0x2RJaH8POoTA
        9nuDi4/85GGEx3UAV/dzEYYVMM98
X-Google-Smtp-Source: APXvYqz2LcDenAZm1gzUluIWgcBrDWvAMyxxJUjf5n5YAuj1DDi110RI+Nknup7jEGUjFCSqlqG7vw==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr12647433wmd.176.1572196587123;
        Sun, 27 Oct 2019 10:16:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 126sm8617277wma.48.2019.10.27.10.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 10:16:26 -0700 (PDT)
Message-Id: <pull.430.git.1572196585.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Oct 2019 17:16:24 +0000
Subject: [PATCH 0/1] worktree: teach "add" to ignore submodule.recurse config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"worktree add" internally calls "reset --hard", but if submodule.recurse is
set, reset tries to recurse into initialized submodules, which makes
start_command try to cd into non-existing submodule paths and die.

Fix that by making sure that the call to reset in "worktree add" does not
recurse.

Some remarks:

 1. This patch is based on maint
    
    
 2. The 2 Travis CI macOS builds fail (they also fail on maint) with the
    message:
    
    > +brew install caskroom/cask/perforce Error: caskroom/cask was moved. Tap
    homebrew/cask-cask instead. The command "ci/install-dependencies.sh"
    failed and exited with 1 during .
    
    
    
 3. I'm on OS X 10.11.6 (Apple clang-800.0.42.1) and I get a warning
    compiling builtin/merge.c : 
    
    >     CC builtin/merge.o
    builtin/merge.c:831:33: warning: data argument not used by format string [-Wformat-extra-args]
                            no_scissors_editor_comment), comment_line_char);
                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~  ^
    builtin/merge.c:809:4: note: format string is defined here
    N_("An empty message aborts the commit.\n");
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./gettext.h:86:20: note: expanded from macro 'N_'
    #define N_(msgid) (msgid)
                       ^~~~~
    1 warning generated.
    
    
     This makes me unable to build with DEVELOPER=1.

Philippe Blain (1):
  worktree: teach "add" to ignore submodule.recurse config

 builtin/worktree.c      |  2 +-
 t/t2400-worktree-add.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-430%2Fphil-blain%2Fworktree-add-recurse-submodule-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-430/phil-blain/worktree-add-recurse-submodule-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/430
-- 
gitgitgadget
