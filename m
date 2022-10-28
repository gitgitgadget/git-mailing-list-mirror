Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D94C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 22:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ1W3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 18:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJ1W3m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 18:29:42 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68499165AA
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 15:29:41 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-369c2f83697so59745487b3.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 15:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1PwdONI5u3jjeqW1rM/utFsmF5/CReP1IqYRmozCh0=;
        b=dh93ZKg1ghNhE4aE9vuL5SK8gl0+3idZe/4cfVzUW/h7WXztEWaMcLYeHXc6rMXij2
         9yPcmtMbbm/2n8TV3Dq0egOd3wh1tKVvJS4w/PV1HiTQRsYYFkPnziOzZdOdotvpK5fc
         XihFzRWEm/LAtU4EOwlzmQQX5ZuNh6BI7Zj1tQMzs7/FVPqTwODwnUcB0JA0ysgk1SsK
         Un6MA/1teuZj0NY95vBQtYvBl0Fux43MOvU4de0lWSTAn9AyiN0+C0BaM8ILtbsmGO8v
         4wc98kJzh4ZyIMzRjm/Om79uigw4/Zmp6/kQA5T6Th85zBVvBET1tqBCqvmSkodb1D4E
         QsUQ==
X-Gm-Message-State: ACrzQf0DX+ZKv69q1S1+A/urTo7kFAmd6nIdJG8+jyTmE9W2xSD5EIz4
        iTU35OoV5ojSCOSJZIzcZAHyTz6jVbLnfZTVUgvxtEmdua4=
X-Google-Smtp-Source: AMsMyM5RkHNT7Uc7hoIxv2tY0I0OzT4uK7TZlnzJGO3uGUQPt5e6wRkBmNLjhiIbuq0b3a/oX7zaHB3ghKRYKlXFzzw=
X-Received: by 2002:a81:ad09:0:b0:370:5b7:bef2 with SMTP id
 l9-20020a81ad09000000b0037005b7bef2mr1646905ywh.47.1666996180426; Fri, 28 Oct
 2022 15:29:40 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Englund <martin@englund.nu>
Date:   Fri, 28 Oct 2022 15:29:33 -0700
Message-ID: <CABYbkvP=fMmaFUD3bQbeQ-XKiMSP6g-u0p7Vq1Qt_K5=D5WJ+A@mail.gmail.com>
Subject: Git Bug Report: out of memory using git tag
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I created a signed tag (git tag -s) using a ssh-agent key and then ran
git tag -l --format '%(contents:body)' v0.6.1

What did you expect to happen? (Expected behavior)
I get the output

What happened instead? (Actual behavior)
fatal: Out of memory, malloc failed (tried to allocate
18446744073709551266 bytes)

What's different between what you expected and what actually happened?
git tries to allocate an unreasonable amount of memory

Anything else you want to add:
I don't have 18,000 PB of memory

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.1.280.g63bba4fdd8
cpu: x86_64
built from commit: 63bba4fdd86d80ef061c449daa97a981a9be0792
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.0-1021-aws #25~20.04.1-Ubuntu SMP Thu Sep 22
13:59:08 UTC 2022 x86_64
compiler info: gnuc: 9.4
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

Cheers,
/Martin
-- 
Martin Englund, martin@englund.nu / GnuPG key: FE91E717
http://blog.englund.nu/
