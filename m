Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2717C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6E6615E2
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhKSK7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhKSK7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 05:59:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2915C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:56:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w29so17399735wra.12
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIJR1MEO+e9oJMZH+SGNHUf/NlbTGSpMGb6NLTv5oyg=;
        b=VWP/0ZLPA5a8wwdcyKNnZ3L1WriuwshbJAJzE00chg9yRvj/8QCZlj6BDn+uZ9WQvC
         LHc6tdaUXUnSHJCW5YmEvlUawTVsLggIGOoRnrTKDw2U3HiRXTcmYQPkTntmg7MPrR6x
         f4fB/lFilIddsER1wWkXgy/xB3hKAVPNpcQ4ca+DLAwBa5Z9m5KouXBQtKTmgyeThjOm
         9RCb83Wy8BkpmqyZSbka2Hkqf5aQVPglUhpG6b/X6KyL+OfZlBnmTmdzeBhShPC3C/FQ
         STjWwOkLynROvjMFiLYrtNjyKmGqY39+S8mmWuS+jac5BIbdyohFbB4+E1FsLuXox9RX
         5okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIJR1MEO+e9oJMZH+SGNHUf/NlbTGSpMGb6NLTv5oyg=;
        b=XpJI/qOND6b03Jb6y/slLnPT/cwliiriDVnR6clcBNLFh7FtTDTMSByUhhjq0WPiwE
         UMGvp/9N7xqb9njEypUZWLHZ5PGuBqITdj6Wov6bbkKn+NRjSvAf6KZiUEZvIn1JSIhE
         MEDNTHwfhqFoKgpkoM7cZ8T42ZJGHo/p06269/ew9/hD+kxlDQGRKeB+QmRCKTxpCU8g
         dQgcjFsTLpL3shzuu2mS3UahxW2ite/H6Nyv5/P3JTvY4iT3hx/znZWCjtD+MpCQsMC5
         fdfujW4oOXMF7/HDFtg2tB0b0wZuqDnCIhJE9s+RuCEW7mSqp9fpSZnz2sXoZoM9GYN4
         d3QQ==
X-Gm-Message-State: AOAM531IxNiL7mPStukaJga+WYmuFFFumNZQlFWWLFyT9Oj1O7Fxvy1B
        Jr8QWVr6q1lo8JoOJ40mVXAQU5v2a/0=
X-Google-Smtp-Source: ABdhPJy4G6b5bsX9Va3b7/xlyuLTi5W/CZUuNglI4keuUbAn5uDCXqojf5DM0SmDZzndOMjq4POObw==
X-Received: by 2002:a05:6000:1813:: with SMTP id m19mr6089170wrh.51.1637319389898;
        Fri, 19 Nov 2021 02:56:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p27sm2503182wmi.28.2021.11.19.02.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:56:29 -0800 (PST)
Message-Id: <pull.1078.v7.git.git.1637319387717.gitgitgadget@gmail.com>
In-Reply-To: <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com>
References: <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com>
From:   "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 10:56:27 +0000
Subject: [PATCH v7] submodule: absorb git dir instead of dying on deinit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Mugdha Pattnaik <mugdhapattnaik@gmail.com>,
        Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mugdha Pattnaik <mugdhapattnaik@gmail.com>

Currently, running 'git submodule deinit' on repos where the
submodule's '.git' is a directory, aborts with a message that is not
exactly user friendly.

Let's change this to instead warn the user that the .git/ directory
has been absorbed into the superproject.
The rest of the deinit function can operate as it already does with
new-style submodules.

In one test, we used to require "git submodule deinit" to fail even
with the "--force" option when the submodule's .git/ directory is not
absorbed. Adjust it to expect the operation to pass.

Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
---
    submodule: absorb git dir instead of dying on deinit
    
    Changes since v6:
    
     * Edited commit message based on suggestions given.
     * Passed correct arguments to absorb gitdir function; path and recurse
       flag
     * Modified behaviour of deinit such that it absorbs the gitdir even
       when not forced.
    
    Changes since v5:
    
     * Fixed accidental submission of old version
    
    Changes since v4:
    
     * Changed test case from "! test -d" to "test_path_is_missing"
    
    Changes since v3:
    
     * Replaced 1 instance of the word "folder" with "directory"
     * Fixed tab spacing
    
    Changes since v2:
    
     * Replaced all instances of the word "folder" with either "directory"
       or "git dir"
    
    Changes since v1:
    
     * Removed extra indent within the if statements
     * Moved absorb_git_dir_into_superproject() call outside the if
       condition checking for --quiet flag
    
    ------------------------------------------------------------------------
    
    Currently, running 'git submodule deinit' on repos where the submodule's
    '.git' is a directory, aborts with a message that is not exactly user
    friendly.
    
    Let's change this to instead warn the user that the .git/ directory has
    been absorbed into the superproject. The rest of the deinit function can
    operate as it already does with new-style submodules.
    
    In one test, we used to require "git submodule deinit" to fail even with
    the "--force" option when the submodule's .git/ directory is not
    absorbed. Adjust it to expect the operation to pass.
    
    I have changed the 'cp -R ../.git/modules/example .git' to 'mv
    ../.git/modules/example .git' since, at the time of testing, the test
    would fail - deinit now would be moving the '.git' directory into the
    superproject's '.git/modules/' directory, and since this same directory
    already existed before, it was causing errors. So, before running
    deinit, instead of copying the '.git' directory into the submodule, if
    we move it there instead, this functionality can be appropriately
    tested.
    
    Thank you, Mugdha

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v7
Pull-Request: https://github.com/git/git/pull/1078

