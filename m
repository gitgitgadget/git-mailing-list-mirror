Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81F81F461
	for <e@80x24.org>; Mon, 20 May 2019 08:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbfETIgU (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 04:36:20 -0400
Received: from mail-it1-f181.google.com ([209.85.166.181]:51188 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfETIgU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 04:36:20 -0400
Received: by mail-it1-f181.google.com with SMTP id i10so956080ite.0
        for <git@vger.kernel.org>; Mon, 20 May 2019 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=blnH0Zew50pEdDgvLyJ2wWDO1NpNPEvaDM1Pu0PxXHQ=;
        b=KWE15q/RENHwEk+uIDFdYlogHrshDKxdcURzqdYFJZjjbMGQS1UsQxmzW5cC7mGyax
         qPiZJ49LV1tl9Tf44tx0YZJYxlAc+fNnaYDipE/qBPwkfAxMeaS7xKtf05T21/WgXfYb
         KzpwgInfEwLroEW2oQlIfNK36KpGOjOJ1Xjne6eBPglSraDAiaqicdEr7IQF3o926nJt
         6UBZ42lskBeGFxoWKQUzeBBF+TAPbY94N50Mh+5A3W5tsib4qGpuJ0IbMb5w4Gqh/Hue
         EpHlc0jYyTiz/tGjnzyt5/6pv2E6wA4Gah4mtFrHx491J/UteH4VzxoZTUrubIEYwH+0
         3L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=blnH0Zew50pEdDgvLyJ2wWDO1NpNPEvaDM1Pu0PxXHQ=;
        b=MC3G1MklwdIv+ORXZn5eRyM5VpPWjVunLz6TYXK9vM8u9SaHlMcuVAHaCLm/UHeN+a
         dIoHlzPQ1/klij/YRQbPIS4SOjGkB3uhb5ejJXS2Z4CBsndiNVSgE5htmnzAGqX7SivM
         flhuWQZQup72QXK6Kdslr7zXREhkrvK972PujC+rjGyWSoN+kCdM+QNATzCtPqr0e8lJ
         NUku8bo8OiB+Jl5UBtUPYJNGHYJVErg/kqB/qqCWFPP+yVb9T7y4fYjZEuWhqBpsd30I
         YJ+S/WJz/4KyVuwsdY1mFHPbYhLaHaHUATbISSxiYkseCocWMMAiy3eGfpTcKN1Hgt2U
         9A2g==
X-Gm-Message-State: APjAAAXjWiJLxAhTVsBX+W2ITDdQ2CSBn323Bxyz2HKNmMIoqk6wU6R9
        1+DSHlbmR5eiuDkqEl+ZFdBzj/Cx+gdp/1HJS5mPR6q/
X-Google-Smtp-Source: APXvYqwT6693g1CDXlztyJcIZl9+b+pCp5s7sZDp/8mUxnVvTFMleY2eS6HJSVgNqh+hwWwaHJ/MDhaSHWe8yLqTYTk=
X-Received: by 2002:a24:c9c3:: with SMTP id h186mr27292962itg.155.1558341379284;
 Mon, 20 May 2019 01:36:19 -0700 (PDT)
MIME-Version: 1.0
From:   Alejandro Sanchez <asanchez1987@gmail.com>
Date:   Mon, 20 May 2019 10:35:53 +0200
Message-ID: <CAA4phoGrA=AsBFHkqZ54=6ev5BH+F7rLd0Hcr-t2kF_YFNrs2g@mail.gmail.com>
Subject: Abort (core dumped)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A core dump occurred while trying to interactively apply (3-way) a
series of patches from a mailbox.

git version 2.20.1

Steps to reproduce:

alex@polaris:~/slurm/source$ git am -3 -i
~/Downloads/6033-18.08-final-patchset-v2.patch
Commit Body is:
--------------------------
Use correct signed/unsiged types.

Change a few variables in archiving to use the correct signed or
unsigned type to avoid implicit casting.

Bug 6033.
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: y
Applying: Use correct signed/unsiged types.
Commit Body is:
--------------------------
Remove unused static variable high_buffer_size.

It was set but never read.

Bug 6033.
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: y
Applying: Remove unused static variable high_buffer_size.
Commit Body is:
--------------------------
Handle duplicate archive file names.

The time period of the archive file currently depends on submit or start
time and whether the purge period is in hours, days, or months.
Previously, if the archive file name already exists, we would overwrite
the old archive file with the assumption that these are duplicate
records being archived after an archive load. However, that could result
in lost records in a couple of ways:

 * If there were runaway jobs that were part of an old archive file's
 time period and are later fixed and then purged, the old file would
 be overwritten.
 * If jobs or steps are purged but there are still jobs or steps in
 that time period that are pending or running, the pending or running
 jobs and steps won't be purged. When they finish and are purged, the
 old file would be overwritten.

Instead of overwriting the old file, we append a number to the file name
to create a new file. This will also be important in an upcoming commit.

Bug 6033.
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: y
Applying: Handle duplicate archive file names.
Using index info to reconstruct a base tree...
M    NEWS
Falling back to patching base and 3-way merge...
Auto-merging NEWS
CONFLICT (content): Merge conflict in NEWS
error: Failed to merge in the changes.
Patch failed at 0003 Handle duplicate archive file names.
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am -i --continue".
If you prefer to skip this patch, run "git am -i --skip" instead.
To restore the original branch and stop patching, run "git am -i --abort".
alex@polaris:~/slurm/source$ vi NEWS
alex@polaris:~/slurm/source$ man git add
alex@polaris:~/slurm/source$ git add -u
alex@polaris:~/slurm/source$ git am -i --continue
Applying: Handle duplicate archive file names.
error: object 861d3c6f689a3ca5eb5fb5c409d46de0ad5555e1 is a commit, not a tree
BUG: diff-lib.c:526: run_diff_index must be passed exactly one tree
Aborted (core dumped)
alex@polaris:~/slurm/source$
