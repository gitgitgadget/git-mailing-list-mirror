Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC14C46467
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJUPOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJUPN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52110DE41
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a14so2478901wru.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5auV+87HwUM3VcadHiqwkdOm25yzEBwxRsUeNgr4Fc=;
        b=a1ocjvAsAUtDYK7UCTd1PJQUpCJvi+C7BTDfdvrejjVQr1WYR2cJRuN8439f2qx3Tt
         EPciYtlG2RwtLh7BhddNsqj8s/gc/nBXd3KAz6t1Yx7ksOEdghrk49Vm0QM+uDtVP0AG
         UX7ml7M7DZu9yoH20JEXWOB5riYqEcd9Ag7+3MPAnKOG96rJaVPCghklvzRL1CFtDAYg
         Q/4dhQJl8Kl1RUJ8rKakqH9j8/n1BHbqR8AK5Dzotq1mHFET5wSeEgY2hgWbasgdzUXj
         q2Rm0C0X7q8xnkeGPaTiv2P3eUn03I0+OFWHuB9z4PmkUyrUzwTC8PH7POz0Yr3VixDy
         iWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5auV+87HwUM3VcadHiqwkdOm25yzEBwxRsUeNgr4Fc=;
        b=7vRZ1uzywwKF5ZsLjZBPH570xziSVjW43Pb/YyMv9PCRyMHII+JExW1uXCdOLF1t8R
         t362NH3tJi01g3es7FRsRaipSWStm4az9bP6rkWWSEOPkTj2Vp8fhSdS3T090nH5ZMw8
         sSkSAXqbTh1rA4zdQyV1iCy08PUt1nWd15Fw1ycsCOHK5a+BSE0/gDPQ90vJOUOE3SIt
         Xm+yTk5h1PB+Ku4rEIAqGZmcMsIHulaQqRB4K9ES38tepBRsVVHlgUX0juVncoqpdk2E
         1ElOsn021/7f8f/2QlwajFkJEAaHMoahnyvnKFqsvhVeDJQ9lIw3D3TmhRjnyluv/LwM
         Sy9g==
X-Gm-Message-State: ACrzQf0unqDCn0cUu645yHEe1pFKvDWIZ9SMw2SN/1q3uGhKZVA3M3Is
        qeMfTevxK3AzpzDZvpQTAJstd9XDR7k=
X-Google-Smtp-Source: AMsMyM6LFZPZo+PTKw0+GXacYZs2f+9msSyxK6/exjXX5UfISuol/fi+6++5OmwIN9MmIUlZAbLJuQ==
X-Received: by 2002:adf:cd0c:0:b0:22e:3434:e060 with SMTP id w12-20020adfcd0c000000b0022e3434e060mr12945074wrm.388.1666365233444;
        Fri, 21 Oct 2022 08:13:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h42-20020a05600c49aa00b003a5537bb2besm2663255wmp.25.2022.10.21.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:53 -0700 (PDT)
Message-Id: <db97bc1dbe004989d1c0d456167d1a160e85db01.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:38 +0000
Subject: [PATCH 8/9] subtree: fix squash merging after annotated tag was
 squashed merged
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

When 'git subtree merge --squash $ref' is invoked, either directly or
through 'git subtree pull --squash $repo $ref', the code looks for the
latest squash merge of the subtree in order to create the new merge
commit as a child of the previous squash merge.

This search is done in function 'process_subtree_split_trailer', invoked
by 'find_latest_squash', which looks for the most recent commit with a
'git-subtree-split' trailer; that trailer's value is the object name in
the subtree repository of the ref that was last squash-merged. The
function verifies that this object is present locally with 'git
rev-parse', and aborts if it's not.

The hash referenced by the 'git-subtree-split' trailer is guaranteed to
correspond to a commit since it is the result of running 'git rev-parse
-q --verify "$1^{commit}"' on the first argument of 'cmd_merge' (this
corresponds to 'rev' in 'cmd_merge' which is passed through to
'new_squash_commit' and 'squash_msg').

But this is only the case since e4f8baa88a (subtree: parse revs in
individual cmd_ functions, 2021-04-27), which went into Git 2.32. Before
that commit, 'cmd_merge' verified the revision it was given using 'git
rev-parse --revs-only "$@"'. Such an invocation, when fed the name of an
annotated tag, would return the hash of the tag, not of the commit
referenced by the tag.

