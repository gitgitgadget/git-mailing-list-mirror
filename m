Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0B9C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D245061037
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbhJGLBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbhJGLBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45741C06176A
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so17895025wrb.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nuo8isn2sktkYIyb4u24OUKLGBSW6my5q9JQrT0km/A=;
        b=D2ArNKSXXT8Bzt625SySurdB9FuOJGlXHF0yjKe/7SVx6kajq8N5fhXAKz3kJXpD1G
         lOiLX2sRephW/EhfTVvJg2ljFAEipnUXouxrECpxniCbGEvt7BZ6usVDWQ9PoAdkuBS0
         hodYytSnj7ceuBTwR+HzqnBJRD6JB58rryubhGKRf9llxFQ+SHH5KjNrlmNycuYoCr7l
         ozGicgmSgESUR4CG39SXcrGBsiCAnNHIe8+WSt2uUpk7L58PFP9sjVZgJt5STwG08iDZ
         VXJf1ziFEmkdXWogKB7lWQV8/LVub7wtXEF+TdH4jDU+GaIax1gYA8mnbSjbrZegSE8L
         zLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nuo8isn2sktkYIyb4u24OUKLGBSW6my5q9JQrT0km/A=;
        b=2K5e1Ca9FHcIB6tyJrHBUXlaHVLQSemGMjU/IsvscyKLPyB7RuRoPpGK81iusbHe5k
         FJQMt/EwwFxKq0cbDepbt28JFRdqWM12D8sABJB0HDAMiNdbbLz2MXDZCTxxQ4YdqXsm
         N1Xq7rqeuBDZ/Al3yGp5WdLIJ4qF4d0Pth21EcCMtJWJt1YD8qtupe2k1B++xm4QR2sp
         6twskabUnHDaxS4vawdZT996znDHyJICmfesGL1gjv8+NbuYTz5ZtsXaX++3oDSBfKqk
         BxHApC9oXw3Kz5qyj/PmxsHNUeqe3osdZzanVoSKw6BHyaWnkpecu7b4LQdWgAchoyXA
         vnAA==
X-Gm-Message-State: AOAM531H0dml4HO2YmGQmrMai4upOY+xU68WUultjJSnc2wPPNbnx2l9
        Bjgc4jcdZizCrLQy/8EoondMibnc58s=
X-Google-Smtp-Source: ABdhPJxbmB/2Nxk9CnYkBPMaJw78RihzTBxDePI1d+LaLAui3jlRZSI52KwyeXt9Bo6Z7CW79rNtgA==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr15650229wmq.5.1633604356853;
        Thu, 07 Oct 2021 03:59:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm14468675wru.6.2021.10.07.03.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:16 -0700 (PDT)
Message-Id: <03b8385ebb5ceae12eaff138606e877216a6f833.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:03 +0000
Subject: [PATCH v5 09/15] scalar: teach 'clone' to support the --single-branch
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like `git clone`, the `scalar clone` command now also offers to
restrict the clone to a single branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          |  9 +++++++--
 contrib/scalar/scalar.txt        | 12 +++++++++++-
 contrib/scalar/t/t9099-scalar.sh |  6 +++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 0401462b9b3..754e19d781d 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -326,12 +326,15 @@ static char *remote_default_branch(const char *url)
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
-	int full_clone = 0;
+	int full_clone = 0, single_branch = 0;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
 		OPT_BOOL(0, "full-clone", &full_clone,
 			 N_("when cloning, create full working directory")),
+		OPT_BOOL(0, "single-branch", &single_branch,
+			 N_("only download metadata for the branch that will "
+			    "be checked out")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
@@ -402,7 +405,9 @@ static int cmd_clone(int argc, const char **argv)
 
 	if (set_config("remote.origin.url=%s", url) ||
 	    set_config("remote.origin.fetch="
-		       "+refs/heads/*:refs/remotes/origin/*") ||
+		       "+refs/heads/%s:refs/remotes/origin/%s",
+		       single_branch ? branch : "*",
+		       single_branch ? branch : "*") ||
 	    set_config("remote.origin.promisor=true") ||
 	    set_config("remote.origin.partialCloneFilter=blob:none")) {
 		res = error(_("could not configure remote in '%s'"), dir);
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index d65fb5f1491..46999cf7c84 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,7 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
-scalar clone [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
+scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
@@ -56,6 +56,16 @@ subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
 	Instead of checking out the branch pointed to by the cloned
 	repository's HEAD, check out the `<name>` branch instead.
 
+--[no-]single-branch::
+	Clone only the history leading to the tip of a single branch, either
+	specified by the `--branch` option or the primary branch remote's
+	`HEAD` points at.
++
+Further fetches into the resulting repository will only update the
+remote-tracking branch for the branch this option was used for the initial
+cloning. If the HEAD at the remote did not point at any branch when
+`--single-branch` clone was made, no remote-tracking branch is created.
+
 --[no-]full-clone::
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 295398f62cc..9a35ab4fde6 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -45,13 +45,17 @@ test_expect_success 'set up repository to clone' '
 
 test_expect_success 'scalar clone' '
 	second=$(git rev-parse --verify second:second.t) &&
-	scalar clone "file://$(pwd)" cloned &&
+	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
 		cd cloned/src &&
 
 		git config --get --global --fixed-value maintenance.repo \
 			"$(pwd)" &&
 
+		git for-each-ref --format="%(refname)" refs/remotes/origin/ >actual &&
+		echo "refs/remotes/origin/parallel" >expect &&
+		test_cmp expect actual &&
+
 		test_path_is_missing 1/2 &&
 		test_must_fail git rev-list --missing=print $second &&
 		git rev-list $second &&
-- 
gitgitgadget

