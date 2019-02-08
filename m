Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED991F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfBHTv0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:51:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33301 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBHTv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:51:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id x9so2884167qkf.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o6zzjL7Swx3JmN5BX6ofOC+KA3UStjMzYoCBTROjFdc=;
        b=a/dp7GDmNDgbmHfKwpMYhPh8fMmhd3dXZHQDRw9W0Nyzf0IZwsGhPEgqB44VN9Wbrr
         vONca8P0kQ4PGDzZUnh8B/zw87BWBFzx/dvqJuAKDEEXjBgU1nGLRDaPIeUcChAKa6OE
         2+k92IznOr9HegHDkcdkzE6qrl00Hi860E3TjvMd5v697p1sybCMdrjFhZzWqnsZRCIy
         zgVl6kCiuCjWnPu1W7QPAUxfNf8h3gq5AoUD3JnrADxY8BTyksSqUmNswUlTVhSuZ2uU
         jgJcrDS+pXvIbNLDdYVYvy0m+qJQFHMNpRUcuEUBN0ncwfGduTXMEvN3scfH5WujRSLz
         QOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o6zzjL7Swx3JmN5BX6ofOC+KA3UStjMzYoCBTROjFdc=;
        b=HW1JYlBdbvHsK/p6s3EywmbO4eaXw8unkIcrC6KYCu6QMk2L7vR+bsSup68BeSdSS8
         EhJRDN//vVfbmqWQ1gBevT8SGphPimYUpPbkugXv/DW8QFeNCnOi8nbL/BMjNmVnJ/k4
         gVe/xgsoAYy5CyHeykE3dc3XnfUpBVAUMiX0w289R855j/KF8BubftikkgmPGeXdLS3+
         PM1C49SrW2RqUTO6tO8Pk3ruRYXLBv5MFyVxNKxAjypZcXTB3p8XKIaeToQIyLiCYlAh
         5D0Hd4PuJEZ2WCU5qysfm2bRwezC2BUSatvqkDTW3GY7x9YCHm8whzW23tKK7D4zKioS
         +5AA==
X-Gm-Message-State: AHQUAubzhot7amPnYtILlC4vLfDBzWtKO6NTe/Q80NYph+41LxxbWFJ9
        CmVE36cW9n+DjlLN7HnHzU/rlQ8wHzU=
X-Google-Smtp-Source: AHgI3IbBUX/6f4oy2hYkcLUgmLdeBX9n0ulEyGhXQgIbyPKMrZQ5NxRh8peB27RCzGJIe5ZuqqOASw==
X-Received: by 2002:a37:8b41:: with SMTP id n62mr17128084qkd.262.1549655484799;
        Fri, 08 Feb 2019 11:51:24 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 12sm8253054qka.83.2019.02.08.11.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:51:24 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, kewillf@microsoft.com
Subject: [PATCH v1 0/3] Add post-indexchanged hook
Date:   Fri,  8 Feb 2019 14:51:12 -0500
Message-Id: <20190208195115.12156-1-peartben@gmail.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add a post-indexchanged hook that is invoked after the index is written in
do_write_locked_index().

This hook is meant primarily for notification, and cannot affect
the outcome of git commands that trigger the index write.

VFSForGit uses this hook to be notified when a git command has made a
change that could impact the virtual files projected in the working
directory.

I'm submitting this in an effort to further minimize the set of differences
between the VFSForGit fork and git.git in the hope that we can someday
not need a separate fork at all.

Base Ref: v2.21.0-rc0
Web-Diff: https://github.com/benpeart/git/commit/639e57486a
Checkout: git fetch https://github.com/benpeart/git post-index-changed-v1 && git checkout 639e57486a

Ben Peart (2):
  read-cache: add post-indexchanged hook
  read-cache: add test for post-indexchanged hook

Kevin Willford (1):
  read-cache: Add documentation for the post-indexchanged hook

 Documentation/githooks.txt         |  18 ++++
 builtin/reset.c                    |   1 +
 builtin/update-index.c             |   2 +
 cache.h                            |   4 +-
 read-cache.c                       |  14 ++-
 t/t7113-post-index-changed-hook.sh | 144 +++++++++++++++++++++++++++++
 unpack-trees.c                     |   2 +
 7 files changed, 182 insertions(+), 3 deletions(-)
 create mode 100755 t/t7113-post-index-changed-hook.sh


base-commit: d62dad7a7dca3f6a65162bf0e52cdf6927958e78
-- 
2.20.1.windows.1


