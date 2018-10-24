Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F4B1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJXRq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:46:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44564 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:46:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id d23-v6so1952241pls.11
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gJjpMUYnIzflc4m5g1x6IJ1lzkh5aTb35pGDHF+2fg4=;
        b=Aj4YF9EYM0M+hTqwLdZI6KAofLVRdTs10+g35phvSqcE1PfX3CW7LMu97MHlVAja43
         KPtXcoG7/ISpickB6YMmy5F29bO1L3+0zBZgbodlHsuWRUa69E/XTqSNFlEOIalSgK7D
         1DO9G70ah06qiMXXV/WNevZ4ZsLoVudFuraO9B2Z2cp6l5CsOOqaqmGpoZlUvIO9bNyN
         deelVNIl7v10S+B3IO/mJsGRvaqpFZyacLxW1rShMZw88BF1iLTUZVIid8qF7wyBVdOs
         RAQKzYOguHbm9E4ABWU5z5DaChPMBxmM8LGgIIeUcwcaGLXkbEQt6H3I1kCewrxAQllC
         1LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gJjpMUYnIzflc4m5g1x6IJ1lzkh5aTb35pGDHF+2fg4=;
        b=LGfLqVE90rG/5+Gyy6acJXFdUsBai6CIEQEjhF93abxH0WYGVn3WWLtW0pAInfPN0w
         ZUe4QkyGI8eTUX355iNOcgVztdWsvzqcMHor2obilwzAgJTWQug5uTk5WkFQA9gEMPgS
         l+Wd3+L9CuoSlbtoWAj+Xfxn0/HZAn1bMIQ7Jg3W/ulpmQMW4qffmqwoDRdb65LtgQGX
         469y/ZAe/++qmeR6JYRC00pHCyCmO12ptQPt6+MUPU6XMNvto0Hv31tGk4CfEByJId0w
         QmBV9v4CeqiMKbQzpV7XAGRCMM9GyjfgQ70dqr9nht2+QjVXQON8aESFOI4vpCprAWcA
         mW9g==
X-Gm-Message-State: AGRZ1gIqfjabYofcVupn1cB+PlgbjhjpRZTBAUhZYJElIESztuqfxQ6H
        XAwGQ5lEAgkfDI/AL40QpLF2SN3f
X-Google-Smtp-Source: AJdET5d0tRXhYokAdal3xrbVQusa3A3K6vlo/kk8RkiyQa9QRV3Lm1kF3v3gv/i52GHCIjPmy/tEcw==
X-Received: by 2002:a17:902:223:: with SMTP id 32-v6mr1803703plc.112.1540372780122;
        Wed, 24 Oct 2018 02:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id o12-v6sm6389445pfh.20.2018.10.24.02.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 02:19:39 -0700 (PDT)
Date:   Wed, 24 Oct 2018 02:19:39 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Oct 2018 09:19:35 GMT
Message-Id: <pull.54.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.54.git.gitgitgadget@gmail.com>
References: <pull.54.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Work around case-insensitivity issues with cwd on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stephen Smith <ischis2@cox.net>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, file names are recorded case-sensitively, but looked up
case-insensitively. Therefore, it is possible to switch to a directory by
using incorrect case, e.g. cd documentation will still get you into the 
Documentation subdirectory.

In Powershell, doing so will however report the current directory with the
specified spelling rather than the one recorded on disk, and Git will get
confused.

To remedy that, we fixed this in Git for Windows more than three years ago,
and needed only a small fix a couple of months later to accommodate for the
diverse scenarios encountered by the many Git for Windows users.

Not only to keep the story closer to what happened historically, but also to
make it easier to follow, I refrained from squashing these two patches.

Side note: the second patch is technically not battle-tested for that long:
it uses an API function that requires Windows Vista or later, and we only
recently started to clean up Git for Windows' code to drop fallbacks for
Windows XP. Read: this code used to load the GetFinalPathNameByHandle() 
function dynamically, and that is the only difference to the code that has
been "battle-tested" for close to three years.

Changes since v1:

 * Fixed a grammar mistake in the second commit message.

Anton Serbulov (1):
  mingw: fix getcwd when the parent directory cannot be queried

Johannes Schindelin (1):
  mingw: ensure `getcwd()` reports the correct case

 compat/mingw.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)


base-commit: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-54%2Fdscho%2Fmingw-getcwd-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-54/dscho/mingw-getcwd-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/54

Range-diff vs v1:

 1:  e13ae2338 = 1:  e13ae2338 mingw: ensure `getcwd()` reports the correct case
 2:  3e3b1c3b1 ! 2:  87ef9ac63 mingw: fix getcwd when the parent directory cannot be queried
     @@ -4,7 +4,7 @@
      
          `GetLongPathName()` function may fail when it is unable to query
          the parent directory of a path component to determine the long name
     -    for that component. It happens, because of it uses `FindFirstFile()`
     +    for that component. It happens, because it uses `FindFirstFile()`
          function for each next short part of path. The `FindFirstFile()`
          requires `List Directory` and `Synchronize` desired access for a calling
          process.

-- 
gitgitgadget
