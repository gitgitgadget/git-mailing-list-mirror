Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEF901F404
	for <e@80x24.org>; Sun,  7 Jan 2018 22:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeAGW22 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 17:28:28 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39500 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbeAGW21 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 17:28:27 -0500
Received: by mail-wr0-f195.google.com with SMTP id z48so3262860wrz.6
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 14:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nE4Zhzg+u/eMX3glg6lyov8j5pFmRhcIjXK0Zpue5JI=;
        b=kP86drj2fabMHRnypGYFJZEB08vxNMrsgU935CeElD4m99SoQ0rN/KX8/becCxMrl/
         7N20uvqKO+fOzhHtZ0eeuy6ufwsNo6gTzIw9j3SORKl/UEgimtKiQFesZ9TKdrpVMhC1
         hozSJWrS0sIBLaOgNDVXsSWR1BrZAetzGTnE3JVIxmEQSxkO4ORXNVVJMvHjyZEG4x3o
         gHvZ1cuhvoqnxUqDZrJajCHbhL+H33oPu5vjC8x7vRckA+VMNbr41nQ0oaTbiY/SkK9t
         THR93+TG6inuOoIyuf7IgIJMffhBcBctcRmZs4weKcIJapz0ACoczqpsorPZcaSA7X2b
         ylMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nE4Zhzg+u/eMX3glg6lyov8j5pFmRhcIjXK0Zpue5JI=;
        b=Cw09XSxk++lhGq3SThyxy5rc8F8o5JpjXmIk7j3hIvPiOptolzXO0dduxAKJKGcLlU
         ayPz23nV8mrMg/FTDZXeEHXJTHGbxyJ+MFHQA3r6PAZB66H6tU6dO9NnVGhU4M7qtKl3
         JUbOMVctf4m80VbFNbptwBo2+DzuNNn562ZUZs4DW2/0bs9mcH8m8vIOHPw613sKca3F
         N9CvRt+WrVZmQY0b1+n3WRTziaghJlgmiZ9ZAPPawCkUcAOJl5yIaJ8FOcpthAbbcJGv
         egb2cP3Eiyum9R+7SLOe8pk+yyephb5zZQqwpIle5dMEBXSLeAlFjTf1qFBdFcWchxWe
         NOpQ==
X-Gm-Message-State: AKGB3mKG7+RQRiNqIQwbTQMcFzHD/F6c9gJh3rXu6ZB9FyoqDT7Fk7Pm
        2eoVU4UAsZQohYtMg6no/9rKH9xI
X-Google-Smtp-Source: ACJfBovv1yPVYzzB4iiULPk2wbR+xoRCb9M03+x2ZxA1ENGbt+K5ZweZ+IoSDs4CgJRYEZaKamNkEA==
X-Received: by 10.223.145.198 with SMTP id 64mr7865966wri.163.1515364106066;
        Sun, 07 Jan 2018 14:28:26 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p8sm9127204wrf.50.2018.01.07.14.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 14:28:25 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/3] fixes for split index mode
Date:   Sun,  7 Jan 2018 22:30:12 +0000
Message-Id: <20180107223015.17720-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79
In-Reply-To: <20171217225122.28941-1-t.gummerer@gmail.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Brandon and Lars for comments on the previous round.

Previous rounds were at <20171210212202.28231-1-t.gummerer@gmail.com>
and <20171217225122.28941-1-t.gummerer@gmail.com>.

Changes since the previous round:

- reworked the patches to no longer try to use struct repository for
  worktrees, but pass gitdir into read_index_from instead (Thanks
  Brandon :)).  So the fixes that were in 1/3 and 2/3 previously are
  now in 1/3
- 2/3 now fixes t7009 properly.  I thought it was fixed before, but it
  probably just passed the tests because of the GIT_TEST_SPLIT_INDEX
  "randomness".
- The travis job is now only running the 64-bit linux build with split
  index mode to save even more cycles.
- As this wasn't picked up anywhere yet, I took the freedom to rebase
  this onto the current master, which includes sg/travis-fixes, which
  made it a bit easier for me to test.  If this makes the life harder
  for anyone reviewing this let me know and I can base it on the same
  commit previous iterations were based on.

Thomas Gummerer (3):
  read-cache: fix reading the shared index for other repos
  split-index: don't write cache tree with null sha1 entries
  travis: run tests with GIT_TEST_SPLIT_INDEX

 cache-tree.c            |  2 +-
 cache.h                 |  8 +++++---
 ci/run-linux32-build.sh |  1 +
 ci/run-tests.sh         |  4 ++++
 read-cache.c            | 25 ++++++++++++++-----------
 repository.c            |  2 +-
 revision.c              |  3 ++-
 split-index.c           |  2 ++
 t/t1700-split-index.sh  | 19 +++++++++++++++++++
 9 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79

