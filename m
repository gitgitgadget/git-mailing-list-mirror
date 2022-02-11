Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EA4C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 22:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiBKW0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 17:26:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiBKW0v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 17:26:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBDCD4C
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 14:26:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so6524437wmq.3
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 14:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uH2x+9KR9hGqHkctMWylypgwIVitOqb9VbRo37/EqBs=;
        b=aasDbA5ZpFbi4Jl2iyFd2owP91HOhy+Y8llQlPAXaJnhg4rjnOJZyksYMrO51Fc6Pv
         TGu44rVIYlqUgFFgMKJjxUzqmFznSWE0E6Jn9dY4v0bXFl0JIcHFLVr96VMHmf14Ldok
         GH3Yb0vPMXtncfviJU1iMznBsRXIMiFYlmDowInmSDyE+clqe1KDs99alY/WzacTGZm4
         7QrN0uhDwr89n0G1h0aQuNWHc/1VZQjaNnvQF5/HABeXPFDzfRGPOGU32e+VqSl5K4kn
         bhqY6rPjmUcAXNo2oKIur5lxWh6+BvyElKT9WBYTbTQBsHiDX72wuOVvY+d/JjbyECla
         5bPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uH2x+9KR9hGqHkctMWylypgwIVitOqb9VbRo37/EqBs=;
        b=4rcRnAFeZSrj6CqNkgNrHYH5z0IP2ogAGgu0g+aMlMU53twNk3LM28xKuhApDvWMbn
         R9rCfnkw8IgA+QIz5OIv1LiM25RnWmcGOPHJoKHKaUZbZd6MFC873IjytN7ZKlr7axp+
         QrPIWWgxptdPbavUuw+NsRcoxgmn+gfGu8CE8n28s4j27/Kex1VG/b1kAyHniSZTcWVL
         PgX81BvKbMtxN5YgLBR7Sg0ObwAvb/2iKarEDcbboJg+2T7JiuM6tJKrh8CZaXx1QmyS
         IdLrKqYFKampw3k+tt+jkTQQS27eoRuy1qAnjH0KcRioozfJ8a/qwWyQIhWOdcYfryTd
         WTCg==
X-Gm-Message-State: AOAM5328fpCx3ktFJ2tSopbUx59tfVSzL2PGtxWYiFqsQ8rTgi5hA2/L
        b/NZ0l7GsryN2hhSbMYvbbdg6K2aYqs=
X-Google-Smtp-Source: ABdhPJx2h8jIuyppWFZPJB2+/fm2ZYshizbPUpvTJ0e2mWJZKnhPzp9KXyLrpEXktyz16yj2dyMJXw==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr1951928wmc.71.1644618407030;
        Fri, 11 Feb 2022 14:26:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm23074544wri.82.2022.02.11.14.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 14:26:45 -0800 (PST)
Message-Id: <pull.1137.v2.git.1644618404948.gitgitgadget@gmail.com>
In-Reply-To: <pull.1137.git.1643802721612.gitgitgadget@gmail.com>
References: <pull.1137.git.1643802721612.gitgitgadget@gmail.com>
From:   "Viaceslavus via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 22:26:44 +0000
Subject: [PATCH v2] hard reset safe mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Viaceslavus <vaceslavkozin619@gmail.com>,
        Viacelaus <vaceslavkozin619@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Viacelaus <vaceslavkozin619@gmail.com>

The power of hard reset may frequently be inconvinient for a common user. So
this is an implementation of safe mode for hard reset. It can be switched on
by setting 'reset.safe' config variable to true. When running 'reset --hard'
with 'reset.safe' enabled git will check if there are any staged changes
that may be discarded by this reset. If there is a chance of deleting the
changes, git will ask the user for a confirmation with Yes/No choice.

