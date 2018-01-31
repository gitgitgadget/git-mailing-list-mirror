Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77211F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753809AbeAaLIP (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:15 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42737 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbeAaLIN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:13 -0500
Received: by mail-pf0-f196.google.com with SMTP id b25so12236019pfd.9
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6UK+VLRLOw7h9cECxOWvbNkNsFRbFXWqj//oNY/+oc=;
        b=rElKmllj1ojsYA+daBNxvxKv2525X4Eol4NC0IfXRlvCxG0frmTHlTvBcYVrqhsBHV
         BYz9ENCZsqOnEXvvFOfyhmk+yIYUwoULxKRhwJUUir2/Iibu4cJRkaUJDGa9ECjfBtJx
         q9lgGDCMlXNt6WHa+EdkigKqSFj/gfR2DSzVyLJi01FSgyC3LW4GHxsmcipEgQ4aWkv6
         Ng2Uj1UW4BtI1wBZj7rEFAwLnHOY6sRmUz4TQwmSRO8pDG/6eRbw2UhppDXJtsg4M6BO
         6lD/rWPCvcY6uH13TlugV7OpD7lwV+R66yuUR1kGimgnh5f8KwLy4AnFtEw58Q+IVKU8
         9Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6UK+VLRLOw7h9cECxOWvbNkNsFRbFXWqj//oNY/+oc=;
        b=OYAjwjlBQCeVt58l2WxZdXseeaSiEFcdp0RRW7/uy7KjIM5mzik8g3SOD31pIKd52W
         eRR5XaTVJFevmtrl3DUl/5G2ByKA2Bm8XOYxTMHi+LcRGPNx7OS2tr05HvWH1PDQ6KAs
         9eVG2QDDNXzcZfG3aiKWrK9TpRUZmNecA5H4dEV1Q5aRo8JNfi4Y/a3t62iAW8gwWftX
         GAyGvpq6BD7C04QZxiB7U2fhdUw5XHcsC8WUrqHaR3CkFKDrxqOfoRP1jeb6ylK78wsD
         sAoX2mbTcLmoXSMhoUUoRFrkDYg96jOsjHnpoTeYQTpcwJPrAqtaXLD/yZkabQgYYWtY
         7yjQ==
X-Gm-Message-State: AKwxytcQUJfReRzk5weGIWBSgCTEVadCnm6RlcpqS5P1XP/Y1dUXyrKP
        vz4QbywqXhScaSUeKHXxgRX9xw==
X-Google-Smtp-Source: AH8x227Bvl4P3wDJIgFJwxsK7keXlvkqHZSwktaBBc2TqoWQ2a7f0FciC89RUSCDZDSQLamDuEgT8g==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31-v6mr27429170plz.346.1517396892618;
        Wed, 31 Jan 2018 03:08:12 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id x124sm38530895pfx.105.2018.01.31.03.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 30/41] completion: use __gitcomp_builtin in _git_pull
Date:   Wed, 31 Jan 2018 18:05:36 +0700
Message-Id: <20180131110547.20577-31-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
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
index 14af9457af..225507b751 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1434,12 +1434,6 @@ _git_difftool ()
 
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
@@ -1740,14 +1734,6 @@ _git_log ()
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
@@ -1873,12 +1859,11 @@ _git_pull ()
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
2.16.1.205.g271f633410

