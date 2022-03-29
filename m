Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D304AC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 20:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbiC2UDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbiC2UDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 16:03:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF41AA070
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i204-20020a1c3bd5000000b0038ce25c870dso39888wma.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6FAlh824YowLbtPbLsYzwI3hYE8qvSGEqtAmbkQfCVI=;
        b=fDC/R9QYjXJoilYp1kPeY8yvkYtolYrBGjv8A0wc9zkVDiaYdphb+AU8FIBww+IoyR
         SRJoR+1Pxh7WbDw+8MvqVg+r5XOFKABp8XpIO9seOWL0tczoE0TNdmJqikpOC4Gjbyxm
         dQikiYql5vTiSWk/LIU8V57Yjf2cR8K5YV5/PE0pIIKL2YZOBr7AJe2JlyAWfRTh2oen
         2qqKm0dJmp8w32qm13flX/nW5nm68dUG5Ga3L+zELIgFZ/us8DGz42XrmMHW0xZxzODm
         /8dUrsl7jPcDZf79N5ZcdWEYDviNO9J0AVM3FzRqoF/NCBs/klmechzHGYZ0AdbE2Nwf
         TioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6FAlh824YowLbtPbLsYzwI3hYE8qvSGEqtAmbkQfCVI=;
        b=mzXWecUej/NvY9lVpSGAVld+NQf2bgqlXvNXo0dfubdpNDq76jo7nWiXf3L1zVUjIW
         7iKhe38mQLyNK4IxEdnPaK3tJldy3WIk/q3zO4dRHRafY4eEagBMXSzxcl5eo46H3opA
         JXyARImEVxxPXk3Q6qOIpC14XYAl7kwYVoE4Fp+iUjpY40kDjkrn3aZ7oraJtl9sASa6
         CCjW6y+3lexKblhgIchchE74Reda+C4+XTIN6D29ryPy+yHPE4aw124hcLfmIJZtLC+n
         Jv4C+F8nI+abAs4uG505vluQO3/OPIzUpya+R2MVI5C5PQ0a3ZJyO7/ToXGMnE9vhhD7
         ozyQ==
X-Gm-Message-State: AOAM5329yBqiFaicAuExDjYAxCuvr4UoB2mkUjs584JWlBbhQHMXHo+9
        smVHO1qz3nzcV2Wk7WAFuDRk18YowAk=
X-Google-Smtp-Source: ABdhPJyv+pAS4AzB2xy14s/UXhjPCkPwhHcH0Xbv+McHmb7pOvJ6bhfbGNXleuZb03ZK+/UCllraBA==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id f13-20020a7bcc0d000000b00381220ea3a0mr1181911wmh.59.1648584081622;
        Tue, 29 Mar 2022 13:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b0038cc9bfe6a4sm2839825wmk.37.2022.03.29.13.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:01:21 -0700 (PDT)
Message-Id: <0b682c173c8cfa7f49ba17b2d71049ac702ec747.1648584079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 20:01:16 +0000
Subject: [PATCH 1/4] branch: support more tracking modes when recursing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

"git branch --recurse-submodules" does not propagate "--track=inherit"
or "--no-track" to submodules, which causes submodule branches to use
the wrong tracking mode [1]. To fix this, pass the correct options to
the "submodule--helper create-branch" child process and test for it.

While we are refactoring the same code, replace "--track" with the
synonymous, but more consistent-looking "--track=direct" option
(introduced at the same time as "--track=inherit", d3115660b4 (branch:
add flags and config to inherit tracking, 2021-12-20)).

[1] This bug is partially a timing issue: "branch --recurse-submodules"
 was introduced around the same time as "--track=inherit", and even
 though I rebased "branch --recurse-submodules" on top of that, I had
 neglected to support the new tracking mode. Omitting "--no-track"
 was just a plain old mistake, though.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c                    | 29 +++++++++++++++++++++++++---
 builtin/submodule--helper.c |  7 ++++---
 t/t3207-branch-submodule.sh | 38 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 6b31df539a5..7377b9f451a 100644
--- a/branch.c
+++ b/branch.c
@@ -233,6 +233,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
 
