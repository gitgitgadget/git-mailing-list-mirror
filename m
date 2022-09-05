Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF312C6FA83
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 14:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiIEOei (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbiIEOed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 10:34:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBAEC1E
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 07:34:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j26so5385868wms.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=vV5S/ISRb5eXv5RPaqMYFKAAU3MRogQgWL7wmHhKSvs=;
        b=VPlpRyBfXJABCP5uAGjdrS9V4av0jDhupZEAIV9jytI/6F4BqXZ/AtPlU56WfQA90Z
         /fnvzlenzf8HudvWM/6mq6ZI8kdV0vB/Jm/8nPwKyomKjfzZm1OWQGfDpxDPXnZ06JvD
         cuj+c8YnD6bv6zgiBuQ2JNGqtD+IW9mpWGe2wGXbTLVsxq1wH6ha72yeoxy8wxW4sCMw
         jP/orVmnugfYu/a6lfQi2QPoXO33e1lJtgXeZtljodBPASZEBJUK3owAnPAUagDjeUx9
         wKNfcOOkY23gQA9vjnxILim4gIO1xYqt66B28CIGdz1A7alOg8ZZ/F1DOmBy2CWvVtQJ
         CaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vV5S/ISRb5eXv5RPaqMYFKAAU3MRogQgWL7wmHhKSvs=;
        b=aq3G9J8RV96SmfjAiVCvTyhSmCxCVsOdP676iaF77sLFx5AlciZ1/L25Ga+AIxFTN7
         nbOZ8jE3iVy/mwp+z+wk5k7q2fmtKdbH1zWRL33LyeevJVob7EhAi9bM+ko0K1aXFPgj
         MgTcmSWEfJd65UVZd5GjiD/OQWtLw/r6UH5hz/qV1H8K9i6FzJZun/WJgTrZBrW3EvR2
         msBaNtJhDOVRMOIiGJYn1MVvc56ixvMe4GvKn5yubZ48sfzKhC+eG2OBQV0r1PfGouC8
         J/1pVf6Hm9QkyeGPBmiZheirVwiZd3krYRK6vyXEZLa7XuyUxKsbEFUJReRkYbFDGy8c
         dn5Q==
X-Gm-Message-State: ACgBeo24JWpaw0Wa/f3hcuZt111LgQ0ZXKZYDq87HLBfjDeQfarZxtpK
        UATwX8rKRaS9yAhpKn+qpK+mD09WDEo=
X-Google-Smtp-Source: AA6agR5X/xv2zwJfCrqO83fcjdyLL0MwOAGxtvx0R23HRwphIz0cTTNxZ+WV/uyeIZwmNRjQ0mxfoA==
X-Received: by 2002:a05:600c:582:b0:3a5:4f7b:3146 with SMTP id o2-20020a05600c058200b003a54f7b3146mr11051759wmd.152.1662388462482;
        Mon, 05 Sep 2022 07:34:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b003a61306d79dsm13006054wmr.41.2022.09.05.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:34:22 -0700 (PDT)
Message-Id: <321854e118c1d0553e3c9efb67851d5763a364fc.1662388460.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Rub=C3=A9n=20Justo?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 05 Sep 2022 14:34:20 +0000
Subject: [PATCH 2/2] branch: support for at-refs like @{-1}
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>

branch command with --edit-description, --set-upstream-to and
--unset-upstream options expects a branch name. A branch can be
specified using at-refs like @{-1}, so those references need to
be resolved.

We can modify the description of the previously checked out branch
with:

$ git branch --edit--description @{-1}

We can modify the upstream of the previously checked out branch
with:

$ git branch --set-upstream-to upstream @{-1}
$ git branch --unset-upstream @{-1}

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c                      | 32 +++++++++++++++++++-----
 t/t3204-branch-name-interpretation.sh | 36 +++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5229cb796f8..df620bee748 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,14 +791,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
 		int ret = 0;
 
 		if (!argc) {
 			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
-		} else if (argc == 1)
-			branch_name = argv[0];
+		} else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch_name = buf.buf;
+		}
 		else
 			die(_("cannot edit description of more than one branch"));
 
@@ -814,6 +817,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			ret = edit_branch_description(branch_name);
 
 		strbuf_release(&branch_ref);
+		strbuf_release(&buf);
 		return ret;
 	} else if (copy) {
 		if (!argc)
@@ -834,11 +838,19 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else
 			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
+		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		}
+		else
 			die(_("too many arguments to set new upstream"));
 
+
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not set upstream of HEAD to %s when "
@@ -853,11 +865,18 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
 					quiet);
+		strbuf_release(&buf);
 	} else if (unset_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
 		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		}
+		else
 			die(_("too many arguments to unset upstream"));
 
 		if (!branch) {
@@ -870,6 +889,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch_has_merge_config(branch))
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
+		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 993a6b5eff7..853315ec20a 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -133,4 +133,40 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
 	expect_branch HEAD one
 '
 
+test_expect_success 'edit-description via @{-1}' '
+	git checkout main &&
+	git checkout - &&
+	write_script editor <<-\EOF &&
+		echo "Branch description" >"$1"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+		write_script editor <<-\EOF &&
+		git stripspace -s <"$1" >"EDITOR_OUTPUT"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+	echo "Branch description" >expect &&
+	test_cmp expect EDITOR_OUTPUT
+'
+
+test_expect_success 'modify branch upstream via "@{-1}@{upstream}"' "
+	cat >expect <<-\EOF &&
+	warning: not setting branch 'upstream-branch' as its own upstream
+	EOF
+	git branch upstream-branch &&
+	git checkout -b upstream-other -t upstream-branch &&
+	git checkout - &&
+	git branch --set-upstream-to upstream-branch @{-1}@{upstream} 2>actual &&
+	test_cmp expect actual
+"
+
+test_expect_success 'unset branch upstream via "@{-1}"' "
+	test "$(git config branch.upstream-other.remote)" = "." &&
+	test "$(git config branch.upstream-other.merge)" = "refs/heads/upstream-branch" &&
+	git checkout upstream-other &&
+	git checkout - &&
+	git branch --unset-upstream @{-1} &&
+	test_must_fail git config branch.upstream-other.remote &&
+	test_must_fail git config branch.upstream-other.merge
+"
+
 test_done
-- 
gitgitgadget
