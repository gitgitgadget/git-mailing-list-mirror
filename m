Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7FB01F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 11:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeK0WKx (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 17:10:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36767 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbeK0WKx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 17:10:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so8200906pfc.3
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rek4vBl9XN0vF5oOQSoDyjoyX7UHw08TD+/OQPLQoz8=;
        b=PmmTQu6EJ7ejfED1hdJo0mwOwsL/Kt+5OxgPN2Dhz6dgNWviQElPXRLc1dTUjhJLf5
         vuBXD3NroWYH+XBo/pbwsaVx4tPaeWM9fLOcl0WVdW9SZlyCACqK8UAS+VSJxM3Tbm6W
         6ip10o2o9VMU4IcPSOGoZyfnz56+Xz3lH/SMb4IKgGLc71xcEy1+0pkXqxB5YLeEnj8D
         oSbG8c9+r2i27hnZYYXrZQfxBhKo0fvlwIEoL0jf4n0MjE08t2LUaG3IMrURConyfeq+
         VUAytV2bsldCenxlT9YwltA6YGyjJDe+vnfDDSS9lv2xg8hpgsB/4vgeHUDPckWZfAGH
         W7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rek4vBl9XN0vF5oOQSoDyjoyX7UHw08TD+/OQPLQoz8=;
        b=MqaraJCp4fA8RjFuWtg5nddBKJH9bAqqGoG3Nm0Gmb3U1GO66DL6emM/dFuZHA8TWO
         unGviOOe5TuSe7GU9GPlEZHAMGc2khMNpkjPH+CU5kiVTUqsfdh2zf1aXoquzz1gMBqI
         FIS4ag6KyaMjF5OucBGixCMGvNvTEQvwsySpKl3cw9wpJSGOmPVzyMB+0MOMNuIlGN67
         xgM4kc9rQxwhuz9PYrOXfQmIxcvTrIgufd9O/YZvfX6YSTU6uTes84BSdKgnBlXb+6nV
         rPO+ntSvITa+zc07665JOTjoaoRFIsXOsC2RKJlSz2vlNhsDRCvRji5ykrpghYRRwBjL
         rB7w==
X-Gm-Message-State: AA+aEWZ9Hvr8A+3wqcNuWhGSaEurAsGqghHI0UCURNfgVTTtKeaTWxzz
        66DvU5Mcpc5HVatWtgwxVCvjZGHq
X-Google-Smtp-Source: AFSGD/XFtFKj0ZKwY6ilgSAUilVGMJMHKZ9FSPOCr6OvYAnTLT3SruecFBdxVv/GSZGWF3MURJf9tA==
X-Received: by 2002:a63:585c:: with SMTP id i28mr29000311pgm.178.1543317198936;
        Tue, 27 Nov 2018 03:13:18 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 8sm5046065pfr.55.2018.11.27.03.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 03:13:17 -0800 (PST)
Date:   Tue, 27 Nov 2018 03:13:17 -0800 (PST)
X-Google-Original-Date: Tue, 27 Nov 2018 11:13:14 GMT
Message-Id: <pull.88.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix git rebase --stat -i <unrelated-history>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

We're really entering obscure territory here, I would say.

To trigger the bug, two things have to come together: the user must have
asked for a diffstat afterwards, and the commits need to have been rebased
onto a completely unrelated commit history (i.e. there must exist no merge
base between the pre-rebase HEAD and the post-rebase HEAD).

Please note that this bug existed already in the scripted rebase, but it was
never detected because the scripted version would not even perform any error
checking.

It will make Junio very happy that I squashed the regression test in to the
patch that fixes it. The reason, however, was not to make Junio happy (I
hope to make him happy by fixing bugs), but simply that an earlier iteration
of test would only fail with the built-in rebase, but not with the scripted
version. The current version would fail with the scripted version, but I'll
save the time to split the patch again now.

Johannes Schindelin (1):
  rebase --stat: fix when rebasing to an unrelated history

 builtin/rebase.c          |  8 +++++---
 git-legacy-rebase.sh      |  6 ++++--
 t/t3406-rebase-message.sh | 10 ++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-88%2Fdscho%2Frebase-stat-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-88/dscho/rebase-stat-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/88
-- 
gitgitgadget
