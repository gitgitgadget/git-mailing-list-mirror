Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7738D1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 17:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeIIW1B (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:27:01 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40817 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeIIW1B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:27:01 -0400
Received: by mail-lj1-f178.google.com with SMTP id j19-v6so15949339ljc.7
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03TxhVlCoPLSmusOdE4B2wWokzp/tAE/E7nWepsZYTc=;
        b=GJUiNhQpYpPnYvlQUrUZCnNSrz1DVLQFJuvUfHmIwnwf+4DXGLgRQk0x2MPro40SUr
         SFEknCri83OIiblCrafz+fSsEbLuJdb1pB6I/Ke9Fr6yE9fL9xQaD8Yde/vmVM1IP6LD
         AjjD9EmHci0WdrgNkf73RCBjZii5YOTWrAyAFSEZMtjAoDjTALbLSemKkL3RyrI+NjRq
         esvWTYbBeUTbkddByWYUHmgYJLcNXqYakIQp0JuI3OhdyjUIZN37aC66FVKoyY1SQBIs
         oIPOpMtmRQYT0tUA8ikVpe+cv85xIq2+XZBkNGK44VBMYRJN4Qwo5WtN+Xgy3mOZhDrz
         lKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=03TxhVlCoPLSmusOdE4B2wWokzp/tAE/E7nWepsZYTc=;
        b=aKDsL2eIdrV69o1fGd7uuF/KAKl7Z2kNZLa1ppTNTtxp0vrtIrOJ6TVBSGHPO2MCfo
         dfpYAdlNE2cNczW/dE4tUyC129ubvXNbZXKS3pwjeBqNVdR8cB0UvEGgxJB41kBgdmeI
         /R6S5V0YygIKlfBV+cOVzaq/9ZC+QQJySoL2xpTfUwTMBe7MkAoOzhYBfQYfQjpE+kMy
         NixFhEgXljOkGcraVLVOFc+nHes0xDsqRnWl+ABhIAhub2DmwTebepnKk9eSIF3jEQid
         QnhigPq8WWXy4Y4or8NdnOMqnns/eRBabCjR8zgcjzbuS3iuleg8myd+HcBz3ekeOu5v
         9rrA==
X-Gm-Message-State: APzg51DXMTCjLJX22dh7zvSc7yTB/3Ze/6Sh4Dfj5oT3fl0LpsAFLA1t
        s00uEa5goAQYg72LIA3D+20VQae1
X-Google-Smtp-Source: ANB0VdZRcJmJiSlOsklVlhOrnDwYY3S5jndl2MTXabPa+1OoBV6wTWIN4oWYQ7XCo4fsROFrexOF3Q==
X-Received: by 2002:a2e:1c4:: with SMTP id f65-v6mr10026181lji.58.1536514597125;
        Sun, 09 Sep 2018 10:36:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2317793lje.51.2018.09.09.10.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:36:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/6] Merge remaining t/helper binaries to test-tool
Date:   Sun,  9 Sep 2018 19:36:25 +0200
Message-Id: <20180909173631.1446-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last time when I added test-tool in 27f25845cf (Merge branch
'nd/combined-test-helper' - 2018-04-11) I left out a few test programs
because there were a couple in-flight new tests that used them. All
those topics are merged now. So we can merge these to test-tool and
call it done.

Nguyễn Thái Ngọc Duy (6):
  t/helper: keep test-tool command list sorted
  t/helper: merge test-dump-untracked-cache into test-tool
  t/helper: merge test-pkt-line into test-tool
  t/helper: merge test-parse-options into test-tool
  t/helper: merge test-dump-fsmonitor into test-tool
  Makefile: add a hint about TEST_BUILTINS_OBJS

 Makefile                             | 12 +++--
 t/helper/test-dump-fsmonitor.c       |  3 +-
 t/helper/test-dump-untracked-cache.c |  3 +-
 t/helper/test-parse-options.c        |  5 +-
 t/helper/test-pkt-line.c             |  3 +-
 t/helper/test-tool.c                 |  6 ++-
 t/helper/test-tool.h                 |  6 ++-
 t/t0040-parse-options.sh             | 70 ++++++++++++++--------------
 t/t5701-git-serve.sh                 | 36 +++++++-------
 t/t5702-protocol-v2.sh               |  2 +-
 t/t5703-upload-pack-ref-in-want.sh   | 14 +++---
 t/t7063-status-untracked-cache.sh    | 68 +++++++++++++--------------
 t/t7519-status-fsmonitor.sh          | 14 +++---
 13 files changed, 128 insertions(+), 114 deletions(-)

-- 
2.19.0.rc0.337.ge906d732e7

