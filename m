Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4083CC43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiGWBxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiGWBx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EED274DC2
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d13so984392wrn.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FbrA92W8T1ED0spel/y6I4Ue4W9deZkR+aTEQG8Dehg=;
        b=E9Fe3g9wjoO/7VQ0VJfWmkGfI2abt4cH7IYrZf5TC+dBD3UOFdgY0kVrChA/1ZLok7
         ECch92JXq5LHwPN2msg0VzMlp6+Kf33QbbmL9l6AG19nmyOUwIvVnL0pp7BI2GoHBf09
         2Zcr6FjbbEGR//ocV/zRI84sbvLE9BiYaBQr4gKicyFBizekdg3DJRt8+Uhafv1AiwEb
         iGw95mY299oU8O+Loczuyf+z3tRxj/WHz7qysvgkzhfEdt/a+w76VycKyUPqRpvZyiVp
         /Lo4/loVnxljXk9HePOZCGec3xYmQpQ00XIYi8IiCnFXz1/fTU1PvufGyPL2yLflvU+E
         PjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FbrA92W8T1ED0spel/y6I4Ue4W9deZkR+aTEQG8Dehg=;
        b=ZEaHI3Z1eYhmWEL17wkWgXzPxykQ5qT71kbB/lgu3aZtC7/m4wdqMbSnkM3eO4F8hQ
         SuRGiUNFHbN2JHL0jYQDW1Fx2WnV235DV+qnI+jTLsDCMWUjtL8dZZxhqhwTCQiLUETZ
         VwgiXr3dk/PBP0XQawuHGGifiQ/R+OhQOsDsTdGR1qmsr9Z0bJxtXScnJGkmiHDYFowe
         le8ffcMYksNv7QvhxkyLU6NZY75nB0TyJPsaynfKIjlv5C0jF3Xt4n0UAjA+4+fU1LmE
         fmc0HKRKSYoT4JsYAgk6GlpBrSgwwkp7Bge0vVPD8AbTbP/H+r2hAvttHCRhHigdTvRr
         Yr3A==
X-Gm-Message-State: AJIora9dxvMG6Lc4KswGccGqRE4XRoMHKGgMXXpYfEVEbUTUssbeugtc
        4Q1mbv1Xb+m/hDdcswqfU9RSb7mpl98=
X-Google-Smtp-Source: AGRyM1vf1NxJPkumDEqWCdrQ7raC6WHQc6c5XR3HROx/k+C4iymtGmusanexyWM65srnvNOxJNap0w==
X-Received: by 2002:a05:6000:60a:b0:21d:9451:e91 with SMTP id bn10-20020a056000060a00b0021d94510e91mr1551584wrb.73.1658541203883;
        Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m126-20020a1ca384000000b003a03e63e428sm11650701wme.36.2022.07.22.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:23 -0700 (PDT)
Message-Id: <c5755271cf1e35c818647cfc75ce8f67c0b777ac.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:14 +0000
Subject: [PATCH v5 4/8] merge: do not abort early if one strategy fails to
 handle the merge
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

builtin/merge is setup to allow multiple strategies to be specified,
and it will find the "best" result and use it.  This is defeated if
some of the merge strategies abort early when they cannot handle the
merge.  Fix the logic that calls recursive and ort to not do such an
early abort, but instead return "2" or "unhandled" so that the next
strategy can try to handle the merge.

Coming up with a testcase for this is somewhat difficult, since
recursive and ort both handle nearly any two-headed merge (there is
a separate code path that checks for non-two-headed merges and
already returns "2" for them).  So use a somewhat synthetic testcase
of having the index not match HEAD before the merge starts, since all
merge strategies will abort for that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          |  6 ++++--
 t/t6402-merge-rename.sh                  |  2 +-
 t/t6424-merge-unrelated-index-changes.sh | 16 ++++++++++++++++
 t/t6439-merge-co-error-msgs.sh           |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b43876f68e4..c120ad619c4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -754,8 +754,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		else
 			clean = merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
-		if (clean < 0)
-			exit(128);
+		if (clean < 0) {
+			rollback_lock_file(&lock);
+			return 2;
+		}
 		if (write_locked_index(&the_index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 3a32b1a45cf..772238e582c 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -210,7 +210,7 @@ test_expect_success 'updated working tree file should prevent the merge' '
 	echo >>M one line addition &&
 	cat M >M.saved &&
 	git update-index M &&
-	test_expect_code 128 git pull --no-rebase . yellow &&
+	test_expect_code 2 git pull --no-rebase . yellow &&
 	test_cmp M M.saved &&
 	rm -f M.saved
 '
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 187c761ad84..615061c7af4 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -275,4 +275,20 @@ test_expect_success 'subtree' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'with multiple strategies, recursive or ort failure do not early abort' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	test_seq 0 10 >a &&
+	git add a &&
+
+	sane_unset GIT_TEST_MERGE_ALGORITHM &&
+	test_must_fail git merge -s recursive -s ort -s octopus C^0 >output 2>&1 &&
+
+	grep "Trying merge strategy recursive..." output &&
+	grep "Trying merge strategy ort..." output &&
+	grep "Trying merge strategy octopus..." output &&
+	grep "No merge strategy handled the merge." output
+'
+
 test_done
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 5bfb027099a..52cf0c87690 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -47,6 +47,7 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge branch 2>out2
 	) &&
+	echo "Merge with strategy ${GIT_TEST_MERGE_ALGORITHM:-ort} failed." >>expect &&
 	test_cmp out2 expect &&
 	git reset --hard HEAD^
 '
-- 
gitgitgadget

