Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5649F1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfBMKTv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:19:51 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:46978 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfBMKTv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:19:51 -0500
Received: by mail-ed1-f49.google.com with SMTP id f2so1405685edy.13
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1ebOXJ7/AO4Xf1ram7289PJkGkVYexu8rpYhigsIj4g=;
        b=YJEUAGWdncOAwxQlx59GBTcHKm9Dqoe/0loIceQ+Jcw3G+Rg9iQXWTwQEuoc70MrIu
         6zasCOjh1XLgUa5VEewjgXufbIsO7OwxOgZ4Mt6po8rtSa/cMNfRoqqdrLf7cVrGuRRS
         Pg3Ns6r7LKPn2LnQv3fKT/xwiXSxQsGe9berteQcpZm4DKIUdf/XrFlNlboZF0nBDhDg
         Ownmr12YOyHWXm3PPy3Bl1rgKbuVIJKDtxIoDkSucWQsFP1A1TzIe3MF23kjd6dt/YI2
         13ME9zU+/PfcHC2SETpJj3SQQW//AHuuIihx9svhr0BfabzJUr5pj35ZMj12fvq66c5n
         vMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ebOXJ7/AO4Xf1ram7289PJkGkVYexu8rpYhigsIj4g=;
        b=BuIl/JpeR7zH3LNzNfAOeWRCxu2jhkKlDhPEfaH8jzGn+aafoPtrYWPJj8y4GODaMo
         O/0sH725ey9wH8Utsg4sHEKCGxz6qUHkbDSVSrubcMiw0UIJHg1lTFo6R/3KvdRsYxrS
         WnQrzXkeU/BekFflw3BPQpQb+X7z1N9PkjR/RJxKIDdKMLn08TLdPjSIh5fMsCbY0y/V
         ZL/zhuVCHM1Zm4mmgoGU1sRFBYDToSwuJZZ5a6JgCJFj2jqi7G33ITkQ5/KG1ZByMGkA
         CUV5iPy27/pX/i25qutVpR8V42foLUtUUUeHqc0NfhS0b1HpPKwgJdF8T7aILWMZcsCU
         NmDQ==
X-Gm-Message-State: AHQUAuboMDpDuCFoEAlmzDg3ZNtdXCfxER5mmDY99nSeYxdhqqpRvaHV
        UqQEFX0lVTQ9LVJSXkGuOxUiQagr
X-Google-Smtp-Source: AHgI3IYfh67aSkcyZ9HK5iQWiZeL40zjAWLk9i6qydcAN9QVZmSAiH0RhEKJFm6lPsqBgpaJFFod1w==
X-Received: by 2002:a17:906:64d9:: with SMTP id p25mr5988958ejn.90.1550053189031;
        Wed, 13 Feb 2019 02:19:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm4652961edd.25.2019.02.13.02.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 02:19:48 -0800 (PST)
Date:   Wed, 13 Feb 2019 02:19:48 -0800 (PST)
X-Google-Original-Date: Wed, 13 Feb 2019 10:19:46 GMT
Message-Id: <pull.125.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Use a more canonical method to fix the CPU reporting on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine pointed out that I had completely forgotten about the HOST_CPU
thing, and that is indeed the much better method of fixing the issue.

Johannes Schindelin (1):
  mingw: use a more canonical method to fix the CPU reporting

 compat/mingw.h   | 19 -------------------
 config.mak.uname |  2 ++
 2 files changed, 2 insertions(+), 19 deletions(-)


base-commit: 3815f64b0dd983bdbf9242a0547706d5d81cb3e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-125%2Fdscho%2Fmingw-host-cpu-take2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-125/dscho/mingw-host-cpu-take2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/125
-- 
gitgitgadget
