Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007E721841
	for <e@80x24.org>; Wed,  2 May 2018 10:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeEBKzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 06:55:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34654 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeEBKzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 06:55:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id p18-v6so13525462wrm.1
        for <git@vger.kernel.org>; Wed, 02 May 2018 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dcTxWN9TaQB6mN2wJcRWidl7MP50d1qFnNOhGkJ0E5Y=;
        b=HFy4XYDZv+/SirthelPGcGTiwMuKrrQxVWlp6bnkdKmAJ1a1MpP+XlAe4IfmPrr0go
         pzlvX2HeJJA11mJeKmQO1nFbFagTH9JWVO3f/CI8x9/H+HgRNsKinu4DKY4VMLrJFIZG
         AJYyyYzaV3dydC5C2k+eY4DPx/kw4Nhe5UO+mXf53HXjjligIx4Hq0wnYDaK4Cc+/A09
         d+toLQOL9casf3Gc7puq3UxF1tjizfkJ5Y3sBWp1nUMAsavjo45VCnrTj1BpzkY1Ev9V
         /WsWqxwKYjDUU9fwcaq3PZ7tw8JeHVDoLBv4lNPmigz7qtpGv9ZWo6PrKelz5DC6s5JO
         QGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dcTxWN9TaQB6mN2wJcRWidl7MP50d1qFnNOhGkJ0E5Y=;
        b=KdYqAk9oSSjeBiBcwsrYVh3RSus0oYnntJSbWJMQAtIPzD1xyNJbm+0wI6Ep1zZV9d
         QHwGlwiM67a1HJ61P+ugImI3/k0t9GOHgm4LBNUO+cMhUTuxUQfyJ53JpliOuF6pPyr7
         T6lC8lUca6RIaKptBI2bIJwLJVZ4PQzcMYFZOipiMQrb5AYVcuDsM5kEkDDMsQasZc34
         DGuQgi8sskuXyhKP35XPTjdre57LJGWvWtzdNAN1HT62xEIkQChs9DFNTn8GnfuJpyxi
         J3v7xrSSfbjONMfAg3dFeyvC/8hjUY9aRiDzQ7slSZ1+y1jSQ2Ntrda2qT6kCbdLgSRE
         6Dlg==
X-Gm-Message-State: ALQs6tCAtnJwUNP/xD0/XaIeieXwY7uQ6YR22/04wmC3RbivRMybZ0Ql
        eF8JRAopzIM0qU1UYJNy0cLdjWbx
X-Google-Smtp-Source: AB8JxZrVv0l69hFZzKY+XkXkEhyQRclvkIuQLIURT8kuUaX0pyDCS43dCdJ1uavGBEazIfcuKzfdlQ==
X-Received: by 2002:adf:9ae5:: with SMTP id a92-v6mr13891381wrc.180.1525258506202;
        Wed, 02 May 2018 03:55:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o53-v6sm11407468wrc.96.2018.05.02.03.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 03:55:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] checkout & worktree: introduce a core.DWIMRemote setting
Date:   Wed,  2 May 2018 10:54:52 +0000
Message-Id: <20180502105452.17583-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a core.DWIMRemote setting which can be used to designate a
remote to prefer (via core.DWIMRemote=origin) when running e.g. "git
checkout master" to mean origin/master, even though there's other
remotes that have the "master" branch.

I want this because it's very handy to use this workflow to checkout a
repository and create a topic branch, then get back to a "master" as
retrieved from upstream:

    (
        rm -rf /tmp/tbdiff &&
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
        rm -rf /tmp/tbdiff &&
        git clone git@github.com:trast/tbdiff.git &&
        cd tbdiff &&
        git branch -m topic &&
        git remote add avar git@github.com:avar/tbdiff.git &&
        git fetch avar &&
        git checkout master
    )

Will output:

    error: pathspec 'master' did not match any file(s) known to git.

The new core.DWIMRemote config allows me to say that whenever that
ambiguity comes up I'd like to prefer "origin", and it'll still work
as though the only remote I had was "origin".

I considered calling the config setting checkout.DWIMRemote, but then
discovered that this behavior is also used by "worktree" for similar
purposes, so it makes sense to have it under core.*. As noted in the
documentation we may also want to use this in other commands in the
future if they have similar DWIM behavior in the presence of one
remote.