Range-diff vs v6:

 1:  384a6742388 ! 1:  f37724016f0 submodule: absorb git dir instead of dying on deinit
     @@
       ## Metadata ##
     -Author: mugdha <mugdhapattnaik@gmail.com>
     +Author: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
      
       ## Commit message ##
          submodule: absorb git dir instead of dying on deinit
      
          Currently, running 'git submodule deinit' on repos where the
          submodule's '.git' is a directory, aborts with a message that is not
     -    exactly user friendly. Let's change this to instead warn the user
     -    to rerun the command with '--force'.
     +    exactly user friendly.
      
     -    This internally calls 'absorb_git_dir_into_superproject()', which
     -    moves the git dir into the superproject and replaces it with
     -    a '.git' file. The rest of the deinit function can operate as it
     -    already does with new-style submodules.
     +    Let's change this to instead warn the user that the .git/ directory
     +    has been absorbed into the superproject.
     +    The rest of the deinit function can operate as it already does with
     +    new-style submodules.
      
     -    We also edit a test case such that it matches the new behaviour of
     -    deinit.
     +    In one test, we used to require "git submodule deinit" to fail even
     +    with the "--force" option when the submodule's .git/ directory is not
     +    absorbed. Adjust it to expect the operation to pass.
      
          Suggested-by: Atharva Raykar <raykar.ath@gmail.com>
          Signed-off-by: Mugdha Pattnaik <mugdhapattnaik@gmail.com>
     @@ builtin/submodule--helper.c: static void deinit_submodule(const char *path, cons
      -			      "to remove it including all of its history)"),
      -			    displaypath);
      +		if (is_directory(sub_git_dir)) {
     -+			if (!(flags & OPT_FORCE))
     -+				die(_("Submodule work tree '%s' contains a "
     -+				      ".git directory.\nUse --force if you want "
     -+				      "to move its contents to superproject's "
     -+				      "module directory and convert .git to a file "
     -+				      "and then proceed with deinit."),
     -+				    displaypath);
     -+
      +			if (!(flags & OPT_QUIET))
      +				warning(_("Submodule work tree '%s' contains a .git "
      +					  "directory. This will be replaced with a "
      +					  ".git file by using absorbgitdirs."),
      +					displaypath);
      +
     -+			absorb_git_dir_into_superproject(displaypath, flags);
     ++			absorb_git_dir_into_superproject(path,
     ++							 ABSORB_GITDIR_RECURSE_SUBMODULES);
      +
      +		}
       
     @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule deinit is silent when
       '
       
      -test_expect_success 'submodule deinit fails when submodule has a .git directory even when forced' '
     -+test_expect_success 'submodule deinit fails when submodule has a .git directory unless forced' '
     ++test_expect_success 'submodule deinit absorbs .git directory if .git is a directory' '
       	git submodule update --init &&
       	(
       		cd init &&
     @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule deinit is silent when
      +		mv ../.git/modules/example .git &&
       		GIT_WORK_TREE=. git config --unset core.worktree
       	) &&
     - 	test_must_fail git submodule deinit init &&
     +-	test_must_fail git submodule deinit init &&
      -	test_must_fail git submodule deinit -f init &&
      -	test -d init/.git &&
      -	test -n "$(git config --get-regexp "submodule\.example\.")"
     -+	git submodule deinit -f init &&
     ++	git submodule deinit init &&
      +	test_path_is_missing init/.git &&
      +	test -z "$(git config --get-regexp "submodule\.example\.")"
       '


 builtin/submodule--helper.c | 21 +++++++++++----------
 t/t7400-submodule-basic.sh  | 11 +++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef2776a9e45..bbab562dec6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1539,16 +1539,17 @@ static void deinit_submodule(const char *path, const char *prefix,
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
+			if (!(flags & OPT_QUIET))
+				warning(_("Submodule work tree '%s' contains a .git "
+					  "directory. This will be replaced with a "
+					  ".git file by using absorbgitdirs."),
+					displaypath);
+
+			absorb_git_dir_into_superproject(path,
+							 ABSORB_GITDIR_RECURSE_SUBMODULES);
+
+		}
 
 		if (!(flags & OPT_FORCE)) {
 			struct child_process cp_rm = CHILD_PROCESS_INIT;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cb1b8e35dbf..e7cec2e457a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1182,18 +1182,17 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	rmdir init example2
 '
 
-test_expect_success 'submodule deinit fails when submodule has a .git directory even when forced' '
+test_expect_success 'submodule deinit absorbs .git directory if .git is a directory' '
 	git submodule update --init &&
 	(
 		cd init &&
 		rm .git &&
-		cp -R ../.git/modules/example .git &&
+		mv ../.git/modules/example .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
-	test_must_fail git submodule deinit init &&
-	test_must_fail git submodule deinit -f init &&
-	test -d init/.git &&
-	test -n "$(git config --get-regexp "submodule\.example\.")"
+	git submodule deinit init &&
+	test_path_is_missing init/.git &&
+	test -z "$(git config --get-regexp "submodule\.example\.")"
 '
 
 test_expect_success 'submodule with UTF-8 name' '

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
gitgitgadget
