Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E3D1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbeGWOlA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:41:00 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:41017 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388048AbeGWOlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:41:00 -0400
Received: by mail-pg1-f175.google.com with SMTP id z8-v6so415603pgu.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8EZUpztaGPOVXDx3pEgttQfZYde7U5UhoyacM4XGF28=;
        b=Y9vkxlj5jphrknkRRfggKI7XDuJJHLbdiFW95qBii+uONUM4/utyHkV7a1p53mVnlg
         eSPKwIwOdS3P6L8qtbqe+XStZdOcBuKM2ziu+U6yWxTSndmOLe81FrBRQiiYnO87Fwef
         34MS4uzZFY4u6UIbMqL6ZjItQ2eqMNqSf3iN5SwieslAQwGb5ixrXnngAzFhNfJjpy22
         IAOePnJN9KX/FOh9cylzH0Z2zBTypxwzBVFxLqVbDMIyP8zCKSwPCaQ82Xx9z0avO7VA
         uQ4cGyFG6mRLWsEwmt9Bg1537AHvfX1y8Iqg7Kcp3Bu9qU1WXHuOdM7hKRWCWUNryx3S
         9OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8EZUpztaGPOVXDx3pEgttQfZYde7U5UhoyacM4XGF28=;
        b=CmMH/uyuMIWk9rlqXoCmowEYioWs8bCl32YVMd6SeeWiIw8cTSsqhxzu0V+674oBUf
         0TpKAoRtOLmuISMlR2WMzbwh5PNEZJf21RH1ZPluo+MJs9TXj0G4nVHZ44jNPZitOhXZ
         u7/DTETz90qg5wtIDaA5eFIVnk655rKS3CQUieKsdlAScryi/evqToBDGbzDjUa97mUw
         SvQ2N+VysOzvPb+/WX07bdSujuCvJ2UQHVK+wG71LXMgENisfs5d8pqeG8htRAHpp3ur
         dNlA1PS3hkOj1EQ/0MlFuawOhZxDC3IHqN4Ad9m0XzkbBt0jGpS9qrMSYbVNBj46u6I/
         xM4w==
X-Gm-Message-State: AOUpUlGUdAYzR8UKBCRVKxeYWyoKkeM7YrPVPXYTfXjpuv25eelaap7I
        gtrqDoot5jj+6nkR11DSKRG6nFxt
X-Google-Smtp-Source: AAOMgpf+fibNZMh+2EOT20jt1BY2XfLBRGjJIxpIzLtXnKSDHygDUV0CKu/oOhGgePIt52MbYrH52g==
X-Received: by 2002:a62:c505:: with SMTP id j5-v6mr13033956pfg.153.1532353181655;
        Mon, 23 Jul 2018 06:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id a191-v6sm23866390pge.45.2018.07.23.06.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:39:40 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:39:40 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:39:38 GMT
Message-Id: <pull.12.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] t7406: avoid failures solely due to timing issues
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

This fixes a regression test that produces false positives occasionally: https://git-for-windows.visualstudio.com/git/_build/results?buildId=14035&view=logs

Johannes Schindelin (1):
  t7406: avoid failures solely due to timing issues

 t/t7406-submodule-update.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)


base-commit: b7bd9486b055c3f967a870311e704e3bb0654e4f
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-12%2Fdscho%2Fmore-robust-t7406-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-12/dscho/more-robust-t7406-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/12
-- 
gitgitgadget