Signed-off-by: Viacelaus <vaceslavkozin619@gmail.com>
---
    Hard reset safe mode
    
    Preventing unexpected code-deletion with hard reset 'safe mode'.
    
    Considering the recomendations for patch v1 and in order to preserve the
    current robustness of hard reset, I have made the following
    modifications to the original version (which has completely disallowed
    hard reset on unborn branch with staged files):
    
    Changes since v1:
    
     * Described security measures aren't enabled by default. Safe mode can
       be turned on with 'reset.safe' config variable.
     * Replaced the resulting error with Yes/No choice so hard reset on
       unborn branch isn`t impossible now.
     * Detection of staged changes that are going to be deleted by the reset
       isn't limited to unborn-branch state now. Git will warn you and ask
       for a confirmation if there are commits on the branch also.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1137%2FViaceslavus%2Fhard-reset-safety-on-empty-repo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1137/Viaceslavus/hard-reset-safety-on-empty-repo-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1137

Range-diff vs v1:

 1:  13cc01b7de7 ! 1:  e6eec1bfda2 forbid a hard reset before the initial commit
     @@ Metadata
      Author: Viacelaus <vaceslavkozin619@gmail.com>
      
       ## Commit message ##
     -    forbid a hard reset before the initial commit
     +    hard reset safe mode
      
     -    Performing 'git reset --hard' on empty repo with staged files
     -    may have the only one possible result - deleting all staged files.
     -    Such behaviour may be unexpected or even dangerous. With this
     -    commit, when running 'git reset --hard', git will check for the
     -    existence of commits in the repo; in case of absence of such, and
     -    also if there are any files staged, git will die with an error.
     +    The power of hard reset may frequently be inconvinient for a common user. So
     +    this is an implementation of safe mode for hard reset. It can be switched on
     +    by setting 'reset.safe' config variable to true. When running 'reset --hard'
     +    with 'reset.safe' enabled git will check if there are any staged changes
     +    that may be discarded by this reset. If there is a chance of deleting the
     +    changes, git will ask the user for a confirmation with Yes/No choice.
      
          Signed-off-by: Viacelaus <vaceslavkozin619@gmail.com>
      
       ## builtin/reset.c ##
     +@@
     + #include "submodule.h"
     + #include "submodule-config.h"
     + #include "dir.h"
     ++#include "wt-status.h"
     + 
     + #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
     + 
      @@ builtin/reset.c: static void die_if_unmerged_cache(int reset_type)
       
       }
     @@ builtin/reset.c: static void die_if_unmerged_cache(int reset_type)
      +{
      +	return is_branch(refname);
      +}
     ++
     ++static void accept_discarding_changes(void) {
     ++	int answer = getc(stdin);
     ++	printf(_("Some staged changes may be discarded by this reset. Continue? [Y/n]"));
     ++
     ++	if (answer != 'y' && answer != 'Y') {
     ++		printf(_("aborted\n"));
     ++		exit(1);
     ++	}
     ++}
     ++
     ++static void detect_risky_reset(int commits_exist) {
     ++	int cache = read_cache();
     ++	if(!commits_exist) {
     ++		if(cache == 1) {
     ++			accept_discarding_changes();
     ++		}
     ++	}
     ++	else {
     ++		if(has_uncommitted_changes(the_repository, 1)) {
     ++			accept_discarding_changes();
     ++		}
     ++	}
     ++}
      +
       static void parse_args(struct pathspec *pathspec,
       		       const char **argv, const char *prefix,
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
       	}
      +
      +	if (reset_type == HARD) {
     -+		int commits_exist = for_each_fullref_in("refs/heads", check_commit_exists, NULL);
     -+		if(!commits_exist) {
     -+			if(read_cache() == 1)
     -+				die(_("Hard reset isn`t allowed before the first commit."));
     ++		int safe = 0;
     ++		git_config_get_bool("reset.safe", &safe);
     ++		if (safe) {
     ++			int commits_exist = for_each_fullref_in("refs/heads", check_commit_exists, NULL);
     ++			detect_risky_reset(commits_exist);
      +		}
      +	}
      +
     @@ t/t7104-reset-hard.sh: test_expect_success 'reset --hard did not corrupt index o
       
       '
       
     -+test_expect_success 'reset --hard on empty repo without staged changes works fine' '
     -+	git reset --hard
     ++test_expect_success 'reset --hard in safe mode on unborn branch with staged files results in a warning' '
     ++	git config reset.safe on &&
     ++	touch a &&
     ++	git add a &&
     ++	test_must_fail git reset --hard
     ++
      +'
      +
     -+test_expect_success 'reset --hard on empty repo with staged changes results in an error' '
     -+	touch n &&
     -+	git add n &&
     -+	test_must_fail git reet --hard
     ++test_expect_success 'reset --hard in safe mode after a commit without staged changes works fine' '
     ++	git config reset.safe on &&
     ++	touch b &&
     ++	git add b &&
     ++	git commit -m "initial" &&
     ++	git reset --hard
     ++
      +'
      +
     -+test_expect_success 'reset --hard after a commit works fine' '
     -+	touch new &&
     -+	git add new &&
     ++test_expect_success 'reset --hard in safe mode after a commit with staged changes results in a warning' '
     ++	git config reset.safe on &&
     ++	touch c d &&
     ++	git add c &&
      +	git commit -m "initial" &&
     -+	git reset --hard 2> error &&
     -+	test_must_be_empty error
     ++	git add d &&
     ++	test_must_fail git reset --hard
     ++
      +'
      +
       test_done
     -
     - ## t/t7106-reset-unborn-branch.sh ##
     -@@ t/t7106-reset-unborn-branch.sh: test_expect_success 'reset --soft is a no-op' '
     - 	test_cmp expect actual
     - '
     - 
     --test_expect_success 'reset --hard' '
     --	rm .git/index &&
     --	git add a &&
     --	test_when_finished "echo a >a" &&
     --	git reset --hard &&
     --
     --	git ls-files >actual &&
     --	test_must_be_empty actual &&
     --	test_path_is_missing a
     --'
     --
     - test_done


 builtin/reset.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 t/t7104-reset-hard.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index b97745ee94e..997e2adf8d8 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -26,6 +26,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "dir.h"
