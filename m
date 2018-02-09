Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BECB1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeBILGR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:06:17 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42475 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeBILGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:06:16 -0500
Received: by mail-pl0-f66.google.com with SMTP id 11so1315562plc.9
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVy7n5rdCxocyACbX+YAGSF7Qu+4i45Kk3O1nFKkIq0=;
        b=O5ZJNbFiOUjymJRfv+RGw20xxDFOmUHcfnTtbwEVnLcm9SqaKNXIDN6iL1HzJ2EnnX
         eYibqLoQ6lNcOssZovhbVFs47dM0Ztc4f7Urr1+eDptXxpGfD7KTxeV6HkD0jQlnzvsC
         4EfZTHvHttWlnE3yNfVLgWx69uTa8J86iFIYtgN22ZJw5r+VzQgZ3zZ73eMaHpRvspIf
         jLpvotfy6aqTP2SmsZnlz/JNOIFgJPzv0AvRImDwOPIF/aLe8E3yh0a1Hot2IRrdB+26
         O6sNR+TC9KdAYRNJN2Vlky1YHmfBDAw3QcQKu08vpL85T+28qhuLouhcCy3/nwv/2WQP
         Kj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVy7n5rdCxocyACbX+YAGSF7Qu+4i45Kk3O1nFKkIq0=;
        b=i2q/aroa6zz7F+UZNf7s6BHBuVzdZx96gbNDcrhyJHFbhqFpDwzy1hhkd/A21ElzWl
         FtmC9NK10WDEE7EJ8XNpi4uQyIpb6uj8RFl2C87p+5DfW44FGro/x9/3bU/3hcMEBewr
         uuR6CG8cDIugJlnFOmEv/gRUE4rKjMCUCBEmiMpM8hAHuD+ReokH9C1xyZGa4zJuMNHE
         RvM+P+I8aYvp45VHSr4udcQOvCBgNdJumGNOSvHmF5Yr8YNsuZk3gBZxZfBnlr/Xs85O
         iT/Cwbto4RoClSl5BF2Vn21SDM8BiVPDTwgB/VOrWAUDfeJXizuVjR54WD84EQqptzTb
         EoIA==
X-Gm-Message-State: APf1xPDgwjIvOrmHvWL3AQBsoYvSdm2iLGAenz2X/idCavFf0EvIMJxZ
        eHcD9/on1Dl8ZR2EnhRQcfwPPA==
X-Google-Smtp-Source: AH8x224isHodcN5t+9rU7tpVBncrSb/QFdeJGc+VbyibXp35D9UgDKdCDFoG3T4GzNW622Gy7XLGmw==
X-Received: by 2002:a17:902:380c:: with SMTP id l12-v6mr2183273plc.8.1518174375653;
        Fri, 09 Feb 2018 03:06:15 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id p9sm4818337pgs.35.2018.02.09.03.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:06:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:06:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 41/42] completion: use __gitcomp_builtin in _git_worktree
Date:   Fri,  9 Feb 2018 18:02:20 +0700
Message-Id: <20180209110221.27224-42-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options for "worktree add" are:

--checkout
--guess-remote
--lock
--track

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c                     | 2 +-
 contrib/completion/git-completion.bash | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4d3422f62e..76dc6b8cb5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -367,7 +367,7 @@ static int add(int ac, const char **av, const char *prefix)
 	struct option options[] = {
 		OPT__FORCE(&opts.force,
 			   N_("checkout <branch> even if already checked out in other worktree"),
-			   0),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e76b2f0356..0ddf40063b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3021,16 +3021,16 @@ _git_worktree ()
 	else
 		case "$subcommand,$cur" in
 		add,--*)
-			__gitcomp "--detach"
+			__gitcomp_builtin worktree_add
 			;;
 		list,--*)
-			__gitcomp "--porcelain"
+			__gitcomp_builtin worktree_list
 			;;
 		lock,--*)
-			__gitcomp "--reason"
+			__gitcomp_builtin worktree_lock
 			;;
 		prune,--*)
-			__gitcomp "--dry-run --expire --verbose"
+			__gitcomp_builtin worktree_prune
 			;;
 		*)
 			;;
-- 
2.16.1.207.gedba492059

