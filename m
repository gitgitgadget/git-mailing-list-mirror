Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660601F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971162AbeEXTrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:47:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44036 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966483AbeEXTrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:47:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id y15-v6so5198117wrg.11
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35XEUfU46TXfJUHUDu0w6jDrnJBmIDd+W3TZYUTCpOc=;
        b=rIKKObNqV4psCir1PMsdLA+py6HqcbRqLtAB1VSKUyWqHVjeaz2iGbOdSoywKU3Cn4
         hthC9tLobCVFfudvuqU+X9zg0nbSywwFQGXRWzITGNTFnjZcK6uTOcBRhDARgp30S/zd
         RXVssBGwqinSFf4y5xiWozX8+/7GoKOiuPZE3/ODJOiiiaRUblHbC6lBn0k0BkKH8A6w
         8JzWLF+PBq4s5jyCzUthVco3AH4PZyIoNtyxxJj7P9p/fdZkqUfDg6sTe0ac8SBtgsYG
         nZyLbwJXGVWKHs+EUEjjiAnMgeEg1HF29YsbKZ0+2dZ6OSAxuk/FL9slMzcmGBXg0KG+
         wNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35XEUfU46TXfJUHUDu0w6jDrnJBmIDd+W3TZYUTCpOc=;
        b=UsOkNo16Wz+BGh14w1OB2xFYCwAQmZXSGePGGJOEfBrGCwvkfrv8j2r0jMa4XsbNH9
         jBjc4GcsZtUAG9M2bQp3DId0XwBqK9Yv20/JC1y6JJsDNd6k3tpGwi9x58a/vq9weT3D
         hpFNmNq7mWlaGMcLEYBxh7UmexHG1k7p0bpYk/uGlCdzau2XbCegwgZ+zGe4kQ8VomOk
         Y3A4FQZSFb26p/tY/FBXTsmJ1q/gX3+WPNfqcwEPif22Xlqd8n5INK7qfAD/EKO95bY6
         b2vE7lf28oe2YBZch2CoG3/f0X/nPpwiDikN2JZwKSCJWYhV1LU2pivITwsjaDMDOhxK
         /JnA==
X-Gm-Message-State: ALKqPwcqq5l/XvGfq8tkYjHawN+FNsQWzUH7GA8yo9wIOTRBwc8apkaO
        HOlWI5HI3IjcuXQCDDf8Z219hbCM
X-Google-Smtp-Source: AB8JxZqjpgcwIJYDb3NlQ8j5/eSk88ycD57g0dsRg4PmYcojgqX7wZ2+FJP4/TDBSpCsuE5W4E0XTw==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr7135272wrh.24.1527191237195;
        Thu, 24 May 2018 12:47:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id f143-v6sm5501039wme.43.2018.05.24.12.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 12:47:15 -0700 (PDT)
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
Subject: [PATCH v3] checkout & worktree: introduce checkout.implicitRemote
Date:   Thu, 24 May 2018 19:47:04 +0000
Message-Id: <20180524194704.936-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com>
References: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a checkout.implicitRemote setting which can be used to
designate a remote to prefer (via checkout.implicitRemote=origin) when
running e.g. "git checkout master" to mean origin/master, even though
there's other remotes that have the "master" branch.

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

The new checkout.implicitRemote config allows me to say that whenever
that ambiguity comes up I'd like to prefer "origin", and it'll still
work as though the only remote I had was "origin".

I considered splitting this into checkout.implicitRemote and
worktree.implicitRemote, but it's probably less confusing to break our
own rules that anything shared between config should live in core.*
than have two config settings, and I couldn't come up with a short
name under core.* that made sense (core.implicitRemoteForCheckout?).

