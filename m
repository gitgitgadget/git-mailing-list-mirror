Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0781F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeFEOlW (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33964 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbeFEOlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id q4-v6so19175499wmq.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+Wpwf4/8mICmFhdk4pjXHnF6kcYK7lTV08j303DdxYA=;
        b=MZo6dGjruAAnmnwB4/uuNxT39sSySE+IDGw5H9HKRMfdXprE0AXhjvikTObSPfTtS0
         WXdHNrbrZvvj2ANj8Rk7v6QKzB8gm9ZJ1eSPTNUceDCeM+B+ApIS7yqcoCrAaDBvXgni
         DhLjXAYCDa56+Vo1aF7pda/UzUphynyc04VA5P1yBSJwmWihorv/4BLgzcK4mv1jZsT+
         IlO+hXxLcqH0FEmfH1Duh3ilb8v0b0mZZ88zJ2cBFDqiXYqLNJZvFN//ol5WucJQwhB1
         ogFczqFWAS8IUBTuXIrczKfxHtzG19IZ3ZOoqHjIh85ar/KVk/VxSMQ98DtU4S2k4iez
         Ovhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+Wpwf4/8mICmFhdk4pjXHnF6kcYK7lTV08j303DdxYA=;
        b=kgt37QD1SWk3UdpEYHB2/OIYWcgN6i00sRt69PNRThgo23UdjadNNuk4SXZY7NSCCe
         p192SUlz3yUw9MD3+iH1e467tqBf+rJ5Q0nxTNqZckXrl43fZhScXuyDMp3ogOmf/3DI
         Kf4exIk9NDLl15c676EeHWRhh+1X02QCwINzs0oDtI+s7yAEG9EePmVDVuN5EFyWmzlq
         XBSUjwdQo4MVDzSyhIzhFjGGFC0DX6ASdIqieyqZEghCJYByefVVzSm+E8f3U5XumTxF
         q9SHV6hjSYFEyrntKV30ndLvWavgXxRHnR03DZXiMH49QR0NEW1L4jms5gd+wadJlL1C
         aQew==
X-Gm-Message-State: ALKqPwdWpsrMJZy4s90PHwvhosuSRPUwntUJW9VyytCV4rpWfy30CUf7
        LvoM2H9jRZ+5x53vmmh/dc10CmzY
X-Google-Smtp-Source: ADUXVKIIDdW8zPErOCU97/YcS8badHDArUWy8ldAsuOIoKtS4zA5meWFY4Uf1aXq2OtCwuVQylP5gA==
X-Received: by 2002:a1c:3bc4:: with SMTP id i187-v6mr13163583wma.57.1528209670205;
        Tue, 05 Jun 2018 07:41:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:41:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 8/8] checkout & worktree: introduce checkout.defaultRemote
Date:   Tue,  5 Jun 2018 14:40:49 +0000
Message-Id: <20180605144049.26488-9-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605144049.26488-1-avarab@gmail.com>
References: <20180605144049.26488-1-avarab@gmail.com>
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a checkout.defaultRemote setting which can be used to
designate a remote to prefer (via checkout.defaultRemote=origin) when
running e.g. "git checkout master" to mean origin/master, even though
there's other remotes that have the "master" branch.

I want this because it's very handy to use this workflow to checkout a
repository and create a topic branch, then get back to a "master" as
retrieved from upstream:

    (
        cd /tmp &&
        rm -rf tbdiff &&
        git clone git@github.com:trast/tbdiff.git &&
        cd tbdiff &&
        git branch -m topic &&
        git checkout master
    )

That will output:

    Branch 'master' set up to track remote branch 'master' from 'origin'.
    Switched to a new branch 'master'

But as soon as a new remote is added (e.g. just to inspect something
from someone else) the DWIMery goes away:

    (
        cd /tmp &&
        rm -rf tbdiff &&
        git clone git@github.com:trast/tbdiff.git &&
        cd tbdiff &&
        git branch -m topic &&
        git remote add avar git@github.com:avar/tbdiff.git &&
        git fetch avar &&
        git checkout master
    )

Will output (without the advice output added earlier in this series):

    error: pathspec 'master' did not match any file(s) known to git.

The new checkout.defaultRemote config allows me to say that whenever
that ambiguity comes up I'd like to prefer "origin", and it'll still
work as though the only remote I had was "origin".

