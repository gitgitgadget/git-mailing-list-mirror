Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD3C1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeHPVbb (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:31:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44982 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbeHPVbb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:31:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so4104560lfb.11
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTOeRmKrHutTf8OmK2mdCWgA4g8klL8T53NgwqC44eY=;
        b=k/avmiYIbXFMQVXI0dHTNr/8VTs5xxX3SR97ikF98o2tCZmWwT1gJqXsyKwceaMXvZ
         4B2dolMS1jkoYfhrgPTXfifjxXOYdWPMFzFUSinv1LSnI5lqtcAsjlT7BD79Hk0AI2O2
         biB5d9ZIu3ceFUtik3NnkKHmgNJuAz4RXGbtUFUvsDy0W155qy1F2MtIxsWV6wVuUSnV
         243ZzNCn0N7YyR0p9xLlKOTBKafqiXo1YBKeW426zkoTSz20oNCCVq1iWyN3NXg+qjzh
         313XNrYbxoJZHlKpXQrVDqTHYF+694yIb/FCTrzJH7x6LzwXxagvuFR6BVrx2nwBZKO/
         x7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTOeRmKrHutTf8OmK2mdCWgA4g8klL8T53NgwqC44eY=;
        b=U/2DvpBvbfSedKb7Dmrc8QJvZgVGvFbJf0dx0PRwJ/8ojE0Xz1axXuiKZZHh4FrSSu
         Od/vqOtfuL0hya9ffbmG02CG8NAI4IieA00uXMhXJ23lAQz+18rMLDbqvvRV2fFEe2Df
         /sBgFHdygzO/N93sRrK4DhdCJZ7sWCmLByml1pWHZ48KY5VNLv0N6ylpEpjq50HoSnWm
         WGBO1RyUj/9o9dQ9TEROIoPtdKpwpcX8U17CyKr/U2lxbH4exHasc6P90ycGX/4LPCF6
         Ocal1yJFHYIjzrmHlfL8l8kWS+yRBO+LB8zfkZIs8yOopYXYTNU+EF73pi2XgCfsL4GQ
         Y/Bg==
X-Gm-Message-State: AOUpUlHljJdDEosSIL99T2Vm/B3PF5Y0ylZxr6noJbOwx5xSNP1PntVH
        VbCHcgmvJqMIrIR8EZH/LxaxavXd
X-Google-Smtp-Source: AA+uWPysWeItdV1hO2iINbX+69ovoPvikFzvBqnGUKISfzmzkLpq5nV8rglvi8vT2BuR8meUk+UcCA==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr19733943lfh.125.1534444284957;
        Thu, 16 Aug 2018 11:31:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id 96-v6sm2773lfu.40.2018.08.16.11.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 11:31:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] commit: add short option for --amend
Date:   Thu, 16 Aug 2018 20:31:17 +0200
Message-Id: <20180816183117.13716-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just realized how often I type "git ci --amend". Looking back at my
~/.bash_history (only 10k lines) this is the second most often git
command I type which may justify a short option for it (assuming that
other people use this option often too, of course).

The short option space for 'git commit' is really crowded with
acCeFhimnopqsStuvz already taken. So it could be '-M' or '-A' but I'd
prefer not to hold shift, so I chose '-j' even though it's not
strictly related to "amend" (or perhaps we can thinking of amending as
joining commits).

Thoughts?

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 213fca2d8e..78f125ba1f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1489,7 +1489,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			    STATUS_FORMAT_LONG),
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
-		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
+		OPT_BOOL('j', "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
-- 
2.18.0.1004.g6639190530