See also 70c9ac2f19 ("DWIM "git checkout frotz" to "git checkout -b
frotz origin/frotz"", 2009-10-18) which introduced this DWIM feature
to begin with, and 4e85333197 ("worktree: make add <path> <branch>
dwim", 2017-11-26) which added it to git-worktree.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Took me a while to get around to this, but this v3 addresses feedback
by Eric about the docs. Thanks! interdiff:
    
    1: 905a17f35f ! 1: b23d1b71e9 checkout & worktree: introduce checkout.implicitRemote
        @@ -71,16 +71,15 @@
         +	tracking e.g. 'origin/<something>'. This stops working as soon
         +	as you have more than one remote with a '<something>'
         +	reference. This setting allows for setting the name of a
        -+	special remote that should always win when it comes to
        ++	preferred remote that should always win when it comes to
         +	disambiguation. The typical use-case is to set this to
         +	`origin`.
         ++
         +Currently this is used by linkgit:git-checkout[1] when 'git checkout
         +<something>' will checkout the '<something>' branch on another remote,
        -+and by linkgit:git-worktree[1] when 'git worktree add' when referring
        -+to a remote branch.  This setting might be used for other
        -+checkout-like commands or functionality in the future when
        -+appropriate.
        ++and by linkgit:git-worktree[1] when 'git worktree add' refers to a
        ++remote branch. This setting might be used for other checkout-like
        ++commands or functionality in the future.
         +
          clean.requireForce::
          	A boolean to make git-clean do nothing unless given -f,
        @@ -110,14 +109,14 @@
          $ git worktree add --track -b <branch> <path> <remote>/<branch>
          ------------
          +
        -+It's also possible to use the `checkout.implicitRemote` setting to
        -+designate a special remote this rule should be applied to, even if the
        -+branch isn't unique across all remotes. See `checkout.implicitRemote`
        -+in linkgit:git-config[1].
        ++The `checkout.implicitRemote` setting can be used to to designate a
        ++preferred `<remote>` this rule should be applied to, even if the
        ++`<branch>` isn't unique across all remotes. See
        ++`checkout.implicitRemote` in linkgit:git-config[1].
         ++
          If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
        - then, as a convenience, a new branch based at HEAD is created automatically,
        - as if `-b $(basename <path>)` was specified.
        + then, as a convenience, the new worktree is associated with a branch
        + (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
         
         diff --git a/builtin/checkout.c b/builtin/checkout.c
         --- a/builtin/checkout.c
        @@ -235,6 +234,6 @@
         +	)
         +'
         +
        - post_checkout_hook () {
        - 	gitdir=${1:-.git}
        - 	test_when_finished "rm -f $gitdir/hooks/post-checkout" &&
        + test_expect_success 'git worktree add does not match remote' '
        + 	test_when_finished rm -rf repo_a repo_b foo &&
        + 	setup_remote_repo repo_a repo_b &&

 Documentation/config.txt       | 16 ++++++++++++++++
 Documentation/git-checkout.txt |  6 ++++++
 Documentation/git-worktree.txt |  5 +++++
 builtin/checkout.c             |  6 ++++--
 checkout.c                     | 17 +++++++++++++++--
 t/t2024-checkout-dwim.sh       | 10 ++++++++++
 t/t2025-worktree-add.sh        | 18 ++++++++++++++++++
 7 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 84e2891aed..7f095a260a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1098,6 +1098,22 @@ browser.<tool>.path::
 	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).
 
+checkout.implicitRemote::
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
index ca5fc9c798..753aa4001f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -38,6 +38,12 @@ equivalent to
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
+If the branch exists in multiple remotes the `checkout.implicitRemote`
+variable can be used to pick the remote you really mean. Set it to
+e.g. `checkout.implicitRemote=origin` to always checkout remote
+branches from there. See also `checkout.implicitRemote` in
+linkgit:git-config[1].
++
 You could omit <branch>, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index afc6576a14..6febb21dca 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -60,6 +60,11 @@ with a matching name, treat as equivalent to:
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
+The `checkout.implicitRemote` setting can be used to to designate a
+preferred `<remote>` this rule should be applied to, even if the
+`<branch>` isn't unique across all remotes. See
+`checkout.implicitRemote` in linkgit:git-config[1].
++
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, the new worktree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2b3b768eff..88e650f0f8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -909,8 +909,10 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *   (b) If <something> is _not_ a commit, either "--" is present
 	 *       or <something> is not a path, no -t or -b was given, and
 	 *       and there is a tracking branch whose name is <something>
-	 *       in one and only one remote, then this is a short-hand to
-	 *       fork local <something> from that remote-tracking branch.
+	 *       in one and only one remote (or if the branch exists on the
+	 *       remote named in checkout.implicitRemote), then this is a
+	 *       short-hand to fork local <something> from that
+	 *       remote-tracking branch.
 	 *
 	 *   (c) Otherwise, if "--" is present, treat it like case (1).
 	 *
diff --git a/checkout.c b/checkout.c
index ac42630f74..2c898cfe19 100644
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
+	const char *implicit_remote;
+	char *implicit_dst_ref;
 };
 
 static int check_tracking_name(struct remote *remote, void *cb_data)
@@ -20,6 +23,8 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		free(query.dst);
 		return 0;
 	}
+	if (cb->implicit_remote && !strcmp(remote->name, cb->implicit_remote))
+		cb->implicit_dst_ref = xstrdup(query.dst);
 	if (cb->dst_ref) {
 		free(query.dst);
 		cb->unique = 0;
@@ -31,13 +36,21 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 
 const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	const char *implicit_remote = NULL;
+	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1, NULL, NULL };
+	if (!git_config_get_string_const("checkout.implicitremote", &implicit_remote))
+		cb_data.implicit_remote = implicit_remote;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
 	free(cb_data.src_ref);
-	if (cb_data.unique)
+	free((char *)implicit_remote);
+	if (cb_data.unique) {
+		free(cb_data.implicit_dst_ref);
 		return cb_data.dst_ref;
+	}
 	free(cb_data.dst_ref);
+	if (cb_data.implicit_dst_ref)
+		return cb_data.implicit_dst_ref;
 	return NULL;
 }
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 3e5ac81bd2..da6bd74bbc 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -68,6 +68,16 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_branch master
 '
 
+test_expect_success 'checkout of branch from multiple remotes succeeds with checkout.implicitRemote #1' '
+	git checkout -B master &&
+	test_might_fail git branch -D foo &&
+
+	git -c checkout.implicitRemote=repo_a checkout foo &&
+	test_branch foo &&
+	test_cmp_rev remotes/repo_a/foo HEAD &&
+	test_branch_upstream foo repo_a foo
+'
+
 test_expect_success 'checkout of branch from a single remote succeeds #1' '
 	git checkout -B master &&
 	test_might_fail git branch -D bar &&
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2240498924..271a6413f0 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -402,6 +402,24 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success '"add" <path> <branch> dwims with checkout.implicitRemote' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		git remote add repo_upstream2 ../repo_upstream &&
+		git fetch repo_upstream2 &&
+		test_must_fail git worktree add ../foo foo &&
+		git -c checkout.implicitRemote=repo_upstream worktree add ../foo foo
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

