Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3F420248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfCEMIq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:08:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33502 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEMIp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:08:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so5553682pfd.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2b9YFg5yiyQ1XlJSS+DZhHv//2KgsWXzUKxd8nBoOGA=;
        b=WYpS5et3lSmS6hrvcx+H1kKwP6H86q2Bvt+8GbgEHeFlkJCKdBLJrR/upi5cD353K5
         fe2NgWExOkAgrevF0EWJvuL1d+PXeF6py7+8ZcNZmBQr32+REQKXw5Ub/QfKK6xeTpn7
         yLlzYgBQMGMfKRjJyG7C3gVTlQvUQ2TbjCMp5cz+TtByuL8gZY7uDRoawxR8VFENX+cn
         plTfIsL79c+x0yGpQ1JeOA4q3D/z3ktAwKwlyh5WSLwBChst8nQef3muE9AKj6L1E7jX
         kBUrHyc6gyi+M5L1zJI7A6G7eepPb5cSZ+ef00PwVqDF+yJYUiPSE+HXYfF8/GMniAO0
         GDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2b9YFg5yiyQ1XlJSS+DZhHv//2KgsWXzUKxd8nBoOGA=;
        b=Q+VqoH/jEKb6/XnMEhA+2HGcpu6UMvMirTlbs6u7zcHNboiECLJcISXWGqDlCxtc7x
         eeyXsgtyLNLfuG4DEWKUWV44yCBe2GVVi4khXP3ZNWvWR785VhsttfqhyHlaru0a1GEX
         4zDAFblSYDBUxYSEs3sM3hktSHDxtvAzXpbxtw4LUwwEskOusuHppGJYjxyVLo2ZZljT
         VMAE6/q64yEhE37Nd1HdGRB33xiFYUrXPaigjSGP0hkPjoACb6dxxfK56cO/W/f86cUR
         sehAnvhdJZG/UcGZ/cCLQbbdk0h+oE9Jd98tQXEGutQpqs7pU/tcK5Li0iiugSWL6yLO
         TVYg==
X-Gm-Message-State: APjAAAXle+DFYZcaa48/ODN6lPFexLLhIFxC8a6pyLOz585y9mnzMwmd
        wUgYjDKTfAfYgyVp4Fh3Tmy/VNGT
X-Google-Smtp-Source: APXvYqxBCjtdJjXre5YlRsA+FW/vuPm1CrmpDA2+gDBchILWV8/iVJBBkIREehoycZmskexG80dZmA==
X-Received: by 2002:a17:902:6f08:: with SMTP id w8mr888909plk.5.1551787725061;
        Tue, 05 Mar 2019 04:08:45 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 1sm22501462pfy.68.2019.03.05.04.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:08:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:08:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, peff@peff.net,
        ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 0/2] worktree add: sanitize worktree names
Date:   Tue,  5 Mar 2019 19:08:32 +0700
Message-Id: <20190305120834.7284-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190226105851.32273-1-pclouds@gmail.com>
References: <20190226105851.32273-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 refactors check_refname_component() so that we could do more accurate
substitution (and leave fewer traps).

Performance of sanitize_worktree_refname() goes back to horrible
again. But since it's not really a big deal (no body is going to add
200 worktrees per second), I don't feel like we should optimize it.
That may involve removing the for loop in do_check_refname_component()
and making things uglier.

The test is also updated to have FUNNYNAMES prerequisite, which is
always unset on Windows. This should fix the breakage there.

Nguyễn Thái Ngọc Duy (2):
  refs.c: refactor check_refname_component()
  worktree add: sanitize worktree names

 builtin/worktree.c      |   7 ++-
 refs.c                  | 114 ++++++++++++++++++++++++++++++++++------
 refs.h                  |   1 +
 t/t2025-worktree-add.sh |   5 ++
 4 files changed, 110 insertions(+), 17 deletions(-)

-- 
2.21.0.rc1.337.gdf7f8d0522

