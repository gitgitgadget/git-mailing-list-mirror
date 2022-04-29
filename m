Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15503C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 09:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357174AbiD2KAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiD2KAM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 06:00:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B274756C
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so10122004wrc.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=94CNW39yx0FK5+icdSaliaZmEjJBiy7AXXxBJV0lNsQ=;
        b=XAkJi3clhs7BBCXFWsraM0qOY04Gk3qrxXxpdjliQKLojswloaJUxSa9VIzEtm9u2y
         2NatpAiNQXwoecTLgYSnaPHk435lFhXerwEHIMyHZevthTF7He9VtXSHtaN1TS9rrCof
         ZWAP3AM6Jzya3f79t2ilV1IAEOI6N7yqinxpAnBuyehivRbwoHxcKw4fOszC5LcEegEW
         KVxA71iTwpKV2sjiBjfvx4iPdeteUoabUlYuxCA2V7kZsJ1ipJEKk8UdtH9h+YCOX7a+
         DWml3g8eKxQMPscgJgvrpwvALPQGMKga2fi8IwNjWWeDYNUmKQLpN6PGvuicl84vW9Vd
         3ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=94CNW39yx0FK5+icdSaliaZmEjJBiy7AXXxBJV0lNsQ=;
        b=wdLG/wVStpmhvikTpFSOFd8xAaBtBMBe1oaI3vld75q9W0+72Lezua9eTB1Tap3J5g
         md2sqc+P2TehkuyrJIKKxb/+SkGOH9XRvEfomT+bXIB1S7ERwJ1vPGLTlv12J+eJp094
         1qdRWL9PQgHEoG+8QJz+JeWEb5UeTuokOVt+r8NNkjpgsUZ3Ff4hDI+mnUDHoBWuMJxj
         vdkXA61nUU8//2G5Sl89GtwD6pqEVYmaPhtG6+y9MeUIJ8YtxGc9zfvQh2GriKqantwJ
         dunoZ5M7t4cOEVcP35jv8lo8UBGr+Ysy02bNUN3C3r/pTdkRO2l+3JH2Xv0MhiEASRnW
         7kiQ==
X-Gm-Message-State: AOAM533hV2mugVdtxgZj5DPTsfpWPuIokLMrw67G+dC2DI3EW/xF7d40
        /T0Vh7cYFHkgGXqghzXPA6NuoVgAzr0=
X-Google-Smtp-Source: ABdhPJwJbF7Au8RqNvRLSMV4TnffMPjDTJjprQBsqzOfoW/QP4+SvxHKLMa5mUQjLFP7HV5Qg62PXA==
X-Received: by 2002:adf:f187:0:b0:20a:dfb0:766a with SMTP id h7-20020adff187000000b0020adfb0766amr18270246wro.517.1651226212187;
        Fri, 29 Apr 2022 02:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-20020adfab03000000b0020ad57b8ddesm2036309wrc.101.2022.04.29.02.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:56:51 -0700 (PDT)
Message-Id: <41c88e51ac6baf3ddaf08f2335015b4fa69fadf6.1651226207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
References: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
        <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Apr 2022 09:56:46 +0000
Subject: [PATCH v5 3/3] push: new config option "push.autoSetupRemote"
 supports "simple" push
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In some "simple" centralized workflows, users expect remote tracking
branch names to match local branch names. "git push" pushes to the
remote version/instance of the branch, and "git pull" pulls any changes
to the remote branch (changes made by the same user in another place, or
by other users).

This expectation is supported by the push.default default option "simple"
which refuses a default push for a mismatching tracking branch name, and
by the new branch.autosetupmerge option, "simple", which only sets up
remote tracking for same-name remote branches.

When a new branch has been created by the user and has not yet been
pushed (and push.default is not set to "current"), the user is prompted
with a "The current branch %s has no upstream branch" error, and
instructions on how to push and add tracking.

This error is helpful in that following the advice once per branch
"resolves" the issue for that branch forever, but inconvenient in that
for the "simple" centralized workflow, this is always the right thing to
do, so it would be better to just do it.

Support this workflow with a new config setting, push.autoSetupRemote,
which will cause a default push, when there is no remote tracking branch
configured, to push to the same-name on the remote and --set-upstream.

Also add a hint offering this new option when the "The current branch %s
has no upstream branch" error is encountered, and add corresponding tests.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 Documentation/config/push.txt | 11 +++++++++
 builtin/push.c                | 44 ++++++++++++++++++++++++++++-------
 t/t5528-push-default.sh       | 14 +++++++++++
 transport.h                   |  1 +
 4 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 632033638c4..e32801e6c91 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -1,3 +1,14 @@
+push.autoSetupRemote::
+	If set to "true" assume `--set-upstream` on default push when no
+	upstream tracking exists for the current branch; this option
+	takes effect with push.default options 'simple', 'upstream',
+	and 'current'. It is useful if by default you want new branches
+	to be pushed to the default remote (like the behavior of
+	'push.default=current') and you also want the upstream tracking
+	to be set. Workflows most likely to benefit from this option are
+	'simple' central workflows where all branches are expected to
+	have the same name on the remote.
+
 push.default::
 	Defines the action `git push` should take if no refspec is
 	given (whether from the command-line, config, or elsewhere).
