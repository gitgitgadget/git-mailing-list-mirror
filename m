Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BAFC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 14:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiHOO4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiHOO43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 10:56:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A21A381
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 07:56:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h1so3949699wmd.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=QDZYDgbCXnd4arR6tKalw2eosH7RNfVKYOS1NZgDFQU=;
        b=Dl1I14p3SgzY0FblcfZFkfmFvjep1hEhoMv7Jk6IHhofghpa0ZYBin/+AwAarHVyKb
         u/WqwHdHamcMphOkOCyMZ/KngKsjffUL4Tmp90md/mcwsL2pTvcVGJbzykutcrrtp2Ds
         FT7NkWxSClrDyBXaZ9XwfPru85b+9xQ4c8AIKXLxEHZGeex8MJrXFGrbRYrUFlOt1u2b
         BRY6+3ozyTh2B3l6IqP+bGMcHe2ZlDL3vWTy+/qqsGdTVZpRoCmuCuHqkEkvKwb1PHdd
         9/+YkHbbUhln+tIaZvELSlBQdAAxbTmZtoKT6AHAosbVAOBnyBWT8A2drewOfDt0hbAm
         mg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=QDZYDgbCXnd4arR6tKalw2eosH7RNfVKYOS1NZgDFQU=;
        b=S+OjaPPS/0F12/sAKXMnwZLH+DCJk6I1HEVbwUAB/2ViVeD0fKNZvDKKMGAA5wjcTd
         ybo7r3ycyxFmd4z9VVIwcJxynCnxKC4dAOdvPxijGVWi5lOL79hB4zMI9R3O5KDO+HID
         vsZ++g8BqKuhGA9/M2MlPxEyYWLvwMs/Dbo4g1k1gnGktQlPBWNraMCZuvaKvp9XrJpc
         NNyWOQqD7Pdw6gMurzd/KBn5g1NlAIxzyg67w0Fw9tb5eshLHawynoFrgJ9oxNxDDuEM
         VsNKAGKF5LcPyOYaCWvaVI59520E6ZTvrt1L0xkztO5CvUbRSdsB0CQFOUBj9ORvXLQz
         HVwg==
X-Gm-Message-State: ACgBeo29LmZCQWAjT6BHOuEguAlJd9K7W6xKK4dXk23om2So6EyjIjtU
        B0+TY95OB+OB0b0asrX1OqfQxWONA9E=
X-Google-Smtp-Source: AA6agR5f+5/S/n4LXtB9PmGvg7Cypz7i9O2d59y0P/AHAWaHcwYRdQxZQ82kl2IIuhIG8HT4DeQg7g==
X-Received: by 2002:a05:600c:1898:b0:3a5:b467:c3ef with SMTP id x24-20020a05600c189800b003a5b467c3efmr15754173wmp.178.1660575386358;
        Mon, 15 Aug 2022 07:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003a54109a6a0sm9718737wmm.3.2022.08.15.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:56:25 -0700 (PDT)
Message-Id: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.git.1660524865.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 14:56:21 +0000
Subject: [PATCH v3 0/3] hide-refs: add hook to force hide refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit is implemented by JGit and is known as a centralized workflow system
which supports reference-level access control for repository. If we choose
to work in centralized workflow like what Gerrit provided, reference-level
access control is needed and we might add a reference filter hook hide-refs
to hide the private data.

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase, each reference will be filtered with
this hook. The hook executes once with no arguments for each
'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
a version number and server process name ('uploadpack' or 'receive') will
send to it in pkt-line format, followed by a flush-pkt. The hook should
respond with its version number.

During reference discovery phase, each reference will be filtered by this
hook. In the following example, the letter 'G' stands for 'git-receive-pack'
or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
decides if the reference will be hidden or not, it sends result back in
pkt-line format protocol, a response "hide" means the references will hide
to the client and can not fetch its private data even in protocol V2.

            # Version negotiation
            G: PKT-LINE(version=1\0uploadpack)
            G: flush-pkt
            H: PKT-LINE(version=1)
            H: flush-pkt

            # Send reference filter request to hook
            G: PKT-LINE(ref <refname>:<refname_full>)
            G: flush-pkt

            # Receive result from the hook.
            # Case 1: this reference is hidden
            H: PKT-LINE(hide)
            H: flush-pkt

            # Case 2: this reference can be advertised
            H: flush-pkt


