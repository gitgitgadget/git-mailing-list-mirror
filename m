Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD236C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiGWBxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiGWBxb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401973928
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d8so8618319wrp.6
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7kMtOVKh6kLLyGhhgjM8QPcFrZkS6oUGXET9DoaLiTM=;
        b=H4T9uuubyqmsPgRCvim0fc/+YPqqMhkyyl0JtIRuadzETxw6s8g9JzYaFEpjmuavZ7
         p5G5iiRk5MM6sXnHF7orRRMkvdupd60h28lxuetd6bYxXCDZrbjF9gdU22oFVbVABK0v
         27n3GfjAgJHfMWEZ6tHcataMJ+nXATEC6eV+l00wBxqd88rRObZl56cDTlcX95O4kv/o
         vN/fCtfPe38aOa+tONZeDLRGnNx5hbgBuZl7a5jX7IIkMfOlfCxEoSl9nCZyAvGtwSUU
         4dUZjCbMvUOk6lBszWL21QbDkOQBjs8dNGiyd6vIz2iI2GAkAC9Eowe0f29+maoSEUWH
         mQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7kMtOVKh6kLLyGhhgjM8QPcFrZkS6oUGXET9DoaLiTM=;
        b=q6MGO+1EoiCArC37o1G6ZqbFCOCWylzFAJHlxYDheori6AwrJmFjM+WtXDZHBE7nmm
         zzCDrrQJ67n9CvuVXoHcQkefnRVedoZgMLXRsx5nz/lxxNueGrUCZ56Gb64T1MF/XaWo
         5tSYpkolfiyGMj8OvfxXH5g/DygHAZzSAXwZcglu6IMqSGLKYPI+cR3L/dsZX7xodtRj
         19jScZtise7QHE1O8SGvtQ4wYLi3GSkFZ02mQEPKf+7IlvxQRkr0AvaOge6eQrJDri0w
         TeQx+Be1Dv5HLUJN0VPhon5z/OwyniZz+UTy1Ocayly/Jg43qfjMir42aV+YgSeEoKEp
         /TkQ==
X-Gm-Message-State: AJIora9wzLQdVohDob8PTLwYyhUc19HqYGx0ZmzHlW3AYIEGAK9gzTYC
        1f3tmiAAN+o9FhsTbnBUzTrywmX95ns=
X-Google-Smtp-Source: AGRyM1vOk3hxl2JtVwslZiIl30wyp8AldsybycRjZe4kXqY5QtRTk8hLoHi1ytpdDQtFOFhDinSekw==
X-Received: by 2002:a5d:598e:0:b0:21e:7348:69bf with SMTP id n14-20020a5d598e000000b0021e734869bfmr230544wri.157.1658541207548;
        Fri, 22 Jul 2022 18:53:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c304b00b003a320b6d5eesm9494872wmh.15.2022.07.22.18.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:27 -0700 (PDT)
Message-Id: <954dec526a2f6df591f84c4a866d61e4bccd8782.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:18 +0000
Subject: [PATCH v5 8/8] merge: do not exit restore_state() prematurely
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, if the user:

* Had no local changes before starting the merge
* A merge strategy makes changes to the working tree/index but returns
  with exit status 2

Then we'd call restore_state() to clean up the changes and either let
the next merge strategy run (if there is one), or exit telling the user
that no merge strategy could handle the merge.  Unfortunately,
restore_state() did not clean up the changes as expected; that function
was a no-op if the stash was a null, and the stash would be null if
there were no local changes before starting the merge.  So, instead of
"Rewinding the tree to pristine..." as the code claimed, restore_state()
would leave garbage around in the index and working tree (possibly
including conflicts) for either the next merge strategy or for the user
after aborting the merge.  And in the case of aborting the merge, the
user would be unable to run "git merge --abort" to get rid of the
unintended leftover conflicts, because the merge control files were not
written as it was presumed that we had restored to a clean state
already.

Fix the main problem by making sure that restore_state() only skips the
stash application if the stash is null rather than skipping the whole
function.

However, there is a secondary problem -- since merge.c forks
subprocesses to do the cleanup, the in-memory index is left out-of-sync.
While there was a refresh_cache(REFRESH_QUIET) call that attempted to
correct that, that function would not handle cases where the previous
merge strategy added conflicted entries.  We need to drop the index and
re-read it to handle such cases.

(Alternatively, we could stop forking subprocesses and instead call some
appropriate function to do the work which would update the in-memory
index automatically.  For now, just do the simple fix.)

Also, add a testcase checking this, one for which the octopus strategy
fails on the first commit it attempts to merge, and thus which it
cannot handle at all and must completely bail on (as per the "exit 2"
code path of commit 98efc8f3d8 ("octopus: allow manual resolve on the
last round.", 2006-01-13)).

Reported-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c        | 10 ++++++----
 t/t7607-merge-state.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100755 t/t7607-merge-state.sh

diff --git a/builtin/merge.c b/builtin/merge.c
index 3c4f415d87e..f7c92c0e64f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -385,11 +385,11 @@ static void restore_state(const struct object_id *head,
 {
 	struct strvec args = STRVEC_INIT;
 
-	if (is_null_oid(stash))
-		return;
-
 	reset_hard(head, 1);
 
+	if (is_null_oid(stash))
+		goto refresh_cache;
+
 	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
 	strvec_push(&args, oid_to_hex(stash));
 
@@ -400,7 +400,9 @@ static void restore_state(const struct object_id *head,
 	run_command_v_opt(args.v, RUN_GIT_CMD);
 	strvec_clear(&args);
 
-	refresh_cache(REFRESH_QUIET);
+refresh_cache:
+	if (discard_cache() < 0 || read_cache() < 0)
+		die(_("could not read index"));
 }
 
 /* This is called when no merge was necessary. */
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
new file mode 100755
index 00000000000..89a62ac53b3
--- /dev/null
+++ b/t/t7607-merge-state.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description="Test that merge state is as expected after failed merge"
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+. ./test-lib.sh
+
+test_expect_success 'Ensure we restore original state if no merge strategy handles it' '
+	test_commit --no-tag "Initial" base base &&
+
+	for b in branch1 branch2 branch3
+	do
+		git checkout -b $b main &&
+		test_commit --no-tag "Change on $b" base $b || return 1
+	done &&
+
+	git checkout branch1 &&
+	# This is a merge that octopus cannot handle.  Note, that it does not
+	# just hit conflicts, it completely fails and says that it cannot
+	# handle this type of merge.
+	test_expect_code 2 git merge branch2 branch3 >output 2>&1 &&
+	grep "fatal: merge program failed" output &&
+	grep "Should not be doing an octopus" output &&
+
+	# Make sure we did not leave stray changes around when no appropriate
+	# merge strategy was found
+	git diff --exit-code --name-status &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
+test_done
-- 
gitgitgadget
