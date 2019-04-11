Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE7820248
	for <e@80x24.org>; Thu, 11 Apr 2019 12:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDKMsK (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 08:48:10 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46988 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDKMsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 08:48:10 -0400
Received: by mail-oi1-f174.google.com with SMTP id x188so4734662oia.13
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GJ06CQbechC6aAYzYph9esNKVRRGfM3Z4yyU2bCtijA=;
        b=LDbzeVOQzGRqHInLXBun2/YgGHEWgE1I3FvydXzrzxjW4T79uTpGrYcs6fkNZjB5yD
         3pq1LiUJ1Vp/sFWQtKuLhA3Y+3eSMAGUD8b3Ji2kEGtBI0c+G9gSsjc0aP4F4biOv0sM
         xin3ZxFH7vAI36ipuhx0aaIj+nSFXHDFHSH8G8XtfkR7ROhfG9BnFTA36P/pO+dy3rgV
         nra9Zo9J0E9Gn6DeGsyGLZ5sNrWQigBDX4vanah1w5p5LdMVNKvA9z1MSmh9dOaPMEqd
         UB9ePKNBYEYlEMJthw5h6pDCOlB2i3BY6LfohD4FvSqW+u4aDREP+vyM8yPJquQrm/Mq
         4TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GJ06CQbechC6aAYzYph9esNKVRRGfM3Z4yyU2bCtijA=;
        b=JSlJ7kFjiylx9GV2ew28MaU8jdTi1WkmNax9402gaswcagrsuLxo2GHALzWKtwXTHO
         93kS22Yf0m/+Owfcq/kUyI1ohfIBSOpuU8Rxv/vVFuURV2N3gMMG2sX55ctld/3916tz
         V7KSPjynqTCA1u1OhurwqWZtN4/tbecJp22lAhm/0pUgOeQsgou2jWLyWBJ7qOvt4bJp
         KY9T2xcsD8gITfYnVUplIXdMZWbibSBtDxl7juNsDPgprDK+oA65y/a9ZSy+f89+5OGt
         5rxj3Vq67xlQ0nLK/GFcrl5znl4E/mXKUn5N0hn6VF2QZQYd4x2JjEbEaR3Vr9D9LKYL
         uUzQ==
X-Gm-Message-State: APjAAAWaJtWajItkyYJ5QSRVraBcR14LqqvSbUkNfWlejSdQbTCjXTXf
        ie5gnE1DGOIC20Sjn3EABrikJ3vfDaU57d5Pv8v3Jg==
X-Google-Smtp-Source: APXvYqxcg+3vXOqFgmyYteq+gJh9M9OCvXiDpThHpu7wEP8TgM5M1dbGUMgtpgKg7HEcYT/++eyxEe2UDqjq5la+Krc=
X-Received: by 2002:aca:f581:: with SMTP id t123mr6489022oih.0.1554986889576;
 Thu, 11 Apr 2019 05:48:09 -0700 (PDT)
MIME-Version: 1.0
From:   NoName Req <nonamereq29@gmail.com>
Date:   Thu, 11 Apr 2019 15:47:58 +0300
Message-ID: <CABgj7us=Rk3EUvd2EVVqsYKDUGS7VfAX09SpW04fB26cgntw5g@mail.gmail.com>
Subject: Bug(feature?) on git-diff-files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Summary
   `git -C (folder path) diff-files --name-only` output is not correct

Steps to Reproduce
1. Apply change to a clean git repository. Go to another folder (not
within this repository) and apply the command
   `git -C repo-path diff-files --name-only`
The above command lists dirty files in that repository.
2. Now undo your changes on the repository
3. Issue the same command. It still lists the file.

More Information

`git -C repo-path diff`  command doesn't seem to have this problem.

System Information

Arch Linux 5.0.7-arch1-1-ARCH
git version 2.21.0
