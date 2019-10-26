Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627601F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 21:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfJZV7N (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 17:59:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54499 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfJZV7M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 17:59:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so5660615wmk.4
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=wMyzUU24OB6UXvN0qePaSmsiVs9hw8Apq2L8ewgdvsI=;
        b=X6XvLqM4fRB+D90eENnpJRaAEbjbEil/dWoTWUG6Z+W25txENEbPyYQ/HLGulVEcfv
         uJLox7xi5XphMDbJnSLFBvbyIszTryeR/6h+p8LGZEgL99jVm9OyzzQGzx8gvNt8Yzav
         DGVRlNppBk77kVkdYsnEMdGTNDICPNIYZS0WaQ41vQC1iDVerrfKDAOQkelniSNx3lF6
         OKuTNSJUe1YI19v7fzVeYZ0bjracE3K5t4j/bW4SiIFm2NQ5h6PUK62aPowYwbe8xSPm
         xU1OW8lxHUkH/HSmyZ8OA9qt7BJL848F2cHBRELcxg25KQ1gD9djo5VBKXY/Zq5Q9xug
         Re2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wMyzUU24OB6UXvN0qePaSmsiVs9hw8Apq2L8ewgdvsI=;
        b=sLSn1QxUZTQB/27fI3nKsu9pv5+bdcidLSpuS0ZVS2kSZqSS5jw2qWTWFpo0ziVIRN
         qLZikB+5Rd86rq32p4+vt01y30Ta+uoPONQ5cSfJQKxrEGSb6CDonO4X4vg7nacqpYd9
         08SAtNW+gnNKBQhlxVIIa5Q8NLyWvxXNjFkkHhIja6rrU89NqpmafepuxB6aM+Tnduap
         YtcGGz4cPZBT0Ab+BDUNAd0/n1ePf/sOneoUChGtpQ7mhoyNSorHMhFH5ExUq7zMbZ1s
         WR/+zxTy74Vq/1bQe8dC7pp5kgvXbRIQtaqoz7NWTH2OldJDGbmtHmTto7yOz1db/V0H
         lXXw==
X-Gm-Message-State: APjAAAVdh1mI/+E7zBJNA1XXjinYAUTOS8tYjTLMeUFS/vSKuB5vRAQ3
        vdBYo1r7ih4oh9ChPzzTn8YVJ+JK
X-Google-Smtp-Source: APXvYqwTEf20k97HUVW3ygJhroVNgmv7po1LCFspn8aQOOoynkuwNAlokTgIJ6+7SOTw4O5KJfX70w==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr3046688wmm.146.1572127150601;
        Sat, 26 Oct 2019 14:59:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm8244485wrc.55.2019.10.26.14.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 14:59:10 -0700 (PDT)
Message-Id: <pull.432.git.1572127149.gitgitgadget@gmail.com>
From:   "Qusielle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Oct 2019 21:59:08 +0000
Subject: [PATCH 0/1] add: respect --ignore-errors when lstat() reports errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git add --ignore-errors" command fails immediately when lstat returns an
error, despite the ignore errors' flag is enabled.

There could be files that triggers an error on stat(), when other files
proceed correctly. Issue can be reproduced when running git under Cygwin and
some target files have utf-8 long names (200+ utf chars). Windows can handle
them, but all operations on them failed under Cygwin. Issue can not be
reproduced with usual latin/numeric only names. For example, create a file
with 220 'й' letters by Windows Explorer, then in Cygwin:

Here and below "ййй..." means the line of й copied 220 times.
=============================================================

$ echo -n 'ййй...' | wc -c # check the real size 440

$ ls -la ls: cannot access 'ййй...'$'\320': No such file or directory
-????????? ? ? ? ? ? 'ййй...'$'\320'

$ ls й* ls: cannot access 'ййй...'$'\320': No such file or directory

$ stat й* stat: cannot stat 'ййй...'$'\320': No such file or directory

In my perspective, it's okay to skip these problematic files when ignore
error flag is specified, but official Git terminates entire git add command
when such files come up. But with proposed patch it is the desired behavior:

$ git add --ignore-errors . error: ййй... can only add regular files,
symbolic links or git-directories

All other files have been added correctly.
==========================================

Signed-off-by: Qusielle <qusielle@gmail.com>

qusielle (1):
  add: respect `--ignore-errors` when `lstat()` reports errors

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-432%2Fqusielle%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-432/qusielle/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/432
-- 
gitgitgadget