See also 70c9ac2f19 ("DWIM "git checkout frotz" to "git checkout -b
frotz origin/frotz"", 2009-10-18) which introduced this DWIM feature
to begin with, and 4e85333197 ("worktree: make add <path> <branch>
dwim", 2017-11-26) which added it to git-worktree.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt       | 15 +++++++++++++++
 Documentation/git-checkout.txt |  5 +++++
 Documentation/git-worktree.txt |  5 +++++
 builtin/checkout.c             |  3 ++-
 checkout.c                     | 17 +++++++++++++++--
 t/t2024-checkout-dwim.sh       | 10 ++++++++++
 t/t2025-worktree-add.sh        | 18 ++++++++++++++++++
 7 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..d4740fcdb9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -898,6 +898,21 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
+core.DWIMRemote::
+	Various git commands will look at references on the configured
+	remotes and DW[YI]M (Do What (You|I) Mean) if the reference
+	only exists on one remote. This setting allows for setting the
+	name of a special remote that should always win when it comes
+	to disambiguation. The typical use-case is to set this to
+	`origin`.
++
+Currently this is used by linkgit:git-checkout[1] when `git checkout
+<something>' will checkout the '<something>' branch on another remote,
+and linkgit:git-worktree[1] when 'git worktree add' similarly DWYM
+when a branch is unique across remotes, or this setting is set to a
+special remote. This setting might be used for other commands or
+functionality in the future when appropriate.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca5fc9c798..8ad7be6c53 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -38,6 +38,11 @@ equivalent to
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
+If the branch exists in multiple remotes the `core.DWIMRemote`
+variable can be used to pick the remote you really mean. Set it to
+e.g. `core.DWIMRemote=origin` to always checkout remote branches from
+there. See also `core.DWIMRemote` in linkgit:git-config[1].
++
 You could omit <branch>, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 2755ca90e3..37db12f816 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -60,6 +60,11 @@ with a matching name, treat as equivalent to:
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
+It's also possible to use the `core.DWIMRemote` setting to designate a
+special remote this rule should be applied to, even if the branch
+isn't unique across all remotes. See `core.DWIMRemote` in
+linkgit:git-config[1].
++
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b49b582071..8622ad4ef1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -903,7 +903,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *   (b) If <something> is _not_ a commit, either "--" is present
 	 *       or <something> is not a path, no -t or -b was given, and
 	 *       and there is a tracking branch whose name is <something>
-	 *       in one and only one remote, then this is a short-hand to
+	 *       in one and only one remote (or if the branch exists on the
+	 *       remote named in core.DWIMRemote), then this is a short-hand to
 	 *       fork local <something> from that remote-tracking branch.
 	 *
 	 *   (c) Otherwise, if "--" is present, treat it like case (1).
diff --git a/checkout.c b/checkout.c
index ac42630f74..6e474fbfbb 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,12 +1,15 @@
 #include "cache.h"
 #include "remote.h"
 #include "checkout.h"
+#include "config.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
 	int unique;
+	const char *dwim_remote;
+	char *dwim_dst_ref;
 };
 
 static int check_tracking_name(struct remote *remote, void *cb_data)
@@ -20,6 +23,8 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		free(query.dst);
 		return 0;
 	}
+	if (cb->dwim_remote && !strcmp(remote->name, cb->dwim_remote))
+		cb->dwim_dst_ref = xstrdup(query.dst);
 	if (cb->dst_ref) {
 		free(query.dst);
 		cb->unique = 0;
@@ -31,13 +36,21 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 
 const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	const char *dwim_remote = NULL;
+	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1, NULL, NULL };
+	if (!git_config_get_string_const("core.dwimremote", &dwim_remote))
+		cb_data.dwim_remote = dwim_remote;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	free(cb_data.src_ref);
-	if (cb_data.unique)
+	free((char *)dwim_remote);
+	if (cb_data.unique) {
+		free(cb_data.dwim_dst_ref);
 		return cb_data.dst_ref;
+	}
 	free(cb_data.dst_ref);
+	if (cb_data.dwim_dst_ref)
+		return cb_data.dwim_dst_ref;
 	return NULL;
 }
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 3e5ac81bd2..d8db2a14d7 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -68,6 +68,16 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_branch master
 '
 
+test_expect_success 'checkout of branch from multiple remotes succeeds with core.DWIMRemote #1' '
+	git checkout -B master &&
+	test_might_fail git branch -D foo &&
+
+	git -c core.DWIMRemote=repo_a checkout foo &&
+	test_branch foo &&
+	test_cmp_rev remotes/repo_a/foo HEAD &&
+	test_branch_upstream foo repo_a foo
+'
+
 test_expect_success 'checkout of branch from a single remote succeeds #1' '
 	git checkout -B master &&
 	test_might_fail git branch -D bar &&
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index d0d2e4f7ec..6be4cd03da 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -450,6 +450,24 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 	)
 '
 
+test_expect_success '"add" <path> <branch> dwims with core.DWIMRemote' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		git remote add repo_upstream2 ../repo_upstream &&
+		git fetch repo_upstream2 &&
+		test_must_fail git worktree add ../foo foo &&
+		git -c core.DWIMRemote=repo_upstream worktree add ../foo foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_upstream foo &&
+		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+	)
+'
+
 post_checkout_hook () {
 	gitdir=${1:-.git}
 	test_when_finished "rm -f $gitdir/hooks/post-checkout" &&
-- 
2.17.0.290.gded63e768a