This leads to a failure in 'find_latest_squash' when squash-merging if
the most recent squash-merge merged an annotated tag of the subtree
repository, using a pre-2.32 version of 'git subtree', unless that
previous annotated tag is present locally (which is not usually the
case).

We can fix this by fetching the object directly by its hash in
'process_subtree_split_trailer' when 'git rev-parse' fails, but in order
to do so we need to know the name or URL of the subtree repository.
This is not possible in general for 'git subtree merge', but is easy
when it is invoked through 'git subtree pull' since in that case the
subtree repository is passed by the user at the command line.

Allow the 'git subtree pull' scenario to work out-of-the-box by adding
an optional 'repository' argument to functions 'cmd_merge',
'find_latest_squash' and 'process_subtree_split_trailer', and invoke
'cmd_merge' with that 'repository' argument in 'cmd_pull'.

If 'repository' is absent in 'process_subtree_split_trailer', instruct
the user to try fetching the missing object directly.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/subtree/git-subtree.sh     | 56 +++++++++++++++++++++++-------
 contrib/subtree/git-subtree.txt    |  9 +++--
 contrib/subtree/t/t7900-subtree.sh | 36 +++++++++++++++++++
 3 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index b90ca0036f7..2c67989fe8a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -371,20 +371,45 @@ try_remove_previous () {
 	fi
 }
 
-# Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH
+# Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
 process_subtree_split_trailer () {
-	assert test $# = 2
+	assert test $# = 2 -o $# = 3
 	b="$1"
 	sq="$2"
-	sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
-	die "fatal: could not rev-parse split hash $b from commit $sq"
+	repository=""
+	if test "$#" = 3
+	then
+		repository="$3"
+	fi
+	fail_msg="fatal: could not rev-parse split hash $b from commit $sq"
+	if ! sub="$(git rev-parse --verify --quiet "$b^{commit}")"
+	then
+		# if 'repository' was given, try to fetch the 'git-subtree-split' hash
+		# before 'rev-parse'-ing it again, as it might be a tag that we do not have locally
+		if test -n "${repository}"
+		then
+			git fetch "$repository" "$b"
+			sub="$(git rev-parse --verify --quiet "$b^{commit}")" ||
+				die "$fail_msg"
+		else
+			hint1=$(printf "hint: hash might be a tag, try fetching it from the subtree repository:")
+			hint2=$(printf "hint:    git fetch <subtree-repository> $b")
+			fail_msg=$(printf "$fail_msg\n$hint1\n$hint2")
+			die "$fail_msg"
+		fi
+	fi
 }
 
-# Usage: find_latest_squash DIR
+# Usage: find_latest_squash DIR [REPOSITORY]
 find_latest_squash () {
-	assert test $# = 1
+	assert test $# = 1 -o $# = 2
 	dir="$1"
-	debug "Looking for latest squash ($dir)..."
+	repository=""
+	if test "$#" = 2
+	then
+		repository="$2"
+	fi
+	debug "Looking for latest squash (dir=$dir, repository=$repository)..."
 	local indent=$(($indent + 1))
 
 	sq=
@@ -404,7 +429,7 @@ find_latest_squash () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			process_subtree_split_trailer "$b" "$sq"
+			process_subtree_split_trailer "$b" "$sq" "$repository"
 			;;
 		END)
 			if test -n "$sub"
@@ -969,17 +994,22 @@ cmd_split () {
 	exit 0
 }
 
