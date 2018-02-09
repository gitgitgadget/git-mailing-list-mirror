Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262391F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751070AbeBILFU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:20 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33141 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbeBILFS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:18 -0500
Received: by mail-pl0-f66.google.com with SMTP id t4so1328348plo.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iHe+pzGRghA8CEzQPDgPpzbrX6hFJyC1G/H+TzdZL8=;
        b=GCZXOnGKtLPonjIwM8Dyc9JU0MAtL2i7FeWtvd5hH0pRYVa/T1sBQkX4XMX7HDuyfS
         sSEEgFRREGITkC09FlOO1n9PusvEpdvcGB5O4eBtuXoyeduJnnDrCN/NifVHhwRq9db7
         GncSmTJuznUYOFiYVSFugiMKO3Crw9hnO3Yb9tEygidrut0SrF8VTI5WFtQaUj9RMzv3
         caP+3CrziMZhJpx6Ge2HyOHljgSecovLAfJWNtQaCBwxCdTVzogYWhCNcdsGiPe3Utuj
         7+vFYHidoJw998IbxTFAHGctmAT96WTZ3UDuEXXapUq7SE7rn9TS2g7diwLaoNVXosGW
         BtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iHe+pzGRghA8CEzQPDgPpzbrX6hFJyC1G/H+TzdZL8=;
        b=frEZWtWPccEsDjmosR3sMe6UQY3ueNxwpidz5przHbTQS8oTPTF9l3TsT2WS5Ah/eR
         Mvq5JS8owIK2Y4qWMDE6Dtu47ykPtvGbINwfZmGnkLs5xmtdak5f80TtpH9UWpbvzPGD
         jdsw1u7XjjbvW7TS56l8H4+ysSKf4durqcnUX18weQZjZAtl+IG/38XqhWzQDwr9DzZV
         4D1XzF+TNhEa7vGvlfg5aTV1O2dFQLGo8pEYVMB2x9yRpoLToj/66QgUXLdRzfvjo538
         dNQts17lNKBr+Mbh0FsnJR3jEarl2Nkk3IWCExm+EhKX/WGmbDd/unFJeMDrw08fSJxt
         uf+w==
X-Gm-Message-State: APf1xPD+F+WpIo4T3+4KdgqReYYBCh1gE293UdnSmc6bppZA/TFrnUgR
        7USgyPRZNg9Sbv6ZRuDbZD/NyA==
X-Google-Smtp-Source: AH8x227THBpStDYOpNIsxgp0fHHouseUjWQEXH3aGH7rQwOQCEigV95gBUxLV3hiQwxJUL+LWjb1lg==
X-Received: by 2002:a17:902:526d:: with SMTP id z100-v6mr2236071plh.396.1518174318270;
        Fri, 09 Feb 2018 03:05:18 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 16sm5465984pfq.181.2018.02.09.03.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 30/42] completion: use __gitcomp_builtin in _git_pull
Date:   Fri,  9 Feb 2018 18:02:09 +0700
Message-Id: <20180209110221.27224-31-pclouds@gmail.com>
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

This is really nice. Since pull_options[] already declares all
passthru options to 'merge' or 'fetch', a single

    git pull --git-completion-helper

would provide all completable options (--no- variants are a separate
issue). Dead shell variables can now be deleted.

New completable options are:

--allow-unrelated-histories
--ipv4
--ipv6
--jobs
--refmap=
--signoff
--strategy-option=

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60127daebf..697fca0c4b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1448,12 +1448,6 @@ _git_difftool ()
 
 __git_fetch_recurse_submodules="yes on-demand no"
 
-__git_fetch_options="
-	--quiet --verbose --append --upload-pack --force --keep --depth=
-	--tags --no-tags --all --prune --dry-run --recurse-submodules=
-	--unshallow --update-shallow
-"
-
 _git_fetch ()
 {
 	case "$cur" in
@@ -1754,14 +1748,6 @@ _git_log ()
 	__git_complete_revlist
 }
 
-# Common merge options shared by git-merge(1) and git-pull(1).
-__git_merge_options="
-	--no-commit --no-stat --log --no-log --squash --strategy
-	--commit --stat --no-squash --ff --no-ff --ff-only --edit --no-edit
-	--verify-signatures --no-verify-signatures --gpg-sign
-	--quiet --verbose --progress --no-progress
-"
-
 _git_merge ()
 {
 	__git_complete_strategy && return
@@ -1887,12 +1873,11 @@ _git_pull ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--rebase --no-rebase
-			--autostash --no-autostash
-			$__git_merge_options
-			$__git_fetch_options
-		"
+		__gitcomp_builtin pull "--no-autostash --no-commit --no-edit
+					--no-ff --no-log --no-progress --no-rebase
+					--no-squash --no-stat --no-tags
+					--no-verify-signatures"
+
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

