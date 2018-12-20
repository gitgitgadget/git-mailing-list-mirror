Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD9D1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeLTMeM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:34:12 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55350 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbeLTMeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:34:12 -0500
Received: by mail-wm1-f51.google.com with SMTP id y139so1824977wmc.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:fcc:mime-version
         :content-transfer-encoding;
        bh=a0YzirftJh9bI+u4W2iC9wtUSXSbgwsy4vNi4SiOH8U=;
        b=nZVo66nU+GsNCWBDhEdIj3azpWbsjSBuJQXArsRIsGtpwPxEn1zbL3jyhZqCaqq8Sh
         H+q/myx5GGLL+uaqoqV31DgKKC97LwSLtM3ZZKM/vzE1j0AvIJxOIiNbtwuvPkFcDVal
         O+64qI2lw2Y34hZxoCxrfpfE60uTGlU+EJImW8w7Zav6t6fIBbJ1ZqFvlzBgE+SXadoK
         xTq01UaRHA7nb32l3IwJHTDTD/eRhKnFr5yv+HDSSwJubdiJ7eCLFtMnvMv74DuAjlG5
         hyN1Xu3No+mZABLn30Yn+BV171tegUQ3E9yMEbjLgk8/kozlCPJ9KEtLgazhjd4QPUhN
         bpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:fcc
         :mime-version:content-transfer-encoding;
        bh=a0YzirftJh9bI+u4W2iC9wtUSXSbgwsy4vNi4SiOH8U=;
        b=HOEgL7z8qeowc43/YO6RvoTO5vUaw/EsfaGrghAcRYz4iP6/Ff07pkMI7+tLdtAJ3t
         cT5T7m2gOIG3+d5n9R2E8VsejaT8KOhuSij1OPByYWfTJ9nTCmIgVME0Hmq1aGx6+7A0
         0UTHrJ4O1aLtnLIu5ulN3qHuQxb5ec5l2zvmcvNNYJWeU0KvcCSvhan6G2bdVZ6/raUl
         6dcXrO7DtEerImyxc7CLq25mdvUVEWPwEtjYcOE8Y/S9ZeuN/TNWeH144r2LQ2v63nUn
         OjPfpdpKVLtWc8L800dfkbN1oS9Gf+nL7GcM9aZ0X9FqbRlX1xWOMM2DFhBae1Nzqs/Q
         n0nQ==
X-Gm-Message-State: AA+aEWbnx+JGPLFsBd8U6fkmcerapKhDiS6+grIk01lNJR71gXg6xhoR
        aw+qgHhEpvEQ+0r8dvOPQyHK6nW9oE8=
X-Google-Smtp-Source: AFSGD/UXb35RR4zdNVQS02Zm+vZ9FNrcypaaMkFCICAcXfgMQlQ1gpidldol9RKYlGIfPiXnibM2qg==
X-Received: by 2002:a1c:8148:: with SMTP id c69mr10773190wmd.126.1545309250160;
        Thu, 20 Dec 2018 04:34:10 -0800 (PST)
Received: from gitforwindows.corp.microsoft.com ([2a02:908:39a:4ba0:11a9:453c:2bcb:983a])
        by smtp.gmail.com with ESMTPSA id f66sm9273102wmd.28.2018.12.20.04.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 04:34:09 -0800 (PST)
From:   Johannes Schindelin <gitgitgadget@gmail.com>
X-Google-Original-From: Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        "Slavica =?UTF-8?Q?=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH 0/7] Turn git add-i into built-in
Date:   Thu, 20 Dec 2018 13:34:01 +0100
Message-Id: <pull.103.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.windows.1.2.g53f0d18676
Received: from [127.0.0.1] ([40.112.139.188])
 by smtp.gmail.com with ESMTPSA id n22sm37931900pfh.166.2018.12.20.04.09.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 04:09:18 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:07 GMT
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Slavica Đukić via GitGitGadget" <gitgitgadget@gmail.com>

This is the first version of a patch series to start porting
git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
a head start:
https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u

Daniel Ferreira (4):
  diff: export diffstat interface
  add--helper: create builtin helper for interactive add
  add-interactive.c: implement status command
  add--interactive.perl: use add--helper --status for status_cmd

Slavica Djukic (3):
  add-interactive.c: implement show-help command
  Git.pm: introduce environment variable GIT_TEST_PRETEND_TTY
  add--interactive.perl: use add--helper --show-help for help_cmd

 .gitignore                 |   1 +
 Makefile                   |   2 +
 add-interactive.c          | 265 +++++++++++++++++++++++++++++++++++++
 add-interactive.h          |  10 ++
 builtin.h                  |   1 +
 builtin/add--helper.c      |  43 ++++++
 color.c                    |   4 +
 diff.c                     |  36 ++---
 diff.h                     |  18 +++
 git-add--interactive.perl  |  15 +--
 git.c                      |   1 +
 perl/Git.pm                |   2 +-
 t/t3701-add-interactive.sh |  25 ++++
 13 files changed, 387 insertions(+), 36 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 builtin/add--helper.c


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-103%2FslavicaDj%2Fadd-i-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-103/slavicaDj/add-i-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/103
-- 
gitgitgadget
