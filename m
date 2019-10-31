Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 673831F4C1
	for <e@80x24.org>; Thu, 31 Oct 2019 09:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfJaJ0f (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 05:26:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35707 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJ0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 05:26:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6so2459011pln.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1XDyYdz83i78hZVhkAOZ1r8IdchOwRyUE7fVlaZ5Z8=;
        b=t5gj+hYh2C+SJ1sK0FwWqEsRTTZ+PZ15H+tfoieEBsQ9i6M759n9dAlBrHJYHgmXne
         ny0JPKqfCxUqw+gK9e/CR36neAKmKwQQji9xdV5OdS9yjNb/2bMpo01O/dnD/yvzXoNP
         PaL0PtcKeSqUZTSsdRm1K4N7IcfV6dJjOVQWbN54eT24TD2GuysbkHC5fjgvbASfS62N
         ZfD49YxY7sCVuIjS64EgsODt3/FPBdZjk14UEqXHbq3GEEQE3v8MysRT642gDegmbMWb
         jnqzkvSzm152cCTS8TQqLdTxN9hXPU3+ri4h0boGFeEnOHw9gDLfHZyLCsoMdY4xV6QT
         bnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1XDyYdz83i78hZVhkAOZ1r8IdchOwRyUE7fVlaZ5Z8=;
        b=RVeISKQ6xB5/sli79eJfuLaHmttBiEOh/Z96VX/lSUOKoHyKSXjPZrH2peOjkdH9EK
         UFhsnS486VzIiRW3Pj9b5opuekEqTKA2vNbrzjpJypGn7UmQ40oHym6T1Th2pTiiqsmL
         Y/sxLF6+1aZX7xo6aFxGnoQ7YziAtld6HmX6xxfnz8dLIuuIMm46EDlkbSkHY8rLKF0g
         sDS/gE/Ez2XwHoyNnJhqoI0to1KGEy7wzArVujCn+5nRFJa9x1ptpgZKYxOXhodDlrUB
         la5g6P8PrfLGKRF/s7q7P9xrcJGbscSiLjDLosLfBhxTGvGqDXi3iX0HlvIQVR87+zN/
         KsGg==
X-Gm-Message-State: APjAAAXj4PsZPN6w08Z0KQsu5bTJp8js5BMy8O/X3hSW6JVe9xYY7tZb
        7ip8IxjoFS4K3H1t8KN5eyL+wQEQ
X-Google-Smtp-Source: APXvYqzk9gqpp0529geA7omnNmgRVu59iitpG4evRP8flg+pGYCASoz/LF1SbXDZIlmuLVYUjjVDig==
X-Received: by 2002:a17:902:9b86:: with SMTP id y6mr5472615plp.84.1572513993941;
        Thu, 31 Oct 2019 02:26:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:2d45:2809:9830:be60:8e46])
        by smtp.gmail.com with ESMTPSA id y24sm3570558pfr.116.2019.10.31.02.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 02:26:33 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 0/3] Linux with musl libc improvement
Date:   Thu, 31 Oct 2019 16:26:15 +0700
Message-Id: <20191031092618.29073-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.3.gc8da3990e5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patch tries to ease the life of musl libc user (by running
configure once) and clear out those last failure on musl.

Doan Tran Cong Danh (3):
  t0028: eliminate non-standard usage of printf
  configure.ac: define ICONV_OMITS_BOM if necessary
  sequencer: reencode to utf-8 before arrange rebase's todo list

 configure.ac                     | 22 ++++++++++++++++++++++
 sequencer.c                      |  2 +-
 t/t0028-working-tree-encoding.sh |  4 ++--
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.24.0.rc1.3.g89530838a3.dirty

