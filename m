Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEC7C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbiCaSv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiCaSvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 14:51:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AE216E7CD
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so972732wrc.13
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QhIZ6ViwWoJZrXihwgpbUJCt7CyAtmgWKKrcYxuljSY=;
        b=lYPFDyTEoKuc3WtAhjCfWp4AH8xgoe9VQ0yh9169JMMAbOMlbP/3KlP+9X1Fjn6xgS
         OXGffMhzBQxzdGeGHQMe+csusYdNewb7m6lEcOCid8xTAaWSSJ/M9evWpL4QQb3O4+PY
         vvPkRnVTzqrRICmjEWwyov2P+s5TeIgGjq5EjpcDrChRJCFBGhTToRkIDvwPVGlTc56n
         spavW4EFY9YaLUcJbi4be6rOnpu/52PYd9shmidPA7qbmMl4k/mfmZ2XvJr1/tuDJ9rZ
         U07JAtIEK8vqgZdqPXEbnNx3uNzP+d+Du5B3pGHnmJ3RZ3bG6nVm0WGOUnhJkPfSYlrs
         RcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QhIZ6ViwWoJZrXihwgpbUJCt7CyAtmgWKKrcYxuljSY=;
        b=UbkKyR9xVb3biwBMaqyRpMRkOlexinyPETZmLd42mVIdGIq7jGUM9q5/EPfgOBiKM9
         YEASPhEc+dJ7cYgqxTfavNTccHZObGMGYrhQKsErz+Kl+C21BlXGbG2CaBgYL2Bmz1Mz
         0JmDNHHJituTRBugcDEBdrCShZxfiAX5hSAzFqyJaWBuGU1SYTerzA4Qf5zZNys4J+y3
         cIsVRlWis0nZMo//NHM7D9JZfH2qrGbYs6LH8pNtp2IcjUdZIxn0sOcbeReDj0EAVhcz
         TqrYfMEhcxIVVX84rszzf6YNm/DfFqd8noxc1UMR+BhG8wMU4Kw51zLznNMiScM7rZzz
         xOTA==
X-Gm-Message-State: AOAM532+WUb+cu/xlmJYprgWMMYkrwA672WEQADXxbAmzah0LwX7lNvL
        0TDCxNwR0r/ZGWYOvu1J/JV03xXREvg=
X-Google-Smtp-Source: ABdhPJzEzulQsjBfTxqWMvacEZIx8rrpK/kCKYmWT8Xh/PKx3+yw8QaGTH0RoWWMy2aNUKsR/asXNQ==
X-Received: by 2002:a05:6000:178a:b0:205:c5e1:df07 with SMTP id e10-20020a056000178a00b00205c5e1df07mr5061464wrg.703.1648752603624;
        Thu, 31 Mar 2022 11:50:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d66c5000000b00203fd25f4ecsm184026wrw.16.2022.03.31.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:50:03 -0700 (PDT)
Message-Id: <5e96a09199fab0be35d26eab8e73d7cd803032c8.1648752601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 18:49:58 +0000
Subject: [PATCH v2 1/4] branch: support more tracking modes when recursing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index 6b31df539a5..aac24591d22 100644
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
+		/* Default for "git checkout". Do not pass --track. */
+	case BRANCH_TRACK_REMOTE:
+		/* Default for "git branch". Do not pass --track. */
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

