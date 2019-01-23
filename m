Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537E11F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfAWOkU (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43378 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfAWOkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so1862730eds.10
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pgp8E1BaMlU1zdLpdXCMie6m/c9J3XLHle9qf0mBpU4=;
        b=XpwuMREA6yXoq6xGszCgUgV040M6EaLQ67mbe0/AP0xAWbJUSaJcZpOLJxxZWJYvpg
         qSBQUCxg74uBR0pshRG21N5RbWR/BB1PeINp4cPv03RrR7Dn5ayUdJUfmJP23ZxdsG3r
         FcLuRaOov55+MVD3Ek5ZNCqtRHaPCLTMtQRHqSYiqIhS+pSBxBZRC0SRB6NHBFhJk+MB
         D5FF7O1j+7H5ZHKvKMsmFwYjHu6ZsWCbAZQIPskJL0oyZA3lfY6KgGu2itkEuHVm/VRP
         XEA35uK5G2qWgjT6umEFQiZMPpD259iKNwwLTQcT07pM4+RSzfsJTWRV72FpzEwgFD6f
         jJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pgp8E1BaMlU1zdLpdXCMie6m/c9J3XLHle9qf0mBpU4=;
        b=cPrduHjC8t2sUXUbnGmkqAAMMAgTcEu6GUgUzv2s3AQH3UPbpNwdxu2wB5HMlR8KQG
         X4wahq4tA57M2p9YDeM545MSJCvxuX0MaQFwLh3HvLYiJILjF3lxDGm3nfZ3eTj2Sw+u
         MIjxX0buYlBGiDp+QCapuop0xVB4X1aYqKa5fE1X/A/+yNiRGZ7jjXBRaoT7lAzYCUsv
         DuimEgrERUb8xxLEHiMkwBEHyhUFkdOL/iYt7Ax/LIU4dDnUMO2kFuh8hhm+91oWeEH5
         bnS8+PhYMKGmT4r7iG3edXfJJCChVp3+aislxbTConPV6Kp5IZDNx02XBxzqiEdj3LsQ
         LuKw==
X-Gm-Message-State: AJcUukdfVm7n2epMsM6/X8cfGjuBzyoifRXJInXAKHEvrJ99LJbWNNUz
        CwTMu8kOVU8qXnz+rzZjvazcH3ZF
X-Google-Smtp-Source: ALg8bN4QykDD8/80Uq5s4O9UN1DDjhLX6ESf4oQbKKcLI6OF/8b2Cnlgpn3cWZDeNoqU5iGP5oBlqA==
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr2898303eds.265.1548254416669;
        Wed, 23 Jan 2019 06:40:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gy12-v6sm5800653ejb.44.2019.01.23.06.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:16 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:16 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:39:54 GMT
Message-Id: <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The upcoming patches will allow building git.git via Azure Pipelines
(i.e. Azure DevOps' Continuous Integration), where variable names and
URLs look a bit different than in Travis CI.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.sh |  3 ++-
 ci/lib.sh                  | 41 ++++++++++++++++++++++++++------------
 ci/print-test-failures.sh  |  2 +-
 ci/test-documentation.sh   |  1 +
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index fe65144152..bcdcc71592 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,7 +37,8 @@ osx-clang|osx-gcc)
 	brew update --quiet
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	brew install git-lfs gettext
+	test -z "$BREW_INSTALL_PACKAGES" ||
+	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	brew install caskroom/cask/perforce
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index c26bb6a274..4456dbbcb0 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,8 +1,26 @@
 # Library of functions shared by all CI scripts
 
-# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
-# want here. We want the source branch instead.
-CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+if test true = "$TRAVIS"
+then
+	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
+	# what we want here. We want the source branch instead.
+	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+	CI_COMMIT="$TRAVIS_COMMIT"
+	CI_JOB_ID="$TRAVIS_JOB_ID"
+	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
+	CI_OS_NAME="$TRAVIS_OS_NAME"
+	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
+
+	cache_dir="$HOME/travis-cache"
+
+	url_for_job_id () {
+		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
+	}
+
+	BREW_INSTALL_PACKAGES="git-lfs gettext"
+	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
+	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+fi
 
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
@@ -28,7 +46,7 @@ skip_branch_tip_with_tag () {
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
-	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
+	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
 	mv "$good_trees_file".tmp "$good_trees_file"
@@ -38,7 +56,7 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
-	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
+	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
 		# Continue the build job.
@@ -48,18 +66,18 @@ skip_good_tree () {
 	echo "$good_tree_info" | {
 		read tree prev_good_commit prev_good_job_number prev_good_job_id
 
-		if test "$TRAVIS_JOB_ID" = "$prev_good_job_id"
+		if test "$CI_JOB_ID" = "$prev_good_job_id"
 		then
 			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
+			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
 			This commit has already been built and tested successfully by this build job.
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		else
 			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
+			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
 			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
-			The log of that build job is available at https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
+			The log of that build job is available at $(url_for_job_id $prev_good_job_id)
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		fi
@@ -84,7 +102,6 @@ check_unignored_build_artifacts ()
 # and installing dependencies.
 set -ex
 
-cache_dir="$HOME/travis-cache"
 good_trees_file="$cache_dir/good-trees"
 
 mkdir -p "$cache_dir"
@@ -94,13 +111,11 @@ skip_good_tree
 
 if test -z "$jobname"
 then
-	jobname="$TRAVIS_OS_NAME-$CC"
+	jobname="$CI_OS_NAME-$CC"
 fi
 
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
-export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-export GIT_TEST_OPTS="--verbose-log -x --immediate"
 export GIT_TEST_CLONE_2GB=YesPlease
 if [ "$jobname" = linux-gcc ]; then
 	export CC=gcc-8
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 7aef39a2fd..d2045b63a6 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -69,7 +69,7 @@ do
 	fi
 done
 
-if [ $combined_trash_size -gt 0 ]
+if [ -n "$TRAVIS_JOB_ID" -a $combined_trash_size -gt 0 ]
 then
 	echo "------------------------------------------------------------------------"
 	echo "Trash directories embedded in this log can be extracted by running:"
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index d3cdbac73f..7d0beb2832 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -5,6 +5,7 @@
 
 . ${0%/*}/lib.sh
 
+test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 gem install asciidoctor
 
 make check-builtins
-- 
gitgitgadget

