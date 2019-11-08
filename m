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
	by dcvr.yhbt.net (Postfix) with ESMTP id DA46E1F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 07:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfKHHJZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 02:09:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33396 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHHJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 02:09:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so5839104wmb.0
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 23:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IUwZWAxnLvlSaP5enO5WK92orZXS9GFBz4DZVrx1sOs=;
        b=ISbUfggTFwiU5pCtMsb4uSFZMDyCYfFZaM9rAPrjqYA4H5rbf477mwPHVeQFbck60X
         KvZIfhS65kFeNHI7zJJTPrRH7i/AV5OW/jWKSQPW3Cyhsj4VdolbbboP9cj7nw0I06XS
         96lR0iv2QVSU6By65FKoXbLJw7w76GVmzx8UJZYk7QQKupWfb9rV0szKFPvZzqZHihMW
         xASZl4+aFLHs6pgdy/RAPuUvspVZov/v99XvMjt+3ZPxS0guQMxE/nZOHl5APh2Fr0i7
         0oeGBgpnj04OPtkbxsJCndNcSq6h13djWqN9fAB359D1tQXY12MnLyZTRMSeCX8wz7pR
         yVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IUwZWAxnLvlSaP5enO5WK92orZXS9GFBz4DZVrx1sOs=;
        b=Z9Qdp75/Q6j/FnluQRX0SqMVusPafyUOTnpCj6mLTaHxQr6yfIW3iDFvNH7cKTcOJG
         E6Mt2lg5jVNO+p3CXayxmZxTcfFxgZ/eLG/Ro6DZsBC6o7NazDeSiEg/7Pqbhqh/6YYf
         RCWQkUiRYV4PUl8u8nXe5Pv1zMObna0dygH2pDjI1X8Hz12Vgvv4XlsBPQFSIABgX5O7
         l/ub1NcSJlszborP8hoG2sqitIMHzbfDIf8VVWjhSZuV9Pc8DbfzjmTHMut4bmEtgVxh
         a/z92yz8WTyM5NvLzCWMpIPsSU4OsviojMDwlONJu7u8EGYlb4suAwchJAXp/CvClRyu
         DO1w==
X-Gm-Message-State: APjAAAX2b6JYUUt9She/g6WuUaVNNVasTK6FmBuu/JuQJbszbQYcO06c
        or6j8pULQfb98g50VPbvZ7RfeDE/
X-Google-Smtp-Source: APXvYqyj2226X9q+Ddub8z/EzlyXDvqnZ5LwNQRFzPbi7+zNklFipkfSqMZPtMUqschUuHpzIEXYRQ==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr6644181wml.102.1573196962155;
        Thu, 07 Nov 2019 23:09:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm7405136wra.79.2019.11.07.23.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 23:09:21 -0800 (PST)
Message-Id: <pull.458.git.1573196960.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Nov 2019 07:09:19 +0000
Subject: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checks added in 3444ec2 to ensure that the fsmonitor_dirty bitmap does
not have more bits than the index do not play well with the split index.

git update-index --fsmonitor --split-index calls write_locked_index which
calls write_shared_index as well as write_split_index. The first call fills
up the fsmonitor_dirty bitmap, and the second modifies the index such that
istate->cache_nr is zero and this assert is hit.

The test written does reproduce the error, but only flakily. There is
limited difference with GIT_TEST_FSMONITOR=fsmonitor-all or
GIT_TEST_FSMONITOR=fsmonitor-watchman, so the flakiness might come from
somewhere else, which I haven't tracked down.

The test also requires checkout of a new branch, and checking out back to
master. It's clear that the index gets into some poor state through these
operations, and there is a deeper bug somewhere.

At the very least, this patch mitigates an over-eager check for split index
users while maintaining good invariants for the standard case. Also, I
haven't been able to reproduce this with "standard" user commands, like
status/checkout/stash, so the blast radius seems limited.

Helped-by: Kevin Willford kewillf@microsoft.com [kewillf@microsoft.com]
Helped-by: Junio C Hamano gitster@pobox.com [gitster@pobox.com]
Signed-off-by: Utsav Shah utsav@dropbox.com [utsav@dropbox.com]

Utsav Shah (1):
  fsmonitor: skip sanity check if the index is split

 fsmonitor.c                 |  8 ++++----
 t/t7519-status-fsmonitor.sh | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-458%2FUtsav2%2Fsplit-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-458/Utsav2/split-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/458
-- 
gitgitgadget
