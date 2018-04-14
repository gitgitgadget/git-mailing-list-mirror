Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1F31F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeDNPf2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34895 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeDNPf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id b189-v6so16423223lfe.2
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L34j+82do6VWvi2CYJLgsQ8Z5N/RRFVDiuFQARZKFLY=;
        b=FyJnRANeztWR6Fe68gY4EF51PsLvp9M52KJRtLRkJ1qqi0D2MGp2dV6BOVT/CejGud
         O4jtriZSeXE0QiX3MCtkBAQHZDmvKGxfaHvDkBS6WEOdzvYUTKCjf1l9Aa3QL9WBZOZS
         zMySW6LFg/pXk0XqljDp389AWEaxr+BTRa3ZJRd7PY2SSvl5ZfPb0pu/nfF/NnWOXkZW
         Qum1HjGfgHBtZ7tF9Yrn9I16OzjVaA2O4J49Yw1Dy3dWyE2Q46i5lSrqr3ZTO0fuj+GI
         dE1/uW5Gay26DzEftSQJFnWSYUH8vuHjPe/DxQrDUIrzXboFSBIrH6xynzBqBE2ZANqL
         nkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L34j+82do6VWvi2CYJLgsQ8Z5N/RRFVDiuFQARZKFLY=;
        b=Neim4CyCCiNO3de9KtPLwRlcoKVehL/UPcW+h8wHOXKy1dO72aJxb8n13oY0U8Sf8U
         5arsiJ+jTnscjES6efb3yoINH1yF4Lnw4NoC2trCf+z1XfrrziV2rxucb3wymfM15vj0
         C3aPe9dAcfXvXa71uUbS4X0bLadBTrqmTeWwtQ5PhX04j+QudgR+MLcd6PmyBEm7B29o
         DQTIyxRRVpUWrTvSzonG7IvRO+O+g5s/KAKiknKajTJ0WlsH8zjO7gc5bYs7MmHVlCEZ
         uqzrhAyr/AGCzgDUa0zLOZ0WWVdIDrHUvblV87FWCpAmdL/s8502WKCpl4QBDlQIInjd
         SjnA==
X-Gm-Message-State: ALQs6tBAkrH8SFuR0GyO189IV3SLImf9rDZpdtrz+EEtWTpy6WEOJXJn
        Ss3aknkRgVoX1SauRWw8B0Tc0w==
X-Google-Smtp-Source: AIpwx4+k1lgVH+4pvZ2BGfHMG0eymX/mAiACVCDpbwqM9XWJsa0vTUk4Y+RqjX9Dk4gIT3ehLMB8Kw==
X-Received: by 2002:a19:d015:: with SMTP id h21-v6mr10353732lfg.124.1523720125307;
        Sat, 14 Apr 2018 08:35:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/15] nd/pack-objects-pack-struct update
Date:   Sat, 14 Apr 2018 17:34:58 +0200
Message-Id: <20180414153513.9902-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is basically a resend from the last round but rebased on latest
master to take advantage of new object-store and oid changes.
One minor change is t/README now mentions about git-config when a
variable accepts a boolean value.

Nguyễn Thái Ngọc Duy (15):
  read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean
  pack-objects: a bit of document about struct object_entry
  pack-objects: turn type and in_pack_type to bitfields
  pack-objects: use bitfield for object_entry::dfs_state
  pack-objects: use bitfield for object_entry::depth
  pack-objects: move in_pack_pos out of struct object_entry
  pack-objects: move in_pack out of struct object_entry
  pack-objects: refer to delta objects by index instead of pointer
  pack-objects: shrink z_delta_size field in struct object_entry
  pack-objects: don't check size when the object is bad
  pack-objects: clarify the use of object_entry::size
  pack-objects: shrink size field in struct object_entry
  pack-objects: shrink delta_size field in struct object_entry
  pack-objects: reorder members to shrink struct object_entry
  ci: exercise the whole test suite with uncommon code in pack-objects

 Documentation/config.txt           |   4 +-
 Documentation/git-pack-objects.txt |   4 +-
 Documentation/git-repack.txt       |   4 +-
 builtin/pack-objects.c             | 364 +++++++++++++++++++----------
 cache.h                            |   2 +
 ci/run-build-and-tests.sh          |   5 +-
 object-store.h                     |   1 +
 object.h                           |   1 -
 pack-bitmap-write.c                |  14 +-
 pack-bitmap.c                      |   2 +-
 pack-bitmap.h                      |   4 +-
 pack-objects.c                     |  68 ++++++
 pack-objects.h                     | 314 +++++++++++++++++++++++--
 read-cache.c                       |   4 +-
 t/README                           |  22 ++
 t/t5300-pack-object.sh             |   5 +
 16 files changed, 654 insertions(+), 164 deletions(-)

-- 
2.17.0.367.g5dd2e386c3

