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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8431F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfKEXNG (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:13:06 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35537 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfKEXNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:13:06 -0500
Received: by mail-wm1-f49.google.com with SMTP id 8so1272309wmo.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ytv31Yyi+PvSp8VR21glTExQ1iMPPOJUDBV3AGOFHns=;
        b=Jt77n/AP7AYQK2DesT7PoszJ5u84L8CS3RIzmIFRbjRxYNBdJ+JehltgxjAmGH89Ly
         3qtXmT7zFlta6C0KknKTMB7dRYrr3qYVgc7tBKuU4IjCezj5ngSatS2eyq4eCH+XM3Fm
         6Hgh/Ky7rRk+ASPm4/f875w0nGLu/chItW/HB5kF9WfBccE58CDayBe4XOIARcdL4rA0
         dF/oy7CmgMW31iCBa2tGt/QbxQU6hdfezkgJig51MhWCzeI5Ql31U6mIhXDxdd9DQP/F
         DS7Ya1AmV3aENyWYM7L8yX1kMZxH2JU6Cf3G7LoT0Mj9WuofOeaVZzt43WJwdBO9U6u2
         oilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ytv31Yyi+PvSp8VR21glTExQ1iMPPOJUDBV3AGOFHns=;
        b=baIcUPJoHPwWuCJn9QyGxeW70bFn04syfNrEnjGa6a1kXKH3T9wrmdeQnnck9c7Vjd
         2QZqQD0MjWgFq+hpISKs1iPaMuu8Z99xXvnZATzVmaXxX5nqvV4wjj4NbpAZEFskuvQH
         EvIsI2dZtvW1CxfVHFt9uEP0TOhnuepoI/7lUTTFIiKBrWXNOVBz8LjaNqwYFcPjfoC2
         YKdWPcDBpd45kHgMekB9YmsvlmcnS9f/z7YbD3sa0DXXtDxFiSVLeiUhZ7hNGdqB4D1J
         g+RAieZY4AEk0dTuxyPkYoCCntMCtOFo5Bk7UWjiG5KLD/rv8EdFI82dHeiTJLL9rxMh
         jfzA==
X-Gm-Message-State: APjAAAW/xtEVqXTK1CAdkM/azo/2xUoiYdygTGXKXicxJfpEM1tqszsp
        3faeaIAMNuBdrXHOarMaHrZc/NFk
X-Google-Smtp-Source: APXvYqyVBhMo0w6u810+GL89S5w0Gn42TMl//M7mnch4ZiZ7RjNU+A0GcTht2Nd81c+54bh3rEa6XQ==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr1172326wma.2.1572995582655;
        Tue, 05 Nov 2019 15:13:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g69sm718561wme.31.2019.11.05.15.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:13:02 -0800 (PST)
Message-Id: <pull.447.git.1572995581.gitgitgadget@gmail.com>
From:   "Venkat Naidu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 23:13:00 +0000
Subject: [PATCH 0/1] Improve unpack trees error text
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

Improve the following error text:error: Entry 'file.txt' not uptodate.
Cannot merge.It would not appear as:error: Entry 'file.txt' is not up to
date. Cannot merge.

naiduv (1):
  Improve unpack trees error text

 t/t7110-reset-merge.sh | 4 ++--
 unpack-trees.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-447%2Fnaiduv%2Fpatch-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-447/naiduv/patch-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/447
-- 
gitgitgadget
