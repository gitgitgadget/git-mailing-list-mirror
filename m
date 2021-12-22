Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD6C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344507AbhLVSL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhLVSL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:11:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160FAC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so6544691wrr.8
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wJ/raSI/Fm1ltba1s0KwY8lWvNMuacskFzFpUi8/gNc=;
        b=VnW/aP4zYZW6/UY/R84i+7sgXfbimxkorDEE46yJ1Xoi1tUkeOxFbc+R634jCHDCHP
         PcVo1VemKXWPpGyNvBRk+YMhz/rH8hXsOEkOS4H6yDftiTgV4DXSC4CJuHZe6s3GDpGf
         tS7sdka6Yhv+XswS2TqL4azKkJB6YTmp3+vP/BgNwIiigbJvvje3LpGjZHG/2ywKOTwf
         niqTiCnn3hqb3s7BuYRQGdD7rMSrXMlWVrspWc6rGqJUfHeeDyv21VhQnyCnrh/DF5gD
         1srvOFhyAbzuZWVrwhNLDu8eqrO8RewDxKf7b69no+yS+Ft/SMiQBm7nT/vFczz2mUIQ
         FcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wJ/raSI/Fm1ltba1s0KwY8lWvNMuacskFzFpUi8/gNc=;
        b=o/Ykelrw7s9rH5hnqkdshljC4yRK1FHKzWNVv2NanRe2xBaA7tJqe70pIpC4i6Y44b
         U3CYP7T3ancGgIHF0dV+T2gRdCxK16xUUHsc6qFKti7he+bG4vT2wL5CWE6Y/Y2ILAyf
         0llr0dODDTYZEs98wYf+ifk6gfqdY41wHftVxskrKbmejTrC3u1TNWFMqq7JJaL1gZb/
         RGXT/2o5HXmnZXS7lypy6TrYzycTPjNIvez2Eyx7WpVq1bSh9WG6czsf5IMOtH1xL7j7
         wUp0XOduAWQCxe7ZXS8e+kzIps8R5J/cj1re3SrlH1UbXVVfZcUKATuHwRfeC1I9zMPe
         DAhg==
X-Gm-Message-State: AOAM533nIfgNi2ZLqG4qgM5XG7zYADLADqWhRTulg70bGCPxRQlq08an
        QWzZMI6J+8lFjVX9/iWr27pOZhsFZCo=
X-Google-Smtp-Source: ABdhPJyY18r2FYSvPp8FiIv0PxoTDYdda18VU2WpE+kVs5s5topK3aIX2RumvWNWrw0l39uEa9K+Eg==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr2911618wrw.430.1640196715539;
        Wed, 22 Dec 2021 10:11:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a198sm2471416wmd.42.2021.12.22.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:11:55 -0800 (PST)
Message-Id: <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:11:51 +0000
Subject: [PATCH v2 0/3] tweaks to refs/debug.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

these are two small commits that helped me while debugging reftable support
for git.

Han-Wen Nienhuys (3):
  refs: pass gitdir to packed_ref_store_create
  refs: print error message in debug output
  refs: centralize initialization of the base ref_store.

 refs.c                |  6 ++++--
 refs/debug.c          |  6 ++++--
 refs/files-backend.c  | 10 +++-------
 refs/packed-backend.c | 11 +++++------
 refs/packed-backend.h |  2 +-
 refs/refs-internal.h  |  4 ++--
 6 files changed, 19 insertions(+), 20 deletions(-)


base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1163%2Fhanwen%2Fdebug-tweaks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1163/hanwen/debug-tweaks-v2
Pull-Request: https://github.com/git/git/pull/1163

Range-diff vs v1:

 -:  ----------- > 1:  bfebb5f08fe refs: pass gitdir to packed_ref_store_create
 1:  177d84f8563 = 2:  b189f8661e2 refs: print error message in debug output
 2:  75e5392032d < -:  ----------- refs: set the repo in debug_ref_store.base
 -:  ----------- > 3:  eea294b688f refs: centralize initialization of the base ref_store.

-- 
gitgitgadget
