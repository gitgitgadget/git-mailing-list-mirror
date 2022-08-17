Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62664C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 00:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiHQAST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 20:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbiHQASR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 20:18:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BA93B94B
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:18:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z16so14396259wrh.12
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=p0p+a8sT6x7coQdm5amF+7etbTpB4+UKSZIppZYFwfk=;
        b=dyVlYVoEItVxmQy5HBQULzvcRwMhfVyn3cU/95DLPUH98Grm0XlK4FrG+59rgnekCp
         +szP/DFCME86mLRT8bkW321lkmvfOknUYVpcTUtv/3r8WaQFBbgV6nC/8EMc+S6wA5Ju
         d9eCC94X0a/vskxrmORMY7+mX271Hj1/xdyk0zHpI7jJbDUdolr/ayHWm/1/mxSzOft8
         xYirXC4AjJ8eYjMr6/7WKMiIH8c+R3FzDKzRpb5i4Kjw5Gwp1g0rIaYowgUH2gfzmu5n
         kL1Txr4JRQLtWbv025YcrDFblat7noMCLtdGpnaGAaKiRdpx+y36E807U4nFEY9WaXZ4
         PdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=p0p+a8sT6x7coQdm5amF+7etbTpB4+UKSZIppZYFwfk=;
        b=LK/HW8rxyVNzMuEb5eHGsGAmEMdjWi30y3duDc7AqtD+Kib4daHIMTPvYkjNxvHSwx
         fjYg7QkPuCGJnisfSgK7/ZZo8nXFzMdLRBF9Ypd6ZhrKoJUJIiMphylXOPuSb6N5Fo7u
         d8KUdb0FjveYBnOGrX5qdhuDWHvqFpycJFJ0Y4lF76Y7zlcBtzO+cEQU93q7Ulr3k3Tb
         Dield8n1Kl7GLrS+94pp4vAOGeNRjKczyMQ/nBso+LAqakI+m3YZAxm+xXzAjYhGJ7JE
         kIvNK74CyHwrlHIWS88C4+50hcWAuR3frrAuTCQXOr1xxusfk0wSjy+aOYHvt5OqYV5h
         tR3A==
X-Gm-Message-State: ACgBeo2E2dIyI/Zxk7opQa0lOd3p4daaQeOYK0P4FAoLMDC50QnXaIvE
        1no+U2EC3RyzKS1Af1GPncj1TEvwpB8=
X-Google-Smtp-Source: AA6agR6RN594NifSY9gf9oJ6BdFAlOb0wB/hDWOyfLizGSzsrYXWEWT2/692Nd+iYqoE6O/NuxG2mA==
X-Received: by 2002:a05:6000:61a:b0:222:d4e5:ba3f with SMTP id bn26-20020a056000061a00b00222d4e5ba3fmr13491209wrb.71.1660695493680;
        Tue, 16 Aug 2022 17:18:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6da9000000b0022510e8cb82sm4630241wrs.52.2022.08.16.17.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:18:13 -0700 (PDT)
Message-Id: <pull.1302.v3.git.1660695492382.gitgitgadget@gmail.com>
In-Reply-To: <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
References: <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 00:18:12 +0000
Subject: [PATCH v3] git-prompt: show presence of unresolved conflicts at
 command prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

If GIT_PS1_SHOWCONFLICTSTATE is set to "yes", show the word "CONFLICT"
on the command prompt when there are unresolved conflicts.

Example prompt: (main|CONFLICT)

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
    Show 'CONFLICT' indicator at command prompt
    
    This patch adds functionality for bash/zsh to show "CONFLICT" on the
    prompt in cases where there are unresolved conflicts. The feature is
    only enabled after setting an environment variable.
    
    The conflict state is determined by running git ls-files --unmerged. In
    my testing, the performance was very good. It took around 0.01 seconds
    to run git ls-files --unmerged regardless of the number of conflicts, or
    their depth, even on very large projects (Linux kernel). I got similar
    performance running git diff --cached --quiet --diff-filter=U.
    
    ------------------------------------------------------------------------
    
    Changes since v2:
    
     * There is now a single new test focused explicitly on this feature
       instead of making copies of existing tests and modifying them.
    
    Changes since v1:
    
     * This feature is now disabled by default.
     * Created new tests for conflict state (instead of modifying existing
       tests).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1302%2Fjustinrdonnelly%2Fconflict-indicator-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1302/justinrdonnelly/conflict-indicator-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1302

