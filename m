Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B061FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbcLJV5x (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 16:57:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36693 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbcLJV5w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 16:57:52 -0500
Received: by mail-pg0-f65.google.com with SMTP id x23so6240695pgx.3
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XZxQUwcOwgVe9qjFrmrjaArA+WdNhnuiXgEvcjcg1l0=;
        b=H+n5GZtoXx4RzEwaxd6NO72+F+JP7J2OPiB2MyNMF6ZkFvP/6uYd92wyPdsog2WSzR
         rqzn6/Oi5VEq7NiN0QgbGRKMrja1fGC2HHHV89uDP4kuVIdIBiPJyerjCG1FZulYHp0i
         uZBrS/yXi8mlSjMJ68KQeYQs56d5xbCtKv+CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XZxQUwcOwgVe9qjFrmrjaArA+WdNhnuiXgEvcjcg1l0=;
        b=RoVpxyH0OyPkuJU5v7BqMm+d54aIYmPM5i/e0V7GDv9yAjj43IdyTZQzAB8fXn9rFB
         t7imxiN+2FWB9BjPVQ9Qcla+vw7U75woUzqoFpTuwQnVFGxbPMOmug2eq3nLooEExZwe
         dLmkWE5a3mQJf5duuVzn0jiiYoRS1rECulcS2xGhpEbBBHKqx/lgXasQjjni6z9OjI8l
         I3UFWHlFNP9/HnvynIhb7orpGAGloULZe02J/N+h+13/KUHEnBLv/jUcaMrxASpK8KPA
         I+R9Yuhp2jltRBsW8+4xrkLP9QnE/ow8mIYefY6wQHJBPRrThP3juoodoqwp6hoJAGOb
         WOCA==
X-Gm-Message-State: AKaTC03gmjvjjVE3P3/HNh0VzD538cK1+hYXo9a5tLOeDUkpzydrBCsjp2vTHkGtrzNcfA==
X-Received: by 10.84.209.173 with SMTP id y42mr15816404plh.94.1481407071576;
        Sat, 10 Dec 2016 13:57:51 -0800 (PST)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id i124sm66882955pgd.15.2016.12.10.13.57.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Dec 2016 13:57:50 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4 worktree support
Date:   Sat, 10 Dec 2016 21:57:33 +0000
Message-Id: <20161210215734.7468-1-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Second attempt at teaching git-p4 about worktrees.

Earlier discussion here:

http://marc.info/?l=git&m=148097985622294

Git-p4 exports GIT_DIR so that when it chdirs into the
P4 client area to apply the change, git commands called
from there will work correctly.

Luke Diamand (1):
  git-p4: support git worktrees

 git-p4.py               | 47 ++++++++++++++++++++++++++---------------------
 t/t9800-git-p4-basic.sh | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.8.2.703.g78b384c.dirty

