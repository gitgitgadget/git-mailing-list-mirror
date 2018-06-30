Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BE31F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeF3JI2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:08:28 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40373 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeF3JIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:25 -0400
Received: by mail-lj1-f175.google.com with SMTP id a6-v6so9060861ljj.7
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDDb52KSF4mJ7f8kSNaxR9Zd1mJxem80My+77fp4G+4=;
        b=jhBAXdmJNSnagJqeD/V91bN0ofUggzj7YZQECVPcPyC2+8jBy+R6LQfLrjvpvHpjoF
         w2LLn5IKOTCZ8u93JJlmfzwIzhjL2fJ65qv4tnLIJcjR7Js7V6t3M777ebd10xwiRCWC
         8GDSasRmvKUxEdNXHIn0vBSAOraEHX+K9rNf0nKFzjfqqcL2ZPkOn4ifhaqBUB/3uI4U
         HUtLTPsGjuI7WjTBjx0FNOsKvsfVFfnkRqz3fVMDI5Z9Vh+gaEqAeD0T16vn5Z3m3Jtp
         X1hA25/7iIo7VhCcvaYKyEIRC17Fpu816bq4cdHEqaGKA5vIQpe30hA92t7YjEamgbZJ
         qfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TDDb52KSF4mJ7f8kSNaxR9Zd1mJxem80My+77fp4G+4=;
        b=GB5P2b3KWsHQ6ZkhC8OPkNo4NxLsjUNDTR8X6otgLrVPZ2JX00CLlNyu9NchtIjfd1
         vOjSGedSLq47buhs0zgss8BUPA+jRWmZxCAWkByaYkjK18Fd0IOBCBoPGiT/OqdmR/Bw
         8W11+/GisTS0iD9f27/tXfuiYXA9nTPaa0h1Og1ULOifABqm88ckx47/Qyp3nvXvCM0Y
         0G0RRNhi/ETIQHXK9WZYKzOr2wl2YvpWsVOg7sTJ8n+1KDY6+5sdk+MdDBBYiIZeDbbb
         eiZ9BN5CAq1cX2oSKEre1tBqfwjjEXnc3zP4t82C2rOiHfxe2TOCK2l1LbRSVA3xqfO1
         werA==
X-Gm-Message-State: APt69E0pFESeHHgsubHR/87Y1Hpd49j6w/6tQnUaS/b47DVtyUT2yQ5h
        ZLFSGroFVX/5wXDGDatG6XIhXA==
X-Google-Smtp-Source: AAOMgpfgRQt7wcqN9Kmr69KYspjqdV/N1KPMrMfucTzfLvOtqWqtHN8IpjJL5zrI0hMStJqOSHzl7g==
X-Received: by 2002:a2e:9742:: with SMTP id f2-v6mr10810523ljj.5.1530349703479;
        Sat, 30 Jun 2018 02:08:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/23] Mark strings for translation
Date:   Sat, 30 Jun 2018 11:07:55 +0200
Message-Id: <20180630090818.28937-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a rebased version of v2 [1], sent during rc time and was
probably fell through the cracks.

[1] https://public-inbox.org/git/20180603163420.13702-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (23):
  Update messages in preparation for i18n
  archive-tar.c: mark more strings for translation
  archive-zip.c: mark more strings for translation
  builtin/config.c: mark more strings for translation
  builtin/grep.c: mark strings for translation and no full stops
  builtin/pack-objects.c: mark more strings for translation
  builtin/replace.c: mark more strings for translation
  commit-graph.c: mark more strings for translation
  config.c: mark more strings for translation
  connect.c: mark more strings for translation
  convert.c: mark more strings for translation
  dir.c: mark more strings for translation
  environment.c: mark more strings for translation
  exec-cmd.c: mark more strings for translation
  object.c: mark more strings for translation
  pkt-line.c: mark more strings for translation
  refs.c: mark more strings for translation
  refspec.c: mark more strings for translation
  replace-object.c: mark more strings for translation
  sequencer.c: mark more strings for translation
  sha1-file.c: mark more strings for translation
  transport.c: mark more strings for translation
  transport-helper.c: mark more strings for translation

 archive-tar.c                         |  12 +--
 archive-zip.c                         |  14 ++--
 builtin/config.c                      |  50 ++++++------
 builtin/grep.c                        |  12 +--
 builtin/pack-objects.c                | 108 ++++++++++++-------------
 builtin/replace.c                     |  90 ++++++++++-----------
 commit-graph.c                        |  20 ++---
 config.c                              |  76 +++++++++---------
 connect.c                             |  85 +++++++++++---------
 convert.c                             |  42 +++++-----
 dir.c                                 |   8 +-
 environment.c                         |   4 +-
 exec-cmd.c                            |   2 +-
 object.c                              |  10 +--
 pkt-line.c                            |  26 +++---
 refs.c                                |  40 +++++-----
 refspec.c                             |   2 +-
 replace-object.c                      |   6 +-
 sequencer.c                           |  28 ++++---
 sha1-file.c                           | 110 +++++++++++++-------------
 t/t0021-conversion.sh                 |   2 +-
 t/t1305-config-include.sh             |   2 +-
 t/t1308-config-set.sh                 |   2 +-
 t/t1400-update-ref.sh                 |  20 ++---
 t/t1404-update-ref-errors.sh          |   4 +-
 t/t1450-fsck.sh                       |   2 +-
 t/t3005-ls-files-relative.sh          |   8 +-
 t/t3210-pack-refs.sh                  |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |   6 +-
 t/t5500-fetch-pack.sh                 |   2 +-
 t/t5505-remote.sh                     |   2 +-
 t/t5570-git-daemon.sh                 |   6 +-
 t/t5801-remote-helpers.sh             |   8 +-
 t/t7063-status-untracked-cache.sh     |   2 +-
 t/t7400-submodule-basic.sh            |   2 +-
 transport-helper.c                    |  89 ++++++++++-----------
 transport.c                           |  18 ++---
 37 files changed, 470 insertions(+), 452 deletions(-)

-- 
2.18.0.rc2.476.g39500d3211

