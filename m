Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A8F202BB
	for <e@80x24.org>; Fri,  8 Mar 2019 15:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCHPvV (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:51:21 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:43187 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfCHPvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:51:20 -0500
Received: by mail-ed1-f50.google.com with SMTP id m35so16763981ede.10
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=AkqnUCy8ufGINL8kW9VTIN605SEAXVgCa/8mNkxAb54=;
        b=YDPoOFJyGgLqE4pWh6c08WF9riyqseyAhda/jkLsCZjp0QUNl3HPM0z1qoZzt2vpHH
         DDikfKobVyRIPvbdMSQ7tcyFocmCDojEapbryL0iTlxC0W+RNgemINbFhIeRUu1HCwn7
         TkTfgCVq+rULcai/uiykRLO9zFZGmAquWUIK1YIifeF5sbVrM/Md7DV4tADCGsZN0sZM
         khFcJQtEvRb11AX2bLuMSOjeQtwlFg13hcNQTJz5zjF05jBq4w4KXmpoJ68QRZeuH9lI
         uDrXzyaTcwEP3zzztRK35KRKe/ZcsAM9NrLgYoSj/m203BXaI1ONvOvroc1Ltib4b5rl
         JlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AkqnUCy8ufGINL8kW9VTIN605SEAXVgCa/8mNkxAb54=;
        b=ubic4kmTdkM4k8OuL65Vn0fgI3A3GxCwVf4fx36XybjFA/2hF0/DDOfqzgxVBz4+5x
         wVl93dPy3Z6sjUESkHKBhCHllh8sm32g0UalpgFmLajNYcF3PQGH+QCGGtEPkm3jpU6Y
         pB2Da9IVvkov9YWYLLrbuRmdYXm8smCxQ/BhZm2Sh7HPz9hX9LnPI/zHX/mI99S6P47o
         aeOmGP2bQ/ZW1hpmzvxgImt+xKgzF5znCnxmbKSMY0nAIEC2z/SDksVOXpjl6VGrsL3V
         knaAuouy9MEBDJa3PXPzol+cwwcrwUFdrixUNM0CHIryrtMnEYYKd/slVJ52dIzSz+2B
         vBag==
X-Gm-Message-State: APjAAAWnmzRGRlvbp0tf8H8crFcmNpz3jrzlZ6u6zMjzu1ONcHQFVV0V
        IdAMj5sTi4jMS1LQji79zLXuzmrp
X-Google-Smtp-Source: APXvYqzjvST27UvF3coeqn0+8AfdXt7sPp7P1mA42/0onucZvB3pPgbDAPoAeFcSvwRS63ECHzWbjA==
X-Received: by 2002:a50:8f24:: with SMTP id 33mr33770649edy.290.1552060278884;
        Fri, 08 Mar 2019 07:51:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 41sm2324276edu.85.2019.03.08.07.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 07:51:18 -0800 (PST)
Date:   Fri, 08 Mar 2019 07:51:18 -0800 (PST)
X-Google-Original-Date: Fri, 08 Mar 2019 15:51:16 GMT
Message-Id: <pull.160.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: fix uname -r test
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

In df5218b4c30b (config.mak.uname: support MSys2, 2016-01-13), I obviously
made the assumption that calling uname -r in MSYS2 would always yield a
version number starting with "2".

That is incorrect, though, as uname -r reports the version of the Cygwin
runtime on which the current MSYS2 runtime is based.

This sadly breaks our build as soon as we upgrade to an MSYS2 runtime that
is based on Cygwin v3.0.2.

Happily, this patch fixes that.

Johannes Schindelin (1):
  mingw: allow building with an MSYS2 runtime v3.x

 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 6e0cc6776106079ed4efa0cc9abace4107657abf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-160%2Fdscho%2Fmsys2-3.x-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-160/dscho/msys2-3.x-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/160
-- 
gitgitgadget