-# Usage: cmd_merge REV
+# Usage: cmd_merge REV [REPOSITORY]
 cmd_merge () {
-	test $# -eq 1 ||
-		die "fatal: you must provide exactly one revision.  Got: '$*'"
+	test $# -eq 1 -o $# -eq 2 ||
+		die "fatal: you must provide exactly one revision, and optionally a repository. Got: '$*'"
 	rev=$(git rev-parse -q --verify "$1^{commit}") ||
 		die "fatal: '$1' does not refer to a commit"
+	repository=""
+	if test "$#" = 2
+	then
+		repository="$2"
+	fi
 	ensure_clean
 
 	if test -n "$arg_addmerge_squash"
 	then
-		first_split="$(find_latest_squash "$dir")" || exit $?
+		first_split="$(find_latest_squash "$dir" "$repository")" || exit $?
 		if test -z "$first_split"
 		then
 			die "fatal: can't squash-merge: '$dir' was never added."
@@ -1017,7 +1047,7 @@ cmd_pull () {
 	ensure_clean
 	ensure_valid_ref_format "$ref"
 	git fetch "$repository" "$ref" || exit $?
-	cmd_merge FETCH_HEAD
+	cmd_merge FETCH_HEAD "$repository"
 }
 
 # Usage: cmd_push REPOSITORY [+][LOCALREV:]REMOTEREF
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 9cddfa26540..0e7524d7864 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git subtree' [<options>] -P <prefix> add <local-commit>
 'git subtree' [<options>] -P <prefix> add <repository> <remote-ref>
-'git subtree' [<options>] -P <prefix> merge <local-commit>
+'git subtree' [<options>] -P <prefix> merge <local-commit> [<repository>]
 'git subtree' [<options>] -P <prefix> split [<local-commit>]
 
 [verse]
@@ -76,7 +76,7 @@ add <repository> <remote-ref>::
 	only a single commit from the subproject, rather than its
 	entire history.
 
-merge <local-commit>::
+merge <local-commit> [<repository>]::
 	Merge recent changes up to <local-commit> into the <prefix>
 	subtree.  As with normal 'git merge', this doesn't
 	remove your own local changes; it just merges those
@@ -88,6 +88,11 @@ If you use '--squash', the merge direction doesn't always have to be
 forward; you can use this command to go back in time from v2.5 to v2.4,
 for example.  If your merge introduces a conflict, you can resolve it in
 the usual ways.
++
+When using '--squash', and the previous merge with '--squash' merged an
+annotated tag of the subtree repository, that tag needs to be available locally.
+If <repository> is given, a missing tag will automatically be fetched from that
+repository.
 
 split [<local-commit>]::
 	Extract a new, synthetic project history from the
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 249743ab9aa..d0671676c7a 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -43,6 +43,30 @@ last_commit_subject () {
 	git log --pretty=format:%s -1
 }
 
+# Upon 'git subtree add|merge --squash' of an annotated tag,
+# pre-2.32.0 versions of 'git subtree' would write the hash of the tag
+# (sub1 below), instead of the commit (sub1^{commit}) in the
+# "git-subtree-split" trailer.
+# We immitate this behaviour below using a replace ref.
+# This function creates 3 repositories:
+# - $1
+# - $1-sub (added as subtree "sub" in $1)
+# - $1-clone (clone of $1)
+test_create_pre2_32_repo () {
+	subtree_test_create_repo "$1" &&
+	subtree_test_create_repo "$1-sub" &&
+	test_commit -C "$1" main1 &&
+	test_commit -C "$1-sub" --annotate sub1 &&
+	git -C "$1" subtree add --prefix="sub" --squash "../$1-sub" sub1 &&
+	tag=$(git -C "$1" rev-parse FETCH_HEAD) &&
+	commit=$(git -C "$1" rev-parse FETCH_HEAD^{commit}) &&
+	git -C "$1" log -1 --format=%B HEAD^2 >msg &&
+	test_commit -C "$1-sub" --annotate sub2 &&
+	git clone --no-local "$1" "$1-clone" &&
+	new_commit=$(cat msg | sed -e "s/$commit/$tag/" | git -C "$1-clone" commit-tree HEAD^2^{tree}) &&
+	git -C "$1-clone" replace HEAD^2 $new_commit
+}
+
 test_expect_success 'shows short help text for -h' '
 	test_expect_code 129 git subtree -h >out 2>err &&
 	test_must_be_empty err &&
@@ -264,6 +288,13 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
 	)
 '
 
+test_expect_success 'merge with --squash after annotated tag was added/merged with --squash pre-v2.32.0 ' '
+	test_create_pre2_32_repo "$test_count" &&
+	git -C "$test_count-clone" fetch "../$test_count-sub" sub2  &&
+	test_must_fail git -C "$test_count-clone" subtree merge --prefix="sub" --squash FETCH_HEAD &&
+	git -C "$test_count-clone" subtree merge --prefix="sub" --squash FETCH_HEAD  "../$test_count-sub"
+'
+
 #
 # Tests for 'git subtree split'
 #
@@ -630,6 +661,11 @@ test_expect_success 'pull rejects flags for split' '
 	)
 '
 
+test_expect_success 'pull with --squash after annotated tag was added/merged with --squash pre-v2.32.0 ' '
+	test_create_pre2_32_repo "$test_count" &&
+	git -C "$test_count-clone" subtree -d pull --prefix="sub" --squash "../$test_count-sub" sub2
+'
+
 #
 # Tests for 'git subtree push'
 #
-- 
gitgitgadget

