Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7B220A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeLMTyM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:54:12 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44794 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMTyM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:54:12 -0500
Received: by mail-pg1-f179.google.com with SMTP id t13so1514244pgr.11
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jbFke6Yt1WSU8rxuWrFstuVA7yB/gxgt+sR0Q4zqUSQ=;
        b=rW9Bu44wN0RlUgFkjmW8nzGeH8tmchN3JiF4E5arWlBAJbJppCf90qQT9+26kWwK6E
         wSzYYjhV/6SLJ54lpWOzAWGI/rQFGSSjTCl1gmHWR0etXQm6raWZamjxlrjKUCSYKHLE
         Q5i2qb53sXyqydShXd6YC0FaPRJy+lsHfPhIbjyaRFmMiupZV1gi+FZ4awzl92SEJOLY
         PZfOhDGNcPLF1goI1Ia8D7N1abc8bT5ZcIABNClLvi6iq8cNQaRUYRr26FN+kVy/ZtQy
         plmdUuDKX34CCuL0v1VrkTML3DNrRamn6nvqvLNFGI2lVxyaXJD5eg3qqCU+ew53syK4
         dW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jbFke6Yt1WSU8rxuWrFstuVA7yB/gxgt+sR0Q4zqUSQ=;
        b=O3p/DdUkCirq5QxqNToI8tWAsYKIAJyhto5w7r3qlln61Zmt3X15NEAv7VLhIzBOCa
         otG4ArOtmgb4nm82HkZfrku9Q92KwsLgf7nRL3kS3oPBugfxXx9Au2FZ1Yr5vA4V/sOw
         ioFku+JUlwuWmp+8bVlZsKDJO1uhq5aX+AbQXSxvjkMmM6hlHwbwEOI5M3kZmlvKS0Le
         T5Xvf72IxgQxaERW+9TncQCpyQALgsrBidqZ3xFMs0WAe2CZ23fOOTI9q52EX/XPkWMO
         i5wgDTKsm7o4WUyNuIkqSpcUdFH4P6nUdKN0bg+stm3WMB8VnW8hqaMpvfoSJwFQ5FXb
         LiAQ==
X-Gm-Message-State: AA+aEWb+czyhNoALsbHx25T6bDsyEA97DMQ5bJd5C+4moCQlD4UEs0YK
        1BiRUDUFKVHSYJ9t9vgK32BqqP+2
X-Google-Smtp-Source: AFSGD/VqiACGTo6w7rNXrj1e3+gGCMZ6jJjy3uWVFW418JqJU9slx+0Z9SmkjIfpoYba3uV6BSuVBQ==
X-Received: by 2002:a63:4002:: with SMTP id n2mr113612pga.137.1544730851116;
        Thu, 13 Dec 2018 11:54:11 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h8sm4191339pfo.162.2018.12.13.11.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:54:10 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:54:10 -0800 (PST)
X-Google-Original-Date: Thu, 13 Dec 2018 19:54:06 GMT
Message-Id: <pull.100.git.gitgitgadget@gmail.com>
From:   "Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] worktree refs: fix case sensitivity for 'head'
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

On a worktree which is not the primary, using the symbolic-ref 'head' was
incorrectly pointing to the main worktree's HEAD. The same was true for any
other casing of the word 'Head'.

Signed-off-by: Michael Rappazzo rappazzo@gmail.com [rappazzo@gmail.com]

Michael Rappazzo (1):
  worktree refs: fix case sensitivity for 'head'

 refs.c                   | 8 ++++----
 t/t1415-worktree-refs.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)


base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-100%2Frappazzo%2Fhead_case_sensitivity_on_worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-100/rappazzo/head_case_sensitivity_on_worktree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/100
-- 
gitgitgadget
