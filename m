Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795E21F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404107AbfAPKcI (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404099AbfAPKcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so2883868pfc.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrX2ku5VLTsjCwH/Osig+uf9qNltpnDPxN/HixZr+Gc=;
        b=OCJmwQ7zyJCTNU7lSUG+BRlqZwR2y8ANvT2Sw1jYTdYBpB3szIOwklsjOChCjeGoLa
         iGYLcTfIktC7Tfs4C0a2cN+mdo97XZyBWxWVOVpDEiZ/MgZwy9zHwm9l/ww9aREtyonV
         RNVtjjsIywSZ4MIG4soZr7uzQeXNkmM0HbdvzQz8MiONTAqoeDM05aV2Ftly6ox6VVbi
         vAXTxFYZjJg9meIvWIbczwxkRCZgy+ND+CtKyqyYtmWWyQOMs+AYSA1LLJxZvt2OVOem
         dNm/852X9KkBfUlVHT5G/ZEmFYaIwTzzuY+GCBk8+aI4qlEtqvkZtYAUAmE22mruRti3
         ZmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrX2ku5VLTsjCwH/Osig+uf9qNltpnDPxN/HixZr+Gc=;
        b=aG6D7BQz5Ui4vDlQ4kMw03HIZ49PHDPsvbwTl1ykjiAZLnPYKV4hI81UgYM+TpGKvr
         zRIs4m89ddtnvPvwGqXTUe4310g9BXcgJjCOPL+eV+VCuBSalx7vXlACEfhfD/6AOddx
         bNgX6Eh/L+tD7kKopAqbIXBB8bsGs+I8kLfPLbQEQpvr6Z9sRb/kcBz/aqBA7+hTmJj8
         QDESPwA1afof8+FTzC3dzxGgFdavsJ8ri3nTFfhW/mx+7VY2yK6lrqwFwS5svImY38dw
         xGfDNwZTv9qUzR3gJm/a7VehrgVBKpJNfms1WEwRW9baeQgYwcEY12ZOnJ6/XUlVEhVW
         WDpA==
X-Gm-Message-State: AJcUukcURyiMf38e7wqL4NcjJXl8mJJgdoc/DslTqau4lCJg1H0zgGEm
        eFW03GYtDXIsci/YH4YhMh7KProj
X-Google-Smtp-Source: ALg8bN4H+daR+cxh/j9lcCmRYE8ciuoOdaEyy2SxDdrb5PUDKXGcTQQ02Ru2OxQBlVm0oWRa0Tpc0g==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr8275010pgr.426.1547634726245;
        Wed, 16 Jan 2019 02:32:06 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y84sm16688696pfb.81.2019.01.16.02.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:31:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [RFC/PATCH 00/10] Support using submodules with worktrees
Date:   Wed, 16 Jan 2019 17:31:49 +0700
Message-Id: <20190116103159.9305-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this topic has come up twice recently, I'll take this opportunity
to gather early comments on this series. It depends nd/config-move-to and
at least has one known problem reported Tomasz. But I'll fix that
later once nd/config-move-to lands.

For more details, head for 01/10. This basically makes it possible
to create secondary worktrees in either supermodules or submodules. The
user will be required to turn on extensions.worktreeConfig and this is
something I'll need to work on, to make the transition smoother.

Note that while it works, it's not really optimal because worktree
clones of the same submodule could be duplicated. But hopefully I could
tackle this one step at a time. Make it work first, shake out bugs, then
think about sharing repos.

Nguyễn Thái Ngọc Duy (10):
  doc: about submodule support with multiple worktrees
  submodule--helper: add missing \n
  submodule add: support multiple worktrees
  submodule init: support multiple worktrees
  submodule update: add tests for multiple worktrees
  submodule sync: support multiple worktrees
  submodule deinit: support multiple worktrees
  submodule clone: use repo_config_set()
  submodule clone: propagate extensions.worktreeConfig
  submodule ensure-core-worktree: write to config.worktree

 Documentation/git-worktree.txt  |   8 ++
 Documentation/gitsubmodules.txt |  17 +++++
 builtin/submodule--helper.c     |  86 ++++++++++++----------
 config.c                        |  10 +++
 config.h                        |   1 +
 git-submodule.sh                |   8 +-
 repository.c                    |  21 ++++--
 repository.h                    |   4 +
 t/t2405-worktree-submodules.sh  | 125 ++++++++++++++++++++++++++++++++
 9 files changed, 228 insertions(+), 52 deletions(-)
 create mode 100755 t/t2405-worktree-submodules.sh

-- 
2.20.0.482.g66447595a7

