Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799491F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeEZNzk (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38019 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752598AbeEZNzj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id 94-v6so13535927wrf.5
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EIDw2KV0q0EG9QSQaEHl+kUJYTlzrBsjcMhbgAXEHc=;
        b=P9GaDIbEvwuPP/gF3yLmI3gM5eram00QWYnS+ncVAQl6zvcANx52JuHwjycPjO8oDq
         utJG/cckwXse31Gn/511/fuS5g1OGWHnnCzf+ZmWZx2hrzx3lKTrboSqF075L82FPm2o
         gGYWEigCHsi3dLd00tMj+EiBJ2x1CI5NhXVR/rHH5czVPXf3CwONsbrj/xVcm6p8nBKL
         F6T96iM8Zl0PSnJxERiJMWsDo6hs7FmV5mzA5EC58mYXB2C3oHJuF5VMTyV0OMOj4fk5
         Ww0VHtlPA1NeuR41Pyg3TImfg23f6B0tjHT4Yz2yh/d3o85sCkuy984pe7i+J78ihuL1
         zhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EIDw2KV0q0EG9QSQaEHl+kUJYTlzrBsjcMhbgAXEHc=;
        b=riOj9lG5e/vCoQWk7ZuiaJDf3cecQFgSGc4ij4stnTKjqg2oUxtFjseraitVqXBHXn
         crxpSq0bXO6cB1JVwvOGvgX5j/XaYMMl6EPKrAW6k1vO4Sx+WitI3NUgESSb1drKkENl
         FNPGUzuAruelqubOvqMsuZkHxF4QMGS3BfD9mMruD5Gj2XFv3l6N7lt3PyjkdUqPTV7V
         P3nOOD4yate1hMXbPSi80zcEhPCrR3CkCjh8cckzRopIWa8LJVy66TzBqoDFvyhqr+Nq
         pCDmZ9QT/3JhXDYb8mxGAtdKI7XYl3cUKpxzzNMeBLS/6/eKIHYB+/7JuAFQvT+1Kylp
         8IjA==
X-Gm-Message-State: ALKqPwdOiqUNgNJVZzdf2YB57TU5PsHGh1TtqwGF2twvplvtA41IoGIN
        Vce80xpa33g9T+OV8zq5o20=
X-Google-Smtp-Source: ADUXVKL3KuoO979GjZ7DEWLzH/96UqClnOjYpNNQtlCAjCQO9T2ETq63exMT9VjeZmozJdJZAxz0Iw==
X-Received: by 2002:a19:c7c8:: with SMTP id x191-v6mr3626160lff.122.1527342937972;
        Sat, 26 May 2018 06:55:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 00/11] completion: avoid hard coding config var list
Date:   Sat, 26 May 2018 15:55:20 +0200
Message-Id: <20180526135531.4516-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 changes:

- based on 'next'
- C99 is now mentioned in the commit message
- fixed Eric's comments
- the old 8/9 partial case-insensitive support patch is replaced
  with Szeder's version.
  
  Szeder I claimed authorship because I wrote the commit message which
  may not be what you like. If you want to claim it instead, I'll be
  glad to resend.

- There is no levenshtein support yet. But the code is updated to keep
  this config list in memory instead of printf'ing directly to make it
  easier in the future to do that.

Nguyễn Thái Ngọc Duy (11):
  Add and use generic name->id mapping code for color slot parsing
  grep: keep all colors in an array
  fsck: factor out msg_id_info[] lazy initialization code
  help: add --config to list all available config
  fsck: produce camelCase config key names
  advice: keep config name in camelCase in advice_config[]
  am: move advice.amWorkDir parsing back to advice.c
  completion: drop the hard coded list of config vars
  completion: keep other config var completion in camelCase
  completion: support case-insensitive config vars
  log-tree: allow to customize 'grafted' color

 Documentation/config.txt               |   3 +-
 Documentation/git-help.txt             |   5 +
 advice.c                               |  53 ++--
 advice.h                               |   1 +
 builtin/am.c                           |   6 +-
 builtin/branch.c                       |  29 +-
 builtin/clean.c                        |  29 +-
 builtin/commit.c                       |  36 +--
 builtin/help.c                         |  16 ++
 config.c                               |  13 +
 config.h                               |   4 +
 contrib/completion/git-completion.bash | 357 ++-----------------------
 diff.c                                 |  56 ++--
 fsck.c                                 |  68 +++--
 generate-cmdlist.sh                    |  19 ++
 grep.c                                 | 109 ++++----
 grep.h                                 |  21 +-
 help.c                                 |  84 ++++++
 help.h                                 |  45 +++-
 log-tree.c                             |  37 +--
 t/t4254-am-corrupt.sh                  |   2 +-
 21 files changed, 440 insertions(+), 553 deletions(-)

-- 
2.17.0.705.g3525833791

