Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D541FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 11:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933222AbcLILfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 06:35:48 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35662 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbcLILfq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 06:35:46 -0500
Received: by mail-pf0-f195.google.com with SMTP id i88so1102445pfk.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 03:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/s9DhHFGsCOgmtQIabR18uccBduZA9qcRFTW85JCr0=;
        b=D2kiRSvn/FzZ5UlDywUTTiLjElSe4wrU4vlqIlHCVxuQtcSUIxnHfdL2/DhW3kwBwg
         1gAwUcMvGE/9XHzzGap7kQRiLID+FdmoevK7BpDDv3KBZaIbTDYKpNUmgGfc7/4TnF2Q
         ZS2w3bckZbMYG2M8BMtB+kHCevnO2eol0HhG4KIQuB1T+zlbugQG9HoNzFBdbxa4xx/j
         gdM45hSOJHRTZSU3knbgDOSv/wO0+X7GX+w1SBOBil+bJ1JY/NkXAN7Jj0c3qaLsu49X
         06mC2bR1SdBkXr+sDx8U2+5nYnH7sw4ueoHIiseBrYeVJ6cDcUsmz1Ot3gwbPvRaGJFf
         jHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/s9DhHFGsCOgmtQIabR18uccBduZA9qcRFTW85JCr0=;
        b=Ngy4xr+/03EOkm19lITb6ISuDyRJHaS6ssWyHJZn/ObM6SSCSDDFTjoTWzf6xW5veM
         LbM7LohT3dPn+t1RkJe53pEsGrfncGm7y7pJHqx+Jw17Yxjy4SqgukggG/JNjF8pOWFR
         MVTmG59w3OiCvmN1ORU83ceueHJdOyLSArbdBJlhhPwmkIooM0nZxCIsM5vtbVhoNTdQ
         t/Wd3bSiJVpHhKiX4l65nA87SkaKSRfjgRGiYyB/cq1oLn6KzpC9TIrgZXK0rvAm1Rr4
         vUYIL5KGwpPZOwk2sH93ZuVIjjpyvZOPTuVdBHsrSmCqsgwxQDvTQEe1rHJtgXjUodMn
         lC5A==
X-Gm-Message-State: AKaTC02CsaalB8WzAuDlf220xPJGVU/KjjyHZgRnmciibwDgOzM9hqtc2F5n5gIkwlbEIg==
X-Received: by 10.99.113.87 with SMTP id b23mr24881825pgn.41.1481283345902;
        Fri, 09 Dec 2016 03:35:45 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id 65sm57080659pfl.21.2016.12.09.03.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 03:35:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Dec 2016 18:35:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, s-beyer@gmx.net,
        christian.couder@gmail.com, szeder@ira.uka.de,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] rebase: rename --forget to be consistent with sequencer
Date:   Fri,  9 Dec 2016 18:34:26 +0700
Message-Id: <20161209113427.6039-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
References: <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-rebase.txt           | 4 ++--
 contrib/completion/git-completion.bash | 4 ++--
 git-rebase.sh                          | 6 +++---
 t/t3407-rebase-abort.sh                | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e01d78e..f892458 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' --continue | --skip | --abort | --forget | --edit-todo
+'git rebase' --continue | --skip | --abort | --quit | --edit-todo
 
 DESCRIPTION
 -----------
@@ -252,7 +252,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	will be reset to where it was when the rebase operation was
 	started.
 
---forget::
+--quit::
 	Abort the rebase operation but HEAD is not reset back to the
 	original branch. The index and working tree are also left
 	unchanged as a result.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8159f28..2c134f8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1670,10 +1670,10 @@ _git_rebase ()
 {
 	local dir="$(__gitdir)"
 	if [ -f "$dir"/rebase-merge/interactive ]; then
-		__gitcomp "--continue --skip --abort --forget --edit-todo"
+		__gitcomp "--continue --skip --abort --quit --edit-todo"
 		return
 	elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
-		__gitcomp "--continue --skip --abort --forget"
+		__gitcomp "--continue --skip --abort --quit"
 		return
 	fi
 	__git_complete_strategy && return
diff --git a/git-rebase.sh b/git-rebase.sh
index f0de633..c62b178 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,7 +43,7 @@ continue!          continue
 abort!             abort and check out the original branch
 skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
-forget!            abort but keep HEAD where it is
+quit!              abort but keep HEAD where it is
 "
 . git-sh-setup
 . git-sh-i18n
@@ -240,7 +240,7 @@ do
 	--verify)
 		ok_to_skip_pre_rebase=
 		;;
-	--continue|--skip|--abort|--forget|--edit-todo)
+	--continue|--skip|--abort|--quit|--edit-todo)
 		test $total_argc -eq 2 || usage
 		action=${1##--}
 		;;
@@ -403,7 +403,7 @@ abort)
 	finish_rebase
 	exit
 	;;
-forget)
+quit)
 	exec rm -rf "$state_dir"
 	;;
 edit-todo)
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 6bc5e71..910f218 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -99,26 +99,26 @@ testrebase() {
 testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
-test_expect_success 'rebase --forget' '
+test_expect_success 'rebase --quit' '
 	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
 	test_must_fail git rebase master &&
 	test_path_is_dir .git/rebase-apply &&
 	head_before=$(git rev-parse HEAD) &&
-	git rebase --forget &&
+	git rebase --quit &&
 	test $(git rev-parse HEAD) = $head_before &&
 	test ! -d .git/rebase-apply
 '
 
-test_expect_success 'rebase --merge --forget' '
+test_expect_success 'rebase --merge --quit' '
 	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
 	test_must_fail git rebase --merge master &&
 	test_path_is_dir .git/rebase-merge &&
 	head_before=$(git rev-parse HEAD) &&
-	git rebase --forget &&
+	git rebase --quit &&
 	test $(git rev-parse HEAD) = $head_before &&
 	test ! -d .git/rebase-merge
 '
-- 
2.8.2.524.g6ff3d78

