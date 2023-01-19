Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03078C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 18:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjASSGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASSGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 13:06:30 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E19BB740
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:06:29 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id 6so1367876vkz.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hCgh+F/YbuI1xNXlhlylJRNHQXzFu628+j4paV126e0=;
        b=JBY0E1yk0J3UEjBw8bwkPrDzJ8xtZN/UOwiX+zVsS657gycm52VxlUfvglB9aLuFIp
         DsxAMbtPCtWbYelnfPKeBgVInrRiTajUh/fQ5C5tlmbVTQRAC9yLmwHMs29zN8zGT7JU
         6X09sCJQfLfgjopLpXt9uksCHq3nLUEZf6bJZCOKUrX8nbCfvwkH9IE8CyaLyeO37zrn
         05k5jTJgF+cN+SyVuAKawzsqhZKd/HJg6uKT0BXNppwDaXua89OJU1msiuOrDfAG8+qo
         9dS9/RZH9UE3W7vIUDf4z4ykGVrmD8+d1ZzM6TcirTm7CLm19fhM/rbo3HxwEbjlhFwS
         2QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCgh+F/YbuI1xNXlhlylJRNHQXzFu628+j4paV126e0=;
        b=c1/FGkVh//1LvcMZU012FskPMJraheLy4pSyZilvMI0Fjgr1SUQPtf20JsI0TS7PFM
         VEvWIzk0RqaTuHwsUbVETaXlgYgZqOyiImm+rbGvU4I0cwHAaX6vEY2U+ia53vWQ+1L7
         +I3s7c8o6HOJDKwXe2F28sIBhn1PXEQ1cN8JaU2wKHyWEYUFeZKXUSagxs9YbKwFyBJr
         W95Jc4AEoVo24ILLw/odOsM7IqsCKDcwSEroYpLxSCkxqEiPUPZ6EYr5e4yoBzs6uSuV
         6CqCnSLLePMLWgOiqjAHin9bg3ltPksZonqjhiTzjVE2VVg5Vt2imTKVcRU74wGyHR97
         AwiQ==
X-Gm-Message-State: AFqh2kpK7lRsAWNenGzMKXcFXm7ajvdSLC2+qdsYz1+XDuKZJg1/PK1k
        uCt6VWGwTBHNJATscDgSKIo53s7clHEkFMg/47NpKkmyCpiAOA==
X-Google-Smtp-Source: AMrXdXsdKgcHLtM3cOj6pQXPhNV7D54k/NfNA7IJLq0mdhhfPGb7lJKvxSu5R+cP7zVCO2jjphVxwu01CzeTLQ/v7Pw=
X-Received: by 2002:a1f:1890:0:b0:3a3:7a00:1084 with SMTP id
 138-20020a1f1890000000b003a37a001084mr1539006vky.41.1674151587970; Thu, 19
 Jan 2023 10:06:27 -0800 (PST)
MIME-Version: 1.0
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Thu, 19 Jan 2023 13:06:17 -0500
Message-ID: <CAKepmaibtbRsKqmiZEtDNoLHWr=JyZ7Fhang4dnmw5ROGmBQTQ@mail.gmail.com>
Subject: Redirect isn't working:
To:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the filled out form for submitting a bug report:

What did you do before the bug happened? (Steps to reproduce your issue)

  At the command line, I typed the following command:

  $ git diff --no-index --word-diff --color=always <(od -An -t x1
-w10000000000 file1.txt) <(od -An -t x1 -w10000000000 file2.txt)

What did you expect to happen? (Expected behavior)

  I expected to see the diff of the two files.

What happened instead? (Actual behavior)

  Instead I saw this:

  error: Could not access '/proc/1961/fd/63'

What's different between what you expected and what actually happened?

  The difference is that I would get the difference between the two
files as opposed to a critical failure message.

Anything else you want to add:

  Nope.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.1.windows.1
cpu: x86_64
built from commit: b85c8f604d375d4d773a36842964e8a7ec056aae
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
