Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FCBF1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeDUQyb (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:54:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42907 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbeDUQya (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:54:30 -0400
Received: by mail-lf0-f67.google.com with SMTP id u21-v6so7609841lfu.9
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2XRWGAPlBCzI81GcpQ5OpBV9RBPMueztbpE/rRQ9so=;
        b=cMHY7cpnQuIGdDWa823fAZT1dnWsDgI6a6GkAQTwpIpbaNLpJJFgLRcYp9KDIj1qzS
         aJQhRXRy4huRwvs/Bn+hidWdWOO4athRYClW9AptHYBJeJDG2zjqYu+woVuWkX2d8WHT
         ReN34NTiOOd3aLPzQVtKFLssUN7N1nKu/8QGfvI/4+tVoCJvtp5BamPuObaDv6YOZ7OF
         LO3oqYDYjTc5cpyjtYvoKsxHT0eYen3udXXDeONLra1puF1a1IeOUuDA5+MY8rlSpar+
         zm6ZHOYpQZFrlYVvZYXdF2TGMwTFO/v6as3uBN/M5qKxmj3an+dSdoHj16aQ676m8rnE
         fEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2XRWGAPlBCzI81GcpQ5OpBV9RBPMueztbpE/rRQ9so=;
        b=gKyTBQsn51uVVHbyaGaSrvnQKQsvGL2kqVx7t39nsAYeD9+5/OFof5nRVHEdORhjIR
         a+sCC4pyE5WoZbIIny/rn0vcq02ON8+18CA7Nj3Zzr/8E4tTBUZqmX9ZLQTCClt42gki
         i/Xzx2fFXjSPbE/1jZJ+9uuPGStJcxN6UQKIzeauK3xW+xERpDSy5UyIbjgXl1HWFWiF
         DApo1DnBkO2gElD4bYqOEAIkpjOOb1jwRWBphe6F3qZFgE9ziYvuRGmRnqoOVADRCBn4
         f3i1QvDS/6U97kzIJ1ClH2lDN8PHYUciD4xWhlE8sKYlJ3GuNLDpKtZ3H22e+/V0WsGx
         KL/A==
X-Gm-Message-State: ALQs6tAMNy7yOpu+q1BBSS0IsZeRUdN8M8Fa5S146A2MZiXfYWv4xZTg
        Xw9NIkmF8ALJI33vKDLu0WA=
X-Google-Smtp-Source: AIpwx4/3IFK+a7xwyuEmSCweoEekkhdBI2MLHIPXxYCkgNL8jSiLik5j3TuS8+7txdiCwIDljMvdiA==
X-Received: by 10.46.150.18 with SMTP id v18mr5960416ljh.96.1524329669173;
        Sat, 21 Apr 2018 09:54:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g81sm1526523ljb.12.2018.04.21.09.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:54:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v3 0/6] Keep all info in command-list.txt in git binary
Date:   Sat, 21 Apr 2018 18:54:08 +0200
Message-Id: <20180421165414.30051-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415164238.9107-1-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes:

- remove the deprecated column in command-list.txt. My change break it
  anyway if anyone uses it.
- fix up failed tests that I marked in the RFC and kinda forgot about it.
- fix bashisms in generate-cmdlist.sh
- fix segfaul in "git help"

Nguyễn Thái Ngọc Duy (6):
  git.c: convert --list-*builtins to --list-cmds=*
  git.c: implement --list-cmds=all and use it in git-completion.bash
  generate-cmdlist.sh: keep all information in common-cmds.h
  git.c: implement --list-cmds=porcelain
  help: add "-a --verbose" to list all commands with synopsis
  help: use command-list.txt for the source of guides

 Documentation/git-help.txt             |   4 +-
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitmodules.txt           |   2 +-
 Documentation/gitrevisions.txt         |   2 +-
 builtin/help.c                         |  39 ++----
 command-list.txt                       |  10 +-
 contrib/completion/git-completion.bash | 108 ++--------------
 generate-cmdlist.sh                    |  57 ++++++---
 git.c                                  |  16 ++-
 help.c                                 | 164 ++++++++++++++++++++++++-
 help.h                                 |   4 +
 t/t0012-help.sh                        |  11 +-
 t/t9902-completion.sh                  |   6 +-
 13 files changed, 263 insertions(+), 162 deletions(-)

-- 
2.17.0.367.g5dd2e386c3

