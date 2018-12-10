Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2A520A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 15:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeLJPKu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 10:10:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45629 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeLJPKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 10:10:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so5373872plm.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LTg051jqGhZ6R0241RZgayYlU55OPaR77YN/grYYbxQ=;
        b=qAv+Bgqw/j8X1PfjmLpXOp8VQifDlsmlE2gNxrsY31AwVFmzCDsl8/aMk1r5y8F5tt
         DS+EWcz3J2vv03pdbwzkgVXtaLGFTMKdmen7UyAcpmPHOcmvDOnoYAwrxQcw6FFhfaND
         nLjsDEy3sFthlxWSBGUdG66XfH6ki5TIoP970kSCZLfyjp3bkf0MuFhnliHJY2tLKcBp
         0GlvHFIAj+ujiq2TPW9g+ZbFV6Ln5SB89TS1V5I6sACURGCaVp2LTrC+7UEghch9GRPP
         ImdXNE094lp0eAPMQtZOwLhXp3OM8uHWWn6rJYh/W9SlHaWeaABRt+WMDi8aPc2/B8Zi
         asyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LTg051jqGhZ6R0241RZgayYlU55OPaR77YN/grYYbxQ=;
        b=hwXOBXkxN0gRXjFJwrG+XLJ3QatGA5W+QKnlYf02m2DGwFMCqv+pjiSvkA/ZD9jXzN
         qT6jw0abGUGnT75yC3iv6isEhzolxjLIoMh9mz2o+GoYy95ySGcLSmM4eKBcxcf3QfqM
         jOzPCVS2fAaPUDVR+1E00ermhi6w7tshyjA+F8DLV/p5rNGKeNyhtZSqMIt83yOJAVUU
         aiBOGDualbu/3UMjTWJ23Hey6VTlEs44iVUEbC6JFN6OK6ycCP6uThrRkjQwSvYRzLEp
         tujBmCFKO4iVSSZ43plsKd+AD6iBlOkvLvEY+3y7nLU7urjbYcPw3kclkPGDlxUZOczP
         7p1A==
X-Gm-Message-State: AA+aEWaOMJmGGcktyBQWUucMwdBn6ONG5FbC41FOw1pBsyjbmyf1gdq3
        NcmD9IsT5nZEHg/RBIt52nqKY1bw
X-Google-Smtp-Source: AFSGD/VRhbh42EWiQfKZCpkqAtj7zeLhhKtx48CdmM2Y9A2rhvB8xN+a5S40x2pgqVJlgFr2gEusKg==
X-Received: by 2002:a17:902:a83:: with SMTP id 3mr11656900plp.276.1544454647160;
        Mon, 10 Dec 2018 07:10:47 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 4sm26871260pfq.10.2018.12.10.07.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:10:46 -0800 (PST)
Date:   Mon, 10 Dec 2018 07:10:46 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 15:10:43 GMT
Message-Id: <830191fbfbf95b9d568ba91ddcdd9860173a476a.1544454643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.82.git.gitgitgadget@gmail.com>
References: <pull.82.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] completion: complete <rev> in `git worktree add <path>
 <rev>`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The second non-option argument to `git worktree`'s `add` command is an
optional revision. Let's complete it.

Inspired by https://github.com/git-for-windows/git/pull/1681.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e8ec95c3c..4194b4a2e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2773,6 +2773,11 @@ _git_worktree ()
 		add,--*)
 			__gitcomp_builtin worktree_add
 			;;
+		add,*)
+			if [ $(__git_count_arguments "worktree") -eq 2 ]; then
+				__git_complete_refs
+			fi
+			;;
 		list,--*)
 			__gitcomp_builtin worktree_list
 			;;
-- 
gitgitgadget
