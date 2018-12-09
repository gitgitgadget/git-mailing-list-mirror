Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA3220A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeLIKpN (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46241 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeLIKpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so7047823ljh.13
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECjWk9Lis3gsZO5a5XqCQhp9qBscr6S4UNQqRqXglQo=;
        b=vFVgCbuaCHwmIhqlvT5LAESJ6F2Aih5a4mqcihQCNMDeJ5lR7hb5Jycr01zM/Xp+Gl
         CjKmtGpN3WwgOGoICvIrApy1s+CVnCxyUPeh1h/DoxWtQk9U9UH8o5xsuFEbSc6FPtfC
         mVPa8T/Er+i5B+Sr7SjYuljBLl3V9W6PO76lLBhGQFaH10zyHcfeS2o3HKR2m9g3kBEg
         4yN//l7OS1g4sIqWJTfeSyhPqDPYWXE2bM6L9DxZYDQX5bzon1LSAo4G8WlE5I8goq8T
         gl3XpBQc8PCCr8hnBaKPQ/i6/OycVb4S5UfIGDj2nGEM0vP6sWQTN2/aoFxXHrb8sVor
         rszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECjWk9Lis3gsZO5a5XqCQhp9qBscr6S4UNQqRqXglQo=;
        b=jP/dR6mA1nrli0TJekP8Lql/4+NCMbezoLBTZeRpCHm1kL9skczVb+c1sCUH2ZcOMo
         f4KHLcmQ8Bcw4CkD2pWsUSl9zKdPawSO536u5IfJy0o8zKWv67K2AeYuukh3qnrrWDSV
         5FpslkJ+zBwqxgpwLpzCfZbzxS188CgesIQRkC510jMtplW6sRu0+OGlWR03MzXgikYu
         cad+w885LSEhd2ZBmSt1X3nuY6jU9esd6bs5wCZqbukSoB/w4HitDTe/sRjcrwMgB9/V
         D9MPh1SbxUW6P+zKiPlNhu7+QGs8z1AzU6rTOPgNCvFnI7WPdkQkDSLGkN8pL++BYaxW
         CVow==
X-Gm-Message-State: AA+aEWaGSdQvwfXUUJ4CHa7vaqWUAC2gTd+JU4/+3g5kHfC2hhgTHZ/F
        VBgSy1MMjgfnw3zWlFpgu4kz0WsE
X-Google-Smtp-Source: AFSGD/VbXN1oEfFlt1J8JqZzy4BrNpuU6yasE+72tboQ/k7E+q+tOaS4hfnmi/jCf8OC8nVr3uYiEQ==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr4790868lja.24.1544352309703;
        Sun, 09 Dec 2018 02:45:09 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:08 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/24] add--interactive: support backup log
Date:   Sun,  9 Dec 2018 11:44:03 +0100
Message-Id: <20181209104419.12639-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git-add--interactive.perl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..730133f57e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -102,28 +102,28 @@ sub colored {
 my %patch_modes = (
 	'stage' => {
 		DIFF => 'diff-files -p',
-		APPLY => sub { apply_patch 'apply --cached', @_; },
+		APPLY => sub { apply_patch 'apply --cached --keep-backup', @_; },
 		APPLY_CHECK => 'apply --cached',
 		FILTER => 'file-only',
 		IS_REVERSE => 0,
 	},
 	'stash' => {
 		DIFF => 'diff-index -p HEAD',
-		APPLY => sub { apply_patch 'apply --cached', @_; },
+		APPLY => sub { apply_patch 'apply --cached --keep-backup', @_; },
 		APPLY_CHECK => 'apply --cached',
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
 	'reset_head' => {
 		DIFF => 'diff-index -p --cached',
-		APPLY => sub { apply_patch 'apply -R --cached', @_; },
+		APPLY => sub { apply_patch 'apply -R --cached --keep-backup', @_; },
 		APPLY_CHECK => 'apply -R --cached',
 		FILTER => 'index-only',
 		IS_REVERSE => 1,
 	},
 	'reset_nothead' => {
 		DIFF => 'diff-index -R -p --cached',
-		APPLY => sub { apply_patch 'apply --cached', @_; },
+		APPLY => sub { apply_patch 'apply --cached --keep-backup', @_; },
 		APPLY_CHECK => 'apply --cached',
 		FILTER => 'index-only',
 		IS_REVERSE => 0,
@@ -628,7 +628,7 @@ sub update_cmd {
 				       HEADER => $status_head, },
 				     @mods);
 	if (@update) {
-		system(qw(git update-index --add --remove --),
+		system(qw(git update-index --add --remove --keep-backup --),
 		       map { $_->{VALUE} } @update);
 		say_n_paths('updated', @update);
 	}
@@ -648,7 +648,7 @@ sub revert_cmd {
 			my @lines = run_cmd_pipe(qw(git ls-tree HEAD --),
 						 map { $_->{VALUE} } @update);
 			my $fh;
-			open $fh, '| git update-index --index-info'
+			open $fh, '| git update-index --keep-backup --index-info'
 			    or die;
 			for (@lines) {
 				print $fh $_;
@@ -673,7 +673,7 @@ sub add_untracked_cmd {
 	my @add = list_and_choose({ PROMPT => __('Add untracked') },
 				  list_untracked());
 	if (@add) {
-		system(qw(git update-index --add --), @add);
+		system(qw(git update-index --keep-backup --add --), @add);
 		say_n_paths('added', @add);
 	} else {
 		print __("No untracked files.\n");
-- 
2.20.0.rc2.486.g9832c05c3d

