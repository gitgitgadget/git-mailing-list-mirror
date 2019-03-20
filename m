Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03B020248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfCTLrO (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:14 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:46294 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:14 -0400
Received: by mail-pg1-f172.google.com with SMTP id a22so1599438pgg.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8r92dYaJlX+W7lUN/bwMm2J6SBaPpEkQSDlSm0TQx0=;
        b=jmffFXVsrUXOq8HS8iidGUmeq8rjksQm9JoGXbXViZ8UoJgl8BlRUDW6P1xhkFjpqI
         7eb1SHGHOiId5MPSXDTynt6GyZQv40jEQuvvK2v505NC9XulcYcEIKtNBjb/UPrJUy7c
         6fotM9sjHWTxcGnYG1p2R7iLrAVKaItfRQXq7c5POMfSvmrJwBwDyU0l1o8WtbaJQI2N
         ohvpjZcbC+C93s7eBcmU5dhE7jDa7EOv0ngU8D/yW3L/u1BsL3affrt1n2HLPd0+8jz3
         BC9OthJQEVU+XsRSBYycpLWVnclx5uWy1hBNdAJ4Qgx0/+l6LVsEQzaX77LSgidGLm/P
         FTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8r92dYaJlX+W7lUN/bwMm2J6SBaPpEkQSDlSm0TQx0=;
        b=Gq3cwYxuJcWWJeL1ZG2hE65pjQewNw8w2B18Br8HCDjifa3Z5/x6PYNHPNTP5DnXoi
         LDz/9gCT75Kx1GLlpakZcN250+Nk0sRaYykctX6qhWal6vD+DRp90wLvQ2YU7hyWUQag
         vq9vAZvRAYSE5O+LM5SC6Aa802X91EDV8tIQ7yAtU47hpcPQVOFfnfQjpSWvfti9/ORS
         ZkjBY4FeTPxAHgNP6kbqszSW34VgH0kndBrq/KSfB1PIIYo/uSXTMHlaoIrZnf7oz1HG
         FuNBwLd/msgQzJ6j0ZcDrL6UXG9w6HkLUomWOLbBcT/LQMTlqrGZGD7CzAHltXmtc/IJ
         Pnaw==
X-Gm-Message-State: APjAAAVDanZ7XUvJ3unkuOG3lLsO5uAHJccC2qqmjcdemZbIPJC1iYkt
        ksCZWDHrOL+QJi3lfV1XCnAt10Iy
X-Google-Smtp-Source: APXvYqyZJkIH1E/U73a5lmi1mgDh449JvBf8UQ19D+Xdbki5//K5Xep2VaJflpUkJk4kASzMTPf/CA==
X-Received: by 2002:a63:f905:: with SMTP id h5mr6729171pgi.223.1553082433169;
        Wed, 20 Mar 2019 04:47:13 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k22sm2725406pfi.90.2019.03.20.04.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/20] nd/diff-parseopt the last part
Date:   Wed, 20 Mar 2019 18:46:43 +0700
Message-Id: <20190320114703.18659-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gotta keep pumping until everything is out! This is the last part to
finish converting diff.c to use parse_options().

The two commands 'range-diff' and 'diff --no-index' are also updated
to do parse_options() directly, which is the end game (i.e. the end of
diff_opt_parse(), but that can't happen until revision.c is
converted).

The next step could be collect complaints about how noisy 'git
range-diff -h' and 'git diff --no-index -h' is and start trimming
unused options. revision.c conversion will happen in parallel.

Nguyễn Thái Ngọc Duy (20):
  diff-parseopt: convert --ws-error-highlight
  diff-parseopt: convert --ita-[in]visible-in-index
  diff-parseopt: convert -z
  diff-parseopt: convert -l
  diff-parseopt: convert -S|-G
  diff-parseopt: convert --pickaxe-all|--pickaxe-regex
  diff-parseopt: convert -O
  diff-parseopt: convert --find-object
  diff-parseopt: convert --diff-filter
  diff-parseopt: convert --[no-]abbrev
  diff-parseopt: convert --[src|dst]-prefix
  diff-parseopt: convert --line-prefix
  diff-parseopt: convert --no-prefix
  diff-parseopt: convert --inter-hunk-context
  diff-parseopt: convert --[no-]color-moved
  diff-parseopt: convert --color-moved-ws
  diff.c: allow --no-color-moved-ws
  range-diff: use parse_options() instead of diff_opt_parse()
  diff --no-index: use parse_options() instead of diff_opt_parse()
  am: avoid diff_opt_parse()

 builtin/am.c             |   4 +-
 builtin/diff.c           |  21 +--
 builtin/range-diff.c     |  26 +--
 diff-no-index.c          |  49 +++---
 diff.c                   | 337 +++++++++++++++++++--------------------
 diff.h                   |   5 +-
 parse-options-cb.c       |   4 +-
 parse-options.h          |   6 +-
 t/t4053-diff-no-index.sh |   3 +-
 9 files changed, 219 insertions(+), 236 deletions(-)

-- 
2.21.0.548.gd3c7d92dc2