diff --git a/builtin/push.c b/builtin/push.c
index 447f91f5b47..86b44f8aa71 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -195,16 +195,32 @@ static const char message_detached_head_die[] =
 	   "\n"
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
-static const char *get_upstream_ref(struct branch *branch, const char *remote_name)
+static const char *get_upstream_ref(int flags, struct branch *branch, const char *remote_name)
 {
-	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
+	if (branch->merge_nr == 0 && (flags & TRANSPORT_PUSH_AUTO_UPSTREAM)) {
+		/* if missing, assume same; set_upstream will be defined later */
+		return branch->refname;
+	}
+
+	if (!branch->merge_nr || !branch->merge || !branch->remote_name) {
+		const char *advice_autosetup_maybe = "";
+		if (!(flags & TRANSPORT_PUSH_AUTO_UPSTREAM)) {
+			advice_autosetup_maybe = _("\n"
+					   "To have this happen automatically for "
+					   "branches without a tracking\n"
+					   "upstream, see 'push.autoSetupRemote' "
+					   "in 'git help config'.\n");
+		}
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
 		    "\n"
-		    "    git push --set-upstream %s %s\n"),
+		    "    git push --set-upstream %s %s\n"
+		    "%s"),
 		    branch->name,
 		    remote_name,
-		    branch->name);
+		    branch->name,
+		    advice_autosetup_maybe);
+	}
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
@@ -212,7 +228,7 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static void setup_default_push_refspecs(struct remote *remote)
+static void setup_default_push_refspecs(int *flags, struct remote *remote)
 {
 	struct branch *branch;
 	const char *dst;
@@ -244,7 +260,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 	case PUSH_DEFAULT_SIMPLE:
 		if (!same_remote)
 			break;
-		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
+		if (strcmp(branch->refname, get_upstream_ref(*flags, branch, remote->name)))
 			die_push_simple(branch, remote);
 		break;
 
@@ -254,13 +270,21 @@ static void setup_default_push_refspecs(struct remote *remote)
 			      "your current branch '%s', without telling me what to push\n"
 			      "to update which remote branch."),
 			    remote->name, branch->name);
-		dst = get_upstream_ref(branch, remote->name);
+		dst = get_upstream_ref(*flags, branch, remote->name);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
 		break;
 	}
 
+	/*
+	 * this is a default push - if auto-upstream is enabled and there is
+	 * no upstream defined, then set it (with options 'simple', 'upstream',
+	 * and 'current').
+	 */
+	if ((*flags & TRANSPORT_PUSH_AUTO_UPSTREAM) && branch->merge_nr == 0)
+		*flags |= TRANSPORT_PUSH_SET_UPSTREAM;
+
 	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
 }
 
@@ -411,7 +435,7 @@ static int do_push(int flags,
 		if (remote->push.nr) {
 			push_refspec = &remote->push;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			setup_default_push_refspecs(remote);
+			setup_default_push_refspecs(&flags, remote);
 	}
 	errs = 0;
 	url_nr = push_url_of_remote(remote, &url);
@@ -482,6 +506,10 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		else
 			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
 		return 0;
+	} else if (!strcmp(k, "push.autosetupremote")) {
+		if (git_config_bool(k, v))
+			*flags |= TRANSPORT_PUSH_AUTO_UPSTREAM;
+		return 0;
 	} else if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
 		if (!git_config_get_value("push.gpgsign", &value)) {
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 0d6c9869ed3..284e20fefda 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -162,6 +162,20 @@ test_expect_success 'push from/to branch with tracking fails with nothing ' '
 	test_push_failure nothing
 '
 
+test_expect_success 'push from/to new branch succeeds with upstream if push.autoSetupRemote' '
+	git checkout -b new-branch-a &&
+	test_config push.autoSetupRemote true &&
+	test_config branch.new-branch-a.remote parent1 &&
+	test_push_success upstream new-branch-a
+'
+
+test_expect_success 'push from/to new branch succeeds with simple if push.autoSetupRemote' '
+	git checkout -b new-branch-c &&
+	test_config push.autoSetupRemote true &&
+	test_config branch.new-branch-c.remote parent1 &&
+	test_push_success simple new-branch-c
+'
+
 test_expect_success '"matching" fails if none match' '
 	git init --bare empty &&
 	test_must_fail git push empty : 2>actual &&
diff --git a/transport.h b/transport.h
index 12bc08fc339..b5bf7b3e704 100644
--- a/transport.h
+++ b/transport.h
@@ -145,6 +145,7 @@ struct transport {
 #define TRANSPORT_PUSH_OPTIONS			(1<<14)
 #define TRANSPORT_RECURSE_SUBMODULES_ONLY	(1<<15)
 #define TRANSPORT_PUSH_FORCE_IF_INCLUDES	(1<<16)
+#define TRANSPORT_PUSH_AUTO_UPSTREAM		(1<<17)
 
 int transport_summary_width(const struct ref *refs);
 
-- 
gitgitgadget
