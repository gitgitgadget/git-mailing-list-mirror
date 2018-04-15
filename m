Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429FD1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeDOQpq (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:45:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41971 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDOQpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:45:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id m202-v6so1476685lfe.8
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Cq7QWnbtnpCnqMh51mFrkBxmDi9KybLTajRCDcUhnw=;
        b=twgNZ2tJAp7s746YQQY5gUUMwAeeCeOdqsDly+0+f23agKcDOnbEiK5zZi6i19CANU
         4SC9Ov+itKz+amOaulKINc9eifBzdu4+PHKAKE8/RJOIP5FL7N2avO1C2cB1si/RuStJ
         oeuRxSzI/ZIdhwmAGABwFh8JbSBRm1Uetp9Gev/AlFE6dyJVVkcx1U6DD25xEJ5E+GOS
         fO+oWjIA42YwGVtvsjmLZcTyMqXX+aXgVm5Q53SdEJtZiVu0tk7zQqSwSOirCqpwi/jR
         aEYJZOoWqpHNQ1bcWO6/fDFJ/mguisoqXbfg+AIGBBzt3mdJ1c8zzVgOgiCtdxv6UN9d
         i4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Cq7QWnbtnpCnqMh51mFrkBxmDi9KybLTajRCDcUhnw=;
        b=dShPWSxaOrBNaEaFeOaBzpEjdgwV4yGtEyFmnqisktx+HJEx4xNSEL4f+wyikhzqMN
         fHsdZVZ9sT3xTkwe68LEwtSoMUvq+XYGQZ1Ytiq/f9XY9zG26vjAEkoDM4EkVXhXg3xr
         l+Ugu7p0kHc04kkQf0GUsZVEPT5Jq9I2EJrf7TOsuCWm8eVXsVuCMUP8OnJYBEh3Yl2G
         HwHuoutDjY0ASSR8lx1Nb2yjSX+lt63BiDKvgnVyJgZbhAIBg+K44RGlbadRjVKgJTrn
         gGfM/flElACZYqRN685eY3uoUmjGKvYgNhNnNVVYJPpdkbJdfS+4j7IYY3TSUefxn5Dw
         sRXw==
X-Gm-Message-State: ALQs6tDqUIS4s9jvhbSeiUtQhCBF8IK+AAHOvad5MYkUIA+9nBWsjtgw
        4xgdZzzubHU0IKVM1/f6t0gyhg==
X-Google-Smtp-Source: AIpwx48UWzVk9hcIXr40PQn7s1lyYUL0ZsN4yKK5hOzdLyX6IJS6p/97oMLgCljYefHD/eRZ+yBqeQ==
X-Received: by 10.46.157.18 with SMTP id t18mr7867592lji.138.1523810743866;
        Sun, 15 Apr 2018 09:45:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2360702lfc.21.2018.04.15.09.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 09:45:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] Keep all info in command-list.txt in git binary
Date:   Sun, 15 Apr 2018 18:42:32 +0200
Message-Id: <20180415164238.9107-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180326165520.802-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 changes

- bug fixes spotted by Eric
- keep 'git help -av' layout close to what's in git.txt
- enable pager for 'git help -av' because it's usually long
- move guide list (aka 'help -g') to command-list.txt

Nguyễn Thái Ngọc Duy (6):
  git.c: convert --list-builtins to --list-cmds=builtins
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
 command-list.txt                       |   8 ++
 contrib/completion/git-completion.bash |  96 +--------------
 generate-cmdlist.sh                    |  65 +++++++---
 git.c                                  |  16 ++-
 help.c                                 | 163 ++++++++++++++++++++++++-
 help.h                                 |   4 +
 t/t0012-help.sh                        |   2 +-
 t/t9902-completion.sh                  |   4 +-
 13 files changed, 249 insertions(+), 158 deletions(-)

-- 
2.17.0.367.g5dd2e386c3

