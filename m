Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9295C1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfBGKqI (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:46:08 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40796 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGKqI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:46:08 -0500
Received: by mail-wr1-f46.google.com with SMTP id q1so994644wrp.7
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DB98rp18YmEgpi9M72efMl6yAmQ6bJ4d3GkTKtWmm78=;
        b=WyPt87bWYfMKODqAqHr28VA0UnJHM+E6+vgMMKFCtsDWKcza6h4vclSKFIc7yROmmn
         /7Iy5Nr4AE8zNMuixE07KBOIaFISU9RebGqAnGD47nTJ7iAjMgxgIyBu1a+H6JR9wdye
         Pjdv29cmSoQOkeNNMVrWZSA1SHfrlUHOkACmbdKAi6tH7PXYz1LLXijRRLqklkjVBHZr
         vEyqClarU7bPgnrx8DLD9bgVdiHEwl6gS8dhAH8vwgRyXm2hWFxqVe+vorBJy+qnTvTk
         Bol4I/iRxNXk7DfHTX2/k7k7kFOAXTSeEcW6WY3jRsNjQgeCRHHbWDB20Mn6jp/iM430
         iyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DB98rp18YmEgpi9M72efMl6yAmQ6bJ4d3GkTKtWmm78=;
        b=VUhxGS5L+tRawHKFkLyZU6B031RFNiUXSzLO3oUHhVGcD7Hxl/tAV8GTbhjffvkhpX
         nJNbi3kBdxBU8RaLa5FJEHAEeAZ1UNtOwOrJp942nsN2F5W+eI2oFkOF9exGU998Q42L
         Ok+nsQ3ZOEmIjoxDGmV7bg7q9hl1oEAXD21vVQnyj9zWxEdK+KCKr8UNdKJo23c0oUU2
         lmbonLdssnDnPSdxO81Fat/1Q8Cs5S6BSWuSlViJ5vHT0VE0MSgu1Q3yjcv6wfZsoxZ4
         cnrgBd91b5xJ9F8EvuPvOgE3+PeWg96es/pJt1Mlwu9EE149fGWgn8z4zcG1Lg3jbVwi
         m8Tg==
X-Gm-Message-State: AHQUAua2PCBwZnDWSp+bTLDYa2HP40VPJY5r9N2uxQ7dc+Uk9zOq2oP/
        Cyoyc3yNjw0EGw28cjoCSz8O2La+
X-Google-Smtp-Source: AHgI3IYo3EXfBbHso+JALbNMd43UGByqTgpzJoInIHWtsDg06eOT9jfRupGu2eY/FLdw8jxfWq/ZUQ==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr12120427wrv.330.1549536366183;
        Thu, 07 Feb 2019 02:46:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm36112605wmb.45.2019.02.07.02.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:46:05 -0800 (PST)
Date:   Thu, 07 Feb 2019 02:46:05 -0800 (PST)
X-Google-Original-Date: Thu, 07 Feb 2019 10:46:03 GMT
Message-Id: <pull.121.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix incorrectly reported CPU in 32-bit Windows
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

While in review, Git for Windows' original design was changed, to use the
output of uname -m instead of (necessarily incomplete) pre-processor magic
to determine which CPU to report.

Both 32-bit and 64-bit versions of Git for Windows are built in the 64-bit
Git for Windows SDK, however, whose uname -m always reports x86_64. Even for
32-bit Git for Windows.

Let's fix that by going back to the pre-processor magic, making it specific
to Git for Windows' SDK (where it actually is complete).

This is yet another patch I forgot to upstream, and I hope that it will make
it into v2.21.0-rc1.

Johannes Schindelin (1):
  mingw: fix CPU reporting in `git version --build-options`

 compat/mingw.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)


base-commit: d62dad7a7dca3f6a65162bf0e52cdf6927958e78
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-121%2Fdscho%2Fmingw-build-options-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-121/dscho/mingw-build-options-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/121
-- 
gitgitgadget
