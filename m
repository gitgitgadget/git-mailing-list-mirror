Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD7C20248
	for <e@80x24.org>; Wed, 13 Mar 2019 11:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfCML4z (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 07:56:55 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44319 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCML4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 07:56:54 -0400
Received: by mail-ed1-f42.google.com with SMTP id b20so1228506edw.11
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vutekBTwQ4uFKE3c6QIfbsUx7W7pFUULklIXiLm10y8=;
        b=elgVH4Elhof6oV4j6BKye5fn30zajwPXA4/huCyyEHFzHQowxrKCUVSzsm3vIKwSPb
         aM0PjabbShMjLcPclfB3u3kq+UhHiZXSaySb2aHq1TzrnQ5jOcVesupCwPkEkR6tKWa0
         1reZc96nZ7Pfm4dzDR5T+5EQQ0vkIrV+XPvUEDRyqbC/YGr9GE84u3n3thA+9vxnc97U
         Q1ZbR5xSr0/SFSw1dD71GAfy+DKpb5H2CNtYWGc2A7t+jH9A1FLv1+r5MtEYf66eBSmR
         P8pTWx8wFVOVGdzAYwsiOoFCcxvZURt+z3JBqzOu7538moqmzTpYnowpdrN4OobgJpN9
         6riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vutekBTwQ4uFKE3c6QIfbsUx7W7pFUULklIXiLm10y8=;
        b=LEUOnEmxSt8lNs/QaSF60x695p2bT7jkvGKiKTPflihjLV1WHBxWc9bO74IG3GVLay
         in4gzTmDdgNWk9C4Ehbmyt5gv0BsB+IiLrUHbyVyQwQOkpudgVaQQv4JNBU0e2eM6hCv
         Kv4b0DLCwBoGDms8NSE4/Adq42gS1ExA8CgYjAoFmWmdSz5myeeWzdyanuX1IVf/iZ41
         IHP1a4zKhr2Td0PMbcwlkPYL/kuzdzyCQfSBry7u+gdmHkcp3f27duFW+cJXvqS7iZ+J
         CZ2r9gFPcImtaOzfX00HVLVb2Ijf2xslNVD44MH6fgUi7Lduo6Ph7k+e0jKa2dFDpTTk
         sHJA==
X-Gm-Message-State: APjAAAWWsSeS5R1z6mNhSbzbIqh9RlOdMeL4jT5IB7NgZbuF6mQ2e+On
        4vp8ZYF6GO1PPxGxUqUcItpaqIi0
X-Google-Smtp-Source: APXvYqwPtlA2Swr4/nODMHY2dPcGmUg75d+Zbd8Ho2uzA/2ew7/yalhQrjt35iRFZhHVStbzWmaMXQ==
X-Received: by 2002:a17:906:9150:: with SMTP id y16mr29565040ejw.123.1552478212946;
        Wed, 13 Mar 2019 04:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w54sm521741edw.82.2019.03.13.04.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 04:56:52 -0700 (PDT)
Date:   Wed, 13 Mar 2019 04:56:52 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 11:56:51 GMT
Message-Id: <pull.162.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix make check-docs on Windows
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

I stumbled across this when investigating one of Duy's bugs in the CI
builds.

Johannes Schindelin (1):
  check-docs: fix for setups where executables have an extension

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-162%2Fdscho%2Fcheck-docs-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-162/dscho/check-docs-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/162
-- 
gitgitgadget
