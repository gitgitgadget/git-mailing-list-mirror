Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9146B1F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfAQI3X (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 03:29:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35771 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQI3X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 03:29:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so7674955edx.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uWAoJiUevVJRm5V4ShMFvOcdIQdd8+Wo7z8J6R8mYVo=;
        b=LOIiLTjEWPL/MrRtpOemU5Buvsv0k+CuFxjWz9xenzIWGOJPGxGcDaWgbEnIaVjocd
         bRTCZdx10QHGMl9cH+HCB39BSjJTfxNmN5zn+YzNE0LmhztElzNxcRCDJUsv8SyqBaF4
         fgBZkudC2nfhE2Az6Jyuq9DJIDMk6eB3gocD6khZnbQPfCltS7r+aZaHu68E1VUyhMNj
         frc9p9DGjSIxX83IB45oIPb0tmP5V1Rz8+Wb3w785gwXBfAF7k2Oj3AutMrY3euAFnyX
         fZ6hPf+91boyBniO9Z9Xy3SuzXgbYq1f1ycWC1lTuxlXmdRlRVPQR7LRBJuqIQ4L5WAr
         sIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uWAoJiUevVJRm5V4ShMFvOcdIQdd8+Wo7z8J6R8mYVo=;
        b=ndbppRA9vIeciLiuz18UaefVG6wCrWNuZahCKcqkQYmSC6fXPYCzUFPlnZOstZVf6t
         cBjr2P/O5S6YTmUBk9NyO1Xd+hfQML6xCkZnu6OPofBXCVOuKK44vX1XVSM7OkuBRjhQ
         UDlwaRIW9oXQAHygS0+ITZFWoAf3l2Tn6TkdZW7McRTTTpOLlalUprux9qnmauQTn+IQ
         JoMNEF0jn2CmSQo87ssDIi6xE8GeYDpy1qAaYgv/WEn6vCls5r892aCuXfGr2oBrsdHD
         FlF3gJChh51qjD31N37rvlaSTXXMb1WiekEonGIXIrqhhJ6Pa+YroABV+ym49kO2G9YF
         y3fg==
X-Gm-Message-State: AJcUukcqDa+mjEOUMQeMb8WFzVXvuWTkkpWvACxulYl0BLploPd4Z9aM
        su3ecoM4cuXvICsdCGZT9SCSrviO
X-Google-Smtp-Source: ALg8bN4wX0OEvrabke2Of67ljmJ0+w/VZTFZbbF5XCD9VJqAkdk9rRRHJa7bNla98CKgaw9O/GE/cw==
X-Received: by 2002:a17:906:7751:: with SMTP id o17-v6mr9939561ejn.15.1547713760953;
        Thu, 17 Jan 2019 00:29:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g40sm6097092edg.39.2019.01.17.00.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 00:29:20 -0800 (PST)
Date:   Thu, 17 Jan 2019 00:29:20 -0800 (PST)
X-Google-Original-Date: Thu, 17 Jan 2019 08:29:18 GMT
Message-Id: <pull.109.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.109.git.gitgitgadget@gmail.com>
References: <pull.109.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] t6042: fix breakage on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unfortunately, Travis decided to change some things under the hood that
affect the Windows build. As a consequence, master has not been tested in
quite a while, even if the test runs pretended that it had been tested :-(

So imagine my surprise when master simply would refuse to pass the test
suite cleanly outside Travis, always failing at t6042, despite the fact that
Travis passed.

It turns out that two files are written too quickly in succession, running
into the issue where Git for Windows chooses not to populate the inode and
device numbers in the stat data (this is a noticeable performance
optimization). As a consequence, Git thinks the file is unchanged, and fails
to pick up a modification. And no, we cannot simply undo the performance
optimization, it would make things prohibitively slow in particular in large
worktrees, and it is not like the bug is likely to be hit in reality: for
Git to be fooled into thinking that a file is unchanged, it has to be
written with the same file size, and within a 100ns time bucket (it is
pretty improbable that there is any real-world scenario that would run into 
that, except of course our regression test suite).

This patch works around this issue by forcing Git to recognize the new file
versions as new files (which they really are: the patch simply replaces

git mv <old> <new> && mv <file> <new> && git add <new>`

by

git rm <old> && mv <file> <new> && git add <new>`

which is not shorter, but even a performance improvement (an unnoticeable
one, of course).

Changes since v1:

 * Clarified the change in the commit message.

Johannes Schindelin (1):
  t6042: work around speed optimization on Windows

 t/t6042-merge-rename-corner-cases.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-109%2Fdscho%2Ffix-t6042-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-109/dscho/fix-t6042-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/109

Range-diff vs v1:

 1:  598de6652c ! 1:  55b0a641d4 t6042: work around speed optimization on Windows
     @@ -35,6 +35,12 @@
          now add the files as new files (as opposed to existing, just renamed
          files).
      
     +    Functionally, we do not change anything because we replace two `git mv
     +    <old> <new>` calls (where `<new>` is completely overwritten and `git
     +    add`ed later anyway) by `git rm <old>` calls (removing other files, too,
     +    that are also completely overwritten and `git add`ed later).
     +
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh

-- 
gitgitgadget
