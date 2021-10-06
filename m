Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615BBC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477AE610A2
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 12:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbhJFM0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhJFM0N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 08:26:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F8C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 05:24:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v25so8264549wra.2
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 05:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I5g0zFe0q/uc8BleMWh/y6NfOFEmQSylyoaAY383ZAI=;
        b=VpPNNVbNHpi19smf6o9jXWO16TaLaQUwSyM2fIn/3XQlupxm2EWevpEWJWYkM2GXfb
         QtwWS9vSTT+auD8QNXcB5CbwHD0AdF/PluU8YlszDgaYfG68SdXBpMt3/QLVYpUDCQw0
         QSpb+3eN+X1bPyes3f9Exuh09ape9wmGdLoWU+715J5c8kvRBKuyzTBUtqUpQBR3UunI
         V5FVCxMusJ6iWt7UK2J9iivK39hnpVwiHDB5TeQcjgiOYMBIZ5hkgU1ox1gOn8Xkv6eB
         j5SA2H53a1c4tPl/Sdi2tYi4X0Pa7uFxQatjwv6cuDK6qzaZhnFfRsqSR8bnwTUCoOS2
         0QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I5g0zFe0q/uc8BleMWh/y6NfOFEmQSylyoaAY383ZAI=;
        b=LosNj6JQBvbJMV+eUuo5eH1F8P8eNS5gKhKgC/L2nqvCsFlPBKa2O9g47y+EVHgIxA
         5g4jExVuD3++qSXsRsjZuqswsenDrDM8eW4d4fvrASvH88BTqIJtp4zwmpUJvT2fXUuf
         L947lj+IPzm9qjr2CQaMCwNwWzXN63yDJqj8LUGIJ/7nMOYOj2Ur0MCcrsUf/a47XmQ6
         v8/VbyEA3qxZ6joVgDphi0AHY1bOVFchN0JThJR60v5VMLuqWtqLti7xwSWNss5i9LxZ
         uHOZjqu/G1M7MEl59zWL3rtULMIHMY5yF3w52yLmDnmRNyPiNhjHGcoakO8Yy69UaB1A
         JY7g==
X-Gm-Message-State: AOAM532DQIYtW/I1Vni2r2FLO/E8pcAODksKVK+gDtF2fcAbWCaQyMuG
        Kug2ViJzzJ/z0ke/boywU7B52ib+tRQ=
X-Google-Smtp-Source: ABdhPJzh441zLNoTG+T43srqUbhjgcEuYD8bjhKWXjMVf0CW1mDEqTyFRj6YcEdw/jrjmjysF++PQQ==
X-Received: by 2002:adf:a147:: with SMTP id r7mr28718518wrr.52.1633523059368;
        Wed, 06 Oct 2021 05:24:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16sm5214671wmk.6.2021.10.06.05.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:24:18 -0700 (PDT)
Message-Id: <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com>
In-Reply-To: <pull.1078.v5.git.git.1633521772731.gitgitgadget@gmail.com>
References: <pull.1078.v5.git.git.1633521772731.gitgitgadget@gmail.com>
From:   "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Oct 2021 12:24:17 +0000
Subject: [PATCH v6] submodule: absorb git dir instead of dying on deinit
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
    
    Changes since v5:
    
     * Fixed accidental submission of old version
    
    Changes since v4:
    
     * Changed test case from "! test -d" to "test_path_is_missing"
    
    Thank you,
    Mugdha

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1078%2Fmugdhapattnaik%2Fsubmodule-deinit-absorbgitdirs-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1078/mugdhapattnaik/submodule-deinit-absorbgitdirs-v6
Pull-Request: https://github.com/git/git/pull/1078

Range-diff vs v5:

 1:  c39cd681e71 ! 1:  384a6742388 submodule: absorb git dir instead of dying on deinit
     @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule deinit is silent when
      -	test -d init/.git &&
      -	test -n "$(git config --get-regexp "submodule\.example\.")"
      +	git submodule deinit -f init &&
     -+	! test -d init/.git &&
     ++	test_path_is_missing init/.git &&
      +	test -z "$(git config --get-regexp "submodule\.example\.")"
       '
       


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
index cb1b8e35dbf..f35479ea634 100755
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
+	test_path_is_missing init/.git &&
+	test -z "$(git config --get-regexp "submodule\.example\.")"
 '
 
 test_expect_success 'submodule with UTF-8 name' '

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
gitgitgadget
