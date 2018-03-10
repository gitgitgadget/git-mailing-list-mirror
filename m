Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0BC31FAE2
	for <e@80x24.org>; Sat, 10 Mar 2018 11:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeCJLwY (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 06:52:24 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33679 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeCJLwY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 06:52:24 -0500
Received: by mail-wr0-f194.google.com with SMTP id v18so11346278wrv.0
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 03:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMEaZpaS5GMhgOP5vIQkpf8B9DC0KgIS6vihheuXBG8=;
        b=AFpjklWxvlgn0HrjtIvujnuv4FEix77g1JeqZw347b01GjztyYnt8oR+BVbtMgGv4u
         N4g7LDGCd5iIpPxqGkqfnwA3UUHdcQtofUHRcXRNhv4Ijok6SuWOSBI4UjsSOq4D6l6g
         AZchQO0B3xclAruPhFRKquLabHsBfLmKZWlGx5XQo4gv4EOvJcNPfOw9J8+lEEZ9yUQA
         pXSwcqjjQZH0zWtJ638s03850azmpNFh4pLpX5qzDOma37cui++ErmoJuWyN9U2p7d0w
         eTk2Lr95HwvgjsTjn8rX7Zq1h5pj26l31Tt5c/DbEvoIiQsQbXdPBrIkvJzfR1/QCBrJ
         NE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMEaZpaS5GMhgOP5vIQkpf8B9DC0KgIS6vihheuXBG8=;
        b=tESBKc30zihOf3NNYhnoP/hWuTlig49asjod+RcuBdiocS5BDFaBUuKsbJ6rzCnuLu
         lI4gF9ev/2MfJJw4hSZIx32ZSrlg2ZwTRADCw4imq8gFBUmtxV3l36PPn605VNasveEg
         SZonpsuMUy+khvkh3wWgS90tKInN3PJ+v/GWv7KgmkxGPq3Zlgmcg2uiIy1Eb14YB024
         8C14QYQXS5I7aW7lS2rCj5JMtQctK1JdpMrZtJpIXssDXV72Y8XqozFVWpTKlWKY7lMJ
         Xx5VAcXSm24TcEZYr1CvDsn0/zRi9zowR3/UAUABbWMSkYs/kjGnbss03LlG3DUf5paU
         jlaA==
X-Gm-Message-State: AElRT7EyeKcYIWUc6WGJ8x/BbmHYo7N1r8x4Dy+wuzSuvT6+GAMwBcXw
        2YnOazo6GUiMUYrffy7wm18J+beS
X-Google-Smtp-Source: AG47ELs0UcQLqQfDK6tdbl8jystD5GFY5Hp4YYujRZQB9iEsdNQvrdCE7QeLCYckVToyVbpjnHnF7Q==
X-Received: by 10.223.147.36 with SMTP id 33mr1298946wro.133.1520682742518;
        Sat, 10 Mar 2018 03:52:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id s21sm2802147wra.45.2018.03.10.03.52.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Mar 2018 03:52:20 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] shortlog: do not accept revisions when run outside repo
Date:   Sat, 10 Mar 2018 12:52:09 +0100
Message-Id: <cover.1520680894.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 3 stops git shortlog from BUG-ing when it's being used slightly
wrong. Patches 1 and 2 are recursive preparation. Based on maint.

Someone trying this out might notice that `man git-shortlog` renders
"\--" as "\--", which is not wanted. (Also visible on git-scm.com...)
There is quite some history around such double-slashes and compatibility
with AsciiDoc-versions, so I'd rather not do a "while at it" there.
Regardless of the destiny of patch 1/3, I will follow up later to
address various forms of "\--" throughout the tree.

Martin Ågren (3):
  git-shortlog.txt: reorder usages
  shortlog: add usage-string for stdin-reading
  shortlog: do not accept revisions when run outside repo

 Documentation/git-shortlog.txt | 2 +-
 t/t4201-shortlog.sh            | 5 +++++
 builtin/shortlog.c             | 9 ++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.16.2.246.ga4ee44448f

