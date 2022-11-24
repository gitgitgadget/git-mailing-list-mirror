Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6268DC4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 03:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKXDrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiKXDr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 22:47:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B5C5F54
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3010709wme.5
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VQDUqthNcGsGcsDpJ+Jx0BJU1Q+ohEjgNdC5vgPOCs=;
        b=GVwjpMlH33qAbdVhpyJRfT16axQ6YKOzhfLpINVhK7KQCe+dCOw5TNhbcEvFgcPg98
         mGyVXCR9ijxL0fvdLz+E/GaGAtjjwgE2HoVOL3D64YiIrV1zBpz4H1M/P8y/yhjJOkka
         t4/8JWrUo5bCDN9GFRcO47N7Vmq5DD6sIzm9MNmM02Q2IP0kGVs6O/FgwqnBZ0z8oBZl
         lAL89hkeWHqkKuXKP9vFqgZFZppwqOEEB9WNhL2RCDvEIZZIo4K7wI1sZGlRKEZhuvHo
         wOJgjUobGykJMuCXRXh6Je0tmnu8oaza7p+KD4WS4CHdKsDLd1PFnPstF2QNAW6bh9ky
         Heww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VQDUqthNcGsGcsDpJ+Jx0BJU1Q+ohEjgNdC5vgPOCs=;
        b=BNSKDZncKO39/tOlEmQPi8Fm0ZIZk1UNi5xcApksYZM3ADrZ3c1BqxXSF7LPSDxrzd
         2iJUPCTOaIjkaBZV713w58j5QBivYKpxX/uihqTME61I8lO0Y7yfitzbZgsNwredf8xZ
         JGBLxc/EeYXJ0k7FqScw2pEP34fLSYFtYwUbtfVJIjddHAMEJ6BjUPcbvknn03GjRqV9
         o9e6EcrLPfdenPQ1A1I7DyEg/g1K1azMFbyE3eVvkdZKn+7KE3KXYfNdNM977FoJIAg1
         IFB5kzyy7CZ8VGTe8fjEYauLVbhkb7/XzTkoybWy2IgEkM2H1Fo+EMRm2iliSkTNovAU
         UrMg==
X-Gm-Message-State: ANoB5plQavWENRFHrhELcv5arn/ixQmEfyGHjPAmL2SqqNNfknDUcd7u
        TopjkYrB0jItpPTO2RWps/jBlybRA+w=
X-Google-Smtp-Source: AA0mqf4S6Yb1RPYkcBUBB17HyFNgMOwk5fY7isfT0N0cU36H1L5y/nt6L54PGESlNT9FCURzVtocUQ==
X-Received: by 2002:a05:600c:2108:b0:3cf:aae0:802a with SMTP id u8-20020a05600c210800b003cfaae0802amr12488428wml.112.1669261643891;
        Wed, 23 Nov 2022 19:47:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b003cfbbd54178sm10954667wms.2.2022.11.23.19.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:47:23 -0800 (PST)
Message-Id: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
References: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 03:47:19 +0000
Subject: [PATCH v6 0/3] git-jump: support Emacs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an optional argument 'stdout' to print the quickfix lines to standard
output. It can be used with M-x grep on Emacs.

Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
EDITOR="emacsclient" and EDITOR="emacsclient -t".

Jeff King (1):
  git-jump: move valid-mode check earlier

Yoichi Nakayama (2):
  git-jump: add an optional argument '--stdout'
  git-jump: invoke emacs/emacsclient

 contrib/git-jump/README   | 10 ++++++++-
 contrib/git-jump/git-jump | 45 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1423

Range-diff vs v5:

 1:  446777d300d = 1:  446777d300d git-jump: add an optional argument '--stdout'
 2:  972d51888ba = 2:  972d51888ba git-jump: move valid-mode check earlier
 3:  ad7c299cb0f ! 3:  446d39f62fb git-jump: invoke emacs/emacsclient
     @@ contrib/git-jump/git-jump: EOF
      +		#
      +		# Wait for completion of the asynchronously executed process
      +		# to avoid race conditions in case of "emacsclient".
     -+		eval "$editor --eval \"(prog1 (pop-to-buffer (compilation-start \\\"cat $@\\\" 'grep-mode)) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""
     ++		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat $@\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
      +		;;
      +	*)
      +		# assume anything else is vi-compatible

-- 
gitgitgadget
