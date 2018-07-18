Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538B11F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeGRULY (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:24 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:40229 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRULY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:24 -0400
Received: by mail-io0-f201.google.com with SMTP id j18-v6so4094800iog.7
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wnARx41OE4mn/G72UQ1JlP2J5RsELwfwL+7EsOlXLNw=;
        b=M1hvLUXrrOZ0u+hMLuhvl9SJNwMrxurWaVr0WHo1vNUAaMB6zyayvR0DPtIAlsUYXv
         zI3EOydXuuLt3C/JDcZ0rMOjYsVyMZZFerofqFithz+UzDaRY567j49talYqKNTs5jnb
         EXaXE+2gABcTusiIn4bDcCwEeC4j9Ulpa2erwn8Helxc/wK7ctn7Kerf91od0E5VVxMT
         lp9vItzvMN9I4XnCFcQI3+wfvOO+nn0159foKiFQ9QkGJ8SnKRYnFckVfkmmwKsPKE/S
         x0c76KLZZrSd89kHrZGlToUXJqTjEnBM0GnO+ZE5qOE0VxETbOkWf1FaD3AbYVJSoeTF
         KPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wnARx41OE4mn/G72UQ1JlP2J5RsELwfwL+7EsOlXLNw=;
        b=Zp9IOc/um2Ya8oN10fZA5VJk2zdhTQfXyVA+YTB7aRmNaGTcajdKyfiiJTtjiWPu0x
         FUo5P49aLnQU4UUSHUIAoc6IItBPfVBCF2B1T8glCVc0FPhcwKeQAOc4Srj7bDODaSXN
         VltQE9mgI5+Mb+or/JWFoHrhcwB57W7nb/lWyE+MyzTG/4MOIySHPusnRRJQ8O/WYNOM
         06TqEQSmCGkFm9lSyks6sdhxS65bsX2y6qEaRSunvkuZaeXQkE2iDCzzJohBrbX2sgHy
         AeI+TtcNYKqRFkq0bRyMCGtwXvwz88Rhq1POlvgtevYwBfcMR7yfjgycDzNapTAjQB03
         FKkg==
X-Gm-Message-State: AOUpUlGXzytn1/N46UKw+SlewbQMxobldxehd0ohwlr+5FBQP3aWoq42
        SyD2B4WlCkx8XE0zEgPQ45e1SUXJ7xtOw6VDvQdUTkggd+XU76LAexgnZs67DJvtsPBA3H7FmyO
        BUfnI33pekjnsP43BN1sbUbkzo+N2vszyvWQQ9/jr8bZLt8KQKQJTk+Yxmxx/
X-Google-Smtp-Source: AAOMgpdlv5ruV/+ba3QIgG1SAMumnk/5Q7elZSx2SSgaRtaj5N/d7TZelZrSin5K56ZTH0ksWuuk7dtlzmHH
X-Received: by 2002:a24:4643:: with SMTP id j64-v6mr1627789itb.18.1531942323731;
 Wed, 18 Jul 2018 12:32:03 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:46 -0700
Message-Id: <20180718193156.47365-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCHv6 00/10] Reroll of sb/diff-color-move-more
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6:
* fixed issues hinted at by Andrei, thanks! (range-diff below)
* incorporates the new config option, sent separately previously.

v5:
This is a resend of sb/diff-color-move-more
https://public-inbox.org/git/20180629001958.85143-1-sbeller@google.com/
that fixes an errornous squashing within the series; the end result is
the same. range diff is below. (As the latest cooking email said
this series is going to land in next soon, I hope this is not too late
of a resend; otherwise just ignore it as the end result is the same)

Thanks,
Stefan


Stefan Beller (10):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations
  t4015: avoid git as a pipe input
  diff.c: do not pass diff options as keydata to hashmap
  diff.c: adjust hash function signature to match hashmap expectation
  diff.c: add a blocks mode for moved code detection
  diff.c: decouple white space treatment from move detection algorithm
  diff.c: factor advance_or_nullify out of mark_color_as_moved
  diff.c: add white space mode to move detection that allows indent
    changes
  diff.c: offer config option to control ws handling in move detection

 Documentation/config.txt       |   5 +
 Documentation/diff-options.txt |  33 ++++-
 diff.c                         | 262 +++++++++++++++++++++++++++++----
 diff.h                         |   9 +-
 t/t4015-diff-whitespace.sh     | 243 +++++++++++++++++++++++++-----
 xdiff/xdiff.h                  |   8 -
 xdiff/xdiffi.c                 |  17 ---
 7 files changed, 489 insertions(+), 88 deletions(-)


1:  a512cd40cae ! 1:  aabbc4e8aff diff.c: add white space mode to move detection that allows indent changes
    @@ -27,8 +27,8 @@
         modes in the move detection.
     
         This patch brings some challenges, related to the detection of blocks.
    -    We need a white net the catch the possible moved lines, but then need to
    -    narrow down to check if the blocks are still in tact. Consider this
    +    We need a wide net to catch the possible moved lines, but then need to
    +    narrow down to check if the blocks are still intact. Consider this
         example (ignoring block sizes):
     
          - A
    @@ -254,7 +254,7 @@
     +		}
     +	}
     +
    -+	for (i = 0; i <pmb_nr; i++) {
    ++	for (i = 0; i < pmb_nr; i++) {
     +		if (got_match[i]) {
     +			/* Carry the white space delta forward */
     +			pmb[i]->next_line->wsd = pmb[i]->wsd;
-:  ----------- > 2:  f80fbe78d9b diff.c: offer config option to control ws handling in move detection
