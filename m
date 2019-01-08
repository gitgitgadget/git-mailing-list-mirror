Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A717A1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfAHVwh (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41527 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfAHVwg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so5587704wrs.8
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=225FzYGcK6GBnYKTZleqI4qncdyYjZSnkxJQcaUaj2Y=;
        b=Ci9N0qRSToR2vJCCDOQgBOBuHruaLNwiaBtTmwqhBYDEP0MKnB3RAapOx2/OeK4K1A
         qB0pjMCBuCHqTlHHWqfoRiC7UJM/jLm2gRhRnR2Lz7FdDriV08UPgBrt0RhdHNDEpkwe
         MBPMZU1iVzZ72qhponoFmTWAyVuITObHtaiSK6M8A58ZrYliKsp+3IxfsP1JU+LeLcxz
         wgSmFadYRa4pITFgRcM5RW54xU1yCShsiurcqvPhRizvoJPKy67Xrc8xorPACSmaUsLP
         1u9l+NvXLDBQAHwV+DyDBp8D361jdLcvocxfnsO2qeN0HF+Nkd2cey2XpJ46dXHWq04m
         FgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=225FzYGcK6GBnYKTZleqI4qncdyYjZSnkxJQcaUaj2Y=;
        b=omO8kpxoBQ8s0gBktkYwMZ7hsXIegdJ+2FBVLQ3YO+L92QWlmCuKRzwyZOa9f5Cp65
         w/O0O53xVQzru+OTThYD3v7BJHoJ9O2y/8LxaNeJf6l6ROMsDybE/TkBGkM83eeB3bHG
         QeYIKVOEX94XGIuIgr242rBWPGZ1gaeULd3DJaJg+OSvaDrNtidKL2S1JYFYc5IfL83p
         +4KlUPkn3u4GIcXi4eev3yRiXf3uZ4d3MiUKDECSK/vVjVytUHr0t68CxfJsQ2WbzDFd
         NkyGW3Kko2Md2BoXjEpzAA8UhM6jy5hzvLyxdyRqVWn5NPDFZvpE/fwdXEkvCTQGIMdg
         ukGQ==
X-Gm-Message-State: AJcUukdovI23XQON0FfXBUwK/WIAZx4/tePB8mrWjJWLE0g1kLr/aJgV
        iC1noIH8JZNHgbCe0lrnIx85FI9Y
X-Google-Smtp-Source: ALg8bN5JlMg0VM/IDPb4YaiPAw9bUcgiY00zMJNecjY9mWSo3ZfbwjBoqr8NSUl/zrPq0h8IF3zAyQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr2615561wrs.290.1546984353945;
        Tue, 08 Jan 2019 13:52:33 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id o64sm9615556wmo.47.2019.01.08.13.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:33 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/8] move worktree tests to t24*
Date:   Tue,  8 Jan 2019 21:52:18 +0000
Message-Id: <20190108215225.3077-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190108215225.3077-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git worktree' command used to be just another mode in 'git
checkout', namely 'git checkout --to'.  When the tests for the latter
were retrofitted for the former, the test name was adjusted, but the
test number was kept, even though the test is testing a different
command now.  t/README states: "Second digit tells the particular
command we are testing.", so 'git worktree' should have a separate
number just for itself.

Move the worktree tests to t24* to adhere to that guideline. We're
going to make use of the free'd up numbers in a subsequent commit.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/{t2025-worktree-add.sh => t2400-worktree-add.sh}       | 0
 t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh}   | 0
 t/{t2027-worktree-list.sh => t2402-worktree-list.sh}     | 0
 t/{t2028-worktree-move.sh => t2403-worktree-move.sh}     | 0
 t/{t2029-worktree-config.sh => t2404-worktree-config.sh} | 0
 5 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
 rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
 rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)
 rename t/{t2028-worktree-move.sh => t2403-worktree-move.sh} (100%)
 rename t/{t2029-worktree-config.sh => t2404-worktree-config.sh} (100%)

diff --git a/t/t2025-worktree-add.sh b/t/t2400-worktree-add.sh
similarity index 100%
rename from t/t2025-worktree-add.sh
rename to t/t2400-worktree-add.sh
diff --git a/t/t2026-worktree-prune.sh b/t/t2401-worktree-prune.sh
similarity index 100%
rename from t/t2026-worktree-prune.sh
rename to t/t2401-worktree-prune.sh
diff --git a/t/t2027-worktree-list.sh b/t/t2402-worktree-list.sh
similarity index 100%
rename from t/t2027-worktree-list.sh
rename to t/t2402-worktree-list.sh
diff --git a/t/t2028-worktree-move.sh b/t/t2403-worktree-move.sh
similarity index 100%
rename from t/t2028-worktree-move.sh
rename to t/t2403-worktree-move.sh
diff --git a/t/t2029-worktree-config.sh b/t/t2404-worktree-config.sh
similarity index 100%
rename from t/t2029-worktree-config.sh
rename to t/t2404-worktree-config.sh
-- 
2.20.1.153.gd81d796ee0

