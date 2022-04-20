Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECEC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377364AbiDTJ7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377359AbiDTJ7o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C63298E
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so3298092wml.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vz48/RSPFOJlzJ3tJY1CkSjfI97YkEq4vzNOy46Tkig=;
        b=qgtOvxYNbWDz86XicSu6LrRIReywLTa2Ku5erT/kdJdHn9CqZzAOLDT9F/Od1pfiEJ
         p5E3tSLzfRy181JJzSV95XkmXSfIJIuHqVqMaph56fzUf9mAz4u8RSau1L9g4gQH0T3I
         L5+QL4KrJu0vnR/DOpPYVhrcMEDPpSUGBMA7/Z4o6By5YUPJ9ZsMYY84B53GTJWBiUyl
         hgQ0zJiU5kqr61RjZOpt4prWAuTwzTnJj9J9luo+gKxfyGtmpTZWMGL5zVZvOPjw4VsA
         4UmyZe2BeWGssLWxURYY5U1NJ/o3N57la0gGvcKos16dTu95P7xPh9+Lv/qdZj7o5yr9
         +pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vz48/RSPFOJlzJ3tJY1CkSjfI97YkEq4vzNOy46Tkig=;
        b=naGaq3BWtjYZkfJwKonbXTh2ekLywm/SyFkmBJYO04eqtGQXdSu+0DBODyIcgy2rbP
         rkYnDV04XRL27BoxDKoLGH5AmeN4+84I+yv2F9isZBM3x1dV3uuPRgsKydea78oTrsxb
         oS5reHv3ScWdgMOUtJXT9UoS0DPy7gE0E28xixQoN6b8B0FuqxKrWkGEJhBgEQ46nDqn
         If2XkfbY0DOfnuK40085kqkhu94oG8NSoXX2Nr2iHS4/z3izHC3ivk6j8Ctz0QqVJTAR
         pfrUaaWfhzkha7+W65i01p678rJnPmopqbduxnBXtWECEAIuBdb7qICyUEjRmZdtYcg/
         7lAw==
X-Gm-Message-State: AOAM5320NaqC9lvN19vQcaeGumY5vnGBfGmvKAr9NpHj61kieTqWNzvQ
        aAOqkOQZQg/fgRsc/eareeRHT930eRs=
X-Google-Smtp-Source: ABdhPJyEclfp3cbUS+1PafXH62p/DRVz7R2G/FaGIzSsf+exT8f6BC0W8YD8QQwm4+XmTTCmHGkSmA==
X-Received: by 2002:a05:600c:3493:b0:38e:bbbb:26f7 with SMTP id a19-20020a05600c349300b0038ebbbb26f7mr2808564wmq.114.1650448616607;
        Wed, 20 Apr 2022 02:56:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm21161311wmc.22.2022.04.20.02.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:56:55 -0700 (PDT)
Message-Id: <0904b50a377ce3ac242f9594a635f9ae7cffc687.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:45 +0000
Subject: [PATCH v2 2/8] t3406: rework rebase reflog tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Refactor the tests in preparation for adding more tests in the next
few commits. The reworked tests use the same function for testing both
the "merge" and "apply" backends. The test coverage for the "apply"
backend now includes setting GIT_REFLOG_ACTION.

Note that rebasing the "conflicts" branch does not create any
conflicts yet. A commit to do that will be added in the next commit
and the diff ends up smaller if we have don't rename the branch when
it is added.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3406-rebase-message.sh | 115 +++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 39 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index d17b450e811..5253dd1551d 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -10,10 +10,15 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success 'setup' '
 	test_commit O fileO &&
 	test_commit X fileX &&
+	git branch fast-forward &&
 	test_commit A fileA &&
 	test_commit B fileB &&
 	test_commit Y fileY &&
 
+	git checkout -b conflicts O &&
+	test_commit P &&
+	test_commit Q &&
+
 	git checkout -b topic O &&
 	git cherry-pick A B &&
 	test_commit Z fileZ &&
@@ -79,54 +84,86 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 	test_i18ngrep "Invalid whitespace option" err
 '
 
-test_expect_success 'GIT_REFLOG_ACTION' '
-	git checkout start &&
-	test_commit reflog-onto &&
-	git checkout -b reflog-topic start &&
-	test_commit reflog-to-rebase &&
-
-	git rebase reflog-onto &&
-	git log -g --format=%gs -3 >actual &&
-	cat >expect <<-\EOF &&
-	rebase (finish): returning to refs/heads/reflog-topic
-	rebase (pick): reflog-to-rebase
-	rebase (start): checkout reflog-onto
+write_reflog_expect () {
+	if test $mode = --apply
+	then
+		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
+	else
+		cat
+	fi >expect
+}
+
+test_reflog () {
+	mode=$1
+	reflog_action="$2"
+
+	test_expect_success "rebase $mode reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		git rebase $mode main
+	) &&
+
+	git log -g --format=%gs -4 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
 	EOF
 	test_cmp expect actual &&
 
-	git checkout -b reflog-prefix reflog-to-rebase &&
-	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
-	git log -g --format=%gs -3 >actual &&
-	cat >expect <<-\EOF &&
-	change-the-reflog (finish): returning to refs/heads/reflog-prefix
-	change-the-reflog (pick): reflog-to-rebase
-	change-the-reflog (start): checkout reflog-onto
+	git log -g --format=%gs -1 conflicts >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): refs/heads/conflicts onto $(git rev-parse main)
 	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'rebase --apply reflog' '
-	git checkout -b reflog-apply start &&
-	old_head_reflog="$(git log -g --format=%gs -1 HEAD)" &&
-
-	git rebase --apply Y &&
+	test_cmp expect actual &&
 
-	git log -g --format=%gs -4 HEAD >actual &&
-	cat >expect <<-EOF &&
-	rebase finished: returning to refs/heads/reflog-apply
-	rebase: Z
-	rebase: checkout Y
-	$old_head_reflog
+	# check there is only one new entry in the branch reflog
+	test_cmp_rev conflicts@{1} Q
+	'
+
+	test_expect_success "rebase $mode fast-forward reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout fast-forward &&
+	test_when_finished "git reset --hard X" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		git rebase $mode main
+	) &&
+
+	git log -g --format=%gs -2 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/fast-forward
+	${reflog_action:-rebase} (start): checkout main
 	EOF
 	test_cmp expect actual &&
 
-	git log -g --format=%gs -2 reflog-apply >actual &&
-	cat >expect <<-EOF &&
-	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
-	branch: Created from start
+	git log -g --format=%gs -1 fast-forward >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): refs/heads/fast-forward onto $(git rev-parse main)
 	EOF
-	test_cmp expect actual
-'
+	test_cmp expect actual &&
+
+	# check there is only one new entry in the branch reflog
+	test_cmp_rev fast-forward@{1} X
+	'
+}
+
+test_reflog --merge
+test_reflog --merge my-reflog-action
+test_reflog --apply
+test_reflog --apply my-reflog-action
 
 test_expect_success 'rebase -i onto unrelated history' '
 	git init unrelated &&
-- 
gitgitgadget

