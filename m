Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C28A1F453
	for <e@80x24.org>; Sun, 21 Oct 2018 14:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJUWRC (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 18:17:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40609 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJUWRC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 18:17:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id n3-v6so1523784lfe.7
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMBZ78XjPlvbgocUw4sqWpdo6J57FlbOHq/+JmlZr2Y=;
        b=dDMXrOzhJqDu6poucVRjrRLBm84/1VudMzitSrkAilWcCrqSsNHaPHar4uGY1Y+IHB
         vWh98vYJw4eqaid5UTY0eJsv/5EFR2o4ohoy16DR/d1fA7SoG8NUbmLQfe73dw74/F+B
         3pp34sKULICUG71fiT0d+ETcAOsgzncSFVIhT3CXl7J5YXn8aRHDeAI5HyZrsIzk0saH
         TS+vfzsf1dwZWMk48Vs7ar5RV0l0D8Ne8wDl/ZJs3nEeSX5KXATd1h8LlAHxBULz4LJh
         aoVxrojNKBZw7QhXbw99h1RXQKCaYlqC8Iq2iaU0syZS5tOATp+1E671voLvq2kcZiJr
         /7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMBZ78XjPlvbgocUw4sqWpdo6J57FlbOHq/+JmlZr2Y=;
        b=S4IuHHHKPP069iGFtEYfRFLew3ApT8d6nJZfCb7Pr93eUJi9UQkdOLxoLrc1LxnZni
         Rl54kokqst7D44j87RHXNmpOIcBfr+paNDCT+ikhUIhzeYf/cl+/TVyFtn0gd/KOw3VZ
         xCvodWnhSCNrxNOqL/k0DOrRSY05fnBe3HY/N5Umz2IX4uXfb18A+eFhtk248FU19feb
         bzi04C5y6lRtRu0QEveuK4zOa2rzICYd7XOQlTjUboRNmuv/eDTVIKtJLt86QBG/UzLB
         ifVMzy5w8gQwBMIE0kUO80xi2ugKmeVoQmJxe7FnLY/5wPmSObJ/lfMuucvSg73WwHwK
         4DvA==
X-Gm-Message-State: ABuFfoi67ryfSZ5/3a8M0m+E8z6CrAHQgmRVJR1LOzkKN25P3ugbsfnf
        d9qcVIjP//zSrK04xVHTVtjdH/LO
X-Google-Smtp-Source: ACcGV60lSzPNlAF/8v1x+nkOY7AIwEcaqFqKvzEReic3KXmgOdk7SxIH+HGgi2RqppMycPRliZDi6A==
X-Received: by 2002:a19:5349:: with SMTP id h70mr6047737lfb.24.1540130552860;
        Sun, 21 Oct 2018 07:02:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x6-v6sm6235563lji.36.2018.10.21.07.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 07:02:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 0/2] Per-worktree config files
Date:   Sun, 21 Oct 2018 16:02:26 +0200
Message-Id: <20181021140228.24941-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181002160658.15891-1-pclouds@gmail.com>
References: <20181002160658.15891-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 has just one minor change to unbreak a && chain in test_cmp_config.

Nguyễn Thái Ngọc Duy (2):
  t1300: extract and use test_cmp_config()
  worktree: add per-worktree config files

 Documentation/config.txt               | 12 +++-
 Documentation/git-config.txt           | 26 ++++++---
 Documentation/git-worktree.txt         | 33 +++++++++++
 Documentation/gitrepository-layout.txt |  8 +++
 builtin/config.c                       | 19 ++++++-
 cache.h                                |  2 +
 config.c                               | 11 ++++
 environment.c                          |  1 +
 setup.c                                | 40 ++++++++++---
 t/t1300-config.sh                      | 79 +++++++-------------------
 t/t2029-worktree-config.sh             | 79 ++++++++++++++++++++++++++
 t/test-lib-functions.sh                | 23 ++++++++
 12 files changed, 255 insertions(+), 78 deletions(-)
 create mode 100755 t/t2029-worktree-config.sh

Range-diff against v3:
1:  445f985619 ! 1:  23c2ee8844 t1300: extract and use test_cmp_config()
    @@ -201,7 +201,7 @@
     +#    test_cmp_config foo core.bar
     +#
     +test_cmp_config() {
    -+	local GD
    ++	local GD &&
     +	if test "$1" = "-C"
     +	then
     +		shift &&
2:  4c2d1bb37d = 2:  0d4dc8c6b0 worktree: add per-worktree config files
-- 
2.19.1.647.g708186aaf9