Also adjust the advice.checkoutAmbiguousRemoteBranchName message to
mention this new config setting to the user, the full output on my
git.git is now (the last paragraph is new):

    $ ./git --exec-path=$PWD checkout master
    error: pathspec 'master' did not match any file(s) known to git.
    hint: 'master' matched more than one remote tracking branch.
    hint: We found 26 remotes with a reference that matched. So we fell back
    hint: on trying to resolve the argument as a path, but failed there too!
    hint:
    hint: If you meant to check out a remote tracking branch on, e.g. 'origin',
    hint: you can do so by fully qualifying the name with the --track option:
    hint:
    hint:     git checkout --track origin/<name>
    hint:
    hint: If you'd like to always have checkouts of an ambiguous <name> prefer
    hint: one remote, e.g. the 'origin' remote, consider setting
    hint: checkout.defaultRemote=origin in your config.

I considered splitting this into checkout.defaultRemote and
worktree.defaultRemote, but it's probably less confusing to break our
own rules that anything shared between config should live in core.*
than have two config settings, and I couldn't come up with a short
name under core.* that made sense (core.defaultRemoteForCheckout?).

See also 70c9ac2f19 ("DWIM "git checkout frotz" to "git checkout -b
frotz origin/frotz"", 2009-10-18) which introduced this DWIM feature
to begin with, and 4e85333197 ("worktree: make add <path> <branch>
dwim", 2017-11-26) which added it to git-worktree.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt       | 21 ++++++++++++++++++++-
 Documentation/git-checkout.txt |  9 +++++++++
 Documentation/git-worktree.txt |  9 +++++++++
 builtin/checkout.c             | 12 +++++++++---
 checkout.c                     | 26 ++++++++++++++++++++++++--
 t/t2024-checkout-dwim.sh       | 18 +++++++++++++++++-
 t/t2025-worktree-add.sh        | 21 +++++++++++++++++++++
 7 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dfc0413a84..aef2769211 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -350,7 +350,10 @@ advice.*::
 		remote tracking branch on more than one remote in
 		situations where an unambiguous argument would have
 		otherwise caused a remote-tracking branch to be
-		checked out.
+		checked out. See the `checkout.defaultRemote`
+		configuration variable for how to set a given remote
+		to used by default in some situations where this
+		advice would be printed.
 	amWorkDir::
 		Advice that shows the location of the patch file when
 		linkgit:git-am[1] fails to apply it.
@@ -1105,6 +1108,22 @@ browser.<tool>.path::
 	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
+checkout.defaultRemote::
+	When you run 'git checkout <something>' and only have one
+	remote, it may implicitly fall back on checking out and
+	tracking e.g. 'origin/<something>'. This stops working as soon
+	as you have more than one remote with a '<something>'
+	reference. This setting allows for setting the name of a
+	preferred remote that should always win when it comes to
+	disambiguation. The typical use-case is to set this to
+	`origin`.
++
+Currently this is used by linkgit:git-checkout[1] when 'git checkout
+<something>' will checkout the '<something>' branch on another remote,
+and by linkgit:git-worktree[1] when 'git worktree add' refers to a
+remote branch. This setting might be used for other checkout-like
+commands or functionality in the future.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca5fc9c798..9db02928c4 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -38,6 +38,15 @@ equivalent to
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
+If the branch exists in multiple remotes and one of them is named by
+the `checkout.defaultRemote` configuration variable, we'll use that
+one for the purposes of disambiguation, even if the `<branch>` isn't
+unique across all remotes. Set it to
+e.g. `checkout.defaultRemote=origin` to always checkout remote
+branches from there if `<branch>` is ambiguous but exists on the
+'origin' remote. See also `checkout.defaultRemote` in
+linkgit:git-config[1].
++
 You could omit <branch>, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index afc6576a14..9c26be40f4 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -60,6 +60,15 @@ with a matching name, treat as equivalent to:
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
+If the branch exists in multiple remotes and one of them is named by
+the `checkout.defaultRemote` configuration variable, we'll use that
+one for the purposes of disambiguation, even if the `<branch>` isn't
+unique across all remotes. Set it to
+e.g. `checkout.defaultRemote=origin` to always checkout remote
+branches from there if `<branch>` is ambiguous but exists on the
+'origin' remote. See also `checkout.defaultRemote` in
+linkgit:git-config[1].
++
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, the new worktree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
diff --git a/builtin/checkout.c b/builtin/checkout.c
index baa027455a..5b357e922a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -912,8 +912,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *   (b) If <something> is _not_ a commit, either "--" is present
 	 *       or <something> is not a path, no -t or -b was given, and
 	 *       and there is a tracking branch whose name is <something>
-	 *       in one and only one remote, then this is a short-hand to
-	 *       fork local <something> from that remote-tracking branch.
+	 *       in one and only one remote (or if the branch exists on the
+	 *       remote named in checkout.defaultRemote), then this is a
+	 *       short-hand to fork local <something> from that
+	 *       remote-tracking branch.
 	 *
 	 *   (c) Otherwise, if "--" is present, treat it like case (1).
 	 *
@@ -1277,7 +1279,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 				 "you can do so by fully qualifying the name with the --track option:\n"
 				 "\n"
-				 "    git checkout --track origin/<name>"),
+				 "    git checkout --track origin/<name>\n"
+				 "\n"
+				 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+				 "one remote, e.g. the 'origin' remote, consider setting\n"
+				 "checkout.defaultRemote=origin in your config."),
 			       argv[0],
 			       dwim_remotes_matched);
 		return ret;
