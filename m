Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D12CC43217
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 01:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiKTB1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 20:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKTB13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 20:27:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96EFE5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:27:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o30so6219788wms.2
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 17:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qej3/LHBiQAtpuFCmfWWDea4xkjsqV5ttLP7wb1VCFI=;
        b=g7XDaxpWezNNhhJqaUHZQewiGI+JfFQSlNnwsel4QD3D4tG0armXdXAQHMwO0WAV/y
         Dv5a8wIBm7w8H1l7zSJCT3JKa7WKW53JT5uNKUXH7fSEFNsyD/XDEM9dTxfXCbZY9n4W
         PAkrF1peElUNodeS/HIKC/z9TfPxQZpAjVzI26dAiyvJBQJ5Z5//7/i4ucXTeL1Zsyjt
         Az42dHQTuZ47ieanH/kmo2GCNtp1ZqXwehiu1NYtUR/O7H6hVKNdwRsCrci/a6Cr77gM
         4OmKwAwVW8dtGY5kaVRIJL7isncvcYzWfptL6BHwFL4f0DguqNIAc+u+MJ3CWnfHPAgV
         NWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qej3/LHBiQAtpuFCmfWWDea4xkjsqV5ttLP7wb1VCFI=;
        b=J0cBcUcFKgoHYoYjsPA2ybbohWM62Qe4cRfe6OFQTzeRzFacS0UDyTD8IjQehFQgUD
         elnGCTx7gO3auAvndrQdN7EIqxNd8qzY0Q9wAgUJkBWa7QPqL/EJXkCHsiQFs6rZ8x5i
         TGJ/zUazxfdenQRUR0/OmQCCyZUxGI+iZp8zawFd7nfR25GM3f0MZGX12FanwnCGW3GG
         AMRc0Ou+wEqB2JYBOBFd8MlAvRXi4PTZdl0fDqz5lPOV6jGuCTt6bPYmmHxmpklC8AG8
         vUsXRJBBfgHpPy9tQtHMZUy4Wa8FDEm2HMFNy3P5OeV+HuLYH2RvNR8PoVZMdWPEEGXw
         /JdA==
X-Gm-Message-State: ANoB5plTTesRFnnkGTpf/2jLEtwi8b1h59vldV+dd+MPAoK05QLmCF5P
        fUmD3lRZsXzdMtLS1IBqRK7Hcfrd0aU=
X-Google-Smtp-Source: AA0mqf5w+iXWSLlkeD+tFBvLlOOqQLqxa3AQqa/iJVPjgti0td+RZ8FV2Uylfb2GnJQX2EayE+XuAQ==
X-Received: by 2002:a7b:ce8c:0:b0:3cf:8b2d:8cbc with SMTP id q12-20020a7bce8c000000b003cf8b2d8cbcmr8918756wmj.89.1668907646092;
        Sat, 19 Nov 2022 17:27:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b003cfd42821dasm9444608wmb.3.2022.11.19.17.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 17:27:25 -0800 (PST)
Message-Id: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Nov 2022 01:27:22 +0000
Subject: [PATCH v2 0/2] git-jump: support Emacs
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

Yoichi Nakayama (2):
  git-jump: add an optional argument 'stdout'
  git-jump: invoke emacsclient

 contrib/git-jump/README   |  9 ++++++++-
 contrib/git-jump/git-jump | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1423

Range-diff vs v1:

 1:  e56858a3eb2 = 1:  e56858a3eb2 git-jump: add an optional argument 'stdout'
 2:  ed19668db86 ! 2:  72c4fd5532b git-jump: invoke emacsclient
     @@ contrib/git-jump/git-jump: if test "$mode" = "stdout"; then
       	exit 0
       fi
       
     -+if git var GIT_EDITOR | grep ^emacsclient >/dev/null; then
     ++if git var GIT_EDITOR | grep emacsclient >/dev/null; then
      +	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
      +	open_emacsclient "$mode" "$@"
      +	exit 0

-- 
gitgitgadget