Range-diff vs v2:

 1:  7154d695426 ! 1:  2ea5c403924 git-prompt: show presence of unresolved conflicts at command prompt
     @@ contrib/completion/git-prompt.sh: __git_ps1 ()
       		if [ "${__git_printf_supports_v-}" != yes ]; then
      
       ## t/t9903-bash-prompt.sh ##
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase merge' '
     - 	test_when_finished "git checkout main" &&
     - 	test_must_fail git rebase --merge b1 b2 &&
     - 	test_when_finished "git rebase --abort" &&
     --	__git_ps1 >"$actual" &&
     -+	(
     -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     -+		__git_ps1 >"$actual"
     -+	) &&
     -+	test_cmp expected "$actual"
     -+'
     -+
     -+test_expect_success 'prompt - rebase merge conflict' '
     -+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
     -+	git checkout b2 &&
     -+	test_when_finished "git checkout main" &&
     -+	test_must_fail git rebase --merge b1 b2 &&
     -+	test_when_finished "git rebase --abort" &&
     -+	(
     -+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
     -+		__git_ps1 >"$actual"
     -+	) &&
     - 	test_cmp expected "$actual"
     - '
     - 
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase am' '
     - 	test_when_finished "git checkout main" &&
     - 	test_must_fail git rebase --apply b1 b2 &&
     - 	test_when_finished "git rebase --abort" &&
     --	__git_ps1 >"$actual" &&
     -+	(
     -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     -+		__git_ps1 >"$actual"
     -+	) &&
     -+	test_cmp expected "$actual"
     -+'
     -+
     -+test_expect_success 'prompt - rebase am conflict' '
     -+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
     -+	git checkout b2 &&
     -+	test_when_finished "git checkout main" &&
     -+	test_must_fail git rebase --apply b1 b2 &&
     -+	test_when_finished "git rebase --abort" &&
     -+	(
     -+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
     -+		__git_ps1 >"$actual"
     -+	) &&
     - 	test_cmp expected "$actual"
     - '
     - 
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - merge' '
     - 	test_when_finished "git checkout main" &&
     - 	test_must_fail git merge b2 &&
     - 	test_when_finished "git reset --hard" &&
     --	__git_ps1 >"$actual" &&
     -+	(
     -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     -+		__git_ps1 >"$actual"
     -+	) &&
     -+	test_cmp expected "$actual"
     -+'
     -+
     -+test_expect_success 'prompt - merge conflict' '
     -+	printf " (b1|MERGING|CONFLICT)" >expected &&
     -+	git checkout b1 &&
     -+	test_when_finished "git checkout main" &&
     -+	test_must_fail git merge b2 &&
     -+	test_when_finished "git reset --hard" &&
     -+	(
     -+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
     -+		__git_ps1 >"$actual"
     -+	) &&
     - 	test_cmp expected "$actual"
     - '
     - 
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pick' '
     - 	printf " (main|CHERRY-PICKING)" >expected &&
     - 	test_must_fail git cherry-pick b1 b1^ &&
     - 	test_when_finished "git cherry-pick --abort" &&
     --	__git_ps1 >"$actual" &&
     -+	(
     -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
     -+		__git_ps1 >"$actual"
     -+	) &&
     - 	test_cmp expected "$actual" &&
     - 	git reset --merge &&
     - 	test_must_fail git rev-parse CHERRY_PICK_HEAD &&
     -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pick' '
     +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - hide if pwd ignored - inside gitdir' '
       	test_cmp expected "$actual"
       '
       
     -+test_expect_success 'prompt - cherry-pick conflict' '
     -+	printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
     -+	test_must_fail git cherry-pick b1 b1^ &&
     -+	test_when_finished "git cherry-pick --abort" &&
     ++test_expect_success 'prompt - conflict indicator' '
     ++	printf " (main|CONFLICT)" >expected &&
     ++	echo "stash" >file &&
     ++	git stash &&
     ++	test_when_finished "git stash drop" &&
     ++	echo "commit" >file &&
     ++	git commit -m "commit" file &&
     ++	test_when_finished "git reset --hard HEAD~" &&
     ++	test_must_fail git stash apply &&
      +	(
      +		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
      +		__git_ps1 >"$actual"
     @@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pick' '
      +	test_cmp expected "$actual"
      +'
      +
     - test_expect_success 'prompt - revert' '
     - 	printf " (main|REVERTING)" >expected &&
     - 	test_must_fail git revert b1^ b1 &&
     + test_done


 contrib/completion/git-prompt.sh | 12 +++++++++++-
 t/t9903-bash-prompt.sh           | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1435548e004..57972c2845c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -84,6 +84,10 @@
 # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
 # by setting GIT_PS1_OMITSPARSESTATE.
 #
+# If you would like to see a notification on the prompt when there are
+# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". The
+# prompt will include "|CONFLICT".
+#
 # If you would like to see more information about the identity of
 # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
 # to one of these values:
@@ -508,6 +512,12 @@ __git_ps1 ()
 		r="$r $step/$total"
 	fi
 
+	local conflict="" # state indicator for unresolved conflicts
+	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
+	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
+		conflict="|CONFLICT"
+	fi
+
 	local w=""
 	local i=""
 	local s=""
@@ -572,7 +582,7 @@ __git_ps1 ()
 	fi
 
 	local f="$h$w$i$s$u$p"
-	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 6a30f5719c3..d459fae6551 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -759,4 +759,20 @@ test_expect_success 'prompt - hide if pwd ignored - inside gitdir' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - conflict indicator' '
+	printf " (main|CONFLICT)" >expected &&
+	echo "stash" >file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	echo "commit" >file &&
+	git commit -m "commit" file &&
+	test_when_finished "git reset --hard HEAD~" &&
+	test_must_fail git stash apply &&
+	(
+		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
+		__git_ps1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_done

base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
-- 
gitgitgadget
