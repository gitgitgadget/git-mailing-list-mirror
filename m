Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5581FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbcHZR6r (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:58:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33272 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753910AbcHZR6q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:58:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so231101wme.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mt/nmj0mwb9x0pJWuLP+qLNcgxJRnJj7yFSveS68WVo=;
        b=YDxxYkAYfNbp3uBWZwt/lPA050E3wVgDvWahjKRHs11HZ905lRqh/V8hCzzFyp4CMn
         3HtBLEo2R51H4Sgwf+x02dF57CAniXXjKAzXbxVeNAe5ghXoWqEajEOEv2KJinrs4jG5
         P9bVzI3GGfSFa+v7VjAf/9/P1lglO9wd6j32Y3S9AQlHvy4yk9z4mQxNbfTGERK1dHre
         ZKmv/FmR2xYP5S+mEtRsr3FGbK2p1IClmc551RmBabxsaE2o/lfh3JE+S3Mm3XzWF+0I
         obq7C1WYk+PMbpxSO5kixNuq45vt1CMqgnKb74iWFp671YcGFsrNfcfWvHlP5OHyh6nF
         +doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mt/nmj0mwb9x0pJWuLP+qLNcgxJRnJj7yFSveS68WVo=;
        b=X5oAYi/sSThbWqyTftgY6nrMwAvp2wx/R3Psxhxgx01v65FlqxLpEPfx4DK9EVh45D
         JpAivBf97/qBLvtlEGqMgAHpwYaazkAmNrrTX3PAb710d2b9WPwWHe95P1RC/Vsenopk
         Cf2jNWpCfBXMyJTtLg29MmFQfYuskjEfsQRlwGT0ts72QOtuP8ZiYBdOR5A/DpIMaj2r
         7brXhU+9izRcq1YfcMi9GIBBcWgLOIODWLYLerGPv3eKhMzqewC2jYlTA+dkLSnLBIfH
         SnQ9JBQ934wG6+4Vy9g0bLblHB8cAjZhJH3thS1TYRFJ2YwBV+3XP31SOaIMLuqG+nHu
         6ZRQ==
X-Gm-Message-State: AE9vXwPQFymyP6G9pKjx2NsMT88yqBYADoDmwt6SE64YVyRcz7rD2XvDynNABjUJUAAKtQ==
X-Received: by 10.28.142.2 with SMTP id q2mr81286wmd.119.1472234325299;
        Fri, 26 Aug 2016 10:58:45 -0700 (PDT)
Received: from localhost (cable-86-56-27-135.cust.telecolumbus.net. [86.56.27.135])
        by smtp.gmail.com with ESMTPSA id d64sm112884wmc.22.2016.08.26.10.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 10:58:44 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        johannes.schindelin@gmx.de, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2 0/3] help: make option --help open man pages only for Git commands
Date:   Fri, 26 Aug 2016 19:58:33 +0200
Message-Id: <20160826175836.14073-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.9.2.912.gd0c0e83
In-Reply-To: <20160818185719.4909-1-ralf.thielow@gmail.com>
References: <20160818185719.4909-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2 are:
- add a patch from Dscho to make config variable 'help.browser' work on Windows again
- rename option "--command-only" to "--exclude-guides" which is less ambiguous in 'help' context
- improve test script
- refactor usage of argv_array in handle_builtin

Johannes Schindelin (1):
  Revert "display HTML in default browser using Windows' shell API"

Ralf Thielow (2):
  help: introduce option --exclude-guides
  help: make option --help open man pages only for Git commands

 Documentation/git-help.txt             | 11 ++++++---
 builtin/help.c                         | 37 ++++++++++++++++++------------
 compat/mingw.c                         | 42 ----------------------------------
 compat/mingw.h                         |  3 ---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  | 15 +++++++++++-
 t/t0012-help.sh                        | 41 +++++++++++++++++++++++++++++++++
 7 files changed, 87 insertions(+), 64 deletions(-)
 create mode 100755 t/t0012-help.sh

-- 
2.9.2.912.gd0c0e83

