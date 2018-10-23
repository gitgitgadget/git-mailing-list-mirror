Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F27D1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeJWTPn (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 15:15:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43234 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWTPm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 15:15:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id d8-v6so444900pgv.10
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=awcaT2Qbag7FuSAdq+P3maEDCvNlcqJRXeKq6O402vA=;
        b=f1uvIxMWlGCYFM9tYDbCpY87POZUISBfwvAtIpNADxeZde0q1jjQ0/oWfn9/RMVtDD
         HF28AHywYEFHxu/FgLB8+gs5JzQC7LoVF8BvRpXzHiEI6/U/b9JyzaH7fDzdDS+pfzid
         8u4N+s9m1iw++5ChgScEYTg4tV+YlJgcxhBAlo+pTt6EvE424rS4LxUXmJSWrdGWD3Zf
         qMPJgbHmRTCo/ARmsOuPOSM//7dDe7stSC2GgjjG+EEYR7OC+kH5DH1/DjzCYhWfIN+5
         Iu9AfORDVsleZJDo9Rp2XUYKHsPhO00+lJrLT2Eo5jC/w5EQWRisrApFk9SOXhK7mIP3
         p4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=awcaT2Qbag7FuSAdq+P3maEDCvNlcqJRXeKq6O402vA=;
        b=gmNvPUMNFldvDsol2Zl6MOGcL3EiwYEupv2ahmSe8UA8Qeu4mNV0B+z//qOQ3oGoHw
         gFV/DnL7mdrtSOOd0aeSRJidi5bco60yJrfx1TbEzJrB0cJH0I37VbM37MMuUH/rMDT3
         jtjggJ8Mu5xxYZQsq/AYGkYto64lzdUA8CLm0892oPaSEQ3s3x0gsbGDWBUeJ1iVlv4n
         hsXyAVpIWEN3HbGOcUaLQXuNO/OtgNe7F6RVenH8gVUst9QMbwz0upWFt8Y+SrDu8rv5
         +O5VbVdrIwlULRoKagKmvG92Zlo0v9VcBr5HNbTuQ3STK2vkziqXp8bM94nVGLB7i+x9
         Nbzw==
X-Gm-Message-State: ABuFfohQcJQpj+IerZZMqkjvzXCXYKMu0zXsfKCA4xmSuOV5jplnC7y3
        xkYzc8mdC4kf8LDW7ucjkomMtSeY
X-Google-Smtp-Source: ACcGV60jjOV09QjRqHqTUUr7dfF6pOOQctO39059uZdyGbSDSmejYFqyRVUD87WPozlbVVRpgsLQaQ==
X-Received: by 2002:a62:42d4:: with SMTP id h81-v6mr50565767pfd.0.1540291967452;
        Tue, 23 Oct 2018 03:52:47 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id j3-v6sm1336797pfn.175.2018.10.23.03.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:52:46 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:52:46 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:52:43 GMT
Message-Id: <pull.54.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Work around case-insensitivity issues with cwd on Windows
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

Anton Serbulov (1):
  mingw: fix getcwd when the parent directory cannot be queried

Johannes Schindelin (1):
  mingw: ensure `getcwd()` reports the correct case

 compat/mingw.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)


base-commit: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-54%2Fdscho%2Fmingw-getcwd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-54/dscho/mingw-getcwd-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/54
-- 
gitgitgadget
