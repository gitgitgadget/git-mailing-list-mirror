Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 796E81F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeDNP1A (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:27:00 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39960 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeDNP07 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:26:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id i18-v6so1355004lfc.7
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEiSUxum6/cl4mEIFKmI2dJ9FlHTWlJ48H/T1C2jElo=;
        b=BasNGDI0Rq8QUeoxoCa28UnTWR45gGf7JLTzhja8hzfTv2tqOnsuml98tID9GGqU8D
         f3tiiXLSu2ag4zWGBvQkK2nfYmBebJRGRwbClhvTg59OPx/2mfkdLz40J6Jluw5v0X1z
         PWXAekrsCCT+GS4lp6zvBWOXN1AUBe2KcGJ0oMEUbhHFNLrdkx8IaG1nQjw1DLEn4Dam
         NXE7qGgO9F8qPo3qjCGVsSiGK4c1JlyVog1rN62ci9JK6Zq1u6PeWedq0QC2DlKFKzZo
         73i9jV+/vtQHSLE2ZpMAhj8o8rtruwiTgdbj6Juf27OsGLIIKN1/ytRwo65oL1/KntI6
         4o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEiSUxum6/cl4mEIFKmI2dJ9FlHTWlJ48H/T1C2jElo=;
        b=tJnC8Y8k+I/zUNQfe9/ea85KnFhfeyN/BBnmNoVrFPSfyjpS4BgKxXiPqwewx0x5CJ
         iEx3SPr2puUULIzEe75zSxl9PEBpzdVjiqAku2DpH4qdwHOaoCIXNUcq0lCOBsf+0/8M
         JUIRPyxc+edUbuyDbaO4urHtrz3mASc4FP+ded2/cEOmuE5Pf9my+RSEgbhOZg/Ste4n
         uCOSGRijuSAB4e2cnD9nMy93JMtbeHTLxP1u7O7jnhHIGrk0cQUKeou7gt4dXgRRiVYn
         QwqpAKBXboIXDe0aQMO6rYeQyGc2Iw5lTMZW8hyAupUBLicNps376W6aI+jLUFO+F4Q0
         gn2A==
X-Gm-Message-State: ALQs6tAF93TIVVwi5M2x2vapvqEh4oVXg8htkMi93wNnA0+fa9x9aQDC
        DIqZ/eIalJHW07TiIoSpTGyo5Q==
X-Google-Smtp-Source: AIpwx4/c1fqpPj+NDSRVXg/u56UtCdqFdF/3zjCLpVTAEum70eKpWeO/O67kkRFCzSjMcDuTLgZN3g==
X-Received: by 2002:a19:d403:: with SMTP id l3-v6mr11212962lfg.51.1523719617436;
        Sat, 14 Apr 2018 08:26:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1803378lfg.28.2018.04.14.08.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:26:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/7] nd/repack-keep-pack update
Date:   Sat, 14 Apr 2018 17:26:35 +0200
Message-Id: <20180414152642.4666-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is basically a resend from the last round but rebased on
'master'. The old base results in some conflicts with packfile and oid
conversion series. This one should reduce merge conflicts on 'pu' to
trivial ones.

Nguyễn Thái Ngọc Duy (7):
  t7700: have closing quote of a test at the beginning of line
  repack: add --keep-pack option
  gc: add --keep-largest-pack option
  gc: add gc.bigPackThreshold config
  gc: handle a corner case in gc.bigPackThreshold
  gc --auto: exclude base pack if not enough mem to "repack -ad"
  pack-objects: show some progress when counting kept objects

 Documentation/config.txt           |  12 +++
 Documentation/git-gc.txt           |  19 +++-
 Documentation/git-pack-objects.txt |   9 +-
 Documentation/git-repack.txt       |   9 +-
 builtin/gc.c                       | 165 +++++++++++++++++++++++++++--
 builtin/pack-objects.c             |  83 +++++++++++----
 builtin/repack.c                   |  21 +++-
 config.mak.uname                   |   1 +
 git-compat-util.h                  |   4 +
 object-store.h                     |   1 +
 pack-objects.h                     |   2 +
 t/t6500-gc.sh                      |  32 ++++++
 t/t7700-repack.sh                  |  27 ++++-
 13 files changed, 349 insertions(+), 36 deletions(-)

-- 
2.17.0.367.g5dd2e386c3

