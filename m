Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29122C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ1UPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJ1UPC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C323C16C
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bs21so7977463wrb.4
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QpniONDadL29AE82dKO6yOtA6u25QaY32iuzyD4GJw=;
        b=eZ58ruw2AoDr3Kdf2vRgoM0rKthiIbiOXh6RBTFYv/rI0SqcI3ZboMGiJ5Kcm+WzMs
         g/noeuOU8rQtvtRZeGvi84gNOUTnOhNeYS8YRHxRcmpvXkumDot8Qq/nlhchA4Uu2TOZ
         d7J1IGigDLF7Z4fSXRfLNIfyepiPCNDu+1y/ahZzlpkEG1urjxFmmFbswgmnKm55vmSo
         re7t028yXg7J7OlcpZzw8qCGZogFqO8ScNL4j11GqzNv4s+UK6p2IqQcOFMGci9HjvXd
         Bei9v7dJQk1R1zNQkX1L9k/F8blk1pXq6SHl7iFZsMowMGQ2EapV/vpMO2pIT5KCCwpN
         nRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QpniONDadL29AE82dKO6yOtA6u25QaY32iuzyD4GJw=;
        b=Ejg6ti9t8edAKPZPFRQnhdIgMUFLcYDk9lgC0MgJj4X5O661o5QAjAssZ7MYzodYZE
         Ev2oFeYztbv4DgRt+w0t3A+w5rEnJT5OH+1CNv+aIAmkZjzuru8+xxhj0Rljo3GBWCLy
         yN4EKiBGINh79KMabmSP6KqjBfs09Ff1l2ddeNTvrSdX14DftvFCu1wfiZz7up22JaJn
         Yd+SxF96kjEvH3CkmloBBZIsp3xlUMX6y76nL9pKIdVW3tijdXx9i33HrG8Gm+u/sdID
         4Q4Wtn6sweRgPGbvNiHqumhMa8JVsxbPwNrLTrEujhBzD4em7IQbeA5yEDzKJ3Jqjd9b
         Zejw==
X-Gm-Message-State: ACrzQf23Cmb9+BPBzrS9TzzPtI16dhJvu+tHU782090miSN7lt4Mxrg+
        UO2nVYXj7uuKraHnzkEkKkiLrxtOBFI=
X-Google-Smtp-Source: AMsMyM7BhO7f6X6F2B4NYA7yDw7jxD1QGv5Axx7MPctGA/vs/RK/lyO8vsOuyN1u4Zhe6fPmqasXfg==
X-Received: by 2002:a5d:4301:0:b0:236:9a64:53cd with SMTP id h1-20020a5d4301000000b002369a6453cdmr576486wrq.459.1666988098985;
        Fri, 28 Oct 2022 13:14:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020adfdec6000000b002366ded5864sm4462867wrn.116.2022.10.28.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:14:58 -0700 (PDT)
Message-Id: <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:49 +0000
Subject: [PATCH v3 1/8] clone: teach --detach option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Teach "git clone" the "--detach" option, which leaves the cloned repo in
detached HEAD (like "git checkout --detach"). In addition, if the clone
is not bare, do not create the local branch pointed to by the remote's
HEAD symref (bare clones always copy all remote branches directly to
local branches, so the branch is still created in the bare case).

This is especially useful in the "submodule.propagateBranches" workflow,
where local submodule branches are named after the superproject's
branches, so it makes no sense to create a local branch named after the
submodule's remote's branch.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/git-clone.txt |  8 +++++++-
 builtin/clone.c             | 12 +++++++++---
 t/t5601-clone.sh            | 22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index d6434d262d6..6a4e5d31b46 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
+	  [--filter=<filter> [--also-filter-submodules] [--detach]] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -210,6 +210,12 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the HEAD at that commit
 	in the resulting repository.
 
+--detach::
+	If the cloned repository's HEAD points to a branch, point the newly
+	created HEAD to the branch's commit instead of the branch itself.
+	Additionally, in a non-bare repository, the corresponding local branch
+	will not be created.
+
 -u <upload-pack>::
 --upload-pack <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin/clone.c b/builtin/clone.c
index 547d6464b3c..e624d3f49a2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -78,6 +78,7 @@ static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
+static int option_detach;
 static const char *bundle_uri;
 
 static int recurse_submodules_cb(const struct option *opt,
@@ -162,6 +163,8 @@ static struct option builtin_clone_options[] = {
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
 		    N_("initialize sparse-checkout file to include only files at root")),
+	OPT_BOOL(0, "detach", &option_detach,
+		 N_("detach HEAD and don't create a local branch")),
 	OPT_STRING(0, "bundle-uri", &bundle_uri,
 		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
 	OPT_END()
@@ -613,10 +616,12 @@ static void update_remote_refs(const struct ref *refs,
 }
 
 static void update_head(const struct ref *our, const struct ref *remote,
-			const char *unborn, const char *msg)
+			const char *unborn, int should_detach,
+			const char *msg)
 {
 	const char *head;
-	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
+	if (our && !should_detach &&
+	    skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
@@ -1357,7 +1362,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
-	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
+	update_head(our_head_points_at, remote_head, unborn_head,
+		    option_detach, reflog_msg.buf);
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4d..418cfd54717 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -333,6 +333,28 @@ test_expect_success 'clone checking out a tag' '
 	test_cmp fetch.expected fetch.actual
 '
 
+test_expect_success '--detach detaches and does not create branch' '
+	test_when_finished "rm -fr dst" &&
+	git clone --detach src dst &&
+	(
+		cd dst &&
+		test_must_fail git rev-parse main &&
+		test_must_fail git symbolic-ref HEAD &&
+		test_cmp_rev HEAD refs/remotes/origin/HEAD
+	)
+'
+
+test_expect_success '--detach with --bare detaches but creates branch' '
+	test_when_finished "rm -fr dst" &&
+	git clone --bare --detach src dst &&
+	(
+		cd dst &&
+		git rev-parse main &&
+		test_must_fail git symbolic-ref HEAD &&
+		test_cmp_rev HEAD refs/heads/main
+	)
+'
+
 test_expect_success 'set up ssh wrapper' '
 	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
 		"$TRASH_DIRECTORY/ssh$X" &&
-- 
gitgitgadget

