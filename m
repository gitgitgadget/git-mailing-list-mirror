Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF24420305
	for <e@80x24.org>; Tue,  9 Apr 2019 10:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfDIKlY (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 06:41:24 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38705 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIKlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 06:41:24 -0400
Received: by mail-ed1-f47.google.com with SMTP id d13so4458954edr.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dTibaL6DIChvo+PXer7Ert+a5/VDjBFD19O129SMfOo=;
        b=kmm2b9kCIRL5668H4hGLXbYnfyUXSPRA7xMQiCR7eb/Ir+OvruMEYsfYyztwAcCKfW
         VUHGMLTudNQcvIfUZ69coF5ZDAjl5haocxSbz7mOk1qy3Mzt004vQ0vdnKUWA/VaLPDd
         1zZIaGsljSn/hbYZvJ/T1zjpR7y7j73WdoxTPN/7Hf5pmfwXQdrjVY6uSeCz3qN6D6au
         ahwpWjodQvDmnUlE+tsJl8OeyBqSdrrOnIlwGGnZMShgTje4M0/L7t+AfRMpWEwozKzW
         Kad7npcRsSJJEG1PdcD6pcCLwLyx8yowQBbmFXrswJwLV0kDpG7gOOl7LUfpJYxU569U
         O5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dTibaL6DIChvo+PXer7Ert+a5/VDjBFD19O129SMfOo=;
        b=gnb+r4ROcMYpwl57BA0wSqEJJc+ddc0kFbo3vSvuylNY9xRYGXgt9Fquw48UPsdX5v
         uSqIuPUt2thntpW7Rf6o/+oO1LeI+SOuID/A16vOjADSsD45F8Na4jkku5Hu7VZ6JQPD
         Jaq82WrwwRTytinZfkYJwbj9nZaR2I7qvpE9HABWDilDrqKDC943Zrmw4tCgCA4EJ0VU
         i1RrY+lOWVATMRXGU4u+r/PfaUVoTmkw/F5DK77vKdg+Dd89h4uL1JRwEpUFvZqezj1f
         6YMV9zN+cc24g0Fw+E3toGf4rSoAZ5fBHtEV7V5kWgKVPIQAlDDNrw+gzP6TLyOK3DYd
         G2bA==
X-Gm-Message-State: APjAAAXLVJ6eGxjkbZEaqmebgbsJVvzLJetSAe0cS0sfcBHoVjRk5PFv
        afUeiGvoIazAkxhyTgd3I4JXPk0W
X-Google-Smtp-Source: APXvYqyYha3U3xfS5bd7T1ESMo5Qzqh8u+8Cp7pZlulkQQ/eIK+ykViREo0Bdw0A8Hmhkzc2QQzKuw==
X-Received: by 2002:a17:906:e202:: with SMTP id gf2mr19438603ejb.55.1554806482744;
        Tue, 09 Apr 2019 03:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h33sm9469097ede.18.2019.04.09.03.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 03:41:22 -0700 (PDT)
Date:   Tue, 09 Apr 2019 03:41:22 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Apr 2019 10:41:19 GMT
Message-Id: <pull.176.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix a false negative in t3301-notes.sh
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

It is always bad when test cases fail for the wrong reasons, but it is in
some ways more scary when they pass for the wrong reasons.

I stumbled over this issue while chasing down a Windows-specific issue that
caused two other test cases to fail, and should have caused this one to
fail, too, but didn't.

Johannes Schindelin (1):
  t3301: fix false negative

 t/t3301-notes.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-176%2Fdscho%2Ffix-false-negative-in-t3301-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-176/dscho/fix-false-negative-in-t3301-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/176
-- 
gitgitgadget