diff --git a/checkout.c b/checkout.c
index ee3a7e9c05..c72e9f9773 100644
--- a/checkout.c
+++ b/checkout.c
@@ -2,15 +2,19 @@
 #include "remote.h"
 #include "refspec.h"
 #include "checkout.h"
+#include "config.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
 	int num_matches;
+	const char *default_remote;
+	char *default_dst_ref;
+	struct object_id *default_dst_oid;
 };
 
-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0, NULL, NULL, NULL }
 
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
@@ -24,6 +28,12 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		return 0;
 	}
 	cb->num_matches++;
+	if (cb->default_remote && !strcmp(remote->name, cb->default_remote)) {
+		struct object_id *dst = xmalloc(sizeof(*cb->default_dst_oid));
+		cb->default_dst_ref = xstrdup(query.dst);
+		oidcpy(dst, cb->dst_oid);
+		cb->default_dst_oid = dst;
+	}
 	if (cb->dst_ref) {
 		free(query.dst);
 		return 0;
@@ -36,14 +46,26 @@ const char *unique_tracking_name(const char *name, struct object_id *oid,
 				 int *dwim_remotes_matched)
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
+	const char *default_remote = NULL;
+	if (!git_config_get_string_const("checkout.defaultremote", &default_remote))
+		cb_data.default_remote = default_remote;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	if (dwim_remotes_matched)
 		*dwim_remotes_matched = cb_data.num_matches;
 	free(cb_data.src_ref);
-	if (cb_data.num_matches == 1)
+	free((char *)default_remote);
+	if (cb_data.num_matches == 1) {
+		free(cb_data.default_dst_ref);
+		free(cb_data.default_dst_oid);
 		return cb_data.dst_ref;
+	}
 	free(cb_data.dst_ref);
+	if (cb_data.default_dst_ref) {
+		oidcpy(oid, cb_data.default_dst_oid);
+		free(cb_data.default_dst_oid);
+		return cb_data.default_dst_ref;
+	}
 	return NULL;
 }
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index fef263a858..9f17ac92f1 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -87,7 +87,23 @@ test_expect_success 'checkout of branch from multiple remotes fails with advice'
 		checkout foo 2>stderr &&
 	test_branch master &&
 	status_uno_is_clean &&
-	test_i18ngrep ! "^hint: " stderr
+	test_i18ngrep ! "^hint: " stderr &&
+	# Make sure the likes of checkout -p do not print this hint
+	git checkout -p foo 2>stderr &&
+	test_i18ngrep ! "^hint: " stderr &&
+	status_uno_is_clean
+'
+
+test_expect_success 'checkout of branch from multiple remotes succeeds with checkout.defaultRemote #1' '
+	git checkout -B master &&
+	status_uno_is_clean &&
+	test_might_fail git branch -D foo &&
+
+	git -c checkout.defaultRemote=repo_a checkout foo &&
+	status_uno_is_clean &&
+	test_branch foo &&
+	test_cmp_rev remotes/repo_a/foo HEAD &&
+	test_branch_upstream foo repo_a foo
 '
 
 test_expect_success 'checkout of branch from a single remote succeeds #1' '
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index d2e49f7632..be6e093142 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -402,6 +402,27 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		git remote add repo_upstream2 ../repo_upstream &&
+		git fetch repo_upstream2 &&
+		test_must_fail git worktree add ../foo foo &&
+		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
+		>status.expect &&
+		git status -uno --porcelain >status.actual &&
+		test_cmp status.expect status.actual
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_upstream foo &&
+		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+	)
+'
+
 test_expect_success 'git worktree add does not match remote' '
 	test_when_finished rm -rf repo_a repo_b foo &&
 	setup_remote_repo repo_a repo_b &&
-- 
2.17.0.290.gded63e768a

