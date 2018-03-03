Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA751F576
	for <e@80x24.org>; Sat,  3 Mar 2018 09:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCCJXc (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 04:23:32 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37945 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeCCJXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 04:23:31 -0500
Received: by mail-pg0-f66.google.com with SMTP id l24so4775393pgc.5
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 01:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UMErGo8xVCeeh30NhLakF3DkswrZqYTT6qYDDRJ9vE=;
        b=sD4DLUsIgPRk6KyWQ4W82YHZSYXv4fSgrDmsh2Ik2mWD5Judtc0s6Nb9UxuS0DyvNM
         ZsPKJzcD73TrcYmZEPJm8ujxFaTnloif7e1f64N2KShZ+q6RN7voCIWC2stDLOLRZHEc
         0For8FuPDGR3hn+k6H7tse2acAQhSA33rHgBQp8K9ZiyBRTjLq/JVch51pt5BRbBeLH4
         nNM4HeYkoosa9Lv0kE7TIVatLB9RURP0Agzr/ZUAahI7c33mGbt3je5Lg9bd1rVdjqeH
         MFMmS8BKV8jdP9DjIqY7TUolte91BWlbz3KIrQ7T9x9s4tc4BplHAmlUR53MNBnqxRsd
         AJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UMErGo8xVCeeh30NhLakF3DkswrZqYTT6qYDDRJ9vE=;
        b=okQh5xQU08/+anBmw9ZUX3pfqAyDsWMcxCZNuv3aFmUjb77o9kwsjI1+FUb+vEyB8c
         LOnPbxxhT0OLvNwuwAai+j0oZTGdbaweM2uQLDOT875XIDr3OV6lzNWtlamP6TmOyat7
         mNUAHqywfoeNLQB1PB5B5WL2wqjucWtyuFpqEtcMmm32wmTv/JlLU1bjVl1mPpN8BKg6
         V0IBJmVwvFLdOFHldYimcn2YdOZO+Ato9vU890EGStbd3yO6COQiSz8mvRRF4MsG71Qd
         AMNmvmDqk6zdzFKQB3d7j0xjsZV8kxqhDKqIGhZRSFuBcz/wqTGcjiG0zxdZF0mlbaIT
         2QiA==
X-Gm-Message-State: APf1xPDV0L2eztRepVuZmkhJP4yOBA6c+cp/FzGoTp6+f3xhOKF6rMoI
        W0WIgSFbwBzuQ5Nop9fpbeHG6w==
X-Google-Smtp-Source: AG47ELsx1GRCkvsVC4Ozm7/3rgZDojBFxCeYqjj1baa/Q1wpK6hRSk5wz+AXEeKjQHinf/ayFY/jgQ==
X-Received: by 10.101.69.4 with SMTP id n4mr6906088pgq.184.1520069010572;
        Sat, 03 Mar 2018 01:23:30 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id y1sm3129642pge.78.2018.03.03.01.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 01:23:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 16:23:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] completion: simplify _git_notes
Date:   Sat,  3 Mar 2018 16:23:07 +0700
Message-Id: <20180303092307.3796-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303092307.3796-1-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This also adds completion for 'git notes remove' with two options:
--ignore-missing and --stdin.

For some strange reason, 'git notes undefined --<tab>' completes --ref
without even running --git-completion-helper. But since this is an error
case (and we're not doing anything destructive, it's probably ok for now)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c310b241d3..ab80f4e6e8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1836,19 +1836,8 @@ _git_notes ()
 	add,--reedit-message=*|append,--reedit-message=*)
 		__git_complete_refs --cur="${cur#*=}"
 		;;
-	add,--*)
-		__gitcomp_builtin notes_add
-		;;
-	append,--*)
-		__gitcomp_builtin notes_append
-		;;
-	copy,--*)
-		__gitcomp_builtin notes_copy
-		;;
-	prune,--*)
-		__gitcomp_builtin notes_prune
-		;;
-	prune,*)
+	*,--*)
+		__gitcomp_builtin notes_$subcommand
 		;;
 	*)
 		case "$prev" in
-- 
2.16.1.435.g8f24da2e1a

