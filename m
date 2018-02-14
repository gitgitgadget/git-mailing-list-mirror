Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5481F576
	for <e@80x24.org>; Wed, 14 Feb 2018 11:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967320AbeBNLQU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 06:16:20 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45219 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967252AbeBNLQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 06:16:19 -0500
Received: by mail-pf0-f194.google.com with SMTP id w83so3791467pfi.12
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 03:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvKPKMAsRVirwoWuIhDA5l/9HALhJVZJfzLEv+oqWjk=;
        b=FUOVFqoJBKvp2Dx6MiMIEgUIp0Blulokt+N1Y6jdjzIyTqnZX6+QpEQM1PXC1zB8eb
         7VyWqOq3eE0fPWTCCHiqvs8QX/F9WF+0qp8v4o2HIYpebdf2qKo6Z7RkLEJE6sr/7zxT
         uTZpNVJSL1YAnRI4yeipjPDOWL9f2ADjBwghZUmsSYOWHmGDiIwwSG3zPKPGIdIaHMXu
         256Ud1GgIiVwMQhcl3OyAxkJ4RiDuG4Ow7Ka0T0iwT5keWajUQwe6ljcfKwz/sXt3p1Z
         gJFFTwQgmtaT4WH3AMdXG+I4sQ6dsGRQG+pSX4SQBe8Oq1dV9UTdj5KuMPRr1DaEasfI
         lMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvKPKMAsRVirwoWuIhDA5l/9HALhJVZJfzLEv+oqWjk=;
        b=lktdJCwqTsGWAGbeMB5qSmK7tlCQxwcHeak00dmjRsOoUlZDF/FranjW7Kx6KP87gZ
         c5fqjLARK8r3dcNS9a7FO4wiJwcFXoJYQcPz/vo1UoYieFw59/3IH1xILUT5DPxwtPiz
         X6Cxj0UMqo/xIN4U8xupA5hkmnGcIopRT8pqWpL2csjTyW775UMnNKHqcdbhmZ4BDzEg
         OkWQOEsEC9Dmv1PbfHgkTypn8jYCSoc31zEqRZW2wRHWd9lQtxb4kBMrpt7H1p3GRmSC
         Fp8Hr2L8asdwCLmITF9wzge7+rRb+GQgcVrWh/lyLxgn/Ux75VqoYT10nnRdOgd+z9fQ
         4lWA==
X-Gm-Message-State: APf1xPDVgEHZpuzkOYeblibsO5E6r27iLwEPxaZbMcGzFhqJEUzdnF/Q
        RGXWD88iWSiIKjYbGzB88ICcWg==
X-Google-Smtp-Source: AH8x226Gdx8DkLIQX62IepNDwJJf6jSojfe7V6AkLCsbcp6oZRhI73Dp57AENYZ0ozQyj1ySN3Aq2A==
X-Received: by 10.99.129.66 with SMTP id t63mr3565314pgd.376.1518606978432;
        Wed, 14 Feb 2018 03:16:18 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id f13sm4048122pgp.59.2018.02.14.03.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 03:16:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 14 Feb 2018 18:16:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] am: support --quit
Date:   Wed, 14 Feb 2018 18:16:06 +0700
Message-Id: <20180214111606.4257-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among the "in progress" commands, only git-am and git-merge do not
support --quit. Support --quit in git-am too.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-am.txt               |  6 +++++-
 builtin/am.c                           | 12 ++++++++++--
 contrib/completion/git-completion.bash |  2 +-
 t/t4150-am.sh                          | 12 ++++++++++++
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 12879e4029..460662e4b9 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort)
+'git am' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
 -----------
@@ -167,6 +167,10 @@ default.   You can use `--no-utf8` to override this.
 --abort::
 	Restore the original branch and abort the patching operation.
 
+--quit::
+	Abort the patching operation but keep HEAD and the index
+	untouched.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index 5bdd2d7578..793c1e2765 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2149,7 +2149,8 @@ enum resume_mode {
 	RESUME_APPLY,
 	RESUME_RESOLVED,
 	RESUME_SKIP,
-	RESUME_ABORT
+	RESUME_ABORT,
+	RESUME_QUIT
 };
 
 static int git_am_config(const char *k, const char *v, void *cb)
@@ -2249,6 +2250,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "abort", &resume,
 			N_("restore the original branch and abort the patching operation."),
 			RESUME_ABORT),
+		OPT_CMDMODE(0, "quit", &resume,
+			N_("abort the patching operation but keep HEAD where it is."),
+			RESUME_QUIT),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2317,7 +2321,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		 * stray directories.
 		 */
 		if (file_exists(state.dir) && !state.rebasing) {
-			if (resume == RESUME_ABORT) {
+			if (resume == RESUME_ABORT || resume == RESUME_QUIT) {
 				am_destroy(&state);
 				am_state_release(&state);
 				return 0;
@@ -2359,6 +2363,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	case RESUME_ABORT:
 		am_abort(&state);
 		break;
+	case RESUME_QUIT:
+		am_rerere_clear();
+		am_destroy(&state);
+		break;
 	default:
 		die("BUG: invalid resume value");
 	}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 88813e9124..c7d5c7af29 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1077,7 +1077,7 @@ _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "--skip --continue --resolved --abort"
+		__gitcomp "--skip --continue --resolved --abort --quit"
 		return
 	fi
 	case "$cur" in
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 73b67b4280..512c754e02 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1045,4 +1045,16 @@ test_expect_success 'am works with multi-line in-body headers' '
 	git cat-file commit HEAD | grep "^$LONG$"
 '
 
+test_expect_success 'am --quit keeps HEAD where it is' '
+	mkdir .git/rebase-apply &&
+	>.git/rebase-apply/last &&
+	>.git/rebase-apply/next &&
+	git rev-parse HEAD^ >.git/ORIG_HEAD &&
+	git rev-parse HEAD >expected &&
+	git am --quit &&
+	test_path_is_missing .git/rebase-apply &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.16.1.435.g8f24da2e1a

