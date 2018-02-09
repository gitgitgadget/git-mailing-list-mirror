Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4DD1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeBILDU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:20 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40700 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBILDT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:19 -0500
Received: by mail-pg0-f66.google.com with SMTP id g2so3396367pgn.7
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+lWmgNIZ92yFfhdopjs9Hwnt+4f5/2cS2/U/5zoc0M=;
        b=E+GXIbuo4jiDJ7CM10UGLMlz9NcHbdS7f8AzLxqrPKGhrf1AqB+GGwkb+E5byhp/q9
         K0AiXLCzBvAmfyifVw9yCGfKPahEV+0ZQCMoENIcjziawQnBFBVR4plLrLXw674YFKFw
         1ZZdoXLm9BWLCoRhFCfODlVJ59MBeI3Oo8Uxpb8NMVy3ZTnGT2s7WfglEm+vo8E954fr
         hmDEQZ2AGYWOqcUM7rLaeWuMODkk5MkKT87FNzndB6SSJjrtWf4W5EGCsz6FgkBqmChw
         7KEMKcBPwCuAf7zIc7v8/hgxjiYHKHi1wYjiHJGgI8lXIxotMBmWKznKmtXHw22nad11
         aX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+lWmgNIZ92yFfhdopjs9Hwnt+4f5/2cS2/U/5zoc0M=;
        b=BBOa05bT8VVE2Qwei5vrnwEcOSlL+XsIUff9B9IebcL/420hpjfQfW6wNhJzHX9ajT
         DieS4Zf4UsQTbglekCDTTMpYOawZ6fM4D0BFVrU8PKDf45uOebAD2wSpGesneCZ95BKv
         WlzPNm7HdsttXFsKQ5ItGQTeB7+Px0DbifMqH9pRXyUd2jcyet5v8OaQGWioEIHz60Rs
         U7dtWm2lTZVrVhOtRTnxT8SsyGvITFwX/Ot4/DaY1wXtjImVZ2d1Tlcghky6UyLF00Id
         cEX9EaWyufNQPfLIPNjTlNBVa4y7JturX2Khg4C1y6X4cdtPG338f7VGrm5eqbt25RGh
         pUDQ==
X-Gm-Message-State: APf1xPDdZfo7vRD5a+X6EVVhw0IPReSbNuzAND3NIDA1Wamctke3A8vZ
        InLfJH10lc2lGx2DzB5Xqqm0oA==
X-Google-Smtp-Source: AH8x224P0d80ETkdMxHuT76XyTDEmFzZlQJcSVv/htrniItnPq1k/YRlGcA/XfYCHNgd1LRDrx8Xrw==
X-Received: by 10.101.100.208 with SMTP id t16mr2073719pgv.19.1518174198727;
        Fri, 09 Feb 2018 03:03:18 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l19sm5051647pgn.50.2018.02.09.03.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 08/42] completion: use __gitcomp_builtin in _git_branch
Date:   Fri,  9 Feb 2018 18:01:47 +0700
Message-Id: <20180209110221.27224-9-pclouds@gmail.com>
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

The new completable options are:

--all
--create-reflog
--format=
--ignore-case
--quiet

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/branch.c                       | 2 +-
 contrib/completion/git-completion.bash | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b5b62c08ba..6d0cea9d4b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -615,7 +615,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), 0),
+		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2fd3fc999e..d926518fb7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1220,12 +1220,8 @@ _git_branch ()
 		__git_complete_refs --cur="${cur##--set-upstream-to=}"
 		;;
 	--*)
-		__gitcomp "
-			--color --no-color --verbose --abbrev= --no-abbrev
-			--track --no-track --contains --no-contains --merged --no-merged
-			--set-upstream-to= --edit-description --list
-			--unset-upstream --delete --move --copy --remotes
-			--column --no-column --sort= --points-at
+		__gitcomp_builtin branch "--no-color --no-abbrev
+			--no-track --no-column
 			"
 		;;
 	*)
-- 
2.16.1.207.gedba492059