+	if (!track)
+		BUG("asked to set up tracking, but tracking is disallowed");
+
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
@@ -534,8 +537,27 @@ static int submodule_create_branch(struct repository *r,
 		strvec_push(&child.args, "--quiet");
 	if (reflog)
 		strvec_push(&child.args, "--create-reflog");
-	if (track == BRANCH_TRACK_ALWAYS || track == BRANCH_TRACK_EXPLICIT)
-		strvec_push(&child.args, "--track");
+
+	switch (track) {
+	case BRANCH_TRACK_NEVER:
+		strvec_push(&child.args, "--no-track");
+		break;
+	case BRANCH_TRACK_ALWAYS:
+	case BRANCH_TRACK_EXPLICIT:
+		strvec_push(&child.args, "--track=direct");
+		break;
+	case BRANCH_TRACK_OVERRIDE:
+		BUG("BRANCH_TRACK_OVERRIDE cannot be used when creating a branch.");
+		break;
+	case BRANCH_TRACK_INHERIT:
+		strvec_push(&child.args, "--track=inherit");
+		break;
+	case BRANCH_TRACK_UNSPECIFIED:
+		/* Default for "git checkout". No need to pass --track. */
+	case BRANCH_TRACK_REMOTE:
+		/* Default for "git branch". No need to pass --track. */
+		break;
+	}
 
 	strvec_pushl(&child.args, name, start_oid, tracking_name, NULL);
 
@@ -614,7 +636,8 @@ void create_branches_recursively(struct repository *r, const char *name,
 	 * tedious to determine whether or not tracking was set up in the
 	 * superproject.
 	 */
-	setup_tracking(name, tracking_name, track, quiet);
+	if (track)
+		setup_tracking(name, tracking_name, track, quiet);
 
 	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
 		if (submodule_create_branch(
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5301612d24b..081c8267c33 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3021,9 +3021,10 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 		OPT__FORCE(&force, N_("force creation"), 0),
 		OPT_BOOL(0, "create-reflog", &reflog,
 			 N_("create the branch's reflog")),
-		OPT_SET_INT('t', "track", &track,
-			    N_("set up tracking mode (see git-pull(1))"),
-			    BRANCH_TRACK_EXPLICIT),
+		OPT_CALLBACK_F('t', "track",  &track, "(direct|inherit)",
+			N_("set branch tracking configuration"),
+			PARSE_OPT_OPTARG,
+			parse_opt_tracking_mode),
 		OPT__DRY_RUN(&dry_run,
 			     N_("show whether the branch would be created")),
 		OPT_END()
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index 0d93f7516c9..cfde6b237f5 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -260,7 +260,7 @@ test_expect_success 'should get fatal error upon branch creation when submodule
 	)
 '
 
-test_expect_success 'should set up tracking of remote-tracking branches' '
+test_expect_success 'should set up tracking of remote-tracking branches by default' '
 	test_when_finished "reset_remote_test" &&
 	(
 		cd super-clone &&
@@ -289,4 +289,40 @@ test_expect_success 'should not fail when unable to set up tracking in submodule
 	)
 '
 
+test_expect_success '--track=inherit should set up tracking correctly' '
+	test_when_finished "reset_remote_test" &&
+	(
+		cd super-clone &&
+		git branch --recurse-submodules branch-a origin/branch-a &&
+		# Set this manually instead of using branch --set-upstream-to
+		# to circumvent the "nonexistent upstream" check.
+		git -C sub config branch.branch-a.remote origin &&
+		git -C sub config branch.branch-a.merge refs/heads/sub-branch-a &&
+		git -C sub/sub-sub config branch.branch-a.remote other &&
+		git -C sub/sub-sub config branch.branch-a.merge refs/heads/sub-sub-branch-a &&
+
+		git branch --recurse-submodules --track=inherit branch-b branch-a &&
+		test_cmp_config origin branch.branch-b.remote &&
+		test_cmp_config refs/heads/branch-a branch.branch-b.merge &&
+		test_cmp_config -C sub origin branch.branch-b.remote &&
+		test_cmp_config -C sub refs/heads/sub-branch-a branch.branch-b.merge &&
+		test_cmp_config -C sub/sub-sub other branch.branch-b.remote &&
+		test_cmp_config -C sub/sub-sub refs/heads/sub-sub-branch-a branch.branch-b.merge
+	)
+'
+
+test_expect_success '--no-track should not set up tracking' '
+	test_when_finished "reset_remote_test" &&
+	(
+		cd super-clone &&
+		git branch --recurse-submodules --no-track branch-a origin/branch-a &&
+		test_cmp_config "" --default "" branch.branch-a.remote &&
+		test_cmp_config "" --default "" branch.branch-a.merge &&
+		test_cmp_config -C sub "" --default "" branch.branch-a.remote &&
+		test_cmp_config -C sub "" --default "" branch.branch-a.merge &&
+		test_cmp_config -C sub/sub-sub "" --default "" branch.branch-a.remote &&
+		test_cmp_config -C sub/sub-sub "" --default "" branch.branch-a.merge
+	)
+'
+
 test_done
-- 
gitgitgadget

