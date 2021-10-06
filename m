Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D0C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 12:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF83A61154
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 12:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbhJFMEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbhJFMEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 08:04:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F4CC061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 05:02:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v25so8082867wra.2
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mblfHdDWp9wjAGuAyJd6renX8xOpwIE1RITHfzY8B3g=;
        b=P3nnIwEtErileYaptXwqYuaB8oUNQVlvQNl6BoLzIqOlHa2fsDTaFfpDuLHzj4GCA9
         3wmv27SIeYeC2+31VgHjeDrVsTjFpdNJ4ZI7EjmevdXTltBPgl2E42n1g0ACg7cx+QoB
         CczNQQQfQzI/FRm7Z2MaVecEylsZvxk1E6DXGSW+2hDDdhJBwchm9J86kM5jArVr/Y5m
         qPCiU+AK2jctXIIVqq2a/GV6JXh0/Z9tYKq60VfQQdAAxk/dTXsZ2nu1/BAyO+DErx2Y
         2pJhwt1a6/vVHfz7ZkDDoYVbEXDMuYueUrWE49CcDOuhgkqjQBgq57YYncxOsAGvAdkA
         HMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mblfHdDWp9wjAGuAyJd6renX8xOpwIE1RITHfzY8B3g=;
        b=uGIGtZmy8iTTMzHjMKS+643o1wQtMq0i23+LXstFeWLf2ytcp1oKO9brHFU46x8+bB
         j8lUGmTR/i8hlRZP8nhZXtIxYwq0uc2IvvjRfDYU29wuJhicJAJwR8PsbJMXIMPa6ym1
         lc54GByc4rNIJ3hFUZ1mwEtY0u95za905M6lBpY4RYGqn7VYWQUm75RGxOYFrJ/ucIlT
         8f96+nW0r0CThkXaIcwsccifbcxz8Ymuu2EtrjwLApgkbAnDkW0tAAhEKhJ9Yn34l2pz
         tq11BpWyTXPc6WHK9KqUbUxfY/txu7PTpwomWtR9jAup8Axw41Xt94sCMUXZFZddMMYA
         eAtg==
X-Gm-Message-State: AOAM531ZqWAMiYufpDAeIrNkCuQaKnjB31anf0or3OpzyvMv9mOpQmla
        lGsy9ikJP7XqmU40Zauv0gT32wua0hI=
X-Google-Smtp-Source: ABdhPJwK1Rx9nWF03QY5tQL8ICTKyRvTKnQDuh4jSfvSvhpHLOntoLu9xR4v8nAET0BJV/uS1tWEGg==
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr17616221wrx.389.1633521773890;
        Wed, 06 Oct 2021 05:02:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm20898670wrh.13.2021.10.06.05.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:02:53 -0700 (PDT)
Message-Id: <pull.1078.v5.git.git.1633521772731.gitgitgadget@gmail.com>
In-Reply-To: <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com>
References: <pull.1078.v4.git.git.1630090303445.gitgitgadget@gmail.com>
From:   "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Oct 2021 12:02:52 +0000
Subject: [PATCH v5] submodule: absorb git dir instead of dying on deinit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mugdha Pattnaik <mugdhapattnaik@gmail.com>,
        mugdha <mugdhapattnaik@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: mugdha <mugdhapattnaik@gmail.com>

Currently, running 'git submodule deinit' on repos where the
submodule's '.git' is a directory, aborts with a message that is not
exactly user friendly. Let's change this to instead warn the user
to rerun the command with '--force'.

This internally calls 'absorb_git_dir_into_superproject()', which
moves the git dir into the superproject and replaces it with
a '.git' file. The rest of the deinit function can operate as it
already does with new-style submodules.

We also edit a test case such that it matches the new behaviour of
deinit.

Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
---
    submodule: absorb git dir instead of dying on deinit
    
    Changes since v4:
    
     * Changed test case from "! test -d" to "test_path_is_missing"
    
    Thanks
    Mugdha

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v5
Pull-Request: https://github.com/git/git/pull/1078

Range-diff vs v4:

 1:  7460fc0e12a = 1:  c39cd681e71 submodule: absorb git dir instead of dying on deinit


 builtin/submodule--helper.c | 28 ++++++++++++++++++----------
 t/t7400-submodule-basic.sh  | 10 +++++-----
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e45..040b26f149d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1539,16 +1539,24 @@ static void deinit_submodule(const char *path, const char *prefix,
 		struct strbuf sb_rm = STRBUF_INIT;
 		const char *format;
 
-		/*
-		 * protect submodules containing a .git directory
-		 * NEEDSWORK: instead of dying, automatically call
-		 * absorbgitdirs and (possibly) warn.
-		 */
-		if (is_directory(sub_git_dir))
-			die(_("Submodule work tree '%s' contains a .git "
-			      "directory (use 'rm -rf' if you really want "
-			      "to remove it including all of its history)"),
-			    displaypath);
+		if (is_directory(sub_git_dir)) {
+			if (!(flags & OPT_FORCE))
+				die(_("Submodule work tree '%s' contains a "
+				      ".git directory.\nUse --force if you want "
+				      "to move its contents to superproject's "
+				      "module directory and convert .git to a file "
+				      "and then proceed with deinit."),
+				    displaypath);
+
+			if (!(flags & OPT_QUIET))
+				warning(_("Submodule work tree '%s' contains a .git "
+					  "directory. This will be replaced with a "
+					  ".git file by using absorbgitdirs."),
+					displaypath);
+
+			absorb_git_dir_into_superproject(displaypath, flags);
+
+		}
 
 		if (!(flags & OPT_FORCE)) {
 			struct child_process cp_rm = CHILD_PROCESS_INIT;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cb1b8e35dbf..3df71478d06 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1182,18 +1182,18 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	rmdir init example2
 '
 
-test_expect_success 'submodule deinit fails when submodule has a .git directory even when forced' '
+test_expect_success 'submodule deinit fails when submodule has a .git directory unless forced' '
 	git submodule update --init &&
 	(
 		cd init &&
 		rm .git &&
-		cp -R ../.git/modules/example .git &&
+		mv ../.git/modules/example .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	test_must_fail git submodule deinit init &&
-	test_must_fail git submodule deinit -f init &&
-	test -d init/.git &&
-	test -n "$(git config --get-regexp "submodule\.example\.")"
+	git submodule deinit -f init &&
+	! test -d init/.git &&
+	test -z "$(git config --get-regexp "submodule\.example\.")"
 '
 
 test_expect_success 'submodule with UTF-8 name' '

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
gitgitgadget
