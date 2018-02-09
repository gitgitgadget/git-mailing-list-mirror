Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82D41F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBILEO (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:14 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45680 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBILEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:14 -0500
Received: by mail-pl0-f67.google.com with SMTP id p5so1312645plo.12
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2TreKTMX5jpNDGWBCv3xaM0sEW/55ZugxiOpoH44kg=;
        b=uGrW3LEl9h1+sgeOhFteGAv3SWVcNF81JgTTTtqJ8rE/CnapEP1Nj3kWEmYnhcjlRy
         WIZp02p/km9WdqW5qhTwiVlOP5mcMLnE1uldMvNrjVGxWRYjpsGF8X5qIDJbmz9CsBVE
         10ks2orLWYmLBsmtFIgT7AeT1Cr0xxj5sUya5ZZ8w47nOdh4Aw++4/LeP2Rs7R3siauQ
         osTnhxfV2O+8SuAfpycKXuTAmmhJAE56Ua7coJQSEFaZVAubNve1d3jOmWxijeaxxG5/
         TED8UPEvY9CgH46m6H6nRdpYvAHAglYJ7WYtSunbzwgeCyOpyUxxibXxPvLua52x4R97
         oW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2TreKTMX5jpNDGWBCv3xaM0sEW/55ZugxiOpoH44kg=;
        b=s7m0Kc6mS+FNlQooStmk8m8vwaLJAYZCU7wG69ScnvcHF2eDDFLlLnsE3ViOh/aBWo
         L9B6FQnl6cv0HAiBPIeSN8a8keye7Qq6GnYHOROHYKKfEPgi1FwVwRCzxbnP5EDlZoKV
         8Ra/l/bTOXlKqOv2ByFR5jRmhfPGYSCPwW9ocXCQgxE1MoPGhJtzWc63vC9SKJxY7zN7
         Rn7iWgRNmNxp06PKlW/c85SfROequHaOb/I+uo/CosVg0NzJ6Mxmj9jN3Jasta4pVgr5
         3TbQcYI/yzNmJtUS3NUev6H7g4/Miy1n7Ao4PCh8JbQJwUhc8K17sOffH+3jezWrfo9P
         2YqQ==
X-Gm-Message-State: APf1xPCRuuMgoa43i2nj0q6fDIMstpXXwVDZrHDRQ6O7H+N8dpxeXDex
        uc/HTAUZqLjNbas44vAZRKJqCg==
X-Google-Smtp-Source: AH8x227GAbeBZCWDIb4/plcA36KMnfePsOPRhifTEHmLpCEntKCpAyw8jhTUEXVqLLLpDeq13d5J1Q==
X-Received: by 2002:a17:902:d68a:: with SMTP id v10-v6mr550645ply.206.1518174253470;
        Fri, 09 Feb 2018 03:04:13 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id a3sm4446248pgw.23.2018.02.09.03.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:04:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:04:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 18/42] completion: use __gitcomp_builtin in _git_fsck
Date:   Fri,  9 Feb 2018 18:01:57 +0700
Message-Id: <20180209110221.27224-19-pclouds@gmail.com>
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

--connectivity-only
--dangling
--progress
--reflogs

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4275307c3d..340e2414ff 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1499,10 +1499,7 @@ _git_fsck ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--tags --root --unreachable --cache --no-reflogs --full
-			--strict --verbose --lost-found --name-objects
-			"
+		__gitcomp_builtin fsck "--no-reflogs"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

