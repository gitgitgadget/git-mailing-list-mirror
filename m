Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC85B1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 07:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeJ0PuL (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:50:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35684 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0PuL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:50:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id o14-v6so3181973ljj.2
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWoYasASA22E3cOsHieOJlZadrPmu+wExfWjBW5RUNk=;
        b=hmeWgfqWxOes+UJyhoJPbAIxrS4uYR17cj+CIotPKcFuzOyKVC9YaV/fFXi/5rYy9c
         rpdhsSzr9qQQYMD7Zl/C71vipnMEVWCH6qMzp2Yad5LbFna3nRh80HED0CceBNPDgIwN
         pTy0cK/PhsnFyi18IYJJASb5VODprQ0iKqhV9HCFWZZGYv7/XYGW4RWPh8k6gZKgNi0s
         g/WbEdgmSb/XqgEIAQgw/MYYr9lDCaByH3rvXCTfNXGmP8D9ktF/nUL6zuhb45PtaAqd
         0TJIT2HEWbF3MmEBmIo6UecKjP+y9KC2TEOtl0ANNdrurooedPKtt6iE2P5k8ShkX1s4
         ijuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWoYasASA22E3cOsHieOJlZadrPmu+wExfWjBW5RUNk=;
        b=jdN4SYh9YL+UsCYGJxWFXZKcZ78en1gkN1s2EI3y3rfZVzYMfXy3ZdJr8bpy+LPIGG
         xJ+qksbFhgLo1faqEtUu56e4SXtDI/D5fsGqiYFzEqkEnTxttPBy8bp2ivz8ma4brB63
         IH+KkxQ5zVJjaJQCRCMU8m7xRLvIDQAKozdtK9hqGLVRwv0CcFc6SMO6e1zwi6RYlTzB
         /7VqWFUK3kr5yVNBwuIB6fz7wTWCB3sGdBSrAPIH/eOxvnjdLi/r7oF/0I3neqxoZEui
         bYvLADmQ0wTcVi30Nz8azftx1sVC67dhycFcTHZ46vmfHG06mblHn8/nom23LbfJC1Z6
         RE1A==
X-Gm-Message-State: AGRZ1gJeHnabyQ0rnkEiFSg6/XY/I0Xkg0rJvI6rj+RlA/AmWFVPyrxG
        0viCh/RD2dfxkpBX32dYidZsuZIa
X-Google-Smtp-Source: AJdET5cLq1dg/zsprwwsOOlnEsPGbXRM3aJvPYl1bSQsRhzLhJwnwE3H5XIe4h3zBNfz0H1fdiiaNA==
X-Received: by 2002:a2e:8146:: with SMTP id t6-v6mr4312154ljg.32.1540624209957;
        Sat, 27 Oct 2018 00:10:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r7-v6sm1534899ljr.21.2018.10.27.00.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 00:10:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/10] Reduce #ifdef NO_PTHREADS
Date:   Sat, 27 Oct 2018 09:09:53 +0200
Message-Id: <20181027071003.1347-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

People seemed to support the idea of removing these #ifdef NO_PTHREADS [1]
so this is a complete series. I left the #ifdef in run-command.c and
transport-helper.c because those code looked complicated so perhaps we
could clean them up later. Even these updated files could be updated
more, I think, to reduce some code duplication, but I tried to keep
the change here minimal.

[1] https://public-inbox.org/git/20181018180522.17642-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (10):
  thread-utils: macros to unconditionally compile pthreads API
  index-pack: remove #ifdef NO_PTHREADS
  name-hash.c: remove #ifdef NO_PTHREADS
  attr.c: remove #ifdef NO_PTHREADS
  send-pack.c: remove #ifdef NO_PTHREADS
  grep: remove #ifdef NO_PTHREADS
  preload-index.c: remove #ifdef NO_PTHREADS
  pack-objects: remove #ifdef NO_PTHREADS
  read-cache.c: remove #ifdef NO_PTHREADS
  Clean up pthread_create() error handling

 Makefile               |  2 +-
 attr.c                 | 14 ---------
 builtin/grep.c         | 58 +++++++++++++----------------------
 builtin/index-pack.c   | 68 +++++++++++-------------------------------
 builtin/pack-objects.c | 26 ++--------------
 grep.c                 |  6 ----
 grep.h                 |  6 ----
 name-hash.c            | 38 +++++++++--------------
 pack-objects.h         |  6 ----
 preload-index.c        | 23 +++++---------
 read-cache.c           | 49 +++++++++++-------------------
 run-command.c          |  2 +-
 send-pack.c            |  8 ++---
 thread-utils.c         | 48 +++++++++++++++++++++++++++++
 thread-utils.h         | 47 +++++++++++++++++++++++++++--
 15 files changed, 178 insertions(+), 223 deletions(-)

-- 
2.19.1.647.g708186aaf9

