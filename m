Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA32F1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeJWSqH (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:46:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37233 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeJWSqG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:46:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh10-v6so411525plb.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BYRpcx1HydJNz9/R/GNovBQU1Y1i6uP4vjfcAOvYwe4=;
        b=V8TwI9RE4faDuOfNWFY4YMBGbGvQyD7wNvb0NeyIK3r/oxndbXPWJGhKtheO5vEISp
         c2ABxFolRQUz3cjR8WSQTLMA8dt4GTTzj3gY/L5AYuzhxXXdOioTUec8NWVE++oR/wz/
         GmteqiP1Rx8ewL9n7o4HWZHX7Qb/wKjW+BTJARI8Eef8tKCV2WCzqtxrGnCqqH2CraXV
         ZB0gR6KwCwLcmb6qOsQ+9LWY7YC82KQYU59UPbgQ+TMnbmn2Piidw+KGZ7NCH2++iDgf
         aOZTEGzn5HoKKnWT0WGmIsHKmWCCK2KzkgYwMCsInN+1iBCIJO3RD2SmoNi+hbdj1p9i
         gCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BYRpcx1HydJNz9/R/GNovBQU1Y1i6uP4vjfcAOvYwe4=;
        b=MvMFxg9jli3jF+mymruw5CEwycG01ak949lGwY9VdM94cIHbL4GA6t0l/EbQtrIGY6
         Fkfl4OI6wK6MTBNhhsTcrTSBLhvXYMazV0Q4lKR5heRW8JE8pBOce2+2JC3iJf9sfSCD
         ypD/Vq3LmVCvMLtoHfQ0ZjE5aSTiV80o6xlfpEtk8zaIZtQfqIYCz6KxdYMsI+MYLBe7
         kpPUSqaDtdjNxQ8i603skqynt6Ui/cKku6gi5OXZSN/bVqlOkKmn6zbSPadxBZOGI+dE
         CTY40BplaYzdr1OU0a4RNNWd0M2asPtHCewEgdh7in1+PyfE2ZpUEMoObRIBJqawL+i4
         RKIg==
X-Gm-Message-State: ABuFfogtWtdYg5oN+jho9m2NmM+uwcDHVP5sEK/FPhtlODuaYmFHrWzo
        +wIr5WNawJh7/mhw4QsWwQML7IHK
X-Google-Smtp-Source: ACcGV62it55f7hI8pMImRyxNtcpXw8CDVTaJ9owpSc2TYc3Yg6iAQF7N338fHTGwOdww56J9cT/vAA==
X-Received: by 2002:a17:902:8342:: with SMTP id z2-v6mr47496333pln.147.1540290199280;
        Tue, 23 Oct 2018 03:23:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id b10-v6sm5517067pgd.51.2018.10.23.03.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 03:23:18 -0700 (PDT)
Date:   Tue, 23 Oct 2018 03:23:18 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 10:23:13 GMT
Message-Id: <pull.53.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Use nanosecond-precision file times on Windows
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

This is yet another patch series in the slow wave of patches coming over
from Git for Windows.

With this change, we now use preciser timestamps to determine e.g. whether
the Git index is out of date. This change made it into Git for Windows
already in version 2.6.0, i.e. for a little over three years.

Please note that this change originally caused a lot of trouble, as e.g.
libgit2 was unaware of our plans and used second-precision file times. So if
you used Git for Windows as well as a libgit2-based program to, say, update
the Git index, there would be a back-and-forth between index updates with
and without the fractional second parts, causing quite a bit of bad
performance.

These issues have been ironed out long ago, though, so it is high time to
contribute these patches to core Git.

Johannes Schindelin (1):
  mingw: factor out code to set stat() data

Karsten Blees (2):
  mingw: replace MSVCRT's fstat() with a Win32-based implementation
  mingw: implement nanosecond-precision file times

 compat/mingw.c   | 76 +++++++++++++++++++++++++++++++-----------------
 compat/mingw.h   | 36 ++++++++++++++++-------
 config.mak.uname |  2 --
 3 files changed, 76 insertions(+), 38 deletions(-)


base-commit: c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-53%2Fdscho%2Fnanosecond-file-times-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-53/dscho/nanosecond-file-times-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/53
-- 
gitgitgadget
