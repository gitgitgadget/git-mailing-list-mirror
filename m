Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2ABD1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 11:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfBELtG (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 06:49:06 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44868 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBELtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 06:49:06 -0500
Received: by mail-ed1-f46.google.com with SMTP id y56so2558290edd.11
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 03:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NuJ6lW+iyOsb8HeJnaCUJnxhNqYZ0HYI9DjjRkceYRc=;
        b=sVGltspVPTDp66BzK7lF1TPIHrd4BEHiV2EctpmMQVdBgOmQ4hFvEYsNPdhH064rQV
         8P23sUmf3KnydlCRd+Yn17lxCrq+r6F/6B49ac07tmQ1K1jUIaUqJxvC5mAHYf0E6p87
         HeTAPU7D5XolSRA0WfUuJlVI4L8zdv9dZpVny6X9sLGFYGFoJDRonmbxXS0J9QkokC93
         NLC3Tz1wnhUq4/pNYEKYoruH0tHi+CEsZU2G3NtJYwIKncnuiTdCeXlaHsedwYyqV2fU
         JyETjdbozHmfBwYS5Kl8hC6r3104elRQ5IbTCy7L/2r8BvxDnrsCtWuJdB6qKeSLia54
         Ap3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NuJ6lW+iyOsb8HeJnaCUJnxhNqYZ0HYI9DjjRkceYRc=;
        b=rDa2RPZ0YZzrVHQdq3AC4AMK5A1dKU9swrDllObHPK6KdNL4rNdUIpP3queHM8yMaV
         OAkCzwRT4biTrWyq6+55Ll99HRgQ2ONSBzu4VlyPPsCHZhqP+hbYO1vteNQi4B5u9MbW
         +Bbk4sgs2gZNog3aZTGxu6pbU/UNoxetKV5wpRUxpMfdHW88IF+D5ZeWVZAuicSN+igR
         y2GwCid99qZ5pCgmJvSuwArJqN+7/8D5vtALTYxlgyqWb8VKSMxTh1mfUXCtmnIzh08w
         B/5YkjeEiAduHQZTDCLa4A4xzPv7blMUdKfQnTKkmeuxa3WL1QBBdqpAE1Bwn7OS49Yq
         +glQ==
X-Gm-Message-State: AHQUAub16w3Qm4kPnzW3AsIibeC6Rew7ZnvG62qTTzoQbmh4U6VXaYAV
        Zw6nVa4OAINxr3dZRUSrVKMg6Dpf
X-Google-Smtp-Source: AHgI3IZfAMNyvOyqyC+3EP2+HV2fLCa7eOX9LS8bEksf6byXNR4K2INwmATf2RLfSAtTbAFRKeND2g==
X-Received: by 2002:a17:906:8144:: with SMTP id z4mr3196714ejw.205.1549367344188;
        Tue, 05 Feb 2019 03:49:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1sm2972504ejx.41.2019.02.05.03.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 03:49:03 -0800 (PST)
Date:   Tue, 05 Feb 2019 03:49:03 -0800 (PST)
X-Google-Original-Date: Tue, 05 Feb 2019 11:49:01 GMT
Message-Id: <pull.118.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] rebase: drop the unwanted -y 
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

I totally missed that this patch, despite my pledge to not include it, made
it into master. Sorry about that.

Johannes Schindelin (1):
  Revert "rebase: introduce a shortcut for --reschedule-failed-exec"

 Documentation/git-rebase.txt |  6 ------
 builtin/rebase.c             | 21 ---------------------
 git-legacy-rebase.sh         |  6 ------
 t/t3418-rebase-continue.sh   |  3 ---
 4 files changed, 36 deletions(-)


base-commit: b5101f929789889c2e536d915698f58d5c5c6b7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-118%2Fdscho%2Frevert-rebase-y-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-118/dscho/revert-rebase-y-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/118
-- 
gitgitgadget
