Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3AC11F453
	for <e@80x24.org>; Mon, 29 Apr 2019 20:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfD2UOQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:14:16 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42772 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:16 -0400
Received: by mail-ed1-f50.google.com with SMTP id l25so10279719eda.9
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=jCKE7HSHVzTC+Oe5kucfr6pjEwhSSkWEI4TGyO8I4w0=;
        b=DhEmGlDV/kjm00Ncstv9g8gl4MPh1sY/jU+mZaqusZFB7owezErBkny3Q9ePDA91+A
         MBJFGayHRCMC8eMOvUaJzHI/SwKc+LQSolsaRy5sFSPJjqS0tj2Hr7lcZXj/U4XC/Cm6
         ffB3YuhumaEu0v4q2Ymu3UnMl2nlXlxoEasSHu5655woKoJAK15fvQj5HgtEqFAm3P6L
         OAHY8lpw0p8l5IGY5DKOnwr8azv6jOaySP5GfPylpF9v9B5bIrjgfBelOZEYgnVeOg5y
         y1ugzJvuvBjwSeNEuFpuV+K/2TVtBUcFm3nHd1PY/TyHesBGfAWx9otWaVn2ktAizahz
         fEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=jCKE7HSHVzTC+Oe5kucfr6pjEwhSSkWEI4TGyO8I4w0=;
        b=G8/VLoz2dpepYcVcN8t8GCC6755zwodNbHc5MZzWthL5mrKdWU4bZlozFYkH64AvGH
         o/JXDvY2FqbbFzOUmx1zuWRc/9A48y4nV2CaSU5PJkurL11eNaKkncwjF+u+3Tosu3ky
         Q+rHH+8TAqsz64RjIsD3KUrY5DYKpZfE/kEcFz+JnN5OYtXRhiErKK3Z0LcBzf2Ztw5M
         9wV5/+7eM/BcxsaMF9JS9+uYDbjb27sm/mTbOsprMaa90nxHYWjdfpd4LrXNEuZouPEk
         bv2F3QnvohZoEagjsKgFax28hfn6FGdtJFgKsGWHWhxcqdrrRZoeKtj+p/2So9NYk+an
         Z1fA==
X-Gm-Message-State: APjAAAVtErGXtbDJwf28E+JMSz7Rbv8TJ1Y6M2PxaUOPnMpQD9T8iJe7
        lY5xbF46Re+KozSLKJDxr/fjtSKQ
X-Google-Smtp-Source: APXvYqy8AY84BYjBnjhrywRFn9GqHPBT4rcizuBkmjb0KCJ16jXkzdF3Z2OU+aIxF6BxYDDRE38kpA==
X-Received: by 2002:a17:906:1e0f:: with SMTP id g15mr17406379ejj.241.1556568853831;
        Mon, 29 Apr 2019 13:14:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h33sm1292987eda.47.2019.04.29.13.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:14:13 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:14:13 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 20:14:00 GMT
Message-Id: <pull.169.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v4.git.gitgitgadget@gmail.com>
References: <pull.169.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 00/11] trace2: load trace2 settings from system config
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Version 4 fixes a few clang-format warnings and simplifies the PID field in
the SID.

Jeff Hostetler (11):
  config: initialize opts structure in repo_read_config()
  trace2: refactor setting process starting time
  trace2: add absolute elapsed time to start event
  trace2: find exec-dir before trace2 initialization
  config: add read_very_early_config()
  trace2: use system/global config for default trace2 settings
  trace2: report peak memory usage of the process
  trace2: clarify UTC datetime formatting
  trace2: make SIDs more unique
  trace2: update docs to describe system/global config settings
  trace2: fixup access problem on /etc/gitconfig in
    read_very_early_config

 Documentation/config.txt                 |   2 +
 Documentation/config/trace2.txt          |  56 ++++++++
 Documentation/technical/api-trace2.txt   | 176 +++++++++++++----------
 Documentation/trace2-target-values.txt   |  10 ++
 Makefile                                 |   1 +
 common-main.c                            |   8 +-
 compat/mingw.c                           |   2 +
 compat/win32/trace2_win32_process_info.c |  50 ++++++-
 config.c                                 |  30 +++-
 config.h                                 |   5 +
 t/t0210-trace2-normal.sh                 |  49 ++++++-
 t/t0211-trace2-perf.sh                   |  43 ++++--
 t/t0212-trace2-event.sh                  |  42 +++++-
 trace2.c                                 |  21 ++-
 trace2.h                                 |  43 ++++--
 trace2/tr2_cfg.c                         |   7 +-
 trace2/tr2_dst.c                         |  26 ++--
 trace2/tr2_dst.h                         |   3 +-
 trace2/tr2_sid.c                         |  53 ++++++-
 trace2/tr2_sysenv.c                      | 127 ++++++++++++++++
 trace2/tr2_sysenv.h                      |  36 +++++
 trace2/tr2_tbuf.c                        |  19 ++-
 trace2/tr2_tbuf.h                        |   5 +-
 trace2/tr2_tgt.h                         |   1 +
 trace2/tr2_tgt_event.c                   |  53 +++----
 trace2/tr2_tgt_normal.c                  |  19 +--
 trace2/tr2_tgt_perf.c                    |  23 +--
 trace2/tr2_tls.c                         |  38 +++--
 trace2/tr2_tls.h                         |   8 +-
 29 files changed, 752 insertions(+), 204 deletions(-)
 create mode 100644 Documentation/config/trace2.txt
 create mode 100644 Documentation/trace2-target-values.txt
 create mode 100644 trace2/tr2_sysenv.c
 create mode 100644 trace2/tr2_sysenv.h


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-169%2Fjeffhostetler%2Fcore-tr2-startup-and-sysenv-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-169/jeffhostetler/core-tr2-startup-and-sysenv-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/169

Range-diff vs v4:

  1:  f6653f1c59 =  1:  f6653f1c59 config: initialize opts structure in repo_read_config()
  2:  48e34834b6 =  2:  48e34834b6 trace2: refactor setting process starting time
  3:  175371fb54 =  3:  175371fb54 trace2: add absolute elapsed time to start event
  4:  94729b284c =  4:  94729b284c trace2: find exec-dir before trace2 initialization
  5:  b0fe1385f1 =  5:  b0fe1385f1 config: add read_very_early_config()
  6:  550cad6189 =  6:  550cad6189 trace2: use system/global config for default trace2 settings
  7:  56d8ce3fd6 =  7:  56d8ce3fd6 trace2: report peak memory usage of the process
  8:  196a9d2c85 =  8:  196a9d2c85 trace2: clarify UTC datetime formatting
  9:  9fdcb50140 =  9:  9fdcb50140 trace2: make SIDs more unique
 10:  3414016d04 = 10:  3414016d04 trace2: update docs to describe system/global config settings
  -:  ---------- > 11:  18ce795360 trace2: fixup access problem on /etc/gitconfig in read_very_early_config

-- 
gitgitgadget