To enable the hide-refs hook, we should config hiderefs with force: option,
eg:

            git config --add transfer.hiderefs force:refs/prefix1/
            git config --add uploadpack.hiderefs force:!refs/prefix2/


the hide-refs will be called during reference discovery phase and check each
matched reference, a 'hide' response means the reference will be hidden for
its private data even if allowTipSHA1InWant or allowReachableSHA1InWant are
set to true.

Sun Chao (3):
  hide-refs: add hook to force hide refs
  t1419: add test cases for hide-refs hook
  doc: add documentation for the hide-refs hook

 Documentation/githooks.txt                    |  48 ++++
 Makefile                                      |   1 +
 builtin/receive-pack.c                        |   5 +-
 ls-refs.c                                     |   2 +-
 refs.c                                        | 221 +++++++++++++++++-
 refs.h                                        |   6 +
 serve.c                                       |   2 +
 t/helper/test-hide-refs.c                     | 152 ++++++++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t1419-hide-refs-hook.sh                     | 142 +++++++++++
 t/t1419/common-functions.sh                   |  80 +++++++
 t/t1419/once-0000-abnormal-hide-refs-hook.sh  | 161 +++++++++++++
 ...test-0001-ls-remote-with-hide-refs-hook.sh |  77 ++++++
 ...st-0002-upload-pack-with-hide-refs-hook.sh | 122 ++++++++++
 ...t-0003-receive-pack-with-hide-refs-hook.sh |  87 +++++++
 upload-pack.c                                 |  32 +--
 upload-pack.h                                 |   1 +
 18 files changed, 1111 insertions(+), 30 deletions(-)
 create mode 100644 t/helper/test-hide-refs.c
 create mode 100755 t/t1419-hide-refs-hook.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/once-0000-abnormal-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1301%2Fsunchao9%2Frefs_advertise-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1301/sunchao9/refs_advertise-v3
Pull-Request: https://github.com/git/git/pull/1301

Range-diff vs v2:

 1:  3b8fb63cc78 ! 1:  01c63ea5fee hide-refs: add hook to force hide refs
     @@ Commit message
          `hide-refs` to hide the private data.
      
          This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
     -    during the reference discovery phase, each reference and will be filtered
     +    during the reference discovery phase, each reference will be filtered
          with this hook. The hook executes once with no arguments for each
          'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
          a version number and server process name ('uploadpack' or 'receive') will
          send to it in pkt-line format, followed by a flush-pkt. The hook should
     -    response with its version number.
     +    respond with its version number.
      
          During reference discovery phase, each reference will be filtered by this
          hook. In the following example, the letter 'G' stands for 'git-receive-pack'
          or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
          decides if the reference will be hidden or not, it sends result back in
     -    pkt-line format protocol, a response "hide" the references will hide
     +    pkt-line format protocol, a response "hide" means the references will hide
          to the client and can not fetch its private data even in protocol V2.
      
                  # Version negotiation
     @@ Commit message
      
          the `hide-refs` will be called during reference discovery phase and
          check each matched reference, a 'hide' response means the reference will
     -    be hidden for its private data and even the `allowTipSHA1InWant` or
     -    `allowReachableSHA1InWant` is set to true.
     +    be hidden for its private data even if `allowTipSHA1InWant` or
     +    `allowReachableSHA1InWant` are set to true.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
 2:  72333c12c3f = 2:  b8a490cb3df t1419: add test cases for hide-refs hook
 3:  e737997eb31 ! 3:  99755b377f0 doc: add documentation for the hide-refs hook
     @@ Metadata
       ## Commit message ##
          doc: add documentation for the hide-refs hook
      
     -    "git upload-pack" or "git recevie-pack" can use "hide-refs"
     +    "git upload-pack" or "git receive-pack" can use "hide-refs"
          hook to filter the references during reference discovery phase.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>

-- 
gitgitgadget