+#include "wt-status.h"
 
 #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
 
@@ -301,6 +302,35 @@ static void die_if_unmerged_cache(int reset_type)
 
 }
 
+static int check_commit_exists(const char *refname, const struct object_id *oid, int f, void *d)
+{
+	return is_branch(refname);
+}
+
+static void accept_discarding_changes(void) {
+	int answer = getc(stdin);
+	printf(_("Some staged changes may be discarded by this reset. Continue? [Y/n]"));
+
+	if (answer != 'y' && answer != 'Y') {
+		printf(_("aborted\n"));
+		exit(1);
+	}
+}
+
+static void detect_risky_reset(int commits_exist) {
+	int cache = read_cache();
+	if(!commits_exist) {
+		if(cache == 1) {
+			accept_discarding_changes();
+		}
+	}
+	else {
+		if(has_uncommitted_changes(the_repository, 1)) {
+			accept_discarding_changes();
+		}
+	}
+}
+
 static void parse_args(struct pathspec *pathspec,
 		       const char **argv, const char *prefix,
 		       int patch_mode,
@@ -474,6 +504,16 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("Cannot do %s reset with paths."),
 					_(reset_type_names[reset_type]));
 	}
+
+	if (reset_type == HARD) {
+		int safe = 0;
+		git_config_get_bool("reset.safe", &safe);
+		if (safe) {
+			int commits_exist = for_each_fullref_in("refs/heads", check_commit_exists, NULL);
+			detect_risky_reset(commits_exist);
+		}
+	}
+
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index cf9697eba9a..c962c706bed 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -44,4 +44,31 @@ test_expect_success 'reset --hard did not corrupt index or cache-tree' '
 
 '
 
+test_expect_success 'reset --hard in safe mode on unborn branch with staged files results in a warning' '
+	git config reset.safe on &&
+	touch a &&
+	git add a &&
+	test_must_fail git reset --hard
+
+'
+
+test_expect_success 'reset --hard in safe mode after a commit without staged changes works fine' '
+	git config reset.safe on &&
+	touch b &&
+	git add b &&
+	git commit -m "initial" &&
+	git reset --hard
+
+'
+
+test_expect_success 'reset --hard in safe mode after a commit with staged changes results in a warning' '
+	git config reset.safe on &&
+	touch c d &&
+	git add c &&
+	git commit -m "initial" &&
+	git add d &&
+	test_must_fail git reset --hard
+
+'
+
 test_done

base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
-- 
gitgitgadget
